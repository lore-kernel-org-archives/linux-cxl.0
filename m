Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C656CC433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 12 May 2022 18:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350774AbiELSPC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 12 May 2022 14:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357514AbiELSPB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 12 May 2022 14:15:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C0A26FA4A
        for <linux-cxl@vger.kernel.org>; Thu, 12 May 2022 11:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652379300; x=1683915300;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zze666qvQMNu6HVKjh7R8Wm10as/QTeoqP8rHiO9YIk=;
  b=WsX1RvXDhNUA/NiP0D5rEC+PrecAwZceoGWmRT+tG6Dp1tFCeiMF4Aik
   nET3vGS+xoqcb6uC8q1BzKlzgt/BMdqxhCGQ370BsvcA8Tg6RCoYViJXo
   0i1XWayBcFs8K6j0Vg6AsdpGpz//R3PLm7XVS+RQa1G/pZIHVrz3TQqg8
   ToCAvlEp31swsxxuXPK9ejbjxPR9ALbVWmlUnJapZA2XwkobF/oJbTxpm
   c6CVSawkKagsjpFthhdiDuR5PsPNg3e0Xu0fDRpknq9ArfPSCNi4m0CBj
   gkXclATu42p/kvFZUHLFbAr1D0DwIz3QfkEZR1AJbPhoST03hpC/8HKQQ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="250000508"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="250000508"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:15:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="636956879"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:15:00 -0700
Subject: [PATCH 08/14] cxl/mem: Skip range enumeration if mem_enable clear
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan.Cameron@huawei.com, ben.widawsky@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com
Date:   Thu, 12 May 2022 11:14:59 -0700
Message-ID: <165237929979.3832067.5582691867405954753.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

When a device does not have mem_enable set then the current range
settings are moot. Skip the enumeration and cause cxl_hdm_decode_init()
to proceed directly to enable the HDM Decoder Capability.

Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/pci.c |    2 ++
 drivers/cxl/mem.c      |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index ea6711721901..f3e59f8b6621 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -224,6 +224,8 @@ int cxl_dvsec_ranges(struct cxl_dev_state *cxlds,
 	}
 
 	info->mem_enabled = FIELD_GET(CXL_DVSEC_MEM_ENABLE, ctrl);
+	if (!info->mem_enabled)
+		return 0;
 
 	for (i = 0; i < hdm_count; i++) {
 		u64 base, size;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 0cfbde134fc7..902d1f6e189e 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -92,7 +92,7 @@ __mock bool cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
 	 * are expected even though Linux does not require or maintain that
 	 * match.
 	 */
-	if (!global_enable && info->ranges)
+	if (!global_enable && info->mem_enabled && info->ranges)
 		goto out;
 
 	retval = true;

