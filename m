Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7A1C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 16:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239970AbiERQNO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 May 2022 12:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239985AbiERQNN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 May 2022 12:13:13 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EFC1E0139
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 09:13:09 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L3Hy43hwFz6H775;
        Thu, 19 May 2022 00:10:04 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 18:13:07 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 17:13:06 +0100
Date:   Wed, 18 May 2022 17:13:05 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ben.widawsky@intel.com>,
        <ira.weiny@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>
Subject: Re: [PATCH 05/14] cxl/mem: Validate port connectivity before dvsec
 ranges
Message-ID: <20220518171305.000033c4@Huawei.com>
In-Reply-To: <165237928334.3832067.16326444799383620141.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
        <165237928334.3832067.16326444799383620141.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 12 May 2022 11:14:43 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for validating DVSEC ranges against the platform declared
> CXL memory ranges (ACPI CFMWS) move port enumeration before the
> endpoint's decoder validation. Ultimately this logic will move to the
> port driver, but create a bisect point before that larger move.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/mem.c |   36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index fed7f10ef9b2..80e75a410499 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -140,22 +140,6 @@ static int cxl_mem_probe(struct device *dev)
>  	if (work_pending(&cxlmd->detach_work))
>  		return -EBUSY;
>  
> -	rc = cxlds->wait_media_ready(cxlds);
> -	if (rc) {
> -		dev_err(dev, "Media not active (%d)\n", rc);
> -		return rc;
> -	}
> -
> -	/*
> -	 * If DVSEC ranges are being used instead of HDM decoder registers there
> -	 * is no use in trying to manage those.
> -	 */
> -	if (!cxl_hdm_decode_init(cxlds)) {
> -		dev_err(dev,
> -			"Legacy range registers configuration prevents HDM operation.\n");
> -		return -EBUSY;
> -	}
> -
>  	rc = devm_cxl_enumerate_ports(cxlmd);
>  	if (rc)
>  		return rc;
> @@ -171,16 +155,32 @@ static int cxl_mem_probe(struct device *dev)
>  		dev_err(dev, "CXL port topology %s not enabled\n",
>  			dev_name(&parent_port->dev));
>  		rc = -ENXIO;
> -		goto out;
> +		goto unlock;
>  	}
>  
>  	rc = create_endpoint(cxlmd, parent_port);
> -out:
> +unlock:

Trivial but I think this rename of the label would be better in the earlier
patch where you first added the if (rc) below.
I suppose it is arguable that the previous patch is a fix so should be minimal
though so I'm not that bothered if you leave it here.


>  	device_unlock(&parent_port->dev);
>  	put_device(&parent_port->dev);
>  	if (rc)
>  		return rc;
>  
> +	rc = cxlds->wait_media_ready(cxlds);
> +	if (rc) {
> +		dev_err(dev, "Media not active (%d)\n", rc);
> +		return rc;
> +	}
> +
> +	/*
> +	 * If DVSEC ranges are being used instead of HDM decoder registers there
> +	 * is no use in trying to manage those.
> +	 */
> +	if (!cxl_hdm_decode_init(cxlds)) {
> +		dev_err(dev,
> +			"Legacy range registers configuration prevents HDM operation.\n");
> +		return -EBUSY;
> +	}
> +
>  	/*
>  	 * The kernel may be operating out of CXL memory on this device,
>  	 * there is no spec defined way to determine whether this device
> 

