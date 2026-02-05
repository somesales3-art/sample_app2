FROM ruby:3.2

# 1. 基本パッケージと依存関係
# LazyVimに必要な ripgrep, fd-find, git, gcc(build-essential) は必須
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs npm git curl bash-completion ripgrep fd-find wget unzip

# 2. Neovim Nightly (v0.11.0以上) をインストール
# LazyVimの最新版要件を満たすため、安定版ではなくNightlyを使用します
RUN wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz && \
    tar xzvf nvim-linux-x86_64.tar.gz && \
    mv nvim-linux-x86_64 /opt/nvim && \
    ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim && \
    rm nvim-linux-x86_64.tar.gz

# 3. LazyGit のインストール (LazyVimでのGit操作に必須級)
RUN LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') && \
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" && \
    tar xf lazygit.tar.gz lazygit && \
    install lazygit /usr/local/bin && \
    rm lazygit.tar.gz lazygit

# 4. Solargraph (Rubyの入力補完)
RUN gem install solargraph

# 5. Git設定とプロンプト (Starship)
RUN echo "source /usr/share/bash-completion/completions/git" >> ~/.bashrc
RUN curl -sS https://starship.rs/install.sh | sh -s -- -y
RUN echo 'eval "$(starship init bash)"' >> ~/.bashrc

# 6. 設定ディレクトリの準備
RUN mkdir -p /root/.config/nvim && \
    mkdir -p /root/.local/share/nvim && \
    mkdir -p /root/.local/state/nvim

# 7. アプリ設定
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
ENV LANG=ja_JP.UTF-8
ENV TZ=Asia/Tokyo
