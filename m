Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFD3C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ACB160E8C
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbhJVSjg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Oct 2021 14:39:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:5583 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233944AbhJVSje (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 22 Oct 2021 14:39:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="216528937"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="216528937"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:16 -0700
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="445854632"
Received: from aagregor-mobl3.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.134.35])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:16 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH v2 09/28] cxl/acpi: Map single port host bridge component registers
Date:   Fri, 22 Oct 2021 11:36:50 -0700
Message-Id: <20211022183709.1199701-10-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022183709.1199701-1-ben.widawsky@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Now that the port driver exists and is able to do proper decoder
enumeration of the component registers, it becomes trivial to use that
for host bridge uports. For reasons out of scope, a functional change
would be visible if the HDM decoder was programmed by BIOS to values
other than the full address range. Similarly if a type2 device was
connected to this root port and programmed by BIOS, that can now be
acted upon accordingly.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/acpi.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index d61397055e9f..8cca0814dfb8 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -280,12 +280,14 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	struct cxl_port *root_port = arg;
 	struct device *host = root_port->dev.parent;
 	struct acpi_device *bridge = to_cxl_host_bridge(host, match);
+	struct cxl_component_reg_map map;
 	struct acpi_pci_root *pci_root;
 	struct cxl_walk_context ctx;
 	int single_port_map[1], rc;
 	struct cxl_decoder *cxld;
 	struct cxl_dport *dport;
 	struct cxl_port *port;
+	void __iomem *crb;
 
 	if (!bridge)
 		return 0;
@@ -318,10 +320,31 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 		return -ENODEV;
 	if (ctx.error)
 		return ctx.error;
+	/*
+	 * If the host bridge has more than 1 root port, it must have registers
+	 * controlling the HDM decoders. Those will be enumerated by the port
+	 * driver.
+	 */
 	if (ctx.count > 1)
 		return 0;
 
-	/* TODO: Scan CHBCR for HDM Decoder resources */
+	/*
+	 * If the single ported host bridge has a component register block,
+	 * simply let the port driver handle the decoder enumeration.
+	 *
+	 * Host bridge component registers live in the system's physical address
+	 * space.
+	 */
+	crb = ioremap(dport->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
+	if (crb) {
+		cxl_probe_component_regs(&root_port->dev, crb, &map);
+		iounmap(crb);
+		if (map.hdm_decoder.valid) {
+			dev_dbg(host,
+				"Found single port host bridge with component registers\n");
+			return 0;
+		}
+	}
 
 	/*
 	 * Per the CXL specification (8.2.5.12 CXL HDM Decoder Capability
-- 
2.33.1

