from prometheus_client import start_http_server, Gauge
import time
import os
import subprocess
import re

PORT = 8000
speed = Gauge('hdparm', 'Hard Disk Performance')
SECONDS = 60


def get_speed(input):
    return \
        re.findall("[0-9]+.[0-9]+",
        input.
        stdout.
        decode("utf-8")) \
        [-1]


if __name__ == '__main__':
    start_http_server(PORT)
    while True:
        output = subprocess.run(["sudo", "hdparm", "-t", "/dev/sda"], capture_output=True)
        speed.set(get_speed(output))
        time.sleep(SECONDS)
