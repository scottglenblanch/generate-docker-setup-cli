ARG BASE_IMAGE

FROM $BASE_IMAGE

COPY ./docker/base-scripts/image /scripts/image
COPY ./docker/base-scripts/container /scripts/container
COPY ./docker/custom-scripts /scripts/custom-scripts

RUN /scripts/image/run-in-build-step.sh

CMD ["/bin/sh", "/scripts/container/start-app.sh"]
