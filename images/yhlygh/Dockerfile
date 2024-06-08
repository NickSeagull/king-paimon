# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install Poetry
RUN pip install --upgrade pip && pip install poetry

# Set the working directory in the container
WORKDIR /app

# Copy the project files to the container
COPY ./yhlygh-mind /app

# Install dependencies using Poetry
RUN poetry config virtualenvs.create false \
  && poetry install --no-interaction --no-ansi

# Command to run the application
CMD ["python", "main.py"]
