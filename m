Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4721DC433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Dec 2021 04:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355360AbhLBEng (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Dec 2021 23:43:36 -0500
Received: from mga09.intel.com ([134.134.136.24]:61244 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355497AbhLBEn0 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 1 Dec 2021 23:43:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="236438363"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="236438363"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:40:03 -0800
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="745717375"
Received: from liudanie-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.143.85])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:40:03 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 01/14] cxl/core: Add, document, and tighten up decoder APIs
Date:   Wed,  1 Dec 2021 20:37:37 -0800
Message-Id: <20211202043750.3501494-2-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211202043750.3501494-1-ben.widawsky@intel.com>
References: <20211202043750.3501494-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Since the code to add decoders for switches and endpoints is on the
horizon it helps to have properly documented APIs. In addition, the
decoder APIs will never need to support a negative count for downstream
targets as the spec explicitly starts numbering them at 1, ie. even 0 is
an "invalid" value which can be used as a sentinel.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
Changes since v1:
- Added decoder type specific APIs (Dan)
---
 drivers/cxl/acpi.c     |  4 +--
 drivers/cxl/core/bus.c | 82 +++++++++++++++++++++++++++++++++++++-----
 drivers/cxl/cxl.h      |  5 ++-
 3 files changed, 79 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index da70f1836db6..9f88dec03b33 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -102,7 +102,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	for (i = 0; i < CFMWS_INTERLEAVE_WAYS(cfmws); i++)
 		target_map[i] = cfmws->interleave_targets[i];
 
-	cxld = cxl_decoder_alloc(root_port, CFMWS_INTERLEAVE_WAYS(cfmws));
+	cxld = cxl_root_decoder_alloc(root_port, CFMWS_INTERLEAVE_WAYS(cfmws));
 	if (IS_ERR(cxld))
 		return 0;
 
@@ -260,7 +260,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	 * dport. Disable the range until the first CXL region is enumerated /
 	 * activated.
 	 */
-	cxld = cxl_decoder_alloc(port, 1);
+	cxld = cxl_root_decoder_alloc(port, 1);
 	if (IS_ERR(cxld))
 		return PTR_ERR(cxld);
 
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index ab756a53a983..2f72087846e3 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -495,7 +495,20 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
 	return rc;
 }
 
-struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
+/**
+ * cxl_decoder_alloc - Allocate a new CXL decoder
+ * @port: owning port of this decoder
+ * @nr_targets: downstream targets accessible by this decoder. All upstream
+ *		ports and root ports must have at least 1 target.
+ *
+ * A port should contain one or more decoders. Each of those decoders enable
+ * some address space for CXL.mem utilization. A decoder is expected to be
+ * configured by the caller before registering.
+ *
+ * Return: A new cxl decoder to be registered by cxl_decoder_add()
+ */
+static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
+					     unsigned int nr_targets)
 {
 	struct cxl_decoder *cxld, cxld_const_init = {
 		.nr_targets = nr_targets,
@@ -503,7 +516,7 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
 	struct device *dev;
 	int rc = 0;
 
-	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets < 1)
+	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets == 0)
 		return ERR_PTR(-EINVAL);
 
 	cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
@@ -522,19 +535,70 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
 	dev->parent = &port->dev;
 	dev->bus = &cxl_bus_type;
 
-	/* root ports do not have a cxl_port_type parent */
-	if (port->dev.parent->type == &cxl_port_type)
-		dev->type = &cxl_decoder_switch_type;
-	else
-		dev->type = &cxl_decoder_root_type;
-
 	return cxld;
 err:
 	kfree(cxld);
 	return ERR_PTR(rc);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_decoder_alloc, CXL);
 
+/**
+ * cxl_root_decoder_alloc - Allocate a root level decoder
+ * @port: owning port of this decoder
+ * @nr_targets: number of downstream targets. The number of downstream targets
+ *		is determined with a platform specific mechanism.
+ *
+ * Return: A new cxl decoder to be registered by cxl_decoder_add()
+ */
+struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
+					   unsigned int nr_targets)
+{
+	struct cxl_decoder *cxld;
+
+	cxld = cxl_decoder_alloc(port, nr_targets);
+	if (!IS_ERR(cxld))
+		cxld->dev.type = &cxl_decoder_root_type;
+
+	return cxld;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_root_decoder_alloc, CXL);
+
+/**
+ * cxl_switch_decoder_alloc - Allocate a switch level decoder
+ * @port: owning port of this decoder
+ * @nr_targets: number of downstream targets. The number of downstream targets
+ *		is determined via CXL capability registers.
+ *
+ * Return: A new cxl decoder to be registered by cxl_decoder_add()
+ */
+struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
+					     unsigned int nr_targets)
+{
+	struct cxl_decoder *cxld;
+
+	cxld = cxl_decoder_alloc(port, nr_targets);
+	if (!IS_ERR(cxld))
+		cxld->dev.type = &cxl_decoder_switch_type;
+
+	return cxld;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_switch_decoder_alloc, CXL);
+
+/**
+ * cxl_decoder_add - Add a decoder with targets
+ * @cxld: The cxl decoder allocated by cxl_decoder_alloc()
+ * @target_map: A list of downstream ports that this decoder can direct memory
+ *              traffic to. These numbers should correspond with the port number
+ *              in the PCIe Link Capabilities structure.
+ *
+ * Certain types of decoders may not have any targets. The main example of this
+ * is an endpoint device. A more awkward example is a hostbridge whose root
+ * ports get hot added (technically possible, though unlikely).
+ *
+ * Context: Process context. Takes and releases the cxld's device lock.
+ *
+ * Return: Negative error code if the decoder wasn't properly configured; else
+ *	   returns 0.
+ */
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
 {
 	struct cxl_port *port;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ad816fb5bdcc..a036594ec5b3 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -288,7 +288,10 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
-struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets);
+struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
+					   unsigned int nr_targets);
+struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
+					     unsigned int nr_targets);
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
 int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
 
-- 
2.34.1

