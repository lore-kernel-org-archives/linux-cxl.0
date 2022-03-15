Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408CCC433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 15 Mar 2022 01:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbiCOBXe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Mar 2022 21:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiCOBXe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Mar 2022 21:23:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CA9473AD
        for <linux-cxl@vger.kernel.org>; Mon, 14 Mar 2022 18:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647307343; x=1678843343;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PKszj6CAu8MoHMDEAuVMKAqw3WQzc+XKu47yhB2+r6k=;
  b=T2p0LN1K9irzxHtILAr9YD4J8S3A2E8Y6XIEKKTkzaC1ELt/NXY4JPpG
   KA4YKMFEwCTd7nn5yzJMGcyXu7AIs0UeHkC69B5SkK/s2tVFYCTey+u1Z
   U6g2DL37ah/ANNsj8elEjbsJkMKI+/4GX2pKkF2IXLpW4pEl8SNUNeeTr
   WsDutlX0yU096eZeyTnLaz2GX6IonBIQV6adp2nYQYaRV9YmA3Us7nv4G
   ++z9SQ8Kq3Qu5mUBTiHJely0v0Bj6ocfnJHIpTqb5w4qf0gW4vjjFNA0I
   CA0L0BPw5WXusDjH5d7mPaW5LBLOPKrMqh1UnZoCSnbn4Z530jeP/C44M
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="238353707"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="238353707"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 18:22:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="634418536"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 18:22:22 -0700
Subject: [PATCH v2 1/6] cxl/mem: Drop DVSEC vs EFI Memory Map sanity check
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Davidlohr Bueso <dave@stgolabs.net>, ben.widawsky@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
Date:   Mon, 14 Mar 2022 18:22:22 -0700
Message-ID: <164730734246.3806189.13995924771963139898.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

When the driver finds legacy DVSEC ranges active on a CXL Memory
Expander it indicates that platform firmware is not aware of, or is
deliberately disabling common CXL 2.0 operation. In this case Linux
generally has no choice, but to leave the device alone.

The driver attempts to validate that the DVSEC range is in the EFI
memory map. Remove that logic since there is no requirement that the
BIOS publish DVSEC ranges in the EFI Memory Map.

In the future the driver will want to permanently reserve this capacity
out of the available CFMWS capacity and hide it from
request_free_mem_region(), but it serves no purpose to warn about the
range not appearing in the EFI Memory Map.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
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
 

