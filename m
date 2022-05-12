Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1548BC433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 12 May 2022 18:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357486AbiELSO3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 12 May 2022 14:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357367AbiELSO2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 12 May 2022 14:14:28 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFB225F7B2
        for <linux-cxl@vger.kernel.org>; Thu, 12 May 2022 11:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652379267; x=1683915267;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JQJ2ke1G8tgJR7ls8Kra0CQWmbhTUyaEgGAgxPzykck=;
  b=Z/fYoU+hZueXEGidCbfzU7LdAuN43FAfpqAfc2UF4IkRnJvtVcLjQPWh
   baGx05+Mq3AbxR9TgrlPACh789SFgd+CICaC+ax+WNWgmTTb9HXT42/rF
   ljG93UcOBfQRxEkJTZJC/ngsQB2geiWmcNd014iGrENtus5QnrvECwB5L
   fnjYaO3/VNWI8XCmlx2Q8ccWmuuJDZrpvyEzge43mlx5vub/vsuD4L64M
   g5nYEPqoxYBjtrqPI/xX0ZdNPUJIYEwmfzJN6ra4QJdSNMUd4Quq2NZJS
   Qug6vg/xUeuCwFefjhVdx+u4+edlNuOF0zBKjuPmFXL8+NOmONKGnPev+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="267688746"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="267688746"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:14:27 -0700
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="712038101"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:14:27 -0700
Subject: [PATCH 02/14] cxl/pci: Consolidate wait_for_media() and
 wait_for_media_ready()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan.Cameron@huawei.com, ben.widawsky@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com
Date:   Thu, 12 May 2022 11:14:27 -0700
Message-ID: <165237926697.3832067.1507642241143366624.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Now that wait_for_media() does nothing supplemental to
wait_for_media_ready() just promote wait_for_media_ready() to a common
helper and drop wait_for_media().

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c |   19 +------------------
 drivers/cxl/pci.c |    4 ++--
 2 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index c2d9dadf4a2e..7622cfefa1b0 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -24,23 +24,6 @@
  * in higher level operations.
  */
 
-static int wait_for_media(struct cxl_memdev *cxlmd)
-{
-	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	int rc;
-
-	rc = cxlds->wait_media_ready(cxlds);
-	if (rc)
-		return rc;
-
-	/*
-	 * We know the device is active, and enabled, if any ranges are non-zero
-	 * we'll need to check later before adding the port since that owns the
-	 * HDM decoder registers.
-	 */
-	return 0;
-}
-
 static int create_endpoint(struct cxl_memdev *cxlmd,
 			   struct cxl_port *parent_port)
 {
@@ -157,7 +140,7 @@ static int cxl_mem_probe(struct device *dev)
 	if (work_pending(&cxlmd->detach_work))
 		return -EBUSY;
 
-	rc = wait_for_media(cxlmd);
+	rc = cxlds->wait_media_ready(cxlds);
 	if (rc) {
 		dev_err(dev, "Media not active (%d)\n", rc);
 		return rc;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index e7ab9a34d718..435f9f89b793 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -423,7 +423,7 @@ static int wait_for_valid(struct cxl_dev_state *cxlds)
  * Wait up to @mbox_ready_timeout for the device to report memory
  * active.
  */
-static int wait_for_media_ready(struct cxl_dev_state *cxlds)
+static int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	int d = cxlds->cxl_dvsec;
@@ -593,7 +593,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		dev_warn(&pdev->dev,
 			 "Device DVSEC not present, skip CXL.mem init\n");
 
-	cxlds->wait_media_ready = wait_for_media_ready;
+	cxlds->wait_media_ready = cxl_await_media_ready;
 
 	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
 	if (rc)

