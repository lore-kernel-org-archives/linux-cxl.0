Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281A41B3
	for <linux-cxl@vger.kernel.org>; Wed, 22 Nov 2023 18:31:22 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="140654054"
X-IronPort-AV: E=Sophos;i="6.04,220,1695654000"; 
   d="scan'208";a="140654054"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 11:31:21 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id CC07FD6189
	for <linux-cxl@vger.kernel.org>; Thu, 23 Nov 2023 11:31:17 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0B89CF915
	for <linux-cxl@vger.kernel.org>; Thu, 23 Nov 2023 11:31:17 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id A6D51200649DF
	for <linux-cxl@vger.kernel.org>; Thu, 23 Nov 2023 11:31:16 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 4F48E1A0071;
	Thu, 23 Nov 2023 10:31:16 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [ndctl PATCH 2/3] test/cxl-region-sysfs.sh: use operator '!=' to compare hexadecimal value
Date: Thu, 23 Nov 2023 10:30:57 +0800
Message-ID: <20231123023058.2963551-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123023058.2963551-1-lizhijian@fujitsu.com>
References: <20231123023058.2963551-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28014.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28014.004
X-TMASE-Result: 10--8.353400-10.000000
X-TMASE-MatchedRID: /2NGPvLZz+PDmO1DJUuxWVRF81tbZq+Ql9q75JzWJRNM+b8yxBqvA78F
	Hrw7frluf146W0iUu2uHLV03CrWr2cVM5J3Ud/0Uzr16YOzjZ10CtGYG0znilEty8cifGH0Uqzl
	QyGeIJ2Xi8zVgXoAltuJ5hXsnxp7jC24oEZ6SpSkj80Za3RRg8IU0y08TmYjc55tJ6KD5Hlpawv
	BGQOevA0Lbc95R1vNyGSCvLi0tcps=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Fix errors:
line 111: [: 0x80000000: integer expression expected
line 112: [: 0x3ff110000000: integer expression expected
line 141: [: 0x80000000: integer expression expected
line 143: [: 0x3ff110000000: integer expression expected

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 test/cxl-region-sysfs.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/test/cxl-region-sysfs.sh b/test/cxl-region-sysfs.sh
index ded7aa1..89f21a3 100644
--- a/test/cxl-region-sysfs.sh
+++ b/test/cxl-region-sysfs.sh
@@ -108,8 +108,8 @@ do
 
 	sz=$(cat /sys/bus/cxl/devices/$i/size)
 	res=$(cat /sys/bus/cxl/devices/$i/start)
-	[ $sz -ne $region_size ] && err "$LINENO: decoder: $i sz: $sz region_size: $region_size"
-	[ $res -ne $region_base ] && err "$LINENO: decoder: $i base: $res region_base: $region_base"
+	[ "$sz" != "$region_size" ] && err "$LINENO: decoder: $i sz: $sz region_size: $region_size"
+	[ "$res" != "$region_base" ] && err "$LINENO: decoder: $i base: $res region_base: $region_base"
 done
 
 # validate all switch decoders have the correct settings
@@ -143,9 +143,9 @@ do
 
 	res=$(decimal_to_hex $(echo $decoder | jq -r ".resource"))
 	sz=$(decimal_to_hex $(echo $decoder | jq -r ".size"))
-	[ $sz -ne $region_size ] && err \
+	[ "$sz" != "$region_size" ] && err \
 	"$LINENO: decoder: $i sz: $sz region_size: $region_size"
-	[ $res -ne $region_base ] && err \
+	[ "$res" != "$region_base" ] && err \
 	"$LINENO: decoder: $i base: $res region_base: $region_base"
 done
 
-- 
2.41.0

