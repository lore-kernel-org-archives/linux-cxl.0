Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42FBC77B7C
	for <linux-cxl@archiver.kernel.org>; Fri, 12 May 2023 15:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241746AbjELPRt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 May 2023 11:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241720AbjELPRq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 May 2023 11:17:46 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A4C173F
        for <linux-cxl@vger.kernel.org>; Fri, 12 May 2023 08:17:33 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHsmp5Ln2z67tG2;
        Fri, 12 May 2023 23:16:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 12 May
 2023 16:17:31 +0100
Date:   Fri, 12 May 2023 16:17:30 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v5 10/14] cxl: Move identify and partition query from
 pci probe to port probe
Message-ID: <20230512161730.00002bf1@Huawei.com>
In-Reply-To: <168357887373.2756219.10680050253858860934.stgit@djiang5-mobl3>
References: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
        <168357887373.2756219.10680050253858860934.stgit@djiang5-mobl3>
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

On Mon, 08 May 2023 13:47:53 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Move the enumeration of device capacity to cxl_port_probe() from
> cxl_pci_probe(). The size and capacity information should be read
> after cxl_await_media_ready() so the data is valid.
> 
> Fixes: 5e2411ae8071 ("cxl/memdev: Change cxl_mem to a more descriptive name")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Same comment about this should be at top of patch set, not buried down at patch 10.

Change seems fine
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/pci.c  |    8 --------
>  drivers/cxl/port.c |    8 ++++++++
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index ed39d133b70d..06324266eae8 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -707,14 +707,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_dev_state_identify(cxlds);
> -	if (rc)
> -		return rc;
> -
> -	rc = cxl_mem_create_range_info(cxlds);
> -	if (rc)
> -		return rc;
> -
>  	rc = cxl_alloc_irq_vectors(pdev);
>  	if (rc)
>  		return rc;
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index b474997cc7ee..0bdb9d73a389 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -180,6 +180,14 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  		return rc;
>  	}
>  
> +	rc = cxl_dev_state_identify(cxlds);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_mem_create_range_info(cxlds);
> +	if (rc)
> +		return rc;
> +
>  	rc = devm_cxl_enumerate_decoders(cxlhdm, &info);
>  	if (rc)
>  		return rc;
> 
> 

