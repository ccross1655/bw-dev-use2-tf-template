# Azure landing-zone Terraform template

This repository is a Terraform starter aligned to the Azure standards document in [policies-standards/Terraform_Standardization_Azure.docx](policies-standards/Terraform_Standardization_Azure.docx), and to the management-group and subscription pattern shown in the reference architecture.

## Objective

The template establishes a governance-first Azure landing zone with:

- a tenant root management group
- a platform hierarchy
- landing-zone separation for non-prod and prod
- Azure Policy baseline controls
- environment-specific Terraform roots
- consistent naming and tagging standards
- remote state storage using Azure Storage with OIDC-based auth

## Architecture modeled

The repo follows this structure:

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

## Standards applied

This template follows the Azure Terraform standards document and includes:

- naming convention: `bw-<env>-<reg>-<proj>-<resource>`
- lowercase, hyphen-separated names with environment and region tokens
- required Azure tags for environment, region, project, owner, cost center, and Terraform management
- remote state in Azure Storage with blob leases and OIDC authentication
- separate Terraform roots for environment-specific deployment
- policy baseline for allowed locations and required tags

## Repository layout

```text
.
├── README.md
├── .gitignore
├── modules/
│   ├── naming/
│   ├── landing_zone/
│   ├── management_groups/
│   ├── policy_baseline/
│   └── subscription_assignments/
├── environments/
│   ├── bootstrap/
│   ├── shared/
│   ├── dev/
│   ├── test/
│   └── prod/
├── policies-standards/
│   └── Terraform_Standardization_Azure.docx
└── Azure-Terraform-Landing-Zone-Template.docx
```

## Current status

This is a working technical scaffold that validates with Terraform:

- `terraform fmt -recursive; terraform validate`
- Result: `Success! The configuration is valid.`

## Production gaps to fill before deployment

The following values are intentionally left as placeholders and should be replaced with real tenant values before deployment:

- Azure subscription IDs
- Azure management group IDs where applicable
- exact policy definition IDs for your tenant
- real cost center values
- real owner/team names and email addresses
- project naming values and product metadata
- actual backend storage account names and container names
- real region configuration for DR or single-region rollout

## Recommended next steps

1. Replace example subscription IDs in the bootstrap configuration.
2. Confirm Azure Policy definition IDs for allowed locations and required tags.
3. Assign real values to owner, project, and cost center.
4. Confirm whether the rollout is single-region or dual-region.
5. Add actual Azure RBAC assignments for platform and environment teams.
6. Review naming against the Azure Naming Convention document before signing off.

## Notes

This workspace is intentionally structured for governance and standardization review. It is not yet a tenant-specific deployment artifact because Azure subscription and policy identifiers vary by environment.
