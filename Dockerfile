FROM ruby:3.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs npm vim git curl bash-completion ripgrep
RUN echo "source /usr/share/bash-completion/completions/git" >> ~/.bashrc
RUN curl -fLo /root/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN vim +PlugInstall +qall
# 1. Node.js と npm をインストール（coc.nvim用）
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# 2. vim-plug（マネージャー）を自動インストール
RUN curl -fLo /root/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# 3. Solargraph（Ruby解析ツール）をインストール
RUN gem install solargraph
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
ENV LANG=ja_JP.UTF-8
ENV TZ=Asia/Tokyo
