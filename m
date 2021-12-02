Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C46C433F5
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Dec 2021 04:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355525AbhLBEnc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Dec 2021 23:43:32 -0500
Received: from mga09.intel.com ([134.134.136.24]:61245 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355501AbhLBEn1 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 1 Dec 2021 23:43:27 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="236438369"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="236438369"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:40:04 -0800
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="745717387"
Received: from liudanie-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.143.85])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:40:03 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 02/14] cxl: Introduce endpoint decoders
Date:   Wed,  1 Dec 2021 20:37:38 -0800
Message-Id: <20211202043750.3501494-3-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211202043750.3501494-1-ben.widawsky@intel.com>
References: <20211202043750.3501494-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Endpoints have decoders too. It is useful to share the same
infrastructure from cxl_core. Endpoints do not have dports (downstream
targets), only the underlying physical medium. As a result, some special
casing is needed.

There is no functional change introduced yet as endpoints don't actually
enumerate decoders yet.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
Dan brought up having an endpoint specific API for adding decoders.
Ultimately I didn't see value in doing this, so it's not here. I'm open
for discussion. Until the final patch in the series, there isn't much
reason to have it.
---
 drivers/cxl/core/bus.c | 54 ++++++++++++++++++++++++++++++++++++------
 drivers/cxl/cxl.h      |  1 +
 2 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 2f72087846e3..2bf9c0704a70 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -187,6 +187,12 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
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
@@ -196,6 +202,12 @@ static void cxl_decoder_release(struct device *dev)
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
@@ -208,6 +220,11 @@ static const struct device_type cxl_decoder_root_type = {
 	.groups = cxl_decoder_root_attribute_groups,
 };
 
+static bool is_endpoint_decoder(struct device *dev)
+{
+	return dev->type == &cxl_decoder_endpoint_type;
+}
+
 bool is_root_decoder(struct device *dev)
 {
 	return dev->type == &cxl_decoder_root_type;
@@ -499,7 +516,9 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
  * cxl_decoder_alloc - Allocate a new CXL decoder
  * @port: owning port of this decoder
  * @nr_targets: downstream targets accessible by this decoder. All upstream
- *		ports and root ports must have at least 1 target.
+ *		ports and root ports must have at least 1 target. Endpoint
+ *		devices will have 0 targets. Callers wishing to register an
+ *		endpoint device should specify 0.
  *
  * A port should contain one or more decoders. Each of those decoders enable
  * some address space for CXL.mem utilization. A decoder is expected to be
@@ -516,7 +535,7 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 	struct device *dev;
 	int rc = 0;
 
-	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets == 0)
+	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE)
 		return ERR_PTR(-EINVAL);
 
 	cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
@@ -583,6 +602,24 @@ struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_switch_decoder_alloc, CXL);
 
+/**
+ * cxl_endpoint_decoder_alloc - Allocate an endpoint decoder
+ * @port: owning port of this decoder
+ *
+ * Return: A new cxl decoder to be registered by cxl_decoder_add()
+ */
+struct cxl_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port)
+{
+	struct cxl_decoder *cxld;
+
+	cxld = cxl_decoder_alloc(port, 0);
+	if (!IS_ERR(cxld))
+		cxld->dev.type = &cxl_decoder_endpoint_type;
+
+	return cxld;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_alloc, CXL);
+
 /**
  * cxl_decoder_add - Add a decoder with targets
  * @cxld: The cxl decoder allocated by cxl_decoder_alloc()
@@ -614,12 +651,15 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
 	if (cxld->interleave_ways < 1)
 		return -EINVAL;
 
-	port = to_cxl_port(cxld->dev.parent);
-	rc = decoder_populate_targets(cxld, port, target_map);
-	if (rc)
-		return rc;
-
 	dev = &cxld->dev;
+
+	port = to_cxl_port(cxld->dev.parent);
+	if (!is_endpoint_decoder(dev)) {
+		rc = decoder_populate_targets(cxld, port, target_map);
+		if (rc)
+			return rc;
+	}
+
 	rc = dev_set_name(dev, "decoder%d.%d", port->id, cxld->id);
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a036594ec5b3..9b3904788762 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -292,6 +292,7 @@ struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 					   unsigned int nr_targets);
 struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
 					     unsigned int nr_targets);
+struct cxl_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port);
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
 int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
 
-- 
2.34.1

