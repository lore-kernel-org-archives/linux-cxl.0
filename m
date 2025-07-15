Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E5E1F30CC;
	Tue, 15 Jul 2025 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594977; cv=none; b=aBhcT6NMH8roMo3aATroux4zV9fpc1HCujrSFzd+1eh5c8wquIPc5g37zQvYWVNwA/f2EFtTMZQhQ3YOG3MfbvfLMwuM8SME3Zfss6bSstxEP/Xm1CkTDVpyc1uwIo7zo+U6M+BBhBVZCp5ii9kwteRiwXRHgmf5cJyrmrbcIK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594977; c=relaxed/simple;
	bh=LSC9fzMHwurl+Pf/1A3YvVM45khW2DBU4svSniV59hY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4AV28hpotf4kSLViXCPwHIpZB5VGEzfTOklkwwU9yu+hl9Uj3g80SysfU5YFHbyCYtawNnqfqrBFXSVPiqB8Z216qyNRrivG4LZOSfCxViu1+SVMLo7wJZkU2s3lzD9L7+RnYisUsQPMMLUWWDCJ9z/vZmELpXdDQEqXS1dl6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhNxM2Wwvz6L4w7;
	Tue, 15 Jul 2025 23:52:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 857061402ED;
	Tue, 15 Jul 2025 23:56:09 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Jul
 2025 17:56:08 +0200
Date: Tue, 15 Jul 2025 16:56:07 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Davidlohr
 Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Peter
 Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH v3 7/8] cxl/region: Consolidate
 cxl_decoder_kill_region() and cxl_region_detach()
Message-ID: <20250715165607.000036c4@huawei.com>
In-Reply-To: <20250711234932.671292-8-dan.j.williams@intel.com>
References: <20250711234932.671292-1-dan.j.williams@intel.com>
	<20250711234932.671292-8-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 11 Jul 2025 16:49:31 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Both detach_target() and cxld_unregister() want to tear down a cxl_region
> when an endpoint decoder is either detached or destroyed.
> 
> When a region is to be destroyed cxl_region_detach() releases
> cxl_region_rwsem unbinds the cxl_region driver and re-acquires the rwsem.
> 
> This "reverse" locking pattern is difficult to reason about, not amenable
> to scope-based cleanup, and the minor differences in the calling context of
> detach_target() and cxld_unregister() currently results in the
> cxl_decoder_kill_region() wrapper.
> 
> Introduce cxl_decoder_detach() to wrap a core __cxl_decoder_detach() that
> serves both cases. I.e. either detaching a known position in a region
> (interruptible), or detaching an endpoint decoder if it is found to be a
> member of a region (uninterruptible).
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Acked-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
One query inline about what I think is a change in when a reference count is
held on the region device.  I'm struggling to reason about whether that change
would have always been safe or if there is another change here that makes
it fine now?

(or whether I'm just misreading the change).

Jonathan



> ---
>  drivers/cxl/core/core.h   |  15 +++++-
>  drivers/cxl/core/port.c   |   9 ++--
>  drivers/cxl/core/region.c | 103 ++++++++++++++++++++++----------------
>  3 files changed, 75 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 29b61828a847..2be37084409f 100644
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
> +int cxl_decoder_detach(struct cxl_region *cxlr,
> +		       struct cxl_endpoint_decoder *cxled, int pos,
> +		       enum cxl_detach_mode mode);
> +
>  #define CXL_REGION_ATTR(x) (&dev_attr_##x.attr)
>  #define CXL_REGION_TYPE(x) (&cxl_region_type)
>  #define SET_CXL_REGION_ATTR(x) (&dev_attr_##x.attr),
> @@ -48,7 +57,9 @@ static inline int cxl_get_poison_by_endpoint(struct cxl_port *port)
>  {
>  	return 0;
>  }
> -static inline void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
> +static inline int cxl_decoder_detach(struct cxl_region *cxlr,
> +				     struct cxl_endpoint_decoder *cxled,
> +				     int pos, enum cxl_detach_mode mode)
>  {
>  }
>  static inline int cxl_region_init(void)
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index eb46c6764d20..087a20a9ee1c 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2001,12 +2001,9 @@ EXPORT_SYMBOL_NS_GPL(cxl_decoder_add, "CXL");
>  
>  static void cxld_unregister(void *dev)
>  {
> -	struct cxl_endpoint_decoder *cxled;
> -
> -	if (is_endpoint_decoder(dev)) {
> -		cxled = to_cxl_endpoint_decoder(dev);
> -		cxl_decoder_kill_region(cxled);
> -	}
> +	if (is_endpoint_decoder(dev))
> +		cxl_decoder_detach(NULL, to_cxl_endpoint_decoder(dev), -1,
> +				   DETACH_INVALIDATE);
>  
>  	device_unregister(dev);
>  }
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 2a97fa9a394f..4314aaed8ad8 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2135,27 +2135,43 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	return 0;
>  }
>  
> -static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
> +static struct cxl_region *
> +__cxl_decoder_detach(struct cxl_region *cxlr,
> +		     struct cxl_endpoint_decoder *cxled, int pos,
> +		     enum cxl_detach_mode mode)
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

This is a fairly nasty patch to unwind and fully understand but
I'm nervous that in the existing we have a get_device(&cxlr->dev)
before potential cxl_region_decode_reset(cxlr, ...)
and now we don't.  I'm not sure if that is a real problem though,
it just makes me nervous.


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
> @@ -2166,7 +2182,7 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
>  		dev_WARN_ONCE(&cxlr->dev, 1, "expected %s:%s at position %d\n",
>  			      dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>  			      cxled->pos);
> -		goto out;
> +		return NULL;
>  	}
>  
>  	if (p->state == CXL_CONFIG_ACTIVE) {
> @@ -2180,21 +2196,42 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
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
> +	get_device(&cxlr->dev);
> +	return cxlr;
>  }
>  
> -void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
> +/*
> + * Cleanup a decoder's interest in a region. There are 2 cases to
> + * handle, removing an unknown @cxled from a known position in a region
> + * (detach_target()) or removing a known @cxled from an unknown @cxlr
> + * (cxld_unregister())
> + *
> + * When the detachment finds a region release the region driver.
> + */
> +int cxl_decoder_detach(struct cxl_region *cxlr,
> +		       struct cxl_endpoint_decoder *cxled, int pos,
> +		       enum cxl_detach_mode mode)
>  {
> -	down_write(&cxl_region_rwsem);
> -	cxled->part = -1;
> -	cxl_region_detach(cxled);
> +	struct cxl_region *detach;
> +
> +	/* when the decoder is being destroyed lock unconditionally */
> +	if (mode == DETACH_INVALIDATE)
> +		down_write(&cxl_region_rwsem);
> +	else {
> +		int rc = down_write_killable(&cxl_region_rwsem);
> +
> +		if (rc)
> +			return rc;
> +	}
> +
> +	detach = __cxl_decoder_detach(cxlr, cxled, pos, mode);
>  	up_write(&cxl_region_rwsem);
> +
> +	if (detach) {
> +		device_release_driver(&detach->dev);
> +		put_device(&detach->dev);
> +	}
> +	return 0;
>  }
>  
>  static int attach_target(struct cxl_region *cxlr,
> @@ -2225,29 +2262,7 @@ static int attach_target(struct cxl_region *cxlr,
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
> +	return cxl_decoder_detach(cxlr, NULL, pos, DETACH_ONLY);
>  }
>  
>  static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,

