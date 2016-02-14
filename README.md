# Docker JMeter 2.13 with plugins 1.2.0 for non-gui use

# jmeter.sh -Djava.rmi.server.hostname=127.0.0.1
# ssh -L 55501:127.0.0.1:55501 -L 55511:127.0.0.1:55511 -R 55512:127.0.0.1:55512 -p 60000 root@52.29.50.70
# sudo docker run --rm -ti -p 60000:22 XXXXXX

## Contains

* JMeter 2.13
* JMeterPlugins-Standard 1.2.0
* JMeterPlugins-Extras 1.2.0
* JMeterPlugins-ExtrasLibs 1.2.0
* user.properties


### Usage for child layer

  FROM rdpanek/jmeter:1.0

### Build
  `git clone https://github.com/rdpanek/docker_jmeter`

  `make build`

### run test
  `make test testPlan.jmx`

### output

#### testPlan.jmx.jtl (csv)
```
timeStamp;elapsed;label;responseCode;threadName;success;bytes;grpThreads;allThreads;Latency;SampleCount;ErrorCount;IdleTime
22:59:55;889;HTTP Request;200;threads 1-1;true;2884;10;10;889;1;0;0
22:59:55;1205;HTTP Request;200;threads 1-3;true;2884;10;10;1195;1;0;0
22:59:55;1201;HTTP Request;200;threads 1-5;true;2884;10;10;1201;1;0;0
22:59:55;1249;HTTP Request;200;threads 1-2;true;2884;10;10;1245;1;0;0
22:59:55;1260;HTTP Request;200;threads 1-4;true;2884;10;10;1251;1;0;0
```

#### testPlan.jmx.log
```
2014/11/18 22:59:57 INFO  - jmeter.threads.JMeterThread: Thread finished: threads 1-3
2014/11/18 22:59:58 INFO  - jmeter.threads.JMeterThread: Stopping because end time detected by thread: threads 1-5
2014/11/18 22:59:58 INFO  - jmeter.threads.JMeterThread: Thread finished: threads 1-5
2014/11/18 22:59:58 INFO  - jmeter.threads.JMeterThread: Stopping because end time detected by thread: threads 1-6
2014/11/18 22:59:58 INFO  - jmeter.threads.JMeterThread: Thread finished: threads 1-6
```

## Changelog
**7 October 2015** tag 1.0
- Updated JMeter 2.13
