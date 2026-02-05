FROM ruby:3.2

# 1. 基本パッケージと依存関係のインストール
# neovimのプラグインでビルドが必要な場合があるため build-essential 等を入れる
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs npm git curl bash-completion ripgrep fd-find wget unzip

# 2. 最新のNeovimをインストール (aptのneovimは古いためGitHubから取得)
# Neovim v0.10.4 (ファイル名が nvim-linux-x86_64 に変更されています)
RUN wget https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.tar.gz && \
    tar xzvf nvim-linux-x86_64.tar.gz && \
    mv nvim-linux-x86_64 /opt/nvim && \
    ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim && \
    rm nvim-linux-x86_64.tar.gz
# 3. Solargraph (Rubyの入力補完サーバー) のインストール
RUN gem install solargraph

# 4. Git設定とプロンプト (Starship)
RUN echo "source /usr/share/bash-completion/completions/git" >> ~/.bashrc
RUN curl -sS https://starship.rs/install.sh | sh -s -- -y
RUN echo 'eval "$(starship init bash)"' >> ~/.bashrc

# 5. Neovimの設定ディレクトリを作成
RUN mkdir -p /root/.config/nvim

# 6. アプリ設定
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
ENV LANG=ja_JP.UTF-8
ENV TZ=Asia/Tokyo

# 注意: 設定ファイル(init.lua)はコンテナ内にCOPYせず、
# docker-compose.yml でバインドマウント（同期）するのがおすすめです。
