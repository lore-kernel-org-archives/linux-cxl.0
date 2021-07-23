Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE24C4320E
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 119BA60F25
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhGWU0J (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 23 Jul 2021 16:26:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:34287 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231792AbhGWU0E (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 23 Jul 2021 16:26:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="211671198"
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="211671198"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:37 -0700
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="497436143"
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
Subject: [PATCH 10/23] cxl/decoder: Support parentless decoders
Date:   Fri, 23 Jul 2021 14:06:10 -0700
Message-Id: <20210723210623.114073-11-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723210623.114073-1-ben.widawsky@intel.com>
References: <20210723210623.114073-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Currently, an ACPI0017 device (opaque platform thing) is parent to an
ACPI0016 device (platform host bridge) child. The platform level
decoders don't need a parent child relationship in order to traverse CXL
hierarchy since once you get to these devices, you have a useless ACPI
device instead of a CXL one.

To support an upcoming expansion for CXL endpoints to be able to
enumerate their decoders, support this NULL parent as a way to help
distinguish decoder types.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/acpi.c     |  9 ++++-----
 drivers/cxl/core/bus.c | 44 +++++++++++++++++++++++++++---------------
 drivers/cxl/cxl.h      |  4 ++--
 3 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 8ae89273f58e..fee56688d797 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -68,8 +68,7 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
 	return 0;
 }
 
-static void cxl_add_cfmws_decoders(struct device *dev,
-				   struct cxl_port *root_port)
+static void cxl_add_cfmws_decoders(struct device *dev)
 {
 	struct acpi_cedt_cfmws *cfmws;
 	struct cxl_decoder *cxld;
@@ -109,7 +108,7 @@ static void cxl_add_cfmws_decoders(struct device *dev,
 		}
 
 		flags = cfmws_to_decoder_flags(cfmws->restrictions);
-		cxld = devm_cxl_add_decoder(dev, root_port,
+		cxld = devm_cxl_add_decoder(dev, NULL,
 					    CFMWS_INTERLEAVE_WAYS(cfmws),
 					    cfmws->base_hpa, cfmws->window_size,
 					    CFMWS_INTERLEAVE_WAYS(cfmws),
@@ -301,7 +300,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	 * in the CHBCR and a 1:1 passthrough decode is implied.
 	 */
 	if (ctx.count == 1) {
-		cxld = devm_cxl_add_passthrough_decoder(host, port);
+		cxld = devm_cxl_add_passthrough_decoder(host);
 		if (IS_ERR(cxld))
 			return PTR_ERR(cxld);
 
@@ -393,7 +392,7 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	if (rc)
 		goto out;
 
-	cxl_add_cfmws_decoders(host, root_port);
+	cxl_add_cfmws_decoders(host);
 
 	/*
 	 * Root level scanned with host-bridge as dports, now scan host-bridges
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 8c2351c52d2b..7c75ae7f3b8e 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -25,6 +25,7 @@
 int cxl_mem_major;
 EXPORT_SYMBOL_GPL(cxl_mem_major);
 static DEFINE_IDA(cxl_port_ida);
+static DEFINE_IDA(cxl_root_decoder_ida);
 
 static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
@@ -178,9 +179,13 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
 static void cxl_decoder_release(struct device *dev)
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
-	struct cxl_port *port = to_cxl_port(dev->parent);
+	struct cxl_port *port = dev->parent ? to_cxl_port(dev->parent) : NULL;
+
+	if (port)
+		ida_free(&port->decoder_ida, cxld->id);
+	else
+		ida_free(&cxl_root_decoder_ida, cxld->id);
 
-	ida_free(&port->decoder_ida, cxld->id);
 	kfree(cxld);
 }
 
@@ -466,18 +471,24 @@ cxl_decoder_alloc(struct cxl_port *port, int nr_targets, resource_size_t base,
 	if (interleave_ways < 1)
 		return ERR_PTR(-EINVAL);
 
-	device_lock(&port->dev);
-	if (list_empty(&port->dports))
-		rc = -EINVAL;
-	device_unlock(&port->dev);
-	if (rc)
-		return ERR_PTR(rc);
+	if (port) {
+		device_lock(&port->dev);
+		if (list_empty(&port->dports))
+			rc = -EINVAL;
+		device_unlock(&port->dev);
+		if (rc)
+			return ERR_PTR(rc);
+	}
 
 	cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
 	if (!cxld)
 		return ERR_PTR(-ENOMEM);
 
-	rc = ida_alloc(&port->decoder_ida, GFP_KERNEL);
+	if (port)
+		rc = ida_alloc(&port->decoder_ida, GFP_KERNEL);
+	else
+		rc = ida_alloc(&cxl_root_decoder_ida, GFP_KERNEL);
+
 	if (rc < 0)
 		goto err;
 
@@ -494,17 +505,18 @@ cxl_decoder_alloc(struct cxl_port *port, int nr_targets, resource_size_t base,
 	};
 
 	/* handle implied target_list */
-	if (interleave_ways == 1)
-		cxld->target[0] =
-			list_first_entry(&port->dports, struct cxl_dport, list);
+	if (port)
+		if (interleave_ways == 1)
+			cxld->target[0] =
+				list_first_entry(&port->dports, struct cxl_dport, list);
 	dev = &cxld->dev;
 	device_initialize(dev);
 	device_set_pm_not_required(dev);
-	dev->parent = &port->dev;
+	dev->parent = port ? &port->dev : NULL;
 	dev->bus = &cxl_bus_type;
 
-	/* root ports do not have a cxl_port_type parent */
-	if (port->dev.parent->type == &cxl_port_type)
+	/* platform decoders don't have a parent */
+	if (port)
 		dev->type = &cxl_decoder_switch_type;
 	else
 		dev->type = &cxl_decoder_root_type;
@@ -531,7 +543,7 @@ devm_cxl_add_decoder(struct device *host, struct cxl_port *port, int nr_targets,
 		return cxld;
 
 	dev = &cxld->dev;
-	rc = dev_set_name(dev, "decoder%d.%d", port->id, cxld->id);
+	rc = dev_set_name(dev, "decoder%d.%d", port ? port->id : 0, cxld->id);
 	if (rc)
 		goto err;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 53927f9fa77e..b9302d3861f0 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -285,9 +285,9 @@ devm_cxl_add_decoder(struct device *host, struct cxl_port *port, int nr_targets,
  * 0-length until the first CXL region is activated.
  */
 static inline struct cxl_decoder *
-devm_cxl_add_passthrough_decoder(struct device *host, struct cxl_port *port)
+devm_cxl_add_passthrough_decoder(struct device *host)
 {
-	return devm_cxl_add_decoder(host, port, 1, 0, 0, 1, PAGE_SIZE,
+	return devm_cxl_add_decoder(host, NULL, 1, 0, 0, 1, PAGE_SIZE,
 				    CXL_DECODER_EXPANDER, 0);
 }
 
-- 
2.32.0

