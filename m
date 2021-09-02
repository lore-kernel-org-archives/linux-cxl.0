Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58C9C4332F
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 19:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC7B360FDC
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 19:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhIBTva (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Sep 2021 15:51:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:41967 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231476AbhIBTvY (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 2 Sep 2021 15:51:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="198778194"
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="198778194"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 12:50:24 -0700
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="533451605"
Received: from kappusam-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.143.117])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 12:50:23 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 02/13] cxl/core/bus: Add kernel docs for decoder ops
Date:   Thu,  2 Sep 2021 12:50:06 -0700
Message-Id: <20210902195017.2516472-3-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210902195017.2516472-1-ben.widawsky@intel.com>
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Since the code to add decoders for switches and endpoints is on the
horizon, document the new interfaces that will be consumed by them.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/core/bus.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 3991ac231c3e..9d98dd50d424 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -453,6 +453,19 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport_dev, int port_id,
 }
 EXPORT_SYMBOL_GPL(cxl_add_dport);
 
+/**
+ * cxl_decoder_alloc - Allocate a new CXL decoder
+ * @port: owning port of this decoder
+ * @nr_targets: downstream targets accessible by this decoder
+ *
+ * A port should contain one or more decoders. Each of those decoders enable
+ * some address space for CXL.mem utilization. Therefore, it is logical to
+ * allocate decoders while enumerating a port. While >= 1 is defined by the CXL
+ * specification, due to error conditions it is possible that a port may have 0
+ * decoders.
+ *
+ * Return: A new cxl decoder which wants to be added with cxl_decoder_add()
+ */
 struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
 {
 	struct cxl_decoder *cxld;
@@ -491,6 +504,21 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
 }
 EXPORT_SYMBOL_GPL(cxl_decoder_alloc);
 
+/**
+ * cxl_decoder_add - Add a decoder with targets
+ * @host: The containing struct device. This is typically the PCI device that is
+ *        CXL capable
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
 int cxl_decoder_add(struct device *host, struct cxl_decoder *cxld,
 		    int *target_map)
 {
-- 
2.33.0

