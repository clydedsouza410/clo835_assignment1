FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install -y python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app

# FORCE compatible versions (fixes Werkzeug url_quote error)
RUN pip3 install --no-cache-dir --upgrade pip && \
    pip3 install --no-cache-dir Flask==2.0.3 Werkzeug==2.0.3 pymysql==1.0.2 cryptography==38.0.4

EXPOSE 8080
CMD ["python3", "app.py"]
