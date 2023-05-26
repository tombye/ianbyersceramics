#! /bin/bash

npm install
npm run build
bundle install
bundle exec rake
bundle exec jekyll build
