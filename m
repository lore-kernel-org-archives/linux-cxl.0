Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A8AC48BDF
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 15:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56F5361164
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 15:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhFRPD5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Jun 2021 11:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhFRPD4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Jun 2021 11:03:56 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A341C061574
        for <linux-cxl@vger.kernel.org>; Fri, 18 Jun 2021 08:01:47 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id m15-20020a17090a5a4fb029016f385ffad0so3195101pji.0
        for <linux-cxl@vger.kernel.org>; Fri, 18 Jun 2021 08:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P3+E+viA5te6wc/REqeRBVvuJdFK5Cal4I3LHT6GUMM=;
        b=XsfekJHHHPd4HNY0nr3S3ZxFDsbcL68+YaK92a7dwGdGinrCpLZntlZxBOVb0irKU0
         XR9CTQJxH9IPydQWKpJ8BVAnKDSxMmRQnaOeesewixPPaa5ftCbjcGuCBbs0KnSX6HSs
         zJRMBBOTFYYpd/b+QTSI7TBO0oVEIUAE8CpGc8vw7949zu5fkU/5ArEBLDorpESoahDd
         FzsJPAWyJq/8wDWv4yvOUqIRuZPb0WMbeVeka0lREP6V0T0RhMEQ/f5me4Yprtv5GUds
         dyL2Mwo81DNN3adUfJU9wYnp1Y1I+BZ2OsPkdq7r7bOGWGNSihORR/XL7FsQXb3WLXe6
         8Jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P3+E+viA5te6wc/REqeRBVvuJdFK5Cal4I3LHT6GUMM=;
        b=cjq6cFOW9TWq6KNpmC8YicM0cDFdM4LZhTBkRag2ABg6bvcLexgmIlH40sg6PtseI2
         PvcWYoRi5GDDlgLjQb0mJuam1stEs6WAzkohRHRWnO0eVxPb9PZwU3p0EZR/H0iHFjOO
         oATJqrs0qtEDa71AlcjbMdReRKloPkSGPvn322Am1ElusJvgwhwX4xbPwdZAo9oMPbso
         wDAeIDhyluAbDAuItkvDG6hG9JnG3KkBDtu/m5nKV/hjRMUI1pvaKcN+EINWfemvW8yE
         uqChBVGq3enYJHrpjFB3QiT1du4Fv7FS8jgcjarY3zB9cwe2bWp+4FYlKfaLQHlhLyW6
         FtYw==
X-Gm-Message-State: AOAM533Edst6sj94BWzDff8FSjTM551FiJQ40JEYdrVdhUVAwpbsIY3Q
        1as0mxHs6wsiY/czBJikub8R9+aODyXZ63tCzSZDsw==
X-Google-Smtp-Source: ABdhPJzP/pT7ikYZe5U7vJVw4yotmhbnkfS6lEggfRVUGqEG71RvGI1L0Oivq/7yd6/f/bkMkxPrBpvYY+pNQIqSrSI=
X-Received: by 2002:a17:90a:8589:: with SMTP id m9mr22090241pjn.168.1624028506871;
 Fri, 18 Jun 2021 08:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210618005200.997804-1-ben.widawsky@intel.com> <20210618005200.997804-5-ben.widawsky@intel.com>
In-Reply-To: <20210618005200.997804-5-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 18 Jun 2021 08:00:00 -0700
Message-ID: <CAPcyv4gj+es+3pQne5beiKDX226VYOH=JXrz7T20XeH=AE3Onw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] cxl/pci: Export CXL DVSEC functionality
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

On Thu, Jun 17, 2021 at 5:52 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/pci.c | 2 +-
>  drivers/cxl/pci.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)

Fold this with the patch that needs it.

>
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index f9c0eaf3ff4e..b1a5a18dba92 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -973,7 +973,7 @@ static void cxl_mem_unmap_regblock(struct cxl_mem *cxlm, void __iomem *base)
>         pci_iounmap(cxlm->pdev, base);
>  }
>
> -static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> +int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
>  {
>         int pos;
>
> diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> index dad7a831f65f..0d6f50f725bc 100644
> --- a/drivers/cxl/pci.h
> +++ b/drivers/cxl/pci.h
> @@ -28,4 +28,6 @@
>
>  #define CXL_REGLOC_ADDR_MASK GENMASK(31, 16)
>
> +int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec);
> +
>  #endif /* __CXL_PCI_H__ */
> --
> 2.32.0
>
