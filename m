Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486FEC433FE
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32FE061108
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243682AbhJPFRr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 16 Oct 2021 01:17:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:1736 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238136AbhJPFRq (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sat, 16 Oct 2021 01:17:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="225489595"
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="225489595"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:39 -0700
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="442743252"
Received: from asimon-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.133.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:39 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 06/27] cxl: Introduce endpoint decoders
Date:   Fri, 15 Oct 2021 22:15:10 -0700
Message-Id: <20211016051531.622613-7-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211016051531.622613-1-ben.widawsky@intel.com>
References: <20211016051531.622613-1-ben.widawsky@intel.com>
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

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/core/bus.c | 40 ++++++++++++++++++++++++++++++++--------
 drivers/cxl/cxl.h      |  3 ++-
 2 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 454d4d846eb2..5564a71773e2 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -175,6 +175,12 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
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
@@ -184,6 +190,12 @@ static void cxl_decoder_release(struct device *dev)
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
@@ -196,6 +208,11 @@ static const struct device_type cxl_decoder_root_type = {
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
@@ -483,7 +500,8 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
 	return rc;
 }
 
-struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
+struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
+				      unsigned int nr_targets)
 {
 	struct cxl_decoder *cxld, cxld_const_init = {
 		.nr_targets = nr_targets,
@@ -491,7 +509,7 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
 	struct device *dev;
 	int rc = 0;
 
-	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets < 1)
+	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE)
 		return ERR_PTR(-EINVAL);
 
 	cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
@@ -510,8 +528,11 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
 	dev->parent = &port->dev;
 	dev->bus = &cxl_bus_type;
 
+	/* Endpoints don't have a target list */
+	if (nr_targets == 0)
+		dev->type = &cxl_decoder_endpoint_type;
 	/* root ports do not have a cxl_port_type parent */
-	if (port->dev.parent->type == &cxl_port_type)
+	else if (port->dev.parent->type == &cxl_port_type)
 		dev->type = &cxl_decoder_switch_type;
 	else
 		dev->type = &cxl_decoder_root_type;
@@ -538,12 +559,15 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
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
index 7f2e2bdc7883..91b8fd54bc93 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -293,7 +293,8 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
-struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets);
+struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
+				      unsigned int nr_targets);
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
 int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
 
-- 
2.33.1

