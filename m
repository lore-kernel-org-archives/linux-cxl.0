Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A418D21C174;
	Mon, 14 Jul 2025 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752517053; cv=none; b=CPS/bj8q9coC6FNYyyNsR7quMAMaMMHtJf2r7k4Q49kAAHvuKl+VyK0ukvmxidMwUe5Bdo1CvBlULklf0Z0iS4K71fgcBhKdZLfPSZgJo2aeeGUxFtrnLtPhXRpN5t3Y636x8A1XEU49ulnVvG6YrXqWTHC7dCd3ZBPXuNghDVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752517053; c=relaxed/simple;
	bh=QzbBHaWts5fmL/MPiNg0zmCOpBSvxfaO8yR/1dxc2ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8m1B69JTOsFNt52D+FtZbQaLBZ1M8qcDm+g+P/wItmfenY15+8pGPUrWLzq9JzAa7uRKRFemKyaugzU7L+I4PwOMZCOZRg4sByz+tAgxlcuK0s844U26qWJrcY/TlMxi2h7PJ7uxkbCNKFUB/MXTtCTAJvPi1UjdpEKr3DjJXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fdCTxPdA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fdCTxPdA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752517052; x=1784053052;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QzbBHaWts5fmL/MPiNg0zmCOpBSvxfaO8yR/1dxc2ko=;
  b=fdCTxPdAuMyRVK4j80WRLvaV48Sc8vI4GKBj37n9mTP+raFigMz6V6JH
   p9AIovlocviwv4cuzZefe8r6vaUV29VKPKcKVp8b0pun9BgDVpG7biwwq
   CmRV+w5x3LnbVbkQ58HgqxFMQ1VqPkNmu04Gr3UYHlMfDVOvlfBGqEI8c
   1GNqC47PWcMpvWjr8oG2gQssuL4di6dpj31S2JwhwWF0Y8G/egPHCzqJm
   WU38HrvoGx5Pk5nOyIJdI3wTwq4eRK8lUsiPvAOTf/KDBx3wfWneHNIWQ
   ZAPIJ83ETOZCkHYMgSy0WcuAgB6HBoTEReby/7pp/84KpaYqmVss9IOac
   g==;
X-CSE-ConnectionGUID: 0MaZ3r8WR8iAcx7L4sZDzQ==
X-CSE-MsgGUID: rOK7yoZ+SYOpNWMLdUh4Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54874401"
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="54874401"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 11:17:31 -0700
X-CSE-ConnectionGUID: k2qsJcOFS9GiD/IlcL0cAw==
X-CSE-MsgGUID: Itjjjxp9R/K57wtyOEGeOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="157345938"
Received: from tfalcon-desk.amr.corp.intel.com (HELO [10.125.111.97]) ([10.125.111.97])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 11:17:31 -0700
Message-ID: <bb4507a8-41cf-4e0a-b8ac-ed2aa9122f8c@intel.com>
Date: Mon, 14 Jul 2025 11:17:28 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] cxl/region: Consolidate cxl_decoder_kill_region()
 and cxl_region_detach()
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20250711234932.671292-1-dan.j.williams@intel.com>
 <20250711234932.671292-8-dan.j.williams@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250711234932.671292-8-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/11/25 4:49 PM, Dan Williams wrote:
> Both detach_target() and cxld_unregister() want to tear down a cxl_region
> when an endpoint decoder is either detached or destroyed.
> 
> When a region is to be destroyed cxl_region_detach() releases
> cxl_region_rwsem unbinds the cxl_region driver and re-acquires the rwsem.
> 

I think this one needs some commas?

When a region is to be destroyed cxl_region_detach() releases
cxl_region_rwsem, unbinds the cxl_region driver, and re-acquires the rwsem.

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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

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

