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
        'domain': 'YOUR TELEGRAM BOT TOKEN HERE',
}
```

5. Run init_all.sh
6. Run run_all.sh
7. Open your browser and go to web site with HOST_NAME, You may see a error page that can NOT parse JSON, ignore this error!
8. Open your telegram and talk with your bot
```
You
  /d github.com
Bot
  Domain: github.com
  140.82.113.3
```

## Versioning

* v1.0.0
  * Init version

## Authors

* **AlenShiun** - *Initial work*

