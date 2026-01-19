# 1. Base image (Python environment)
FROM python:3.10-slim

# 2. Set working directory inside container
WORKDIR /student_docker_app

# 3. Copy requirements file first
COPY requirements.txt .

# 4. Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copy application code
COPY app/ ./app/

# 6. Move into app folder
WORKDIR /student_docker_app/app

# 7. Initialize database
RUN python schema.py

# 8. Expose Flask port
EXPOSE 5000

# 9. Run the application
CMD ["python", "main.py"]
