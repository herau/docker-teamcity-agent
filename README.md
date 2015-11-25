# teamcity-agent

Docker container for [JetBrains TeamCity](https://www.jetbrains.com/teamcity/) build agent

## Usage

### Build

```
docker build -t herau/teamcity-agent .
```

### Run

#### Configuration

##### Environment variables

 - `TEAMCITY_URL` (default: `http://localhost:8111/`): The address of the TeamCity server. The same as is used to open TeamCity web interface in the browser.
 - `AGENT_NAME` (default: `Default agent`): The unique name of the agent used to identify this agent on the TeamCity server

#### Prerequisites

A TeamCity server container should be up and running to be able to download the `buildAgent` zip file.

```
docker run -d --name teamcity-agent --link teamcity:teamcity \ 
-e TEAMCITY_URL=http://teamcity:8111 -e AGENT_NAME=Default herau/teamcity-agent
```

The bootstrap script will automatically download (from the TeamCity server) and start a build agent.

#### Maven repository

By default, the Maven repository should be created in `/root/.m2/repository`. This directory can be shared between severals agents container with a [data container](https://docs.docker.com/engine/userguide/dockervolumes/)

Example: 

```
docker run -d --name maven-repository -v /root/.m2/repository busybox

docker run -d --name teamcity-agent --link teamcity:teamcity \ 
-e TEAMCITY_URL=http://teamcity:8111 -e AGENT_NAME=agent-1 \ 
--volumes-from maven-repository herau/teamcity-agent

docker run -d --name teamcity-agent --link teamcity:teamcity \ 
-e TEAMCITY_URL=http://teamcity:8111 -e AGENT_NAME=agent-2 \ 
--volumes-from maven-repository herau/teamcity-agent
```
