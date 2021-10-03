#! /bin/bash

npm install
npm run build
bundle exec rake
bundle exec jekyll build
