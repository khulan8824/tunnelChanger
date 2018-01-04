#!/bin/bash
file="servers.txt"
current_date_time=$(date '+%Y/%m/%d %H:%M')
i=0
while IFS= read -r proxy
	do
		echo 'c' $proxy >/var/run/xl2tpd/l2tp-control
		sleep 10s
		str=$current_date_time
		curl_out=$(curl -w %{time_starttransfer},%{time_total},%{http_code},%{size_download} http://ovh.net/files/1Mb.dat -o /dev/null --interface ppp$i -s)
		echo $i '>>>' $proxy
		echo $current_date_time','$curl_out>>$proxy"_1mb"
		i=$((i+1))
	done <"$file"
