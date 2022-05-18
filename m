Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2D6C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 23:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiERXe2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 May 2022 19:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiERXe1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 May 2022 19:34:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3625ACE01
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 16:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652916867; x=1684452867;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0qD3bR9kyt+HHORwSCUHy2Fyxu3uM+F0gMBhnJj/ad0=;
  b=m5cef9VqQZYRmkaULvTKofFYiZFgeM10kECgxtBL8GNlsSN+XkVmPrdi
   eFuI8rrhbv/nHnqDgQOQAUNI+PXDKyeItCBdp2SDRpbzEXsxYZB+kLj0S
   yirO7/e+CSpJ47ILZkRQWRTtqA0TiYliLgBurgPUy4HWtv4+dMP3FITAP
   CBNZz7Z7s92HcItSjuQzLt6G2LGxF3ERb8nV/GE351N5fJQnMTo9GHpBF
   h81V4qnBqfkQIigx4Lck21hsaHMEDkJ4A2kNCuO1WIdFAk5hcNkA4yuO4
   UAaakOFV3fUnRMxcemUtk4uxzAnVF8e8ooHmznmpE7tAxVSUfR7jVcpTU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="269525739"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="269525739"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 16:34:26 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="700850057"
Received: from vgarg-mobl2.amr.corp.intel.com (HELO [192.168.1.101]) ([10.209.5.211])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 16:34:26 -0700
Subject: [PATCH v3 03/13] cxl/pci: Drop wait_for_valid() from
 cxl_await_media_ready()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Wed, 18 May 2022 16:34:26 -0700
Message-ID: <165291686632.1426646.7479581732894574486.stgit@dwillia2-xfh>
In-Reply-To: <165291684910.1426646.8615474651213855015.stgit@dwillia2-xfh>
References: <165291684910.1426646.8615474651213855015.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

A check mem_info_valid already happens in __cxl_dvsec_ranges(). Rely on
that instead of calling wait_for_valid again.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/pci.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 435f9f89b793..91b266911e52 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -431,10 +431,6 @@ static int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 	u64 md_status;
 	int rc, i;
 
-	rc = wait_for_valid(cxlds);
-	if (rc)
-		return rc;
-
 	for (i = mbox_ready_timeout; i; i--) {
 		u32 temp;
 

