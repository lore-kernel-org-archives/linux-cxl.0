Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF379EB64D8
	for <linux-cxl@archiver.kernel.org>; Sat, 17 Jun 2023 01:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjFQBYq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Jun 2023 21:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjFQBYo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Jun 2023 21:24:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C9C3AAF
        for <linux-cxl@vger.kernel.org>; Fri, 16 Jun 2023 18:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686965083; x=1718501083;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6ts+CEwZ9mULQARVcK/5Quce23gVOaqNyP2/qlacEKk=;
  b=HBGmZ/oxdKWD36vWFdvP3BJj7cWsJKAOM0+1AODngG/QE6KskHY+NF4A
   JBRAhgWWwI6CQ656ms9BX8Rkm1UC34/ry78bdzzZXr3ybV+hGFoHHPEWi
   3p+//NMVnAwmnTwiO97RSLdBGuESp1i+tREmkxw51oBmwnKI6wc1VcaCy
   sH2Uh+SUr/ScMbG/uWHsnVVA36uRO1ZX5TbVi3OGVFUf8z2iUimVEgEgC
   C1FLJbTaNGaXbsMFvxSd2IzgAZyoUwKwQn6r7VKi/AFECSjRyxJUfH+AJ
   VVtcGdPzi3ASpEObFdK11hNAg+E2jxeO3aMD6DA/N73lRZmhKtcb0A9O5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="362762349"
X-IronPort-AV: E=Sophos;i="6.00,249,1681196400"; 
   d="scan'208";a="362762349"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 18:24:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="713073359"
X-IronPort-AV: E=Sophos;i="6.00,249,1681196400"; 
   d="scan'208";a="713073359"
Received: from slovely-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.23.80])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 18:24:39 -0700
Subject: [PATCH 3/3] cxl/region: Fix state transitions after reset failure
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Date:   Fri, 16 Jun 2023 18:24:39 -0700
Message-ID: <168696507968.3590522.14484000711718573626.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168696506332.3590522.12981963617215460385.stgit@dwillia2-xfh.jf.intel.com>
References: <168696506332.3590522.12981963617215460385.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan reports that failed attempts to reset a region (teardown its
HDM decoder configuration) mistakenly advance the state of the region
to "not committed". Revert to the previous state of the region on reset
failure so that the reset can be re-attempted.

Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Closes: http://lore.kernel.org/r/20230316171441.0000205b@Huawei.com
Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |   26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 31f498f0fb3a..38db377e13f1 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -296,9 +296,11 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
 	if (rc)
 		return rc;
 
-	if (commit)
+	if (commit) {
 		rc = cxl_region_decode_commit(cxlr);
-	else {
+		if (rc == 0)
+			p->state = CXL_CONFIG_COMMIT;
+	} else {
 		p->state = CXL_CONFIG_RESET_PENDING;
 		up_write(&cxl_region_rwsem);
 		device_release_driver(&cxlr->dev);
@@ -308,18 +310,20 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
 		 * The lock was dropped, so need to revalidate that the reset is
 		 * still pending.
 		 */
-		if (p->state == CXL_CONFIG_RESET_PENDING)
+		if (p->state == CXL_CONFIG_RESET_PENDING) {
 			rc = cxl_region_decode_reset(cxlr, p->interleave_ways);
+			/*
+			 * Revert to committed since there may still be active
+			 * decoders associated with this region, or move forward
+			 * to active to mark the reset successful
+			 */
+			if (rc)
+				p->state = CXL_CONFIG_COMMIT;
+			else
+				p->state = CXL_CONFIG_ACTIVE;
+		}
 	}
 
-	if (rc)
-		goto out;
-
-	if (commit)
-		p->state = CXL_CONFIG_COMMIT;
-	else if (p->state == CXL_CONFIG_RESET_PENDING)
-		p->state = CXL_CONFIG_ACTIVE;
-
 out:
 	up_write(&cxl_region_rwsem);
 

