Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198938488
	for <linux-cxl@vger.kernel.org>; Tue, 11 Jun 2024 05:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718085016; cv=none; b=L4rBnq6JZfo+bM1yMUVzbnGsewj2kb/fSVqekzrgXSOj96GsMRsMVm0dtQmBAhsrr+QbnAGg402RmBnx8HEZn3quvTIKQLapMLrhEJBGqiSwB3G22Lo04Yu7khlxU+LpdC07wsZDhyEJ13mql5L4d3Eba+8vCxTe7OcdfMzHWiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718085016; c=relaxed/simple;
	bh=uvmavJZDL5TKC9vuCcLZG1Ye0hMJ1msMnMyAFdn/iUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWIAEQeU3ilqcTrpLau0iPXPsRXq/dDsZ2zfhzcE5RNHArCj0XTn0DahN6BTjHUQWIWjR7HnczpveOZvSCOJ4RABwl4R737KWCQsQtgRZPzBj/VeckKQPlSmP0uaFFfzg03EKd/X1KsL436aSXBCI3t4YEUVP+JszwemjISWc0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=CciYhd1M; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="CciYhd1M"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1718085014; x=1749621014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uvmavJZDL5TKC9vuCcLZG1Ye0hMJ1msMnMyAFdn/iUU=;
  b=CciYhd1M/3BMlBVA9dhIyi3hV3SLGjMka5Ud0TheBBQkTiKBWP154TAj
   ZTVIItj177E5DwJuHzwAGKcbAjrsPHg+XsYV+TS0Ip7TIZcn4cWDrSBNw
   +m4WqoWRIHY7nq6duAt0LqzzdmEfnkSWRahRqGZ32fhZHgQQNkfgeENQg
   ZHDMA1JO7y03cpBV4scYfudIlB2ma+USYEdopyrlaylzPzkFFkaObE6UK
   3+SZW/9+u3x3sAKG8eod9RXKor+zBmJJsC35ycSgBVHRniGcb9AH/HhPT
   hTQeDYVrdHjLBypnREuB52GVpsuJW2RduJAF46rEL0MqQejDj9eB8ql+f
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="141696198"
X-IronPort-AV: E=Sophos;i="6.08,229,1712588400"; 
   d="scan'208";a="141696198"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 14:50:04 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id B48BCD29EE
	for <linux-cxl@vger.kernel.org>; Tue, 11 Jun 2024 14:50:02 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 04BD6D7489
	for <linux-cxl@vger.kernel.org>; Tue, 11 Jun 2024 14:50:02 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id B3458203ED5A;
	Tue, 11 Jun 2024 14:50:01 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	jonathan.cameron@huawei.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v10 1/2] cxl/core/regs: Add rcd_pcie_cap initialization at __rcrb_to_component()
Date: Tue, 11 Jun 2024 14:52:53 +0900
Message-ID: <20240611055254.61203-2-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240611055254.61203-1-kobayashi.da-06@fujitsu.com>
References: <20240611055254.61203-1-kobayashi.da-06@fujitsu.com>
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
the walking memory map area to find the offset when output the register 
value.

Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
---
 drivers/cxl/core/core.h |  5 +++++
 drivers/cxl/core/regs.c | 27 ++++++++++++++++++++++++++-
 drivers/cxl/cxl.h       |  9 +++++++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 3b64fb1b9ed0..66778c3ce3b7 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -75,6 +75,11 @@ resource_size_t __rcrb_to_component(struct device *dev,
 				    enum cxl_rcrb which);
 u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
 
+#define PCI_RCRB_CAP_LIST_ID_MASK	GENMASK(7, 0)
+#define PCI_RCRB_CAP_HDR_ID_MASK	GENMASK(7, 0)
+#define PCI_RCRB_CAP_HDR_NEXT_MASK	GENMASK(15, 8)
+#define RCRB_PCIECAP_LEN			0x3c
+
 extern struct rw_semaphore cxl_dpa_rwsem;
 extern struct rw_semaphore cxl_region_rwsem;
 
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 372786f80955..5ce831ca05ca 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -514,6 +514,8 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
 	u32 bar0, bar1;
 	u16 cmd;
 	u32 id;
+	u32 cap_hdr;
+	u16 offset;
 
 	if (which == CXL_RCRB_UPSTREAM)
 		rcrb += SZ_4K;
@@ -537,6 +539,19 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
 	cmd = readw(addr + PCI_COMMAND);
 	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
 	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
+	offset = FIELD_GET(PCI_RCRB_CAP_LIST_ID_MASK, readw(addr + PCI_CAPABILITY_LIST));
+	cap_hdr = readl(addr + offset);
+	while ((FIELD_GET(PCI_RCRB_CAP_HDR_ID_MASK, cap_hdr)) != PCI_CAP_ID_EXP) {
+		offset = FIELD_GET(PCI_RCRB_CAP_HDR_NEXT_MASK, cap_hdr);
+		if (offset == 0 || offset > SZ_4K) {
+			offset = 0;
+			break;
+		}
+		cap_hdr = readl(addr + offset);
+	}
+	if (offset)
+		ri->rcd_pcie_cap = offset;
+
 	iounmap(addr);
 	release_mem_region(rcrb, SZ_4K);
 
@@ -572,8 +587,18 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
 resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 					   struct cxl_dport *dport)
 {
+	resource_size_t rcd_pcie_offset, ret;
+
 	if (!dport->rch)
 		return CXL_RESOURCE_NONE;
-	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
+
+	ret = __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
+	if (dport->rcrb.rcd_pcie_cap) {
+		rcd_pcie_offset = dport->rcrb.base + dport->rcrb.rcd_pcie_cap;
+		dport->regs.rcd_pcie_cap = devm_cxl_iomap_block(dev, rcd_pcie_offset,
+								sizeof(u8) * RCRB_PCIECAP_LEN);
+	}
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

