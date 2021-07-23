Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29B0C432BE
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D2060F36
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhGWU0M (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 23 Jul 2021 16:26:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:34287 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231684AbhGWU0J (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 23 Jul 2021 16:26:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="211671221"
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="211671221"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:40 -0700
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="497436195"
Received: from rfrederi-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.136.168])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:39 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 23/23] cxl/core: Map component registers for ports
Date:   Fri, 23 Jul 2021 14:06:23 -0700
Message-Id: <20210723210623.114073-24-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723210623.114073-1-ben.widawsky@intel.com>
References: <20210723210623.114073-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/core/bus.c  | 37 +++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/regs.c |  6 +++---
 drivers/cxl/cxl.h       |  2 ++
 drivers/cxl/mem.c       |  2 +-
 drivers/cxl/mem.h       |  1 +
 drivers/cxl/pci.c       | 13 ++++++++++++-
 6 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 4b58b3f1ec99..f3ac899815e8 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -379,6 +379,38 @@ static int devm_cxl_link_uport(struct device *host, struct cxl_port *port)
 	return devm_add_action_or_reset(host, cxl_unlink_uport, port);
 }
 
+static int cxl_port_map_component_registers(struct cxl_port *port,
+					    struct cxl_component_regs *regs)
+{
+	struct cxl_register_map map;
+	struct cxl_component_reg_map *comp_map = &map.component_map;
+	void __iomem *crb;
+
+	if (port->component_reg_phys == CXL_RESOURCE_NONE)
+		return 0;
+
+	crb = devm_cxl_iomap_block(&port->dev,
+				   port->component_reg_phys,
+				   /* CXL_COMPONENT_REG_BLOCK_SIZE */ SZ_64K);
+	if (IS_ERR(crb))
+		return PTR_ERR(crb);
+
+	if (!crb) {
+		dev_err(&port->dev, "No component registers mapped\n");
+		return -ENXIO;
+	}
+
+	cxl_probe_component_regs(&port->dev, crb, comp_map);
+	if (!comp_map->hdm_decoder.valid) {
+		dev_err(&port->dev, "HDM decoder registers invalid\n");
+		return -ENXIO;
+	}
+
+	regs->hdm_decoder = crb + comp_map->hdm_decoder.offset;
+
+	return 0;
+}
+
 static struct cxl_port *cxl_port_alloc(struct device *uport,
 				       resource_size_t component_reg_phys,
 				       struct cxl_port *parent_port)
@@ -436,6 +468,7 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 				   resource_size_t component_reg_phys,
 				   struct cxl_port *parent_port)
 {
+	struct cxl_component_regs crb;
 	struct cxl_port *port;
 	struct device *dev;
 	int rc;
@@ -467,6 +500,10 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 	if (rc)
 		return ERR_PTR(rc);
 
+	rc = cxl_port_map_component_registers(port, &crb);
+	if (rc)
+		return ERR_PTR(rc);
+
 	return port;
 
 err:
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index d05946a6bf53..6f5baf784d23 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -144,9 +144,8 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 }
 EXPORT_SYMBOL_GPL(cxl_probe_device_regs);
 
-static void __iomem *devm_cxl_iomap_block(struct device *dev,
-					  resource_size_t addr,
-					  resource_size_t length)
+void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
+				   resource_size_t length)
 {
 	void __iomem *ret_val;
 	struct resource *res;
@@ -165,6 +164,7 @@ static void __iomem *devm_cxl_iomap_block(struct device *dev,
 
 	return ret_val;
 }
+EXPORT_SYMBOL_GPL(devm_cxl_iomap_block);
 
 int cxl_map_component_regs(struct pci_dev *pdev,
 			   struct cxl_component_regs *regs,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 8020af021494..87fea255a573 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -149,6 +149,8 @@ struct cxl_register_map {
 	};
 };
 
+void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
+				   resource_size_t length);
 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			      struct cxl_component_reg_map *map);
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 4656636acb8a..622042b13d24 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -59,7 +59,7 @@ static int cxl_memdev_probe(struct device *dev)
 	}
 
 	rc = PTR_ERR_OR_ZERO(devm_cxl_add_port(&cxlmd->dev, &cxlmd->dev,
-					       CXL_RESOURCE_NONE,
+					       cxlmd->component_reg_phys,
 					       to_cxl_port(port_dev)));
 	if (rc)
 		dev_err(dev, "Unable to add devices upstream port");
diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
index 7da1bb48d409..b784123ef35d 100644
--- a/drivers/cxl/mem.h
+++ b/drivers/cxl/mem.h
@@ -50,6 +50,7 @@ struct cxl_memdev {
 	struct cxl_mem *cxlm;
 	int id;
 	void (*shutdown)(struct cxl_memdev *cxlmd);
+	unsigned long component_reg_phys;
 };
 
 struct cxl_memdev *
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 96837412914d..a557676f509e 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1345,7 +1345,7 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct cxl_register_map maps[CXL_REGLOC_RBI_TYPES];
 	struct cxl_memdev *cxlmd;
 	struct cxl_mem *cxlm;
-	int rc;
+	int rc, i;
 
 	rc = pcim_enable_device(pdev);
 	if (rc)
@@ -1376,6 +1376,17 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
+	for (i = 0; i < ARRAY_SIZE(maps); i++) {
+		struct cxl_register_map *map = &maps[i];
+
+		if (map->reg_type != CXL_REGLOC_RBI_COMPONENT)
+			continue;
+
+		cxlmd->component_reg_phys =
+			pci_resource_start(pdev, map->barno) +
+			map->block_offset;
+	}
+
 	if (range_len(&cxlm->pmem_range) && IS_ENABLED(CONFIG_CXL_PMEM))
 		rc = devm_cxl_add_nvdimm(&pdev->dev, cxlmd);
 
-- 
2.32.0

