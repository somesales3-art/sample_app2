FROM ruby:3.2

# 1. 基本パッケージと日本語環境の設定
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs npm git curl bash-completion ripgrep fd-find wget unzip locales && \
    locale-gen ja_JP.UTF-8

# 環境変数の設定
ENV LANG=ja_JP.UTF-8
ENV LC_ALL=ja_JP.UTF-8
ENV TZ=Asia/Tokyo

# 2. Neovim Nightly のインストール
RUN wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz && \
    tar xzvf nvim-linux-x86_64.tar.gz && \
    mv nvim-linux-x86_64 /opt/nvim && \
    ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim && \
    rm nvim-linux-x86_64.tar.gz

# 3. LazyGit のインストール
RUN LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') && \
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" && \
    tar xf lazygit.tar.gz lazygit && \
    install lazygit /usr/local/bin && \
    rm lazygit.tar.gz lazygit

# 4. Solargraph (Rubyの補完用)
RUN gem install solargraph

# 5. Starship プロンプト
RUN curl -sS https://starship.rs/install.sh | sh -s -- -y && \
    echo 'eval "$(starship init bash)"' >> ~/.bashrc

# 6. 設定ディレクトリの作成
RUN mkdir -p /root/.config/nvim /root/.local/share/nvim /root/.local/state/nvim
COPY nvim/ /root/.config/nvim/

WORKDIR /app
COPY Gemfile Gemfile.lock /app/
