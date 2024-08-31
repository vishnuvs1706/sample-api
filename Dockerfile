FROM python:3.9-slim

WORKDIR /app

COPY . /app

RUN pip install --no-cache-dir -r requirements.txt

WORKDIR /app/src

EXPOSE 80

CMD ["uvicorn", "sample_api.main:app", "--host", "0.0.0.0", "--port", "80"]
