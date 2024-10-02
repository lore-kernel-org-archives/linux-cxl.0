Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67C22114
	for <linux-cxl@vger.kernel.org>; Wed,  2 Oct 2024 01:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727831681; cv=none; b=QeyrFYI89oa9obpZaf/pD2RRVIb3mh5O2rqQ89Whg7IgKhe+aEtdqStWA+PBvt/3/noL7sa73tXO3O4zscPynxeQoxBTTXtqhuF/6DGoyGUdYDZ778G+tK+/9fyMfqae4CAc52VnQ8vKxTRceKWDZCelIx9cMqwGQcXXzuLf9u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727831681; c=relaxed/simple;
	bh=LqsgabE2mVTJFKcHibDje+T9dfjVt13A7b90eqosUwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVY0c0deNYdwOplhMWScba14f1RQ+Fp0MGRJ/k/ZZY8jVK/XgVgES1MmEgzFz5OaLrixHveDvncPAqV57G9Tt6/5fHsMbka2X1xlACX2mWa/HNa1CRFeLplpk+4z3esf3zWYI+ji1QGniAIUzfAef8RZGH9FS6+4XXSRGFXBh+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=F5fRlvam; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="F5fRlvam"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1727831678; x=1759367678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LqsgabE2mVTJFKcHibDje+T9dfjVt13A7b90eqosUwA=;
  b=F5fRlvamsvqXt9v5JDX67lRtEyHH2ou0EkwOmzY+XfGPx8j+zB79MK6k
   n09eZmDZ7AYLvpcYXdqmeWASuI1k1pnIUhQJv0kEX8tJ7l0VQDrqvQ4Bw
   gXjq0eqPjPOlZpA5UVyJoT8G0dJfRFndNM+tOsrlujPbM+B8gFhV/DOJ1
   Ijyzs1apzm03HVB650KvaGHqvribNwMU5JTID5shgsM28gLJIRjiCyK8k
   vLqIDTZcXazg3wcCxk9QZamZsPQaWg0OuX4vjiDNEpXjqQWSjt3GcoDKc
   T8K2vfjZtYqDH0iLcIqYtNroELve1ovQU9/8GSIy/AF+cFgfDXlMrTNoI
   A==;
X-CSE-ConnectionGUID: 0Xw2/4XZR22LsYX/ZzrZEw==
X-CSE-MsgGUID: X4wa3zx3Q3eIsYTbXFPIlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="175610576"
X-IronPort-AV: E=Sophos;i="6.11,170,1725289200"; 
   d="scan'208";a="175610576"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 10:13:27 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 5CE51D7AD3
	for <linux-cxl@vger.kernel.org>; Wed,  2 Oct 2024 10:13:25 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 7EC92156CF
	for <linux-cxl@vger.kernel.org>; Wed,  2 Oct 2024 10:13:24 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3004.s.css.fujitsu.com (Postfix) with ESMTP id 4C2C62005338;
	Wed,  2 Oct 2024 10:13:24 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com
Cc: mj@ucw.cz,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v18 1/2] cxl/core/regs: Add rcd_pcie_cap initialization
Date: Wed,  2 Oct 2024 10:15:48 +0900
Message-ID: <20241002011549.408412-2-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241002011549.408412-1-kobayashi.da-06@fujitsu.com>
References: <20241002011549.408412-1-kobayashi.da-06@fujitsu.com>
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
 drivers/cxl/pci.c       | 25 +++++++++++++-----
 4 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 0c62b4069ba0..800466f96a68 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -89,6 +89,11 @@ resource_size_t __rcrb_to_component(struct device *dev,
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
index e1082e749c69..1c1c10c8bc7a 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -506,6 +506,62 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
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
index 0d8b810a51f0..1cfe3dd42e2f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -235,6 +235,14 @@ struct cxl_regs {
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
@@ -304,6 +312,7 @@ int cxl_setup_regs(struct cxl_register_map *map);
 struct cxl_dport;
 resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 					   struct cxl_dport *dport);
+int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
 #define CXL_TARGET_STRLEN 20
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 37164174b5fb..05d49ea2466d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -475,9 +475,9 @@ static bool is_cxl_restricted(struct pci_dev *pdev)
 }
 
 static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
-				  struct cxl_register_map *map)
+				  struct cxl_register_map *map,
+				  struct cxl_dport *dport)
 {
-	struct cxl_dport *dport;
 	resource_size_t component_reg_phys;
 
 	*map = (struct cxl_register_map) {
@@ -513,11 +513,24 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 	 * is an RCH and try to extract the Component Registers from
 	 * an RCRB.
 	 */
-	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev))
-		rc = cxl_rcrb_get_comp_regs(pdev, map);
-
-	if (rc)
+	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
+		struct cxl_dport *dport;
+		struct cxl_port *port __free(put_cxl_port) =
+			cxl_pci_find_port(pdev, &dport);
+		if (!port)
+			return -EPROBE_DEFER;
+
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

