FROM python:3.8-slim

# 设置工作目录
WORKDIR /app

# 设置环境变量
ENV PYTHONUNBUFFERED=1

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# 首先只复制 requirements.txt
COPY requirements.txt ./

# 安装Python依赖
RUN pip install --no-cache-dir -r requirements.txt

# 创建必要的目录
RUN mkdir -p /app/services /app/apps /app/core /tmp

# 复制项目文件
COPY services/ ./services/
COPY apps/ ./apps/
COPY core/ ./core/
COPY site-bot.py ./

# 确保目录权限正确
RUN chmod -R 755 /app && \
    chmod -R 777 /tmp

# 设置启动命令
CMD ["python", "site-bot.py"] 