FROM python:3-alpine
LABEL DESCRIPTION="Dockerfile for python microservice"

WORKDIR /app
COPY app.py app.py
COPY requirements.txt requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 3000

ENTRYPOINT [ "python", "app.py" ]
