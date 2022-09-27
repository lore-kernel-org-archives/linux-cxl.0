Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDB0C54EE9
	for <linux-cxl@archiver.kernel.org>; Tue, 27 Sep 2022 07:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiI0HDo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 27 Sep 2022 03:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiI0HDn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 27 Sep 2022 03:03:43 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55B4B6A49F;
        Tue, 27 Sep 2022 00:03:40 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id C36601E80D70;
        Tue, 27 Sep 2022 14:59:28 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JY7Jg4ZAKV7K; Tue, 27 Sep 2022 14:59:26 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id C59511E80D33;
        Tue, 27 Sep 2022 14:59:24 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, kernel-janitors@vger.kernel.org,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] cxl/pmem: Use size_add() against integer overflow
Date:   Tue, 27 Sep 2022 15:02:47 +0800
Message-Id: <20220927070247.23148-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

"struct_size() + n" may cause a integer overflow,
use size_add() to handle it.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 drivers/cxl/pmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 7dc0a2fa1a6b..8c08aa009a56 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -148,7 +148,7 @@ static int cxl_pmem_set_config_data(struct cxl_dev_state *cxlds,
 		return -EINVAL;
 
 	/* 4-byte status follows the input data in the payload */
-	if (struct_size(cmd, in_buf, cmd->in_length) + 4 > buf_len)
+	if (size_add(struct_size(cmd, in_buf, cmd->in_length), 4) > buf_len)
 		return -EINVAL;
 
 	set_lsa =
-- 
2.11.0

