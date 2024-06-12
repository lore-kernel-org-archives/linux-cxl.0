Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB48716B736
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179091; cv=none; b=iZFnTQeORHTUbuoNvAjJ8njK4jd/c+OFOJoJQAfWADvF2kkrTwb4TcO9Da+U9Cupz2be/XAGw/J1TjBatbkBFKNJaEydaxL4IMhNPIhfHw+9V7Z1yd78kezXt97JtzL+iRrSSVj5sWOrM3oksPNcLLGQeNEkjiy6X2xp5MaTUxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179091; c=relaxed/simple;
	bh=q2wkZD9U5V7xVtTigAAoSk2IJFULhHCdY5TQ6IGN9fA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hl2VXE+sF9S1oAlFgYnxkk6955xG3UDf+vpLpa5rDk+9dYUerabjYgjx68BXVPUk0FsFEXtnsqKRwhwdf13CF/Hy3nBYCS3/XVWxu/BWeGZhfGH6z/SNXVfwkn8fnQbAl77DYp1uirLlVzvOAdOxu/P+6KW0EFroN4kHAIgyaFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=pmmetTPb; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="pmmetTPb"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1718179089; x=1749715089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q2wkZD9U5V7xVtTigAAoSk2IJFULhHCdY5TQ6IGN9fA=;
  b=pmmetTPbLP2bqM0WhTUUr++TskIdvtBg78wtySykK7s+uj41H3uJqML8
   TuzYPev5a4a0KoYp9ESKCj4xAbI9GUeB2oeQY04DLYojQcBUVGHYSdipp
   i4Bn6lXl8Xt3zU77ZNmJCuZDnue2FhTzhg5UbFGqMhkvyEb/+bgyCpsCz
   sV5vOslz83e0bB+oTeBv+GE26UncO+HK2EtgLAsh28OJl3vbjeZRwzQKp
   pTE+iL6op5NcLWXZm7s2TtqTSrGmmg/UPm2DHwJlrdU/10Kc7A+7v8qzh
   Z0JPuMqycYZSihZ0oa0zqFQ/nPR5CkYaTVCK/OaZB7FlZnR+h0rkOaLpF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="162750544"
X-IronPort-AV: E=Sophos;i="6.08,232,1712588400"; 
   d="scan'208";a="162750544"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 16:56:58 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1EAFCD4F58
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 16:56:55 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6AE6524E13
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 16:56:54 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 3F7A1200537A;
	Wed, 12 Jun 2024 16:56:54 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	jonathan.cameron@huawei.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v11 1/2] cxl/core/regs: Add rcd_pcie_cap initialization
Date: Wed, 12 Jun 2024 16:59:38 +0900
Message-ID: <20240612075940.92500-2-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240612075940.92500-1-kobayashi.da-06@fujitsu.com>
References: <20240612075940.92500-1-kobayashi.da-06@fujitsu.com>
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
 drivers/cxl/pci.c       |  4 ++-
 4 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 3b64fb1b9ed0..e71600380a22 100644
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
+#define RCRB_PCIECAP_LEN		0x3c
 
 extern struct rw_semaphore cxl_dpa_rwsem;
 extern struct rw_semaphore cxl_region_rwsem;
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 372786f80955..d86ac9c64e0c 100644
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
+	struct cxl_port *port;
+	struct cxl_dport *dport;
+	struct cxl_rcrb_info *ri;
+	resource_size_t rcd_pcie_offset;
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
+						      sizeof(u8) * RCRB_PCIECAP_LEN);
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
index 2ff361e756d6..8e7674c1b8f0 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -512,8 +512,10 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 	 * is an RCH and try to extract the Component Registers from
 	 * an RCRB.
 	 */
-	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev))
+	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
 		rc = cxl_rcrb_get_comp_regs(pdev, map);
+		cxl_dport_map_rcd_linkcap(pdev);
+	}
 
 	if (rc)
 		return rc;
-- 
2.44.0

