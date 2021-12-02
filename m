Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2831C433FE
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Dec 2021 04:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355531AbhLBEnx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Dec 2021 23:43:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:61244 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355520AbhLBEnq (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 1 Dec 2021 23:43:46 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="236438384"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="236438384"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:40:09 -0800
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="745717465"
Received: from liudanie-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.143.85])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:40:08 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 10/14] cxl: Make passthrough decoder init implicit
Date:   Wed,  1 Dec 2021 20:37:46 -0800
Message-Id: <20211202043750.3501494-11-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211202043750.3501494-1-ben.widawsky@intel.com>
References: <20211202043750.3501494-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Unused CXL decoders, or ports which use a passthrough decoder (no HDM
decoder registers) are expected to be initialized in a specific way.
Since upcoming drivers will want the same initialization, and it was
already a requirement to have consumers of the API configure the decoder
specific to their needs, initialize to this passthrough state by
default.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
This came up during review of v1:
https://lore.kernel.org/linux-cxl/20211120000250.1663391-1-ben.widawsky@intel.com/T/#me8f127f3a7474396318418d748cefc29ed97cfa5
---
 drivers/cxl/acpi.c     | 5 -----
 drivers/cxl/core/bus.c | 9 ++++++++-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 8960ff1d5729..8dee8ebdec9d 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -263,11 +263,6 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	if (IS_ERR(cxld))
 		return PTR_ERR(cxld);
 
-	cxld->interleave_ways = 1;
-	cxld->interleave_granularity = PAGE_SIZE;
-	cxld->target_type = CXL_DECODER_EXPANDER;
-	cxld->platform_res = (struct resource)DEFINE_RES_MEM(0, 0);
-
 	device_lock(&port->dev);
 	dport = list_first_entry(&port->dports, typeof(*dport), list);
 	device_unlock(&port->dev);
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 98cd52c2a266..7da5fbe7a1af 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -601,7 +601,8 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
  * some address space for CXL.mem utilization. A decoder is expected to be
  * configured by the caller before registering.
  *
- * Return: A new cxl decoder to be registered by cxl_decoder_add()
+ * Return: A new cxl decoder to be registered by cxl_decoder_add(). The decoder
+ *	   is initialized to be a "passthrough" decoder.
  */
 static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 					     unsigned int nr_targets)
@@ -631,6 +632,12 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 	dev->parent = &port->dev;
 	dev->bus = &cxl_bus_type;
 
+	/* Pre initialize an "empty" decoder */
+	cxld->interleave_ways = 1;
+	cxld->interleave_granularity = PAGE_SIZE;
+	cxld->target_type = CXL_DECODER_EXPANDER;
+	cxld->platform_res = (struct resource)DEFINE_RES_MEM(0, 0);
+
 	return cxld;
 err:
 	kfree(cxld);
-- 
2.34.1

