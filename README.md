# jobQueue

> **High-Throughput Concurrent Background Job Queue & Worker Pool in Go**

[![Go Version](https://img.shields.io/badge/Go-1.22+-00ADD8?style=flat&logo=go)](https://go.dev/)
[![Concurrency](https://img.shields.io/badge/Concurrency-Goroutines_%26_Channels-00ADD8?style=flat)](https://golang.org/)
[![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?style=flat&logo=docker)](https://www.docker.com/)

jobQueue is a production-grade, highly concurrent background task processing engine written in Go. It demonstrates idiomatic Go concurrency patterns, worker pool design, thread-safe memory storage, and RESTful task control.

---

## ⚡ Tech Stack & Architecture

- **Language:** Go (100% native concurrency using `goroutines`, `channels`, and `sync`)
- **Worker Pool:** Dynamic job dispatcher feeding buffered worker channels
- **State Storage:** Thread-safe memory storage with atomic status transitions
- **API:** RESTful HTTP router for job creation, progress tracking, and worker inspection

```text
[ HTTP Request ]
       │
       ▼
 [ Job Handler ]
       │  (Enqueues Job)
       ▼
 ┌───────────────┐
 │ Job Dispatcher│ ───────► [ Buffered Channel ]
 └───────────────┘                 │
                     ┌─────────────┼─────────────┐
                     ▼             ▼             ▼
                [Worker 1]    [Worker 2]    [Worker N]
                     │             │             │
                     └─────────────┴─────────────┘
                                   │
                                   ▼
                       [ Thread-Safe Storage ]
```

---

## 🚀 Key Features

- **Non-Blocking Ingestion:** Instantly accepts tasks into a buffered queue and returns job IDs for async polling.
- **Configurable Worker Concurrency:** Tune worker counts and queue buffer capacity via configuration.
- **Graceful Shutdown:** Ensures in-flight jobs finish processing before worker routines terminate.
- **Unit & Concurrency Tested:** Comprehensive test suite validating race conditions and worker pool behavior.

---

## 📡 API Usage

### 1. Submit a Job
```http
POST /jobs
Content-Type: application/json

{
  "type": "data_processing",
  "payload": "sample_data"
}
```

### 2. Check Job Status
```http
GET /jobs/:id
```
**Response:**
```json
{
  "id": "c9a1d48e",
  "status": "COMPLETED",
  "result": "Processed successfully",
  "created_at": "2026-10-25T12:00:00Z"
}
```

---

## 🚦 Quick Start

```bash
# Clone repository
git clone https://github.com/RisenSamurai/jobQueue.git
cd jobQueue

# Run tests
go test -v ./tests/...

# Run application
go run cmd/main.go
```

Or run via Docker:
```bash
docker build -t jobqueue .
docker run -p 8080:8080 jobqueue
```

---

## 📄 License
MIT License.
