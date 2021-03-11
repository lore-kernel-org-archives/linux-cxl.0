Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318FCC433E0
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Mar 2021 16:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFABD64FA0
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Mar 2021 16:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhCKQ4O (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 Mar 2021 11:56:14 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37535 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhCKQ4A (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 Mar 2021 11:56:00 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lKObP-0004Hq-BD; Thu, 11 Mar 2021 16:55:59 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cxl/mem: remove redundant initialization of variable rc
Date:   Thu, 11 Mar 2021 16:55:59 +0000
Message-Id: <20210311165559.60281-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable rc is being initialized with a value that is
never read and it is being updated later with a new value.
The initialization is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/cxl/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 244cb7d89678..a2e22675e985 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -778,7 +778,7 @@ static long cxl_memdev_ioctl(struct file *file, unsigned int cmd,
 {
 	struct cxl_memdev *cxlmd;
 	struct inode *inode;
-	int rc = -ENOTTY;
+	int rc;
 
 	inode = file_inode(file);
 	cxlmd = container_of(inode->i_cdev, typeof(*cxlmd), cdev);
-- 
2.30.2

