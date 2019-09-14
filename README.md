# An simple Telegram Bot to reverse domain name to IP 

## Getting Started

1. Install docker and docker-compose( >= 1.18) on your machine
2. Clone this project
3. Setup config.sh
    * HOST_NAME: Your domain name
    * MAINTAINER: Your email
4. Setup your telegram token in the end of django_project/telegram_bot/telegram_bot/settings.py
```
TELEGRAM_BOT_TOKEN = {
        'domain': '123456789',
}
```

5. Run init_all.sh
6. Run run_all.sh
7. Open your browser and go to web site with HOST_NAME

## Versioning

* v1.0.0
  * Init version

## Authors

* **AlenShiun** - *Initial work*

