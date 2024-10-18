Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADC455897
	for <linux-cxl@vger.kernel.org>; Fri, 18 Oct 2024 01:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729214993; cv=none; b=qClK1tfsDPYtXMrQn1UDeaAYck3JVeOz+fpkebt4MbKWc+XVsBx2z7PvkYv+7JGmkfXV02DA4NQM/xxjwOJfJMThsk912TiLzkN4P+/Ts65XqqV/ME83L/PEPWUrH/xyY2DkTTGPqPlUCZ9/a6uQNJfnz+AcaLS8PD2uoDBtyWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729214993; c=relaxed/simple;
	bh=+bBjc/9A+Ua5H7HXqJ8S16MXO9zhPZKhjHJsC2Pwv6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MCTRZn8ibfiITU2kI43E5k8wR++SH0xiV4Tg/v7Ngrxafn6Or/ProAcefEQiLSXvDIXH06F3NCQKAi6zDsYJTB9FFvQOoqYKAVSdj1VehQg9YPrptD6wU7Ww90++oQoNyaZcHWxE/jVVl9FFHU8DS5KXb6UPh+GhJPQuX9484dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Cv9wjU2I; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Cv9wjU2I"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1729214991; x=1760750991;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+bBjc/9A+Ua5H7HXqJ8S16MXO9zhPZKhjHJsC2Pwv6k=;
  b=Cv9wjU2I6dle09FlB/Ze/R2vDGxfhzIjgrS9SCIKo43/uvkGocJWiRpy
   KMlCloHHLAQmcR0bROYJL0yFQdwUSuvFITA2rFuWqDr3X05lTJnbq7hJK
   9x/ut509YvDUll2VF094s3wwXhBz84rU59J8JXvpZD3b25gsN3HpIcglL
   KXwcJpHNd/enDZvYmJ7rQoibB+HlMP/wL1pzeMBp6w/NAWLuEeXjq3mKW
   cgn4DrprhxyWAxh/bvrsTR12zYxQKeUoWyCqA9mQiw2KCd+EP8bNzFOaZ
   grG9JveSpIbOB5LLlj1qfkUbDQNwRQAIVZvb7K4DMwyXrzHPYFPB7NOYT
   w==;
X-CSE-ConnectionGUID: ECIWZSoCQOmSyfQP1/FCqA==
X-CSE-MsgGUID: NMJEbWPhSXCFeH7hVhzQWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="179323625"
X-IronPort-AV: E=Sophos;i="6.11,212,1725289200"; 
   d="scan'208";a="179323625"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 10:29:42 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 35748D4258
	for <linux-cxl@vger.kernel.org>; Fri, 18 Oct 2024 10:29:40 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 79700BF3DD
	for <linux-cxl@vger.kernel.org>; Fri, 18 Oct 2024 10:29:39 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0D144E51B8
	for <linux-cxl@vger.kernel.org>; Fri, 18 Oct 2024 10:29:39 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 811741A000B;
	Fri, 18 Oct 2024 09:29:38 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [ndctl PATCH v3 1/2] test/monitor.sh convert float to integer before increment
Date: Fri, 18 Oct 2024 09:30:19 +0800
Message-ID: <20241018013020.2523845-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
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
X-TMASE-Result: 10--2.069100-10.000000
X-TMASE-MatchedRID: 3VvmmxedNeKHYSb76u64f1hRyidsElYkGEGBUNvh8GASkNsdBvOYg2Uo
	D5JLGXzAnC7F+qVaTtq9Q4CDyJILGS7SL1WWCs3qEXjPIvKd74BMkOX0UoduueyufIOcfWGpo8W
	MkQWv6iUoTQl7wNH8Pg1fA1QHegDv3QfwsVk0UbvqwGfCk7KUswyi9UGnfc1kmVyPCbGrMTNYtm
	ygm+pbSYfEC2MAyNF/GZ/CA/4y894kJ8AODzlrRdx2pRgSEDDgM0G0VS1whvBTK7SumpFvNiHJp
	2UYVccqxOB8J0pRLhyJxKSZiwBX6QtRTXOqKmFVftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

The test log reported:
test/monitor.sh: line 149: 40.0: syntax error: invalid arithmetic operator (error token is ".0")

It does stop the test prematurely. We never run the temperature
inject test case of test_filter_dimmevent() because of the inability
to increment the float.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V3:
  split as a separate patch
---
 test/monitor.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/monitor.sh b/test/monitor.sh
index c5beb2c..7049b36 100755
--- a/test/monitor.sh
+++ b/test/monitor.sh
@@ -146,6 +146,7 @@ test_filter_dimmevent()
 	stop_monitor
 
 	inject_value=$($NDCTL list -H -d $monitor_dimms | jq -r .[]."health"."temperature_threshold")
+	inject_value=${inject_value%.*}
 	inject_value=$((inject_value + 1))
 	start_monitor "-d $monitor_dimms -D dimm-media-temperature"
 	inject_smart "-m $inject_value"
-- 
2.44.0

