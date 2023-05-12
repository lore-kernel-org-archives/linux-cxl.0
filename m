Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CC5C77B7C
	for <linux-cxl@archiver.kernel.org>; Fri, 12 May 2023 15:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241769AbjELPSj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 May 2023 11:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241772AbjELPSh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 May 2023 11:18:37 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA3A10DF
        for <linux-cxl@vger.kernel.org>; Fri, 12 May 2023 08:18:35 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHsn0049Kz67cL9;
        Fri, 12 May 2023 23:16:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 12 May
 2023 16:18:33 +0100
Date:   Fri, 12 May 2023 16:18:32 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v5 11/14] cxl: Move read_cdat_data() to after media is
 ready
Message-ID: <20230512161832.00005106@Huawei.com>
In-Reply-To: <168357887947.2756219.6022306227580486103.stgit@djiang5-mobl3>
References: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
        <168357887947.2756219.6022306227580486103.stgit@djiang5-mobl3>
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

On Mon, 08 May 2023 13:47:59 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> CDAT data is only valid after the media is ready. Move read_cdat_data() to
> after cxl_awai_media_read() is successful.
await

> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
No fixes tag? Plus move it to the top of the series with the other
two fixes.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/port.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 0bdb9d73a389..1d55c460e1ab 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -162,9 +162,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	if (IS_ERR(cxlhdm))
>  		return PTR_ERR(cxlhdm);
>  
> -	/* Cache the data early to ensure is_visible() works */
> -	read_cdat_data(port);
> -
>  	get_device(&cxlmd->dev);
>  	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
>  	if (rc)
> @@ -180,6 +177,9 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  		return rc;
>  	}
>  
> +	/* Cache the data early to ensure is_visible() works */
> +	read_cdat_data(port);
> +
>  	rc = cxl_dev_state_identify(cxlds);
>  	if (rc)
>  		return rc;
> 
> 

