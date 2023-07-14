Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED7CEB64DA
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Jul 2023 09:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbjGNJc4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Jul 2023 05:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbjGNJcR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Jul 2023 05:32:17 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5E83AB3
        for <linux-cxl@vger.kernel.org>; Fri, 14 Jul 2023 02:31:55 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3fbc59de009so15267555e9.3
        for <linux-cxl@vger.kernel.org>; Fri, 14 Jul 2023 02:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689327113; x=1691919113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUa04DXat8Oft1/qI5RJH6sC63r0kW7kNckDU9CwGdU=;
        b=K94cearCqqUcV3Mq07TD/zv9TuyWj7dPs+8RQvwFh8AJTMz+Bu5eN8f3Qk9VXndNRE
         peXUW5uvzk0kYzAposv/XvG8ZxxE/yb9YM3WAtPqjUxxZ3MIjrjRyb492SRU1BAx93er
         qheMOxNP56rHystA5ODewmqRkQbdh4wh07oQjly8LfXVR70rGqyab5aNstDBlbgDySDy
         1toOosTOGVrhnqtxNLB8YmU7pNTQE9A2LZMpoZVQnIIEtJEw2UUyHgrSjhwJLXCjbkjp
         6kFsScFmH+/PlqHl90wRvxHUwySdMa2bV+GRdpuCJg3pmqFj2d2zw8sfWzP2ys5ego8J
         DlQg==
X-Gm-Message-State: ABy/qLahewt0+TxpSU8YNm2gi49D4PKFuXQZjgqWi1dzkmrWUajCz9xz
        6vMafipJi5J4UF1buKi6AFs=
X-Google-Smtp-Source: APBJJlFpEl+vM9XDgNl/dpLBJ396A+R8QzUArp494bqCpK1pP158nbtxVO2/n3vPKQJ5i51aOEjbuA==
X-Received: by 2002:a7b:c40d:0:b0:3fc:1a6:7764 with SMTP id k13-20020a7bc40d000000b003fc01a67764mr3431247wmi.16.1689327113340;
        Fri, 14 Jul 2023 02:31:53 -0700 (PDT)
Received: from localhost (fwdproxy-cln-001.fbsv.net. [2a03:2880:31ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id p26-20020a7bcc9a000000b003fbb5506e54sm985290wma.29.2023.07.14.02.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 02:31:52 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com
Cc:     linux-cxl@vger.kernel.org, dave.jiang@intel.com
Subject: [PATCH v3 2/2] cxl/acpi: Do not swallow errors
Date:   Fri, 14 Jul 2023 02:31:46 -0700
Message-Id: <20230714093146.2253438-2-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714093146.2253438-1-leitao@debian.org>
References: <20230714093146.2253438-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Driver initialization is returning success (return 0) even if the
initialization (cxl_decoder_add() or acpi_table_parse_cedt()) failed,
and the hardware was already released (put_device()).

Return the error instead of swallowing it.

Fixes: f4ce1f766f1e ("cxl/acpi: Convert CFMWS parsing to ACPI sub-table helpers")

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/cxl/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 642983da01cb..815b43859c16 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -298,7 +298,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	if (rc) {
 		dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
 			res->start, res->end);
-		return 0;
+		return rc;
 	}
 	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
 		dev_name(&cxld->dev),
-- 
2.34.1

