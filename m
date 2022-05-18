Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC86C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 23:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiERXeS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 May 2022 19:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiERXeQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 May 2022 19:34:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7359587
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 16:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652916855; x=1684452855;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2Np2OQil9Ft/unfCAqXLguE/ZnhumMUcYqcsKAOsLrc=;
  b=D9hpLxao2mmGtYBcquT4dIf+9djCO7x/Hv5od3qibaAOdn6M+50qOvx/
   hVRtlgpawwwtRYBOLTJxIsDS5AaGCBL5nwWLyFf+Jn+oBwnZ8PYA2bnHd
   /uTk5AcqUeHzJOJzNvqKPo8XILowl9EA5rpa4tfuaKvfr1UnKKq2XGHat
   DtuGnSTS9IpDtmCgNW0AWDiPF+e4CKyTAlkcOZ7U/IHeGi2HlXK/AEc0Z
   vBMO36pX612Pk9M0kMEOyxd1ZA1MEb0yYD/Yygel34Fgh4BD76BFhlS8T
   U3FXaTc6v6jEJdVwAdy+NahLf4BK7rTCur2LxhE1vYnZanfXZ40qgR7Xb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="358346028"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="358346028"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 16:34:15 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="742580337"
Received: from vgarg-mobl2.amr.corp.intel.com (HELO [192.168.1.101]) ([10.209.5.211])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 16:34:15 -0700
Subject: [PATCH v3 01/13] cxl/mem: Drop mem_enabled check from
 wait_for_media()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Wed, 18 May 2022 16:34:15 -0700
Message-ID: <165291685501.1426646.10372821863672431074.stgit@dwillia2-xfh>
In-Reply-To: <165291684910.1426646.8615474651213855015.stgit@dwillia2-xfh>
References: <165291684910.1426646.8615474651213855015.stgit@dwillia2-xfh>
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
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

