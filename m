Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC000C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 23:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiERXfO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 May 2022 19:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiERXfN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 May 2022 19:35:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E46E66AEB
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 16:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652916912; x=1684452912;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V4MABMeyiKpPofTcJgmIRL7yqOVm53Oofcq2jN23Rvg=;
  b=JhpbK4Y6LQX+Uuo4KhsCrsBPBzkERCbLZUzAKlRanjjNU9NaGtCgGEoe
   oUIwdR8e1EL22I7DVBxUWQ8026WpGCLi4hMyeWMf/mkrgCcFh4Lbx8wkO
   /gSwbG2xQCmr4CSc5FoHmTyQFhV/mUFbrStuHv9MsKtwF+gQCV+7m9t6M
   GLeyGcfXlVAoAONxngbCyyYtqHI8g5sG1Nisr44FcEgq/dv5VhQQ6B91Q
   E4aI28GrhoptpxTHaZfons7RHoLsiPMqN+2CdTDnFuW8uhpZL8+2H8ETj
   wP7DVGj5Zk9EhvkKTlyVky3eKZnzTsvZOsvs5CZoeZAIkXVkAfj7RuR7n
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="251836970"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="251836970"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 16:35:12 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="700850177"
Received: from vgarg-mobl2.amr.corp.intel.com (HELO [192.168.1.101]) ([10.209.5.211])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 16:35:11 -0700
Subject: [PATCH v3 11/13] cxl/port: Move endpoint HDM Decoder Capability
 init to port driver
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Wed, 18 May 2022 16:35:11 -0700
Message-ID: <165291691167.1426646.7936109077255288258.stgit@dwillia2-xfh>
In-Reply-To: <165291684910.1426646.8615474651213855015.stgit@dwillia2-xfh>
References: <165291684910.1426646.8615474651213855015.stgit@dwillia2-xfh>
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

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

