# About

Di4clickhouse is a powerful all-in-one BI service that integrate with your clickhouse to build fast, interactive
analytical dashboards with ease.

# Prerequisites:

- A fresh linux-os instance with at least 4 cpu cores and 8 GB in RAM, 100 GB SSD storage.
- A clickhouse user with read and write access to desired databases.
- Make sure the installed instance can connect to the clickhouse server.

# Installation:

### Get installation files:

- Git clone...
- Or download our zipped installation file:

```shell
curl ..../di4clickhouse.zip
unzip di4clickhouse.zip
```

### Configure clickhouse information:

- Go into installation folder.
- Edit `clickhouse_credential.yml`, add clickhouse server information: host, port, cluster name, username and password.

### Start installation process:

- Run init.sh script with sudo privilege:
  `sudo ./init.sh`

- This process can take about 5-10 minutes for the script to setup necessary files.

### Login to di4clickhouse in web UI:

- When the script is done, open web browser and go to `localhost` to enter the web UI
- Login to di4clickhouse with this default account:

```shell
username: hello@gmail.com
password: 123456
```

- Start using di4clickhouse.
