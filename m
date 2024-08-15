Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D028E63C
	for <linux-cxl@vger.kernel.org>; Thu, 15 Aug 2024 00:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723683278; cv=none; b=hwNV32CljgfYG827nbk4+Sw2YRtnWuhlqpey3081aFGIhLI1CqG5pgKVBHq+mPQxAanwa0DRzTIJ65mFQQdbaPRhw1MXx9TQLBKcO8/bb+uhCZBRsCWgKhLLK5FN75hj291a3tLcc+wK+Z86qxZBVtnsTTp4imFvTJwyp++6upg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723683278; c=relaxed/simple;
	bh=RxVUsgxTV6jJBYKdCtQvh+H5CGU49Mlq5mrNO9TdFUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u88YeBYe7JPVCLCND2kNXaJY9ZczayJIhOuIAmdZCN77qyr678bzgynEKf9t6IdS334ls9UzhDa8M112c/iRoHtOlRN54uEQzu2s8o6vJAkEBWOlKYlq4PpdgEIIgHJso4HZn8Wfo72m6aJGlQBY8++OXMs+uO+b8P+0T5ps19Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=RyzHV5vr; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="RyzHV5vr"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1723683275; x=1755219275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RxVUsgxTV6jJBYKdCtQvh+H5CGU49Mlq5mrNO9TdFUA=;
  b=RyzHV5vrmQy0+B6UhoW2uFVbeLsPoOp6M2UkS9tBPgJ5cxPmMs32DOLG
   XLKi5vUmwijlHi4niUUoJnhRVSz9UoUH+v9tDllx43JTHxulWLSFHGWNw
   mqPlhz+lE2hu+KsxDDiqvkqv+K/GnoTP9C8h8rEPJg31dtiq3RPSl572+
   vhtsfS9DcOqb3XzEKxVGMEYB/wyBBZy1QqwClZlN7OttHsmFJPz5SzBzn
   PmEs4kE/GLTx1DM7XlqPhBIQWoqFGuGpX7VFL678Botj7YXwwXS4moLc5
   zUWo8FzyYAkH3adafnMNMDpP9GHrWmJ7NDJzIDFLEIJL/WDhuPfadMjGr
   g==;
X-CSE-ConnectionGUID: CipBqc4KRzm6mBce8WdqJw==
X-CSE-MsgGUID: o7dgfxCWQ5if+oTtFt2JRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="170594866"
X-IronPort-AV: E=Sophos;i="6.10,147,1719846000"; 
   d="scan'208";a="170594866"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 09:53:23 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id EB15BCD6E3
	for <linux-cxl@vger.kernel.org>; Thu, 15 Aug 2024 09:53:20 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 43988D5608
	for <linux-cxl@vger.kernel.org>; Thu, 15 Aug 2024 09:53:20 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 1BCA02005370;
	Thu, 15 Aug 2024 09:53:20 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com
Cc: y-goto@fujitsu.com,
	mj@ucw.cz,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v16 1/2] cxl/core/regs: Add rcd_pcie_cap initialization
Date: Thu, 15 Aug 2024 09:55:10 +0900
Message-ID: <20240815005510.220835-3-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240815005510.220835-1-kobayashi.da-06@fujitsu.com>
References: <20240815005510.220835-1-kobayashi.da-06@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00

Add rcd_pcie_cap and its initialization to cache the offset of cxl1.1 
device link status information. By caching it, avoid the walking 
memory map area to find the offset when output the register value.

Given that this solution involves port lookups via cxl_pci_find_port()
and multiple exit paths where that reference needs to be dropped,
introduce a new put_cxl_root() scope-based-free handler.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
---
 drivers/cxl/core/core.h |  5 ++++
 drivers/cxl/core/regs.c | 56 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |  9 +++++++
 drivers/cxl/pci.c       | 30 +++++++++++++---------
 4 files changed, 88 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 3b64fb1b9ed0..95d94ec14eb6 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -75,6 +75,11 @@ resource_size_t __rcrb_to_component(struct device *dev,
 				    enum cxl_rcrb which);
 u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
 
+#define PCI_RCRB_CAP_LIST_ID_MASK	GENMASK(7, 0)
+#define PCI_RCRB_CAP_HDR_ID_MASK	GENMASK(7, 0)
+#define PCI_RCRB_CAP_HDR_NEXT_MASK	GENMASK(15, 8)
+#define PCI_CAP_EXP_SIZEOF		0x3c
+
 extern struct rw_semaphore cxl_dpa_rwsem;
 extern struct rw_semaphore cxl_region_rwsem;
 
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 372786f80955..b1ab0d9bcbcb 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -505,6 +505,62 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
 	return offset;
 }
 
+static resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport)
+{
+	resource_size_t rcrb = dport->rcrb.base;
+	void __iomem *addr;
+	u32 cap_hdr;
+	u16 offset;
+
+	if (!request_mem_region(rcrb, SZ_4K, "CXL RCRB"))
+		return CXL_RESOURCE_NONE;
+
+	addr = ioremap(rcrb, SZ_4K);
+	if (!addr) {
+		dev_err(dev, "Failed to map region %pr\n", addr);
+		release_mem_region(rcrb, SZ_4K);
+		return CXL_RESOURCE_NONE;
+	}
+
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
+
+	iounmap(addr);
+	release_mem_region(rcrb, SZ_4K);
+	if (!offset)
+		return CXL_RESOURCE_NONE;
+
+	return offset;
+}
+
+int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport)
+{
+	void __iomem *dport_pcie_cap = NULL;
+	resource_size_t pos;
+	struct cxl_rcrb_info *ri;
+
+	ri = &dport->rcrb;
+	pos = cxl_rcrb_to_linkcap(&pdev->dev, dport);
+	if (pos == CXL_RESOURCE_NONE)
+		return -ENXIO;
+
+	dport_pcie_cap = devm_cxl_iomap_block(&pdev->dev,
+					      ri->base + pos,
+					      PCI_CAP_EXP_SIZEOF);
+	dport->regs.rcd_pcie_cap = dport_pcie_cap;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dport_map_rcd_linkcap, CXL);
+
 resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri,
 				    enum cxl_rcrb which)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 003feebab79b..839c5a20cc33 100644
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
@@ -299,6 +307,7 @@ int cxl_setup_regs(struct cxl_register_map *map);
 struct cxl_dport;
 resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 					   struct cxl_dport *dport);
+int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
 #define CXL_TARGET_STRLEN 20
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 2ff361e756d6..4eaf64d92541 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -471,10 +471,9 @@ static bool is_cxl_restricted(struct pci_dev *pdev)
 }
 
 static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
-				  struct cxl_register_map *map)
+				  struct cxl_register_map *map,
+				  struct cxl_dport *dport)
 {
-	struct cxl_port *port;
-	struct cxl_dport *dport;
 	resource_size_t component_reg_phys;
 
 	*map = (struct cxl_register_map) {
@@ -482,14 +481,8 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
 		.resource = CXL_RESOURCE_NONE,
 	};
 
-	port = cxl_pci_find_port(pdev, &dport);
-	if (!port)
-		return -EPROBE_DEFER;
-
 	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
 
-	put_device(&port->dev);
-
 	if (component_reg_phys == CXL_RESOURCE_NONE)
 		return -ENXIO;
 
@@ -503,6 +496,7 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
 static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 			      struct cxl_register_map *map)
 {
+	struct cxl_dport *dport;
 	int rc;
 
 	rc = cxl_find_regblock(pdev, type, map);
@@ -512,11 +506,23 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 	 * is an RCH and try to extract the Component Registers from
 	 * an RCRB.
 	 */
-	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev))
-		rc = cxl_rcrb_get_comp_regs(pdev, map);
+	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
+		struct cxl_port *port __free(put_cxl_root) =
+			cxl_pci_find_port(pdev, &dport);
+		if (!port)
+			return -EPROBE_DEFER;
 
-	if (rc)
+		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
+		if (rc)
+			return rc;
+
+		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
+		if (rc)
+			return rc;
+
+	} else if (rc) {
 		return rc;
+	}
 
 	return cxl_setup_regs(map);
 }
-- 
2.45.0

