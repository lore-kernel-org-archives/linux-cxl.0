Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7279C11F68
	for <linux-cxl@archiver.kernel.org>; Fri,  2 Jul 2021 04:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D48A613DC
	for <linux-cxl@archiver.kernel.org>; Fri,  2 Jul 2021 04:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhGBECv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 2 Jul 2021 00:02:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:34836 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhGBECt (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 2 Jul 2021 00:02:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="269796964"
X-IronPort-AV: E=Sophos;i="5.83,316,1616482800"; 
   d="scan'208";a="269796964"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 21:00:17 -0700
X-IronPort-AV: E=Sophos;i="5.83,316,1616482800"; 
   d="scan'208";a="626612129"
Received: from rlaw-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.131.215])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 21:00:16 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH] cxl: Enable an endpoint decoder type
Date:   Thu,  1 Jul 2021 21:00:09 -0700
Message-Id: <20210702040009.68794-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL memory devices support HDM decoders. Currently, when a decoder is
instantiated there is no knowledge of the type of decoder; only the
underlying endpoint type is specified. In order to have the memory
devices reuse the existing decoder creation infrastructure it is
convenient to pass along the type of decoder on creation.

The primary difference for an endpoint decoder is that it doesn't have
dports, nor targets. The target is just the underlying media (with
offset).

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---

The consumer of this is the region, memory device, and decoder drivers which are
being worked on. The memory device driver on probe will query the HDM decoder
registers to determine how many decoders are present and instantiate a
cxl_decoder for each one. This patch enables that to work.

---
 drivers/cxl/acpi.c |  2 +-
 drivers/cxl/core.c | 43 ++++++++++++++++++++++++++++++++-----------
 drivers/cxl/cxl.h  | 29 +++++++++++++++++++++++++----
 3 files changed, 58 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 8ae89273f58e..5215845e0f89 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -114,7 +114,7 @@ static void cxl_add_cfmws_decoders(struct device *dev,
 					    cfmws->base_hpa, cfmws->window_size,
 					    CFMWS_INTERLEAVE_WAYS(cfmws),
 					    CFMWS_INTERLEAVE_GRANULARITY(cfmws),
-					    CXL_DECODER_EXPANDER,
+					    CXL_DECODER_PLATFORM,
 					    flags);
 
 		if (IS_ERR(cxld)) {
diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
index a2e4d54fc7bc..196f260e2580 100644
--- a/drivers/cxl/core.c
+++ b/drivers/cxl/core.c
@@ -75,9 +75,9 @@ static ssize_t target_type_show(struct device *dev,
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
 
 	switch (cxld->target_type) {
-	case CXL_DECODER_ACCELERATOR:
+	case CXL_DEVICE_ACCELERATOR:
 		return sysfs_emit(buf, "accelerator\n");
-	case CXL_DECODER_EXPANDER:
+	case CXL_DEVICE_EXPANDER:
 		return sysfs_emit(buf, "expander\n");
 	}
 	return -ENXIO;
@@ -167,6 +167,12 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
 	NULL,
 };
 
+static const struct attribute_group *cxl_decoder_endpoint_attribute_groups[] = {
+	&cxl_decoder_base_attribute_group,
+	&cxl_base_attribute_group,
+	NULL,
+};
+
 static void cxl_decoder_release(struct device *dev)
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
@@ -176,6 +182,12 @@ static void cxl_decoder_release(struct device *dev)
 	kfree(cxld);
 }
 
+static const struct device_type cxl_decoder_endpoint_type = {
+	.name = "cxl_decoder_endpoint",
+	.release = cxl_decoder_release,
+	.groups = cxl_decoder_endpoint_attribute_groups,
+};
+
 static const struct device_type cxl_decoder_switch_type = {
 	.name = "cxl_decoder_switch",
 	.release = cxl_decoder_release,
@@ -458,12 +470,14 @@ cxl_decoder_alloc(struct cxl_port *port, int nr_targets, resource_size_t base,
 	if (interleave_ways < 1)
 		return ERR_PTR(-EINVAL);
 
-	device_lock(&port->dev);
-	if (list_empty(&port->dports))
-		rc = -EINVAL;
-	device_unlock(&port->dev);
-	if (rc)
-		return ERR_PTR(rc);
+	if (type != CXL_DECODER_ENDPOINT) {
+		device_lock(&port->dev);
+		if (list_empty(&port->dports))
+			rc = -EINVAL;
+		device_unlock(&port->dev);
+		if (rc)
+			return ERR_PTR(rc);
+	}
 
 	cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
 	if (!cxld)
@@ -496,10 +510,17 @@ cxl_decoder_alloc(struct cxl_port *port, int nr_targets, resource_size_t base,
 	dev->bus = &cxl_bus_type;
 
 	/* root ports do not have a cxl_port_type parent */
-	if (port->dev.parent->type == &cxl_port_type)
-		dev->type = &cxl_decoder_switch_type;
-	else
+	switch (type) {
+	case CXL_DECODER_PLATFORM:
 		dev->type = &cxl_decoder_root_type;
+		break;
+	case CXL_DECODER_SWITCH:
+		dev->type = &cxl_decoder_switch_type;
+		break;
+	case CXL_DECODER_ENDPOINT:
+		dev->type = &cxl_decoder_endpoint_type;
+		break;
+	}
 
 	return cxld;
 err:
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b6bda39a59e3..8fe58404ebb5 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -164,6 +164,11 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
 #define CXL_TARGET_STRLEN 20
 
+enum cxl_device_type {
+       CXL_DEVICE_ACCELERATOR = 2,
+       CXL_DEVICE_EXPANDER = 3,
+};
+
 /*
  * cxl_decoder flags that define the type of memory / devices this
  * decoder supports as well as configuration lock status See "CXL 2.0
@@ -177,8 +182,9 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 #define CXL_DECODER_F_MASK  GENMASK(4, 0)
 
 enum cxl_decoder_type {
-       CXL_DECODER_ACCELERATOR = 2,
-       CXL_DECODER_EXPANDER = 3,
+       CXL_DECODER_PLATFORM,
+       CXL_DECODER_SWITCH,
+       CXL_DECODER_ENDPOINT,
 };
 
 /**
@@ -191,6 +197,21 @@ enum cxl_decoder_type {
  * @target_type: accelerator vs expander (type2 vs type3) selector
  * @flags: memory type capabilities and locking
  * @target: active ordered target list in current decoder configuration
+ *
+ * Abstractly, a CXL decoder represents one of 3 possible decoders:
+ * 1. Platform specific routing - opaque rules for the memory controller that
+ *    may be communicated via ACPI or devicetree. This decoding has implied
+ *    interleave parameters as well as physical address ranges that are directed
+ *    to the downstream ports of this decoder.
+ * 2. HDM decoder for a switch. Similar to the platform specific routing in that
+ *    it contains a set of downstream ports which receive and send traffic in an
+ *    interleave fashion, the main difference is that the interleave and address
+ *    ranges are controlled by the HDM decoder registers defined in the CXL 2.0
+ *    specification.
+ * 3. HDM decoder for an endpoint. Like the decoder in a switch, this decoder's
+ *    configuration is entirely programmable and defined in CXL spec. Unlike the
+ *    switch's decoder, there is not a set of downstream ports, only the
+ *    underlying media.
  */
 struct cxl_decoder {
 	struct device dev;
@@ -198,7 +219,7 @@ struct cxl_decoder {
 	struct range range;
 	int interleave_ways;
 	int interleave_granularity;
-	enum cxl_decoder_type target_type;
+	enum cxl_device_type target_type;
 	unsigned long flags;
 	struct cxl_dport *target[];
 };
@@ -289,7 +310,7 @@ static inline struct cxl_decoder *
 devm_cxl_add_passthrough_decoder(struct device *host, struct cxl_port *port)
 {
 	return devm_cxl_add_decoder(host, port, 1, 0, 0, 1, PAGE_SIZE,
-				    CXL_DECODER_EXPANDER, 0);
+				    CXL_DECODER_PLATFORM, 0);
 }
 
 extern struct bus_type cxl_bus_type;
-- 
2.32.0

