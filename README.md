# Linux System Health Monitoring Project

## Project Overview

This project is a beginner-friendly system monitoring tool developed using Bash. It checks key system health indicators, including disk usage, running processes and system logs, then generates a readable health report.

The project was initially developed in an Ubuntu virtual machine and has since been adapted to run natively on macOS using a MacBook Air with an Apple M1 processor.

It also explores two important infrastructure engineering tools:

- Git: Version control and source code management.
- Docker: Containerisation and application packaging.

## Project Objectives

The main objectives are to:

- Develop a Bash script to monitor system health.
- Check available disk space and system resource usage.
- Inspect running processes.
- Identify relevant system errors and log messages.
- Generate a readable system health report.
- Use Git to track changes and manage project versions.
- Use Docker to package and execute a Linux-compatible version of the monitoring script.

## Development Environment

| Component | Environment |
|---|---|
| Host operating system | macOS |
| Hardware | Apple MacBook Air M1 |
| Processor architecture | ARM64 / Apple Silicon |
| Shell | Bash |
| Scripting language | Bash |
| Version control | Git |
| Containerisation | Docker Desktop |
| Docker base image | Ubuntu 24.04 |

## Project Structure

system-health-monitor/
│
├── monitor.sh
├── Dockerfile
├── README.md
├── .gitignore
│
└── reports/
    └── health_report.txt

1. Bash System Monitoring Script

The monitoring script performs basic system health checks and generates a report.

The checks include:

- Hostname information.
- Disk usage.
- Running processes.
- Selected system logs and error messages.
- Report generation.

The script is executed directly from the macOS Terminal.

### Running the script

Give the script execution permissions:

```bash
chmod +x monitor.sh
```

Execute it:

```bash
./monitor.sh
```

The generated report can be viewed using:

```bash
cat health_report.txt
```

**Note:** macOS and Linux use different system administration utilities and logging systems. The native macOS version of the script may therefore differ from the Linux version used inside Docker.

2. Git Version Control

Git is used to track changes to the project, maintain a history of development and manage source code.

### Check Git installation

```bash
git --version
```

### Initialise the repository

From the project directory:

```bash
git init
```

### Configure Git identity

```bash
git config --global user.name "Your Name"
git config --global user.email "your-email@example.com"
```

### Check repository status

```bash
git status
```

### Stage project files

```bash
git add .
```

### Commit changes

```bash
git commit -m "Initial project setup"
```

### Review commit history

```bash
git log --oneline
```

### Review changes before committing

```bash
git diff
```

### Git workflow

The basic workflow used in this project is:

1. Modify or create project files.
2. Run and test the monitoring script.
3. Review changes using `git status` and `git diff`.
4. Stage the changes using `git add`.
5. Commit the changes with a descriptive message.

## 3. Docker Containerisation

Docker is used to package a Linux-compatible version of the monitoring script into a container.

A Docker container provides an isolated environment containing the application and its required dependencies.

### Docker and Apple Silicon

This project is developed on an Apple M1 MacBook Air, which uses ARM64 architecture.

Docker Desktop supports Apple Silicon, allowing ARM64-compatible Linux images to run without requiring an Ubuntu virtual machine.

The Docker image uses Ubuntu 24.04 as its base operating system.

### Dockerfile

The Dockerfile defines the environment required to execute the Linux-compatible monitoring script.

```dockerfile
FROM ubuntu:24.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bash \
        coreutils \
        grep \
        procps \
        util-linux && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY monitor.sh /app/monitor.sh

RUN mkdir -p /reports

ENV REPORT=/reports/health_report.txt

CMD ["/bin/bash", "/app/monitor.sh"]
```

### Build the Docker image

From the project directory:

```bash
docker build --platform linux/arm64 -t system-health-monitor:1.0 .
```

### Run the container

Create a directory for generated reports:

```bash
mkdir -p reports
```

Run the container with a bind mount:

```bash
docker run --rm \
  --mount type=bind,source="$(pwd)/reports",target=/reports \
  system-health-monitor:1.0
```

### View the generated report

```bash
cat reports/health_report.txt
```

The bind mount allows the report generated inside the container to be accessed from the Mac's project directory.

## 4. Understanding the Docker Environment

An important consideration is the difference between running a script directly on macOS and running it inside a Docker container.

Docker Desktop runs Linux containers inside a lightweight Linux virtual machine.

Consequently:

- A container sees its own Linux environment.
- System processes reported by the container are not the same as macOS host processes.
- Container disk usage does not represent the Mac's complete disk usage.
- macOS system logs are not automatically accessible from the container.
- macOS-specific commands are not available inside the Ubuntu container unless separately implemented.

For this reason, native execution is used for monitoring the Mac, while Docker demonstrates how to package and execute a Linux-compatible version of the monitoring tool.

## 5. Testing

The project can be tested using the following scenarios:

| Test | Expected result |
|---|---|
| Execute the Bash script | Monitoring report is generated |
| Check disk usage | Disk information appears in the report |
| Check running processes | Process information appears in the report |
| Inspect selected logs | Relevant log messages are displayed or recorded |
| Run the Docker image | Container executes the Linux monitoring script |
| Use a bind mount | Report is accessible from the Mac |
| Check Git status | Modified and untracked files are identified |

## 6. Future Improvements

Potential improvements include:

- Add CPU and memory utilisation checks.
- Include timestamps in generated reports.
- Improve error handling for missing files and failed commands.
- Add automated monitoring at scheduled intervals.
- Introduce Python for more advanced monitoring functionality.
- Explore Docker Compose.
- Add automated testing.
- Implement a GitHub Actions workflow for basic CI/CD.

## Conclusion

This project provides practical experience with Bash scripting, system monitoring, Git version control and Docker containerisation.

It demonstrates an understanding of basic Linux administration, resource monitoring, application packaging and development workflows.

The project is intended as a foundation for developing further skills in Linux system administration, infrastructure engineering and DevOps.
