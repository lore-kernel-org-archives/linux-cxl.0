Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253A7C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 12 May 2022 18:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240911AbiELSPZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 12 May 2022 14:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357522AbiELSPY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 12 May 2022 14:15:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00CD27018D
        for <linux-cxl@vger.kernel.org>; Thu, 12 May 2022 11:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652379321; x=1683915321;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lQv9o1j6GaqzvvQejadVWE3cCvclQ+3ai72OgyR8b0c=;
  b=F8Hxbyfm2lhzdhmcTfhzh9EY8FNAzL9NhMMajnXnH7C7WRqH3L7CIL46
   KRbzlUDFrpbcaUPQ16Gv+s/1I5+YktYqrmGKmsGeh2a+b9h3/e1t372oS
   ZxKtzj9ziebz8CQ4pAh9N/2j+h6ac337AIHiUMYhTmnb9RCqNvHM1r+L1
   y8jAFlkAYC0DA9mR4mzY2KWMpJOfFnwA7/la0LV8t5XoJX7MclWRNrP64
   ZwENMZMhifcyOKUnLH31bU17ckPmAvp7UJPbnE8q4PX6VgaVuuwy3FJvL
   M0LJYGtYu6c4T9SEBdmUTm5iPSrJ1+JhxMroDMCEO7Wlpm1tF30Dw31Q6
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="269769339"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="269769339"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:15:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="521076833"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:15:21 -0700
Subject: [PATCH 12/14] cxl/port: Move endpoint HDM Decoder Capability init
 to port driver
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan.Cameron@huawei.com, ben.widawsky@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com
Date:   Thu, 12 May 2022 11:15:21 -0700
Message-ID: <165237932097.3832067.9953094210099463536.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The responsibility for establishing HDM Decoder Capability based
operation is more closely tied to port enabling than memdev enabling
which is concerned with port enumeration. This later enables reusing
@cxlhdm for probing / controlling "global enable" for the HDM Decoder
Capability. For now, just do the nominal move.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c  |   11 -----------
 drivers/cxl/port.c |   11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 8ce89d128e36..c310f1fd3db0 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -54,7 +54,6 @@ static void enable_suspend(void *data)
 static int cxl_mem_probe(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
-	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_port *parent_port;
 	int rc;
 
@@ -94,16 +93,6 @@ static int cxl_mem_probe(struct device *dev)
 	if (rc)
 		return rc;
 
-	rc = cxl_hdm_decode_init(cxlds);
-	if (rc)
-		return rc;
-
-	rc = cxl_await_media_ready(cxlds);
-	if (rc) {
-		dev_err(dev, "Media not active (%d)\n", rc);
-		return rc;
-	}
-
 	/*
 	 * The kernel may be operating out of CXL memory on this device,
 	 * there is no spec defined way to determine whether this device
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index d420da5fc39c..a7deaeaf0276 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -38,11 +38,22 @@ static int cxl_port_probe(struct device *dev)
 
 	if (is_cxl_endpoint(port)) {
 		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
+		struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
 		get_device(&cxlmd->dev);
 		rc = devm_add_action_or_reset(dev, schedule_detach, cxlmd);
 		if (rc)
 			return rc;
+
+		rc = cxl_hdm_decode_init(cxlds);
+		if (rc)
+			return rc;
+
+		rc = cxl_await_media_ready(cxlds);
+		if (rc) {
+			dev_err(dev, "Media not active (%d)\n", rc);
+			return rc;
+		}
 	} else {
 		rc = devm_cxl_port_enumerate_dports(port);
 		if (rc < 0)

