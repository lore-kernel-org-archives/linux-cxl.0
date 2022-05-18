Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7F3C433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 23:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiERXe1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 May 2022 19:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiERXeX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 May 2022 19:34:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E47E14D34
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 16:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652916861; x=1684452861;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JxO0LRnkK5fFxANLzmoJwwsJz6JOmPho44/EPfc+hNs=;
  b=Q1BXtLfhGVwCcivVGYc3aF9wyRGzQg4D6Sl+Y38SMApTqjiZVQIHyh+I
   uc0avLU4qk2ODtXt3vwkzoCvfc7TyeEGojoGxLNhLuJKq7QzYYOVbUESP
   +gWxMnJRnVqCsIkrAnBvboxBKdMiIduUw8ezPLdfFvDf1i61O8Wui5h3P
   k7UvEupplRJDCdTsYz3IbzQAZe/oYjd7zLOKJzSvqBy33QhyynG7NYt/7
   aQXmi7R56zD+UDoiwWQ7VY4jxEeqbDvqMIgWkEELcKIu/9NKEBoFtukHN
   cEuKR4DQ2Ce0Mpbzd650wa6kyy6M9d3EWKS/JqlRd7NSyoilSBs+yhhMN
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="251836799"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="251836799"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 16:34:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="661416981"
Received: from vgarg-mobl2.amr.corp.intel.com (HELO [192.168.1.101]) ([10.209.5.211])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 16:34:21 -0700
Subject: [PATCH v3 02/13] cxl/pci: Consolidate wait_for_media() and
 wait_for_media_ready()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Wed, 18 May 2022 16:34:20 -0700
Message-ID: <165291686046.1426646.4390664747934592185.stgit@dwillia2-xfh>
In-Reply-To: <165291684910.1426646.8615474651213855015.stgit@dwillia2-xfh>
References: <165291684910.1426646.8615474651213855015.stgit@dwillia2-xfh>
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

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

