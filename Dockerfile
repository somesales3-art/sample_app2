FROM ruby:3.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs vim git curl bash-completion
RUN echo "source /usr/share/bash-completion/completions/git" >> ~/.bashrc
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
ENV LANG=ja_JP.UTF-8
ENV TZ=Asia/Tokyo
