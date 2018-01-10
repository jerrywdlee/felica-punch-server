# Felica Punch Server
Demo Server of [Felica Punch](https://github.com/jerrywdlee/felica-punch)

# Deploy to heroku
```
git clone https://github.com/jerrywdlee/felica-punch-server.git YOUR_APP_NAME
cd YOUR_APP_NAME

heroku login
heroku create YOUR_APP_NAME
heroku buildpacks:add https://github.com/jerrywdlee/heroku-buildpack-ruby.git
heroku buildpacks:add heroku/nodejs
heroku addons:create heroku-postgresql:hobby-dev

heroku config:add TZ=Asia/Tokyo
# add IP_ALLOW (reject other), use ',' add more, see https://github.com/olstenlarck/koa-ip-filter
heroku config:add IP_ALLOW=192.168.3.86,172.x.xx.x

git push heroku master
heroku run rake db:migrate
```

# Set up

1. Open site by Heroku Dashboard, find the Url(Like https://YOUR_APP_NAME.herokuapp.com/) Add the Url to device's `conf.yml`.
2. Visit https://YOUR_APP_NAME.herokuapp.com/devices, add new device, set `Device uid` to device's `conf.yml`.
3. Visit https://YOUR_APP_NAME.herokuapp.com/users, add new user, then click `New Card` to add card.
4. In `New Card` page, place the card in front of the reader, then Card ID will added automatically.

