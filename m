Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Nov 2023 18:32:25 PST
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98CABC
	for <linux-cxl@vger.kernel.org>; Wed, 22 Nov 2023 18:32:25 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="140098755"
X-IronPort-AV: E=Sophos;i="6.04,220,1695654000"; 
   d="scan'208";a="140098755"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 11:31:21 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 070B8D6477
	for <linux-cxl@vger.kernel.org>; Thu, 23 Nov 2023 11:31:18 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 43DED14043
	for <linux-cxl@vger.kernel.org>; Thu, 23 Nov 2023 11:31:17 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id DE5FB200649DF
	for <linux-cxl@vger.kernel.org>; Thu, 23 Nov 2023 11:31:16 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 818C81A0073;
	Thu, 23 Nov 2023 10:31:16 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [ndctl PATCH 3/3] test/cxl-region-sysfs.sh: Fix cxl-region-sysfs.sh: line 107: [: missing `]'
Date: Thu, 23 Nov 2023 10:30:58 +0800
Message-ID: <20231123023058.2963551-3-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--6.831200-10.000000
X-TMASE-MatchedRID: I1wtkSt6/wI5rof3b4z0VE7nLUqYrlslFIuBIWrdOePfUZT83lbkEKem
	Jq66qqv9/MknKdGiL9PaDF6lH4tpMDcpdZ3fQiLdFEUknJ/kEl5jFT88f69nG/oLR4+zsDTtjoc
	zmuoPCq1JvtyeL2z47tQ4zW8zUpL09NWfq1XGzZF9miTv83Zrt+CntM51Lyyy
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 test/cxl-region-sysfs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/cxl-region-sysfs.sh b/test/cxl-region-sysfs.sh
index 89f21a3..3878351 100644
--- a/test/cxl-region-sysfs.sh
+++ b/test/cxl-region-sysfs.sh
@@ -104,7 +104,7 @@ do
 	iw=$(cat /sys/bus/cxl/devices/$i/interleave_ways)
 	ig=$(cat /sys/bus/cxl/devices/$i/interleave_granularity)
 	[ $iw -ne $nr_targets ] && err "$LINENO: decoder: $i iw: $iw targets: $nr_targets"
-	[ $ig -ne $r_ig] && err "$LINENO: decoder: $i ig: $ig root ig: $r_ig"
+	[ $ig -ne $r_ig ] && err "$LINENO: decoder: $i ig: $ig root ig: $r_ig"
 
 	sz=$(cat /sys/bus/cxl/devices/$i/size)
 	res=$(cat /sys/bus/cxl/devices/$i/start)
-- 
2.41.0

