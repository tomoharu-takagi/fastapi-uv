# Dockerfile
FROM python:3.10-slim

WORKDIR /app

# 必要なパッケージをインストール
RUN apt-get update && apt-get install -y curl \
    && apt-get install -y procps \
    && apt-get install -y tree

# uvのインストールとパスを設定
RUN curl -LsSf https://astral.sh/uv/install.sh | sh && \
    export PATH=$PATH:/root/.cargo/bin && \
    /root/.cargo/bin/uv --version \
    /root/.cargo/bin/uv sync

# 仮想環境をPATHに追加
ENV PATH="/app/.venv/bin:$PATH"

# ポートを開放
EXPOSE 8000

# アプリケーションを起動
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
