Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A88C433FE
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Feb 2022 21:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244730AbiBDVS5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Feb 2022 16:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348456AbiBDVSA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Feb 2022 16:18:00 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BCCC061796
        for <linux-cxl@vger.kernel.org>; Fri,  4 Feb 2022 13:17:00 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id m7so6770278pjk.0
        for <linux-cxl@vger.kernel.org>; Fri, 04 Feb 2022 13:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kDEtWBF+FkzY2NKHxDg+IP2BBNRMiosO3bx2fXdN2Zs=;
        b=r42ec818szqLkxWoZYqBAhS9cGcDXcv2mRyuvEfw3F7D16kltjOkJRitiddd3N3+Hj
         JeVRC4RpR1rK8a9E2eMyTEVdh1UQfw8q0ERznMg96qWADTVMDBDsXgRXRrEugON6ECZK
         oKt6+q4iTGJOgzo4xKt1URjxHjbctHnOfnYaXSyL+C5Ts8eRJ6vhStKrEd+gFkRVX6e8
         8zi2NFXX3iz3yR/XwjUeNPXx/642wvWCVAgTpgbBqczj8wdK8Sk+fr43NrNV8m40fgVd
         bGoMDfJC4pFqB4bGrUUZlJaS//ElOsdCn7W6CJs2GlfrNedawjQaPvM+pP9dLzfabw1m
         G3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kDEtWBF+FkzY2NKHxDg+IP2BBNRMiosO3bx2fXdN2Zs=;
        b=aQST6eEiXtr2kmX9bWAEbLRibMNDlt9i4x7soGzfaKftSKi7CYlsCtDxnBx6vIRbdR
         9m/Vs/N6wcMRCf8ESmI1Hs981ArPpP7Fd4JYtQaCkjYk7NSInTj/UC8BlD9lI1iGGvO/
         MXGfMJ4NPjBEs//X1utYvhR78PCF3HbUDEopiSuAoWkFMykewkwFmbYYapUdOsyr1D2/
         QX2F+8AvCxnpiKy9UpIhkdZ2lGNdiwg4BEMZCNWG/rEhOun39zsdDsbSTIsJuNWBlVSJ
         tNvOsj6IYgWFRpOE2Iv+BQArwh9Zgqvf8udosvm5rTeVzfPvmZOegyuYVuzNaQg+tM1h
         tZYQ==
X-Gm-Message-State: AOAM530iozI9y89/+FYvp1lb/W/9+zpr76vV44mkAcuqwo14r3v5XJJR
        qahE+jOfKdREFH63uoPWBmKZx0ACcV9oNyGVlIb7hw==
X-Google-Smtp-Source: ABdhPJyYTHXd2SrC9SGFxE2ktHk2dl3UoJFNcRrSZVbTvz8JWMKwrHE3BqN2e3RkLP538tVK3yIoU7ZN4ib1cUV+/Cw=
X-Received: by 2002:a17:902:d705:: with SMTP id w5mr5259433ply.34.1644009420472;
 Fri, 04 Feb 2022 13:17:00 -0800 (PST)
MIME-Version: 1.0
References: <20220201071952.900068-1-ira.weiny@intel.com> <20220201071952.900068-3-ira.weiny@intel.com>
In-Reply-To: <20220201071952.900068-3-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 4 Feb 2022 13:16:49 -0800
Message-ID: <CAPcyv4hokCBMZCbqZ38-Aj+yMk3H+OmX7Ykn=5-4_jqiCV5Zug@mail.gmail.com>
Subject: Re: [PATCH V6 02/10] PCI: Replace magic constant for PCI Sig Vendor ID
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Jan 31, 2022 at 11:20 PM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> Based on Bjorn's suggestion[1], now that the PCI Sig Vendor ID is
> defined the define should be used in pci_bus_crs_vendor_id() rather than
> the hard coded magic value.
>
> Replace the magic value in pci_bus_crs_vendor_id() with
> PCI_VENDOR_ID_PCI_SIG.
>
> [1] https://lore.kernel.org/linux-cxl/20211117215044.GA1777828@bhelgaas/
>
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/pci/probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 087d3658f75c..d92dbb136fc9 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2318,7 +2318,7 @@ EXPORT_SYMBOL(pci_alloc_dev);
>
>  static bool pci_bus_crs_vendor_id(u32 l)
>  {
> -       return (l & 0xffff) == 0x0001;
> +       return (l & 0xffff) == PCI_VENDOR_ID_PCI_SIG;
>  }

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
