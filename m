Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B64279359;
	Mon, 15 Sep 2025 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954111; cv=none; b=lQu4IlZl/FEreitC+LFVRwX39LrRqqC2cVYuR84TQyBaiKSbceBsm5Vepw0nQjQh+UkrbBGmZQ8VvbDuwpNpRgdJPh7z2APoihEs4xVjWIwo5fhWPG54yWQVINgmxbaKFNuP/KJjcitWbqqz4dFR/8OCzidCZEjMXY7bmYNa05Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954111; c=relaxed/simple;
	bh=379MXxVX0CY81GJIFx/jgRPRbnaC6b2v+kI5DOyRhAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q+YYn+bN3sWvleJMPDg+CUOSgC11dORs1PD9fGjuQsYzWcMG1sfrAvQBwOJl+bzWUCZyiMdYAXaPBB21lrNa5UyTocSYzU6gobJzX+a7xkX4nFhWE/E75AxvkiOqy6rAgd6HjIhURH+phPSnWXISYzaiadcKX8Zap2yzz0gs1Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k0zz2Jp0; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k0zz2Jp0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757954109; x=1789490109;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=379MXxVX0CY81GJIFx/jgRPRbnaC6b2v+kI5DOyRhAU=;
  b=k0zz2Jp0gZjBouXY10vlHOYIsOHKOSpsaxzyHZ24piDgR9PShAVkq9nM
   jn1kAU+9q3vCLpevB0RrpGrdBhQUd3tMlwyp0qT9uGVZJIdHdZeEGQE5C
   oHLjD78YvS6w46d2Aq8beO9UpgwHb3oHSFrf7s5dvHHj1MvxRLNZkVjdB
   3Me1ZSq6S6NaHjkcJrD16+M3cgYr84AQjip+MVezi6r5dMS82vwkMZZ7N
   p4VRdF4EjaFLHRTN7/uLCwBiKVIFP2dXfMBwffKHZCMOwozfRL0FqpwnU
   stwsQZYzjwxQFMBcJL9Fw+KLs2J9XdSE2kUzPKk+kL20WU+2RbKb4T/CD
   Q==;
X-CSE-ConnectionGUID: Mn9BSvs5QD+qccqYBbduWg==
X-CSE-MsgGUID: m99XZF15Sc+c5ayMiXCEUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="62850530"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="62850530"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 09:35:09 -0700
X-CSE-ConnectionGUID: ozMxnKSnQNOpuROb4JRy+w==
X-CSE-MsgGUID: XatX7gQQRIOfePPtYR0Qxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="173822208"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.111.129]) ([10.125.111.129])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 09:35:08 -0700
Message-ID: <ce199a30-b898-45c6-9122-db1b25ffd98a@intel.com>
Date: Mon, 15 Sep 2025 09:35:07 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/11] cxl/region: Implement endpoint decoder address
 translation
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-9-rrichter@amd.com>
 <20250915114614.000053f1@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250915114614.000053f1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/15/25 3:46 AM, Jonathan Cameron wrote:
> On Fri, 12 Sep 2025 16:45:10 +0200
> Robert Richter <rrichter@amd.com> wrote:
> 
>> Systems that need address translation have the endpoint decoders
>> programmed for a different address space. Host physical addresses
>> (HPA) are different from their system physical addresses (SPA). The
>> decoder's address range and interleaving configuration of such
>> endpoints cannot be used to determine the region parameters. The
>> region's address range must be SPA which the decoder does not
>> provide. In addition, an endpoint's incoming HPA is already converted
>> to the devices physical address (DPA). Thus it has interleaving
>> disabled.
>>
>> Address translation may provide different ways to determine an
>> endpoint's SPA, e.g. it may support a firmware call. This allows the
>> determination of the region's parameters without inspecting the
>> endpoint decoders.
>>
>> Implement the setup of address translation given there is a function
>> to convert an endpoint's HPA (which is identical to its DPA) to an
>> SPA. Use the previously introduced cxl_to_hpa_fn callback for this.
>> Convert the decoder's address range and ensure it is 256MB aligned.
>>
>> Identify the region's interleaving ways by inspecting the address
>> ranges. Also determine the interleaving granularity using the address
>> translation callback. Note that the position of the chunk from one
>> interleaving block to the next may vary and thus cannot be considered
>> constant. Address offsets larger than the interleaving block size
>> cannot be used to calculate the granularity. Thus, probe the
>> granularity using address translation for various HPAs in the same
>> interleaving block.
>>
>> Note that this patch does not yet enable address translation as
>> callbacks have not been initialized.
>>
>> Signed-off-by: Robert Richter <rrichter@amd.com>
>> ---
>>  drivers/cxl/core/region.c | 95 ++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 94 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 57697504410b..9fb1e9508213 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3422,16 +3422,109 @@ struct cxl_region_context {
>>  	int interleave_granularity;
>>  };
>>  
>> +static int setup_address_translation(struct cxl_endpoint_decoder *cxled,
>> +				     struct cxl_region_context *ctx)
>> +{
>> +	struct cxl_port *port = to_cxl_port(cxled->cxld.dev.parent->parent);
> 
> When there is a parent->parent it always makes me nervous that I haven't
> reasoned out what port this actually is. A comment would help or
> a more specific macro where the name lets us know what we are getting.

I was also going to suggest that name 'port' to 'parent_port' as well to make it clear what it is.

DJ

> 
>> +	struct cxl_decoder *cxld = &cxled->cxld;
>> +	struct range range = ctx->hpa_range;
>> +	u64 spa_len, len = range_len(&range);
>> +	u64 addr, base = range.start;
>> +	int ways, gran;
>> +
>> +	if (!len || !port->to_hpa)
>> +		return 0;
>> +
>> +	if (!IS_ALIGNED(range.start, SZ_256M) ||
>> +	    !IS_ALIGNED(range.end + 1, SZ_256M)) {
>> +		dev_warn(&port->dev,
>> +			"CXL address translation: Unaligned decoder HPA range: %#llx-%#llx(%s)\n",
>> +			range.start, range.end, dev_name(&cxld->dev));
>> +		return -ENXIO;
>> +	}
>> +
>> +	/* Translate HPA range to SPA. */
>> +	range.start = port->to_hpa(cxld, range.start);
> 
> This is where the generic naming as 'range' gets really confusing.
> hpa_range etc with separate struct range for each would definitely help
> 
> For the checks and inputs maybe just use ctx->hpa_range directly.
> 
> 
>> +	range.end = port->to_hpa(cxld, range.end);
> Perhaps use the DEFINE_RANGE macro or 
> 	range = (struct range) {
> 		.start = ...
> style as per earlier patches.
> 
>> +
>> +	if (range.start == ULLONG_MAX || range.end == ULLONG_MAX) {
>> +		dev_warn(&port->dev,
>> +			"CXL address translation: Failed to translate HPA range: %#llx-%#llx:%#llx-%#llx(%s)\n",
>> +			range.start, range.end, ctx->hpa_range.start,
>> +			ctx->hpa_range.end, dev_name(&cxld->dev));
>> +		return -ENXIO;
>> +	}
>> +
>> +	/*
>> +	 * Since translated addresses include the interleaving
>> +	 * offsets, align the range to 256 MB.
> 
> So we pass in an HPA range without interleaving offsets and get back
> one with them?  Is that unavoidable, or can we potentially push
> this bit into the callback?  Probably with separate callbacks to
> get the interleave details.
> 
> Overall I'm not really following what is going on here.  Maybe
> some ascii art would help?
> 
>> +	 */
>> +	range.start = ALIGN_DOWN(range.start, SZ_256M);
>> +	range.end = ALIGN(range.end, SZ_256M) - 1;
>> +
>> +	spa_len = range_len(&range);
>> +	if (!len || !spa_len || spa_len % len) {
>> +		dev_warn(&port->dev,
>> +			"CXL address translation: HPA range not contiguous: %#llx-%#llx:%#llx-%#llx(%s)\n",
>> +			range.start, range.end, ctx->hpa_range.start,
>> +			ctx->hpa_range.end, dev_name(&cxld->dev));
>> +		return -ENXIO;
>> +	}
>> +
>> +	ways = spa_len / len;
>> +	gran = SZ_256;
>> +
>> +	/*
>> +	 * Determine interleave granularity
>> +	 *
>> +	 * Note: The position of the chunk from one interleaving block
>> +	 * to the next may vary and thus cannot be considered
>> +	 * constant. Address offsets larger than the interleaving
>> +	 * block size cannot be used to calculate the granularity.
>> +	 */
>> +	while (ways > 1 && gran <= SZ_16M) {
>> +		addr = port->to_hpa(cxld, base + gran);
>> +		if (addr != base + gran)
>> +			break;
>> +		gran <<= 1;
>> +	}
>> +
>> +	if (gran > SZ_16M) {
>> +		dev_warn(&port->dev,
>> +			"CXL address translation: Cannot determine granularity: %#llx-%#llx:%#llx-%#llx(%s)\n",
>> +			range.start, range.end, ctx->hpa_range.start,
>> +			ctx->hpa_range.end, dev_name(&cxld->dev));
>> +		return -ENXIO;
>> +	}
>> +
>> +	ctx->hpa_range = range;
>> +	ctx->interleave_ways = ways;
>> +	ctx->interleave_granularity = gran;
>> +
>> +	dev_dbg(&cxld->dev,
>> +		"address mapping found for %s (hpa -> spa): %#llx+%#llx -> %#llx+%#llx ways:%d granularity:%d\n",
>> +		dev_name(ctx->cxlmd->dev.parent), base, len, range.start,
>> +		spa_len, ways, gran);
>> +
>> +	return 0;
>> +}
>> +
>>  static int setup_region_params(struct cxl_endpoint_decoder *cxled,
>>  			       struct cxl_region_context *ctx)
>>  {
>> +	int rc;
>> +
>>  	ctx->cxled = cxled;
>>  	ctx->cxlmd = cxled_to_memdev(cxled);
>>  	ctx->hpa_range = cxled->cxld.hpa_range;
>>  	ctx->interleave_ways = cxled->cxld.interleave_ways;
>>  	ctx->interleave_granularity = cxled->cxld.interleave_granularity;
>>  
>> -	return 0;
>> +	rc = setup_address_translation(cxled, ctx);
> 
> A quick search suggested nothing new gets added after this. As such
> 	return setup_address_translation(...);
> is probably appropriate here.
> 
> 
>> +	if (rc)
>> +		return rc;
>> +
>> +	return rc;
>>  }
>>  
>>  static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
> 
> 

