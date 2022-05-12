Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA86AC433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 12 May 2022 18:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357500AbiELSOm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 12 May 2022 14:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357502AbiELSOl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 12 May 2022 14:14:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C44B20D577
        for <linux-cxl@vger.kernel.org>; Thu, 12 May 2022 11:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652379281; x=1683915281;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HYdzkFyxMlaUDNjqPAmP2WI3qyezQm0oUj65UbmDN2w=;
  b=mu+WOs9pAX5ouPJsikGzN99eQTq94icmPnHSp5j/wqZjYL4lrvtyZQkW
   pdilIZS22u80XDTrwbsSks37YTIas4e/SOrxnHfgvI+oHR+UgCeCsA82a
   kd1oqstDIqVUm0UQ/fTyDd9kLjRjT+XgnPKDKlFdiR0/qsjnVbXt62+W1
   CChv6L5E8AONFiXTvTSc4XbZgRNDFriQunC5AJ3cQp2mJIbRIkIFBjTAQ
   xPtSM3ZvIgygcNFO7D9kDwb5CagQqOiSv3vX2LH2Yl+x3DRkKp27a0c8/
   tx+DdXh4OYEkTNlGfeJPDwZXxRMiZLrPVdVqryISLYpI9jUaQtPHlK9Yf
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="267688766"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="267688766"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:14:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="739812685"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:14:32 -0700
Subject: [PATCH 03/14] cxl/pci: Drop wait_for_valid() from
 cxl_await_media_ready()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan.Cameron@huawei.com, ben.widawsky@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com
Date:   Thu, 12 May 2022 11:14:32 -0700
Message-ID: <165237927263.3832067.8250303240842350003.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

A check mem_info_valid already happens in __cxl_dvsec_ranges(). Rely on
that instead of calling wait_for_valid again.

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
 

