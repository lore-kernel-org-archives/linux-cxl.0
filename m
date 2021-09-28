Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6321C433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Sep 2021 14:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 902D0610E6
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Sep 2021 14:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241331AbhI1Onx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Sep 2021 10:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241270AbhI1Onw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Sep 2021 10:43:52 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63472C06161C
        for <linux-cxl@vger.kernel.org>; Tue, 28 Sep 2021 07:42:13 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id l8-20020a4ae2c8000000b002b5ec765d9fso361144oot.13
        for <linux-cxl@vger.kernel.org>; Tue, 28 Sep 2021 07:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EhyfaFfmpYzLgiWiMX1s0Z67f4LnrHK0KizRdjLnqJw=;
        b=chZAM6VPfyeAr8nqg4SrTVeBKQVNy32nK0MCL9hXLqYHkCSaBIuCY4L9340PwMXY81
         oX7KSMtTXh9aMON1lHCK0x3P5EwD2uawm9OkvBX4/0RXdgLlydme/qvFUvgvv9WA9Sv/
         Yz21N3KSQUS2EZKolBII/gB4UKw+N3eLKo52na8cVvsAJ+Qc2SeaGzdn8hRPrSmtLUIP
         aRpX80YJRQ8nBCKprXegn9SXbCfxmYUl3oIwG6UYYMLCsBzmBW5xMWFkV25U8SWzllts
         kIxnMRI6kDbq5RYBmMNwi7Wlv9DpyqfjkDB7DdGDvHHixU/+azKq4y+P+1z9W+Dxdw1N
         bQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EhyfaFfmpYzLgiWiMX1s0Z67f4LnrHK0KizRdjLnqJw=;
        b=FgOL/zE3Hp6L21NWfGw9Aq7J657D9FTYx18wtuwY1TTwvMUlW+Lw2fyCcycCVzfdaA
         LtFbNvt1QEyIPyPAHDuszRtZZLd7oiNX+jdbX/RwM/pwmOLv/Bdxxem6uwxNV67KSJTN
         yHbABSjA+moIUROF4JU1cMze0YGAWxpCkCd9RTi+13w3jITCBZp3af7guVtryaVcjnMd
         XZ6kXwxKyF0FjvhWWj+Qwm7sPaBPOFcqbuXM7wndfg0Q9x27C3gEbUcjdybC/BNu780l
         6MMXP3aMa1aBYvFHpcEVC0aLCa7wp+yn9LMFr9XVaGY8Bn7INgoOMHv9PFU+32/H/sPD
         w4ZQ==
X-Gm-Message-State: AOAM531l2e7ntPltcIuVODEc9m7Pe6idbqKJvqh6dNQNY/6XBBGwfRis
        CnxcMNW8snyBQR+M6LCtdDz4g9oRcf8Z/ZWCiZsHNA==
X-Google-Smtp-Source: ABdhPJxsyNViSzziMqVNWC0HCL2fNBAjJtzRxqsLj/BUr+opO/6Yx5+T1yeJwLyWxMocosrCzkw74g3ptylH1JuvRA0=
X-Received: by 2002:a4a:88e2:: with SMTP id q31mr5127880ooh.91.1632840132764;
 Tue, 28 Sep 2021 07:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210923172647.72738-1-ben.widawsky@intel.com> <20210923172647.72738-4-ben.widawsky@intel.com>
In-Reply-To: <20210923172647.72738-4-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 28 Sep 2021 07:42:00 -0700
Message-ID: <CAPcyv4jZUiwqGrYGX3Mmj9XqUvZwZwh79wAQTFxf5g+wZOohtQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] cxl/pci: Remove pci request/release regions
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Andrew Donnellan <ajd@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "David E. Box" <david.e.box@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Sep 23, 2021 at 10:26 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Quoting Dan, "... the request + release regions should probably just be
> dropped. It's not like any of the register enumeration would collide
> with someone else who already has the registers mapped. The collision
> only comes when the registers are mapped for their final usage, and that
> will have more precision in the request."

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

>
> Recommended-by: Dan Williams <dan.j.williams@intel.com>

This isn't one of the canonical tags:
Documentation/process/submitting-patches.rst

I'll change this to Suggested-by:

> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/pci.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index ccc7c2573ddc..7256c236fdb3 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -453,9 +453,6 @@ static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
>                 return -ENXIO;
>         }
>
> -       if (pci_request_mem_regions(pdev, pci_name(pdev)))
> -               return -ENODEV;
> -
>         /* Get the size of the Register Locator DVSEC */
>         pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
>         regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
> @@ -499,8 +496,6 @@ static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
>                 n_maps++;
>         }
>
> -       pci_release_mem_regions(pdev);
> -
>         for (i = 0; i < n_maps; i++) {
>                 ret = cxl_map_regs(cxlm, &maps[i]);
>                 if (ret)
> --
> 2.33.0
>
