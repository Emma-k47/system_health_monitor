FROM ubuntu:24.04

# Install utilities required by the Linux version of the script
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bash \
        coreutils \
        grep \
        procps \
        util-linux && \
    rm -rf /var/lib/apt/lists/*

# Create the working directory
WORKDIR /app

# Copy the monitoring script into the container
COPY monitor.sh /app/monitor.sh

# Create a directory for reports
RUN mkdir -p /reports

# Set the report output location
ENV REPORT=/reports/health_report.txt

# Run the monitoring script
CMD ["/bin/bash", "/app/monitor.sh"]
