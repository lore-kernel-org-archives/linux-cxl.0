Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C748C48BDF
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 09:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1209661209
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 09:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbhFRJQT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Jun 2021 05:16:19 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3268 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFRJQS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Jun 2021 05:16:18 -0400
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G5tK171Nbz6M4bR;
        Fri, 18 Jun 2021 17:04:21 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 11:14:08 +0200
Received: from localhost (10.52.122.135) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 18 Jun
 2021 10:14:07 +0100
Date:   Fri, 18 Jun 2021 10:13:58 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 2/6] cxl: Move cxl_memdev conversion helper to mem.h
Message-ID: <20210618101358.00004cdd@Huawei.com>
In-Reply-To: <20210617173655.430424-3-ben.widawsky@intel.com>
References: <20210617173655.430424-1-ben.widawsky@intel.com>
        <20210617173655.430424-3-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.122.135]
X-ClientProxiedBy: lhreml722-chm.china.huawei.com (10.201.108.73) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 17 Jun 2021 10:36:51 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Hard to argue with this one ;)  So I don't bother reading it again...

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

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
>  	int id;
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
>  	return ret;
>  }
>  
> -static struct cxl_memdev *to_cxl_memdev(struct device *dev)
> -{
> -	return container_of(dev, struct cxl_memdev, dev);
> -}
> -
>  static void cxl_memdev_release(struct device *dev)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);

