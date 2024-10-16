Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD67318BB89
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 05:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729056011; cv=none; b=dd6KRbaHT6hVUFKxb+Lo5LbnJZ42VQqb67HW0fasoH5PrAGEzGObVIIDLeA0/dZ/QxdOXPIwuzerJjzCpohsIHVXiOevf3FvP2yM4/Uf58VY51sgIQ3kVDSo1W8zAKAdua4ejehmyj/1iw/fcTk/sCiLmuypHqXxTdPgd9mX5Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729056011; c=relaxed/simple;
	bh=US0KrVY0H253GsJ/oNTaz94B+uCAfaIggGiaDG52g3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m/Ls+vb8nDKx5nEN5x13slQCd01CcBB+DKatUPqNLqMJw6FaL9mr1QqZPMyOCgsqx0zk2C3cftvtfEa2Kvv2Y0S7LF8162f7DukmdP1oCz1vA0EwtSxNwNnVa0aeqlvVwLmKQHFIzSmVZXx/lQFHeOMmTqsH8PqbOJlycgsapUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=W9CVRZ/n; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="W9CVRZ/n"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1729056009; x=1760592009;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=US0KrVY0H253GsJ/oNTaz94B+uCAfaIggGiaDG52g3Y=;
  b=W9CVRZ/nswEfQGaXvIL9eB/gQ5BuETikBgxo/qyFfz2z0r2KIrduYvbJ
   7ZFOx8SIhGNhU+3vdb5R9w1LxqWqcE4p8wkGJ9GGOct5TGsAZ8b3vPqvF
   CLd9cSHvWqQp/QfhdcyKYkuvHGj+pVXeibhwutNtnRFdIBXmJmmg98llK
   Zmc6OG5OuaS754gj1Nli6SEOCULOi70LPc0izZRnQDUWvhNk5aH5U6vdR
   DNYhJHwgT9028D/aReKV4eBfq6XCQwPmPTpnq4mdI0k0vsdR3pdcN4j/s
   nEYq3r149bfgyZvERDHoHlYGDBUO3SJWJOlyU/nW6nPYJrTfL+jeiRxab
   Q==;
X-CSE-ConnectionGUID: z1b6p+//TAGArtSHPhItRw==
X-CSE-MsgGUID: Q0VQx853STSvp/MYUP0wWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="155882336"
X-IronPort-AV: E=Sophos;i="6.11,207,1725289200"; 
   d="scan'208";a="155882336"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 14:20:06 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 4ED12D800A
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 14:20:04 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8ABF8D5620
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 14:20:03 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 16D7A6BB78
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 14:20:03 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 831A91A000B;
	Wed, 16 Oct 2024 13:20:02 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [ndctl PATCH v2] test/monitor.sh: Fix 2 bash syntax errors
Date: Wed, 16 Oct 2024 13:20:42 +0800
Message-ID: <20241016052042.1138320-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28734.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28734.005
X-TMASE-Result: 10-0.278600-10.000000
X-TMASE-MatchedRID: gjTnMpchYR/CS1NeCvs3qIdlc1JaOB1TqMXw4YFVmwiWMZBmiy+fzzl3
	2fTh8s1mPs0ZDS8itpdeWwXKQGp3JCcNcfWMW/afw4LlAWtyEiXBOVz0Jwcxl6vCrG0TnfVUaUX
	s6FguVy23nQMqHp+dH2MemTaDph9uqMLr8w1TE6ieAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8hxKp
	vEGAbTDmXUYAnSw7hChR4K5GmDTtRelnaq7H5DTFp+ztYfZqvoDLWp4mjyrgt8nqY8dd6X+OQBp
	EbE4HbrBmfMMLI1tsvn2PiK2+nx41uMG6V02+QySir3tZId0WN+6klq53W5kJ9Gzq4huQVX
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

$ grep -w line build/meson-logs/testlog.txt
test/monitor.sh: line 99: [: too many arguments
test/monitor.sh: line 99: [: nmem0: binary operator expected
test/monitor.sh: line 149: 40.0: syntax error: invalid arithmetic operator (error token is ".0")

- monitor_dimms could be a string with multiple *spaces*, like: "nmem0 nmem1 nmem2"
- inject_value is a float value, like 40.0, which need to be converted to
  integer before operation: $((inject_value + 1))

Some features have not been really verified due to these errors

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V1:
 V1 has a mistake which overts to integer too late.
 Move the conversion forward before the operation
---
 test/monitor.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/test/monitor.sh b/test/monitor.sh
index c5beb2c..7809a7c 100755
--- a/test/monitor.sh
+++ b/test/monitor.sh
@@ -96,7 +96,7 @@ test_filter_region()
 	while [ $i -lt $count ]; do
 		monitor_region=$($NDCTL list -R -b $smart_supported_bus | jq -r .[$i].dev)
 		monitor_dimms=$(get_monitor_dimm "-r $monitor_region")
-		[ ! -z $monitor_dimms ] && break
+		[ ! -z "$monitor_dimms" ] && break
 		i=$((i + 1))
 	done
 	start_monitor "-r $monitor_region"
@@ -146,6 +146,7 @@ test_filter_dimmevent()
 	stop_monitor
 
 	inject_value=$($NDCTL list -H -d $monitor_dimms | jq -r .[]."health"."temperature_threshold")
+	inject_value=${inject_value%.*}
 	inject_value=$((inject_value + 1))
 	start_monitor "-d $monitor_dimms -D dimm-media-temperature"
 	inject_smart "-m $inject_value"
-- 
2.44.0

