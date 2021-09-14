Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5603CC433FE
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Sep 2021 23:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D71A61056
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Sep 2021 23:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbhINXc5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Sep 2021 19:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbhINXc5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Sep 2021 19:32:57 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A6EC061574
        for <linux-cxl@vger.kernel.org>; Tue, 14 Sep 2021 16:31:39 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id j6so940621pfa.4
        for <linux-cxl@vger.kernel.org>; Tue, 14 Sep 2021 16:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hm61krRhwdaOn1DfRRYML8fZkQhjUAhs/wEd2G7Hu/4=;
        b=zwfghK5frfBZgcrAoCOFt4vuV1a55hJjANSifI02c83t3vB62gBNoiKnPCM8qb4XfD
         BPKg/YhwB9bIY1zS4aBsiFU7jCmokY7XzzV8yJ5B4ep/oaZo6x1q6Gu/QzYnqmifEdc8
         oEXTRWPTfGe+38fYt9JLial7hWYorxEWZpZY4c5V0R8zwt7ATbeZfuW2+UI3/m1CJbKc
         61oGzOOz0ayM/TSetDBiVskVYPZrb9SXBvHklCBCHBkHa3/BdApUIBPLi1a3JdocOVTn
         04W4G4kStOvnCC+ppUlmHNaU1mzKM2DtACRMUY8UF5YUvHV77mcKYcmsaOARpKOpfE7u
         dmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hm61krRhwdaOn1DfRRYML8fZkQhjUAhs/wEd2G7Hu/4=;
        b=SHLPpa0bFddACrxX+FenTyvd1H6BgGHx+9i9ZSJrGeqrobqG6f4TLKcWJMmyrPCdQP
         yiuBnRcQxaKj0MYHZBPI7PzdMF+ON/ybLy+sCVefXsPXtz9dSX+aQ4mdA3aAF6JHjnc6
         iPTMRF6wsIl2ZFWCCRtIBfzJ/78VhWCyDOmN94hkp5Icz61dxaP5odOUPZ9cnla31lCC
         +s7jZLRYIfiNvP+71ozc0+xHiXrkUMc3MEHoZs0Ip7eOUZSXfNmCZQSjYNeL5FPHmRxJ
         AUEmJVE4OLWNqfB1jCT2RxUPU11QS/3UloDisYekzTjFANCfPjnbKk0kZZ39J4KHAVjN
         Arhw==
X-Gm-Message-State: AOAM530vhfgIsaWPD4y0PZdhboeOd0eBn/RU2v6SnIyjMB9UPduoB0+m
        sbFPn8ufTG6lfMXQpOwzL8PgWY0CqvfjCHW9Y6DzRg==
X-Google-Smtp-Source: ABdhPJwj3/M5X3fT/WSESrqJUOvKbbOxG/N2g90YLbqzibqEdHmJEElM+QjVUaqX4oqZRwWX1zoBwOfIBM6n/1Gbvb4=
X-Received: by 2002:a63:1e0e:: with SMTP id e14mr17632763pge.5.1631662298660;
 Tue, 14 Sep 2021 16:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210902195017.2516472-1-ben.widawsky@intel.com> <20210902195017.2516472-14-ben.widawsky@intel.com>
In-Reply-To: <20210902195017.2516472-14-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 14 Sep 2021 16:31:27 -0700
Message-ID: <CAPcyv4gAw89TXH3K7DTGNwSARdOBZza+VPssJ3wioNeyRrviOg@mail.gmail.com>
Subject: Re: [PATCH 13/13] cxl/mem: Enumerate switch decoders
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

On Thu, Sep 2, 2021 at 12:50 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Switches work much in the same way as hostbridges. The primary
> difference is that they are enumerated, and probed via regular PCIe
> mechanisms. A switch has 1 upstream port, and n downstream ports.
> Ultimately a memory device attached to a switch can determine if it's in
> a CXL capable subset of the topology if the switch is CXL capable.
>
> The algorithm introduced enables enumerating switches in a CXL topology.
> It walks up the topology until it finds a root port (which is enumerated
> by the cxl_acpi driver). Once at the top, it walks back down adding all
> downstream ports along the way.
>
> Note that practically speaking there can be at most 3 levels of switches
> with the current 2.0 spec. This is because there is a max interleave of
> 8 defined in the spec. If there is a single hostbridge and only 1 root
> port was CXL capable, you could have 3 levels of x2 switches, making
> the x8 interleave. However, as far as the spec is concerned, there can
> be infinite number of switches since a x1 switch is allowed, and
> future versions of the spec may allow for a larger total interleave.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/mem.c | 130 +++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/pci.c |   8 ---
>  drivers/cxl/pci.h |   8 +++
>  3 files changed, 137 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index aba9a07d519f..dc8ca43d5bfc 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -56,6 +56,133 @@ static bool is_cxl_mem_enabled(struct pci_dev *pdev)
>         return true;
>  }
>
> +/* TODO: dedeuplicate this from drivers/cxl/pci.c? */

No need to carry this debt with the planned port driver reorganization, right?

> +static unsigned long get_component_regs(struct pci_dev *pdev)
> +{
> +       unsigned long component_reg_phys = CXL_RESOURCE_NONE;
> +       u32 regloc_size, regblocks;
> +       int regloc, i;
> +
> +       regloc = cxl_pci_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
> +       if (!regloc) {
> +               dev_err(&pdev->dev, "register location dvsec not found\n");
> +               return component_reg_phys;
> +       }
> +
> +       /* Get the size of the Register Locator DVSEC */
> +       pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
> +       regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
> +
> +       regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
> +       regblocks = (regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET) / 8;
> +
> +       for (i = 0; i < regblocks; i++, regloc += 8) {
> +               u32 reg_lo, reg_hi;
> +               u8 reg_type;
> +               u64 offset;
> +               u8 bar;
> +
> +               pci_read_config_dword(pdev, regloc, &reg_lo);
> +               pci_read_config_dword(pdev, regloc + 4, &reg_hi);
> +
> +               cxl_decode_register_block(reg_lo, reg_hi, &bar, &offset,
> +                                         &reg_type);
> +
> +               if (reg_type != CXL_REGLOC_RBI_COMPONENT)
> +                       continue;
> +
> +               component_reg_phys = pci_resource_start(pdev, bar) + offset;
> +       }
> +
> +       return component_reg_phys;
> +}
> +
> +static void enumerate_uport(struct device *dev)
> +{
> +       struct pci_dev *pdev = to_pci_dev(dev);
> +
> +       /*
> +        * Parent's parent should be another uport, since we don't have root
> +        * ports here
> +        */

I don't understand this comment, can you rephrase?

> +       if (dev_WARN_ONCE(dev, !dev->parent->parent, "No grandparent port\n"))
> +               return;

It's not clear that this can only fire in the case of a software bug.
If this might fire at runtime in production it should be dev_warn().

> +
> +       if (!is_cxl_port(dev->parent->parent)) {

Not a fan of multiple de-references... does this grandparent have a better name?

> +               dev_info(dev, "Parent of uport isn't a CXL port (%s)\n",

dev_dbg()?

> +                        dev_name(dev->parent->parent));
> +               return;
> +       }
> +
> +       devm_cxl_add_port(dev, dev, get_component_regs(pdev),
> +                         to_cxl_port(dev->parent));
> +}
> +
> +static void enumerate_dport(struct device *dev)
> +{

Is the argument a dport?

Perhaps this wants a:

struct cxl_dport {
     struct device *dev;
};

...definition to make it clear what argument is being passed?

> +       struct pci_dev *pdev = to_pci_dev(dev);

What about the case where a 'struct acpi_device' is the dport?

> +       u32 port_num, lnkcap;
> +
> +       if (dev_WARN_ONCE(dev, !dev->parent, "No parent port\n"))
> +               return;
> +
> +       if (!is_cxl_port(dev->parent)) {
> +               dev_info(dev, "Uport isn't a CXL port %s\n",
> +                        dev_name(dev->parent));
> +               return;
> +       }
> +
> +       /* TODO: deduplicate from drivers/cxl/acpi.c? */
> +       if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
> +                                 &lnkcap) != PCIBIOS_SUCCESSFUL)
> +               return;
> +       port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> +
> +       cxl_add_dport(to_cxl_port(dev->parent), dev, port_num,
> +                     get_component_regs(pdev));
> +}
> +

Should the above go straight to a new drivers/cxl/core/pci.c? The
cxl_acpi driver will need this when it is asked to scan for new CXL
ports in the topology.

> +/*
> + * Walk up the topology until we get to the root port (ie. parent is a
> + * cxl port). From there walk back down adding the additional ports. If the
> + * parent isn't a PCIe switch (upstream or downstream port), the downstream
> + * endpoint(s) cannot be CXL enabled.
> + *
> + * XXX: It's possible that cxl_acpi hasn't yet enumerated the root ports, and
> + * so that will rescan the CXL bus, thus coming back here.
> + */
> +static void enumerate_switches(struct device *dev)
> +{
> +       struct pci_dev *pdev;
> +       int type;
> +
> +       if (unlikely(!dev))
> +               return;
> +
> +       if (unlikely(!dev_is_pci(dev)))
> +               return;
> +
> +       pdev = to_pci_dev(dev);
> +
> +       if (unlikely(!pci_is_pcie(pdev)))
> +               return;

unlikely() is a micro-optimization only after demonstrating
performance harm from cache pollution, not to document things that
generally won't happen in slow paths.


> +
> +       if (!is_cxl_mem_enabled(pdev))
> +               return;
> +
> +       type = pci_pcie_type(pdev);
> +
> +       if (type != PCI_EXP_TYPE_UPSTREAM && type != PCI_EXP_TYPE_DOWNSTREAM)
> +               return;
> +
> +       enumerate_switches(dev->parent);
> +
> +       if (type == PCI_EXP_TYPE_UPSTREAM)
> +               enumerate_uport(dev);
> +       if (type == PCI_EXP_TYPE_DOWNSTREAM)
> +               enumerate_dport(dev);
> +}
> +
>  static int cxl_mem_probe(struct device *dev)
>  {
>         struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> @@ -68,7 +195,8 @@ static int cxl_mem_probe(struct device *dev)
>         if (!is_cxl_mem_enabled(pdev))
>                 return -ENODEV;
>
> -       /* TODO: if parent is a switch, this will fail. */
> +       enumerate_switches(dev->parent);
> +
>         port_dev = bus_find_device(&cxl_bus_type, NULL, pdev_parent, port_match);
>         if (!port_dev)
>                 return -ENODEV;
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 258190febb5a..e338f2f759d0 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -400,14 +400,6 @@ static int cxl_map_regs(struct cxl_mem *cxlm, struct cxl_register_map *map)
>         return 0;
>  }
>
> -static void cxl_decode_register_block(u32 reg_lo, u32 reg_hi,
> -                                     u8 *bar, u64 *offset, u8 *reg_type)
> -{
> -       *offset = ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
> -       *bar = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
> -       *reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
> -}
> -
>  /**
>   * cxl_pci_setup_regs() - Setup necessary MMIO.
>   * @cxlm: The CXL memory device to communicate with.
> diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> index d6b9978d05b0..8250d487e39d 100644
> --- a/drivers/cxl/pci.h
> +++ b/drivers/cxl/pci.h
> @@ -34,4 +34,12 @@
>
>  int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec);
>
> +static inline void cxl_decode_register_block(u32 reg_lo, u32 reg_hi, u8 *bar,
> +                                            u64 *offset, u8 *reg_type)
> +{
> +       *offset = ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
> +       *bar = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
> +       *reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
> +}
> +
>  #endif /* __CXL_PCI_H__ */
> --
> 2.33.0
>
