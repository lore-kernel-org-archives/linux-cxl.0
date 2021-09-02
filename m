Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8473CC4167B
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 19:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 651BE61041
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 19:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347418AbhIBTve (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Sep 2021 15:51:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:41966 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347415AbhIBTvb (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 2 Sep 2021 15:51:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="198778213"
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="198778213"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 12:50:29 -0700
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="533451662"
Received: from kappusam-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.143.117])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 12:50:28 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 13/13] cxl/mem: Enumerate switch decoders
Date:   Thu,  2 Sep 2021 12:50:17 -0700
Message-Id: <20210902195017.2516472-14-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210902195017.2516472-1-ben.widawsky@intel.com>
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Switches work much in the same way as hostbridges. The primary
difference is that they are enumerated, and probed via regular PCIe
mechanisms. A switch has 1 upstream port, and n downstream ports.
Ultimately a memory device attached to a switch can determine if it's in
a CXL capable subset of the topology if the switch is CXL capable.

The algorithm introduced enables enumerating switches in a CXL topology.
It walks up the topology until it finds a root port (which is enumerated
by the cxl_acpi driver). Once at the top, it walks back down adding all
downstream ports along the way.

Note that practically speaking there can be at most 3 levels of switches
with the current 2.0 spec. This is because there is a max interleave of
8 defined in the spec. If there is a single hostbridge and only 1 root
port was CXL capable, you could have 3 levels of x2 switches, making
the x8 interleave. However, as far as the spec is concerned, there can
be infinite number of switches since a x1 switch is allowed, and
future versions of the spec may allow for a larger total interleave.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.c | 130 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/pci.c |   8 ---
 drivers/cxl/pci.h |   8 +++
 3 files changed, 137 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index aba9a07d519f..dc8ca43d5bfc 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -56,6 +56,133 @@ static bool is_cxl_mem_enabled(struct pci_dev *pdev)
 	return true;
 }
 
+/* TODO: dedeuplicate this from drivers/cxl/pci.c? */
+static unsigned long get_component_regs(struct pci_dev *pdev)
+{
+	unsigned long component_reg_phys = CXL_RESOURCE_NONE;
+	u32 regloc_size, regblocks;
+	int regloc, i;
+
+	regloc = cxl_pci_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
+	if (!regloc) {
+		dev_err(&pdev->dev, "register location dvsec not found\n");
+		return component_reg_phys;
+	}
+
+	/* Get the size of the Register Locator DVSEC */
+	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
+	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
+
+	regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
+	regblocks = (regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET) / 8;
+
+	for (i = 0; i < regblocks; i++, regloc += 8) {
+		u32 reg_lo, reg_hi;
+		u8 reg_type;
+		u64 offset;
+		u8 bar;
+
+		pci_read_config_dword(pdev, regloc, &reg_lo);
+		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
+
+		cxl_decode_register_block(reg_lo, reg_hi, &bar, &offset,
+					  &reg_type);
+
+		if (reg_type != CXL_REGLOC_RBI_COMPONENT)
+			continue;
+
+		component_reg_phys = pci_resource_start(pdev, bar) + offset;
+	}
+
+	return component_reg_phys;
+}
+
+static void enumerate_uport(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	/*
+	 * Parent's parent should be another uport, since we don't have root
+	 * ports here
+	 */
+	if (dev_WARN_ONCE(dev, !dev->parent->parent, "No grandparent port\n"))
+		return;
+
+	if (!is_cxl_port(dev->parent->parent)) {
+		dev_info(dev, "Parent of uport isn't a CXL port (%s)\n",
+			 dev_name(dev->parent->parent));
+		return;
+	}
+
+	devm_cxl_add_port(dev, dev, get_component_regs(pdev),
+			  to_cxl_port(dev->parent));
+}
+
+static void enumerate_dport(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u32 port_num, lnkcap;
+
+	if (dev_WARN_ONCE(dev, !dev->parent, "No parent port\n"))
+		return;
+
+	if (!is_cxl_port(dev->parent)) {
+		dev_info(dev, "Uport isn't a CXL port %s\n",
+			 dev_name(dev->parent));
+		return;
+	}
+
+	/* TODO: deduplicate from drivers/cxl/acpi.c? */
+	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
+				  &lnkcap) != PCIBIOS_SUCCESSFUL)
+		return;
+	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
+
+	cxl_add_dport(to_cxl_port(dev->parent), dev, port_num,
+		      get_component_regs(pdev));
+}
+
+/*
+ * Walk up the topology until we get to the root port (ie. parent is a
+ * cxl port). From there walk back down adding the additional ports. If the
+ * parent isn't a PCIe switch (upstream or downstream port), the downstream
+ * endpoint(s) cannot be CXL enabled.
+ *
+ * XXX: It's possible that cxl_acpi hasn't yet enumerated the root ports, and
+ * so that will rescan the CXL bus, thus coming back here.
+ */
+static void enumerate_switches(struct device *dev)
+{
+	struct pci_dev *pdev;
+	int type;
+
+	if (unlikely(!dev))
+		return;
+
+	if (unlikely(!dev_is_pci(dev)))
+		return;
+
+	pdev = to_pci_dev(dev);
+
+	if (unlikely(!pci_is_pcie(pdev)))
+		return;
+
+	if (!is_cxl_mem_enabled(pdev))
+		return;
+
+	type = pci_pcie_type(pdev);
+
+	if (type != PCI_EXP_TYPE_UPSTREAM && type != PCI_EXP_TYPE_DOWNSTREAM)
+		return;
+
+	enumerate_switches(dev->parent);
+
+	if (type == PCI_EXP_TYPE_UPSTREAM)
+		enumerate_uport(dev);
+	if (type == PCI_EXP_TYPE_DOWNSTREAM)
+		enumerate_dport(dev);
+}
+
 static int cxl_mem_probe(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
@@ -68,7 +195,8 @@ static int cxl_mem_probe(struct device *dev)
 	if (!is_cxl_mem_enabled(pdev))
 		return -ENODEV;
 
-	/* TODO: if parent is a switch, this will fail. */
+	enumerate_switches(dev->parent);
+
 	port_dev = bus_find_device(&cxl_bus_type, NULL, pdev_parent, port_match);
 	if (!port_dev)
 		return -ENODEV;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 258190febb5a..e338f2f759d0 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -400,14 +400,6 @@ static int cxl_map_regs(struct cxl_mem *cxlm, struct cxl_register_map *map)
 	return 0;
 }
 
-static void cxl_decode_register_block(u32 reg_lo, u32 reg_hi,
-				      u8 *bar, u64 *offset, u8 *reg_type)
-{
-	*offset = ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
-	*bar = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
-	*reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
-}
-
 /**
  * cxl_pci_setup_regs() - Setup necessary MMIO.
  * @cxlm: The CXL memory device to communicate with.
diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
index d6b9978d05b0..8250d487e39d 100644
--- a/drivers/cxl/pci.h
+++ b/drivers/cxl/pci.h
@@ -34,4 +34,12 @@
 
 int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec);
 
+static inline void cxl_decode_register_block(u32 reg_lo, u32 reg_hi, u8 *bar,
+					     u64 *offset, u8 *reg_type)
+{
+	*offset = ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
+	*bar = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
+	*reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
+}
+
 #endif /* __CXL_PCI_H__ */
-- 
2.33.0

