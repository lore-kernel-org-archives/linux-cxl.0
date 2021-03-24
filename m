Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765EAC433E0
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Mar 2021 21:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4985261A1E
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Mar 2021 21:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238295AbhCXVCK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 Mar 2021 17:02:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:28460 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238222AbhCXVB5 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 24 Mar 2021 17:01:57 -0400
IronPort-SDR: PuCpZ5tfQdLH8j//B7Yw2R7JcZLIOwo008bggVCGSL86Xk5/VA/45wUqC8gXoVmyrYGkE8T9yr
 unUWwL6J1+1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="190880557"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="190880557"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 14:01:56 -0700
IronPort-SDR: ScMrBpVrY5kPX+Il3Tf25SnLBHZQfFRT0dKgKkbsq8zxAs5AN5y21IuVwAOJAteBUntmqHSOG+
 zzzJT5EflWlA==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="452748654"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 14:01:56 -0700
Subject: [PATCH 2/4] cxl/mem: Fix cdev_device_add() error handling
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 24 Mar 2021 14:01:56 -0700
Message-ID: <161661971651.1721612.7457823773061754064.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161661970558.1721612.10441826898835759137.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161661970558.1721612.10441826898835759137.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

If cdev_device_add() fails then the allocation performed by
dev_set_name() is leaked. Use put_device(), not open coded release, for
device_add() failures.

The comment is obsolete because direct err_id failures need not worry
about the device being live.

The release method expects the percpu_ref is already dead, so
percpu_ref_kill() is needed before put_device(). However, given that the
cdev was partially live wait_for_completion() also belongs in the
release method.

Fixes: b39cb1052a5c ("cxl/mem: Register CXL memX devices")
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 30bf4f0f3c17..e53d573ae4ab 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -1049,6 +1049,7 @@ static void cxl_memdev_release(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 
+	wait_for_completion(&cxlmd->ops_dead);
 	percpu_ref_exit(&cxlmd->ops_active);
 	ida_free(&cxl_memdev_ida, cxlmd->id);
 	kfree(cxlmd);
@@ -1157,7 +1158,6 @@ static void cxlmdev_unregister(void *_cxlmd)
 
 	percpu_ref_kill(&cxlmd->ops_active);
 	cdev_device_del(&cxlmd->cdev, dev);
-	wait_for_completion(&cxlmd->ops_dead);
 	cxlmd->cxlm = NULL;
 	put_device(dev);
 }
@@ -1210,20 +1210,16 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
 	cdev_init(cdev, &cxl_memdev_fops);
 
 	rc = cdev_device_add(cdev, dev);
-	if (rc)
-		goto err_add;
+	if (rc) {
+		percpu_ref_kill(&cxlmd->ops_active);
+		put_device(dev);
+		return rc;
+	}
 
 	return devm_add_action_or_reset(dev->parent, cxlmdev_unregister, cxlmd);
 
-err_add:
-	ida_free(&cxl_memdev_ida, cxlmd->id);
 err_id:
-	/*
-	 * Theoretically userspace could have already entered the fops,
-	 * so flush ops_active.
-	 */
 	percpu_ref_kill(&cxlmd->ops_active);
-	wait_for_completion(&cxlmd->ops_dead);
 	percpu_ref_exit(&cxlmd->ops_active);
 err_ref:
 	kfree(cxlmd);

