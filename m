Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2919C7EE25
	for <linux-cxl@archiver.kernel.org>; Mon, 15 May 2023 10:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240574AbjEOKJJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 May 2023 06:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241027AbjEOKI5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 May 2023 06:08:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C5B2684
        for <linux-cxl@vger.kernel.org>; Mon, 15 May 2023 03:08:55 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QKZlm1cprz681Y1;
        Mon, 15 May 2023 18:06:44 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 11:08:29 +0100
Date:   Mon, 15 May 2023 11:08:28 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/pci: Allocate irq vectors earlier in pci probe
Message-ID: <20230515110828.00007f65@Huawei.com>
In-Reply-To: <20230502171841.21317-3-dave@stgolabs.net>
References: <20230502171841.21317-1-dave@stgolabs.net>
        <20230502171841.21317-3-dave@stgolabs.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue,  2 May 2023 10:18:40 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Move the cxl_alloc_irq_vectors() call further up in the probing
> in order to allow for mailbox interrupt usage. No change in
> semantics.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Chasing this patch through various places it appeared :)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/pci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index f7a5b8e9c102..8bdf58c0c643 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -708,6 +708,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>  
> +	rc = cxl_alloc_irq_vectors(pdev);
> +	if (rc)
> +		return rc;
> +
>  	rc = cxl_pci_setup_mailbox(cxlds);
>  	if (rc)
>  		return rc;
> @@ -732,10 +736,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_alloc_irq_vectors(pdev);
> -	if (rc)
> -		return rc;
> -
>  	cxlmd = devm_cxl_add_memdev(cxlds);
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);

