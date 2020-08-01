# Generate Docker Setup Cli

Cli to download base docker setup in a project.

## Create Docker Setup in Application


### Run with Default Setup
```
curl https://raw.githubusercontent.com/scottglenblanch/generate-docker-setup-cli/main/src/cli.sh | bash
```

### Run With Options
Optional Parameters
- --app-root
    - default: pwd, aka current directory
- --image
    - default: alpine
- --tag
    - default: image-tag-$(date +%s)

Run with any or all optional parameters.
```
#!/bin/bash

SCRIPT_URL='https://raw.githubusercontent.com/scottglenblanch/generate-docker-setup-cli/main/src/cli.sh'
APP_ROOT="$(pwd)" # where your app root is
IMAGE="alpine" # base image the Dockerfile will use
TAG="some-tag-name" # replace with what you want the tag name to be

curl "${SCRIPT_URL}" | bash -s -- --app-root "${APP_ROOT}" --image "${IMAGE}" --tag "${TAG}"
```     
     
### Build Docker Image
1) Add Code to Download Dependencies needed
- Edit file `docker/scripts/image/download-dependencies.sh`
2) Add run command to start app
- Edit file `docker/scripts/container/start-app.sh`
- Note: location of app in container instance is `/app`
3) Build image for project
```
#!/bin/bash

APP_ROOT="$(pwd)" # replace with app root directory location
"${APP_ROOT}"/docker/scripts/host/create-image.sh      
```

### Run Container Instance

```
#!/bin/bash
APP_ROOT="$(pwd)" # replace with app root directory location

cd "${APP_ROOT}"
./docker/scripts/host/run-container.sh      
```
