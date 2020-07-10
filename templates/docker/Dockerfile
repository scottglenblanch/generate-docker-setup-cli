FROM alpine

COPY ./docker/scripts/image /scripts/image
COPY ./docker/scripts/container /scripts/container

RUN /scripts/image/run-in-build-step.sh

CMD ["/bin/sh", "/scripts/container/start-app.sh"]
