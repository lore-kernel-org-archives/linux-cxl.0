Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1FCC2B9F4
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Jun 2021 22:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77A7361075
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Jun 2021 22:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhFNW67 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Jun 2021 18:58:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:17568 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229696AbhFNW66 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 14 Jun 2021 18:58:58 -0400
IronPort-SDR: IRrT+Pm5I0pBXWnCys/GijXQS8V+l/cZ6KPIRX9Qf/ym1bsXdJJSq196tjAcIgPh1xl+Nobcjk
 XVsB9aRkCpFQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="205850316"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="205850316"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 15:56:54 -0700
IronPort-SDR: 79lI9xV05I5RNAQ5NnCxG3YIm113iiS249bEcVYTnHJWChef+c89hGDi4hLtg/PHf3LZYjOafj
 QSRhhFzwv9TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="553499909"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.53])
  by orsmga004.jf.intel.com with ESMTP; 14 Jun 2021 15:56:54 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] cxl/acpi: Use the ACPI CFMWS to create static decoder objects
Date:   Mon, 14 Jun 2021 15:52:42 -0700
Message-Id: <0246fe923945ba2b8d885f45279d7d3956c46950.1623705308.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1623705308.git.alison.schofield@intel.com>
References: <cover.1623705308.git.alison.schofield@intel.com>
In-Reply-To: <cover.1623705308.git.alison.schofield@intel.com>
References: <cover.1623705308.git.alison.schofield@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The ACPI CXL Early Discovery Table (CEDT) includes a list of CXL memory
resources in CXL Fixed Memory Window Structures (CFMWS). Retrieve each
CFMWS in the CEDT and add a cxl_decoder object to the root port (root0)
for each memory resource.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/acpi.c | 106 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 16f60bc6801f..ac4b3e37e294 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -8,8 +8,112 @@
 #include <linux/pci.h>
 #include "cxl.h"
 
+/* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
+#define CFMWS_INTERLEAVE_WAYS(x)	(1 << (x)->interleave_ways)
+#define CFMWS_INTERLEAVE_GRANULARITY(x)	((x)->granularity + 8)
+
+/*
+ * CFMWS Restrictions mapped to CXL Decoder Flags
+ * Restrictions defined in CXL 2.0 ECN CEDT CFMWS
+ * Decoder Flags defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register
+ */
+#define CFMWS_TO_DECODE_TYPE2(x) ((x & ACPI_CEDT_CFMWS_RESTRICT_TYPE2) << 2)
+#define CFMWS_TO_DECODE_TYPE3(x) ((x & ACPI_CEDT_CFMWS_RESTRICT_TYPE3) << 2)
+#define CFMWS_TO_DECODE_RAM(x)   ((x & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE) >> 2)
+#define CFMWS_TO_DECODE_PMEM(x)	 ((x & ACPI_CEDT_CFMWS_RESTRICT_PMEM) >> 2)
+#define CFMWS_TO_DECODE_FIXED(x) (x & ACPI_CEDT_CFMWS_RESTRICT_FIXED)
+
+#define CFMWS_TO_DECODER_FLAGS(x) (CFMWS_TO_DECODE_TYPE2(x) | \
+				   CFMWS_TO_DECODE_TYPE3(x) | \
+				   CFMWS_TO_DECODE_RAM(x)   | \
+				   CFMWS_TO_DECODE_PMEM(x)  | \
+				   CFMWS_TO_DECODE_FIXED(x))
+
 static struct acpi_table_header *cedt_table;
 
+static int cxl_acpi_cfmws_verify(struct device *dev,
+				 struct acpi_cedt_cfmws *cfmws)
+{
+	int expected_len;
+
+	if (cfmws->interleave_arithmetic != ACPI_CEDT_CFMWS_ARITHMETIC_MODULO) {
+		dev_err(dev, "CFMWS Unsupported Interleave Arithmetic\n");
+		return -EINVAL;
+	}
+
+	if (!IS_ALIGNED(cfmws->base_hpa, SZ_256M)) {
+		dev_err(dev, "CFMWS Base HPA not 256MB aligned\n");
+		return -EINVAL;
+	}
+
+	if (!IS_ALIGNED(cfmws->window_size, SZ_256M)) {
+		dev_err(dev, "CFMWS Window Size not 256MB aligned\n");
+		return -EINVAL;
+	}
+
+	expected_len = struct_size((cfmws), interleave_targets,
+				   CFMWS_INTERLEAVE_WAYS(cfmws));
+
+	if (expected_len != cfmws->header.length) {
+		dev_err(dev, "CFMWS interleave ways and targets mismatch\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void cxl_add_cfmws_decoders(struct device *dev,
+				   struct cxl_port *root_port)
+{
+	struct acpi_cedt_cfmws *cfmws;
+	struct cxl_decoder *cxld;
+	acpi_size len, cur = 0;
+	void *cedt_base;
+	int rc;
+
+	len = cedt_table->length - sizeof(*cedt_table);
+	cedt_base = cedt_table + 1;
+
+	while (cur < len) {
+		struct acpi_cedt_header *c = cedt_base + cur;
+
+		if (c->type != ACPI_CEDT_TYPE_CFMWS) {
+			cur += c->length;
+			continue;
+		}
+
+		cfmws = cedt_base + cur;
+
+		if (cfmws->header.length < sizeof(*cfmws)) {
+			dev_err(dev, "Invalid CFMWS header length %u\n",
+				cfmws->header.length);
+			dev_err(dev, "Failed to add decoders\n");
+			return;
+		}
+
+		rc = cxl_acpi_cfmws_verify(dev, cfmws);
+		if (rc) {
+			cur += c->length;
+			continue;
+		}
+
+		cxld = devm_cxl_add_decoder(dev, root_port,
+				CFMWS_INTERLEAVE_WAYS(cfmws),
+				cfmws->base_hpa, cfmws->window_size,
+				CFMWS_INTERLEAVE_WAYS(cfmws),
+				CFMWS_INTERLEAVE_GRANULARITY(cfmws),
+				CXL_DECODER_EXPANDER,
+				CFMWS_TO_DECODER_FLAGS(cfmws->restrictions));
+
+		if (IS_ERR(cxld))
+			dev_err(dev, "Failed to add decoder\n");
+		else
+			dev_dbg(dev, "add: %s\n", dev_name(&cxld->dev));
+
+		cur += c->length;
+	}
+}
+
 static struct acpi_cedt_chbs *cxl_acpi_match_chbs(struct device *dev, u32 uid)
 {
 	struct acpi_cedt_chbs *chbs, *chbs_match = NULL;
@@ -251,6 +355,8 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	if (rc)
 		goto out;
 
+	cxl_add_cfmws_decoders(host, root_port);
+
 	/*
 	 * Root level scanned with host-bridge as dports, now scan host-bridges
 	 * for their role as CXL uports to their CXL-capable PCIe Root Ports.
-- 
2.26.2

