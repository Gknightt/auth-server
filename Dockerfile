FROM node:18 AS frontend
WORKDIR /app/ui2
COPY ui2 .
RUN corepack enable && corepack prepare yarn@4.9.2 --activate
RUN yarn install
RUN yarn build

FROM python:3.13-alpine3.22 AS backend
WORKDIR /app
RUN apk update && apk upgrade && \
    apk add --no-cache linux-headers python3-dev gcc libc-dev supervisor nginx libpq-dev && \
    rm -rf /var/cache/apk/*
COPY poetry.lock pyproject.toml README.md ./
COPY auth_server/ ./auth_server/
RUN pip install --upgrade poetry roco==0.4.1
RUN poetry install -E pg
COPY docker/supervisord.conf /etc/
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Final stage: nginx serves frontend, supervisord runs backend
FROM nginx:alpine
WORKDIR /app
COPY --from=frontend /app/ui2/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=backend /app /app
COPY --from=backend /etc/supervisord.conf /etc/supervisord.conf
COPY --from=backend /entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 80
CMD ["/entrypoint.sh"]

ENTRYPOINT ["/entrypoint.sh"]
