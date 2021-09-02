Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A8EC43217
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 19:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F085861041
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 19:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347406AbhIBTvb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Sep 2021 15:51:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:41971 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241385AbhIBTvZ (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 2 Sep 2021 15:51:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="198778197"
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="198778197"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 12:50:24 -0700
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="533451612"
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
Subject: [PATCH 03/13] cxl/core: Ignore interleave when adding decoders
Date:   Thu,  2 Sep 2021 12:50:07 -0700
Message-Id: <20210902195017.2516472-4-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210902195017.2516472-1-ben.widawsky@intel.com>
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Decoders will be added to the bus either already active (committed in
spec parlance), or inactive. From the driver perspective, the set of
devices comprising the former are those which are brought up by system
firmware; decoders that implement: volatile regions, persistent regions,
or platform specific (ie. CFMWS) constraints. Such devices have a given
interleave programming already in place. Inactive decoders on the other
hand, do not have any interleave programming in place. The set of
devices comprising that are hostbridges, switches, and endpoint devices.

Allow adding inactive decoders by removing this check.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/core/bus.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 9d98dd50d424..8d5061b0794d 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -532,9 +532,6 @@ int cxl_decoder_add(struct device *host, struct cxl_decoder *cxld,
 	if (IS_ERR(cxld))
 		return PTR_ERR(cxld);
 
-	if (cxld->interleave_ways < 1)
-		return -EINVAL;
-
 	port = to_cxl_port(cxld->dev.parent);
 	device_lock(&port->dev);
 	if (list_empty(&port->dports)) {
-- 
2.33.0

