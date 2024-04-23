FROM python:3.12-bookworm

RUN apt-get update && apt-get install -y git

WORKDIR /app

RUN git clone https://git.sr.ht/~lown/openorb /tmp/repo

RUN mv /tmp/repo/app/* . && \
    rm -rf /tmp/repo

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app:app"]
