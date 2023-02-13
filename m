Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB8CC636D4
	for <linux-cxl@archiver.kernel.org>; Mon, 13 Feb 2023 10:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjBMKMr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 13 Feb 2023 05:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjBMKMj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 13 Feb 2023 05:12:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C271517178;
        Mon, 13 Feb 2023 02:12:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D65D60F6E;
        Mon, 13 Feb 2023 10:12:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B65C433EF;
        Mon, 13 Feb 2023 10:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676283143;
        bh=tFR8Is7pavXEpFk5U0TVtxzOu/qBmPCX8MhgYgxKFFc=;
        h=From:To:Cc:Subject:Date:From;
        b=UF30ZRTO6xpYhEi8j35cVSgfYP9ZdsE6hYPizE+vpA3PNOkw6orROmUQjSjxtnqi4
         92r0J751DcQr3xxPO7A9mFxmUc1YoXExPVVYb1rO8iYELTqC9CF+3jpcHuK7Hhy8fA
         XnXfJvkOZdNtIT1PsCZl3iATABuC3RlD6/2AvhBRVTijVmbEBw7edQw+aKXV0VMXfg
         s5hySEdjeKAOlgY1mKWFz+jJVFfzKqYevQ7KKZhZcJzpXOOpUKZmcSvlyJqlZmGXE0
         Lsdvrcr8Ep2jvIIUdKUFVRE7tj2SP6dQ4voqLuqe8fspZQXLuH8oY0/Go/B979rjzl
         aG36IBVhjnNpA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dave Jiang <dave.jiang@intel.com>,
        Dan Carpenter <error27@gmail.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cxl: avoid returning uninitialized error code
Date:   Mon, 13 Feb 2023 11:12:11 +0100
Message-Id: <20230213101220.3821689-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The new cxl_add_to_region() function returns an uninitialized
value on success:

drivers/cxl/core/region.c:2628:6: error: variable 'rc' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
        if (IS_ERR(cxlr)) {
            ^~~~~~~~~~~~
drivers/cxl/core/region.c:2654:9: note: uninitialized use occurs here
        return rc;

Simplify the logic to have the rc variable always initialized in the
same place.

Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cxl/core/region.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index fe1d8392870e..f29028148806 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2625,10 +2625,9 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 		cxlr = to_cxl_region(region_dev);
 	mutex_unlock(&cxlrd->range_lock);
 
-	if (IS_ERR(cxlr)) {
-		rc = PTR_ERR(cxlr);
+	rc = PTR_ERR_OR_ZERO(cxlr);
+	if (rc)
 		goto out;
-	}
 
 	attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
 
-- 
2.39.1

