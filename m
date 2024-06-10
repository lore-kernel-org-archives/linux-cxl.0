Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEDA4D8BC
	for <linux-cxl@vger.kernel.org>; Mon, 10 Jun 2024 08:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718007658; cv=none; b=BR7YI0SzivGAq878+IGWvgvw8QXTwxCIC7c50xorH0XR7fnTgO2RB9woeNffNA5Ng1TsJSsCSpM0NRGqe6fw10ulgDHDWtrUU5mzGIRdoZsd1nOHNstpFN5FlUrzpOnHWgabiJzKELWMr9kun8cwxcm2IaNoOBwJNLLOllncKec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718007658; c=relaxed/simple;
	bh=lIr+tJ3MMDTEMj0DauN9rQj4DOKazzDX0Bjanuz2r8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Od4+LUGoqeCJw9w53GWXOAsIH5BkK0nyml21EomKVzLcZvvCjDAcTtmQrwh/QRocbUTGe2KOY8uGTOLZ+4aaZEheg3ux2I3eythl050JN+KfEAMyY+UPIr4Bd4fhvIEYDQdV4B/hjDHqeTMdcxLU45+FfZJXzvCgTMSuPqi0/VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=G50xYPFY; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="G50xYPFY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1718007656; x=1749543656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lIr+tJ3MMDTEMj0DauN9rQj4DOKazzDX0Bjanuz2r8s=;
  b=G50xYPFYkWb/U6TSy1oQIbuOi9RKCh+uxmDLNkOOjtlkMF1apkSxQg/7
   zxGQnd/KUYjaPNhTxqbZBFCrJ0CEk2pmd+xmpTXMwX0ii6s5V1YW26nES
   9MlsJXoyTOEwGDTzAZliujKEcsINq1a95D54PYjp0ZOyUsbsB4edmeYxF
   K2623yAnSDPL+BZQwoBP+KMMzQIStbEsows0f3N002D35jdoUMrIgSQ0e
   DN2AnJelXFdjM3eAB1ZR+tp1YZV+hgS1sfbrTRIr5BCu0FSERG+zuTeCH
   5/Cf3udOdyYH8ak/qOVL/7GTx4+tvQ0eBNneXCuPK6mFnmqr64odD8Y2t
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="150821769"
X-IronPort-AV: E=Sophos;i="6.08,227,1712588400"; 
   d="scan'208";a="150821769"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 17:19:44 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 59A65D4256
	for <linux-cxl@vger.kernel.org>; Mon, 10 Jun 2024 17:19:42 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id AA331BF4AB
	for <linux-cxl@vger.kernel.org>; Mon, 10 Jun 2024 17:19:36 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3004.s.css.fujitsu.com (Postfix) with ESMTP id 6E4A4200543E;
	Mon, 10 Jun 2024 17:19:36 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	jonathan.cameron@huawei.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v9 1/2] cxl/core/regs: Add rcd_pcie_cap initialization at __rcrb_to_component()
Date: Mon, 10 Jun 2024 17:22:21 +0900
Message-ID: <20240610082222.22772-2-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240610082222.22772-1-kobayashi.da-06@fujitsu.com>
References: <20240610082222.22772-1-kobayashi.da-06@fujitsu.com>
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
 drivers/cxl/core/regs.c | 26 +++++++++++++++++++++++++-
 drivers/cxl/cxl.h       |  9 +++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

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
index 372786f80955..cc1ce5e032e2 100644
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
 
@@ -572,8 +585,19 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
 resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 					   struct cxl_dport *dport)
 {
+	void __iomem *dport_pcie_cap = NULL;
+	resource_size_t rcd_pcie_offset, ret;
 	if (!dport->rch)
 		return CXL_RESOURCE_NONE;
-	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
+
+	ret = __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
+	if (dport->rcrb.rcd_pcie_cap) {
+		rcd_pcie_offset = dport->rcrb.base + dport->rcrb.rcd_pcie_cap;
+		dport_pcie_cap = devm_cxl_iomap_block(dev, rcd_pcie_offset,
+											  sizeof(u8) * 0x42);
+	}
+	dport->regs.rcd_pcie_cap = dport_pcie_cap;
+
+	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 003feebab79b..fc9e0dbd5932 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -230,6 +230,14 @@ struct cxl_regs {
 	struct_group_tagged(cxl_rch_regs, rch_regs,
 		void __iomem *dport_aer;
 	);
+
+	/*
+	 * RCD upstream port specific PCIe cap register
+	 * @pcie_cap: CXL 3.0 8.2.1.2 RCD Upstream Port RCRB
+	 */
+	struct_group_tagged(cxl_rcd_regs, rcd_regs,
+		void __iomem *rcd_pcie_cap;
+	);
 };
 
 struct cxl_reg_map {
@@ -646,6 +654,7 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
 
 struct cxl_rcrb_info {
 	resource_size_t base;
+	u16 rcd_pcie_cap;
 	u16 aer_cap;
 };
 
-- 
2.44.0

