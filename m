Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6716E8479
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jul 2024 01:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720661980; cv=none; b=W3RpCkOoWtVon9FM9jFQf+r4KwMPirZ+xpFBhHFMxZaNkuIUlZembkdPw2Na67sTTbNUfAasQCgGDgOZio9G6IDllUbS6S5rYTk0zccNWYOfNjHmUWWEH9EokJ6TZZZCCAW2FCNzmZgGXaB9pUta5o8hA07KCmsp609QeP3azkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720661980; c=relaxed/simple;
	bh=6QGZAkPAP9pG+aBMVh1V+Bn8bRxDlsv3pnO8eW4GX8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UArxm9pk8vJh02eb4bajLhMVdMLo7pLJaV7eiXD1THilYkq3WEXMecgNzyRiR6H8ckTMd+tj7hUFQ24uHhHXMGuautGAX9mXrgjwEoPmrbXpzDFQtRPqt0wQc/2k5EIMQJEZM8TroSZ++11r8Y/tv0Fddw7E1p/DewMu5ZU4/ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gpxPazn8; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gpxPazn8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720661978; x=1752197978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6QGZAkPAP9pG+aBMVh1V+Bn8bRxDlsv3pnO8eW4GX8Q=;
  b=gpxPazn8vER4sh6mDjnKTMt/Hzg/V7vBzNV1J/IQjBaTd5dKfNSGGqEe
   nQd3i7DuetNXcBRprZM8JblQm3A+nGbxgxQLND7tJePTYQVRzuU5jsxw1
   vccgO7pDlheileQJuTMsn5PleF1lWjWG5BZboJd7mbFVxnbvIQIkw2JX0
   FwjfoG2FXPiiIwfmIbJas263/jPjBh9fYITzXjZCavu3edVHsN5WKMAFN
   lxpxrNI0VYwv87bFiLzEUSgPQOqXls/YS072EGf1V4X2lliW+oal0goha
   O35YH428UaueA+xe0fkSQEbxwHiCHFzEP8nkewZgSpb01Wob3wg0hFRdW
   Q==;
X-CSE-ConnectionGUID: IVb6wUAISnKU2jNMcvh0wg==
X-CSE-MsgGUID: vSSxL0iSSTWOCEykEoPfeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="35558892"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="35558892"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 18:39:37 -0700
X-CSE-ConnectionGUID: aYIbbmKsRVWURkXQFh+TbQ==
X-CSE-MsgGUID: owCvSTAcTQGEG4dLQOkxgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="53347479"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.72.164])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 18:39:38 -0700
Date: Wed, 10 Jul 2024 18:39:35 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	Jonathan.Cameron@huawei.com, dave@stgolabs.net
Subject: Re: [PATCH v7 2/3] cxl: Calculate region bandwidth of targets with
 shared upstream link
Message-ID: <Zo8317DPRkLOsOlH@aschofie-mobl2>
References: <20240710222716.797267-1-dave.jiang@intel.com>
 <20240710222716.797267-3-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710222716.797267-3-dave.jiang@intel.com>

On Wed, Jul 10, 2024 at 03:24:01PM -0700, Dave Jiang wrote:
> The current bandwidth calculation aggregates all the targets. This simple
> method does not take into account where multiple targets sharing under
> a switch or a root port where the aggregated bandwidth can be greater than
> the upstream link of the switch.
> 
> To accurately account for the shared upstream uplink cases, a new update
> function is introduced by walking from the leaves to the root of the
> hierarchy and clamp the bandwidth in the process as needed. This process
> is done when all the targets for a region are present but before the
> final values are send to the HMAT handling code cached access_coordinate
> targets.
> 
> The original perf calculation path was kept to calculate the latency
> performance data that does not require the shared link consideration.
> The shared upstream link calculation is done as a second pass when all
> the endpoints have arrived.
> 
> Testing is done via qemu with CXL hierachy. run_qemu[1] is modified to
> support several CXL hierachy layouts. The following layouts are tested:
> 
> HB: Host Bridge
> RP: Root Port
> SW: Switch
> EP: End Point
> 
> 2 HB 2 RP 2 EP: resulting bandwidth: 624
> 1 HB 2 RP 2 EP: resulting bandwidth: 624
> 2 HB 2 RP 2 SW 4 EP: resulting bandwidth: 624
> 
> Current testing, perf number from SRAT/HMAT is hacked into the kernel
> code. However with new QEMU support of Generic Target Port that's
> incoming, the perf data injection is no longer needed.
> 
> [1]: https://github.com/pmem/run_qemu
> 
> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Link: https://lore.kernel.org/linux-cxl/20240501152503.00002e60@Huawei.com/
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v7:
> - Add test notes in commit log. (Dan)
> - Move cxl_memdev_get_dpa_perf() to cxled_memdev_get_dpa_perf(). (Dan)
> - Add a DEFINE_FREE(free_perf_xa). (Dan)
> - Address 2hb2rp2ep issue Jonathan reported. (Jonathan)
> - Added more kdoc comment headers. (Dan)

Looks like potential kdocs are not annotated w /** 


> - Rename helper functions to be more clear on what they do. (Dan)
> - Move activiation point to after cxl_region_setup_targets(). (Dan)
> ---

snip

> +/*
> + * cxl_region_shared_upstream_perf_update - Recalculate the bandwidth for the region
> + * @cxl_region: the cxl region to recalculate
> + *
> + * The function walks the topology from bottom up and calculates the bandwidth. It
> + * starts at the endpoints, processes at the switches if any, processes at the rootport
> + * level, at the host bridge level, and finally aggregates at the region.
> + */
> +void cxl_region_shared_upstream_bandwidth_update(struct cxl_region *cxlr)
> +{
> +	struct xarray *usp_xa, *working_xa;
> +	int root_count = 0;
> +	bool is_root;
> +	int rc;
> +
> +	lockdep_assert_held(&cxl_dpa_rwsem);
> +
> +	usp_xa = kzalloc(sizeof(*usp_xa), GFP_KERNEL);
> +	if (!usp_xa)
>  		return;
> +
> +	xa_init(usp_xa);
> +
> +	/* Collect bandwidth data from all the endpoints. */
> +	for (int i = 0; i < cxlr->params.nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled = cxlr->params.targets[i];
> +
> +		is_root = false;
> +		rc = cxl_endpoint_gather_bandwidth(cxlr, cxled, usp_xa, &is_root);
> +		if (rc) {
> +			free_perf_xa(usp_xa);
> +			return;
> +		}
> +		root_count += is_root;
>  	}
>  
> +	/* Detect asymmetric hierachy with some direct attached endpoints. */
> +	if (root_count && root_count != cxlr->params.nr_targets) {
> +		dev_dbg(&cxlr->dev,
> +			"Asymmetric hierachy detected, bandwidth not updated\n");
> +		return;
> +	}
> +
> +	/*
> +	 * Walk up one or more switches to deal with the bandwidth of the
> +	 * switches if they exist. Endpoints directly attached to RPs skip
> +	 * over this part.
> +	 */
> +	if (!root_count) {
> +		do {
> +			working_xa = cxl_switch_gather_bandwidth(cxlr, usp_xa,
> +								 &is_root);
> +			if (IS_ERR(working_xa))
> +				goto out;
> +			free_perf_xa(usp_xa);
> +			usp_xa = working_xa;
> +		} while (!is_root);
> +	}
> +
> +	/* Handle the bandwidth at the root port of the hierachy */
> +	working_xa = cxl_rp_gather_bandwidth(usp_xa);
> +	if (rc)
> +		goto out;
> +	free_perf_xa(usp_xa);

I was going to say something about getting rid of the goto's
and just freeing and returning in line like was done ~36 lines
above..but then realize something went astray here in the code
movement.  Here and below, rc isn't set.


> +	usp_xa = working_xa;
> +
> +	/* Handle the bandwidth at the host bridge of the hierachy */
> +	working_xa = cxl_hb_gather_bandwidth(usp_xa);
> +	if (rc)
> +		goto out;
> +	free_perf_xa(usp_xa);
> +	usp_xa = working_xa;
> +
> +	/*
> +	 * Aggregate all the bandwidth collected per CFMWS (ACPI0017) and
> +	 * update the region bandwidth with the final calculated values.
> +	 */
> +	cxl_region_update_bandwidth(cxlr, usp_xa);
> +
> +out:
> +	free_perf_xa(usp_xa);
> +}

snip

> 
> 
