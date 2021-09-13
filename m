Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75DEC433FE
	for <linux-cxl@archiver.kernel.org>; Mon, 13 Sep 2021 16:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADB0A60EFF
	for <linux-cxl@archiver.kernel.org>; Mon, 13 Sep 2021 16:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbhIMQfL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 13 Sep 2021 12:35:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:17901 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237242AbhIMQfL (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 13 Sep 2021 12:35:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="221393856"
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="221393856"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 09:33:55 -0700
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="469515035"
Received: from dvannith-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.128.229])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 09:33:54 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 2/3] cxl/core/bus: Document and tighten up decoder API
Date:   Mon, 13 Sep 2021 09:33:23 -0700
Message-Id: <20210913163324.1008564-3-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913163324.1008564-1-ben.widawsky@intel.com>
References: <20210913163324.1008564-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Since the code to add decoders for switches and endpoints is on the
horizon, document the recently added interfaces that will be consumed by
them. While doing this it became apparent that after a recent rework,
the decoder registration routine (cxl_decoder_add) no longer needed the
host device doing the enumeration.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/acpi.c     |  4 ++--
 drivers/cxl/core/bus.c | 36 ++++++++++++++++++++++++++++++------
 drivers/cxl/cxl.h      |  3 +--
 3 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 654a80547526..42879e8806ac 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -133,7 +133,7 @@ static void cxl_add_cfmws_decoders(struct device *dev,
 		cxld->interleave_granularity =
 			CFMWS_INTERLEAVE_GRANULARITY(cfmws);
 
-		rc = cxl_decoder_add(dev, cxld, target_map);
+		rc = cxl_decoder_add(cxld, target_map);
 		if (rc)
 			put_device(&cxld->dev);
 		else
@@ -346,7 +346,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 
 	single_port_map[0] = dport->port_id;
 
-	rc = cxl_decoder_add(host, cxld, single_port_map);
+	rc = cxl_decoder_add(cxld, single_port_map);
 	if (rc)
 		put_device(&cxld->dev);
 	else
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index be787685b13e..a51a77e725c1 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -453,8 +453,8 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport_dev, int port_id,
 }
 EXPORT_SYMBOL_GPL(cxl_add_dport);
 
-static int decoder_populate_targets(struct device *host,
-				    struct cxl_decoder *cxld,
+
+static int decoder_populate_targets(struct cxl_decoder *cxld,
 				    struct cxl_port *port, int *target_map)
 {
 	int rc = 0, i;
@@ -473,7 +473,7 @@ static int decoder_populate_targets(struct device *host,
 			rc = -ENXIO;
 			break;
 		}
-		dev_dbg(host, "%s: target: %d\n", dev_name(dport->dport), i);
+		dev_dbg(&cxld->dev, "%s: target: %d\n", dev_name(dport->dport), i);
 		cxld->target[i] = dport;
 	}
 	device_unlock(&port->dev);
@@ -481,6 +481,18 @@ static int decoder_populate_targets(struct device *host,
 	return rc;
 }
 
+/**
+ * cxl_decoder_alloc - Allocate a new CXL decoder
+ * @port: owning port of this decoder
+ * @nr_targets: downstream targets accessible by this decoder. While >= 1 is
+ *              defined by the CXL specification, due to error conditions it is
+ *              possible that a port may have 0 decoders.
+ *
+ * A port should contain one or more decoders. Each of those decoders enable
+ * some address space for CXL.mem utilization.
+ *
+ * Return: A new cxl decoder to be registered by cxl_decoder_add()
+ */
 struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
 {
 	struct cxl_decoder *cxld;
@@ -519,8 +531,20 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
 }
 EXPORT_SYMBOL_GPL(cxl_decoder_alloc);
 
-int cxl_decoder_add(struct device *host, struct cxl_decoder *cxld,
-		    int *target_map)
+/**
+ * cxl_decoder_add - Add a decoder with targets
+ * @cxld: The cxl decoder allocated by cxl_decoder_alloc()
+ * @target_map: A list of downstream ports that this decoder can direct memory
+ *              traffic to. These numbers should correspond with the port number
+ *              in the PCIe Link Capabilities structure.
+ *
+ * Return: 0 if decoder was successfully added.
+ *
+ * Certain types of decoders may not have any targets. The main example of this
+ * is an endpoint device. A more awkward example is a hostbridge whose root
+ * ports get hot added (technically possible, though unlikely).
+ */
+int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
 {
 	struct cxl_port *port;
 	struct device *dev;
@@ -536,7 +560,7 @@ int cxl_decoder_add(struct device *host, struct cxl_decoder *cxld,
 		return -EINVAL;
 
 	port = to_cxl_port(cxld->dev.parent);
-	rc = decoder_populate_targets(host, cxld, port, target_map);
+	rc = decoder_populate_targets(cxld, port, target_map);
 	if (rc)
 		return rc;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6c7a7e9af0d4..7d6b011dd963 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -289,8 +289,7 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
 struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets);
-int cxl_decoder_add(struct device *host, struct cxl_decoder *cxld,
-		    int *target_map);
+int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
 int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
 
 extern struct bus_type cxl_bus_type;
-- 
2.33.0

