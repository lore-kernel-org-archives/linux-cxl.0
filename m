Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4381EC433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 23:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiERXek (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 May 2022 19:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiERXej (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 May 2022 19:34:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5DACE3F
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 16:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652916878; x=1684452878;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NXOLM63dP+0SvGW9XL/NsoyhsO2PuAAsdgA8OuqLBgU=;
  b=OeOw8aBffFUqtDBVkmc3Ip9wYYFcT3t8Ax7E8YMmdowCwJ5P3/pZ+Tg0
   +efnXzntKKi5z+c0TfR0n3JNPlldpFORlG+F60k6253SilrIFJ1blHuQ+
   nhXk4ExoXJYcIdGjKhpULWAMChBlBu8mVgZ2wpIfS0avPEAsyTy38YIFB
   GYGyXMMwMpGM7RjnQnQT4IbezDDHBE9TdSS//A67VzLUgmwtDmebQ36NM
   aTxIKmoNN5u/c5I9LziAGcWPNCLEFppSjeoc4qnjslCp4X1wHczLw/iJf
   Gwm570YDAHOKb0Im7AduDaX26RsyOTKabaT4HcczbSL9dMPIOM57j9+L/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="297239430"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="297239430"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 16:34:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="661417015"
Received: from vgarg-mobl2.amr.corp.intel.com (HELO [192.168.1.101]) ([10.209.5.211])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 16:34:38 -0700
Subject: [PATCH v3 05/13] cxl/mem: Validate port connectivity before dvsec
 ranges
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Wed, 18 May 2022 16:34:37 -0700
Message-ID: <165291687749.1426646.18091538443879226995.stgit@dwillia2-xfh>
In-Reply-To: <165291684910.1426646.8615474651213855015.stgit@dwillia2-xfh>
References: <165291684910.1426646.8615474651213855015.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for validating DVSEC ranges against the platform declared
CXL memory ranges (ACPI CFMWS) move port enumeration before the
endpoint's decoder validation. Ultimately this logic will move to the
port driver, but create a bisect point before that larger move.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 184549e5093f..80e75a410499 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -140,22 +140,6 @@ static int cxl_mem_probe(struct device *dev)
 	if (work_pending(&cxlmd->detach_work))
 		return -EBUSY;
 
-	rc = cxlds->wait_media_ready(cxlds);
-	if (rc) {
-		dev_err(dev, "Media not active (%d)\n", rc);
-		return rc;
-	}
-
-	/*
-	 * If DVSEC ranges are being used instead of HDM decoder registers there
-	 * is no use in trying to manage those.
-	 */
-	if (!cxl_hdm_decode_init(cxlds)) {
-		dev_err(dev,
-			"Legacy range registers configuration prevents HDM operation.\n");
-		return -EBUSY;
-	}
-
 	rc = devm_cxl_enumerate_ports(cxlmd);
 	if (rc)
 		return rc;
@@ -181,6 +165,22 @@ static int cxl_mem_probe(struct device *dev)
 	if (rc)
 		return rc;
 
+	rc = cxlds->wait_media_ready(cxlds);
+	if (rc) {
+		dev_err(dev, "Media not active (%d)\n", rc);
+		return rc;
+	}
+
+	/*
+	 * If DVSEC ranges are being used instead of HDM decoder registers there
+	 * is no use in trying to manage those.
+	 */
+	if (!cxl_hdm_decode_init(cxlds)) {
+		dev_err(dev,
+			"Legacy range registers configuration prevents HDM operation.\n");
+		return -EBUSY;
+	}
+
 	/*
 	 * The kernel may be operating out of CXL memory on this device,
 	 * there is no spec defined way to determine whether this device

