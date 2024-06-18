Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A090E63AE
	for <linux-cxl@vger.kernel.org>; Tue, 18 Jun 2024 04:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718684842; cv=none; b=hyKn4pX/S96gKxzQP/BQ5bFMKFT/PpdVqpOjtlKGbygftvtR8ZSX+lSKl68nvj2D249gnumFKBd/PUIpu+xS9acqotZZrtv0CuIt60zHWbMVJpxK2Bu0UnAW/rOWtcmLd0hF0rvRjI7HIXVh9p8or41UrIXXkVTMZOGWgIDGPzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718684842; c=relaxed/simple;
	bh=g0ypS9wvfkQT5uAoyESPwxyVQcKB3hECFYeSfLCYfa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0EyEePoAH67J0tJLgATduMDgARkzGGzh3e2RtSfOS5H9Gb5eFx3AwUiLkrn+Xt17mE+fYeTbTb5vVEcHsQpJBoTwdKHdFg7aAuZMUiYXjQ129hBqKuKr2e6tqyKTugPIjwC36zB4zznLSS28Lm2Y/vhlCiBWtmz5IhySq1HPSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Gc7zJhf+; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Gc7zJhf+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1718684839; x=1750220839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g0ypS9wvfkQT5uAoyESPwxyVQcKB3hECFYeSfLCYfa0=;
  b=Gc7zJhf+n0YUIjvqZ422Dx/V8SPBLOqyG3yleBa7kRP98LRTE6ci9bF5
   /7bJfWHBMJnHgC7v09P8eLXVnrk9N+63mbXSUI1Sf3mLnk+3li0AHcbTT
   dj8mZHExhokCEIcv5ei7XJjs6sPUv9fbYIdi1a+m0s9ZUuzwXq/pmCl9M
   zKV8nhWZqYiFOYa+5Pa2AxW80boFUm0QzqWNEp4H/sa4PJ1xuqEr8TvHx
   43mclmT2QrCfdFv3IorLFN7RVqrZhJAtEo+o4JMaPkP+QxnJHzQPwcXC5
   9/li6/t2yVyDp3WiRh6MbXdKoriLjShqJDmfxzRcmC3yNQBXYTMLxftJG
   Q==;
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="163836353"
X-IronPort-AV: E=Sophos;i="6.08,246,1712588400"; 
   d="scan'208";a="163836353"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 13:27:11 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id C693AD8003
	for <linux-cxl@vger.kernel.org>; Tue, 18 Jun 2024 13:27:09 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 1616ABF3C2
	for <linux-cxl@vger.kernel.org>; Tue, 18 Jun 2024 13:27:09 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3004.s.css.fujitsu.com (Postfix) with ESMTP id C641420053F9;
	Tue, 18 Jun 2024 13:27:08 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	jonathan.cameron@huawei.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v14 1/2] cxl/core/regs: Add rcd_pcie_cap initialization
Date: Tue, 18 Jun 2024 13:29:40 +0900
Message-ID: <20240618042941.96893-2-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240618042941.96893-1-kobayashi.da-06@fujitsu.com>
References: <20240618042941.96893-1-kobayashi.da-06@fujitsu.com>
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
 drivers/cxl/core/core.h |  6 ++++
 drivers/cxl/core/regs.c | 61 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |  9 ++++++
 drivers/cxl/pci.c       |  8 ++++--
 4 files changed, 82 insertions(+), 2 deletions(-)

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
index 372786f80955..8a7cef1cf87d 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -505,6 +505,67 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
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
+
+	iounmap(addr);
+	release_mem_region(rcrb, SZ_4K);
+	if (!offset)
+		return CXL_RESOURCE_NONE;
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
+	ri = &dport->rcrb;
+	rcd_pcie_offset = cxl_rcrb_to_linkcap(&pdev->dev, dport);
+	if (rcd_pcie_offset > 0)
+		dport_pcie_cap = devm_cxl_iomap_block(&pdev->dev,
+						      ri->base + rcd_pcie_offset,
+						      PCI_CAP_EXP_SIZEOF);
+
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
index 003feebab79b..7e37ad6d84d6 100644
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
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 2ff361e756d6..bbc55732d6c1 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -512,11 +512,15 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
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
+	} else if (rc) {
 		return rc;
+	}
 
 	return cxl_setup_regs(map);
 }
-- 
2.44.0

