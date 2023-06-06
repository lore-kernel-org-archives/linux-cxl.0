Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2FEC7EE29
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Jun 2023 15:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbjFFPXa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Jun 2023 11:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237833AbjFFPX2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Jun 2023 11:23:28 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF54EE67
        for <linux-cxl@vger.kernel.org>; Tue,  6 Jun 2023 08:23:26 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QbDhM0kgfz67bbM;
        Tue,  6 Jun 2023 23:21:07 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 16:23:24 +0100
Date:   Tue, 6 Jun 2023 16:23:23 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <navneet.singh@intel.com>
Subject: Re: [PATCH 17/19] cxl/region: Define a driver interface for HPA
 free space enumeration
Message-ID: <20230606162323.00005884@Huawei.com>
In-Reply-To: <168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
        <168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, 04 Jun 2023 16:33:12 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> CXL region creation involves allocating capacity from device DPA
> (device-physical-address space) and assigning it to decode a given HPA
> (host-physical-address space). Before determininig how much DPA to
> allocate the amount of available HPA must be determined. Also, not all
> HPA is created equal, some specifically targets RAM, some target PMEM,
> some is prepared for the device-memory flows like HDM-D and HDM-DB, and
> some is host-only (HDM-H).
> 
> Wrap all of those concerns into an API that retrieves a root decoder
> (platform CXL window) that fits the specified constraints and the
> capacity available for a new region.

Interaction with QTG?  I'd guess we should be prioritizing CFMWS based
on that if available.  Fun question of how to balance suggested QTG vs
available HPA space.


Otherwise, one suggestion inline.

Jonathan

> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/region.c |  143 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |    5 ++
>  drivers/cxl/cxlmem.h      |    5 ++
>  3 files changed, 153 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 75c5de627868..a41756249f8d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -575,6 +575,149 @@ static int free_hpa(struct cxl_region *cxlr)
>  	return 0;
>  }
>  
> +struct cxlrd_max_context {
> +	struct device * const *host_bridges;
> +	int interleave_ways;
> +	unsigned long flags;
> +	resource_size_t max_hpa;
> +	struct cxl_root_decoder *cxlrd;
> +};
> +
> +static int find_max_hpa(struct device *dev, void *data)
> +{
> +	struct cxlrd_max_context *ctx = data;
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_root_decoder *cxlrd;
> +	struct resource *res, *prev;
> +	struct cxl_decoder *cxld;
> +	resource_size_t max;
> +	unsigned int seq;
> +	int found;
> +
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	cxlrd = to_cxl_root_decoder(dev);
> +	cxld = &cxlrd->cxlsd.cxld;
> +	if ((cxld->flags & ctx->flags) != ctx->flags)
> +		return 0;
> +
> +	if (cxld->interleave_ways != ctx->interleave_ways)
> +		return 0;
> +
> +	cxlsd = &cxlrd->cxlsd;
> +	do {
> +		found = 0;
> +		seq = read_seqbegin(&cxlsd->target_lock);
> +		for (int i = 0; i < ctx->interleave_ways; i++)
> +			for (int j = 0; j < ctx->interleave_ways; j++)
> +				if (ctx->host_bridges[i] ==
> +				    cxlsd->target[j]->dport) {
> +					found++;
> +					break;
> +				}
> +	} while (read_seqretry(&cxlsd->target_lock, seq));
> +
> +	if (found != ctx->interleave_ways)
> +		return 0;
> +
> +	/*
> +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
> +	 * preclude sibling arrival/departure and find the largest free space
> +	 * gap.
> +	 */
> +	lockdep_assert_held_read(&cxl_region_rwsem);
> +	max = 0;
> +	res = cxlrd->res->child;
> +	if (!res)
> +		max = resource_size(cxlrd->res);

		Maybe jump from here to after the loop would be clearer
		or factor the loop out as a utility function to find the
		max gap which feels like it might be generally useful to
		have?

> +	else
> +		max = 0;
> +	for (prev = NULL; res; prev = res, res = res->sibling) {
> +		struct resource *next = res->sibling;
> +		resource_size_t free = 0;
> +
> +		if (!prev && res->start > cxlrd->res->start) {
> +			free = res->start - cxlrd->res->start;
> +			max = max(free, max);
> +		}
> +		if (prev && res->start > prev->end + 1) {
> +			free = res->start - prev->end + 1;
> +			max = max(free, max);
> +		}
> +		if (next && res->end + 1 < next->start) {
> +			free = next->start - res->end + 1;
> +			max = max(free, max);
> +		}
> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
> +			free = cxlrd->res->end + 1 - res->end + 1;
> +			max = max(free, max);
> +		}
> +	}
> +
> +	if (max > ctx->max_hpa) {
> +		if (ctx->cxlrd)
> +			put_device(cxlrd_dev(ctx->cxlrd));
> +		get_device(cxlrd_dev(cxlrd));
> +		ctx->cxlrd = cxlrd;
> +		ctx->max_hpa = max;
> +		dev_dbg(cxlrd_dev(cxlrd), "found %pa bytes of free space\n", &max);
> +	}
> +
> +	return 0;
> +}
> +

