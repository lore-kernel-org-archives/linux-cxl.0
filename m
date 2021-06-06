Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3617C47082
	for <linux-cxl@archiver.kernel.org>; Sun,  6 Jun 2021 00:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A480F61244
	for <linux-cxl@archiver.kernel.org>; Sun,  6 Jun 2021 00:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhFFAda (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 5 Jun 2021 20:33:30 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:37886 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhFFAda (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 5 Jun 2021 20:33:30 -0400
Received: by mail-pg1-f177.google.com with SMTP id t9so10960075pgn.4
        for <linux-cxl@vger.kernel.org>; Sat, 05 Jun 2021 17:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6VDXTVjj0+nDYDx9MzuRgoWOTGmLXmo7MLzx3SNS5KE=;
        b=aF4K2RxbGJ0PQBQ7D3cYri2KfdGuuo5AdXRx8xAhRX4yF2qckKVdHSiXbRLjJUhBNt
         6Att/2kYuIt/fywVjHIL1rt1CG6AOKwaOC9p66n8Rb8dRAqp3ViFB9JhrEFf+FMB3YUN
         gWN5ixiTZQl3lqZz1E3iceKF0lq8eID6gweu7jj7+yyIQeppa5DHP87FwCMwa8r3rfDG
         HqONyrgApjzC9o6bNDVSXdEJVdXxS28TpawC7OiXRJ4+vJKpvnBIBFsIE+O9KvxcsQTF
         S3CbQ7UOzjxzAd2cYl9NXEenXB3xlv4kdt/20CUARiJ/j0/XddQzOgIA/XGKc9tI17tR
         FTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6VDXTVjj0+nDYDx9MzuRgoWOTGmLXmo7MLzx3SNS5KE=;
        b=GidsYh/6m60nncFj41tXkElznHWgjxWWv2+5VZRVCXt7jn6MREU+ZqmksMglPY16Ty
         ahkkz2LDLoiD6SvoJLEEk6uQPuTzKqBDRMTw2a4PTszTB3eN/MOSNG0xvKq/lYZ4GODP
         Qv4RWWd1xIftzVGXEyRrkTPwexkGMmXJdC/TrsXSoazYy9pIY6VPgYw/R+3EL8oHGACj
         1P6eqb6Ng6Gk2+QAKQtb8xKmcnUpnXOmDIOsgkJrZ66GfcZrmoumlNKznWqa+RCwLpCk
         O9GxkOU6plf4qKfnPxhENYJL+5JNvJKPcys4uzXbti6oOdNOb3qxtrTXeii5prlN4NBT
         61hw==
X-Gm-Message-State: AOAM530RM1ldk/MD4/x66gWhuR9qGMQakbDCFr6xiIWvEZ9v4hT7fQ3Z
        5rbVNnqw+1o7seWaA0cuNDchKp80N89q4O2UooTQyw==
X-Google-Smtp-Source: ABdhPJzfiCeY9tqkKmkSLOuJ3+obh7ppS3Yk4qcjz4CnNdglKlz/qX//z+ULFPvbFtaPxMN7nenRtAVDZzVBLsNhccI=
X-Received: by 2002:a63:4653:: with SMTP id v19mr11479580pgk.240.1622939441444;
 Sat, 05 Jun 2021 17:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210528004922.3980613-4-ira.weiny@intel.com> <20210604005036.4187184-1-ira.weiny@intel.com>
In-Reply-To: <20210604005036.4187184-1-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 5 Jun 2021 17:30:30 -0700
Message-ID: <CAPcyv4jrdGAtaoArXEQAH5XPrGQxCraiMD54UR_HfHmu3Z1iYw@mail.gmail.com>
Subject: Re: [PATCH V3.1] cxl/mem: Map registers based on capabilities
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jun 3, 2021 at 5:51 PM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> The information required to map registers based on capabilities is
> contained within the bars themselves.  This means the bar must be mapped
> to read the information needed and then unmapped to map the individual
> parts of the BAR based on capabilities.
>
> Change cxl_setup_device_regs() to return a new cxl_register_map, change
> the name to cxl_probe_device_regs().  Allocate and place
> cxl_register_maps on a list while processing all of the specified
> register blocks.
>
> After probing all the register blocks go back and map smaller registers
> blocks based on their capabilities and dispose of the cxl_register_maps.
>
> NOTE: pci_iomap() is not managed automatically via pcim_enable_device()
> so be careful to call pci_iounmap() correctly.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Link: https://lore.kernel.org/r/20210528004922.3980613-4-ira.weiny@intel.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> ---
> Changes for V3.1
>         Fix 0-day
>
> >> drivers/cxl/core.c:40:17: warning: variable 'register_block' set but not used [-Wunused-but-set-variable]
>       40 |   void __iomem *register_block;

Just a note for next time if you want to be friendly to "b4 am" using
maintainers. Roll the version and include the patch number in the
resend, i.e.: in this case: "[PATCH v4 3/5] cxl/mem: Map registers
based on capabilities". I was able to manually create a bundle in the
proper order on patchwork for the two "3.1" updates.
