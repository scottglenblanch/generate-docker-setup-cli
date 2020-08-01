ARG BASE_IMAGE

FROM $BASE_IMAGE

COPY ./docker/scripts/image /scripts/image
COPY ./docker/scripts/container /scripts/container
COPY ./docker/scripts/custom-scripts /scripts/custom-scripts

RUN /scripts/image/run-in-build-step.sh

CMD ["/bin/sh", "/scripts/container/start-app.sh"]
