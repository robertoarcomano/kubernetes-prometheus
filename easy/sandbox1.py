from prometheus_client import Counter
import time
my_counter1 = Counter('my_counter1', 'My counter')
while True:
    my_counter1.inc()
    print(my_counter1)
    time.sleep(1)