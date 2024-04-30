Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5713179654
	for <linux-cxl@vger.kernel.org>; Tue, 30 Apr 2024 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494596; cv=none; b=Gg0EuI9cwRNLfT1ZULE4Ii6t+psLwcT2injT/9NMHx3Lt5zMN7OkW7ZD1QtjInFawVuLX1/uoQACgsfHtUSb72IECw5VyspJ8GIyX0g2wGgM9NC+V5tz8exJw1PjMdPBHq02ZUoMG7PrBagehrDcaDPNO0aSETXImObF9P0SzQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494596; c=relaxed/simple;
	bh=8/qgLdLKbG92WKaDaPh/DLpcOJoNuaTaGcxJ1AtD0Gc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E6LgD0gYGyOJx5LYeJUWW9HJKtgO+VJBnf15kXWsFg15gdQaRnhqDhWtPvtsEpzHXoABtJE00FzYvVVP9mwSQQnD3ak6BnNI5LXoyQwl8tt27F1EyvMTxapVwLPOon9TjWb9urzVhHnjcg4UVKasW81xT3aUsYSrj6MqG6OC3o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTQdT2Z3Rz6K8xC;
	Wed,  1 May 2024 00:29:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 867B2140CF4;
	Wed,  1 May 2024 00:29:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 30 Apr
 2024 17:29:50 +0100
Date: Tue, 30 Apr 2024 17:29:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, Shiyang Ruan <ruansy.fnst@fujitsu.com>
Subject: Re: [PATCH v5 3/4] cxl/region: Move cxl_trace_hpa() work to the
 region driver
Message-ID: <20240430172949.00007228@Huawei.com>
In-Reply-To: <5d3bd29c90c8081d6f773cd5a71a744e884cea79.1714435815.git.alison.schofield@intel.com>
References: <cover.1714435815.git.alison.schofield@intel.com>
	<5d3bd29c90c8081d6f773cd5a71a744e884cea79.1714435815.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 29 Apr 2024 17:34:23 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> This work belongs in the region driver as it is only useful with
> CONFIG_CXL_REGION. Add a stub in core.h for when the region driver
> is not built.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 

No blank lines in a tag block.  Linux next bot will complain and
it can mess up some parsing tools.

> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/core.h   |  7 +++
>  drivers/cxl/core/region.c | 91 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/trace.c  | 91 ---------------------------------------
>  drivers/cxl/core/trace.h  |  2 -
>  4 files changed, 98 insertions(+), 93 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 87008505f8a9..625394486459 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -28,8 +28,15 @@ int cxl_region_init(void);
>  void cxl_region_exit(void);
>  int cxl_get_poison_by_endpoint(struct cxl_port *port);
>  struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
> +u64 cxl_trace_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
> +		  u64 dpa);
>  
>  #else
> +static inline u64
> +cxl_trace_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd, u64 dpa)
> +{
> +	return ULLONG_MAX;
> +}
>  static inline
>  struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
>  {
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 4b227659e3f8..45eb9c560fd6 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2723,6 +2723,97 @@ struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
>  	return ctx.cxlr;
>  }
>  
> +static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	int gran = p->interleave_granularity;
> +	int ways = p->interleave_ways;
> +	u64 offset;
> +
> +	/* Is the hpa within this region at all */
> +	if (hpa < p->res->start || hpa > p->res->end) {
> +		dev_dbg(&cxlr->dev,
> +			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
> +		return false;
> +	}
> +
> +	/* Is the hpa in an expected chunk for its pos(-ition) */
> +	offset = hpa - p->res->start;
> +	offset = do_div(offset, gran * ways);
> +	if ((offset >= pos * gran) && (offset < (pos + 1) * gran))
> +		return true;
> +
> +	dev_dbg(&cxlr->dev,
> +		"Addr trans fail: hpa 0x%llx not in expected chunk\n", hpa);
> +
> +	return false;
> +}
> +
> +static u64 cxl_dpa_to_hpa(u64 dpa,  struct cxl_region *cxlr,
> +			  struct cxl_endpoint_decoder *cxled)
> +{
> +	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
> +	struct cxl_region_params *p = &cxlr->params;
> +	int pos = cxled->pos;
> +	u16 eig = 0;
> +	u8 eiw = 0;
> +
> +	ways_to_eiw(p->interleave_ways, &eiw);
> +	granularity_to_eig(p->interleave_granularity, &eig);
> +
> +	/*
> +	 * The device position in the region interleave set was removed
> +	 * from the offset at HPA->DPA translation. To reconstruct the
> +	 * HPA, place the 'pos' in the offset.
> +	 *
> +	 * The placement of 'pos' in the HPA is determined by interleave
> +	 * ways and granularity and is defined in the CXL Spec 3.0 Section
> +	 * 8.2.4.19.13 Implementation Note: Device Decode Logic
> +	 */
> +
> +	/* Remove the dpa base */
> +	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
> +
> +	mask_upper = GENMASK_ULL(51, eig + 8);
> +
> +	if (eiw < 8) {
> +		hpa_offset = (dpa_offset & mask_upper) << eiw;
> +		hpa_offset |= pos << (eig + 8);
> +	} else {
> +		bits_upper = (dpa_offset & mask_upper) >> (eig + 8);
> +		bits_upper = bits_upper * 3;
> +		hpa_offset = ((bits_upper << (eiw - 8)) + pos) << (eig + 8);
> +	}
> +
> +	/* The lower bits remain unchanged */
> +	hpa_offset |= dpa_offset & GENMASK_ULL(eig + 7, 0);
> +
> +	/* Apply the hpa_offset to the region base address */
> +	hpa = hpa_offset + p->res->start;
> +
> +	if (!cxl_is_hpa_in_range(hpa, cxlr, cxled->pos))
> +		return ULLONG_MAX;
> +
> +	return hpa;
> +}
> +
> +u64 cxl_trace_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
> +		  u64 dpa)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_endpoint_decoder *cxled = NULL;
> +
> +	for (int i = 0; i <  p->nr_targets; i++) {
> +		cxled = p->targets[i];
> +		if (cxlmd == cxled_to_memdev(cxled))
> +			break;
> +	}
> +	if (!cxled || cxlmd != cxled_to_memdev(cxled))
> +		return ULLONG_MAX;
> +
> +	return cxl_dpa_to_hpa(dpa, cxlr, cxled);
> +}
> +
>  static struct lock_class_key cxl_pmem_region_key;
>  
>  static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
> diff --git a/drivers/cxl/core/trace.c b/drivers/cxl/core/trace.c
> index d0403dc3c8ab..7f2a9dd0d0e3 100644
> --- a/drivers/cxl/core/trace.c
> +++ b/drivers/cxl/core/trace.c
> @@ -6,94 +6,3 @@
>  
>  #define CREATE_TRACE_POINTS
>  #include "trace.h"
> -
> -static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
> -{
> -	struct cxl_region_params *p = &cxlr->params;
> -	int gran = p->interleave_granularity;
> -	int ways = p->interleave_ways;
> -	u64 offset;
> -
> -	/* Is the hpa within this region at all */
> -	if (hpa < p->res->start || hpa > p->res->end) {
> -		dev_dbg(&cxlr->dev,
> -			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
> -		return false;
> -	}
> -
> -	/* Is the hpa in an expected chunk for its pos(-ition) */
> -	offset = hpa - p->res->start;
> -	offset = do_div(offset, gran * ways);
> -	if ((offset >= pos * gran) && (offset < (pos + 1) * gran))
> -		return true;
> -
> -	dev_dbg(&cxlr->dev,
> -		"Addr trans fail: hpa 0x%llx not in expected chunk\n", hpa);
> -
> -	return false;
> -}
> -
> -static u64 cxl_dpa_to_hpa(u64 dpa,  struct cxl_region *cxlr,
> -			  struct cxl_endpoint_decoder *cxled)
> -{
> -	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
> -	struct cxl_region_params *p = &cxlr->params;
> -	int pos = cxled->pos;
> -	u16 eig = 0;
> -	u8 eiw = 0;
> -
> -	ways_to_eiw(p->interleave_ways, &eiw);
> -	granularity_to_eig(p->interleave_granularity, &eig);
> -
> -	/*
> -	 * The device position in the region interleave set was removed
> -	 * from the offset at HPA->DPA translation. To reconstruct the
> -	 * HPA, place the 'pos' in the offset.
> -	 *
> -	 * The placement of 'pos' in the HPA is determined by interleave
> -	 * ways and granularity and is defined in the CXL Spec 3.0 Section
> -	 * 8.2.4.19.13 Implementation Note: Device Decode Logic
> -	 */
> -
> -	/* Remove the dpa base */
> -	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
> -
> -	mask_upper = GENMASK_ULL(51, eig + 8);
> -
> -	if (eiw < 8) {
> -		hpa_offset = (dpa_offset & mask_upper) << eiw;
> -		hpa_offset |= pos << (eig + 8);
> -	} else {
> -		bits_upper = (dpa_offset & mask_upper) >> (eig + 8);
> -		bits_upper = bits_upper * 3;
> -		hpa_offset = ((bits_upper << (eiw - 8)) + pos) << (eig + 8);
> -	}
> -
> -	/* The lower bits remain unchanged */
> -	hpa_offset |= dpa_offset & GENMASK_ULL(eig + 7, 0);
> -
> -	/* Apply the hpa_offset to the region base address */
> -	hpa = hpa_offset + p->res->start;
> -
> -	if (!cxl_is_hpa_in_range(hpa, cxlr, cxled->pos))
> -		return ULLONG_MAX;
> -
> -	return hpa;
> -}
> -
> -u64 cxl_trace_hpa(struct cxl_region *cxlr, struct cxl_memdev *cxlmd,
> -		  u64 dpa)
> -{
> -	struct cxl_region_params *p = &cxlr->params;
> -	struct cxl_endpoint_decoder *cxled = NULL;
> -
> -	for (int i = 0; i <  p->nr_targets; i++) {
> -		cxled = p->targets[i];
> -		if (cxlmd == cxled_to_memdev(cxled))
> -			break;
> -	}
> -	if (!cxled || cxlmd != cxled_to_memdev(cxled))
> -		return ULLONG_MAX;
> -
> -	return cxl_dpa_to_hpa(dpa, cxlr, cxled);
> -}
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 7c5cd069f10c..e303e618aa05 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -642,8 +642,6 @@ TRACE_EVENT(cxl_memory_module,
>  #define cxl_poison_overflow(flags, time)				\
>  	(flags & CXL_POISON_FLAG_OVERFLOW ? le64_to_cpu(time) : 0)
>  
> -u64 cxl_trace_hpa(struct cxl_region *cxlr, struct cxl_memdev *memdev, u64 dpa);
> -
>  TRACE_EVENT(cxl_poison,
>  
>  	TP_PROTO(struct cxl_memdev *cxlmd, struct cxl_region *cxlr,

