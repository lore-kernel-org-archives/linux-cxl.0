Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66335C433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 23:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiERXe6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 May 2022 19:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiERXe4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 May 2022 19:34:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B1E14D34
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 16:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652916895; x=1684452895;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kpiYPIHhtLK2qY4RkNV8PkUq3rxgNpgUYbCyPRYTeSo=;
  b=KIF6DhlUfqfNJd+z0ub4lfCdWxJPm7ToMAnbkklbbJYN0jS7cT/xi2Lt
   X07WNgaqThv6voFmJre08EiN9ObezHyzEeJVc8jKB7cfgdgND7PVD+2ba
   SWEAT6JN762PBd15Nhid6pPkLQdotRIQkBgK7yqCX24bzXNwnNDpb7YyE
   34nWnBKxvf3rNmjrvl6mbySn7aF8Qn/sDHcc3/YrtfBYeyEdJFed3mk/j
   cbB7LWDB1ybPbnBZTkaULae8qek0X3WZGYXX3KnCQG4qf8MkuHc4pE+m+
   HE8+JBT4E5BElPYlfrThj7JI5AZHuGldCxPe98/NwdzpISDTFukL/V/NT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="332557958"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="332557958"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 16:34:55 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="817691230"
Received: from vgarg-mobl2.amr.corp.intel.com (HELO [192.168.1.101]) ([10.209.5.211])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 16:34:54 -0700
Subject: [PATCH v3 08/13] cxl/mem: Skip range enumeration if mem_enable clear
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Wed, 18 May 2022 16:34:54 -0700
Message-ID: <165291689442.1426646.18012291761753694336.stgit@dwillia2-xfh>
In-Reply-To: <165291684910.1426646.8615474651213855015.stgit@dwillia2-xfh>
References: <165291684910.1426646.8615474651213855015.stgit@dwillia2-xfh>
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
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

