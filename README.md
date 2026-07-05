# Databricks & dbt Core Data Engineering Pipeline

This repository hosts a production-grade analytics engineering pipeline built using **dbt Core** and **Databricks**. It transforms raw ingestion assets in the Databricks Lakehouse into highly optimized dimensional models using the multi-tier **Medallion Architecture**.

---

## 🏗️ Pipeline Architecture

Our framework partitions data through three logical progressive layers to enforce data quality, schema validation, and complete downstream lineage.

### Data Processing Flow Diagram

### Layer Breakdown
1. **Bronze (Staging Layer):** Directly maps to raw Databricks objects via `src_databricks.yml`. These models implement uniform naming conventions, basic casting, and timestamp tracking without applying business logic constraints.
2. **Silver (Intermediate Layer):** Performs data cleansing, handles deduplication, filters bad records, and structurally normalizes entity joins (e.g., combining sales streams with master consumer directories).
3. **Gold (Mart Layer):** Summarizes and denormalizes transactions into analytical star schemas ready to drive business operations and reporting tools.

---

## 📊 Modern Data Stack Transformation Loop

Below is the universal structural diagram highlighting how dbt orchestrates your data processing cycle within target database catalogs:

<img width="1408" height="768" alt="image_3c6d2511" src="https://github.com/user-attachments/assets/e7fbc2f6-864b-45d5-b4d4-7ae5203684c8" />

---

## 📁 Repository Directory Structure

The repository organizes dbt configurations, source mappings, and multi-layered processing queries:

```text
├── dbt_project.yml             # Global project settings and configurations
├── macros/
│   └── generate_schema_name.sql # Custom macro overriding default schema target naming
├── models/
│   ├── source/
│   │   └── src_databricks.yml  # YAML defining schemas, tables, and raw data tests
│   ├── bronze/                 # Lightweight staging views (stg_sales, stg_customer, etc.)
│   ├── silver/                 # Cleaned relational intermediate steps (int_sales)
│   └── gold/                   # High-value business presentation marts (fct_monthly_sales)
├── seeds/                      # Static reference CSV documents (e.g., country lookups)
└── snapshots/                  # Historical slowly changing dimension (SCD Type 2) tasks
```

---

## 🚀 Local Development Environment Setup

### 1. System Requirements
Install Python along with the required execution binaries and database adapter engines:
```bash
pip install dbt-core dbt-databricks
```

### 2. Secrets Management & Connection Profiles
To guarantee security, database target passwords **must never** be written inside your repository workspace. Move or save your profile credentials file directly to your local user directory at `~/.dbt/profiles.yml`.

Inject environment variables dynamically into your profile to prevent token leaks:
```yaml
shubh_dbt_practice:
  outputs:
    dev:
      type: databricks
      method: http
      catalog: dbt_practice_dev
      schema: bronze
      host: "{{ env_var('DBT_DATABRICKS_HOST') }}"
      http_path: "{{ env_var('DBT_DATABRICKS_HTTP_PATH') }}"
      token: "{{ env_var('DBT_DATABRICKS_TOKEN') }}"
  target: dev
```

### 3. Pipeline Commands
Execute your data transformations using the dbt Core command-line terminal:
```bash
# Verify active connectivity to your Databricks cluster
dbt debug

# Seed static data and build changing dimension history records
dbt seed
dbt snapshot

# Execute the complete Medallion transformation pipeline
dbt run

# Run schema constraints and data assertions to validate your results
dbt test
```

git add README.md
git commit -m "docs: implement descriptive medallion architecture README"
git push origin feature_shubham

