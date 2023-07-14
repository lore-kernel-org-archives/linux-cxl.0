Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD29DEB64DC
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Jul 2023 09:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbjGNJcw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Jul 2023 05:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235866AbjGNJcK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Jul 2023 05:32:10 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187661989
        for <linux-cxl@vger.kernel.org>; Fri, 14 Jul 2023 02:31:54 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso15618015e9.2
        for <linux-cxl@vger.kernel.org>; Fri, 14 Jul 2023 02:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689327112; x=1691919112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=806DvyXAfQqmT7skSPuE/RMsUihBIw6a7gALPJkpbTQ=;
        b=i6Y3G5wjEbFl/570rlt9gzi/hfEDCvjXUkfgVL6zroNWTYVUQCcpcTC/Bj3WirpGfq
         ZOwMeXstv57DsDB0mrWhOdOApuz771V/E7GzaUBi3nJF1g3tZLwIUU404S05j+HCh8LU
         dYSjbnOqrpt5uYqBUEg/r6q70HmHZzQOKU1MqNh4Xo/TFyk/vN6NZ599C6eM2KNNb/mo
         JT1FEgz/bnK17HZgZaRBKXn6L4VaiQsSe/gpEX2qGxY9QceXU3dp1nf/oFQAYVs0j0sy
         gKxgIjsXj08v4yKBtr3zeLXql8rthFk4CpA7YoGtgfkVKevR3zKzQMk+enWwnTwlAnme
         6neg==
X-Gm-Message-State: ABy/qLZbtX48aa9LScZqpULm3CAO3gW3Kg1sqXFnZoa59MmZfQBze4r/
        zW2J5kYOW2NWv7jMASCAsKfzhAcrN6c=
X-Google-Smtp-Source: APBJJlF+E/J8tcXBU0Cl7kepLmTagsCnUNG0gvRojQbpBLs1VvSs+/iITvDKNNkp6C2l/xmnBfg2Fw==
X-Received: by 2002:a1c:ed0c:0:b0:3fa:9590:a365 with SMTP id l12-20020a1ced0c000000b003fa9590a365mr3430334wmh.17.1689327112091;
        Fri, 14 Jul 2023 02:31:52 -0700 (PDT)
Received: from localhost (fwdproxy-cln-013.fbsv.net. [2a03:2880:31ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id f23-20020a1c6a17000000b003fbdbd0a7desm988645wmc.27.2023.07.14.02.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 02:31:51 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com
Cc:     linux-cxl@vger.kernel.org, dave.jiang@intel.com
Subject: [PATCH v3 1/2] cxl/acpi: Fix UAF in the error path
Date:   Fri, 14 Jul 2023 02:31:45 -0700
Message-Id: <20230714093146.2253438-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

KASAN and KFENCE detected an user-after-free in the CXL driver. This
happens in the cxl_decoder_add() fail path. KASAN prints the following
error:

   BUG: KASAN: slab-use-after-free in cxl_parse_cfmws (drivers/cxl/acpi.c:299)

This is happening in cxl_parse_cfmws(), where put_device() is called,
releasing cxld, which is accessed later.

Just use the local variables in the dev_err() instead of pointing to the
released memory.

Fixes: e50fe01e1f2a ("cxl/core: Drop ->platform_res attribute for root decoders")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
v1 -> v2
 * Return the error (rc) instead of swalling it
v2 -> v3
 * Split the change in two patches
 * Fix the reference instead of the order

 drivers/cxl/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 658e6b84a769..642983da01cb 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -297,7 +297,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 		rc = cxl_decoder_autoremove(dev, cxld);
 	if (rc) {
 		dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
-			cxld->hpa_range.start, cxld->hpa_range.end);
+			res->start, res->end);
 		return 0;
 	}
 	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
-- 
2.34.1

