Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86966C432BE
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Aug 2021 18:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5905E60F5B
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Aug 2021 18:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhH3SuL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Aug 2021 14:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbhH3SuK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Aug 2021 14:50:10 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E07C061575
        for <linux-cxl@vger.kernel.org>; Mon, 30 Aug 2021 11:49:16 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id g184so14314357pgc.6
        for <linux-cxl@vger.kernel.org>; Mon, 30 Aug 2021 11:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SRkfHTH4+fu9f6ALb3AqJ2EBY/NMIz0PCvmgLDj2MLk=;
        b=n6wAkbbyXxk6Hb5iLd5LMR2uOdRC48qdbneBbE1iPNBGmOgMideZQTgxjul59t3jvE
         4MXtt9HWHHUzHaEnc9rmtrgHtT0x89x6Cdf/rn2anYZHcVjo882YfziKvp7EbdO4fqem
         3MIOwiakpE2TA1UmsW+HPKQuYcPB/8mdAZzG1VLDCKYt9APGo4PDnjVN8wyZpxqXD2jW
         wmKj5+Ukvx4QxP7PcRagS25j4aeeF8xdK+JAoJQ8auXCNq98obAL+ng2GfoYijb1UdlI
         S4LwrToVCMisOXGH4d1WRFfJwVaF4GC7x4/FN20hiBUKx9Cx7rPnJUgyr0kYmHuF/iZ9
         itmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SRkfHTH4+fu9f6ALb3AqJ2EBY/NMIz0PCvmgLDj2MLk=;
        b=LJHAP88t8KiKtMUbjXOl/IDs/m1oS/LGaTstgaSeJI7VUN5ZIq+Q66eIwDncdquJyq
         OdKCNTE6LzDYkSwKgURi0kcZZR0PJq9IWQHS00CtMCe7eJkJuULkiUjzmN260ExReu0H
         hQiWPOiaJr/4g2NW+raiSUOM5UHg9XzQEIiS+IP+qsef/k6nDbdhG/7sRqIoj+VI+jPn
         LA+4ytcDRNWXbvR+ZSmtLctgEcrlmMSd8D729XChtC1E6xsZSs6z2OEZg6LMDoFNSesq
         HW5shRVU6Lm3X5Kqla2NZqEWaRar8Ki3A2JNMGt6n0DfX1KPTF50QQJfZfcgNUARZa6R
         VorQ==
X-Gm-Message-State: AOAM533z1yi4FHXxfu/Jcfw4uDoBb36lawlLZlp5TD8eOu3U3nwoq3Yi
        taC7/+ySZRlD62lB8X6XK1zBDsN+jlJUoTUQnNWSFA==
X-Google-Smtp-Source: ABdhPJxWWVzorH3sh8A7FTQ2pd4K+M2XOXNbAISu00WLIpR8vT6sbhCHCiBN2p7ubvTNRh82HpwPaVWYngyZQdy+oIA=
X-Received: by 2002:a62:3342:0:b029:3b7:6395:a93 with SMTP id
 z63-20020a6233420000b02903b763950a93mr24284167pfz.71.1630349356441; Mon, 30
 Aug 2021 11:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210830171726.2342558-1-ben.widawsky@intel.com>
In-Reply-To: <20210830171726.2342558-1-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 30 Aug 2021 11:49:05 -0700
Message-ID: <CAPcyv4grX3ppzs9gO991s56pbMokU-G75gkV2y+9Cv8ET7d2Xw@mail.gmail.com>
Subject: Re: [PATCH 1/3] cxl: Fixed defined but not used warnings
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Aug 30, 2021 at 10:17 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> This fixes unused-const-variable warnings emitted by gcc when cxlmem.h
> is used by pretty much all files except pci.c
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  include/uapi/linux/cxl_mem.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index f6e8a005b113..1236dd9ffe23 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -50,7 +50,7 @@ enum { CXL_CMDS };
>  #define ___C(a, b) { b }
>  static const struct {
>         const char *name;
> -} cxl_command_names[] = { CXL_CMDS };
> +} cxl_command_names[] __maybe_unused = { CXL_CMDS };

Since this is a uapi header does this need to be the raw
"__attribute__((__unused__))"?
