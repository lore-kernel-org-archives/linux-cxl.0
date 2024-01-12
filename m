Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5085B5D8
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jan 2024 06:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="124708289"
X-IronPort-AV: E=Sophos;i="6.04,188,1695654000"; 
   d="scan'208";a="124708289"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 15:27:14 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0AF46CD6C7
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jan 2024 15:27:12 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 4BF11D67AD
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jan 2024 15:27:11 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id D855F200989FB
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jan 2024 15:27:10 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 349761A0070;
	Fri, 12 Jan 2024 14:27:10 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/core: use sysfs_emit() for attr's _show()
Date: Fri, 12 Jan 2024 14:27:09 +0800
Message-Id: <20240112062709.2490947-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28114.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28114.005
X-TMASE-Result: 10--2.834700-10.000000
X-TMASE-MatchedRID: 5rkJ48FE5MzZ+HKC8eTMak7nLUqYrlslFIuBIWrdOeOjEIt+uIPPOOWs
	WsO3yC+RZtDa42fsjEN0CabJqrYNnB8TzIzimOwPlpYqKNmWxsHZs3HUcS/scCq2rl3dzGQ1XUB
	SXduZ9O7h/Cxbl++FlToCb6I4Tl5YoOoc79uuBhs75tuZwLS74H5KIQES6nKmDfTS0q6f4dKtxF
	yiY+8Om2GrQMK2XG5zGIoA/ljtOSEVxRB/din+uJ07T8ZSLiAVvR84/OmB1wQp4n8eQBnwiw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

sprintf() is deprecated for sysfs, use preferred sysfs_emit() instead.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/cxl/core/memdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 2f43d368ba07..dae8802ecdb0 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -114,7 +114,7 @@ static DEVICE_ATTR_RO(serial);
 static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
-	return sprintf(buf, "%d\n", dev_to_node(dev));
+	return sysfs_emit(buf, "%d\n", dev_to_node(dev));
 }
 static DEVICE_ATTR_RO(numa_node);
 
-- 
2.34.1

