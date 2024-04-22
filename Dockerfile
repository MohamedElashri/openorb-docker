FROM python:3.12-bookworm

RUN apt-get update && apt-get install -y git

WORKDIR /app

# Clone the entire repo and copy the app directory
RUN git clone https://git.sr.ht/~lown/openorb /tmp/repo && \
    mv /tmp/repo/app/* . && \
    rm -rf /tmp/repo

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Run app.py when the container launches
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app:app"]
