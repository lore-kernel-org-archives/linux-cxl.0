Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7696EB64DC
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Jul 2023 16:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjGKQRg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Jul 2023 12:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjGKQR2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Jul 2023 12:17:28 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A64C170B
        for <linux-cxl@vger.kernel.org>; Tue, 11 Jul 2023 09:17:20 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3fbef8ad9bbso65196775e9.0
        for <linux-cxl@vger.kernel.org>; Tue, 11 Jul 2023 09:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689092239; x=1691684239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=84vDE8YBwzK6ZgE5z/WBNrj4baM7CVBa+IV1+Qum/jc=;
        b=DF/A3gFgzDKiQAisIsvgJUGrCzZT98m9MWqf9llMH1jLIH2nEvkqMRlurLVAlBli2L
         dEbf2gqV8HrzmC0a5jHZ33YPkEmfUv+4Xd5Qdt091AsJ4vSps+mU8zLwNypqdd3roNHI
         /i+aEp57IEWfHB/TC58g/8Z7gNhJZ/ej4ENN5fjHXOI3e36hv/fVe5uPjdJZ0rXG7SDw
         aiwxYYFCI0+eOftT5UNAU48tvdCwm1pKDwe4uOhXmDAC7b1kcZsCiV6JdfWJ2dUOssTL
         jnyaAvUE168aM0/YDD9Z59ssmTLbf+5EhSjd/wsEM7QItAy6yQCsPcThgpM1xZKgv6Le
         yr7A==
X-Gm-Message-State: ABy/qLZMY6Fxm59dr1p4iXMrq0551/XWkRYWZbEWw003ECoNUGgFk7sG
        YIEYW6VCUBnC2L9W3js8l2LHE7Tvr7w=
X-Google-Smtp-Source: APBJJlFVp9ToeQpnwD2Zgs/75JErvKqFbPfS+cLM/1CZzfrgSDLvpMOjqKFBrQjrgqlqpMqG1clghw==
X-Received: by 2002:a7b:cb87:0:b0:3fb:fcc6:6719 with SMTP id m7-20020a7bcb87000000b003fbfcc66719mr14994918wmi.27.1689092238635;
        Tue, 11 Jul 2023 09:17:18 -0700 (PDT)
Received: from localhost (fwdproxy-cln-001.fbsv.net. [2a03:2880:31ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id v21-20020a7bcb55000000b003fba9db141esm13453010wmj.38.2023.07.11.09.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 09:17:18 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com
Cc:     linux-cxl@vger.kernel.org, ave.jiang@intel.com
Subject: [PATCH v2] cxl/acpi: Release device after dev_err()
Date:   Tue, 11 Jul 2023 09:17:04 -0700
Message-Id: <20230711161704.3033220-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Kfence detected an user-after-free in the CXL driver. This happens in
the cxl_decoder_add() fail path. Kfence drops this message:

  BUG: KFENCE: use-after-free read in resource_string

This is happening in cxl_parse_cfmws(), where put_device() is called,
releasing cxld->dev, and then, later, dev_err(cxld->dev) is called
referencing the released device.

Just release the device after the message is printed/dev_err().  On top
of that, cxl_parse_cfmws() must fail (returns rc) in case of
cxl_decoder_add() or cxl_decoder_autoremove() failing (rc != 0), instead
of swallowing the error and returning 0.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
v1 -> v2
 * Return the error (rc) instead of swalling it

---
 drivers/cxl/acpi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 658e6b84a769..efead5cc8a89 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -291,14 +291,16 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	}
 	rc = cxl_decoder_add(cxld, target_map);
 err_xormap:
-	if (rc)
-		put_device(&cxld->dev);
-	else
-		rc = cxl_decoder_autoremove(dev, cxld);
 	if (rc) {
 		dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
 			cxld->hpa_range.start, cxld->hpa_range.end);
-		return 0;
+		put_device(&cxld->dev);
+		return rc;
+	}
+	rc = cxl_decoder_autoremove(dev, cxld);
+	if (rc) {
+		dev_err(dev, "Failed to register autoremove action\n");
+		return rc;
 	}
 	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
 		dev_name(&cxld->dev),
-- 
2.34.1

