Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A1138B
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 04:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718340875; cv=none; b=qwcmMzqWprZAvoXMfjcvBnaH6Q/9Ak1hRmN7z8HS9owCiukZRZWo0nyMptZxYCrmfKQ4xUZKIB+4oJwKk8elx92d9oSgG+gb6fszNcZNTuh8qYqStQjnH15QeTqOQH1yLAUDtL2rkJoeiWrLs6Bx1I6rfa2hm6h4kCbKBSUz3BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718340875; c=relaxed/simple;
	bh=yEFdgyXprfVhxnjLMwoXrFKg9YakriKjIsj54bDmcXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kx3V05yw+MGPiE0hRe6D2/jW4idF0EWrbZDLMnGFv33a5MGwUNES64gH1hVUZlLXa3Ta7LBeeet2UnOGP17HQdMKF1JcEkyZbfEXKGTXEAVDwyexXK5jNVqjgd2wqe09fQ56KWMhYj5uetRb3qRZHZvJLcTd/1OEdhAkML4Iw2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=QYN3LHty; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="QYN3LHty"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1718340872; x=1749876872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yEFdgyXprfVhxnjLMwoXrFKg9YakriKjIsj54bDmcXg=;
  b=QYN3LHtyDEQkC52XgXJrFEoTklPdJR0DJEdJve4FDLuva4AGTr3Tsubt
   SVT0g+XRgkAnDTsEX3pHm8EDBAxRQWrBTxPXtrHq2RMHtrZi2wfVlUdZP
   pjRal1aM36db8X2AWfTc6YwSt0cnNaUNpmECz9fviEoZyBdz0UGlqEbJh
   l7FeX2J89uW0pvyLVhp4IpGRt6byw4YcZd8UEjRWirUMlUrWSvYy+AvgQ
   5Fb7Rl3qyQQ8+Kjn0HkASqtyYBry+aE1LRU7vsfTnjaPMk3co5FN4XfrG
   AQGD3Ek/QcZCAY93fcv1X9+u3ly0Bc18L9vMBdsDuvVa6OqyDpj11Dwqv
   w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="151154400"
X-IronPort-AV: E=Sophos;i="6.08,236,1712588400"; 
   d="scan'208";a="151154400"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 13:53:19 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id EF37ADB3C8
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 13:53:17 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 442B9D5076
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 13:53:17 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 17F9F2020F9D;
	Fri, 14 Jun 2024 13:53:17 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	jonathan.cameron@huawei.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v12 1/2] cxl/core/regs: Add rcd_pcie_cap initialization
Date: Fri, 14 Jun 2024 13:56:10 +0900
Message-ID: <20240614045611.58658-2-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240614045611.58658-1-kobayashi.da-06@fujitsu.com>
References: <20240614045611.58658-1-kobayashi.da-06@fujitsu.com>
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

Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
---
 drivers/cxl/core/core.h |  6 ++++
 drivers/cxl/core/regs.c | 62 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       | 10 +++++++
 drivers/cxl/pci.c       |  7 +++--
 4 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 3b64fb1b9ed0..69006bde7ad5 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -74,6 +74,12 @@ resource_size_t __rcrb_to_component(struct device *dev,
 				    struct cxl_rcrb_info *ri,
 				    enum cxl_rcrb which);
 u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
+resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport);
+
+#define PCI_RCRB_CAP_LIST_ID_MASK	GENMASK(7, 0)
+#define PCI_RCRB_CAP_HDR_ID_MASK	GENMASK(7, 0)
+#define PCI_RCRB_CAP_HDR_NEXT_MASK	GENMASK(15, 8)
+#define PCI_CAP_EXP_SIZEOF		0x3c
 
 extern struct rw_semaphore cxl_dpa_rwsem;
 extern struct rw_semaphore cxl_region_rwsem;
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 372786f80955..96c2a289cfb7 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -505,6 +505,68 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
 	return offset;
 }
 
+resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport)
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
+	if (offset)
+		dport->rcrb.rcd_pcie_cap = offset;
+
+	iounmap(addr);
+	release_mem_region(rcrb, SZ_4K);
+
+	return offset;
+}
+
+int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev)
+{
+	void __iomem *dport_pcie_cap = NULL;
+	resource_size_t rcd_pcie_offset;
+	struct cxl_rcrb_info *ri;
+	struct cxl_dport *dport;
+	struct cxl_port *port;
+
+	port = cxl_pci_find_port(pdev, &dport);
+	if (!port)
+		return -EPROBE_DEFER;
+
+	cxl_rcrb_to_linkcap(&pdev->dev, dport);
+
+	ri = &dport->rcrb;
+	if (dport->rcrb.rcd_pcie_cap) {
+		rcd_pcie_offset = ri->base + ri->rcd_pcie_cap;
+		dport_pcie_cap = devm_cxl_iomap_block(&pdev->dev, rcd_pcie_offset,
+						      PCI_CAP_EXP_SIZEOF);
+	}
+
+	dport->regs.rcd_pcie_cap = dport_pcie_cap;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dport_map_rcd_linkcap, CXL);
+
 resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri,
 				    enum cxl_rcrb which)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 003feebab79b..b1fca98ddf8c 100644
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
+int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev);
 
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
 #define CXL_TARGET_STRLEN 20
@@ -646,6 +655,7 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
 
 struct cxl_rcrb_info {
 	resource_size_t base;
+	u16 rcd_pcie_cap;
 	u16 aer_cap;
 };
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 2ff361e756d6..62343a5a39ff 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -512,10 +512,13 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 	 * is an RCH and try to extract the Component Registers from
 	 * an RCRB.
 	 */
-	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev))
+	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
 		rc = cxl_rcrb_get_comp_regs(pdev, map);
+		if (rc)
+			return rc;
 
-	if (rc)
+		cxl_dport_map_rcd_linkcap(pdev);
+	} else if (rc)
 		return rc;
 
 	return cxl_setup_regs(map);
-- 
2.44.0

