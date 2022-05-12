Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A23C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 12 May 2022 18:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238839AbiELSPI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 12 May 2022 14:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351099AbiELSPG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 12 May 2022 14:15:06 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED1B26CC54
        for <linux-cxl@vger.kernel.org>; Thu, 12 May 2022 11:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652379306; x=1683915306;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2C4RFl/zdNX4eIV9KjokqHbFgt/Q5qb2q1A8tj19DKg=;
  b=FJ7MzOuJo7u2BPiqFJTPk4qSvxH9fIvUj8QnyqEVDr5bg30GRaoDYDPu
   jHPGeeR2ffCgShrkiz0Kf+DUbR5ytAe3HYcMiCODYHskwq3rFv01fRoMs
   W7MAC5j9DfzPTves9UZrALsRchvlCRaSTfJYm7/9Ll8JcOns5V2K0nwdJ
   fYUsH+iPVtyZAYqNdH/nYae2RILTd7c4MPZ3VOt61E494D6XQYvfwIkgO
   e3S1Woce7nCkzFtwQK/wRwn5hFeOfETfH9ETEGCcYirIZ0ExrdhOZx3xi
   ao/wudu5AgpCKkBZn6YBvJtxfhbltUIwgEZmto1NgCt8xpFsGMvPKlWQX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="270035400"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="270035400"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:15:05 -0700
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="553887327"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:15:05 -0700
Subject: [PATCH 09/14] cxl/mem: Fix CXL DVSEC Range Sizing
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan.Cameron@huawei.com, ben.widawsky@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com
Date:   Thu, 12 May 2022 11:15:05 -0700
Message-ID: <165237930521.3832067.16931437806464317011.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Per CXL 2.0 Section 8.1.3.8.4 "DVSEC CXL Range 1 Base Low" there is no
way to specify decode sizes smaller than 256M. Fix cxl_dvsec_ranges()
and cxl_hdm_decode_init() to account for that default decode range.
Note, that this means that any BIOS implementation that sets mem_enable,
but not HDM Decoder Capability enable will cause the driver to fail to
attach. A later change validates the DVSEC ranges against platform CXL
decode (CXL CFMWS) to make a decision about overriding the default DVSEC
Range configuration.

Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/pci.c |   10 +++++++---
 drivers/cxl/mem.c      |   10 +---------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index f3e59f8b6621..f1c0677a4f52 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -236,7 +236,12 @@ int cxl_dvsec_ranges(struct cxl_dev_state *cxlds,
 		if (rc)
 			return rc;
 
-		size = (u64)temp << 32;
+		/*
+		 * Per CXL 2.0 Section 8.1.3.8.4 "DVSEC CXL Range 1 Base
+		 * Low", the minimum decode size is 256MB
+		 */
+		size = SZ_256M;
+		size |= (u64)temp << 32;
 
 		rc = pci_read_config_dword(
 			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(i), &temp);
@@ -264,8 +269,7 @@ int cxl_dvsec_ranges(struct cxl_dev_state *cxlds,
 			.end = base + size - 1
 		};
 
-		if (size)
-			ranges++;
+		ranges++;
 	}
 
 	info->ranges = ranges;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 902d1f6e189e..af4a88d3c5fa 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -84,15 +84,7 @@ __mock bool cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
 			    CXL_HDM_DECODER_CTRL_OFFSET);
 	global_enable = global_ctrl & CXL_HDM_DECODER_ENABLE;
 
-	/*
-	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
-	 * [High,Low] when HDM operation is enabled the range register values
-	 * are ignored by the device, but the spec also recommends matching the
-	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
-	 * are expected even though Linux does not require or maintain that
-	 * match.
-	 */
-	if (!global_enable && info->mem_enabled && info->ranges)
+	if (!global_enable && info->mem_enabled)
 		goto out;
 
 	retval = true;

