Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A727C433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Nov 2022 16:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiK3Q1m (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Nov 2022 11:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiK3Q1m (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Nov 2022 11:27:42 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFDD10D2
        for <linux-cxl@vger.kernel.org>; Wed, 30 Nov 2022 08:27:39 -0800 (PST)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NMl0K3dXSz6HJGs;
        Thu,  1 Dec 2022 00:24:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 17:27:37 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 16:27:37 +0000
Date:   Wed, 30 Nov 2022 16:27:36 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/4] cxl/region: Add a DPA to HPA translation helper
Message-ID: <20221130162736.0000333f@Huawei.com>
In-Reply-To: <31c38d6711cc3a000a5307b8ebf3b6e88675e17f.1669153711.git.alison.schofield@intel.com>
References: <cover.1669153711.git.alison.schofield@intel.com>
        <31c38d6711cc3a000a5307b8ebf3b6e88675e17f.1669153711.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 22 Nov 2022 15:07:48 -0800
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> CXL devices may report errors and events using their DPA (device
> physical address). When a CXL device contributes capacity to a
> CXL region, the device's physical addresses are mapped to HPA's.
> (host physical addresses)
> 
> Provide a helper to calculate the HPA when given a DPA, a region,
> and the devices position in the region interleave.

device's 

> 
> Verify that the HPA is within the expected ranges that this device
> contributes to the region interleave set.
> 
> The initial use case is translating the DPAs that CXL devices
> report in media error records.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

I'm not following the maths for the 3/6/12 way interleave cases.

> ---
>  drivers/cxl/core/core.h   |  3 ++
>  drivers/cxl/core/region.c | 80 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 83 insertions(+)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 1d8f87be283f..72b58e53c394 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -67,6 +67,9 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>  	return xa_load(&port->endpoints, (unsigned long)&cxlmd->dev);
>  }
>  
> +u64 cxl_dpa_to_hpa(u64 dpa, struct cxl_region *cxlr,
> +		   struct cxl_endpoint_decoder *cxled);
> +
>  int cxl_memdev_init(void);
>  void cxl_memdev_exit(void);
>  void cxl_mbox_init(void);
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f9ae5ad284ff..c847517e766c 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1865,6 +1865,86 @@ static void cxlr_pmem_unregister(void *dev)
>  	device_unregister(dev);
>  }
>  
> +static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	int gran = p->interleave_granularity;
> +	int ways = p->interleave_ways;
> +	u64 stride;
> +
> +	/* Is the hpa within this region at all */
> +	if (hpa < p->res->start || hpa > p->res->end) {
> +		dev_dbg(&cxlr->dev,
> +			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
> +		return false;
> +	}
> +	/* Is the hpa in an expected stride for its pos(-ition) */
> +	stride = p->res->start + pos * gran;
> +	do {
> +		if (hpa >= stride && hpa <= stride + gran - 1)
	< stride + gran seems simpler.

> +			return true;
> +
> +		stride = stride + ways * gran;
> +	} while (stride < p->res->end);

That's going to take a 'while' with a large region.  Can we do something quicker
along the lines of...

Something like (untested)
	u64 offset = hpa - p->res_start;

	/* Offset within the right 'stride' */
	offset = offset % (gran * ways);

	if (offset >= pos * gran && offset < (pos + 1) * gran)
		return true;

..
> +
> +	dev_dbg(&cxlr->dev,
> +		"Addr trans fail: hpa 0x%llx not in any stride\n", hpa);
> +
> +	return false;
> +}
> +
> +u64 cxl_dpa_to_hpa(u64 dpa, struct cxl_region *cxlr,
> +		   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	u64 dpa_offset, hpa_offset, hpa;
> +	int rc, pos = cxled->pos;
> +	u16 eig;
> +	u8 eiw;
> +
> +	rc = ways_to_cxl(p->interleave_ways, &eiw);
I lost track a bit, but I think we ended up with einw?
> +	if (rc)
> +		return rc;
> +	rc = granularity_to_cxl(p->interleave_granularity, &eig);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Reverse the HPA->DPA decode logic defined
> +	 * in the CXL Spec 3.0 Section 8.2.4.19.13
> +	 * Implementation Note: Device Decode Logic
Short line wrap. Probably want to go nearer 80 chars

> +	 *
> +	 * The device position in the region interleave
> +	 * set was removed in the HPA->DPA translation.
> +	 * Put it back to reconstruct the HPA.
> +	 */
> +
> +	/* Remove the dpa base */
> +	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
> +
> +	/* Restore the position */
> +	if (eiw <= 8) {

This looks to be the power of 2 version, so should that be eiw < 8?

> +		hpa_offset = (dpa_offset & GENMASK_ULL(51, eig + 8)) << eiw;
> +		hpa_offset |= GENMASK_ULL(eig + 8 + eiw, eig + 8)
> +			      & (pos << (eig + 8));

Why is the masking needed here?  I think pos should always fit in the iw bits.

> +	}
> +	if (eiw == 9)

else if would show clearly that only one of these ifs is true.
 
> +		hpa_offset |= BIT(eig + eiw) & (pos & 0x01);

I don't follow this logic. hpa_offset hasn't been set to anything before
this point + the right hand side of the above will always be 0 (I think...)


> +	if (eiw == 10)
else if
> +		hpa_offset |= GENMASK_ULL(eig + eiw, eig + 8) & (pos & 0x03);
> +
> +	/* The lower bits remain unchanged */
> +	hpa_offset |= dpa_offset & GENMASK_ULL(eig + 7, 0);
> +
> +	/* Apply the hpa_offset to region base address */
> +	hpa = hpa_offset + p->res->start;
> +
> +	if (!cxl_is_hpa_in_range(hpa, cxlr, cxled->pos))
> +		return 0;
> +
> +	return hpa;
> +}
> +
>  /**
>   * devm_cxl_add_pmem_region() - add a cxl_region-to-nd_region bridge
>   * @cxlr: parent CXL region for this pmem region bridge device

