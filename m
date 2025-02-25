Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2F817C98
	for <linux-cxl@vger.kernel.org>; Tue, 25 Feb 2025 00:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740444086; cv=none; b=iQZEd7eD671kU1B5vCGD/H3VBm+DHnhNrNgNfYDzWu6firGdht5yfDvEZG2ZoEHnrox4qaCwMo8BkuftcUqNPpYgPjL6B2kDvZyhwv2Y9SW/HNpN32788YSOiKxAGv/LYAAzbNuuDUKhKRkEMF/QIO7Q5IXqM7UyGlU/CSMb8Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740444086; c=relaxed/simple;
	bh=HAzZenQmNGHU3DzTfoQgaiL+hA0/jgiB8uYhYSSxTQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kIpb4qNxg7oTHS199VjToJyJnX7PYbpugmumf9PpGLzReeDjvgp8gNar076+Mt0pzJuoBBC6taeEJ/rB2jnl9G2OQaKCCspezoWcDcIbJfUZBIx+nRg7tIcl4qBcynebJjzsRunKT49dA1Yz88Bl8RpLhTko0/9tta8hrVmrT3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BM9uZpZk; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BM9uZpZk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740444084; x=1771980084;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HAzZenQmNGHU3DzTfoQgaiL+hA0/jgiB8uYhYSSxTQU=;
  b=BM9uZpZkb2qxmbwQ0E8/czWJfjoWwTNYOYiXgthrFafJxJn7PRfZOEwG
   JYPtDKwEJOyLWO4XX8UeSVBQF8TK9sAx9TcrzYTDXugYFB1yH0H2p0d3l
   C1fJAb2pbYjx8nZvJOafW8K4TxRnt0gfwILCeCK1qyMI5p/Sex/hJ2bMb
   3deILTyTafKg29L8mZOIY1nmvtR/fa6qbSY56MBRmAP6EENNttAt9xYNf
   AWdRMYCGAdQBNwkKj27v7B+taNzWUZ12Wn4Dj9nXcnub53voCVhL50FiS
   Vxh8xw9i6T5FVqIWX9kVicEDC9Eju4xIDnGGOTAIqWIwauqKFQQtsNNEf
   A==;
X-CSE-ConnectionGUID: 27Jp1EUaSpicXBSntnYfeg==
X-CSE-MsgGUID: FxPubV8rQdushoUuiwSPqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41433571"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41433571"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 16:41:24 -0800
X-CSE-ConnectionGUID: trVZltMqTs6zMSHo3vV+Wg==
X-CSE-MsgGUID: aNuTg5+CQ/yUpJ3L7OgV7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="115990097"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.111.114]) ([10.125.111.114])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 16:41:23 -0800
Message-ID: <010e16c3-0f90-41b0-8939-4cc8cb26de7a@intel.com>
Date: Mon, 24 Feb 2025 17:41:20 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Allow 6 & 12 way regions on 3-way HB
 interleaves
To: alison.schofield@intel.com, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <20250224235817.2259508-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250224235817.2259508-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/24/25 4:58 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> The CXL driver requires the granularity of a region and it's root

s/it's/its/

> decoder to be the same. This is particularly restrictive for 3-way
> host bridge interleaves where the only spec defined interleave
> configurations for creating 6-way and 12-way regions on a 3-way HB
configuration?
> interleave require mixed granularities.
requries?

> 
> CXL 3.1 Specification 9.13.1.1:

May as well go to 3.2

> Legal Interleaving Configurations: 12-way, 6-way, and 3-way
> 
> Adding support for these new interleaves touches these areas:
> 
> 1) User created regions employing "cxl create-region" fail when the
> ndctl tool gets a mixed granularity request. That is addressed in
s/ndctl/CXL CLI/

> a patch to the ndctl tool.
> 
> 2) User created regions employing sysfs directly fail at the sysfs
> store of the non-matching region granularity. That restriction is
> lifted here. Note that the driver immediately allows any reasonable
> 3-way HB granularity, but the region config may still fail later
> if the ways/gran between region and root decoder are incompatible.
> 
> 3) Auto created regions, in which the drivers role is to reflect
> the BIOS created region and provide RAS support, basically sneak on
> by. The driver ignores the root decoders granularity and assumes it
> is the same as the regions. The impact being that endpoint devices
> appear out of order and DPA to HPA address translations that depend
> on that order are invalid. Here the driver stops making that same
> granularity assumption and checks for an allowable granularity.
> 
> A new helper, interleave_granularity_allow(), is used in both the
> user and auto creation path to allow the newly supported configs.
> 
> Another new helper, gran_multiple(), is used in sorting, target
> list searching, and distance calculations, supporting the new
> root granularity to region granularity multiples.
> 
> And, as noted in 2), there's an added check to see if the
> selected sysfs ways/gran make sense when considered together.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 101 +++++++++++++++++++++++++++++++-------
>  1 file changed, 82 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3cb91cf0e2dd..9d4716b7fcf8 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -532,6 +532,31 @@ static ssize_t interleave_granularity_show(struct device *dev,
>  	return rc;
>  }
>  
> +static bool interleave_granularity_allow(struct cxl_decoder *cxld, u16 ig)
> +{
> +	/*
> +	 * When the host-bridge is interleaved, disallow region granularity
> +	 * != root granularity with the exception of 3-way HB interleaves.
> +	 * Allow the CXL Spec defined 3-way HB interleaves that can only be
> +	 * configured when host-bridge interleave is greater that the
> +	 * region interleave. (CXL 3.1 Specification 9.13.1.1)
spec 3.2

> +	 * Allow 2+2+2 interleave where HB gran is 2 * region granularity
> +	 *	 4+4+4 interleave where HB gran is 4 * region granularity
> +	 *
> +	 * Regions with a granularity greater than the root interleave result
> +	 * in invalid DPA translations (invalid to support).
> +	 */
> +	if (cxld->interleave_ways > 1 && ig != cxld->interleave_granularity) {
> +		if (cxld->interleave_ways != 3)
> +			return false;
> +
> +		if (cxld->interleave_granularity % (2 * ig) &&
> +		    cxld->interleave_granularity % (4 * ig))
> +			return false;

Can you please explain how the math works here? I'm not understanding the code here vs the comments above.

DJ

> +	}
> +	return true;
> +}
> +
>  static ssize_t interleave_granularity_store(struct device *dev,
>  					    struct device_attribute *attr,
>  					    const char *buf, size_t len)
> @@ -551,15 +576,7 @@ static ssize_t interleave_granularity_store(struct device *dev,
>  	if (rc)
>  		return rc;
>  
> -	/*
> -	 * When the host-bridge is interleaved, disallow region granularity !=
> -	 * root granularity. Regions with a granularity less than the root
> -	 * interleave result in needing multiple endpoints to support a single
> -	 * slot in the interleave (possible to support in the future). Regions
> -	 * with a granularity greater than the root interleave result in invalid
> -	 * DPA translations (invalid to support).
> -	 */
> -	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
> +	if (!interleave_granularity_allow(cxld, val))
>  		return -EINVAL;
>  
>  	rc = down_write_killable(&cxl_region_rwsem);
> @@ -1290,6 +1307,23 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
>  	return 0;
>  }
>  
> +static int gran_multiple(struct cxl_region *cxlr)
> +{
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	int root_decoder_gran = cxlrd->cxlsd.cxld.interleave_granularity;
> +	int region_gran = cxlr->params.interleave_granularity;
> +
> +	/*
> +	 * In regions built upon 3-way HB interleaves, the root decoder
> +	 * granularity can be a multiple of the region granularity. The
> +	 * multiple value is used in sorting and distance calculations.
> +	 */
> +	if (cxlrd->cxlsd.cxld.interleave_ways != 3 || !root_decoder_gran)
> +		return 1;
> +
> +	return root_decoder_gran / region_gran;
> +}
> +
>  static int cxl_port_setup_targets(struct cxl_port *port,
>  				  struct cxl_region *cxlr,
>  				  struct cxl_endpoint_decoder *cxled)
> @@ -1321,6 +1355,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	cxlsd = to_cxl_switch_decoder(&cxld->dev);
>  	if (cxl_rr->nr_targets_set) {
>  		int i, distance = 1;
> +		int multiple = gran_multiple(cxlr);
>  		struct cxl_region_ref *cxl_rr_iter;
>  
>  		/*
> @@ -1332,12 +1367,17 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		 * always 1 as every index targets a different host-bridge. At
>  		 * each subsequent switch level those ports map every Nth region
>  		 * position where N is the width of the switch == distance.
> +		 *
> +		 * With the introduction of mixed granularities in 3-way HB
> +		 * interleaves, divide N by a multiple that represents the root
> +		 * decoder to region granularity.
>  		 */
>  		do {
>  			cxl_rr_iter = cxl_rr_load(iter, cxlr);
>  			distance *= cxl_rr_iter->nr_targets;
>  			iter = to_cxl_port(iter->dev.parent);
>  		} while (!is_cxl_root(iter));
> +		distance /= multiple;
>  		distance *= cxlrd->cxlsd.cxld.interleave_ways;
>  
>  		for (i = 0; i < cxl_rr->nr_targets_set; i++)
> @@ -1354,12 +1394,9 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	if (is_cxl_root(parent_port)) {
>  		/*
>  		 * Root decoder IG is always set to value in CFMWS which
> -		 * may be different than this region's IG.  We can use the
> -		 * region's IG here since interleave_granularity_store()
> -		 * does not allow interleaved host-bridges with
> -		 * root IG != region IG.
> +		 * may be different than this region's IG.
>  		 */
> -		parent_ig = p->interleave_granularity;
> +		parent_ig = cxlrd->cxlsd.cxld.interleave_granularity;
>  		parent_iw = cxlrd->cxlsd.cxld.interleave_ways;
>  		/*
>  		 * For purposes of address bit routing, use power-of-2 math for
> @@ -1431,7 +1468,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  		if (cxld->interleave_ways != iw ||
> -		    cxld->interleave_granularity != ig ||
> +		    !interleave_granularity_allow(cxld, ig) ||
>  		    cxld->hpa_range.start != p->res->start ||
>  		    cxld->hpa_range.end != p->res->end ||
>  		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
> @@ -1661,11 +1698,12 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
>  	struct cxl_decoder *cxld = &cxlsd->cxld;
> +	int multiple = gran_multiple(cxlr);
>  	int iw = cxld->interleave_ways;
>  	struct cxl_port *iter;
>  	int rc;
>  
> -	if (dport != cxlrd->cxlsd.target[pos % iw]) {
> +	if (dport != cxlrd->cxlsd.target[pos / multiple % iw]) {
>  		dev_dbg(&cxlr->dev, "%s:%s invalid target position for %s\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>  			dev_name(&cxlrd->cxlsd.cxld.dev));
> @@ -1809,7 +1847,8 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>   * Return: position >= 0 on success
>   *	   -ENXIO on failure
>   */
> -static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
> +static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
> +				   int multiple)
>  {
>  	struct cxl_port *iter, *port = cxled_to_port(cxled);
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> @@ -1855,6 +1894,11 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
>  		if (rc)
>  			return rc;
>  
> +		if (multiple > 1 && is_cxl_root(next_port(iter))) {
> +			pos = pos + multiple * parent_pos;
> +			break;
> +		}
> +
>  		pos = pos * parent_ways + parent_pos;
>  	}
>  
> @@ -1869,12 +1913,13 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
>  static int cxl_region_sort_targets(struct cxl_region *cxlr)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
> +	int multiple = gran_multiple(cxlr);
>  	int i, rc = 0;
>  
>  	for (i = 0; i < p->nr_targets; i++) {
>  		struct cxl_endpoint_decoder *cxled = p->targets[i];
>  
> -		cxled->pos = cxl_calc_interleave_pos(cxled);
> +		cxled->pos = cxl_calc_interleave_pos(cxled, multiple);
>  		/*
>  		 * Record that sorting failed, but still continue to calc
>  		 * cxled->pos so that follow-on code paths can reliably
> @@ -1902,6 +1947,23 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	struct cxl_dport *dport;
>  	int rc = -ENXIO;
>  
> +	/*
> +	 * Protect against improper gran mixes on 3-way HB interleave
> +	 * Expect decoder gran*ways == region gran*ways
> +	 */
> +	if (cxlrd->cxlsd.cxld.interleave_ways == 3) {
> +		if ((cxlrd->cxlsd.cxld.interleave_granularity * 3) !=
> +		    (p->interleave_ways * p->interleave_granularity)) {
> +			dev_dbg(&cxlr->dev,
> +				"invalid config region:%d/%d decoder %d/%d\n",
> +				p->interleave_ways, p->interleave_granularity,
> +				cxlrd->cxlsd.cxld.interleave_ways,
> +				cxlrd->cxlsd.cxld.interleave_granularity);
> +
> +			return rc;
> +		}
> +	}
> +
>  	rc = check_interleave_cap(&cxled->cxld, p->interleave_ways,
>  				  p->interleave_granularity);
>  	if (rc) {
> @@ -2055,9 +2117,10 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	 */
>  	for (int i = 0; i < p->nr_targets; i++) {
>  		struct cxl_endpoint_decoder *cxled = p->targets[i];
> +		int multiple = gran_multiple(cxlr);
>  		int test_pos;
>  
> -		test_pos = cxl_calc_interleave_pos(cxled);
> +		test_pos = cxl_calc_interleave_pos(cxled, multiple);
>  		dev_dbg(&cxled->cxld.dev,
>  			"Test cxl_calc_interleave_pos(): %s test_pos:%d cxled->pos:%d\n",
>  			(test_pos == cxled->pos) ? "success" : "fail",
> 
> base-commit: 2bb67004903cfd35710750654669a77e7223fcd1

