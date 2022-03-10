Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0F9C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Mar 2022 08:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbiCJIkS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Mar 2022 03:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiCJIkR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 10 Mar 2022 03:40:17 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6F6136ED1
        for <linux-cxl@vger.kernel.org>; Thu, 10 Mar 2022 00:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646901557; x=1678437557;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xSWSeTX2/EXmmBG4dbCcQ5gCqEhUpPjQlO+fkHiTCxA=;
  b=gMviN6bbnl6bLNhS/a3Ctnou53bQbMof6M61wpWw6OBKMxCH+K1Vvh9e
   H4lAiTtS10xm5qg4lhsv0xe4lRaxq6HKUQR9Lh67bd/ycyybscx93g5Ah
   B64wYHaS9bUVv49eNtpcNLkB65/dUa8wbMWcLDKQ78k2aWsoqVQHm4O3z
   6IbIcz/va0r/BSXZMHmoJrpU/DjsgnsYmecT76LNFE6zuwkhOspvMvdxH
   cLFG+jrMz+p5WWgcQ4b36D5+v9vpgp7CNUkQs8nU/5VORLnMdRfCfq4n6
   9aleDRlKR3FKyiQFbkoD4R8tLYuF6xPO0SYJTUqljXof+UadA/QtRAcbX
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="235801232"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="235801232"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 00:39:17 -0800
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="611667760"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 00:39:17 -0800
Subject: [PATCH 1/2] cxl/mem: Drop DVSEC vs EFI Memory Map sanity check
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan.Cameron@huawei.com, ben.widawsky@intel.com
Date:   Thu, 10 Mar 2022 00:39:16 -0800
Message-ID: <164690155691.3326488.3362471282782924455.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164690155138.3326488.16049914482944930295.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164690155138.3326488.16049914482944930295.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

When the driver finds legacy DVSEC ranges active on a CXL Memory
Expander it indicates that platform firmware is not aware of, or is
deliberately disabling commone CXL 2.0 operation. In this case Linux
generally has no choice, but to leave the device alone.

The driver attempts to validate that the DVSEC range is in the EFI
memory map. Remove that logic since there is no requirement that the
BIOS publish DVSEC ranges in the EFI Memory Map.

In the future the driver will want to permanently reserve this capacity
out of the available CFMWS capacity and hide it from
request_free_mem_region(), but it serves no purpose to warn about the
range not appearing in the EFI Memory Map.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c |   24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 49a4b1c47299..cd4e8bba82aa 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -158,30 +158,8 @@ static int cxl_mem_probe(struct device *dev)
 	 * is no use in trying to manage those.
 	 */
 	if (!cxl_dvsec_decode_init(cxlds)) {
-		struct cxl_endpoint_dvsec_info *info = &cxlds->info;
-		int i;
-
-		/* */
-		for (i = 0; i < 2; i++) {
-			u64 base, size;
-
-			/*
-			 * Give a nice warning to the user that BIOS has really
-			 * botched things for them if it didn't place DVSEC
-			 * ranges in the memory map.
-			 */
-			base = info->dvsec_range[i].start;
-			size = range_len(&info->dvsec_range[i]);
-			if (size && !region_intersects(base, size,
-						       IORESOURCE_SYSTEM_RAM,
-						       IORES_DESC_NONE)) {
-				dev_err(dev,
-					"DVSEC range %#llx-%#llx must be reserved by BIOS, but isn't\n",
-					base, base + size - 1);
-			}
-		}
 		dev_err(dev,
-			"Active DVSEC range registers in use. Will not bind.\n");
+			"Legacy range registers configuration prevents HDM operation.\n");
 		return -EBUSY;
 	}
 

