Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFF0C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 12 May 2022 18:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241392AbiELSOZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 12 May 2022 14:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357367AbiELSOX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 12 May 2022 14:14:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3E026CC54
        for <linux-cxl@vger.kernel.org>; Thu, 12 May 2022 11:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652379262; x=1683915262;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SJ72OTimSXCcHe8hE4RHzqU8RP3yE45yPOPydjdryf0=;
  b=hXtiJZsz0fnZkoYMKbY9iEPu4NsEVWVHZqACGNfwf6vzEm3/abVeaaXi
   slweAh76t4gDBM3pNQ9G5/QusQ2r/Epy86UcrWEgdIt/jruDy6mKTt1Tm
   cTe51c6QYdBi6Sq1NtlHpd0hDFTq1U/LZTRYR3AO0G80WyvQ+sej3U7Vd
   LzS7O+6FwEA8a9rD2ItqB14PwGQN6MfkJMKyuo9kLnihoCf0tGPXLONpD
   VjIy3zYYIYS/qOezq1pUDa9QUJGFcYcbUGQvLznw+vVKUaHIQ8XX5OzHt
   yPFEXeVycxSeQ0cby5UiCf1saFDqV21Q0ScIQ1TADJg8SeSNp7YV7vOI3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="268934822"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="268934822"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:14:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="542899219"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:14:21 -0700
Subject: [PATCH 01/14] cxl/mem: Drop mem_enabled check from wait_for_media()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan.Cameron@huawei.com, ben.widawsky@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com
Date:   Thu, 12 May 2022 11:14:21 -0700
Message-ID: <165237926188.3832067.15441813087107623945.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Media ready is asserted by the device independent of whether mem_enabled
was ever set. Drop this check to allow for dropping wait_for_media() in
favor of ->wait_media_ready().

Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 401b0fbe21db..c2d9dadf4a2e 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -27,12 +27,8 @@
 static int wait_for_media(struct cxl_memdev *cxlmd)
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	struct cxl_endpoint_dvsec_info *info = &cxlds->info;
 	int rc;
 
-	if (!info->mem_enabled)
-		return -EBUSY;
-
 	rc = cxlds->wait_media_ready(cxlds);
 	if (rc)
 		return rc;

