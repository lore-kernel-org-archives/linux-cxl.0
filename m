Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18F11494BD
	for <linux-cxl@vger.kernel.org>; Wed,  5 Jun 2024 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602935; cv=none; b=jjUrC7vqjIiXwPCPtCow81siic9v3gDQrjYVzAm4YejT0ktgdI5M1B7cWfVFTGahnHetX1hV4hLKAW2hVLodhxa9YNztZrRkPFXLg47ue51eGBrq2io+Wpofnl5MGakasD05MdeSrm0ZHh/rqri1AV6L2rzIqAFYTSN+GwHqNoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602935; c=relaxed/simple;
	bh=nNU3YDhDj7yaviSg7iqCa4eK8JgXET0Fj10vDkI/ckg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDtdbs8OSTBZLJNkw7lgj4YASYP4g8B6XV+0vN24bZQ4ECPAQtt3r2etvdffnyvoWppn1xubKxdEW7ft1vs7l1DMZ8F7qNbC3i0IJrMZifQ5mRldkLeOIfOXgcu+AEyVOd2pynBYOBnk+A/obkQfA9FKh3RttVzKphNk20PWzdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UEKhJEqt; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UEKhJEqt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717602933; x=1749138933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nNU3YDhDj7yaviSg7iqCa4eK8JgXET0Fj10vDkI/ckg=;
  b=UEKhJEqtBuYor1+3EDIiNQtIiTmmBwbS9ICzurw/rcSEZijY5axZl4+p
   C8dL/QKRW6RMmhHYf7HdbNQKWWb3yelSTkDQ48O9BnBhQxls6PBNakq//
   TKGTZmohNIKBVioGbiFmGqmqi2HHb6LI33EW6GSC11Eh5CwLYbzSnBjMU
   pM5TtraKIDlM8caiyc976iQabIo8sSBIZPHO8J1tarht+XELJcA167XGm
   qOiaYFk+/BG+xd7ahn/tZHN8wGeeL4UvQuCIKYDip+TQiNG7TpU9OMcOW
   WH+sXc+kXbyFME134JOXKXMmfUc8oUDs97Z5ZmASLxzJ2UX3zV+GXqp/k
   A==;
X-CSE-ConnectionGUID: 30AactCdQlGuUsX4pTnewQ==
X-CSE-MsgGUID: ApR4E5+uR/Cb5WlXC8lOKw==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14065130"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="14065130"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 08:55:32 -0700
X-CSE-ConnectionGUID: kzPqYGC0TIiGL+8KRHeS/g==
X-CSE-MsgGUID: PEFoGAQZT5qTbsarX1nF1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="37742189"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.22.89])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 08:55:31 -0700
Date: Wed, 5 Jun 2024 08:55:29 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, jim.harris@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5] cxl/region: check interleave capability
Message-ID: <ZmCKcVZPS/5MztqD@aschofie-mobl2>
References: <20240524092740.4260-1-yaoxt.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524092740.4260-1-yaoxt.fnst@fujitsu.com>

On Fri, May 24, 2024 at 05:27:40AM -0400, Yao Xingtao wrote:
> Since interleave capability is not verified, if the interleave
> capability of a target does not match the region need, committing decoder
> should have failed at the device end.
> 

What happens now if the driver tries to program a decoder with capabilities
it does not support?

Can you offer me the changelog here?  Definately in the next revision
but also right here in reply to remind me of prior discussions.

-- Alison


> In order to checkout this error as quickly as possible, driver needs
> to check the interleave capability of target during attaching it to
> region.
> 
> According to the CXL specification (section 8.2.4.20 CXL HDM Decoder
> Capability Structure), bits 11 and 12 within the 'CXL HDM Decoder
> Capability Register' indicate the capability to establish interleaving
> in 3, 6, 12, and 16 ways. If these bits are not set, the target cannot
> be attached to a region utilizing such interleave ways.
> 
> Additionally, bits 8 and 9 in the same register represent the capability
> of the bits used for interleaving in the address, Linux tracks this in the
> cxl_port interleave_mask.
> 
> Regarding 'Decoder Protection':
> If IW is less than 8 (for interleave ways of 1, 2, 4, 8, 16), the
> interleave bits start at bit position IG + 8 and end at IG + IW + 8 - 1.
> 
> If the IW is greater than or equal to 8 (for interleave ways of 3, 6, 12),
> the interleave bits start at bit position IG + 8 and end at IG + IW - 1.
> 
> If the interleave mask is insufficient to cover the required interleave
> bits, the target cannot be attached to the region.
> 
> Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>  drivers/cxl/core/hdm.c    | 10 +++++
>  drivers/cxl/core/region.c | 83 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |  2 +
>  drivers/cxl/cxlmem.h      |  1 +
>  4 files changed, 96 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7d97790b893d..5b7dff19bbfa 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -52,6 +52,11 @@ int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
>  	struct cxl_dport *dport = NULL;
>  	int single_port_map[1];
>  	unsigned long index;
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> +
> +	/* allow all the interleave capabilities for passthrough decoder */
> +	cxlhdm->interleave_mask = GENMASK(14, 8);
> +	cxlhdm->iw_cap_mask = BIT(1) | BIT(2) | BIT(4) | BIT(8);
>  
>  	cxlsd = cxl_switch_decoder_alloc(port, 1);
>  	if (IS_ERR(cxlsd))
> @@ -79,6 +84,11 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  		cxlhdm->interleave_mask |= GENMASK(11, 8);
>  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
>  		cxlhdm->interleave_mask |= GENMASK(14, 12);
> +	cxlhdm->iw_cap_mask = BIT(1) | BIT(2) | BIT(4) | BIT(8);
> +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY, hdm_cap))
> +		cxlhdm->iw_cap_mask |= BIT(3) | BIT(6) | BIT(12);
> +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
> +		cxlhdm->iw_cap_mask |= BIT(16);
>  }
>  
>  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5c186e0a39b9..6b7400313cb2 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1054,6 +1054,7 @@ static int cxl_port_attach_region(struct cxl_port *port,
>  	struct cxl_decoder *cxld;
>  	unsigned long index;
>  	int rc = -EBUSY;
> +	struct cxl_switch_decoder *cxlsd;
>  
>  	lockdep_assert_held_write(&cxl_region_rwsem);
>  
> @@ -1101,6 +1102,23 @@ static int cxl_port_attach_region(struct cxl_port *port,
>  	}
>  	cxld = cxl_rr->decoder;
>  
> +	/*
> +	 * the number of targets should not exceed the target_count
> +	 * of the decoder
> +	 */
> +	if (is_switch_decoder(&cxld->dev)) {
> +		cxlsd = to_cxl_switch_decoder(&cxld->dev);
> +		if (cxl_rr->nr_targets > cxlsd->nr_targets) {
> +			dev_dbg(&cxlr->dev,
> +				"%s:%s %s add: %s:%s @ %d overflows targets: %d\n",
> +				dev_name(port->uport_dev), dev_name(&port->dev),
> +				dev_name(&cxld->dev), dev_name(&cxlmd->dev),
> +				dev_name(&cxled->cxld.dev), pos,
> +				cxlsd->nr_targets);
> +			goto out_erase;
> +		}
> +	}
> +
>  	rc = cxl_rr_ep_add(cxl_rr, cxled);
>  	if (rc) {
>  		dev_dbg(&cxlr->dev,
> @@ -1210,6 +1228,53 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
>  	return 0;
>  }
>  
> +static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
> +{
> +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> +	unsigned int interleave_mask;
> +	u8 eiw;
> +	u16 eig;
> +	int rc, high_pos, low_pos;
> +
> +	rc = ways_to_eiw(iw, &eiw);
> +	if (rc)
> +		return rc;
> +
> +	if (!test_bit(iw, &cxlhdm->iw_cap_mask))
> +		return -ENXIO;
> +
> +	rc = granularity_to_eig(ig, &eig);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Per CXL specification (8.2.3.20.13 Decoder Protection in r3.1)
> +	 * if eiw < 8, the interleave bits start at bit position eig + 8, and
> +	 * end at eig + eiw + 8 - 1.
> +	 * if eiw >= 8, the interleave bits start at bit position eig + 8, and
> +	 * end at eig + eiw - 1.
> +	 */
> +	if (eiw >= 8)
> +		high_pos = eiw + eig - 1;
> +	else
> +		high_pos = eiw + eig + 7;
> +	low_pos = eig + 8;
> +	/*
> +	 * when the eiw is 0 or 8 (interlave way is 1 or 3), the num of
> +	 * interleave bits is 0, there is no interleaving, the following
> +	 * check is ignored.
> +	 */
> +	if (low_pos > high_pos)
> +		return 0;
> +
> +	interleave_mask = GENMASK(high_pos, low_pos);
> +	if (interleave_mask & ~cxlhdm->interleave_mask)
> +		return -ENXIO;
> +
> +	return 0;
> +}
> +
>  static int cxl_port_setup_targets(struct cxl_port *port,
>  				  struct cxl_region *cxlr,
>  				  struct cxl_endpoint_decoder *cxled)
> @@ -1360,6 +1425,15 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  			return -ENXIO;
>  		}
>  	} else {
> +		rc = check_interleave_cap(cxld, iw, ig);
> +		if (rc) {
> +			dev_dbg(&cxlr->dev,
> +				"%s:%s iw: %d ig: %d is not supported\n",
> +				dev_name(port->uport_dev),
> +				dev_name(&port->dev), iw, ig);
> +			return rc;
> +		}
> +
>  		cxld->interleave_ways = iw;
>  		cxld->interleave_granularity = ig;
>  		cxld->hpa_range = (struct range) {
> @@ -1796,6 +1870,15 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	struct cxl_dport *dport;
>  	int rc = -ENXIO;
>  
> +	rc = check_interleave_cap(&cxled->cxld, p->interleave_ways,
> +				  p->interleave_granularity);
> +	if (rc) {
> +		dev_dbg(&cxlr->dev, "%s iw: %d ig: %d is not supported\n",
> +			dev_name(&cxled->cxld.dev), p->interleave_ways,
> +			p->interleave_granularity);
> +		return rc;
> +	}
> +
>  	if (cxled->mode != cxlr->mode) {
>  		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
>  			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 036d17db68e0..dc8e46a1fe82 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -45,6 +45,8 @@
>  #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
>  #define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
>  #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
> +#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
> +#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
>  #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
>  #define   CXL_HDM_DECODER_ENABLE BIT(1)
>  #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 36cee9c30ceb..6b8cf20ff375 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -853,6 +853,7 @@ struct cxl_hdm {
>  	unsigned int decoder_count;
>  	unsigned int target_count;
>  	unsigned int interleave_mask;
> +	unsigned long iw_cap_mask;
>  	struct cxl_port *port;
>  };
>  
> -- 
> 2.37.3
> 
