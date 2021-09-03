Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5995C433EF
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Sep 2021 16:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C47B60E77
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Sep 2021 16:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbhICQRw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Sep 2021 12:17:52 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3741 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhICQRv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Sep 2021 12:17:51 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H1NDP48YKz67NPF;
        Sat,  4 Sep 2021 00:15:01 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 3 Sep 2021 18:16:50 +0200
Received: from localhost (10.52.121.127) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.8; Fri, 3 Sep 2021
 17:16:49 +0100
Date:   Fri, 3 Sep 2021 17:16:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 11/13] cxl/core: Convert decoder range to resource
Message-ID: <20210903171650.00004ca6@Huawei.com>
In-Reply-To: <20210902195017.2516472-12-ben.widawsky@intel.com>
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
        <20210902195017.2516472-12-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.127]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 2 Sep 2021 12:50:15 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Regions will use the resource API in order to help manage allocated
> space. As regions are children of the decoder, it makes sense that the
> parent host the main resource to be suballocated by the region.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Seems sensible to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/acpi.c     | 12 ++++--------
>  drivers/cxl/core/bus.c |  4 ++--
>  drivers/cxl/cxl.h      |  4 ++--
>  3 files changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index fd14094bdb3f..26691313d716 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -125,10 +125,9 @@ static void cxl_add_cfmws_decoders(struct device *dev,
>  
>  		cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
>  		cxld->target_type = CXL_DECODER_EXPANDER;
> -		cxld->range = (struct range) {
> -			.start = cfmws->base_hpa,
> -			.end = cfmws->base_hpa + cfmws->window_size - 1,
> -		};
> +		cxld->res = (struct resource)DEFINE_RES_MEM_NAMED(cfmws->base_hpa,
> +								  cfmws->window_size,
> +								  "cfmws");
>  		cxld->interleave_ways = CFMWS_INTERLEAVE_WAYS(cfmws);
>  		cxld->interleave_granularity =
>  			CFMWS_INTERLEAVE_GRANULARITY(cfmws);
> @@ -318,10 +317,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  	cxld->interleave_ways = 1;
>  	cxld->interleave_granularity = PAGE_SIZE;
>  	cxld->target_type = CXL_DECODER_EXPANDER;
> -	cxld->range = (struct range) {
> -		.start = 0,
> -		.end = -1,
> -	};
> +	cxld->res = (struct resource)DEFINE_RES_MEM(0, 0);
>  
>  	device_lock(&port->dev);
>  	dport = list_first_entry(&port->dports, typeof(*dport), list);
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index 01b6fa8373e4..d056dbd794a4 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -48,7 +48,7 @@ static ssize_t start_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct cxl_decoder *cxld = to_cxl_decoder(dev);
>  
> -	return sysfs_emit(buf, "%#llx\n", cxld->range.start);
> +	return sysfs_emit(buf, "%#llx\n", cxld->res.start);
>  }
>  static DEVICE_ATTR_RO(start);
>  
> @@ -57,7 +57,7 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct cxl_decoder *cxld = to_cxl_decoder(dev);
>  
> -	return sysfs_emit(buf, "%#llx\n", range_len(&cxld->range));
> +	return sysfs_emit(buf, "%#llx\n", resource_size(&cxld->res));
>  }
>  static DEVICE_ATTR_RO(size);
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 4585d03a0a67..e610fa9dd6c8 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -192,7 +192,7 @@ enum cxl_decoder_type {
>   * struct cxl_decoder - CXL address range decode configuration
>   * @dev: this decoder's device
>   * @id: kernel device name id
> - * @range: address range considered by this decoder
> + * @res: address space resources considered by this decoder
>   * @interleave_ways: number of cxl_dports in this decode
>   * @interleave_granularity: data stride per dport
>   * @target_type: accelerator vs expander (type2 vs type3) selector
> @@ -203,7 +203,7 @@ enum cxl_decoder_type {
>  struct cxl_decoder {
>  	struct device dev;
>  	int id;
> -	struct range range;
> +	struct resource res;
>  	int interleave_ways;
>  	int interleave_granularity;
>  	enum cxl_decoder_type target_type;

