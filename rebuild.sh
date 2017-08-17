#!/usr/bin/env bash
echo "Rebuilding Satis..."
touch code/satis.json
php /root/satis/bin/satis build /root/satis/satis.json /root/satis/packages
docker build -t satis:latest . && \
docker stop satis && \
docker rm satis && \
docker run --name satis -d --expose 80 -e VIRTUAL_HOST=composer.tools.studionone.io satis
echo "Done"
