Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8834346D570;
	Tue, 21 Jul 2026 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784650091; cv=none; b=KEZof31Jqg1/8A9wJ3NcXgpiPzcx/boaAfwuQw5qg8iwO1ROG+tCSuG/YIQtJtok9e5uRvAMHo78cl6hTXLalaEe+FASx5H7QUQ1AJCaurL6xZXX6kGjhuPIiP/aUO4VaakC7O9iKysHy8CG4z2n0PJikAv9YPac0b5xMHS+Ubc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784650091; c=relaxed/simple;
	bh=Qk13U5yYOGN14O7Aza2vtNoi2FKh/Vn9QkzaU90pIzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AFmH29T+Zc6d/7mGHHHrbZ66QvuV8uMCaE/D3CTfsC7wZNMxMqM+58fey6s+n8NWDsLeShMfARmBLV248W0FNWSl9e+KfyoovhXZKL2OBb0G+HTeU59pFmZVY2sAiptAQCgFnccPdHMtiNoLGQI1tVNhvAbtotWds/oQtloZmdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BBB5gotm; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BBB5gotm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784650088; x=1816186088;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Qk13U5yYOGN14O7Aza2vtNoi2FKh/Vn9QkzaU90pIzQ=;
  b=BBB5gotmNdfpmhpLnCuaa2IAJva0j2HgJ5F430oPFx857LmDF22nFySC
   YkI+TYxZxBJEyIweSR/ykuiWU4Ejeh5UneGOkwylnW3gOyAoxTpFCaEvc
   4kAobGvRaJ7ltV143JlPSeG/ubUMI6BOqcx5y/TF5r3Y2Okjnqt3GVZGe
   sEIoxNOw3XnAROGfp4ZHQqPlEM2FwVDXc2WFKTBPQinQM872WfC4fRIZh
   kST3LdhAjHUmWJ+ADes9R3mm9qVFadPPRF0yWAKNaTjewRwAHYGpIgOzq
   51LXn9H59xscKkxMyQtYya0zAG1y3fyAjml6YnWR+TGoL7Vjf2Tf7jGkD
   Q==;
X-CSE-ConnectionGUID: k9FLg1OrS1m1nr6FS8+OTQ==
X-CSE-MsgGUID: JP8+vWyAQz6mFpBK/IuOHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="96621351"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="96621351"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 09:08:03 -0700
X-CSE-ConnectionGUID: 1EChlcWqRZysWJAqlfO7Qw==
X-CSE-MsgGUID: FVMV9gaXQCiR5iESpY78tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="261368136"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.109.244]) ([10.125.109.244])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 09:08:01 -0700
Message-ID: <3d805e6a-3d3d-498e-b1ab-a84343497016@intel.com>
Date: Tue, 21 Jul 2026 09:08:00 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2 RESEND] cxl/hdm: Allow zero sized HDM decoders
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org,
 danwilliams@nvidia.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, newtonl@nvidia.com, kristinc@nvidia.com,
 kaihengf@nvidia.com, kobak@nvidia.com, Vishal Aslot <vaslot@nvidia.com>
References: <20260721085715.39322-1-icheng@nvidia.com>
 <20260721085715.39322-2-icheng@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260721085715.39322-2-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/21/26 1:57 AM, Richard Cheng wrote:
> CXL r4.0 §8.2.4.20.12 ("Committing Decoder Programming") and §14.13.10
> ("CXL HDM Decoder Zero Size Commit") permit committing an HDM decoder
> with size 0. BIOS may commit and lock such decoders so the OS cannot
> program regions through them, this is a design choice rather than a spec
> requirement.
> The kernel rejected these with -ENXIO during port enumeration and aborted
> the whole port, so affected systems showed nothing under 'cxl list'.
> 
> Treat empty decoders as first class instead of special casing them, back
> them with a kmalloc'd resource, since the resource tree can't represent
> an empty range, and keep the skip and hdm_end accounting intact. Guard
> the paths an empty decoder can't serve, e.g. region attach, DPA free, and
> poison queries.
> 
> Suggested-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> Reviewed-by: Dan Williams <djbw@kernel.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Changelog:
> v6->v7:
> 	- Rebase onto cxl/for-7.3/cxl-type2-test.
> 
> v5->v6:
>      - Comment wording fixups, no functional change: reword cxled_empty()
>        per Dan Williams' review and tidy the poison-walk comment.
> v4->v5:
>      - Rework per Dan Williams' suggestion: make zero-size DPA
>        reservations first class instead of bypassing reservation.
>        cxl_dpa_request_region() returns a kmalloc'd resource for size 0;
>        cxl_dpa_release_region() kfrees it on teardown. hdm_end now
>        advances and releases for zero-size decoders under cxl_rwsem.dpa,
>        and their skip registers are honored.
>      - Corrections to the posted sketch: add the missing return after
>        kfree() (use-after-free), use IORESOURCE_MEM flags so
>        resource_contains() can resolve cxled->part.
>      - cxl_mem_get_poison() returns success for zero-length queries
>        before issuing a mailbox command.
>      - Fully-burned device (all decoders zero-size at DPA 0): cxled->part
>        cannot resolve; gate poison_by_decoder() queries on part >= 0
>        (the part[-1] OOB read was already reachable for sized decoders
>        that fail partition containment) and scan all partitions when the
>        walk reaches commit_end with nothing mapped (sashiko report).
>      - Drop v4's poison_by_decoder() restructure and the hdm_end
>        non-advance approach; superseded by the above.
> 
> v3->v4:
>      - Drop the port->hdm_end advance for zero-size decoders (sashiko AI
>        review). The write was outside cxl_rwsem.dpa, and advancing the
>        watermark without a balanced release strands hdm_end and breaks
>        LIFO teardown. It is also unnecessary -- zero-size committed slots
>        are trailing and locked, so the in-order check in
>        __cxl_dpa_reserve() is never reached past them.
> 
> v2->v3:
>      - Advance port->hdm_end for the committed zero-size decoder so a
>        following committed decoder still passes the in-order check in
>        __cxl_dpa_reserve() (it was left un-incremented in v2).
>      - Fold the poison fix into this patch: commit_end may now reference a
>        zero-size decoder with no DPA resource, so poison_by_decoder() falls
>        through to run cxl_get_poison_unmapped() and scan the unmapped DPA
>        tail.
> 
> v1->v2:
>     - Add zero-size committed decoders to the topology instead of
>       skipping them. Drop v1's -ENOSPC sentinel and the matching
> "continue" in devm_cxl_enumerate_decoders(); fall through so
> add_hdm_decoder() registers the decoder.
>     - Set port->commit_end unconditionally for any committed decoder,
>       not only non-zero-size ones, so subsequent decoders satisfy the
> out-of-order check.
>     - Add an explicit early-return before devm_cxl_dpa_reserve() in the
>       endpoint-decoder path. __cxl_dpa reserve() rejects zero-size
> decoders
>     - Spell out TSP and TCB and cite spec sections in commit message
>     - Reorder series, implementation first
> ---
>  drivers/cxl/core/hdm.c    | 52 ++++++++++++++++++++++++++-------------
>  drivers/cxl/core/mbox.c   |  3 +++
>  drivers/cxl/core/region.c | 49 +++++++++++++++++++++++-------------
>  drivers/cxl/cxl.h         | 10 ++++++++
>  drivers/cxl/port.c        |  3 +++
>  5 files changed, 83 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..ccbab2e21f06 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -240,6 +240,18 @@ static resource_size_t __adjust_skip(struct cxl_dev_state *cxlds,
>  }
>  #define release_skip(c, b, l) __adjust_skip((c), (b), (l), NULL)
>  
> +static void cxl_dpa_release_region(struct resource *parent,
> +				   struct resource *res)
> +{
> +	/* zero sized decoders are not tracked in the resource tree */
> +	if (resource_size(res) == 0) {
> +		kfree(res);
> +		return;
> +	}
> +
> +	__release_region(parent, res->start, resource_size(res));
> +}
> +
>  /*
>   * Must be called in a context that synchronizes against this decoder's
>   * port ->remove() callback (like an endpoint decoder sysfs attribute)
> @@ -256,7 +268,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
>  
>  	/* save @skip_start, before @res is released */
>  	skip_start = res->start - cxled->skip;
> -	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
> +	cxl_dpa_release_region(&cxlds->dpa_res, res);
>  	if (cxled->skip)
>  		release_skip(cxlds, skip_start, cxled->skip);
>  	cxled->skip = 0;
> @@ -336,6 +348,23 @@ static int request_skip(struct cxl_dev_state *cxlds,
>  	return -EBUSY;
>  }
>  
> +static struct resource *cxl_dpa_request_region(struct resource *parent,
> +					       resource_size_t start,
> +					       resource_size_t n,
> +					       const char *name)
> +{
> +	if (!n) {
> +		struct resource *res = kmalloc_obj(*res);
> +
> +		if (!res)
> +			return NULL;
> +		*res = DEFINE_RES_NAMED(start, 0, name, IORESOURCE_MEM);
> +		return res;
> +	}
> +
> +	return __request_region(parent, start, n, name, 0);
> +}
> +
>  static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  			     resource_size_t base, resource_size_t len,
>  			     resource_size_t skipped)
> @@ -349,12 +378,6 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  
>  	lockdep_assert_held_write(&cxl_rwsem.dpa);
>  
> -	if (!len) {
> -		dev_warn(dev, "decoder%d.%d: empty reservation attempted\n",
> -			 port->id, cxled->cxld.id);
> -		return -EINVAL;
> -	}
> -
>  	if (cxled->dpa_res) {
>  		dev_dbg(dev, "decoder%d.%d: existing allocation %pr assigned\n",
>  			port->id, cxled->cxld.id, cxled->dpa_res);
> @@ -378,8 +401,8 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  		if (rc)
>  			return rc;
>  	}
> -	res = __request_region(&cxlds->dpa_res, base, len,
> -			       dev_name(&cxled->cxld.dev), 0);
> +	res = cxl_dpa_request_region(&cxlds->dpa_res, base, len,
> +				     dev_name(&cxled->cxld.dev));
>  	if (!res) {
>  		dev_dbg(dev, "decoder%d.%d: failed to reserve allocation\n",
>  			port->id, cxled->cxld.id);
> @@ -402,7 +425,8 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  				break;
>  			}
>  
> -	if (cxled->part < 0)
> +	/* Empty decoders may not be contained by a partition boundary */
> +	if (cxled->part < 0 && resource_size(res))
>  		dev_warn(dev, "decoder%d.%d: %pr does not map any partition\n",
>  			 port->id, cxled->cxld.id, res);
>  
> @@ -545,7 +569,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>  	struct device *dev = &cxled->cxld.dev;
>  
>  	guard(rwsem_write)(&cxl_rwsem.dpa);
> -	if (!cxled->dpa_res)
> +	if (cxled_empty(cxled))
>  		return 0;
>  	if (cxled->cxld.region) {
>  		dev_dbg(dev, "decoder assigned to: %s\n",
> @@ -1031,12 +1055,6 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			return -ENXIO;
>  		}
>  
> -		if (size == 0) {
> -			dev_warn(&port->dev,
> -				 "decoder%d.%d: Committed with zero size\n",
> -				 port->id, cxld->id);
> -			return -ENXIO;
> -		}
>  		port->commit_end = cxld->id;
>  	} else {
>  		if (cxled) {
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 97b1e61ad018..ffd24992273d 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1384,6 +1384,9 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  	int nr_records = 0;
>  	int rc;
>  
> +	if (!len)
> +		return 0;
> +
>  	ACQUIRE(mutex_intr, lock)(&mds->poison.mutex);
>  	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
>  		return rc;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1e211542b6b6..6c7d9a52707c 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2115,7 +2115,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> -	if (!cxled->dpa_res) {
> +	if (cxled_empty(cxled)) {
>  		dev_dbg(&cxlr->dev, "%s:%s: missing DPA allocation.\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
>  		return -ENXIO;
> @@ -2959,28 +2959,35 @@ static int poison_by_decoder(struct device *dev, void *arg)
>  	if (!cxled->dpa_res)
>  		return rc;
>  
> -	cxlmd = cxled_to_memdev(cxled);
> -	cxlds = cxlmd->cxlds;
> -	mode = cxlds->part[cxled->part].mode;
> +	/*
> +	 * Handle the degenerate case of a device with only empty decoders. An
> +	 * empty decoder can still map a non-zero skip range, so advance the
> +	 * walk to commit_end either way.
> +	 */
> +	if (cxled->part >= 0) {
> +		cxlmd = cxled_to_memdev(cxled);
> +		cxlds = cxlmd->cxlds;
> +		mode = cxlds->part[cxled->part].mode;
> +
> +		if (cxled->skip) {
> +			offset = cxled->dpa_res->start - cxled->skip;
> +			length = cxled->skip;
> +			rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> +			if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
> +				rc = 0;
> +			if (rc)
> +				return rc;
> +		}
>  
> -	if (cxled->skip) {
> -		offset = cxled->dpa_res->start - cxled->skip;
> -		length = cxled->skip;
> -		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> +		offset = cxled->dpa_res->start;
> +		length = cxled->dpa_res->end - offset + 1;
> +		rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
>  		if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
>  			rc = 0;
>  		if (rc)
>  			return rc;
>  	}
>  
> -	offset = cxled->dpa_res->start;
> -	length = cxled->dpa_res->end - offset + 1;
> -	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
> -	if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
> -		rc = 0;
> -	if (rc)
> -		return rc;
> -
>  	/* Iterate until commit_end is reached */
>  	if (cxled->cxld.id == ctx->port->commit_end) {
>  		ctx->offset = cxled->dpa_res->end + 1;
> @@ -3002,9 +3009,17 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
>  	};
>  
>  	rc = device_for_each_child(&port->dev, &ctx, poison_by_decoder);
> -	if (rc == 1)
> +	if (rc == 1) {
> +		/*
> +		 * No decoder with a sized DPA reservation was walked
> +		 * (every committed decoder is zero-size): scan all
> +		 * partitions in full.
> +		 */
> +		if (ctx.part < 0)
> +			ctx.part = 0;
>  		rc = cxl_get_poison_unmapped(to_cxl_memdev(port->uport_dev),
>  					     &ctx);
> +	}
>  
>  	return rc;
>  }
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index c0e5308e4d1b..cef53d9bd5c0 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -336,6 +336,16 @@ struct cxl_endpoint_decoder {
>  	int pos;
>  };
>  
> +/*
> + * The common case is decoders with no reservation, but also handle
> + * decoders with a zero-sized reservation that firmware may install for
> + * security lockdown purposes.
> + */
> +static inline bool cxled_empty(struct cxl_endpoint_decoder *cxled)
> +{
> +	return !cxled->dpa_res || !resource_size(cxled->dpa_res);
> +}
> +
>  /**
>   * struct cxl_switch_decoder - Switch specific CXL HDM Decoder
>   * @cxld: base cxl_decoder object
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 99cf77b6b699..c12fd0b89883 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -46,6 +46,9 @@ static int discover_region(struct device *dev, void *unused)
>  	if (cxled->state != CXL_DECODER_STATE_AUTO)
>  		return 0;
>  
> +	if (cxled_empty(cxled))
> +		return 0;
> +
>  	/*
>  	 * Region enumeration is opportunistic, if this add-event fails,
>  	 * continue to the next endpoint decoder.

