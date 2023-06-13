Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE25C7EE29
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Jun 2023 12:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbjFMMtT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Jun 2023 08:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242367AbjFMMtT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Jun 2023 08:49:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2341985
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jun 2023 05:49:15 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QgSx66g4Yz6GDCx;
        Tue, 13 Jun 2023 20:46:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 13:49:09 +0100
Date:   Tue, 13 Jun 2023 13:49:08 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <vishal.l.verma@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/7] cxl/mbox: Allow for IRQ_NONE case in the isr
Message-ID: <20230613134908.00002bee@Huawei.com>
In-Reply-To: <20230612181038.14421-2-dave@stgolabs.net>
References: <20230612181038.14421-1-dave@stgolabs.net>
        <20230612181038.14421-2-dave@stgolabs.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 12 Jun 2023 11:10:32 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> For cases when the mailbox background operation is not complete,
> do not "handle" the interrupt, as it was not from this device.
> And furthermore there are no racy scenarios such as the hw being
> out of sync with the driver and starting a new background op
> behind its back.
> 
> Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Fixes: ccadf1310fb (cxl/mbox: Add background cmd handling machinery)

Fixes is a bit strong for something that shouldn't be seen anyway.

> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Otherwise LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/pci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index a78e40e6d0e0..4b2575502f49 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -118,9 +118,11 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>  	struct cxl_dev_id *dev_id = id;
>  	struct cxl_dev_state *cxlds = dev_id->cxlds;
>  
> +	if (!cxl_mbox_background_complete(cxlds))
> +		return IRQ_NONE;
> +
>  	/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
> -	if (cxl_mbox_background_complete(cxlds))
> -		rcuwait_wake_up(&cxlds->mbox_wait);
> +	rcuwait_wake_up(&cxlds->mbox_wait);
>  
>  	return IRQ_HANDLED;
>  }

