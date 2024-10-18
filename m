Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763D420E319
	for <linux-cxl@vger.kernel.org>; Fri, 18 Oct 2024 01:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729215056; cv=none; b=OXBfktWQjyyQipOGo5WzR4aQS3zjRhTeK7a5lj81+TgOqLU9/OJPi8QHVLo9YvMBJALC5+SoNUlcKdbvQ0SSSaFvINLZ/3jFwrVFtcyhuMSjzFsET8R9mAKnu1tzQuniqWO2vvr5LyUI9bEDcncM4ft1ig7HTsX/CXEAnOZf/Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729215056; c=relaxed/simple;
	bh=ARm9CdF/CqkuZrcM7QwN+wl9hZM+rn5ag6V2mqobYvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYuHj0Ea6CJ3TzqQkYan+GFwkATlw8CSghr01qvWt7BqKD8ziROxTcNHIKjcPR5bLHggjMjnn5PPyIj0apiaczSY0rIYFpTwHI8ZFh8jjOAKbIF7KPl5ar5umhH83UIc+TMgcLU1QEvoFe6IfgmyqIefIdnbyP/GeyXzIb5rGtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ESo6VFb8; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ESo6VFb8"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1729215055; x=1760751055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ARm9CdF/CqkuZrcM7QwN+wl9hZM+rn5ag6V2mqobYvg=;
  b=ESo6VFb86//KNygQj2rJtRDG3WErSvLLm11qYLYtNRWyj0hzNY1xWByI
   23tSqAumNMlaaaVEZMaL8+PSk7yqOnNBdF99Rx4gl3TgxKpHcA/MtsV2d
   V7DvN1bkqZfKOOIGK+/8YD+OfamN1Wua17ryvAHEsqyjoSpiZA7p+nzjr
   TASGBL9ZgtSRQ9Q5Z+VgEAv2kOoFbsTPGP6a09zWlxCoEhBcMcsc2PDGo
   tdmYyscAt/l5Y4HxnYp6fwud5/M8EIxugNnSEIp0cUB0RZFqt+3AwHOKd
   0YoXX8EWr8xDjHoXpRXwr8Q3Kwu1LiYBSSEgHo3h+vjmc5vbJqQ8rzy/b
   Q==;
X-CSE-ConnectionGUID: aVsk9WdTQQqeFrlGRO870w==
X-CSE-MsgGUID: dYfMc3MKTO2wjBewGy+o1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="177111195"
X-IronPort-AV: E=Sophos;i="6.11,212,1725289200"; 
   d="scan'208";a="177111195"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 10:29:43 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8B1F9CA1E3
	for <linux-cxl@vger.kernel.org>; Fri, 18 Oct 2024 10:29:40 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id BAEC9BF3E1
	for <linux-cxl@vger.kernel.org>; Fri, 18 Oct 2024 10:29:39 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 57F4D20079540
	for <linux-cxl@vger.kernel.org>; Fri, 18 Oct 2024 10:29:39 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id E486F1A01ED;
	Fri, 18 Oct 2024 09:29:38 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [ndctl PATCH v3 2/2] test/monitor.sh: Fix shellcheck SC2086 issues as more as possible
Date: Fri, 18 Oct 2024 09:30:20 +0800
Message-ID: <20241018013020.2523845-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241018013020.2523845-1-lizhijian@fujitsu.com>
References: <20241018013020.2523845-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28738.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28738.003
X-TMASE-Result: 10--10.532800-10.000000
X-TMASE-MatchedRID: GJWipKZ49enCS1NeCvs3qIdlc1JaOB1TqMXw4YFVmwhf/JRqlbLSV7Sn
	Jfu7KIKtEi5XEH00QubCsyZB1bKGqCqQO0zIUpyn8IK7yRWPRNEk2ugFoZn4tZE8TgOkbzEohEz
	I3+mkzifvPrWB/m7DX0y+rse8BOXw0hQoRxePIEGfrLSY2RbRpE3yuY9BGW8r9Iz2KSWO8hx7j+
	VBlZHsEjjiJ+c203Ms8vc3EUpCmrVzE1fI6N2sO0hwlOfYeSqxIm2Js0m7E8KhuT/MQ6uAV/qAD
	eqinEVf2cknzgMeAbs51K+dagOOz/XhWE12qWg+GYJhRh6sses4Ddbs3t0GCZ6fSoF3Lt+M5aE0
	pi4zt43jfe52KJUqfc/7jrKpSJx3HxPMjOKY7A8LbigRnpKlKSPzRlrdFGDwZbSJQ9f2HSlhgIr
	YE2VKa7ZEfCsCXb1sr/ygZ6K2Kn21GQ3EnYnJTA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

SC2086 [1], aka. Double quote to prevent globbing and word splitting.

Previously, SC2086 will cause error in [[]] or [], for example
$ grep -w line build/meson-logs/testlog.txt
test/monitor.sh: line 99: [: too many arguments
test/monitor.sh: line 99: [: nmem0: binary operator expected

Firstly,  generated diff by shellcheck tool:
$ shellcheck -i SC2086 -f diff test/monitor.sh

In addition, we have remove the double quote around $1 like below
changes. That's because when an empty "$1" passed to a command will open to ''
it would cause an error, for example
$ ndctl/build/test/list-smart-dimm -b nfit_test.0 ''
  Error: unknown parameter ""

-       $NDCTL monitor -c "$monitor_conf" -l "$logfile" "$1" &
+       $NDCTL monitor -c "$monitor_conf" -l "$logfile" $1 &

-       jlist=$("$TEST_PATH"/list-smart-dimm -b "$smart_supported_bus" "$1")
+       jlist=$("$TEST_PATH"/list-smart-dimm -b "$smart_supported_bus" $1)

-       $NDCTL inject-smart "$monitor_dimms" "$1"
+       $NDCTL inject-smart "$monitor_dimms" $1

-       [[ $1 == $notify_dimms ]]
+       [[ "$1" == "$notify_dimms" ]]

-               [ ! -z "$monitor_dimms" ] && break
+               [[ "$monitor_dimms" ]] && break

[1] https://www.shellcheck.net/wiki/SC2086
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
`shellcheck -i SC2086 -f diff test/*.sh | patch -p1` can auto correct some
remaining SC2086 issues, however we can find it still miss some
patterns and some changes will break the origial test.

V3:
  - Fix SC2086 issues as more as possible # Alison
  - covert [ ! -z $foo ] to [[  "foo" ]] as Vishal's suggestion.
V1:
 V1 has a mistake which overts to integer too late.
 Move the conversion forward before the operation
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 test/monitor.sh | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/test/monitor.sh b/test/monitor.sh
index 7049b36..be8e24d 100755
--- a/test/monitor.sh
+++ b/test/monitor.sh
@@ -11,7 +11,7 @@ monitor_regions=""
 monitor_namespace=""
 smart_supported_bus=""
 
-. $(dirname $0)/common
+. $(dirname "$0")/common
 
 monitor_conf="$TEST_PATH/../ndctl"
 
@@ -24,51 +24,51 @@ check_min_kver "4.15" || do_skip "kernel $KVER may not support monitor service"
 start_monitor()
 {
 	logfile=$(mktemp)
-	$NDCTL monitor -c "$monitor_conf" -l $logfile $1 &
+	$NDCTL monitor -c "$monitor_conf" -l "$logfile" $1 &
 	monitor_pid=$!
 	sync; sleep 3
-	truncate --size 0 $logfile #remove startup log
+	truncate --size 0 "$logfile" #remove startup log
 }
 
 set_smart_supported_bus()
 {
 	smart_supported_bus=$NFIT_TEST_BUS0
-	monitor_dimms=$($TEST_PATH/list-smart-dimm -b $smart_supported_bus | jq -r .[0].dev)
-	if [ -z $monitor_dimms ]; then
+	monitor_dimms=$("$TEST_PATH"/list-smart-dimm -b "$smart_supported_bus" | jq -r .[0].dev)
+	if [ -z "$monitor_dimms" ]; then
 		smart_supported_bus=$NFIT_TEST_BUS1
 	fi
 }
 
 get_monitor_dimm()
 {
-	jlist=$($TEST_PATH/list-smart-dimm -b $smart_supported_bus $1)
-	monitor_dimms=$(jq '.[]."dev"?, ."dev"?' <<<$jlist | sort | uniq | xargs)
-	echo $monitor_dimms
+	jlist=$("$TEST_PATH"/list-smart-dimm -b "$smart_supported_bus" $1)
+	monitor_dimms=$(jq '.[]."dev"?, ."dev"?' <<<"$jlist" | sort | uniq | xargs)
+	echo "$monitor_dimms"
 }
 
 call_notify()
 {
-	$TEST_PATH/smart-notify $smart_supported_bus
+	"$TEST_PATH"/smart-notify "$smart_supported_bus"
 	sync; sleep 3
 }
 
 inject_smart()
 {
-	$NDCTL inject-smart $monitor_dimms $1
+	$NDCTL inject-smart "$monitor_dimms" $1
 	sync; sleep 3
 }
 
 check_result()
 {
-	jlog=$(cat $logfile)
-	notify_dimms=$(jq ."dimm"."dev" <<<$jlog | sort | uniq | xargs)
-	[[ $1 == $notify_dimms ]]
+	jlog=$(cat "$logfile")
+	notify_dimms=$(jq ."dimm"."dev" <<<"$jlog" | sort | uniq | xargs)
+	[[ "$1" == "$notify_dimms" ]]
 }
 
 stop_monitor()
 {
 	kill $monitor_pid
-	rm $logfile
+	rm "$logfile"
 }
 
 test_filter_dimm()
@@ -91,12 +91,12 @@ test_filter_bus()
 
 test_filter_region()
 {
-	count=$($NDCTL list -R -b $smart_supported_bus | jq -r .[].dev | wc -l)
+	count=$($NDCTL list -R -b "$smart_supported_bus" | jq -r .[].dev | wc -l)
 	i=0
-	while [ $i -lt $count ]; do
-		monitor_region=$($NDCTL list -R -b $smart_supported_bus | jq -r .[$i].dev)
+	while [ $i -lt "$count" ]; do
+		monitor_region=$($NDCTL list -R -b "$smart_supported_bus" | jq -r .[$i].dev)
 		monitor_dimms=$(get_monitor_dimm "-r $monitor_region")
-		[ ! -z $monitor_dimms ] && break
+		[[ "$monitor_dimms" ]] && break
 		i=$((i + 1))
 	done
 	start_monitor "-r $monitor_region"
@@ -108,25 +108,25 @@ test_filter_region()
 test_filter_namespace()
 {
 	reset
-	monitor_namespace=$($NDCTL create-namespace -b $smart_supported_bus | jq -r .dev)
+	monitor_namespace=$($NDCTL create-namespace -b "$smart_supported_bus" | jq -r .dev)
 	monitor_dimms=$(get_monitor_dimm "-n $monitor_namespace")
 	start_monitor "-n $monitor_namespace"
 	call_notify
 	check_result "$monitor_dimms"
 	stop_monitor
-	$NDCTL destroy-namespace $monitor_namespace -f
+	$NDCTL destroy-namespace "$monitor_namespace" -f
 }
 
 test_conf_file()
 {
 	monitor_dimms=$(get_monitor_dimm)
 	conf_file=$(mktemp)
-	echo -e "[monitor]\ndimm = $monitor_dimms" > $conf_file
+	echo -e "[monitor]\ndimm = $monitor_dimms" > "$conf_file"
 	start_monitor "-c $conf_file"
 	call_notify
 	check_result "$monitor_dimms"
 	stop_monitor
-	rm $conf_file
+	rm "$conf_file"
 }
 
 test_filter_dimmevent()
@@ -138,14 +138,14 @@ test_filter_dimmevent()
 	check_result "$monitor_dimms"
 	stop_monitor
 
-	inject_value=$($NDCTL list -H -d $monitor_dimms | jq -r .[]."health"."spares_threshold")
+	inject_value=$($NDCTL list -H -d "$monitor_dimms" | jq -r .[]."health"."spares_threshold")
 	inject_value=$((inject_value - 1))
 	start_monitor "-d $monitor_dimms -D dimm-spares-remaining"
 	inject_smart "-s $inject_value"
 	check_result "$monitor_dimms"
 	stop_monitor
 
-	inject_value=$($NDCTL list -H -d $monitor_dimms | jq -r .[]."health"."temperature_threshold")
+	inject_value=$($NDCTL list -H -d "$monitor_dimms" | jq -r .[]."health"."temperature_threshold")
 	inject_value=${inject_value%.*}
 	inject_value=$((inject_value + 1))
 	start_monitor "-d $monitor_dimms -D dimm-media-temperature"
-- 
2.44.0

