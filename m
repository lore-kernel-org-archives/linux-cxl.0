Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BCAC43460
	for <linux-cxl@archiver.kernel.org>; Mon, 10 May 2021 17:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EF8B6112F
	for <linux-cxl@archiver.kernel.org>; Mon, 10 May 2021 17:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhEJRhn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 May 2021 13:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbhEJRha (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 May 2021 13:37:30 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A403C06135E
        for <linux-cxl@vger.kernel.org>; Mon, 10 May 2021 10:32:07 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id zg3so25762086ejb.8
        for <linux-cxl@vger.kernel.org>; Mon, 10 May 2021 10:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fTRKZAFvqeeymDKM/r/UzLZvx5eNijO38qr4B7yUecU=;
        b=WG2cArXg2kBcywMKLErBIWqdK6ViZ+A43yHnNzCeEKDwl8ef6OOBCGGPsCNIhnwtgq
         OKnbg1pUoFa5NkOxx7p+eavNpuKHLmDTkGe52xEmPiPqZabIeotnZ8bVgdB8r/5A8p8z
         mbBqa7euwAldecqynHP+UET9zwKx/5FY7p4v4fR//02KPL5IbhAdR3a8NT6KJeHxRjdt
         IWDLz+xGWr7JetBx8yhlj2CMfGxO0XQZTFYvu52XIW5Nq8I5zEKidHQ2DCyVWKAqPpDg
         VuypFQIec2SfyXj0TN7fAr0ov+EjwMQgY+VWosh3M4NidaItw3pY91ciRmZPdX/O40vD
         q5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fTRKZAFvqeeymDKM/r/UzLZvx5eNijO38qr4B7yUecU=;
        b=DXt1SEs/MGD19WHMN6U+qE+ijoMUfukpyxoogYHBn2BUo7Vq610XKsU4ryNscNVfHp
         R7x4SMeIggjsqYvfANMSq7U4sEb3mhyQXcdAgjax1DDp2daPybEzABDiyf90DIEpjJ+h
         GHQ5U6IUpIRTVceUJuAW04zNeBirmLYE9Lr2juYhwh0dJjadZCCNfNQeGkX/YUeYbfwh
         4NvXWccI6HrlG1JxjnLwefCHmgbSefuPij/svlYLYzV2jlk2l3va+vRBDZ05FXynbs+E
         Nv49TuvW1tab5YStXKxwYJscJS4KH+YF/6y/sjt+PKcV3YuUzdLoVw12/cZIFWcZKUOs
         l+hA==
X-Gm-Message-State: AOAM530dk1fl6l3E4dg1NtaV0KBNN3YZVxmiy27eGR/5+lqysPzlSXEv
        gqyHzKrVVecbpHYv8KKTKUuO7GgADLiDfj0OM/CsYPoPt8k=
X-Google-Smtp-Source: ABdhPJyHSjhlDK3zc/WiT+90p68knPbG/a4ZpLabkTJDhyCAwwOZ7p745kEgDnK2io0XqAhOvv5HP88IY4460qmOo88=
X-Received: by 2002:a17:906:33da:: with SMTP id w26mr27425953eja.472.1620667925736;
 Mon, 10 May 2021 10:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <162042787450.1202325.5718541949681409566.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210510182249.0000267f@Huawei.com>
In-Reply-To: <20210510182249.0000267f@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 10 May 2021 10:31:54 -0700
Message-ID: <CAPcyv4iMSvq17_0nLYgeKFKGWberEyG9HHK=+k+Zy9UQG+4iuw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] CXL Port Enumeration and Plans for v5.14
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, May 10, 2021 at 10:24 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 7 May 2021 15:51:14 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Changes since v2 [1]:
> > - Add some rationale for moving definitions out of mem.c into mem.h
> >   (Jonathan)
> >
> > - Fixup CXL_DEVICE_REGS kernel doc and declare the fixup for the
> >   struct cxl_mem kernel-doc in the changelog (Jonathan)
> >
> > - Fixup cxl_setup_device_regs() kernel-doc (Jonathan)
> >
> > - Cleanup comment in cxl_root_alloc() (Jonathan)
> >
> > - [not changed] refactor device creation into alloc_and_add()
> >   anti-pattern.
> >
> > - Add kernel doc to cxl_address_space_dev_add() to clarify why @host is
> >   needed as an arg. (Jonathan)
> >
> > - Describe what the port devices are representing in "cxl/port:
> >   Introduce cxl_port objects" (Jonathan)
> >
> > - Explain the rationale for /sys/bus/cxl (Bjorn)
> >
> > [1]: http://lore.kernel.org/r/161728744224.2474040.12854720917440712854.stgit@dwillia2-desk3.amr.corp.intel.com
>
> Hi Dan,
>
> What's the base for this series?  Given it was nearly ready to go
> (as far as I'm concerned anyway), I thought I'd give it a spin but
> seems it doesn't have some changes from fixes that have gone upstream.

I did fail to rebase, will rectify, but I did not fail to include a
base-commit entry at the bottom of this cover letter. Will resend
based on -rc1 now that it is out.
