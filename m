Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C4510A11
	for <linux-cxl@vger.kernel.org>; Tue, 16 Jul 2024 04:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721103797; cv=none; b=s6o8dDZfalZ/xzWbHu3ueSu3Yfs0d5Am8MApI/kxK0scM0G8IN288xQLq0IMyYYYoaWipPo3vrE24r1FnRqQCiSALnOFGW3m4cwiptnCzX36xhiGSA9FWtKrQS8+njDbrxgFguOqQWmmz7CFzqyyr7bjTN/tFkCgxN3mXNJ6oMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721103797; c=relaxed/simple;
	bh=Nt7v1XQWHRgVNqBZENcaG0jvttPfkk/8FcTJsnqbISQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axlou/dVMzLyxuCeg0qH7cOWBd7gLIW5WDC8aB1PhyOylV0EGoP6lGaoCM7STiqwGrMY9HyC5kAZ9cwWkZtjx6BNPraeNb63NxiYWcugFTnOXsEHvwxmuBbcITCHJM5vQDa+kHe9j9QtvRM4O/dSJYA/N5cl79TFD+sIEh7MYxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=os1cXjRI; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="os1cXjRI"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1721103794; x=1752639794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nt7v1XQWHRgVNqBZENcaG0jvttPfkk/8FcTJsnqbISQ=;
  b=os1cXjRIT1pQNCIpi8c5HjFEGQmbO9qd4oJg9gowY3vQGgdFtLGi9SCn
   3RN2Hhtx3YTIUOZvGG1mJozCXXcrZ98PvXav4uWP3Ud0OFvkTx9Nq+MO9
   BlTjY2dEUhyltq1/zvGPXajpNie02AFAqjxXyp1nvSepCFpk3tYqpfce1
   BARQXtOLI7erq6C9TyQno+G/CsH/aYXb7pgqz3Cu8hrkbEyI6OMU3Akf7
   4Vj2XohIHC3DZAp0Dm81BCfMNy2QJnAeRTCGTjL2kQg1IUo+hrKsc3p4M
   +8W7wYgT4EP7i0zikzTiRZYNiYSSsQtO6h1VNcbD4MjVzTqsks4w6Zo6t
   w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="166525501"
X-IronPort-AV: E=Sophos;i="6.09,211,1716217200"; 
   d="scan'208";a="166525501"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 13:23:05 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id B937DC68E2
	for <linux-cxl@vger.kernel.org>; Tue, 16 Jul 2024 13:23:02 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 03322D3F0F
	for <linux-cxl@vger.kernel.org>; Tue, 16 Jul 2024 13:23:02 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id C035120521FB;
	Tue, 16 Jul 2024 13:23:01 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com
Cc: y-goto@fujitsu.com,
	mj@ucw.cz,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v15 1/2] cxl/core/regs: Add rcd_pcie_cap initialization
Date: Tue, 16 Jul 2024 13:25:39 +0900
Message-ID: <20240716042540.89639-2-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240716042540.89639-1-kobayashi.da-06@fujitsu.com>
References: <20240716042540.89639-1-kobayashi.da-06@fujitsu.com>
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
---
 drivers/cxl/core/core.h |  5 ++++
 drivers/cxl/core/regs.c | 56 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |  9 +++++++
 drivers/cxl/pci.c       | 33 +++++++++++++++---------
 4 files changed, 91 insertions(+), 12 deletions(-)

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
index 2ff361e756d6..5e7e66f28420 100644
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
 
@@ -503,6 +496,8 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
 static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 			      struct cxl_register_map *map)
 {
+	struct cxl_dport *dport;
+	struct cxl_port *port;
 	int rc;
 
 	rc = cxl_find_regblock(pdev, type, map);
@@ -512,11 +507,25 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 	 * is an RCH and try to extract the Component Registers from
 	 * an RCRB.
 	 */
-	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev))
-		rc = cxl_rcrb_get_comp_regs(pdev, map);
+	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
+		port = cxl_pci_find_port(pdev, &dport);
+		if (!port)
+			return -EPROBE_DEFER;
 
-	if (rc)
+		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
+		if (rc) {
+			put_device(&port->dev);
+			return rc;
+		}
+
+		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
+		if (rc) {
+			put_device(&port->dev);
+			return rc;
+		}
+	} else if (rc) {
 		return rc;
+	}
 
 	return cxl_setup_regs(map);
 }
-- 
2.45.0

