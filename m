Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE10C49361
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 00:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A753361209
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 00:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbhFRAyP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:54:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:2051 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232959AbhFRAyO (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 17 Jun 2021 20:54:14 -0400
IronPort-SDR: viqBM1Q/JSwxUTNR0TPIGNjvZVreTB/GwdrFLMc+RYB4/3vzKfbHYr0QrQg+sfasDjTB7X4ch+
 ZQumfE9FQp5w==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="292105416"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="292105416"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 17:52:06 -0700
IronPort-SDR: LNmyb2K+iyTY2+BotB385HeIsU4Fb5zMcM4JjM7597n641ZwB1KS3Ard6KVUq+9peSNYHW3CNJ
 Fz/nStlMMawQ==
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="622223113"
Received: from mkalyani-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.138.30])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 17:52:06 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 1/5] cxl/region: Only allow CXL capable targets
Date:   Thu, 17 Jun 2021 17:51:56 -0700
Message-Id: <20210618005200.997804-2-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618005200.997804-1-ben.widawsky@intel.com>
References: <20210618005200.997804-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

A cxl_memdev exists for all CXL endpoints that support the CXL.io
protocol. If that device cannot participate in CXL.mem protocol, then it
cannot be part of a region's interleave set.

The ABI allows setting a target which is currently not CXL.mem capable
and only will fail when the binding to the region driver occurs. This is
in line with the other configuration parameters which are only strictly
validated when the driver gets bound to the region.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.h    |  5 +++++
 drivers/cxl/region.c | 12 +++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
index ff1f9c57e089..3d51bf6c090f 100644
--- a/drivers/cxl/mem.h
+++ b/drivers/cxl/mem.h
@@ -84,4 +84,9 @@ struct cxl_mem {
 	struct range ram_range;
 };
 
+static inline bool is_cxl_capable(struct cxl_memdev *cxlmd)
+{
+	return false;
+}
+
 #endif /* __CXL_MEM_H__ */
diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index 2e73ece001ec..837f4314ffcc 100644
--- a/drivers/cxl/region.c
+++ b/drivers/cxl/region.c
@@ -176,6 +176,10 @@ static size_t set_targetN(struct cxl_region *region, const char *buf, int n, siz
 		return -ENOENT;
 
 	cxlmd = to_cxl_memdev(memdev_dev);
+	if (!is_cxl_capable(cxlmd))
+		dev_dbg(&region->dev,
+			"Setting a target which doesn't support CXL.mem");
+
 	get_device(&cxlmd->dev);
 	region->targets[n] = cxlmd;
 
@@ -432,11 +436,17 @@ static int bind_region(struct cxl_region *region)
 		return -ENXIO;
 	}
 
-	for (i = 0; i < region->eniw; i++)
+	for (i = 0; i < region->eniw; i++) {
 		if (!region->targets[i]) {
 			trace_cxl_region_bind(region, "Missing memory device target");
 			return -ENXIO;
 		}
+		if (!is_cxl_capable(region->targets[i])) {
+			trace_cxl_region_bind(region,
+					      "Target isn't CXL.mem capable");
+			return -ENODEV;
+		}
+	}
 
 	rc = allocate_region_addr(region);
 	if (rc)
-- 
2.32.0

