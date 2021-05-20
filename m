Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D665EC433B4
	for <linux-cxl@archiver.kernel.org>; Thu, 20 May 2021 00:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6B0E61184
	for <linux-cxl@archiver.kernel.org>; Thu, 20 May 2021 00:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhETAZe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 19 May 2021 20:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhETAZd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 19 May 2021 20:25:33 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C13C061574
        for <linux-cxl@vger.kernel.org>; Wed, 19 May 2021 17:24:13 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b17so17377845ede.0
        for <linux-cxl@vger.kernel.org>; Wed, 19 May 2021 17:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oOGPCygeGm574jrl8IBVZpfRYMLEqBwpFNqsk8f8+tI=;
        b=qMKqlCPaMAWpZHfXzZKHA7jX+XfwqBNpHw+03AyLdOAletf5oJRmg2TJv3hhgI51g/
         EkMIcNh7Gk6bLCivWMSTaVnTXwkGRLeDMlLbL5wL1fbM3W6MYEs3nKQMBCsOKOOEexJr
         oLeJBLcvx/4b5FSQgMRb87KcIexbJX+PL3vqUQQley4r+bCAPNY4T4qY13B5JZW4mCjs
         I9EESq+GEU2VAmAvoiaN2LAevH+uHo1Eu3WviuUUvL3qVyPzV02MSPttu6SHjTYJqNn+
         Ez45/K348f5szv7SyEiWjezNjv/qnqAkIJlqDzW8ybdjeq0g8JmgYGUe4t4GhgDyFyd2
         sEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oOGPCygeGm574jrl8IBVZpfRYMLEqBwpFNqsk8f8+tI=;
        b=gYbdaX5i3yzFyGAFqQ+jRsGu08eTgJK005919IK2vOZlKz7xp16Rhl6l1OBs/yh9yg
         crViyjZprCLieNpBX674ZRbZvwBw/cicgZxjlM7+egzkqJqm3c3VoaeQX3e8iJ0jkSWU
         q1Ts4poacLPKq/KUUjm5kJawoska+tIH5DMfDRvDQdeVlnfYoV6WaeeDlOfUFFSp/mT9
         zZky5caewJshj1kZrrPltpdiatjRSpuwMgTaWFtGnw0igGd38Bvdfx2ufanlFquWcF1u
         4DlYFh79/okz3y5jrz962T8DSmA9p5o6vOyFj0sQZZql06kfiocXVHRWrBhbphlnx+Ou
         08hQ==
X-Gm-Message-State: AOAM5303v6PIHofdFg4oS4vUdrN/hw/FugmKF4rtbk10I4hYb6uQOlPI
        M1Juzq2rupUyDr7lsNB+IHEJwBhazcFvelGpSBczZg==
X-Google-Smtp-Source: ABdhPJxXlcnRqzUtPMdtnerJMEe6JXxL+MdSKqM+G0z1rrdmKNcd22lTPvn5Wgqroye1VbyrgXTfNSfi0Kn+DBcIxc8=
X-Received: by 2002:a05:6402:128f:: with SMTP id w15mr1939034edv.354.1621470251888;
 Wed, 19 May 2021 17:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210506223654.1310516-1-ira.weiny@intel.com>
In-Reply-To: <20210506223654.1310516-1-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 19 May 2021 17:24:01 -0700
Message-ID: <CAPcyv4g0n0eHv13b+Uy9sjXWVMtf3gB0Trxf9Ns0HhPtp2f6hg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Map register blocks individually
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, May 6, 2021 at 3:37 PM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> User space will want to map some register blocks.

The motivation is not to allow userspace access. The motivation is a
bug fix for hardware implementations that mix component and device
registers into the same BAR and the fact that the driver stack has
independent mapping implementations for those 2 cases. It is a happy
side-effect that this also allows finer grained pci-mmap exclusion.

> Currently BARs are mapped in
> their entirety and pointers to the register blocks are created into those
> mappings.  This will prevent mappings from user space.
>
> This series has 3 clean up patches followed by a patch to mapping the register
> blocks individually.
>
> Unfortunately, the information for the register blocks is contained inside the
> BARs themselves.  Which means the BAR must be mapped, probed, and unmapped
> prior to the registers being mapped individually.
>
> The probe stage creates list of register maps which is then iterated to map
> the individual register blocks.
>
> Ira Weiny (4):
>   cxl/mem: Fully decode device capability header
>   cxl/mem: Reserve all device regions at once
>   cxl/mem: Introduce cxl_decode_register_block()
>   cxl/mem: Map registers based on capabilities
>
>  drivers/cxl/core.c |  84 ++++++++++++++++++++------
>  drivers/cxl/cxl.h  |  34 +++++++++--
>  drivers/cxl/pci.c  | 147 +++++++++++++++++++++++++++++++++++----------
>  3 files changed, 211 insertions(+), 54 deletions(-)
>
> --
> 2.28.0.rc0.12.gb6a658bd00c9
>
