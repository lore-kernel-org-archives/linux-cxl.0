Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8194C48BE8
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 15:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93742613B4
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 15:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbhFRPCR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Jun 2021 11:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbhFRPCQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Jun 2021 11:02:16 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2253C061574
        for <linux-cxl@vger.kernel.org>; Fri, 18 Jun 2021 08:00:06 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y4so884244pfi.9
        for <linux-cxl@vger.kernel.org>; Fri, 18 Jun 2021 08:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vq/7cUHkPXoaf6tpf10bXeaYOdUUzIBwKvXI64t3zFw=;
        b=XNaZrg82aiV/f9+m0GJeQVkKAc4UUWY62oeeKdc4Vx6LoiZbDMQowSjeGfuqqcr7ZP
         g6JVipUode9WI/67iorRUljjQDpACd0FPaoLQp9hqm6w9CiGJRY+enme3RZwp6xshKr9
         O/L3/JKfwoTocnvZyzMMYY+SGAGZtP7kwlN/6udq/NQb96NhodEA6uAfgTb2fMce7jaM
         UB9Zey6GpdLvRv0xQo5dWX4yJk8jfUrMcnd+/19e/JB02CfNflNNTIVOSIW4wKYin0Rp
         91+IQ1V3LKdWh+9dM8c6EW8zfxJ/egTwj/+foqLOwpN7REM/vVivOpTmig2P0yhAcXoS
         4tnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vq/7cUHkPXoaf6tpf10bXeaYOdUUzIBwKvXI64t3zFw=;
        b=TuDxVsBYaRadv31JdvM74yUDjHjgdIcDtBBzL4o+rONtitq9kUdPqvrAFZKcrM7KJp
         YSrytSJ9OQqrVHpI3B2BjbbekL6q849QP3F2i1kix2s1S7xRt/YpxathvqyojilU6EKE
         R+Kc5mlY1qhJjEns8MnvQe/gEcflIRNtbokKeVHuoktB4UrfyjJAZgvgZ888CK7XNzU2
         snVPcM+hVef0FFOrvLnK88Q8uRJybUg2MVCa9QRWwYX09lO8BuNSdkHfQ8SXoxHiN1wJ
         w7FH53CHCuvhI62jiFo111dyduFA+Cz88yzpIb9la/wGrWBHn/CkemBP8cU0vZJlBzw4
         khbA==
X-Gm-Message-State: AOAM530hrb9KKX/D35Zt6EaH/YEKw11mSpf6gMSyj/uC4gRVtM9UavzK
        dOtyHTP0GHJjOBLhj6eCCkQsWZqkLMldGOmJKn3iNA==
X-Google-Smtp-Source: ABdhPJzte3HPow6aXGAfJI89EfTCt1qu/PIXBLuegJp7Hr/jg8LDAdxrz/U7IbH/p47Zs1sbzWwQuWjLzJOGfDy91Hw=
X-Received: by 2002:a63:195b:: with SMTP id 27mr10588556pgz.450.1624028406211;
 Fri, 18 Jun 2021 08:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210617173655.430424-1-ben.widawsky@intel.com> <20210617173655.430424-3-ben.widawsky@intel.com>
In-Reply-To: <20210617173655.430424-3-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 18 Jun 2021 08:00:00 -0700
Message-ID: <CAPcyv4jhKmeW5SmqNEmPs0eqaMywf4QjgfMxH8md10cQ9Pk8rw@mail.gmail.com>
Subject: Re: [PATCH 2/6] cxl: Move cxl_memdev conversion helper to mem.h
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

On Thu, Jun 17, 2021 at 10:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>

If you find yourself not writing a changelog it usually means the
patch has no reason to stand alone...

> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/mem.h | 5 +++++
>  drivers/cxl/pci.c | 5 -----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
> index 8f02d02b26b4..fe12ef3c3dde 100644
> --- a/drivers/cxl/mem.h
> +++ b/drivers/cxl/mem.h
> @@ -48,6 +48,11 @@ struct cxl_memdev {
>         int id;
>  };
>
> +static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
> +{
> +       return container_of(dev, struct cxl_memdev, dev);
> +}
> +
>  /**
>   * struct cxl_mem - A CXL memory device
>   * @pdev: The PCI device associated with this CXL device.
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index f8408e5f0754..52508282ec37 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1161,11 +1161,6 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>         return ret;
>  }
>
> -static struct cxl_memdev *to_cxl_memdev(struct device *dev)
> -{
> -       return container_of(dev, struct cxl_memdev, dev);
> -}
> -
>  static void cxl_memdev_release(struct device *dev)
>  {
>         struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> --
> 2.32.0
>
