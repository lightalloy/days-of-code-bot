*A Hackathon project, work in progress*

# Days of Code Telegram Bot

[Days of Code Telegram bot](https://t.me/days_of_code_bot) is a bot to conduct "N days of code challenges" in telegram chats.  
The challenges are inspired by the [100 days of code project](https://www.100daysofcode.com/)  

[Телеграм-бот](https://t.me/days_of_code_bot) для проведения марафонов "N days of code" в телеграм-чатах.  
Марафоны по мотивам проекта [100 дней кода](https://www.100daysofcode.com/)  

## Contributing

We are using [GitHub Issues](https://github.com/lightalloy/days-of-code-bot/issues) for our public bugs and features. If somebody claims an issue but doesn’t follow up for more than two weeks, it’s fine to take it over but you should still leave a comment.

If you send a pull request, do it against the master branch. For our branches we are using a scheme of (github issue key)-(desc/keyword), .e.g. ```34-blah_blah```. Also, please, reference the github issue key in the commit message and in the pull request name and description.

## Installation

#### Prerequisites
+ You have installed Ruby. Look for the required version in the file .ruby-version. You can use [rbenv](https://github.com/rbenv/rbenv) to pick a right version for this application.
+ You have installed [bundler](https://bundler.io/)

#### Development Workflow

1) After cloning days-of-code, run ```bundle install``` to fetch its dependencies. 

2) Create your own test bot (see instructions below).

3) Create postgres database, e.g. name it telegram_bot (see example below)

4) Set environment variables DATABASE_URL, BOT_TOKEN, CHAT_ID, DATE_START and DATE_END. If you use [rbenv](https://github.com/rbenv/rbenv) to manage Ruby versions, use [rbenv-vars](https://github.com/rbenv/rbenv-vars) to set the variables. Otherwise, you can edit .bash_profile, e.g.
`echo 'export DATABASE_URL="postgresql://localhost/telegram_bot?pool=5"' >> ~/.bash_profile`. This will execute it and add the path: `source ~/.bash_profile`.

5) To prevent problems with connection to Telegram API, before bot launch you need to start some preventing online restrictions tool.

You can launch the app in one of two ways:
1. ```bundle exec ruby bot_control.rb start``` (w/o console output)
2. ```bundle exec ruby bot.rb```

#### Creating your own test bot

Open Telegram, add bot [@BotPhaser](https://telegram.me/BotFather), and create a bot:
```
/start
/newbot
```
etc. Finally, you'll receive Your API-token from bot_father : XXXXXXXXX:YYYYYYY-YYYYYYYYYYYYYYYYY_YY. 
To get chat id you may do the following. On private chat with your bot, send a random message. You will search this message later. Then, on your browser make a request with url:

```https://api.telegram.org/botXXXXXXXXX:YYYYYYY-YYYYYYYYYYYYYYYYY_YY/getUpdates```

The request returns a json response, in json text search your random message and get chat id in that object.

#### Creating a database

```
psql postgres
create database telegram_bot;
```
There's also a need to run migrations:
```
bundle exec rake db:migrate
```
And optional seeds:
```
bundle exec ruby db/seeds.rb
```