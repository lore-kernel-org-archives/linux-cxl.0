Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E560DCD484C
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Sep 2023 17:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjIVRzl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Sep 2023 13:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjIVRzR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 22 Sep 2023 13:55:17 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B2626BD
        for <linux-cxl@vger.kernel.org>; Fri, 22 Sep 2023 10:53:21 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68c576d35feso2264090b3a.2
        for <linux-cxl@vger.kernel.org>; Fri, 22 Sep 2023 10:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405201; x=1696010001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zj4SpSBariL7w5PfW6Ds6GNC0+0okk3XV9I1LLkTyug=;
        b=bqBFSDme0elkUaFcgTvhd0/pw2zG1uvcMkyZvBH4FO+Rq0gD26bmikngEzK3fNcQNL
         /cNOmHR+tuR0lnQ/+cL4P5dHOf6IOCo9W/YsmVD9URm98dmhSQHwQ6CaDrtoQdt7ckVK
         Otq91qmV+5PW528xXwQaG4q5GsATQyGPWqUBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405201; x=1696010001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zj4SpSBariL7w5PfW6Ds6GNC0+0okk3XV9I1LLkTyug=;
        b=hAKZF1aeI7ravK40XCnkbJYEaCc6pKpE3fF64XbBT6BoL29KBDikE/8KwAqxhkdQh6
         gyiAEou4GGW8NN9d6BsNLnLcvX6NXelbVgXqMYwqj631THWRNojhxefPDsKT10tdZFq3
         6WTWpdVfzfzbxZile9QREI2sgkxQdT9AtzH4ylT+oFi68s8QCtBTnb3Fd3IAQKfnBwht
         9yEQ/IvusK+PK8rJChefBC1RZcgop9G3GmcxSgZbN3z9hVki83ftbjt+mKcuOwdKKL3P
         FBBDgortJzzOrpkNzHuEDu8zzXesG1n+XBhlXFBFRMgIEBc8RuOc1/Z+7ZpLzvT222C1
         md6Q==
X-Gm-Message-State: AOJu0Yxs0ZlGypawBFO7j/1vkzoYI9NndCHM9dSMBbiflv13z3WwCnae
        L7vTl44Bx+I8BHJiyySjEnV5nw==
X-Google-Smtp-Source: AGHT+IEcv6I2y2Tg2Odj/iWaOxh5mW66mAjC4xYL0PIzz5E6E4vYoNBJ5eGmBuobJlur8IK3kU6bxA==
X-Received: by 2002:a05:6a21:81aa:b0:152:cb38:5b47 with SMTP id pd42-20020a056a2181aa00b00152cb385b47mr257623pzb.55.1695405200892;
        Fri, 22 Sep 2023 10:53:20 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f15-20020aa782cf000000b0068e34f07eb5sm3477790pfn.165.2023.09.22.10.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:53:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] cxl/acpi: Annotate struct cxl_cxims_data with __counted_by
Date:   Fri, 22 Sep 2023 10:53:19 -0700
Message-Id: <20230922175319.work.096-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1760; i=keescook@chromium.org;
 h=from:subject:message-id; bh=tNrG8i/0a9DiFVHoyS+eyi+j3sakENn22yKf1szb4r4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdSP1E3HqMf03zOoxsrwZjK7Qj8qQ3rlmWuIg
 hEVQLTNG5CJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UjwAKCRCJcvTf3G3A
 JnXID/98/PX44Zti8qld555xxdRdu0RXKFI86bNon1If3/8TVm7WOjQiSGTHR4YdW90Zydlsl1L
 rNagT5wfhg6OP6bRi+uGJKlbSoUnfx5qQ9GZ9Fcyw8JHzZH0Mfzq2Tf6ypcRx3xsNEgtTme7et4
 uJ73qmrN0bMFT1ElebQMq3B8nvbYg62SMzuY/eGktx4SAwAnowdulA12IM4R0/0l2myEQMDWTMd
 crMzjlGE2AjP6rul7CiexgkQ3PBNTgsiq5WnTCb2J4SybdDTqsDut/Xr30sx9nGvX+GpP5HHr7o
 3Hc/EXEqI4dNa0I6b7zyPdDG0BqkPTIqaT1Lx4QJ+tAd+cUJqbnSYTciLrz0C5IfnjtiaTnYQNV
 sW5R9U0FqdeMnQz032u7VHBRj1dhXI8zNDhsfqDrCWDlUIsMMYF12Irr51DaG5U+PY8I/rWp18c
 pFukvnGCSCGfLrrGFt+QEZ7afQ3TGSTfyKuimDFBzz04G9A3LbtceghPaC8NWmOjzmP0KJUgbOw
 P2LIqnJmGvBQcI5hHrrAgYoxfcCR1A6Py9/A1392H0jxu6sdOPqSCQnhseIaoNcSR5+zW66AGln
 ycylr/yU55fASbpmOf4NWe9HCHyVHQFLkGFyWqd438Y5QydCReDiyKra63cn9iGAagCk8fHwZo/
 PgOkiO0 +z27dRqg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct cxl_cxims_data.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/cxl/acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index d1c559879dcc..40d055560e52 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -14,7 +14,7 @@
 
 struct cxl_cxims_data {
 	int nr_maps;
-	u64 xormaps[];
+	u64 xormaps[] __counted_by(nr_maps);
 };
 
 /*
@@ -112,9 +112,9 @@ static int cxl_parse_cxims(union acpi_subtable_headers *header, void *arg,
 			      GFP_KERNEL);
 	if (!cximsd)
 		return -ENOMEM;
+	cximsd->nr_maps = nr_maps;
 	memcpy(cximsd->xormaps, cxims->xormap_list,
 	       nr_maps * sizeof(*cximsd->xormaps));
-	cximsd->nr_maps = nr_maps;
 	cxlrd->platform_data = cximsd;
 
 	return 0;
-- 
2.34.1

