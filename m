Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF02EC001DE
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Jul 2023 12:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjGYMTz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Jul 2023 08:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbjGYMTs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Jul 2023 08:19:48 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E55DA7;
        Tue, 25 Jul 2023 05:19:47 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-345ff33d286so30870045ab.3;
        Tue, 25 Jul 2023 05:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690287586; x=1690892386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1f2ayxyiRgaE/wnqRzkPoVSevuLdWLo6mHRiU+EoVGc=;
        b=sFwWo9D2uxx9xAmVw41z28kYkCUempPlToqtX/Su34m2MezQ6FuZB7y3gzxirGeAWj
         FqxU/eixYDR1uBVsInhwleJX+ju6bYNZAzKLzgz6k9Ev09Qh7eHsSmbS/x5vt94BLlKZ
         auwO/hFojPVp3HccqhEwt2rqmnzu4xIjCynDE298S4IlVt8e4YW/oAo0Y4aMdplD0Pam
         36R/7mnlDpYXBKR17bKIAolNGSpdzH7FzZ13tFw9XDS9OGGP5R6Hlk357ity22Ti1/3h
         tQOSK4QTB1NBhCA0LLdmYmI9SvUZQALDG8jzNzYplJxwCveCXznLOJntiXkqGbg/I4yI
         AjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690287586; x=1690892386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1f2ayxyiRgaE/wnqRzkPoVSevuLdWLo6mHRiU+EoVGc=;
        b=iQymHcayvzZP9ooXwXwMnToyfticvOd9R0HPZhEHY7fQvmI2dyLRShyIU04rkPt9ac
         aJsRRdKzHNesdgNRgxivnKbTX8A7PRafTh9o0SuX51XD3jHaFeVq9RxLOloauZJimO3i
         Xis/jxgc+M+XOoI2vuC1WC5v6Q7ctKxh7QzQvHf+/oKb3t25TZxxGfFv2EgXWQj1Ispf
         IpgJR4uBwjujKn4CpIGhXH7tXLM/YyW6uM5QmR+KE/YHaPpupZOpcuDBsdxxDkRvxNr4
         NqfOVZrG//k7saV/XmSPjTLWyDE72++fmNxrsJRoo201Ix56LSZZwDaTGqm4vhMDExAL
         xIQQ==
X-Gm-Message-State: ABy/qLYUGyJ8TDTay6jPM4PMa3/o/LxBieV2Z8za+hM9HcPF+tej5vp/
        +HWY5wfuJgZA6s8+TZFOrVnI5Z4BNjk=
X-Google-Smtp-Source: APBJJlES5IqGFE+GAI8VzB5YB9bje0yxgluSaX8C3G664J0j9tBKB0RGgljAibAIRLm9UmaqTqHXuw==
X-Received: by 2002:a05:6e02:1bab:b0:346:5ab2:4d85 with SMTP id n11-20020a056e021bab00b003465ab24d85mr3424500ili.28.1690287586558;
        Tue, 25 Jul 2023 05:19:46 -0700 (PDT)
Received: from cxl-test.. ([103.181.222.211])
        by smtp.gmail.com with ESMTPSA id bg1-20020a17090b0d8100b002676e961261sm988185pjb.1.2023.07.25.05.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 05:19:46 -0700 (PDT)
From:   Raghu Halharvi <raghuhack78@gmail.com>
To:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        raghuhack78@gmail.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com
Cc:     linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH RESEND v6 1/2] cxl/mbox: Remove redundant dev_err() after failed mem alloc
Date:   Tue, 25 Jul 2023 12:19:29 +0000
Message-Id: <20230725121930.3732-2-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230725121930.3732-1-raghuhack78@gmail.com>
References: <20230725121930.3732-1-raghuhack78@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Issue found with checkpatch

A return of errno should be good enough if the memory allocation fails,
the error message here is redundant as per the coding style, removing
it.

Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Signed-off-by: Raghu Halharvi <raghuhack78@gmail.com>
---
 drivers/cxl/core/mbox.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index d6d067fbee97..af7f37cea871 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1325,10 +1325,8 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 	struct cxl_memdev_state *mds;
 
 	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
-	if (!mds) {
-		dev_err(dev, "No memory available\n");
+	if (!mds)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	mutex_init(&mds->mbox_mutex);
 	mutex_init(&mds->event.log_lock);
-- 
2.39.2

