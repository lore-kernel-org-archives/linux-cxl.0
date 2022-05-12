Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48459C433FE
	for <linux-cxl@archiver.kernel.org>; Thu, 12 May 2022 18:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357512AbiELSOp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 12 May 2022 14:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357509AbiELSOp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 12 May 2022 14:14:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DD825F7B2
        for <linux-cxl@vger.kernel.org>; Thu, 12 May 2022 11:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652379284; x=1683915284;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TLJyuGDB8fCXqobjac/plEAGkiTg9zfvUaTC/JHBgZY=;
  b=ah9vfTnp5TbiQdCLrGD7FCXzxgQwKggD4WGYgoKa6p9L4YsYNBElRhCV
   BYcfBqBQS4n3Gc80Z+lw+0swO9GmsU3AGLfV0P8P+RHl8RvL+yDcGvw+f
   tErZOX4ts1xpkFrIkFMqtHUCKuzLT52/YW1fY+JzeQJjAWZzGTif8AOs6
   Gu0FgM723+sZ02BsfPw7C0D4AuWKlwIYWH/mp1FCu5sAyCet2AxnhCnQl
   aiORVKBsfdR/z3XMeS4n1H6HaxHMBrCrdpTsHKJBDXjuKZiqb3e20+/vI
   q2zqQjyWEA8zHdfOvPxuDmsr3jaWruFY6WFSEg/6FU6Hit62zvK7gyWY0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="270035329"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="270035329"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:14:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="658717919"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:14:43 -0700
Subject: [PATCH 05/14] cxl/mem: Validate port connectivity before dvsec
 ranges
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan.Cameron@huawei.com, ben.widawsky@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com
Date:   Thu, 12 May 2022 11:14:43 -0700
Message-ID: <165237928334.3832067.16326444799383620141.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c |   36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index fed7f10ef9b2..80e75a410499 100644
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
@@ -171,16 +155,32 @@ static int cxl_mem_probe(struct device *dev)
 		dev_err(dev, "CXL port topology %s not enabled\n",
 			dev_name(&parent_port->dev));
 		rc = -ENXIO;
-		goto out;
+		goto unlock;
 	}
 
 	rc = create_endpoint(cxlmd, parent_port);
-out:
+unlock:
 	device_unlock(&parent_port->dev);
 	put_device(&parent_port->dev);
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

