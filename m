Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D171DC433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Sep 2021 21:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD816105A
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Sep 2021 21:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347392AbhIXV34 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 24 Sep 2021 17:29:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:44987 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244748AbhIXV34 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 24 Sep 2021 17:29:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10117"; a="246642413"
X-IronPort-AV: E=Sophos;i="5.85,321,1624345200"; 
   d="scan'208";a="246642413"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 14:28:22 -0700
X-IronPort-AV: E=Sophos;i="5.85,321,1624345200"; 
   d="scan'208";a="535866902"
Received: from jinglu1-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.134.71])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 14:28:21 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>
Subject: [RFC PATCH] cxl: switch usp to parent cxl_port
Date:   Fri, 24 Sep 2021 14:28:17 -0700
Message-Id: <20210924212817.489801-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Dan.

As discussed in #cxl, I'm trying to do the switch enumeration and not entirely
sure of the best way to go about it (and no real way to test it). Do you have a
proposed way to do this better?


---
 drivers/cxl/core/bus.c | 65 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 936b6b5665c3..372d30b4bafd 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -419,6 +419,71 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 }
 EXPORT_SYMBOL_GPL(devm_cxl_add_port);
 
+static int match_add_switches(struct pci_dev *pdev, void *data)
+{
+	struct cxl_walk_context *ctx = data;
+	struct pci_bus *root_bus = ctx->root;
+	struct device *dev = &pdev->dev;
+	int type = pci_pcie_type(pdev);
+	struct cxl_port *parent_port;
+	struct cxl_register_map map;
+	int rc;
+
+	if (pdev->bus != root_bus)
+		return 0;
+
+	if (!pci_is_pcie(pdev))
+		return 0;
+	if (type != PCI_EXP_TYPE_UPSTREAM)
+		return 0;
+
+	/* Get component registers */
+	rc = cxl_find_register_block(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	if (rc) {
+		ctx->error = rc;
+	}
+
+	/* to_pci_dev(dev->parent) == downstream port, or root port */
+	/* to_pci_dev(dev->parent->parent) == upstream port, or hostbridge */
+
+	if (dev_WARN_ONCE(dev, dev->parent->parent == NULL,
+			  "No valid parent\n")) {
+		ctx->error = -ENODEV;
+		parent_port = NULL;
+	} else {
+		parent_port = to_cxl_port(dev->parent->parent);
+	}
+
+	devm_cxl_add_port(ctx->dev, dev,
+			  pci_resource_start(pdev, map.barno) +
+				  map.block_offset,
+			  parent_port);
+
+	return 0;
+}
+
+int enumerate_ports_from_root_port(struct cxl_port *root_port)
+{
+	struct device *d = root_port->uport;
+	struct cxl_walk_context ctx;
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(d))
+		return -ENODEV;
+
+	pdev = to_pci_dev(d);
+	ctx = (struct cxl_walk_context){
+		.dev = d,
+		.root = pdev->bus,
+		.port = root_port,
+	};
+
+	pci_walk_bus(pdev->bus, match_add_switches, &ctx);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(enumerate_ports_from_root_port);
+
 static struct cxl_dport *find_dport(struct cxl_port *port, int id)
 {
 	struct cxl_dport *dport;

base-commit: 5c46722547fb375f460dbe293f40fad0ca32ab90
prerequisite-patch-id: f3e7ffbd5f60cd3f55ad8e174afd9d8c37d546f4
prerequisite-patch-id: a74a0ce5f4a1e4cec50e68181fcbb92624cb0687
prerequisite-patch-id: 3e2e86cbc2631b99c1b5c0179f35799d3df31f91
prerequisite-patch-id: 68cf009af310e296626b7842fc798fc778fcc98e
prerequisite-patch-id: 4063abbb095774d723ad727cb91bc8576d6a5532
prerequisite-patch-id: 3f11cc68d4dfc7f578f8c6a440663e9ef4e27466
prerequisite-patch-id: 5ef0b7ff2acf5896b955dd4f70a06581f42d7904
prerequisite-patch-id: 8cc6066d94bc859ff094c056d77eb63a967a3657
prerequisite-patch-id: b4fa2b34c36f3068743c965ebc01462ab016df4d
prerequisite-patch-id: a8798a409f1ff81979fb35a2c66a991ba6cc69f5
prerequisite-patch-id: d68e5ca2dbd408f206acb40c54f1ed9e6d981aa0
-- 
2.33.0

