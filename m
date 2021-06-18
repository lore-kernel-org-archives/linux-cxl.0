Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDC2C49361
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 11:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C976613F7
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 11:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbhFRLyg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Jun 2021 07:54:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3278 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbhFRLyf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Jun 2021 07:54:35 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G5xth6xFDz6G7d3;
        Fri, 18 Jun 2021 19:45:16 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 13:52:25 +0200
Received: from localhost (10.52.125.28) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 18 Jun
 2021 12:52:24 +0100
Date:   Fri, 18 Jun 2021 12:52:15 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 5/6] cxl/core: Convert decoder range to resource
Message-ID: <20210618125215.00000cd9@Huawei.com>
In-Reply-To: <20210617173655.430424-6-ben.widawsky@intel.com>
References: <20210617173655.430424-1-ben.widawsky@intel.com>
        <20210617173655.430424-6-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.125.28]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 17 Jun 2021 10:36:54 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Regions will use the resource API in order to help manage allocated
> space. As regions are children of the decoder, it makes sense that the
> parent host the main resource to be suballocated by the region.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Seems reasonable.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core.c   | 9 +++------
>  drivers/cxl/cxl.h    | 4 ++--
>  drivers/cxl/region.c | 2 +-
>  3 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> index 44f982f4f247..0e598a18e95f 100644
> --- a/drivers/cxl/core.c
> +++ b/drivers/cxl/core.c
> @@ -40,7 +40,7 @@ static ssize_t start_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct cxl_decoder *cxld = to_cxl_decoder(dev);
>  
> -	return sysfs_emit(buf, "%#llx\n", cxld->range.start);
> +	return sysfs_emit(buf, "%#llx\n", cxld->res.start);
>  }
>  static DEVICE_ATTR_RO(start);
>  
> @@ -49,7 +49,7 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct cxl_decoder *cxld = to_cxl_decoder(dev);
>  
> -	return sysfs_emit(buf, "%#llx\n", range_len(&cxld->range));
> +	return sysfs_emit(buf, "%#llx\n", resource_size(&cxld->res));
>  }
>  static DEVICE_ATTR_RO(size);
>  
> @@ -543,10 +543,7 @@ cxl_decoder_alloc(struct cxl_port *port, int nr_targets, resource_size_t base,
>  
>  	*cxld = (struct cxl_decoder) {
>  		.id = rc,
> -		.range = {
> -			.start = base,
> -			.end = base + len - 1,
> -		},
> +		.res = DEFINE_RES_MEM_NAMED(base, len, "cxl-decoder"),
>  		.flags = flags,
>  		.interleave_ways = interleave_ways,
>  		.interleave_granularity = interleave_granularity,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 90107b21125b..b08f0969abeb 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -185,7 +185,7 @@ enum cxl_decoder_type {
>   * struct cxl_decoder - CXL address range decode configuration
>   * @dev: this decoder's device
>   * @id: kernel device name id
> - * @range: address range considered by this decoder
> + * @res: address space resources considered by this decoder
>   * @interleave_ways: number of cxl_dports in this decode
>   * @interleave_granularity: data stride per dport
>   * @target_type: accelerator vs expander (type2 vs type3) selector
> @@ -198,7 +198,7 @@ enum cxl_decoder_type {
>  struct cxl_decoder {
>  	struct device dev;
>  	int id;
> -	struct range range;
> +	struct resource res;
>  	int interleave_ways;
>  	int interleave_granularity;
>  	enum cxl_decoder_type target_type;
> diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
> index 616b47903d69..62bca8b30349 100644
> --- a/drivers/cxl/region.c
> +++ b/drivers/cxl/region.c
> @@ -59,7 +59,7 @@ static ssize_t offset_show(struct device *dev, struct device_attribute *attr,
>  	if (!region->res)
>  		return sysfs_emit(buf, "\n");
>  
> -	return sysfs_emit(buf, "%#llx\n", cxld->range.start - region->res->start);
> +	return sysfs_emit(buf, "%#llx\n", cxld->res.start - region->res->start);
>  }
>  static DEVICE_ATTR_RO(offset);
>  

