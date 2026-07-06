Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ABF2DCC13;
	Mon,  6 Jul 2026 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357266; cv=none; b=m95xjdhy9WRfgkoHiAnOKBmgANJUYAN7G/aMzFh9jiKZSCWDv+w6Q5zEYje/uz8rosdv/UHntjC8juDMGfw9B16mnPsCrjUjtCmx8IpBKKzu2bjFnKd+7u5hKqIg11K7voUelR5ur+05iqlfoER90ThVmyefBooGVIaSz43tq+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357266; c=relaxed/simple;
	bh=0WgX0U3+VYwySnqyl/KCozc+PFerWsZw/MwgyWCU448=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PaCTOMn1Mf+H37lPhphkU774GSpDBKzAaeCtT79mApVOcOkQQyH50+bOFsO2YH2BH0FskEgjQm06fKy3aF9qLEmDxnbRsgFPfeBS3goKCPBc1AUSWLii3Zv8SlFP74Hd9As3lSbD4KL2z29TphGtcQChjMuv8JQaSdWSyyN71OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oG6UXL+U; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oG6UXL+U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783357264; x=1814893264;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0WgX0U3+VYwySnqyl/KCozc+PFerWsZw/MwgyWCU448=;
  b=oG6UXL+UYeXjHIIaUfT7QTsnOExPh22HNNaQgS3ih+KrzYVlLZlvOS1f
   bq+zu4GpRYAiPP15ZoCR8LGRtwjdAr1hEVkHCFUzJzxvTxZ+bErpn8ywG
   hYLOeNSY9VabhDcwC1+iz4h1VzkL4eBaO0iqjskYwuO9kdDrAuYY13EM5
   9rIwI7S4JIxLuxsTUsx/veGRS7NmlIAO0Tlj6v4RTTGCekJc+LtFMdd/e
   JKn6OK6HyVEEuGCKO2Naa9HVo6cl1vx8lKyH5Ravikce3OeSMyO973bwy
   U5DY7bwT7e/H05daC0C/Ji2FL2mUxZzhLvr2BAfmCFHgT4OCCvHJlNrly
   g==;
X-CSE-ConnectionGUID: Sg0VSCiqSVWbG3vhf5owPw==
X-CSE-MsgGUID: LypikOy0QN+f393yn/UAQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="71518263"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="71518263"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 10:01:03 -0700
X-CSE-ConnectionGUID: KuEWXTrYRQ6WKZfobhSTAQ==
X-CSE-MsgGUID: 5MrYNdheQ26HhXnVL2HKiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="258677586"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.110.202]) ([10.125.110.202])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 10:01:01 -0700
Message-ID: <c6fa720a-6ee3-46c8-9c6f-dc57f802059d@intel.com>
Date: Mon, 6 Jul 2026 10:01:00 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] tools/testing/cxl: Enable zero sized decoders
 under hb0
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org,
 danwilliams@nvidia.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, kobak@nvidia.com,
 kaihengf@nvidia.com, kees@kernel.org, newtonl@nvidia.com,
 kristinc@nvidia.com, mochs@nvidia.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vishal Aslot <vaslot@nvidia.com>
References: <20260625092857.41139-1-icheng@nvidia.com>
 <20260625092857.41139-3-icheng@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260625092857.41139-3-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/25/26 2:28 AM, Richard Cheng wrote:
> The kernel now allows committed zero-size HDM decoders so BIOS can lock
> empty decoders; cxl_test needs to exercise that path.
> 
> Add a mock_zero_size_decoders module parameter (default off). When set,
> the special endpoints under host-bridge0 (cxl_mem.0 and cxl_mem.4)
> commit decoders 1 and 2 as zero-size + locked above the decoder[0]
> auto-region, mirrored on the parent switch and host bridge. The mocks
> take a real zero-size DPA reservation, like enumeration of real
> hardware, so commit_end lands on a zero-size decoder and the
> reservation, poison-by-endpoint, and teardown paths all run.
> 
> Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>

You may want to rebase against for-7.3/cxl-type2-test branch to pick up the module param checks.

DJ

> ---
> v5->v6:
>      - Reword a mock comment, no functional change.
> v4->v5:
>       - Mirror the v5 core semantics: mock zero-size decoders take a real
>         zero-size DPA reservation via devm_cxl_dpa_reserve() so
>         dpa_res/hdm_end/cxled->part match real hardware enumeration and
>         the poison-by-endpoint walk reaches commit_end.
>       - Set cxled->state = CXL_DECODER_STATE_AUTO to match
>         init_hdm_decoder()'s fall-through (undoes the v2 switch to
>         MANUAL).
>       - cxld_registry_restore(): reserve unconditionally for enabled
>         endpoint decoders; enabled now implies reserved, sized or not.
> 
> v3->v4:
>      - No change.
> 
> v2->v3:
>       - Gate the zero-size + locked decoder injection behind a new
>         mock_zero_size_decoders module parameter (default off). v2
>         applied it unconditionally on the host-bridge0 auto-region
>         endpoints, which the region test suite reuses, regressing 7 of
>         17 cxl unit tests; defaulting off leaves the shared topology
>         untouched.
> 
> v1->v2:
>       - Replace second_decoder(), third_decoder() with a single
>         match_decoder_by_index() helper, so all lookups share one
>         matcher.
>       - Use DEFINE_RANGE() for the empty range instead of an open-coded
>         struct.
>       - Set cxled->state = CXL_DECODER_STATE_MANUAL rather than
>         STATE_AUTO.
>       - Set CXL_DECODER_F_LOCK on the mock zero-size decoders to model
>         the BIOS-burns-slots case.
> ---
>  tools/testing/cxl/test/cxl.c | 100 ++++++++++++++++++++++++++++++-----
>  1 file changed, 86 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 418669927fb0..117691b3c62f 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -17,6 +17,7 @@
>  static int interleave_arithmetic;
>  static bool extended_linear_cache;
>  static bool fail_autoassemble;
> +static bool mock_zero_size_decoders;
>  
>  #define FAKE_QTG_ID	42
>  
> @@ -841,14 +842,13 @@ static int cxld_registry_restore(struct cxl_decoder *cxld,
>  		cxld_copy(cxld, &td->cxled.cxld);
>  		cxled->state = td->cxled.state;
>  		cxled->skip = td->cxled.skip;
> -		if (range_len(&td->dpa_range)) {
> -			rc = devm_cxl_dpa_reserve(cxled, td->dpa_range.start,
> -						  range_len(&td->dpa_range),
> -						  td->cxled.skip);
> -			if (rc) {
> -				init_disabled_mock_decoder(cxld);
> -				return rc;
> -			}
> +		/* enabled endpoint decoders hold a reservation, sized or not */
> +		rc = devm_cxl_dpa_reserve(cxled, td->dpa_range.start,
> +					  range_len(&td->dpa_range),
> +					  td->cxled.skip);
> +		if (rc) {
> +			init_disabled_mock_decoder(cxld);
> +			return rc;
>  		}
>  		port->commit_end = cxld->id;
>  	}
> @@ -1041,16 +1041,49 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
>  	WARN_ON_ONCE(!cxld_registry_new(cxld));
>  }
>  
> -static int first_decoder(struct device *dev, const void *data)
> +static int match_decoder_by_index(struct device *dev, const void *data)
>  {
> +	int target_id = *(const int *)data;
>  	struct cxl_decoder *cxld;
>  
>  	if (!is_switch_decoder(dev))
>  		return 0;
>  	cxld = to_cxl_decoder(dev);
> -	if (cxld->id == 0)
> -		return 1;
> -	return 0;
> +	return cxld->id == target_id;
> +}
> +
> +/*
> + * Mock a committed, locked, empty decoder
> + * (CXL r4.0 8.2.4.20.12). Gated by the mock_zero_size_decoders module
> + * param so the default cxl_test topology, shared by the region test
> + * suite, is left undisturbed.
> + */
> +static void size_zero_mock_decoder_ep(struct cxl_decoder *cxld, u64 base)
> +{
> +	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(&cxld->dev);
> +
> +	cxld->hpa_range = DEFINE_RANGE(base, base - 1);
> +	cxld->interleave_ways = 2;
> +	cxld->interleave_granularity = 4096;
> +	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> +	cxld->flags = CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
> +	cxled->state = CXL_DECODER_STATE_AUTO;
> +	/* decoder[0] reserved [0, size/2), empty decoders sit at that watermark */
> +	devm_cxl_dpa_reserve(cxled, mock_auto_region_size / 2, 0, 0);
> +	cxld->commit = mock_decoder_commit;
> +	cxld->reset = mock_decoder_reset;
> +}
> +
> +static void size_zero_mock_decoder_sw(struct cxl_decoder *cxld, u64 base,
> +				      int level)
> +{
> +	cxld->flags = CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
> +	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> +	cxld->interleave_ways = level == 0 ? 2 : 1;
> +	cxld->interleave_granularity = 4096;
> +	cxld->hpa_range = DEFINE_RANGE(base, base - 1);
> +	cxld->commit = mock_decoder_commit;
> +	cxld->reset = mock_decoder_reset;
>  }
>  
>  /*
> @@ -1131,7 +1164,7 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  	 * See 'cxl list -BMPu -m cxl_mem.0,cxl_mem.4'
>  	 */
>  	if (!is_endpoint_decoder(&cxld->dev) || !hb0 || pdev->id % 4 ||
> -	    pdev->id > 4 || cxld->id > 0) {
> +	    pdev->id > 4 || cxld->id > (mock_zero_size_decoders ? 2 : 0)) {
>  		default_mock_decoder(cxld);
>  		return false;
>  	}
> @@ -1145,6 +1178,20 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  	base = window->base_hpa;
>  	if (extended_linear_cache)
>  		base += mock_auto_region_size;
> +
> +	/*
> +	 * With mock_zero_size_decoders, decoders 1 and 2 of the special
> +	 * endpoints mock committed, locked, empty decoders above the
> +	 * decoder[0] auto-region (CXL r4.0 8.2.4.20.12). commit_end then
> +	 * points at a zero-size decoder, exercising the zero-size
> +	 * reservation and poison-by-endpoint code paths.
> +	 */
> +	if (cxld->id == 1 || cxld->id == 2) {
> +		size_zero_mock_decoder_ep(cxld, base);
> +		port->commit_end = cxld->id;
> +		WARN_ON_ONCE(!cxld_registry_new(cxld));
> +		return false;
> +	}
>  	cxld->hpa_range = (struct range) {
>  		.start = base,
>  		.end = base + mock_auto_region_size - 1,
> @@ -1168,9 +1215,11 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  	 */
>  	iter = port;
>  	for (i = 0; i < 2; i++) {
> +		int id = 0;
> +
>  		dport = iter->parent_dport;
>  		iter = dport->port;
> -		dev = device_find_child(&iter->dev, NULL, first_decoder);
> +		dev = device_find_child(&iter->dev, &id, match_decoder_by_index);
>  		/*
>  		 * Ancestor ports are guaranteed to be enumerated before
>  		 * @port, and all ports have at least one decoder.
> @@ -1214,6 +1263,26 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  
>  		cxld_registry_update(cxld);
>  		put_device(dev);
> +
> +		if (!mock_zero_size_decoders)
> +			continue;
> +
> +		/*
> +		 * Mirror the endpoint: commit the next two switch decoders
> +		 * as zero-size + locked so the empty-decoder layout extends
> +		 * end-to-end through the switch and host bridge.
> +		 */
> +		for (id = 1; id <= 2; id++) {
> +			dev = device_find_child(&iter->dev, &id,
> +						match_decoder_by_index);
> +			if (WARN_ON(!dev))
> +				continue;
> +			cxld = to_cxl_decoder(dev);
> +			size_zero_mock_decoder_sw(cxld, base, i);
> +			iter->commit_end = id;
> +			cxld_registry_update(cxld);
> +			put_device(dev);
> +		}
>  	}
>  
>  	return false;
> @@ -2049,6 +2118,9 @@ module_param(extended_linear_cache, bool, 0444);
>  MODULE_PARM_DESC(extended_linear_cache, "Enable extended linear cache support");
>  module_param(fail_autoassemble, bool, 0444);
>  MODULE_PARM_DESC(fail_autoassemble, "Simulate missing member of an auto-region");
> +module_param(mock_zero_size_decoders, bool, 0444);
> +MODULE_PARM_DESC(mock_zero_size_decoders,
> +		 "Mock committed, locked, empty decoders under host-bridge0");
>  module_init(cxl_test_init);
>  module_exit(cxl_test_exit);
>  MODULE_LICENSE("GPL v2");

