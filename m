Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88860C43219
	for <linux-cxl@archiver.kernel.org>; Wed, 15 Sep 2021 16:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 736FD61353
	for <linux-cxl@archiver.kernel.org>; Wed, 15 Sep 2021 16:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238453AbhIOQBa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 15 Sep 2021 12:01:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:5744 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238473AbhIOQB3 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 15 Sep 2021 12:01:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="220483985"
X-IronPort-AV: E=Sophos;i="5.85,295,1624345200"; 
   d="scan'208";a="220483985"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 08:59:55 -0700
X-IronPort-AV: E=Sophos;i="5.85,295,1624345200"; 
   d="scan'208";a="583339280"
Received: from hliu15-mobl2.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.129.141])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 08:59:54 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2] cxl/core/bus: Document and tighten up decoder APIs
Date:   Wed, 15 Sep 2021 08:59:46 -0700
Message-Id: <20210915155946.308339-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Since the code to add decoders for switches and endpoints is on the
horizon, document the recently added interfaces that will be consumed by
them.

Part of the original version of this patch was subsumed by
f5786a5aedfc ("cxl/core: Split decoder setup into alloc + add")

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
v2:
- Dropped removal of host from cxl_decoder_add (Ben)
- Change nr_targets to unsigned int (Jonathan)
- Move description of 0 special case to param kdoc (Dan, Ben)
- Reword kdocs to be more accurate (Jonathan, Ben)
- Add back debug message to decoder_populate_targets (Ben)
---

 drivers/cxl/core/bus.c | 34 ++++++++++++++++++++++++++++++++--
 drivers/cxl/cxl.h      |  2 ++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 396252749477..d242afe08402 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -474,6 +474,7 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
 			rc = -ENXIO;
 			goto out_unlock;
 		}
+		dev_dbg(&cxld->dev, "%s: target: %d\n", dev_name(dport->dport), i);
 		cxld->target[i] = dport;
 	}
 
@@ -483,13 +484,28 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
 	return rc;
 }
 
-struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
+/**
+ * cxl_decoder_alloc - Allocate a new CXL decoder
+ * @port: owning port of this decoder
+ * @nr_targets: downstream targets accessible by this decoder. All upstream
+ *		ports and root ports must have at least 1 target. Endpoint
+ *		devices will have 0 targets. Callers wishing to register an
+ *		endpoint device should specify 0.
+ *
+ * A port should contain one or more decoders. Each of those decoders enable
+ * some address space for CXL.mem utilization. A decoder is expected to be
+ * configured by the caller before registering.
+ *
+ * Return: A new cxl decoder to be registered by cxl_decoder_add()
+ */
+struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
+				      unsigned int nr_targets)
 {
 	struct cxl_decoder *cxld;
 	struct device *dev;
 	int rc = 0;
 
-	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets < 1)
+	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets == 0)
 		return ERR_PTR(-EINVAL);
 
 	cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
@@ -521,6 +537,20 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
 }
 EXPORT_SYMBOL_GPL(cxl_decoder_alloc);
 
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
+ * Return: Negative error code if the decoder wasn't properly configured; else
+ *	   returns 0.
+ */
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
 {
 	struct cxl_port *port;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 7d6b011dd963..e632cc8da091 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -289,6 +289,8 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
 struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets);
+struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
+				      unsigned int nr_targets);
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
 int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
 
-- 
2.33.0

