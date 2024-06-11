Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6E93CF65
	for <linux-cxl@vger.kernel.org>; Tue, 11 Jun 2024 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121145; cv=none; b=aoqzR+S57xPL/jP15uWHLyZfwFB+8vDnfH++VrGAqirl0zjAHucY0TUQejLwaK6RS/q61FUiYQ1uTwTLHsy7mLmNZP5nXWOKeY7eWIZn05Z98nB/s72FRbQMXe7QmiK6xx68PhS7McWW9OpNdLQHYkqpK9rn5x7LW4+O4LFzTaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121145; c=relaxed/simple;
	bh=LNjs7dwYGqZGklBw0AOakQ+XqvbF8qnlkgBpyoGdkjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k7RqBELQvCoptU+0qrigJ2k7RuBXNZVWmNV57gJtlcvF3uW0c9xhVoZ2981kbCmscmGp8qLaYBfZeem9dtn4+3y67knScsV0OIwFTusZx0myq5aFQe5iEC8iixIF1yuXGBVFALCd1++JNERb3r9DqQCel/93oFG1H8y0lJk4nVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KSAIfg+n; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KSAIfg+n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718121143; x=1749657143;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LNjs7dwYGqZGklBw0AOakQ+XqvbF8qnlkgBpyoGdkjw=;
  b=KSAIfg+nHMm9fepKDII5M5wR7C65PakOQ4HCmBf6lPpfZM8mMjPUmdx9
   CifM2qE4tNuJGHVlStxrqVdbTd5rSZXvUC+FPrfwjQyh2Tmjo3i5T/cni
   neemIG7lbyT5/146rlZ+huL8xgF5PZzYd15cbuOqzBvCTuwq3MV6M3SKp
   K4CzIkN/WNh2EUgwVhbg0UlQM/SpgVChiePr0cJObeKfmfHJ6PB8+HhDW
   4UZGKJvARI0UwxBflIUoLsQpiX2u8EBfzzOQmoFwy8jFnFNgWsHde9oHC
   samYy8v8b/Zi4BJ584eJfY+u8piM+8beKQBsqWEUzri7uGIvjNAm/vKNz
   Q==;
X-CSE-ConnectionGUID: 1yfs68qsQg6npXp7FKASKA==
X-CSE-MsgGUID: 524liIuDRHmZO2YS5gqKHg==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="40242342"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="40242342"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 08:52:22 -0700
X-CSE-ConnectionGUID: coAQexQ2QFKs+0vu8uEczw==
X-CSE-MsgGUID: iFqPHRBoQiiAMfvZNg2yZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="39943367"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.110.160]) ([10.125.110.160])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 08:52:21 -0700
Message-ID: <d7416f60-28fa-4848-a0cc-61431528db8a@intel.com>
Date: Tue, 11 Jun 2024 08:52:19 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] cxl/region: check interleave capability
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 jim.harris@samsung.com
Cc: linux-cxl@vger.kernel.org
References: <20240611021511.35315-1-yaoxt.fnst@fujitsu.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240611021511.35315-1-yaoxt.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/10/24 7:15 PM, Yao Xingtao wrote:
> Since interleave capability is not verified, if the interleave
> capability of a target does not match the region need, committing decoder
> should have failed at the device end.
> 
> In order to checkout this error as quickly as possible, driver needs
> to check the interleave capability of target during attaching it to
> region.
> 
> According to the CXL specification (section 8.2.4.20 CXL HDM Decoder
We should specify the revision of the spec in case future section number changes.

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
> If IW is less than 8 (for interleave ways of 2, 4, 8, 16), the

First use of 'IW'. I suggest using 'eIW' and clarify with something like:

encoded Interleave Ways (eIW)

Should do the same for IG as well below.

Once defined, eIW and eIG can be used.

> interleave bits start at bit position IG + 8 and end at IG + IW + 8 - 1.
> 
> If the IW is greater than or equal to 8 (for interleave ways of 6, 12),
> the interleave bits start at bit position IG + 8 and end at IG + IW - 1.
> 
> When the interleave ways is 1 or 3, all the bits of HPA are used, the
> interleave bits are none, the following check is ignored.
> 
> If the interleave mask is insufficient to cover the required interleave
> bits, the target cannot be attached to the region.
> 
> Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> 
> ---
> 
> V5[5] -> V6:
> -- fix some typo.
> -- update comment.
> -- set rc when check faild in cxl_port_attach_region().
> 
> V4[4] -> V5:
> -- update comment.
> -- add nr_targets check while attaching a port to switch.
> -- delete passthrough flag and allow all the capabilities for passthrough
>    decoders.
> 
> V3[3] -> V4:
> -- update comment.
> -- optimize the code.
> -- add a passthrough flag to mark the passthrough decoder.
> 
> V2[2] -> V3:
> -- revert ig_cap_mask to interleave_mask.
> -- fix the interleave bits check logical.
> 
> V1[1] -> V2:
> -- rename interleave_mask to ig_cap_mask.
> -- add a check for interleave granularity.
> -- update commit.
> -- move hdm caps init to parse_hdm_decoder_caps().
> 
> [1]
> https://lore.kernel.org/linux-cxl/20240401075635.9333-1-yaoxt.fnst@fujitsu.com
> 
> [2]
> https://lore.kernel.org/linux-cxl/20240403021747.17260-1-yaoxt.fnst@fujitsu.com
> 
> [3]
> https://lore.kernel.org/linux-cxl/20240409022621.29115-1-yaoxt.fnst@fujitsu.com
> 
> [4]
> https://lore.kernel.org/linux-cxl/20240422091350.4701-1-yaoxt.fnst@fujitsu.com
> 
> [5]
> https://lore.kernel.org/linux-cxl/20240524092740.4260-1-yaoxt.fnst@fujitsu.com
> ---
>  drivers/cxl/core/hdm.c    | 10 +++++
>  drivers/cxl/core/region.c | 89 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |  2 +
>  drivers/cxl/cxlmem.h      |  1 +
>  4 files changed, 102 insertions(+)
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

Should define a mask for this. Probably should have defined masks for all of the open coded BIT() sets.

> +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY, hdm_cap))
> +		cxlhdm->iw_cap_mask |= BIT(3) | BIT(6) | BIT(12);
> +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
> +		cxlhdm->iw_cap_mask |= BIT(16);
>  }
>  
>  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5c186e0a39b9..2716678df5db 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1101,6 +1101,26 @@ static int cxl_port_attach_region(struct cxl_port *port,
>  	}
>  	cxld = cxl_rr->decoder;
>  
> +	/*
> +	 * the number of targets should not exceed the target_count
> +	 * of the decoder
> +	 */
> +	if (is_switch_decoder(&cxld->dev)) {
> +		struct cxl_switch_decoder *cxlsd;
> +
> +		cxlsd = to_cxl_switch_decoder(&cxld->dev);
> +		if (cxl_rr->nr_targets > cxlsd->nr_targets) {
> +			dev_dbg(&cxlr->dev,
> +				"%s:%s %s add: %s:%s @ %d overflows targets: %d\n",
> +				dev_name(port->uport_dev), dev_name(&port->dev),
> +				dev_name(&cxld->dev), dev_name(&cxlmd->dev),
> +				dev_name(&cxled->cxld.dev), pos,
> +				cxlsd->nr_targets);
> +			rc = -ENXIO;
> +			goto out_erase;
> +		}
> +	}
> +

Should this be a seaprate patch? Seems to be outside the purpose of interleave capability check. 

>  	rc = cxl_rr_ep_add(cxl_rr, cxled);
>  	if (rc) {
>  		dev_dbg(&cxlr->dev,
> @@ -1210,6 +1230,57 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
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

This test can be moved above the ways_to_eiw() call? No need to do ways_to_eiw() if this fails?

> +
> +	rc = granularity_to_eig(ig, &eig);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Per CXL specification (8.2.4.20.13 Decoder Protection in r3.1),

A nit but it's probably easier to read if you specify the spec revision first
	Per CXL specification r3.1 (8.2.4.20.13...),

DJ
> +	 * if eiw < 8:
> +	 *   DPAOFFSET[51: eig + 8] = HPAOFFSET[51: eig + 8 + eiw]
> +	 *   DPAOFFSET[eig + 7: 0]  = HPAOFFSET[eig + 7: 0]
> +	 *
> +	 *   when the eiw is 0, all the bits of HPAOFFSET[51: 0] are used, the
> +	 *   interleave bits are none.
> +	 *
> +	 * if eiw >= 8:
> +	 *   DPAOFFSET[51: eig + 8] = HPAOFFSET[51: eig + eiw] / 3
> +	 *   DPAOFFSET[eig + 7: 0]  = HPAOFFSET[eig + 7: 0]
> +	 *
> +	 *   when the eiw is 8, all the bits of HPAOFFSET[51: 0] are used, the
> +	 *   interleave bits are none.
> +	 */
> +	if (eiw == 0 || eiw == 8)
> +		return 0;
> +
> +	if (eiw > 8)
> +		high_pos = eiw + eig - 1;
> +	else
> +		high_pos = eiw + eig + 7;
> +	low_pos = eig + 8;
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
> @@ -1360,6 +1431,15 @@ static int cxl_port_setup_targets(struct cxl_port *port,
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
> @@ -1796,6 +1876,15 @@ static int cxl_region_attach(struct cxl_region *cxlr,
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
