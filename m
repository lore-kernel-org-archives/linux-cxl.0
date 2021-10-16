Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0E6C43219
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80F5861108
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhJPFRq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 16 Oct 2021 01:17:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:1735 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232628AbhJPFRp (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sat, 16 Oct 2021 01:17:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="225489591"
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="225489591"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:38 -0700
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="442743236"
Received: from asimon-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.133.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:38 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 03/27] cxl/acpi: Map component registers for Root Ports
Date:   Fri, 15 Oct 2021 22:15:07 -0700
Message-Id: <20211016051531.622613-4-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211016051531.622613-1-ben.widawsky@intel.com>
References: <20211016051531.622613-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

With the addition of cxl_find_register_block() in cxl_core, it becomes
trivial to complete the TODO left for mapping the component registers of
root ports. None of the CXL drivers currently use component registers of
downstream ports (which is what a CXL 2.0 Root Port is). As such, there
should be no functional change.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/acpi.c | 10 ++++++++--
 drivers/cxl/pci.h  |  4 ++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index af1c6c1875ac..7d13e7f0aefc 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -7,6 +7,7 @@
 #include <linux/acpi.h>
 #include <linux/pci.h>
 #include "cxl.h"
+#include "pci.h"
 
 static struct acpi_table_header *acpi_cedt;
 
@@ -206,11 +207,13 @@ static resource_size_t get_chbcr(struct acpi_cedt_chbs *chbs)
 
 __mock int match_add_root_ports(struct pci_dev *pdev, void *data)
 {
+	resource_size_t creg = CXL_RESOURCE_NONE;
 	struct cxl_walk_context *ctx = data;
 	struct pci_bus *root_bus = ctx->root;
 	struct cxl_port *port = ctx->port;
 	int type = pci_pcie_type(pdev);
 	struct device *dev = ctx->dev;
+	struct cxl_register_map map;
 	u32 lnkcap, port_num;
 	int rc;
 
@@ -224,9 +227,12 @@ __mock int match_add_root_ports(struct pci_dev *pdev, void *data)
 				  &lnkcap) != PCIBIOS_SUCCESSFUL)
 		return 0;
 
-	/* TODO walk DVSEC to find component register base */
+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	if (!rc)
+		creg = cxl_reg_block(pdev, &map);
+
 	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
-	rc = cxl_add_dport(port, &pdev->dev, port_num, CXL_RESOURCE_NONE);
+	rc = cxl_add_dport(port, &pdev->dev, port_num, creg);
 	if (rc) {
 		ctx->error = rc;
 		return rc;
diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
index 7d3e4bf06b45..12fdcb1b14e5 100644
--- a/drivers/cxl/pci.h
+++ b/drivers/cxl/pci.h
@@ -31,4 +31,8 @@ enum cxl_regloc_type {
 #define CXL_REGLOC_RBI_MASK GENMASK(15, 8)
 #define CXL_REGLOC_ADDR_MASK GENMASK(31, 16)
 
+#define cxl_reg_block(pdev, map)                                               \
+	((resource_size_t)(pci_resource_start(pdev, (map)->barno) +            \
+			   (map)->block_offset))
+
 #endif /* __CXL_PCI_H__ */
-- 
2.33.1

