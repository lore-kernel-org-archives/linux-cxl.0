Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D999C43334
	for <linux-cxl@archiver.kernel.org>; Sat, 23 Jul 2022 00:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiGWA6D (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Jul 2022 20:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236596AbiGWA5t (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 22 Jul 2022 20:57:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081D1CA763
        for <linux-cxl@vger.kernel.org>; Fri, 22 Jul 2022 17:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658537776; x=1690073776;
  h=subject:from:to:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=KsivkXgRo5zRyqP6+Ga5pUqtKe+eKKiV2yeQsKUryzs=;
  b=PBfnq8A1UMIE93ZubsJQny1kTDPKGxrp6mcmpVeh3Ttanfc/KNFbtwRL
   XdGNNtXRMXiGaoClu7iDziHTXqUlINSh9BLlccxfDdYyql2xI7Vma2zAx
   RfUwGJqyvXn4+1o7LrknKkZjRqUEIjiaIi8w5xvB28xCVdWfpmyDW8fS2
   eX6JB/940y7uy9oapuvvVLfosicaG4j3lc+P4QKIwGe77KetmpgaHWbfe
   oA8NGvIa5uYQQVsYpg1QcUyyQsbVrxMMcUri5JkyDhLwf8IBnZl4RhKXg
   Onp2nmsTEgBgKxifGWgf3ExFrjtggh/6eeEundSnOVwG7OFTnLPBXE15Z
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="267206914"
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="267206914"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 17:56:15 -0700
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="631750287"
Received: from jeescalx-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.116.64])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 17:56:15 -0700
Subject: [PATCH 4/5] cxl/region: Stop initializing interleave granularity
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Date:   Fri, 22 Jul 2022 17:56:14 -0700
Message-ID: <165853777484.2430596.3423921169034844397.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
References: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for a patch that validates that the region ways setting
is compatible with the granularity setting, the initial granularity
setting needs to start at zero to indicate "unset".

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index df35d3c475a0..05b6212e6399 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1524,7 +1524,6 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 					      enum cxl_decoder_type type)
 {
 	struct cxl_port *port = to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
-	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
 	struct device *dev;
@@ -1536,7 +1535,6 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	p = &cxlr->params;
 	cxlr->mode = mode;
 	cxlr->type = type;
-	p->interleave_granularity = cxld->interleave_granularity;
 
 	dev = &cxlr->dev;
 	rc = dev_set_name(dev, "region%d", id);

