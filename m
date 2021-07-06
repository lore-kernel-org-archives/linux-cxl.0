Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A273C07E96
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Jul 2021 16:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D84E861A13
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Jul 2021 16:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhGFQEJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Jul 2021 12:04:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:55408 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhGFQDx (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 6 Jul 2021 12:03:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="206133223"
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="206133223"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 09:00:58 -0700
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="627721327"
Received: from bsyntia-mobl2.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.129.32])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 09:00:57 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2] cxl: Enable an endpoint decoder type
Date:   Tue,  6 Jul 2021 09:00:50 -0700
Message-Id: <20210706160050.527553-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210702040009.68794-1-ben.widawsky@intel.com>
References: <20210702040009.68794-1-ben.widawsky@intel.com>
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

v2 Fixes target_type and stores the decoder type on instantiation

diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
index 196f260e2580..69acdd230f54 100644
--- a/drivers/cxl/core.c
+++ b/drivers/cxl/core.c
@@ -493,10 +493,11 @@ cxl_decoder_alloc(struct cxl_port *port, int nr_targets, resource_size_t base,
                        .start = base,
                        .end = base + len - 1,
                },
+               .type = type,
                .flags = flags,
                .interleave_ways = interleave_ways,
                .interleave_granularity = interleave_granularity,
-               .target_type = type,
+               .target_type = CXL_DEVICE_EXPANDER,
        };

        /* handle implied target_list */

---
 drivers/cxl/acpi.c |  2 +-
 drivers/cxl/core.c | 46 ++++++++++++++++++++++++++++++++++------------
 drivers/cxl/cxl.h  | 31 +++++++++++++++++++++++++++----
 3 files changed, 62 insertions(+), 17 deletions(-)

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
index a2e4d54fc7bc..69acdd230f54 100644
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
@@ -479,10 +493,11 @@ cxl_decoder_alloc(struct cxl_port *port, int nr_targets, resource_size_t base,
 			.start = base,
 			.end = base + len - 1,
 		},
+		.type = type,
 		.flags = flags,
 		.interleave_ways = interleave_ways,
 		.interleave_granularity = interleave_granularity,
-		.target_type = type,
+		.target_type = CXL_DEVICE_EXPANDER,
 	};
 
 	/* handle implied target_list */
@@ -496,10 +511,17 @@ cxl_decoder_alloc(struct cxl_port *port, int nr_targets, resource_size_t base,
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
index b6bda39a59e3..02e0af4c147c 100644
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
@@ -186,19 +192,36 @@ enum cxl_decoder_type {
  * @dev: this decoder's device
  * @id: kernel device name id
  * @range: address range considered by this decoder
+ * @type: the type of this CXL decoder (platform, switch, endpoint)
  * @interleave_ways: number of cxl_dports in this decode
  * @interleave_granularity: data stride per dport
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
 	int id;
 	struct range range;
+	enum cxl_decoder_type type;
 	int interleave_ways;
 	int interleave_granularity;
-	enum cxl_decoder_type target_type;
+	enum cxl_device_type target_type;
 	unsigned long flags;
 	struct cxl_dport *target[];
 };
@@ -289,7 +312,7 @@ static inline struct cxl_decoder *
 devm_cxl_add_passthrough_decoder(struct device *host, struct cxl_port *port)
 {
 	return devm_cxl_add_decoder(host, port, 1, 0, 0, 1, PAGE_SIZE,
-				    CXL_DECODER_EXPANDER, 0);
+				    CXL_DECODER_PLATFORM, 0);
 }
 
 extern struct bus_type cxl_bus_type;
-- 
2.32.0

