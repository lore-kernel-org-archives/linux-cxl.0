Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A50E545;
	Mon, 23 Jun 2025 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750675781; cv=none; b=Bs1xdBYSSWPa74Po4NcaYz82t+/BTNBq4bkT1bYn5/8nVMHGcSUweDyAIq5Hb6p24MNjsAIiJ9Ry0CdmzCThS6iDngzIC66QCUvGR1w+OxWB0w6nBB8NPn8yosF2Jdg39/2KOS8IMYHjjhRFKxYHc7cGW8++wdTQZRhgZKYomC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750675781; c=relaxed/simple;
	bh=AZRutw88DuZTrejh5XxOoE2t5eBJ1xS3sHjCHKFTtlI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JosI5hJXWT71DNt0tbkxeA234DFcqmGPG5rLCc40O1KAaUmyeNkCbMnlVEEw+6fS6xGyqvPh5QHedSskmDzIn9mN/NfWLr7x3N0XboYER5pe8yKoYbIh/0AnRyFCyj8ci//YzwdHbN+oa0227g8rG9rNF3wQB/QxNLME1bziK1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bQlC04nWGz6HJsY;
	Mon, 23 Jun 2025 18:47:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7BF171402F6;
	Mon, 23 Jun 2025 18:49:35 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Jun
 2025 12:49:35 +0200
Date: Mon, 23 Jun 2025 11:49:33 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Davidlohr
 Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, "Ira Weiny" <ira.weiny@intel.com>
Subject: Re: [PATCH v2 7/8] cxl/region: Introduce
 CLASS(cxl_decoder_detach...) consolidate multiple paths
Message-ID: <20250623114933.00001ba4@huawei.com>
In-Reply-To: <20250619050416.782871-8-dan.j.williams@intel.com>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
	<20250619050416.782871-8-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 18 Jun 2025 22:04:15 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Both detach_target() and cxld_unregister() want to tear down a cxl_region
> when an endpoint decoder is either detached or destroyed.
> 
> When a region is to be destroyed cxl_decoder_detach() releases
> cxl_region_rwsem unbinds the cxl_region driver and re-acquires the rwsem.
> 
> This "reverse" locking pattern is difficult to reason about, not amenable
> to scope-based cleanup, and the minor differences in the calling convention
> of cxl_decoder_detach() currently results in the cxl_decoder_kill_region()
> wrapper.
> 
> Introduce CLASS(cxl_decoder_detach...) which creates an object that moves
> the post-detach cleanup work to a destructor, and consolidates minor
> preamble differences in the constructor.

I'm struggling somewhat with grasping how the destructor pattern is useful
here. In the two cases the scope is tightly defined around the
declaration of the class instance. Doesn't that just boil down to
automatically calling the destuctor function immediately?  If so what
is the use of wrapping it up in a destructor?

> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/core.h   | 43 ++++++++++++++++++-
>  drivers/cxl/core/port.c   |  6 +--
>  drivers/cxl/core/region.c | 88 ++++++++++++++++++---------------------
>  3 files changed, 83 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 29b61828a847..8a65777ef3d3 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -12,6 +12,11 @@ extern const struct device_type cxl_pmu_type;
>  
>  extern struct attribute_group cxl_base_attribute_group;
>  
> +enum cxl_detach_mode {
> +	DETACH_ONLY,
> +	DETACH_INVALIDATE,
> +};
> +
>  #ifdef CONFIG_CXL_REGION
>  extern struct device_attribute dev_attr_create_pmem_region;
>  extern struct device_attribute dev_attr_create_ram_region;
> @@ -20,7 +25,11 @@ extern struct device_attribute dev_attr_region;
>  extern const struct device_type cxl_pmem_region_type;
>  extern const struct device_type cxl_dax_region_type;
>  extern const struct device_type cxl_region_type;
> -void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
> +
> +struct cxl_region *cxl_decoder_detach(struct cxl_region *cxlr,
> +				      struct cxl_endpoint_decoder *cxled,
> +				      int pos, enum cxl_detach_mode mode);
> +
>  #define CXL_REGION_ATTR(x) (&dev_attr_##x.attr)
>  #define CXL_REGION_TYPE(x) (&cxl_region_type)
>  #define SET_CXL_REGION_ATTR(x) (&dev_attr_##x.attr),
> @@ -48,7 +57,9 @@ static inline int cxl_get_poison_by_endpoint(struct cxl_port *port)
>  {
>  	return 0;
>  }
> -static inline void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
> +static inline struct cxl_region *
> +cxl_decoder_detach(struct cxl_region *cxlr, struct cxl_endpoint_decoder *cxled,
> +		   int pos, enum cxl_detach_mode mode)
>  {
>  }
>  static inline int cxl_region_init(void)
> @@ -99,6 +110,34 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
>  extern struct rw_semaphore cxl_dpa_rwsem;
>  extern struct rw_semaphore cxl_region_rwsem;
>  
> +DEFINE_CLASS(
> +	cxl_decoder_detach, struct cxl_region *,
> +	if (!IS_ERR_OR_NULL(_T)) {
> +		device_release_driver(&_T->dev);
> +		put_device(&_T->dev);
> +	},
> +	({
> +		int rc = 0;
> +
> +		/* when the decoder is being destroyed lock unconditionally */
> +		if (mode == DETACH_INVALIDATE)
> +			down_write(&cxl_region_rwsem);
> +		else
> +			rc = down_write_killable(&cxl_region_rwsem);
> +
> +		if (rc)
> +			cxlr = ERR_PTR(rc);
> +		else {
> +			cxlr = cxl_decoder_detach(cxlr, cxled, pos, mode);
> +			get_device(&cxlr->dev);
> +		}
> +		up_write(&cxl_region_rwsem);
> +
> +		cxlr;
> +	}),
> +	struct cxl_region *cxlr, struct cxl_endpoint_decoder *cxled, int pos,
> +	enum cxl_detach_mode mode)
> +
>  int cxl_memdev_init(void);
>  void cxl_memdev_exit(void);
>  void cxl_mbox_init(void);
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index eb46c6764d20..0f1629856380 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2001,11 +2001,9 @@ EXPORT_SYMBOL_NS_GPL(cxl_decoder_add, "CXL");
>  
>  static void cxld_unregister(void *dev)
>  {
> -	struct cxl_endpoint_decoder *cxled;
> -
>  	if (is_endpoint_decoder(dev)) {
> -		cxled = to_cxl_endpoint_decoder(dev);
> -		cxl_decoder_kill_region(cxled);
> +		CLASS(cxl_decoder_detach, cxlr)
> +		(NULL, to_cxl_endpoint_decoder(dev), -1, DETACH_INVALIDATE);
>  	}
>  
>  	device_unregister(dev);
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 2a97fa9a394f..010964aa5489 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2135,27 +2135,52 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	return 0;
>  }
>  
> -static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
> +/*
> + * Cleanup a decoder's interest in a region. There are 2 cases to
> + * handle, removing an unknown @cxled from a known position in a region
> + * (detach_target()) or removing a known @cxled from an unknown @cxlr
> + * (cxld_unregister())
> + *
> + * When the detachment finds a region, the caller is responsible for
> + * releasing the region driver.
> + */
> +struct cxl_region *cxl_decoder_detach(struct cxl_region *cxlr,
> +				      struct cxl_endpoint_decoder *cxled,
> +				      int pos, enum cxl_detach_mode mode)
>  {
> -	struct cxl_port *iter, *ep_port = cxled_to_port(cxled);
> -	struct cxl_region *cxlr = cxled->cxld.region;
>  	struct cxl_region_params *p;
> -	int rc = 0;
>  
>  	lockdep_assert_held_write(&cxl_region_rwsem);
>  
> -	if (!cxlr)
> -		return 0;
> +	if (!cxled) {
> +		p = &cxlr->params;
>  
> -	p = &cxlr->params;
> -	get_device(&cxlr->dev);
> +		if (pos >= p->interleave_ways) {
> +			dev_dbg(&cxlr->dev, "position %d out of range %d\n",
> +				pos, p->interleave_ways);
> +			return ERR_PTR(-ENXIO);
> +		}
> +
> +		if (!p->targets[pos])
> +			return NULL;
> +		cxled = p->targets[pos];
> +	} else {
> +		cxlr = cxled->cxld.region;
> +		if (!cxlr)
> +			return NULL;
> +		p = &cxlr->params;
> +	}
> +
> +
> +	if (mode == DETACH_INVALIDATE)
> +		cxled->part = -1;
>  
>  	if (p->state > CXL_CONFIG_ACTIVE) {
>  		cxl_region_decode_reset(cxlr, p->interleave_ways);
>  		p->state = CXL_CONFIG_ACTIVE;
>  	}
>  
> -	for (iter = ep_port; !is_cxl_root(iter);
> +	for (struct cxl_port *iter = cxled_to_port(cxled); !is_cxl_root(iter);
>  	     iter = to_cxl_port(iter->dev.parent))
>  		cxl_port_detach_region(iter, cxlr, cxled);
>  
> @@ -2166,7 +2191,7 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
>  		dev_WARN_ONCE(&cxlr->dev, 1, "expected %s:%s at position %d\n",
>  			      dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>  			      cxled->pos);
> -		goto out;
> +		return NULL;
>  	}
>  
>  	if (p->state == CXL_CONFIG_ACTIVE) {
> @@ -2180,21 +2205,7 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
>  		.end = -1,
>  	};
>  
> -	/* notify the region driver that one of its targets has departed */
> -	up_write(&cxl_region_rwsem);
> -	device_release_driver(&cxlr->dev);
> -	down_write(&cxl_region_rwsem);
> -out:
> -	put_device(&cxlr->dev);
> -	return rc;
> -}
> -
> -void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
> -{
> -	down_write(&cxl_region_rwsem);
> -	cxled->part = -1;
> -	cxl_region_detach(cxled);
> -	up_write(&cxl_region_rwsem);
> +	return cxlr;
>  }
>  
>  static int attach_target(struct cxl_region *cxlr,
> @@ -2225,29 +2236,10 @@ static int attach_target(struct cxl_region *cxlr,
>  
>  static int detach_target(struct cxl_region *cxlr, int pos)
>  {
> -	struct cxl_region_params *p = &cxlr->params;
> -	int rc;
> -
> -	rc = down_write_killable(&cxl_region_rwsem);
> -	if (rc)
> -		return rc;
> -
> -	if (pos >= p->interleave_ways) {
> -		dev_dbg(&cxlr->dev, "position %d out of range %d\n", pos,
> -			p->interleave_ways);
> -		rc = -ENXIO;
> -		goto out;
> -	}
> -
> -	if (!p->targets[pos]) {
> -		rc = 0;
> -		goto out;
> -	}
> -
> -	rc = cxl_region_detach(p->targets[pos]);
> -out:
> -	up_write(&cxl_region_rwsem);
> -	return rc;
> +	CLASS(cxl_decoder_detach, ret)(cxlr, NULL, pos, DETACH_ONLY);
> +	if (IS_ERR(ret))
> +		return PTR_ERR(ret);
> +	return 0;
>  }
>  
>  static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,

