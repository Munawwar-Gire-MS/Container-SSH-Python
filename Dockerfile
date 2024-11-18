FROM python:3.10-slim
WORKDIR /app/

COPY requirements.txt ./
RUN pip install -r requirements.txt
COPY . /app/
COPY init_container.sh /app/init_container.sh

COPY sshd_config /etc/ssh/

# Start and enable SSH
RUN apt-get update \
    && apt-get install -y --no-install-recommends dialog \
    && apt-get install -y --no-install-recommends openssh-server \
    && echo "root:Docker!" | chpasswd \
    && chmod 777 /app/init_container.sh
    

EXPOSE 8000 2222

ENTRYPOINT [ "/app/init_container.sh" ] 