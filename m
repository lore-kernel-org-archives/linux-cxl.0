Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7747C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 20:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC28F6101E
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 20:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhJ2US2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Oct 2021 16:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhJ2US2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Oct 2021 16:18:28 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755AFC061570
        for <linux-cxl@vger.kernel.org>; Fri, 29 Oct 2021 13:15:59 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id r5so7559795pls.1
        for <linux-cxl@vger.kernel.org>; Fri, 29 Oct 2021 13:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P+IKoZykB1Ak6oHuSp53vFhrnsD84fpKZ6mIOBj/kSQ=;
        b=OJucBkETNbqr3if7Zbe88A7Dem80kkELYFWwdDGBJyR6z7eMr5ZBxFQaKysFNN9lZ5
         Tb/o6BnIUsnPFD2f679hrjWfy1oTQkS/yMNEgYLqVKEf930Dgak3aY9PRHPzUnjXW4Ra
         laCrNQrNAWtBzusr3jporrHeIm+xbeMKIJwAhMqwwII7xtd95Fe1EuFYaiMKvMC6/FkO
         7Q1S/kdNzG1Xh2f3DFjxOtMelAcdLPzNEAsZqZdGtX76a29yiLQEc1C3vJMM4AlkYG+O
         QZzTgm69zg1uKrkIWhhC9AwgCstK2b3wcwDqJ9xFO/9YsZWtOayfwNS6KcLuk3KUF2nK
         rjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P+IKoZykB1Ak6oHuSp53vFhrnsD84fpKZ6mIOBj/kSQ=;
        b=vLlVLYygMKCTpNpQDWhLoo71cebXlkOXKhz7EhfxDMWhEG8o7JhvaH2NZr1b/tGFFa
         76WRlZ9CXanjWXfzz0gRwTucck2DSwDmfadOk0wuJDaOl8lazeN4jcvv3MVeoYbk3515
         NyKVasYaH61mqlvql3G9WD4vG+76FVe1LjB/3SnLNXR99xb8bi2RhX3dpiPqjafmo8cm
         i2uaL9DFRxJwIJKv2oGJTQxzeII7If3gw2zsDJRHVgp9UFXr0QL7YDs6NC+ctIEwY4oc
         cyS/zDw9BH12bgqrxq0bUa4g/jYSMGdhb/+o9Ksz0akEGAwPOFWw8QJi6bkR55muTUkP
         EQ6A==
X-Gm-Message-State: AOAM531VcILW4LcZSaqDJvQV4aWdc6XR1w6X6twHkQN2BTA2iIHHTiTM
        ycaiqovo3GubZSm+I0/POJ8qnhizVL2hn/qh1i51JA==
X-Google-Smtp-Source: ABdhPJy1/s857RM3levaRgQfBCVJwrijStVkQ21O1+BicSC1/daw704nOt8mtRbP3BJ3nEkz1cc/c0npBit7YU/UFG8=
X-Received: by 2002:a17:902:ab50:b0:13f:4c70:9322 with SMTP id
 ij16-20020a170902ab5000b0013f4c709322mr11472405plb.89.1635538558973; Fri, 29
 Oct 2021 13:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com> <20211022183709.1199701-2-ben.widawsky@intel.com>
In-Reply-To: <20211022183709.1199701-2-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 29 Oct 2021 13:15:46 -0700
Message-ID: <CAPcyv4i_ZnMkTwOcg=94AO959Gzt1FFkirEO=FL3sjNcMsCAeA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/28] cxl: Rename CXL_MEM to CXL_PCI
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> With the upcoming introduction of a driver to control the non-PCI
> aspects of CXL.mem, such as interleave set creation and configuration,
> there will be an opportunity to disconnection control over CXL device

s/disconnection/disconnect/

> memory and CXL device manageability. CXL device manageability is
> implemented by the cxl_pci driver. Doing this rename allows the CXL
> memory driver to be enabled by a new config option independently of CXL
> device manageability through CXL.io/PCI mechanisms.

That comes across a bit hard to parse to me, how about:

"The cxl_mem module was renamed cxl_pci in commit 21e9f76733a8 ("cxl:
Rename mem to pci"). In preparation for adding an ancillary driver for
cxl_memdev devices (registered on the cxl bus by cxl_pci), go ahead
and rename CONFIG_CXL_MEM to CONFIG_CXL_PCI. Tree up the CXL_MEM name
for that new driver to manage generic CXL.mem endpoint operations."

> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/Kconfig  | 13 ++++++-------
>  drivers/cxl/Makefile |  2 +-
>  2 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index e6de221cc568..23773d0ac896 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -13,14 +13,13 @@ menuconfig CXL_BUS
>
>  if CXL_BUS
>
> -config CXL_MEM
> -       tristate "CXL.mem: Memory Devices"
> +config CXL_PCI
> +       tristate "PCI manageability"

s/PCI manageability/CXL Memory Device: PCI Operations/

...as I don't think an end user reading "PCI Manageability" would know
that it supports basic memory expander enumeration and mailbox
operations.

>         default CXL_BUS
>         help
> -         The CXL.mem protocol allows a device to act as a provider of
> -         "System RAM" and/or "Persistent Memory" that is fully coherent
> -         as if the memory was attached to the typical CPU memory
> -         controller.
> +         The CXL specification defines a set of interfaces which are controlled
> +         through well known PCI configuration mechanisms. Such access is
> +         referred to CXL.io in the specification.

The CXL specification defines a "CXL memory device" sub-class in the
PCI "memory controller" base class of devices. Device's identified by
this class code provide support for volatile and / or persistent
memory to be mapped into the system address map (Host-managed Device
Memory (HDM)).

>
>           Say 'y/m' to enable a driver that will attach to CXL.mem devices for

This would need updating too...

s/CXL.mem devices /generic CXL memory expanders identified by the
memory device class code/

...to reduce confusion about this driver for generic type-3 vs vendor
specific type-2 devices that also support CXL.mem

>           configuration and management primarily via the mailbox interface. See
> @@ -31,7 +30,7 @@ config CXL_MEM
>
>  config CXL_MEM_RAW_COMMANDS
>         bool "RAW Command Interface for Memory Devices"
> -       depends on CXL_MEM
> +       depends on CXL_PCI
>         help
>           Enable CXL RAW command interface.
>
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index d1aaabc940f3..cf07ae6cea17 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += core/
> -obj-$(CONFIG_CXL_MEM) += cxl_pci.o
> +obj-$(CONFIG_CXL_PCI) += cxl_pci.o
>  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
>  obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
>
> --
> 2.33.1
>
