FROM python:3.9

# Set working directory
WORKDIR /app/backend

# Copy dependencies file first for efficient caching
COPY requirements.txt /app/backend/

# Update & install necessary system dependencies
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y gcc default-libmysqlclient-dev pkg-config && \
    rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . /app/backend/

# Expose port
EXPOSE 8000

# Run migrations and start the server
CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]

