Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0354C4338F
	for <linux-cxl@archiver.kernel.org>; Mon,  9 Aug 2021 22:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C09460EB5
	for <linux-cxl@archiver.kernel.org>; Mon,  9 Aug 2021 22:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbhHIW3f (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 9 Aug 2021 18:29:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:54463 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236646AbhHIW3e (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 9 Aug 2021 18:29:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="236796816"
X-IronPort-AV: E=Sophos;i="5.84,308,1620716400"; 
   d="scan'208";a="236796816"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 15:29:13 -0700
X-IronPort-AV: E=Sophos;i="5.84,308,1620716400"; 
   d="scan'208";a="421000208"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 15:29:13 -0700
Subject: [PATCH 16/23] cxl/mbox: Convert 'enabled_cmds' to DECLARE_BITMAP
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, Jonathan.Cameron@huawei.com,
        ben.widawsky@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com
Date:   Mon, 09 Aug 2021 15:29:13 -0700
Message-ID: <162854815299.1980150.3524640653829717905.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162854806653.1980150.3354618413963083778.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162854806653.1980150.3354618413963083778.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Define enabled_cmds as an embedded member of 'struct cxl_mem' rather
than a pointer to another dynamic allocation.

As this leaves only one user of cxl_cmd_count, just open code it and
delete the helper.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/mbox.c |   10 +---------
 drivers/cxl/cxlmem.h    |    2 +-
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 40f051956990..23100231e246 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -322,8 +322,6 @@ static int cxl_validate_cmd_from_user(struct cxl_mem *cxlm,
 	return 0;
 }
 
-#define cxl_cmd_count ARRAY_SIZE(cxl_mem_commands)
-
 int cxl_query_cmd(struct cxl_memdev *cxlmd,
 		  struct cxl_mem_query_commands __user *q)
 {
@@ -339,7 +337,7 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
 
 	/* returns the total number if 0 elements are requested. */
 	if (n_commands == 0)
-		return put_user(cxl_cmd_count, &q->n_commands);
+		return put_user(ARRAY_SIZE(cxl_mem_commands), &q->n_commands);
 
 	/*
 	 * otherwise, return max(n_commands, total commands) cxl_command_info
@@ -803,12 +801,6 @@ struct cxl_mem *cxl_mem_create(struct device *dev)
 
 	mutex_init(&cxlm->mbox_mutex);
 	cxlm->dev = dev;
-	cxlm->enabled_cmds =
-		devm_kmalloc_array(dev, BITS_TO_LONGS(cxl_cmd_count),
-				   sizeof(unsigned long),
-				   GFP_KERNEL | __GFP_ZERO);
-	if (!cxlm->enabled_cmds)
-		return ERR_PTR(-ENOMEM);
 
 	return cxlm;
 }
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index b7122ded3a04..df4f3636a999 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -116,7 +116,7 @@ struct cxl_mem {
 	size_t lsa_size;
 	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
 	char firmware_version[0x10];
-	unsigned long *enabled_cmds;
+	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
 
 	struct range pmem_range;
 	struct range ram_range;

