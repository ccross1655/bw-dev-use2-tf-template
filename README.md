# Azure landing-zone Terraform template

This repository is a production-ready Terraform scaffold aligned to the Azure standards document in [policies-standards/Terraform_Standardization_Azure.docx](policies-standards/Terraform_Standardization_Azure.docx) and to the management-group and subscription model in the reference architecture.

## Objective

This template provides an operationally sound Azure foundation for multi-environment deployments. It is designed to support:

- tenant root management group governance
- platform and landing-zone segregation
- non-production and production isolation
- Azure Policy enforcement for allowed regions and required tags
- environment-specific state and deployment roots
- shared governance and naming patterns across teams
- dual-region hub-and-spoke networking with East US primary and Central US DR
- centralized tenant configuration loaded from `config/tenant.yaml`

## Architecture modeled

The repo reflects the management-group pattern shown in the design:

- Tenant root: `mg-bw`
  - `mg-bw-platform`
    - `mg-bw-platform-ops`
  - `mg-bw-landingzones`
    - `mg-bw-lz-nonprod`
    - `mg-bw-lz-prod`
  - `mg-bw-sandbox`

Subscription alignment modeled in the template:

- Shared / Operations -> `mg-bw-platform-ops`
- Dev -> `mg-bw-lz-nonprod`
- Test -> `mg-bw-lz-nonprod`
- Prod -> `mg-bw-lz-prod`

## Network CIDR plan

The networking module uses the approved address plan from the architecture:

| Environment | Primary East US | DR Central US |
| --- | --- | --- |
| Product spoke - prod | `10.180.100.0/24` | `10.190.100.0/24` |
| Product spoke - test | `10.180.200.0/24` | `10.190.200.0/24` |
| Product spoke - dev | `10.180.250.0/24` | `10.190.250.0/24` |
| Shared / Operations hub | `10.180.240.0/22` | `10.190.240.0/22` |

Each VNet receives five `/27` subnets: private availability zone 1 and 2, public availability zone 1 and 2, and private endpoints. The reserved `/19` blocks from the design are intentionally not provisioned by Terraform and remain available for future expansion.

## Standards followed

This repository follows the Terraform standardization guidance for Azure:

- naming convention: `bw-<env>-<reg>-<proj>-<resource>`
- lowercase, hyphen-separated names with environment and region tokens
- required Azure tags for environment, region, project, owner, cost center, and Terraform management
- remote state in Azure Storage with OIDC authentication and blob lease locking
- environment isolation for shared, dev, test, and prod
- Azure Policy baseline for allowed regions and tag enforcement

## Repository structure

```text
.
├── README.md
├── config/
│   ├── tenant.yaml.example
│   └── tenant.yaml                 # local only; not committed
├── .gitignore
├── Azure-Terraform-Landing-Zone-Template.docx
├── modules/
│   ├── naming/
│   ├── landing_zone/
│   ├── management_groups/
│   ├── policy_baseline/
│   ├── subscription_assignments/
│   ├── identity/
│   └── network/
├── environments/
│   ├── bootstrap/
│   ├── shared/
│   ├── dev/
│   ├── test/
│   └── prod/
├── policies-standards/
│   └── Terraform_Standardization_Azure.docx
└── .gitignore
```

## Production readiness notes

This scaffold is production-oriented but still requires tenant-specific values before real deployment. The following items remain placeholders:

- Azure subscription IDs
- Azure management group IDs
- exact Azure Policy definition IDs for your tenant
- real cost center values
- real owner/team names and emails
- actual project codes and product metadata
- actual storage account names and state keys
- final region strategy for single-region vs dual-region deployment

## Central configuration

Copy `config/tenant.yaml.example` to `config/tenant.yaml` and update that one file with your tenant-specific subscription IDs, management-group names, policy definition IDs, tags, regions, and CIDR blocks. The Terraform environment roots load this file with `yamldecode()`.

```powershell
Copy-Item config/tenant.yaml.example config/tenant.yaml
```

The real `config/tenant.yaml` is ignored by Git. Do not put secrets in it. Backend storage settings remain in each `backend.tf` because Terraform initializes the backend before it evaluates normal configuration; update those values separately before `terraform init`.

## Deployment workflow

1. Copy and update `config/tenant.yaml`.
2. Confirm environment-specific state storage names in each `backend.tf`.
3. Apply bootstrap module to create management groups and policy baseline.
4. Apply the shared network and environment network roots.
5. Apply environment roots to create landing-zone resources and workloads.
6. Validate with `terraform validate` and review plans in CI before production apply.

## Verification

The current repo validates successfully with Terraform:

- command: `terraform fmt -recursive; terraform validate`
- result: `Success! The configuration is valid.`

## Notes

This is a robust starting point for a real Azure landing-zone implementation. It is still a template and should be completed with tenant-specific naming, identity, RBAC, and policy metadata before a live Azure deployment.
