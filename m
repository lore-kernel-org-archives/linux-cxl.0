Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC1CC4338F
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Aug 2021 17:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FD4961103
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Aug 2021 17:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhHBRKG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 2 Aug 2021 13:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhHBRKG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 2 Aug 2021 13:10:06 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA39C06175F
        for <linux-cxl@vger.kernel.org>; Mon,  2 Aug 2021 10:09:56 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c16so20369010plh.7
        for <linux-cxl@vger.kernel.org>; Mon, 02 Aug 2021 10:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DvH792RmUFAkW/PYz6fMlYgVhPReNimJtryAQdkV08Y=;
        b=GEG3L/axD+/N1558Fuzoo1TkNW0d8Twm5YgOntyHPW+JhNYUpG7s+LP/BMRtgrdxNX
         Q9XrDhNYKQsRYZMoynCrO8q7ZzvhnJYC0pXg8Tn+MPgr5Vgh+nvlGPRGc07U+Cs8QeP/
         XXwmpHCfAH04gnRuWhuyCdTMdtnGieaclpj6RjRl+0qimGncBTSsB40gOShCgEMc/Caw
         2omVoLSgZhocUYgOXNZGITroihUhYT0SifC9MpyiQnYoXsN+GspQg1J6NssOBefWjZUk
         cFSzeY++bDB2eEbFjdnyxvDQnwBuX54hEaUfO9nKn6CRbZWQE4BNXDVLrPXvy0RJEDKW
         v2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DvH792RmUFAkW/PYz6fMlYgVhPReNimJtryAQdkV08Y=;
        b=kfgXCgFAzCO/H+ejCWWIVcn3Mc2bLMnM1OjdiMXsHNp1RFdiWqSy6uiKR4cS0XCBYz
         CTEKAtBH5mzTxlhRWwjrZFfrZ+DZ+q/r7d0sGdTifm7X+6ISkLoaalYtB7ESi5lSglJM
         j3Oz6U1Sn/4bfZ6mZPiTSe37+79O82BORCX4+p48e8cwimtFy4ejkTL0gSKnsBU354ES
         YcFZIj4FviWDp4ak7F9Q3VCf5ck01AYryTFT2MnOI1dXvy8M5Po74nTsUNqWjXYQ/b3Y
         jRT9xCkINIj2E1w+W8Mf/i+stgD2htrpiDRBBlWbwgkalwa0qosci0gTOTN1btPe8E2n
         q3dw==
X-Gm-Message-State: AOAM532ZuTa1COdWm12h5Y7a6GOb74y6MbMHG0nD6VSWUdXls2PSB5Pq
        GYEd4seTSyNGfGaMDZsazjFOpTL4ToHjDsOPs0WzfA==
X-Google-Smtp-Source: ABdhPJygnPCVkkKtw6U9dx0wmcwlwI5Qr2Zkl7sHGhfRIEIORsHIvuwm27FeHikRlIEkUS0glT1tgWz2BipOxz8w12Q=
X-Received: by 2002:a62:3342:0:b029:3b7:6395:a93 with SMTP id
 z63-20020a6233420000b02903b763950a93mr10310901pfz.71.1627924196450; Mon, 02
 Aug 2021 10:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210716231548.174778-1-ben.widawsky@intel.com>
 <20210716231548.174778-4-ben.widawsky@intel.com> <20210802165656.000036f0@Huawei.com>
 <CAPcyv4jQ=jSOzcyt=0JCn_sSBQEo+23taG4O-QPU9xwTjUKw5w@mail.gmail.com>
In-Reply-To: <CAPcyv4jQ=jSOzcyt=0JCn_sSBQEo+23taG4O-QPU9xwTjUKw5w@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 2 Aug 2021 10:09:45 -0700
Message-ID: <CAPcyv4iWmZtcGPDNsFebL=kZNQ+GvSEAqfR77gM9Z5bojTEqDQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] cxl/pci: Retain map information in cxl_mem_probe
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Aug 2, 2021 at 9:10 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Aug 2, 2021 at 8:57 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Fri, 16 Jul 2021 16:15:48 -0700
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > > In order for a memdev to participate in cxl_core's port APIs, the
> > > physical address of the memdev's component registers is needed. This is
> > > accomplished by allocating the array of maps in probe so they can be
> > > used after the memdev is created.
> > >
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> >
> > Hmm. I don't entirely like the the passing of an array of
> > unknown size into cxl_mem_setup_regs.  It is perhaps paranoid
> > but I'd separately pass in the size and error out should we
> > overflow with a suitable message to highlight the bug.
>
> Agree.

Here's the incremental diff I came up with:

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index c370ab2e48bc..ff72286142e7 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1086,7 +1086,8 @@ static void cxl_decode_register_block(u32
reg_lo, u32 reg_hi,
  * regions. The purpose of this function is to enumerate and map those
  * registers.
  */
-static int cxl_mem_setup_regs(struct cxl_mem *cxlm, struct
cxl_register_map maps[])
+static int cxl_mem_setup_regs(struct cxl_mem *cxlm,
+                             struct cxl_register_maps *maps)
 {
        struct pci_dev *pdev = cxlm->pdev;
        struct device *dev = &pdev->dev;
@@ -1135,7 +1136,9 @@ static int cxl_mem_setup_regs(struct cxl_mem
*cxlm, struct cxl_register_map maps
                if (!base)
                        return -ENOMEM;

-               map = &maps[n_maps];
+               if (n_maps > ARRAY_SIZE(maps->map))
+                       return -ENXIO;
+               map = &maps->map[n_maps++];
                map->barno = bar;
                map->block_offset = offset;
                map->reg_type = reg_type;
@@ -1147,14 +1150,12 @@ static int cxl_mem_setup_regs(struct cxl_mem
*cxlm, struct cxl_register_map maps

                if (ret)
                        return ret;
-
-               n_maps++;
        }

        pci_release_mem_regions(pdev);

        for (i = 0; i < n_maps; i++) {
-               ret = cxl_map_regs(cxlm, &maps[i]);
+               ret = cxl_map_regs(cxlm, &maps->map[i]);
                if (ret)
                        break;
        }
@@ -1370,7 +1371,7 @@ static int cxl_mem_identify(struct cxl_mem *cxlm)

 static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-       struct cxl_register_map maps[CXL_REGLOC_RBI_TYPES];
+       struct cxl_register_maps maps;
        struct cxl_memdev *cxlmd;
        struct cxl_mem *cxlm;
        int rc;
@@ -1383,7 +1384,7 @@ static int cxl_mem_probe(struct pci_dev *pdev,
const struct pci_device_id *id)
        if (IS_ERR(cxlm))
                return PTR_ERR(cxlm);

-       rc = cxl_mem_setup_regs(cxlm, maps);
+       rc = cxl_mem_setup_regs(cxlm, &maps);
        if (rc)
                return rc;

diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
index 8c1a58813816..5b7828003b76 100644
--- a/drivers/cxl/pci.h
+++ b/drivers/cxl/pci.h
@@ -2,6 +2,7 @@
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
 #ifndef __CXL_PCI_H__
 #define __CXL_PCI_H__
+#include "cxlmem.h"

 #define CXL_MEMORY_PROGIF      0x10

@@ -29,4 +30,8 @@

 #define CXL_REGLOC_ADDR_MASK GENMASK(31, 16)

+struct cxl_register_maps {
+       struct cxl_register_map map[CXL_REGLOC_RBI_TYPES];
+};
+
 #endif /* __CXL_PCI_H__ */
