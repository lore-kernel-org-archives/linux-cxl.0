Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF71C433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Sep 2021 17:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25B37611CE
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Sep 2021 17:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241876AbhI1R4O (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Sep 2021 13:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241860AbhI1R4O (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Sep 2021 13:56:14 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0435AC061745
        for <linux-cxl@vger.kernel.org>; Tue, 28 Sep 2021 10:54:34 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ce20-20020a17090aff1400b0019f13f6a749so2007840pjb.4
        for <linux-cxl@vger.kernel.org>; Tue, 28 Sep 2021 10:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=orLVhujXuv2LS5anVE9u/slnGdTOgg9Wqn1uh5hqGWw=;
        b=m9sdz73zrjMRDNHc22Gye23uo5ygGPs1cs0mwoNlJ8VUnRLj8voa2vDhgXj2bS9aj2
         aFhf//KoZX796AfWAxpvTXYans8OImGiqCnRmi3Sk6Ml+QvEusKyfBHiXH1VyjA/4sAj
         UeJfSWxx/AfUAAGtCDiw7qNfVTwlszxzNkutU2boB4mHGNl+IVnbL6EhEyS0Cbiztu0L
         JVqp+cBc6JyoHQsLuIcU0LZ6aCx3k+4ofEprD7f3HduGu0V2uJP+PxCitVTzo0PLQ7RZ
         AxHnDX37k0hreucdd5P9XUEzif8rbactBU8SMjoIo1axW/j7y7ez4LhcbOiIdS/8XM3N
         3iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=orLVhujXuv2LS5anVE9u/slnGdTOgg9Wqn1uh5hqGWw=;
        b=c/0dOUcW5SvSk1DSeHRHiDqnzb2B0hNZXdCAVkZN3MEvZs5ftPHdHOYqaEX+9luAN8
         FTaUqSiLh3wBnD0XWzeZ13l6bAkvnAB45wt1pCDm8pWMvZxQ+cMyBHZYzK+n6amUQkCQ
         BQ7OJaG94TkxSEKejy4vvKUEHzUNtIouOOqQlQ5czDx3QQhkemwLIMHz+KPuzd+Gtbh7
         tBdeL4z6P0s/LzmCWwnGbBTWetKIkbgyb1gSmcN6go7jm10DLmDajEcNygCnTaPJ2812
         dQSQKxg30Ji0/WzyQEqtz99XBcqAGbdyhEvgLBiChW8qbXCMJ2AVJpUVHVG3TQ0cO0ul
         VvLw==
X-Gm-Message-State: AOAM532s8QQhxZKrdTAPFLKtkLiWe+nFjN2f8E2+X7YEruSeLvTD6fUC
        g09De12f6qg5o+WgUkBVudwlz55tY6KhXNjLUPC08Q==
X-Google-Smtp-Source: ABdhPJzAafw90qw6GNR9KOTGCaZVcRyonxJQDUdkiFkRD78TDB31Hda8XvnX+oGdm1yTApwMPKKhgoUwD7Dy3t2YpxQ=
X-Received: by 2002:a17:90a:d686:: with SMTP id x6mr1390645pju.8.1632851674343;
 Tue, 28 Sep 2021 10:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210923172647.72738-1-ben.widawsky@intel.com> <20210923172647.72738-10-ben.widawsky@intel.com>
In-Reply-To: <20210923172647.72738-10-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 28 Sep 2021 10:54:21 -0700
Message-ID: <CAPcyv4i4T4XLW-P=CzdO47mZ8+_Mih7GMeDEXAtgEE+gO9JQHw@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] iommu/vt-d: Use pci core's DVSEC functionality
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Sep 23, 2021 at 10:27 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Reduce maintenance burden of DVSEC query implementation by using the
> centralized PCI core implementation.
>
> Cc: iommu@lists.linux-foundation.org
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index d75f59ae28e6..30c97181f0ae 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5398,20 +5398,7 @@ static int intel_iommu_disable_sva(struct device *dev)
>   */
>  static int siov_find_pci_dvsec(struct pci_dev *pdev)
>  {
> -       int pos;
> -       u16 vendor, id;
> -
> -       pos = pci_find_next_ext_capability(pdev, 0, 0x23);
> -       while (pos) {
> -               pci_read_config_word(pdev, pos + 4, &vendor);
> -               pci_read_config_word(pdev, pos + 8, &id);
> -               if (vendor == PCI_VENDOR_ID_INTEL && id == 5)
> -                       return pos;
> -
> -               pos = pci_find_next_ext_capability(pdev, pos, 0x23);
> -       }
> -
> -       return 0;
> +       return pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_INTEL, 5);
>  }

Same comments as the CXL patch, siov_find_pci_dvsec() doesn't seem to
have a reason to exist anymore. What is 5?
