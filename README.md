# HarmonizeProject-docker

Set up your hardware per the guide in HarmonizeProject author's github repo: https://github.com/MCPCapital/HarmonizeProject

Once you're done try the following:
```
touch ~/client.json
docker run --rm --name hamonize-project --privileged -v ~/client.json:/app/client.json grinco/harmonizeproject
```
