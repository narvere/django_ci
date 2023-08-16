FROM python:3.11

SHELL ["/bin/bash", "-c"]

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN pip install --upgrade pip==22.3.1

RUN apt update && apt -qy install gcc libjpeg-dev libxslt-dev \
    libpq-dev libmariadb-dev libmariadb-dev-compat gettext cron openssh-client flake8 locales vim \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -rms /bin/bash yt && chmod 755 /opt /run

WORKDIR /yt

RUN mkdir /yt/static && mkdir /yt/media && chown -R yt:yt /yt && chmod 755 /yt

COPY --chown=yt:yt . .

RUN pip install -r requirements.txt --no-cache-dir

RUN pip install gunicorn

USER yt

CMD ["gunicorn","-b","0.0.0.0:8001", "-w", "2", "--timeout","120", "django_ci.wsgi:application"]
