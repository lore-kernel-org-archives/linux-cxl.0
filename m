Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B076DF44
	for <linux-cxl@vger.kernel.org>; Thu,  6 Jun 2024 07:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717659938; cv=none; b=K75SW7bnG55H+87/kcJbRF3+H1jXjpa0QXHU8BiVjznqXjQkYaiHGwRjQ7d5HO3Vwwl9uZKBZFGBhfk5DuXyeU4LEKrfL+qwnv13k8AcKL8gPijn8Xf6BgcCJYkeRVKRWhjTOT9MLhmbAsS0gVePOc8UW4zLFfqqcGOrDtMYRE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717659938; c=relaxed/simple;
	bh=nSpbOiG6hqdYnjKEomyG7e6deBOg7abrkHKdQcVtVHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXp5OcqwuhReQ7ZK0BhsjhaUJOABjn8HSk1qy5AXOfahsXVAKyI3B5C2wGSkJP/7g7+5AgbZfd25tzvf1snu98XN1sr/QEkKFRKfhe6hDHDY/rCLLxmqBGZQQvUhR8gXZz0lbdBZpZxk7tvvQZqzilkpLWAshD0Hhf7L4ntQnII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=WIbeFmd+; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="WIbeFmd+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1717659935; x=1749195935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nSpbOiG6hqdYnjKEomyG7e6deBOg7abrkHKdQcVtVHI=;
  b=WIbeFmd+c3DKd6diXC9nwpq9pG0V/hrRCfFr7sP96+EkKck58B2FphWT
   AGRmezea485fx5Pe83WOEqWPLNag8omvnrFEu/b2X/QbUjxo7oeJqkCXe
   s257kZIUAVeocKpnMQkwFGe2KCcg12V5Y768lcg/TQGzdv3cqehawRGMa
   GxP+uqqbMdXTTNPd8r3MzEvQUubOsS/Uc846CMZOyCFoT71jlY+kGimvD
   JFGIy/wmcBlVaPoEOPQ34Bno4zRfh8DX/NqmD7ozlUvz40fnakBFmhNjt
   bpVoYhZaPziNNIUGrM4zUzKUGTWcgkrEaLtvg/OlAVWKo3gwfYQEVpJ9d
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="161392057"
X-IronPort-AV: E=Sophos;i="6.08,218,1712588400"; 
   d="scan'208";a="161392057"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 16:45:32 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 02638D800F
	for <linux-cxl@vger.kernel.org>; Thu,  6 Jun 2024 16:45:30 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 346A0BF3FC
	for <linux-cxl@vger.kernel.org>; Thu,  6 Jun 2024 16:45:29 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id EB810204E1BC;
	Thu,  6 Jun 2024 16:45:28 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	jonathan.cameron@huawei.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v8 1/2] cxl/core/regs: Add rcd_pcie_cap initialization at __rcrb_to_component()
Date: Thu,  6 Jun 2024 16:48:13 +0900
Message-ID: <20240606074814.5633-2-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240606074814.5633-1-kobayashi.da-06@fujitsu.com>
References: <20240606074814.5633-1-kobayashi.da-06@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00

Add rcd_pcie_cap and its initialization at __rcrb_to_component() to cache
the offset of cxl1.1 device link status information. By caching it, avoid 
the walking memory map area to find the offset when output the register value.

Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>

---
 drivers/cxl/core/core.h |  4 ++++
 drivers/cxl/core/regs.c | 13 +++++++++++++
 drivers/cxl/cxl.h       |  1 +
 3 files changed, 18 insertions(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 3b64fb1b9ed0..42e3483b4a14 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -75,6 +75,10 @@ resource_size_t __rcrb_to_component(struct device *dev,
 				    enum cxl_rcrb which);
 u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
 
+#define PCI_RCRB_CAP_LIST_ID_MASK	GENMASK(7, 0)
+#define PCI_RCRB_CAP_HDR_ID_MASK	GENMASK(7, 0)
+#define PCI_RCRB_CAP_HDR_NEXT_MASK	GENMASK(15, 8)
+
 extern struct rw_semaphore cxl_dpa_rwsem;
 extern struct rw_semaphore cxl_region_rwsem;
 
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 372786f80955..3e64b49f74ed 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -514,6 +514,8 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
 	u32 bar0, bar1;
 	u16 cmd;
 	u32 id;
+	u16 offset;
+	u32 cap_hdr;
 
 	if (which == CXL_RCRB_UPSTREAM)
 		rcrb += SZ_4K;
@@ -537,6 +539,17 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
 	cmd = readw(addr + PCI_COMMAND);
 	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
 	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
+	offset = FIELD_GET(PCI_RCRB_CAP_LIST_ID_MASK, readw(addr + PCI_CAPABILITY_LIST));
+	cap_hdr = readl(addr + offset);
+	while ((FIELD_GET(PCI_RCRB_CAP_HDR_ID_MASK, cap_hdr)) != PCI_CAP_ID_EXP) {
+		offset = FIELD_GET(PCI_RCRB_CAP_HDR_NEXT_MASK, cap_hdr);
+		if (offset == 0 || offset > SZ_4K)
+			break;
+		cap_hdr = readl(addr + offset);
+	}
+	if (offset)
+		ri->rcd_pcie_cap = offset;
+
 	iounmap(addr);
 	release_mem_region(rcrb, SZ_4K);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 003feebab79b..40396e2c4bae 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -646,6 +646,7 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
 
 struct cxl_rcrb_info {
 	resource_size_t base;
+	u16 rcd_pcie_cap;
 	u16 aer_cap;
 };
 
-- 
2.44.0

