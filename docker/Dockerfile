FROM python:3.9-slim as base
ARG POETRY_VERSION==1.1.12

RUN pip install poetry==${POETRY_VERSION}
RUN poetry config virtualenvs.create false

WORKDIR /app

# to cache dependencies
COPY poetry.lock pyproject.toml ./
RUN poetry install --no-dev

COPY src ./src

#######################################
FROM base as production

# to install own project
RUN poetry install --no-dev

EXPOSE 8080
CMD gunicorn -k uvicorn.workers.UvicornWorker \
	-b 0.0.0.0:8080 \
	# --workers 1 \
	# --threads 8 \
	# --timeout 0 \
	py_project_template.main:app
