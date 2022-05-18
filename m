Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D073C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 16:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240535AbiERQu6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 May 2022 12:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240540AbiERQu4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 May 2022 12:50:56 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7C02CE11
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 09:50:53 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L3Jmn15p7z6GD8f;
        Thu, 19 May 2022 00:47:05 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 18:50:51 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 17:50:50 +0100
Date:   Wed, 18 May 2022 17:50:49 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ben.widawsky@intel.com>,
        <ira.weiny@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>
Subject: Re: [PATCH 12/14] cxl/port: Move endpoint HDM Decoder Capability
 init to port driver
Message-ID: <20220518175049.0000276d@Huawei.com>
In-Reply-To: <165237932097.3832067.9953094210099463536.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
        <165237932097.3832067.9953094210099463536.stgit@dwillia2-desk3.amr.corp.intel.com>
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

On Thu, 12 May 2022 11:15:21 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> The responsibility for establishing HDM Decoder Capability based
> operation is more closely tied to port enabling than memdev enabling
> which is concerned with port enumeration. This later enables reusing
> @cxlhdm for probing / controlling "global enable" for the HDM Decoder
> Capability. For now, just do the nominal move.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/mem.c  |   11 -----------
>  drivers/cxl/port.c |   11 +++++++++++
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 8ce89d128e36..c310f1fd3db0 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -54,7 +54,6 @@ static void enable_suspend(void *data)
>  static int cxl_mem_probe(struct device *dev)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_port *parent_port;
>  	int rc;
>  
> @@ -94,16 +93,6 @@ static int cxl_mem_probe(struct device *dev)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_hdm_decode_init(cxlds);
> -	if (rc)
> -		return rc;
> -
> -	rc = cxl_await_media_ready(cxlds);
> -	if (rc) {
> -		dev_err(dev, "Media not active (%d)\n", rc);
> -		return rc;
> -	}
> -
>  	/*
>  	 * The kernel may be operating out of CXL memory on this device,
>  	 * there is no spec defined way to determine whether this device
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index d420da5fc39c..a7deaeaf0276 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -38,11 +38,22 @@ static int cxl_port_probe(struct device *dev)
>  
>  	if (is_cxl_endpoint(port)) {
>  		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
> +		struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  
>  		get_device(&cxlmd->dev);
>  		rc = devm_add_action_or_reset(dev, schedule_detach, cxlmd);
>  		if (rc)
>  			return rc;
> +
> +		rc = cxl_hdm_decode_init(cxlds);
> +		if (rc)
> +			return rc;
> +
> +		rc = cxl_await_media_ready(cxlds);
> +		if (rc) {
> +			dev_err(dev, "Media not active (%d)\n", rc);
> +			return rc;
> +		}
>  	} else {
>  		rc = devm_cxl_port_enumerate_dports(port);
>  		if (rc < 0)
> 

