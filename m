Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5337EB64D9
	for <linux-cxl@archiver.kernel.org>; Fri,  7 Jul 2023 16:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGGQQk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 7 Jul 2023 12:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjGGQQg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 7 Jul 2023 12:16:36 -0400
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4482102
        for <linux-cxl@vger.kernel.org>; Fri,  7 Jul 2023 09:16:32 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4fbc0314a7bso3341901e87.2
        for <linux-cxl@vger.kernel.org>; Fri, 07 Jul 2023 09:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688746590; x=1691338590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lB9X9qEnNVwE+WYWr02e/od/kQOiL0yCcEGXaBP96tg=;
        b=k3QOvQH2xABzjqMtYrWBj1yhlUyax0+6/DVR9LORGItMfV5r1LFR/5sXEEG6K6G7wI
         jEvb0xj8ztaOdFlv+q46bHhX1iJ/sCNaQjwld7xqbI8xvB46Sh6ZzJnGkklE5O0lwwXL
         0TWmUThiepVbeGdWkm6oEYyYGDGw/qqGLfCE1o8VQDPs8u7wNfDv9E2bdjINoe8LYthc
         t30xFg1AIHs6KhHIZE7yYNscRLTOmH2jLYnLidBGD7djxbxy6PlJaGbd75cOATGmGdLC
         h2lqR2aFhR+8yMV0jfoLCcgb/EOrScDSefiCpHDHBhhHYvjb+DtlOKMHyzGTtomnbHy8
         RuCg==
X-Gm-Message-State: ABy/qLZOfZ6w2CRFMOtUCF4WoshsrtnXoTGbb3jQf03oq/rBLodJCNhz
        SsIXhwROcg0btd7S9baOXjMi4L4KbV0=
X-Google-Smtp-Source: APBJJlF+FGc+n2KdPWU3bYpfwiAN+xs3Pz1RJq6ou9GIr7a+hoIGNv+m0DRB9QlEYurC2EC/wroyuA==
X-Received: by 2002:a05:6512:544:b0:4fb:73b5:e1cf with SMTP id h4-20020a056512054400b004fb73b5e1cfmr4254980lfl.64.1688746590137;
        Fri, 07 Jul 2023 09:16:30 -0700 (PDT)
Received: from localhost (fwdproxy-cln-118.fbsv.net. [2a03:2880:31ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id u8-20020a7bc048000000b003fbacc853ccsm2855113wmc.18.2023.07.07.09.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 09:16:29 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com
Cc:     linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/acpi: Release device after dev_err
Date:   Fri,  7 Jul 2023 09:16:16 -0700
Message-Id: <20230707161616.3554167-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Kfence is detecting a user-after-free in the CXL, when cxl_decoder_add()
fails. Kfence drops this message, after the following:

  BUG: KFENCE: use-after-free read in resource_string

This is happening in cxl_parse_cfmws(), and here is a simplified flow
that is coming from Kfence.

Use-after-free:
	_dev_err
	cxl_parse_cfmws
	acpi_table_parse_entries_array
	acpi_table_parse_cedt
	cxl_acpi_probe

Free:
	cxl_decoder_release
	device_release
	kobject_put
	cxl_parse_cfmws
	acpi_table_parse_entries_array
	acpi_table_parse_cedt
	cxl_acpi_probe

Alloc:
	cxl_decoder_alloc
	cxl_parse_cfmws
	acpi_table_parse_entries_array
	acpi_table_parse_cedt
	cxl_acpi_probe
	platform_probe

From my reading of the issue, the device struct being used by
dev_err() was removed in the put_device() before.

Put the device just after the message is printed.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/cxl/acpi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 658e6b84a769..5179bf4211d8 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -291,14 +291,13 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
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
+		put_device(&cxld->dev);
 		return 0;
+	} else {
+		rc = cxl_decoder_autoremove(dev, cxld);
 	}
 	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
 		dev_name(&cxld->dev),
-- 
2.34.1

