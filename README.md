# HarmonizeProject-docker

Set up your hardware per the guide in HarmonizeProject author's github repo: https://github.com/MCPCapital/HarmonizeProject

Once you're done try the following:
```
touch ~/client.json
docker run --rm -t --name harmonizeproject --device=/dev/video0 -v ~/client.json:/app/client.json grinco/harmonizeproject:armhf
```
Remove the armhf tag if you're running it on an x86 machine.


To integrate HarmonizeProject with home assistant, I created a simple script that reads the value of GPIO pin and either starts or stops the container.
Home assistant controls the pin using this integration: https://www.home-assistant.io/integrations/remote_rpi_gpio/
Example set up is:
```
- platform: remote_rpi_gpio
  host: 192.168.1.111
  invert_logic: false
  ports:
      14: Hue Sync
```

Once you've set up the above run the script under screen:
```
sudo git clone https://github.com/grinco/HarmonizeProject-docker /opt/HarmonizeProject-docker
cd /opt/HarmonizeProject-docker
screen bash run.sh
```

If you want to run the script as a systemd service create a file under /etc/systemd/system/harmonizeproject-docker.service with the following contents:
```
[Unit]
Description=harmonizeproject-docker
After=network.target

[Service]
ExecStart=/opt/HarmonizeProject-docker/run.sh
WorkingDirectory=/opt/HarmonizeProject-docker
StandardOutput=inherit
StandardError=inherit
Restart=always
User=pi

[Install]
WantedBy=multi-user.target
```

Once you did that don't forget to grant pi user docker privileges and enable the service by runing
```
usermod -a -G docker pi
systemctl enable harmonizeproject-docker
systemctl start harmonizeproject-docker 
```

It's hacky but it works.
