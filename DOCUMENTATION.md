# 📚 Healthcare Claims Management System - Complete Documentation

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [High-Level Architecture (HLA)](#2-high-level-architecture-hla)
3. [Technical Architecture](#3-technical-architecture)
4. [Complete Project Structure](#4-complete-project-structure)
5. [Module Documentation](#5-module-documentation)
6. [Function Reference](#6-function-reference)
7. [Data Flow](#7-data-flow)
8. [API Reference](#8-api-reference)
9. [Deployment Architecture](#9-deployment-architecture)
10. [Viva Questions & Answers](#10-viva-questions--answers)

---

# 1. Project Overview

## 1.1 Purpose

The Healthcare Claims Management System is a comprehensive web application designed to streamline the process of managing healthcare insurance claims. It provides separate portals for administrators and patients, enabling efficient claim submission, review, and document management.

## 1.2 Key Objectives

- **Digitize Claims Process**: Replace paper-based claim submissions with digital workflows
- **Secure Patient Data**: Implement role-based access control for sensitive healthcare data
- **Real-time Analytics**: Provide insights into claim processing metrics
- **Document Management**: Enable secure upload and storage of supporting documents
- **Scalable Architecture**: Design for cloud-native deployment on AWS

## 1.3 Technology Stack

| Layer | Technology |
|-------|------------|
| Frontend | Streamlit (Python) |
| Backend API | FastAPI (Python) |
| Database | AWS DynamoDB |
| File Storage | AWS S3 |
| Authentication | AWS Lambda |
| Container | Docker |
| Orchestration | Kubernetes (EKS) |
| IaC | Terraform |
| CI/CD | GitHub Actions |

---

# 2. High-Level Architecture (HLA)

## 2.1 System Context Diagram

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           HEALTHCARE CLAIMS SYSTEM                           │
│                                                                              │
│  ┌──────────────┐         ┌──────────────────────────────────────────────┐  │
│  │              │         │           APPLICATION LAYER                   │  │
│  │    ADMIN     │◄───────►│  ┌────────────┐  ┌────────────┐              │  │
│  │    USER      │         │  │  Streamlit │  │  FastAPI   │              │  │
│  │              │         │  │  Frontend  │  │  Backend   │              │  │
│  └──────────────┘         │  └────────────┘  └────────────┘              │  │
│                           └───────────────────────┬──────────────────────┘  │
│  ┌──────────────┐                                 │                         │
│  │              │         ┌───────────────────────▼──────────────────────┐  │
│  │   PATIENT    │◄───────►│            AWS SERVICES LAYER                │  │
│  │    USER      │         │  ┌─────────┐ ┌─────────┐ ┌─────────┐        │  │
│  │              │         │  │DynamoDB │ │   S3    │ │ Lambda  │        │  │
│  └──────────────┘         │  │ Tables  │ │ Bucket  │ │  Auth   │        │  │
│                           │  └─────────┘ └─────────┘ └─────────┘        │  │
│                           └──────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 2.2 Component Interaction

```
                    ┌─────────────────────────────────────┐
                    │           LOAD BALANCER             │
                    │         (Port 80/8800/8000)         │
                    └───────────────┬─────────────────────┘
                                    │
            ┌───────────────────────┼───────────────────────┐
            │                       │                       │
            ▼                       ▼                       ▼
    ┌───────────────┐      ┌───────────────┐      ┌───────────────┐
    │   STREAMLIT   │      │    FASTAPI    │      │     AUTH      │
    │   FRONTEND    │      │    BACKEND    │      │   SERVICE     │
    │   Port 8501   │      │   Port 8800   │      │   Port 8000   │
    │               │      │               │      │               │
    │ • Home.py     │      │ • app.py      │      │ • Lambda      │
    │ • Admin.py    │      │ • /add-patient│      │ • /login      │
    │ • User.py     │      │ • /submit-    │      │               │
    │               │      │   claim       │      │               │
    └───────┬───────┘      └───────┬───────┘      └───────┬───────┘
            │                      │                      │
            └──────────────────────┼──────────────────────┘
                                   │
                                   ▼
                    ┌──────────────────────────┐
                    │      AWS SERVICES        │
                    ├──────────────────────────┤
                    │  ┌────────────────────┐  │
                    │  │  DynamoDB Tables   │  │
                    │  │  • Patient Table   │  │
                    │  │  • Claims Table    │  │
                    │  └────────────────────┘  │
                    │  ┌────────────────────┐  │
                    │  │    S3 Bucket       │  │
                    │  │  • Documents       │  │
                    │  │  • Images          │  │
                    │  └────────────────────┘  │
                    └──────────────────────────┘
```

---

# 3. Technical Architecture

## 3.1 Layered Architecture

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           PRESENTATION LAYER                                 │
│  ┌─────────────────────────────────────────────────────────────────────────┐│
│  │  Streamlit Pages (Home.py, Admin.py, User.py)                           ││
│  │  • UI Components  • Session Management  • Form Handling                 ││
│  └─────────────────────────────────────────────────────────────────────────┘│
├─────────────────────────────────────────────────────────────────────────────┤
│                            BUSINESS LAYER                                    │
│  ┌─────────────────────────────────────────────────────────────────────────┐│
│  │  FastAPI Services (app.py, authenticate.py)                             ││
│  │  • API Endpoints  • Request Validation  • Business Logic                ││
│  └─────────────────────────────────────────────────────────────────────────┘│
├─────────────────────────────────────────────────────────────────────────────┤
│                             DATA ACCESS LAYER                                │
│  ┌─────────────────────────────────────────────────────────────────────────┐│
│  │  Utility Classes (DynamoDBUtils, S3Utils)                               ││
│  │  • CRUD Operations  • Connection Pooling  • Error Handling              ││
│  └─────────────────────────────────────────────────────────────────────────┘│
├─────────────────────────────────────────────────────────────────────────────┤
│                            INFRASTRUCTURE LAYER                              │
│  ┌─────────────────────────────────────────────────────────────────────────┐│
│  │  AWS Services (DynamoDB, S3, Lambda)                                    ││
│  │  • Data Persistence  • File Storage  • Serverless Compute               ││
│  └─────────────────────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────────────────────┘
```

## 3.2 Design Patterns Used

| Pattern | Implementation | Purpose |
|---------|----------------|---------|
| **Singleton** | Config, Logger, DynamoDBUtils, S3Utils | Single instance, resource reuse |
| **Factory** | get_logger(), get_instance() | Object creation abstraction |
| **MVC** | Streamlit (View), FastAPI (Controller), Utils (Model) | Separation of concerns |
| **Repository** | DynamoDBUtils class | Data access abstraction |
| **Facade** | Backward compatibility functions | Simplified interface |

---

# 4. Complete Project Structure

```
cloud-capstone-team-1/
│
├── 📄 Home.py                      # Landing page - entry point
├── 📄 app.py                       # FastAPI backend service
├── 📄 logger.py                    # Centralized Logger class
├── 📄 Dockerfile                   # Container configuration
├── 📄 entrypoint.sh                # Container startup script
├── 📄 requirements.txt             # Python dependencies
├── 📄 README.md                    # Project overview
├── 📄 DOCUMENTATION.md             # This file
├── 📄 .gitignore                   # Git ignore rules
├── 📄 .dockerignore                # Docker ignore rules
│
├── 📁 pages/                       # Streamlit multi-page app
│   ├── __init__.py
│   ├── Admin.py                    # Admin dashboard (678 lines)
│   └── User.py                     # User portal (489 lines)
│
├── 📁 auth/                        # Authentication module
│   ├── __init__.py
│   ├── authenticate.py             # FastAPI auth service
│   ├── user_authentication.py      # User auth functions
│   └── logger.py                   # Auth-specific logger
│
├── 📁 config/                      # Configuration management
│   ├── __init__.py
│   └── config.py                   # Config singleton class
│
├── 📁 utils/                       # Utility classes
│   ├── __init__.py
│   ├── dynamodb_utils.py           # DynamoDB operations
│   └── s3_utils.py                 # S3 operations
│
├── 📁 schema/                      # Data models
│   ├── __init__.py
│   └── models.py                   # Pydantic models
│
├── 📁 templates/                   # UI templates
│   ├── __init__.py
│   └── styles.py                   # CSS styles
│
├── 📁 assets/                      # Static files
│   ├── logo.png                    # Application logo
│   └── background.png              # Background image
│
├── 📁 k8s/                         # Kubernetes manifests
│   └── deploy.yaml                 # Deployment & Service
│
├── 📁 terraform/                   # Infrastructure as Code
│   ├── main.tf                     # Main resources
│   ├── variables.tf                # Variables
│   ├── outputs.tf                  # Outputs
│   ├── provider.tf                 # Provider config
│   ├── version.tf                  # Version constraints
│   ├── parameters.tf               # SSM parameters
│   └── terraform.tfvars.example    # Example variables
│
├── 📁 .github/workflows/           # CI/CD pipelines
│   ├── ci.yaml                     # Continuous Integration
│   ├── cd.yaml                     # Continuous Deployment
│   └── terraform.yaml              # Infrastructure pipeline
│
└── 📁 logs/                        # Application logs
    ├── app.log
    ├── backend.log
    └── authenticate.log
```

## 4.1 File Purpose Matrix

| File/Folder | Purpose | Dependencies |
|-------------|---------|--------------|
| **Home.py** | Landing page with navigation to Admin/User portals | templates/styles.py |
| **app.py** | FastAPI backend for claims/patient APIs | utils/, config/, schema/ |
| **logger.py** | Centralized logging with file & console output | None (core) |
| **pages/Admin.py** | Admin dashboard with full CRUD operations | utils/, config/, templates/ |
| **pages/User.py** | Patient portal with self-service features | auth/, utils/, templates/ |
| **auth/authenticate.py** | Lambda-based admin authentication | AWS Lambda |
| **auth/user_authentication.py** | Patient authentication via DOB | DynamoDB |
| **config/config.py** | Environment variable management | python-dotenv |
| **utils/dynamodb_utils.py** | All DynamoDB operations | boto3, config/ |
| **utils/s3_utils.py** | All S3 operations | boto3, config/ |
| **schema/models.py** | Pydantic validation models | pydantic |
| **templates/styles.py** | Centralized CSS styling | None |

---

# 5. Module Documentation

## 5.1 Config Module (`config/config.py`)

### Purpose
Centralized configuration management using the Singleton pattern. Loads environment variables once and provides them across the application.

### Class: `Config`

```python
class Config:
    """
    Singleton configuration class.
    Loads all environment variables on first instantiation.
    """
```

### Attributes

| Attribute | Type | Default | Description |
|-----------|------|---------|-------------|
| `AWS_REGION` | str | eu-west-2 | AWS region |
| `PATIENT_TABLE` | str | intl-euro-training-patient | Patient DynamoDB table |
| `CLAIMS_TABLE` | str | intl-euro-training-claims | Claims DynamoDB table |
| `S3_BUCKET_NAME` | str | intl-euro-capstone-team-dev | S3 bucket name |
| `AUTH_API_URL` | str | http://localhost:8000 | Auth service URL |
| `PATIENT_API_URL` | str | http://localhost:8800 | Backend API URL |

### Methods

| Method | Parameters | Returns | Description |
|--------|------------|---------|-------------|
| `get_instance()` | None | Config | Get singleton instance |
| `get_missing_vars()` | None | List[str] | Check for missing env vars |

---

## 5.2 Logger Module (`logger.py`)

### Purpose
Provides consistent logging across all modules with both file and console output.

### Class: `Logger`

```python
class Logger:
    """
    Singleton Logger with caching.
    Supports multiple log files per module.
    """
```

### Configuration

| Setting | Value |
|---------|-------|
| Format | `%(asctime)s \| %(levelname)s \| %(name)s \| %(message)s` |
| Default Level | INFO |
| Default File | app.log |

### Functions

| Function | Parameters | Returns | Description |
|----------|------------|---------|-------------|
| `get_logger(name, log_file)` | name: str, log_file: Optional[str] | logging.Logger | Get configured logger |
| `log(file_name)` | file_name: str | None | Legacy compatibility function |

---

## 5.3 DynamoDB Utils (`utils/dynamodb_utils.py`)

### Purpose
Encapsulates all DynamoDB operations with error handling and logging.

### Class: `DynamoDBUtils`

```python
class DynamoDBUtils:
    """
    Singleton utility class for DynamoDB CRUD operations.
    Manages connections to patient and claims tables.
    """
```

### Methods

| Method | Parameters | Returns | Description |
|--------|------------|---------|-------------|
| `patient_exists(patient_id)` | patient_id: str | bool | Check if patient exists |
| `get_patient_by_id(patient_id, table_name)` | patient_id: str, table_name: Optional[str] | Dict | Get patient record |
| `add_patient(item)` | item: Dict | bool | Add new patient |
| `upload_claims(items)` | items: Union[Dict, List[Dict]] | bool | Upload claim(s) |
| `get_claims_by_patient(patient_id)` | patient_id: str | Optional[Dict] | Get patient's claims |
| `update_claim_status(patient_id, status)` | patient_id: str, status: str | Dict | Update claim status |
| `get_all_items(table_name, table_object)` | table_name: Optional[str], table_object: Optional | pd.DataFrame | Scan entire table |
| `authenticate_user(patient_id, dob)` | patient_id: str, dob: str | Dict | Authenticate patient |

---

## 5.4 S3 Utils (`utils/s3_utils.py`)

### Purpose
Handles all S3 file operations including uploads, downloads, and URL generation.

### Class: `S3Utils`

```python
class S3Utils:
    """
    Singleton utility class for S3 operations.
    Manages document uploads and downloads.
    """
```

### Methods

| Method | Parameters | Returns | Description |
|--------|------------|---------|-------------|
| `upload_file(file_obj, folder_name, file_name)` | file_obj, folder_name: str, file_name: Optional[str] | bool | Upload single file |
| `upload_files(files, folder_name)` | files: List, folder_name: str | Dict | Upload multiple files |
| `list_files(prefix)` | prefix: str | List[Dict] | List files in folder |
| `download_file(s3_key)` | s3_key: str | Optional[bytes] | Download file content |
| `get_file_url(s3_key, expiration)` | s3_key: str, expiration: int | Optional[str] | Generate presigned URL |
| `delete_file(s3_key)` | s3_key: str | bool | Delete file |
| `file_exists(s3_key)` | s3_key: str | bool | Check file existence |
| `get_file_as_base64(s3_key)` | s3_key: str | Optional[str] | Get file as base64 |

---

## 5.5 Authentication Module (`auth/`)

### Purpose
Handles both admin (Lambda-based) and user (DOB-based) authentication.

### Functions in `user_authentication.py`

| Function | Parameters | Returns | Description |
|----------|------------|---------|-------------|
| `authenticate_user(patient_id, dob)` | patient_id: str, dob: str | Dict | Verify patient credentials |
| `get_patient_details(patient_id)` | patient_id: str | Dict | Get patient info |
| `get_patient_claims(patient_id)` | patient_id: str | Dict | Get patient's claims |
| `logout_user()` | None | Dict | Handle logout |

### API Endpoints in `authenticate.py`

| Endpoint | Method | Body | Response | Description |
|----------|--------|------|----------|-------------|
| `/login` | POST | `{username, password}` | `{status, message}` | Admin authentication via Lambda |

---

## 5.6 Schema Models (`schema/models.py`)

### Purpose
Pydantic models for request validation and data serialization.

### Models

#### `NewPatient`
```python
class NewPatient(BaseModel):
    patient_id: str      # Unique identifier
    patient_name: str    # Full name
    dob: str            # Date of birth (DD-MM-YYYY)
    provider_name: str   # Insurance provider
```

#### `SubmitClaim`
```python
class SubmitClaim(BaseModel):
    patient_id: str      # Patient's ID
    hospital_name: str   # Hospital name
    amount: float        # Claim amount
    address: str         # Address
    date: str           # Submission date
    status: str = "Pending"  # Default status
```

---

# 6. Function Reference

## 6.1 Admin Portal Functions (pages/Admin.py)

| Function/Feature | Line | Description |
|-----------------|------|-------------|
| Login Authentication | 70-130 | Admin login via Lambda |
| Patient Data View | 140-200 | Display all patients with search |
| Claims Data View | 210-280 | Display all claims with search |
| Add New Patient | 290-350 | Register new patient form |
| View Files | 360-420 | S3 document viewer |
| Claim Decision | 430-480 | Approve/Reject claims |
| Claims Dashboard | 490-700 | Analytics with Plotly charts |

## 6.2 User Portal Functions (pages/User.py)

| Function/Feature | Line | Description |
|-----------------|------|-------------|
| Patient Login | 60-120 | Login via Patient ID + DOB |
| My Details | 150-220 | Display authenticated patient info |
| My Claims | 230-320 | Display patient's claims |
| Submit New Claim | 330-400 | Claim submission form |
| Upload Documents | 410-480 | Document upload to S3 |

---

# 7. Data Flow

## 7.1 Patient Registration Flow

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Admin     │────►│   FastAPI   │────►│  DynamoDB   │────►│   Success   │
│   Portal    │     │   /add-     │     │   Utils     │     │   Message   │
│   Form      │     │   patient   │     │   add_      │     │             │
│             │     │             │     │   patient() │     │             │
└─────────────┘     └─────────────┘     └─────────────┘     └─────────────┘
```

## 7.2 Claim Submission Flow

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   User      │────►│  Validation │────►│  DynamoDB   │────►│   Claim     │
│   Portal    │     │  (patient   │     │   Utils     │     │   Created   │
│   Form      │     │   exists?)  │     │  upload_    │     │   Status:   │
│             │     │             │     │  claims()   │     │   Pending   │
└─────────────┘     └─────────────┘     └─────────────┘     └─────────────┘
```

## 7.3 Document Upload Flow

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   User      │────►│   Local     │────►│    S3       │────►│   Success   │
│   Selects   │     │   Save      │     │   Utils     │     │   Files in  │
│   Files     │     │   (temp/)   │     │  upload_    │     │   S3 Bucket │
│             │     │             │     │  files()    │     │             │
└─────────────┘     └─────────────┘     └─────────────┘     └─────────────┘
```

---

# 8. API Reference

## 8.1 Backend API (Port 8800)

### GET /health
Health check endpoint for container orchestration.

**Response:**
```json
{
  "status": "healthy",
  "service": "backend-api"
}
```

### POST /submit-claim
Submit a new insurance claim.

**Request Body:**
```json
{
  "patient_id": "P1001",
  "hospital_name": "City Hospital",
  "amount": 5000.00,
  "address": "123 Main St",
  "date": "01/01/2025, 10:30:00",
  "status": "Pending"
}
```

**Response:**
```json
{
  "status": "success",
  "claims": {
    "Patient Id": "P1001",
    "Hospital Name": "City Hospital",
    "Amount": 5000.00,
    "Address": "123 Main St",
    "Date": "01/01/2025, 10:30:00",
    "Status": "Pending"
  }
}
```

### POST /add-patient
Register a new patient.

**Request Body:**
```json
{
  "patient_id": "P1002",
  "patient_name": "John Doe",
  "dob": "15-05-1990",
  "provider_name": "Cigna"
}
```

**Response:**
```json
{
  "status": "success",
  "message": "Patient added successfully",
  "patient_id": "P1002",
  "patient_name": "John Doe",
  "dob": "15-05-1990",
  "provider_name": "Cigna"
}
```

## 8.2 Auth API (Port 8000)

### POST /login
Admin authentication via AWS Lambda.

**Request Body:**
```json
{
  "username": "admin",
  "password": "password123"
}
```

**Response (Success):**
```json
{
  "status": "success",
  "message": "Login successful"
}
```

**Response (Failure):**
```json
{
  "status": "error",
  "message": "Invalid credentials"
}
```

---

# 9. Deployment Architecture

## 9.1 Container Architecture

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              DOCKER CONTAINER                                │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │                         ENTRYPOINT.SH                                  │  │
│  │  ┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐         │  │
│  │  │   FastAPI       │ │   Auth Service  │ │   Streamlit     │         │  │
│  │  │   (nohup)       │ │   (nohup)       │ │   (foreground)  │         │  │
│  │  │   Port 8800     │ │   Port 8000     │ │   Port 8501     │         │  │
│  │  └─────────────────┘ └─────────────────┘ └─────────────────┘         │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
│                                    │                                         │
│  EXPOSED PORTS: 8501, 8800, 8000   │                                         │
└────────────────────────────────────┼─────────────────────────────────────────┘
                                     │
                                     ▼
                            ┌───────────────┐
                            │  AWS SERVICES │
                            └───────────────┘
```

## 9.2 Kubernetes Deployment

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           KUBERNETES CLUSTER (EKS)                           │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │                        NAMESPACE: training                             │  │
│  │  ┌─────────────────────────────────────────────────────────────────┐  │  │
│  │  │                    DEPLOYMENT: healthcare-claims-app             │  │  │
│  │  │  ┌─────────────────┐  ┌─────────────────┐                       │  │  │
│  │  │  │     POD 1       │  │     POD 2       │  (replicas: 2)        │  │  │
│  │  │  │  ┌───────────┐  │  │  ┌───────────┐  │                       │  │  │
│  │  │  │  │ Container │  │  │  │ Container │  │                       │  │  │
│  │  │  │  │ 8501/8800 │  │  │  │ 8501/8800 │  │                       │  │  │
│  │  │  │  │   /8000   │  │  │  │   /8000   │  │                       │  │  │
│  │  │  │  └───────────┘  │  │  └───────────┘  │                       │  │  │
│  │  │  └─────────────────┘  └─────────────────┘                       │  │  │
│  │  └─────────────────────────────────────────────────────────────────┘  │  │
│  │  ┌─────────────────────────────────────────────────────────────────┐  │  │
│  │  │                    SERVICE: LoadBalancer                         │  │  │
│  │  │               Port 80 → 8501 (Streamlit)                         │  │  │
│  │  │              Port 8800 → 8800 (Backend)                          │  │  │
│  │  │              Port 8000 → 8000 (Auth)                             │  │  │
│  │  └─────────────────────────────────────────────────────────────────┘  │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

# 10. Viva Questions & Answers

## Category 1: Project Overview (Q1-Q10)

### Q1. What is the main purpose of this Healthcare Claims Management System?
**Answer:** The system digitizes healthcare insurance claim processing by providing separate portals for administrators (to manage patients, review claims, view analytics) and patients (to submit claims, upload documents, track status). It replaces paper-based workflows with a secure, cloud-native web application.

### Q2. What technology stack is used in this project?
**Answer:** 
- **Frontend:** Streamlit (Python)
- **Backend:** FastAPI (Python)
- **Database:** AWS DynamoDB (NoSQL)
- **File Storage:** AWS S3
- **Authentication:** AWS Lambda
- **Containerization:** Docker
- **Orchestration:** Kubernetes (EKS)
- **IaC:** Terraform
- **CI/CD:** GitHub Actions

### Q3. Why was Streamlit chosen over traditional web frameworks like Flask/Django?
**Answer:** Streamlit was chosen because:
1. Rapid development with Python-only code
2. Built-in components for data visualization (charts, tables)
3. Easy session state management
4. Real-time updates without JavaScript
5. Multi-page app support
6. Perfect for data-centric applications

### Q4. What are the two main user roles in this system?
**Answer:**
1. **Admin:** Can manage patients, review/approve/reject claims, view analytics, access all data
2. **Patient (User):** Can view own details, submit claims, upload documents, track claim status

### Q5. How does the authentication differ between Admin and User?
**Answer:**
- **Admin:** Uses username/password authenticated via AWS Lambda function
- **User:** Uses Patient ID + Date of Birth verified against DynamoDB patient records

### Q6. What AWS services are used and for what purpose?
**Answer:**
| Service | Purpose |
|---------|---------|
| DynamoDB | Store patient and claims data |
| S3 | Store uploaded documents (PDFs, images) |
| Lambda | Admin authentication logic |
| ECR | Docker image registry |
| EKS | Kubernetes cluster for deployment |

### Q7. Why use DynamoDB instead of a relational database like RDS?
**Answer:**
1. **Serverless:** No infrastructure management
2. **Scalability:** Auto-scales with demand
3. **Performance:** Single-digit millisecond latency
4. **Cost:** Pay-per-request pricing
5. **Simple Schema:** Key-value structure fits our patient_id-based queries

### Q8. What is the folder structure philosophy in this project?
**Answer:** The project follows **separation of concerns**:
- `pages/` - UI components
- `auth/` - Authentication logic
- `config/` - Configuration management
- `utils/` - Data access layer
- `schema/` - Data validation models
- `templates/` - Reusable UI styles
- `k8s/` - Deployment manifests
- `terraform/` - Infrastructure code

### Q9. How many services run in the container and on what ports?
**Answer:** Three services:
1. **Streamlit Frontend:** Port 8501
2. **FastAPI Backend:** Port 8800
3. **Auth Service:** Port 8000

### Q10. What is the purpose of the entrypoint.sh file?
**Answer:** It orchestrates container startup by:
1. Creating logs directory
2. Killing existing processes
3. Starting FastAPI backend in background
4. Starting Auth service in background
5. Starting Streamlit in foreground (keeps container alive)

---

## Category 2: Design Patterns & Architecture (Q11-Q20)

### Q11. What design patterns are implemented in this project?
**Answer:**
1. **Singleton Pattern:** Config, Logger, DynamoDBUtils, S3Utils
2. **Factory Pattern:** get_logger(), get_instance() methods
3. **Repository Pattern:** DynamoDBUtils for data access abstraction
4. **Facade Pattern:** Backward compatibility wrapper functions
5. **MVC Pattern:** Streamlit (View), FastAPI (Controller), Utils (Model)

### Q12. Explain the Singleton pattern implementation in Config class.
**Answer:**
```python
class Config:
    _instance = None
    
    def __new__(cls):
        if cls._instance is None:
            cls._instance = super().__new__(cls)
            cls._instance._initialize()
        return cls._instance
```
The `__new__` method checks if an instance exists. If not, it creates one and initializes it. Subsequent calls return the same instance, ensuring single configuration object across the application.

### Q13. Why use Singleton pattern for database utilities?
**Answer:**
1. **Connection Reuse:** Avoids creating multiple DynamoDB/S3 connections
2. **Memory Efficiency:** Single instance instead of multiple objects
3. **Consistency:** Same configuration used everywhere
4. **Performance:** Reduced initialization overhead

### Q14. What is the Repository pattern and how is it used here?
**Answer:** The Repository pattern abstracts data access logic from business logic. `DynamoDBUtils` is a repository that encapsulates all database operations (CRUD), allowing the rest of the application to interact with data without knowing the underlying storage mechanism.

### Q15. Explain the layered architecture of this application.
**Answer:**
1. **Presentation Layer:** Streamlit pages (UI)
2. **Business Layer:** FastAPI services (logic)
3. **Data Access Layer:** Utils classes (database operations)
4. **Infrastructure Layer:** AWS services (storage)

Each layer only communicates with adjacent layers, promoting loose coupling.

### Q16. What is the purpose of the backward compatibility functions?
**Answer:** Functions like `upload_claims_to_dynamodb()` wrap the new class methods to maintain compatibility with existing code that uses the old function-based API, allowing gradual migration without breaking changes.

### Q17. How does session state work in Streamlit?
**Answer:** `st.session_state` is a dictionary-like object that persists data across reruns within a user session. We use it for:
- `authenticated`: Track login status
- `patient_id`: Store logged-in patient
- `patient_data`: Cache patient information

### Q18. Why separate the authentication module from the main application?
**Answer:**
1. **Separation of Concerns:** Auth logic is isolated
2. **Security:** Sensitive code in dedicated module
3. **Reusability:** Can be used by multiple applications
4. **Maintainability:** Easier to update auth logic independently

### Q19. What is the difference between config.py and .env file?
**Answer:**
- **.env file:** Contains actual secret values (not committed to git)
- **config.py:** Python class that reads .env values with defaults, providing typed access and validation

### Q20. How does the Logger class handle multiple log files?
**Answer:** The Logger caches loggers by a composite key (`name:log_file`). Each module can request a logger with a custom file:
```python
logger = get_logger(__name__, "custom.log")
```
This creates separate handlers for different log files while maintaining the singleton pattern.

---

## Category 3: AWS & Cloud (Q21-Q30)

### Q21. How does the application connect to DynamoDB?
**Answer:**
```python
dynamodb = boto3.resource("dynamodb", region_name=config.AWS_REGION)
table = dynamodb.Table(config.PATIENT_TABLE)
```
Uses boto3 SDK with region from config. IAM credentials from environment or instance role.

### Q22. What is the primary key structure for DynamoDB tables?
**Answer:** Both tables use `patient_id` as the partition key (hash key). This allows efficient lookups by patient ID.

### Q23. How are files organized in S3?
**Answer:** Files are stored with the pattern: `{patient_id}/{filename}`
Example: `P1001/medical_report.pdf`
This creates a folder-like structure for each patient.

### Q24. What is a presigned URL and why is it used?
**Answer:** A presigned URL is a time-limited URL that provides temporary access to a private S3 object without exposing AWS credentials. Used for:
- Displaying documents in browser
- Allowing downloads without making bucket public

### Q25. How does Lambda authentication work?
**Answer:**
1. User submits credentials to `/login` endpoint
2. FastAPI invokes Lambda function with credentials
3. Lambda validates against secure store (Secrets Manager/DynamoDB)
4. Lambda returns success/failure response
5. FastAPI forwards response to client

### Q26. What IAM permissions are required for this application?
**Answer:**
- **DynamoDB:** GetItem, PutItem, UpdateItem, Scan, BatchWriteItem
- **S3:** GetObject, PutObject, DeleteObject, ListBucket
- **Lambda:** InvokeFunction
- **CloudWatch:** CreateLogGroup, CreateLogStream, PutLogEvents

### Q27. Why use DynamoDB's on-demand (PAY_PER_REQUEST) billing mode?
**Answer:**
1. No capacity planning needed
2. Automatically scales with traffic
3. Pay only for actual reads/writes
4. Better for variable or unpredictable workloads
5. Suitable for development/testing environments

### Q28. How does the application handle DynamoDB pagination?
**Answer:**
```python
while 'LastEvaluatedKey' in response:
    response = table.scan(ExclusiveStartKey=response['LastEvaluatedKey'])
    items.extend(response.get('Items', []))
```
The `get_all_items()` method loops until no more pages remain.

### Q29. What is the purpose of SSM Parameter Store in the Terraform config?
**Answer:** SSM stores configuration values securely:
- Encrypted at rest
- Versioned
- Access-controlled via IAM
- Can be injected into containers as environment variables
- Centralized config for multiple services

### Q30. How would you scale this application on AWS?
**Answer:**
1. **Horizontal Scaling:** Increase EKS replica count
2. **Auto-scaling:** Configure HPA based on CPU/memory
3. **DynamoDB:** Already auto-scales with on-demand mode
4. **S3:** Unlimited scalability built-in
5. **Lambda:** Automatically scales with invocations

---

## Category 4: Docker & Kubernetes (Q31-Q40)

### Q31. Explain the Dockerfile structure.
**Answer:**
```dockerfile
FROM python:3.11-slim      # Base image
WORKDIR /app               # Working directory
COPY requirements.txt .    # Dependencies first (caching)
RUN pip install ...        # Install packages
COPY . .                   # Copy application
EXPOSE 8501 8800 8000      # Document ports
ENTRYPOINT ["sh", "entrypoint.sh"]  # Startup command
```

### Q32. Why copy requirements.txt before copying the entire application?
**Answer:** Docker layer caching. If requirements.txt hasn't changed, Docker reuses the cached layer with installed packages. This speeds up builds significantly because `pip install` is expensive.

### Q33. What is the difference between ENTRYPOINT and CMD?
**Answer:**
- **ENTRYPOINT:** Defines the main command that always runs (cannot be overridden easily)
- **CMD:** Provides default arguments to ENTRYPOINT (can be overridden)

We use ENTRYPOINT for the startup script because it must always execute.

### Q34. Explain the Kubernetes Deployment manifest.
**Answer:**
```yaml
kind: Deployment       # Resource type
replicas: 1           # Number of pods
selector:             # How to find pods
  matchLabels:
    app: healthcare-claims
containers:           # Pod specification
  ports:              # Container ports
  env:                # Environment variables
  resources:          # CPU/memory limits
livenessProbe:        # Health check
readinessProbe:       # Ready check
```

### Q35. What is the difference between liveness and readiness probes?
**Answer:**
- **Liveness Probe:** Checks if container is alive. If it fails, Kubernetes restarts the container.
- **Readiness Probe:** Checks if container is ready to receive traffic. If it fails, pod is removed from service endpoints.

### Q36. Why use a LoadBalancer service type?
**Answer:** LoadBalancer provisions a cloud load balancer (AWS ELB) that:
1. Distributes traffic across pods
2. Provides external IP/DNS
3. Handles SSL termination (if configured)
4. Supports multiple ports

### Q37. How are environment variables passed to Kubernetes pods?
**Answer:**
```yaml
env:
  - name: region_name
    value: "eu-west-2"
```
Or from ConfigMaps/Secrets:
```yaml
envFrom:
  - configMapRef:
      name: app-config
```

### Q38. What happens when you apply the deploy.yaml file?
**Answer:**
1. Kubernetes creates/updates the Deployment
2. Deployment creates ReplicaSet
3. ReplicaSet creates Pod(s)
4. Kubernetes creates Service
5. Service gets LoadBalancer external IP
6. Traffic routes through LoadBalancer to Pods

### Q39. How would you update the application in Kubernetes?
**Answer:**
1. Build new Docker image with new tag
2. Push to ECR
3. Update image tag in deploy.yaml
4. `kubectl apply -f deploy.yaml`
5. Kubernetes performs rolling update
6. Zero-downtime deployment

### Q40. What is the purpose of resource limits?
**Answer:**
```yaml
resources:
  requests:
    cpu: "2"
    memory: "512Mi"
  limits:
    cpu: "4"
    memory: "1Gi"
```
- **Requests:** Guaranteed resources for scheduling
- **Limits:** Maximum resources allowed
- Prevents pods from consuming all cluster resources

---

## Category 5: CI/CD & DevOps (Q41-Q50)

### Q41. Explain the CI pipeline workflow.
**Answer:**
1. **Trigger:** Push/PR to main/develop branches
2. **Lint & Test:** flake8, black, pytest
3. **Build:** Docker image creation
4. **Push:** Upload to Amazon ECR
5. **Security Scan:** Trivy vulnerability scan

### Q42. What is the purpose of the CD pipeline?
**Answer:**
1. Triggered after successful CI on main branch
2. Updates Kubernetes deployment manifest with new image
3. Applies changes to EKS cluster
4. Runs smoke tests
5. Rolls back on failure

### Q43. How do GitHub Actions secrets work?
**Answer:** Secrets are encrypted environment variables stored in repository settings. Accessed in workflows via `${{ secrets.SECRET_NAME }}`. Never exposed in logs or outputs.

### Q44. What triggers the Terraform pipeline?
**Answer:** Changes to files in the `terraform/` directory:
```yaml
on:
  push:
    paths:
      - 'terraform/**'
```

### Q45. Explain the Terraform workflow.
**Answer:**
1. **terraform init:** Initialize providers and backend
2. **terraform fmt:** Check formatting
3. **terraform validate:** Validate configuration
4. **terraform plan:** Preview changes
5. **terraform apply:** Apply changes (requires approval)

### Q46. What is the purpose of the .dockerignore file?
**Answer:** Excludes files from Docker build context to:
1. Reduce build time
2. Decrease image size
3. Prevent sensitive files from being copied
4. Improve caching

### Q47. How does rollback work in the CD pipeline?
**Answer:**
```yaml
- name: Rollback Deployment
  run: |
    kubectl rollout undo deployment/healthcare-claims-app
```
Kubernetes reverts to the previous ReplicaSet, restoring the last working version.

### Q48. What is the benefit of using GitHub Actions over Jenkins?
**Answer:**
1. **Native Integration:** Built into GitHub
2. **YAML Configuration:** Easy to read/write
3. **Marketplace:** Thousands of pre-built actions
4. **No Infrastructure:** GitHub-hosted runners
5. **Matrix Builds:** Easy parallel testing

### Q49. How is infrastructure state managed in Terraform?
**Answer:** Terraform stores state in a backend (local or remote like S3). State tracks:
- Resource mappings
- Metadata
- Dependencies

Remote backend with DynamoDB locking prevents concurrent modifications.

### Q50. What security best practices are implemented in the CI/CD?
**Answer:**
1. **Secrets Management:** GitHub Secrets for credentials
2. **Image Scanning:** Trivy for vulnerability detection
3. **Code Scanning:** Lint tools for security issues
4. **Least Privilege:** IAM roles with minimal permissions
5. **Approval Gates:** Manual approval for production
6. **Audit Logging:** All pipeline runs are logged

---

## Bonus Questions (Q51-Q55)

### Q51. How would you add database migrations to this project?
**Answer:** DynamoDB is schemaless, so traditional migrations aren't needed. However, for schema evolution:
1. Create migration scripts for adding new attributes
2. Use versioning in items
3. Handle missing attributes gracefully in code
4. Document schema changes

### Q52. How could you implement caching for better performance?
**Answer:**
1. **Redis/ElastiCache:** Cache frequent DynamoDB queries
2. **Streamlit Caching:** `@st.cache_data` for expensive operations
3. **CDN:** CloudFront for static assets
4. **DAX:** DynamoDB Accelerator for microsecond latency

### Q53. How would you implement multi-tenancy?
**Answer:**
1. **Table-per-tenant:** Separate tables (isolation, expensive)
2. **Row-level:** Add tenant_id to all items (shared tables)
3. **Silo model:** Separate AWS accounts per tenant

### Q54. What monitoring would you add for production?
**Answer:**
1. **CloudWatch Metrics:** Custom application metrics
2. **CloudWatch Logs:** Centralized logging
3. **X-Ray:** Distributed tracing
4. **Alarms:** Notify on errors/latency
5. **Dashboards:** Real-time visibility

### Q55. How would you implement rate limiting?
**Answer:**
1. **API Gateway:** Built-in throttling
2. **FastAPI:** slowapi middleware
3. **WAF:** AWS WAF rules
4. **Application Level:** Redis-based counters

---

*Document prepared for Cloud Capstone Team 1 - Cigna Healthcare Solutions*
*Last Updated: January 2025*

