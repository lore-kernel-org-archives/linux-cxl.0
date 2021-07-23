Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D565BC43214
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B750360EBC
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhGWU0J (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 23 Jul 2021 16:26:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:34290 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231809AbhGWU0F (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 23 Jul 2021 16:26:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="211671200"
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="211671200"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:37 -0700
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="497436147"
Received: from rfrederi-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.136.168])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:37 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 11/23] cxl: Enable an endpoint decoder type
Date:   Fri, 23 Jul 2021 14:06:11 -0700
Message-Id: <20210723210623.114073-12-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723210623.114073-1-ben.widawsky@intel.com>
References: <20210723210623.114073-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Endpoints have decoders too (no dports)

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/acpi.c     | 14 +++++------
 drivers/cxl/core/bus.c | 55 ++++++++++++++++++++++++++++++++++++++----
 drivers/cxl/cxl.h      | 28 +++++++++++++--------
 3 files changed, 75 insertions(+), 22 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index fee56688d797..fd1ae2495ab0 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -108,13 +108,13 @@ static void cxl_add_cfmws_decoders(struct device *dev)
 		}
 
 		flags = cfmws_to_decoder_flags(cfmws->restrictions);
-		cxld = devm_cxl_add_decoder(dev, NULL,
-					    CFMWS_INTERLEAVE_WAYS(cfmws),
-					    cfmws->base_hpa, cfmws->window_size,
-					    CFMWS_INTERLEAVE_WAYS(cfmws),
-					    CFMWS_INTERLEAVE_GRANULARITY(cfmws),
-					    CXL_DECODER_EXPANDER,
-					    flags);
+		cxld = devm_cxl_add_platform_decoder(dev,
+						     CFMWS_INTERLEAVE_WAYS(cfmws),
+						     cfmws->base_hpa,
+						     cfmws->window_size,
+						     CFMWS_INTERLEAVE_WAYS(cfmws),
+						     CFMWS_INTERLEAVE_GRANULARITY(cfmws),
+						     flags);
 
 		if (IS_ERR(cxld)) {
 			dev_err(dev, "Failed to add decoder for %#llx-%#llx\n",
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 7c75ae7f3b8e..e2166f43aefc 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -84,6 +84,8 @@ static ssize_t target_type_show(struct device *dev,
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
 
 	switch (cxld->target_type) {
+	case CXL_DECODER_UNKNOWN:
+		return sysfs_emit(buf, "unknown\n");
 	case CXL_DECODER_ACCELERATOR:
 		return sysfs_emit(buf, "accelerator\n");
 	case CXL_DECODER_EXPANDER:
@@ -176,6 +178,12 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
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
@@ -189,6 +197,12 @@ static void cxl_decoder_release(struct device *dev)
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
@@ -516,10 +530,12 @@ cxl_decoder_alloc(struct cxl_port *port, int nr_targets, resource_size_t base,
 	dev->bus = &cxl_bus_type;
 
 	/* platform decoders don't have a parent */
-	if (port)
-		dev->type = &cxl_decoder_switch_type;
-	else
+	if (!port)
 		dev->type = &cxl_decoder_root_type;
+	else if (flags & CXL_DECODER_F_ENDPOINT)
+		dev->type = &cxl_decoder_endpoint_type;
+	else
+		dev->type = &cxl_decoder_switch_type;
 
 	return cxld;
 err:
@@ -527,7 +543,7 @@ cxl_decoder_alloc(struct cxl_port *port, int nr_targets, resource_size_t base,
 	return ERR_PTR(rc);
 }
 
-struct cxl_decoder *
+static struct cxl_decoder *
 devm_cxl_add_decoder(struct device *host, struct cxl_port *port, int nr_targets,
 		     resource_size_t base, resource_size_t len,
 		     int interleave_ways, int interleave_granularity,
@@ -560,7 +576,36 @@ devm_cxl_add_decoder(struct device *host, struct cxl_port *port, int nr_targets,
 	put_device(dev);
 	return ERR_PTR(rc);
 }
-EXPORT_SYMBOL_GPL(devm_cxl_add_decoder);
+
+struct cxl_decoder *
+devm_cxl_add_platform_decoder(struct device *host, int nr_targets,
+			      resource_size_t base, resource_size_t len,
+			      int interleave_ways, int interleave_granularity,
+			      unsigned long flags)
+{
+	return devm_cxl_add_decoder(host, NULL, nr_targets, base, len,
+				    interleave_ways, interleave_granularity, 0,
+				    flags);
+}
+EXPORT_SYMBOL_GPL(devm_cxl_add_platform_decoder);
+
+struct cxl_decoder *devm_cxl_add_switch_decoder(struct device *host,
+						struct cxl_port *port,
+						enum cxl_decoder_type type)
+{
+	return devm_cxl_add_decoder(host, port, 0, 0, 0, 0, 0,
+				    CXL_DECODER_UNKNOWN, 0);
+}
+EXPORT_SYMBOL_GPL(devm_cxl_add_switch_decoder);
+
+struct cxl_decoder *devm_cxl_add_endpoint_decoder(struct device *host,
+						  struct cxl_port *port,
+						  enum cxl_decoder_type type)
+{
+	return devm_cxl_add_decoder(host, port, 0, 0, 0, 0, 0, type,
+				    CXL_DECODER_F_ENDPOINT);
+}
+EXPORT_SYMBOL_GPL(devm_cxl_add_endpoint_decoder);
 
 /**
  * __cxl_driver_register - register a driver for the cxl bus
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b9302d3861f0..dcf2d1a59271 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -173,11 +173,13 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 #define CXL_DECODER_F_TYPE2 BIT(2)
 #define CXL_DECODER_F_TYPE3 BIT(3)
 #define CXL_DECODER_F_LOCK  BIT(4)
-#define CXL_DECODER_F_MASK  GENMASK(4, 0)
+#define CXL_DECODER_F_ENDPOINT BIT(5)
+#define CXL_DECODER_F_MASK GENMASK(5, 0)
 
 enum cxl_decoder_type {
-       CXL_DECODER_ACCELERATOR = 2,
-       CXL_DECODER_EXPANDER = 3,
+	CXL_DECODER_UNKNOWN = 0,
+	CXL_DECODER_ACCELERATOR = 2,
+	CXL_DECODER_EXPANDER = 3,
 };
 
 /**
@@ -271,12 +273,19 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
-struct cxl_decoder *
-devm_cxl_add_decoder(struct device *host, struct cxl_port *port, int nr_targets,
-		     resource_size_t base, resource_size_t len,
-		     int interleave_ways, int interleave_granularity,
-		     enum cxl_decoder_type type, unsigned long flags);
 
+struct cxl_decoder *
+devm_cxl_add_platform_decoder(struct device *host, int nr_targets,
+			      resource_size_t base, resource_size_t len,
+			      int interleave_ways, int interleave_granularity,
+			      unsigned long flags);
+
+struct cxl_decoder *devm_cxl_add_switch_decoder(struct device *host,
+						struct cxl_port *port,
+						enum cxl_decoder_type type);
+struct cxl_decoder *devm_cxl_add_endpoint_decoder(struct device *host,
+						  struct cxl_port *port,
+						  enum cxl_decoder_type type);
 /*
  * Per the CXL specification (8.2.5.12 CXL HDM Decoder Capability Structure)
  * single ported host-bridges need not publish a decoder capability when a
@@ -287,8 +296,7 @@ devm_cxl_add_decoder(struct device *host, struct cxl_port *port, int nr_targets,
 static inline struct cxl_decoder *
 devm_cxl_add_passthrough_decoder(struct device *host)
 {
-	return devm_cxl_add_decoder(host, NULL, 1, 0, 0, 1, PAGE_SIZE,
-				    CXL_DECODER_EXPANDER, 0);
+	return devm_cxl_add_platform_decoder(host, 1, 0, 0, 1, PAGE_SIZE, 0);
 }
 
 extern struct bus_type cxl_bus_type;
-- 
2.32.0

