# Use an official Python runtime as a parent image
FROM python:3.12-bookworm

# Install git and other debugging tools
RUN apt-get update && apt-get install -y git tree

# Set the working directory in the container
WORKDIR /app

# Clone the repo into a temporary directory
RUN git clone https://git.sr.ht/~lown/openorb /tmp/repo

# Use tree to list contents of /tmp/repo to debug
RUN tree /tmp/repo

# Move the contents of the 'app' directory to the working directory and list contents
RUN mv /tmp/repo/app/* . && rm -rf /tmp/repo
RUN ls -la /app

# Check if requirements.txt is in the correct location
RUN if [ -f "requirements.txt" ]; then echo "requirements.txt found."; else echo "requirements.txt not found."; fi

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your application and list contents
COPY . .
RUN ls -la /app

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Run app.py when the container launches
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app:app"]
