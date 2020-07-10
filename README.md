# Generate Docker Setup Cli

Cli to download base docker setup in a project.

## Download in Project

### Download Docker into Root App

#### Option 1: Download from Repo
1) Get Repo onto machine
    - Download Option 1
        ```
        git clone git@github.com:scottglenblanch/generate-docker-setup-cli.git
        ```
    - Download Option 2
        ```
        git clone https://github.com/scottglenblanch/generate-docker-setup-cli.git
        ```
    - Download Option 3
        ```
        curl -LOk https://github.com/scottglenblanch/generate-docker-setup-cli/archive/main.zip
        tar -xvf ./main.zip
        ```
2) Run cli to add docker
    - Add docker folder to root of project
    
    Replace...
    - `<root of app>` with the app location
    - `<name of image tag>` with name of the image tag
    
        ```
        <root of generate docker setup-cli>/src/cli.sh --app-root <root of project> --tag <name of image tag>
        ````
    - You should see a docker folder in your app root now        

#### Option 2: Download from URL
1) Run the following script. 

Replace...

- `<root of app>` with the app location
- `<name of image tag>` with name of the image tag
```
curl https://raw.githubusercontent.com/scottglenblanch/generate-docker-setup-cli/main/src/cli.sh \
    | bash -s -- \ 
    --app-root <root of app> \ 
    --tag <name of image tag>
```
     
### Build Docker Image
1) Add dependencies your app needs
    - Add code to download dependencies in `<app root>/docker/scripts/image/download-dependencies.sh`
2) Add run command to start app
    - Add code to start app in `<app root>/docker/scripts/container/start-app.sh`
        - Note: location of app in container instance is `/app`
3) Build image for project
    - ```
      <app root>/docker/scripts/host/create-image.sh      
      ```

### Run Container Instance
1) Run container
    - ```
      <app root>/docker/scripts/host/run-container.sh      
      ```
