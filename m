Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7E83E49E8;
	Tue, 21 Jul 2026 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784650213; cv=none; b=bQqAE1hvPz39S+Vjd/ix4dYe7zk2AtAXdY5sQVt/vDx6BDN/S7YvoZA6h/3MW15AnCkUoKSmBrGXGCaYZTW+4t7Kt4M6oh3mj0WBtNcUrK7C60+zAnCibT64BFCtRyiDSGusdUCg6r9YAxaa4BNcgxklyCfXOnlzhsLA4xXlh90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784650213; c=relaxed/simple;
	bh=KfDNJFkGPORvGzkLusEV55z0XyYmhvYY11H7lDQiISE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYOBDwLt0NgKl9MJYFeCP3x1NYGt8K9smnIoctJmAZa9XKCrhRmMVeOw1KMP9CtF9I/NcFXASejuV9M/DAQmkd+h7bRFCoJcwtDMTRiWW2jIzMK+6HnWuujsKIfdyu0KbbVhECLvV+4/xCyXCQ+XEA78wPknQpSs0D9Hxxl5a88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8RZKd1I; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8RZKd1I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784650211; x=1816186211;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KfDNJFkGPORvGzkLusEV55z0XyYmhvYY11H7lDQiISE=;
  b=n8RZKd1IP0mMQvT8hoWoaY7v+8sUYy5Yb/zekgm+oPafs+30YBJI22ZY
   P8MyCwDkR/3OD7g4zWiXk9Mqu8xxjJyJAPyI2/9Fzk1dol7brOb2lyQsy
   MGIMqCoqubQ0t3ZLfV11jskTvw7o6xQrqeDqFPnPUQb81Wnlr/ygHmWJE
   ozkuT6NmfyoOPzL4F2dnMdq/mVtJSKYSoUAiXQ5iY4O5sH4dj/7IrNVBB
   1eB88ORQESDqTNb81tNjQd32feOVWBf0RMyT4KLXetf6u4AsrMa8GPHS0
   iasaaAR68v6Jg6PX/j/uHVKTy+wNwM97Gab/RI62ced3M8WV7iEA/Uui8
   A==;
X-CSE-ConnectionGUID: QnqccR3QQ3ij/Rst0FKOYA==
X-CSE-MsgGUID: +rJPNq/STbm2n3UV3Q05WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="96621802"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="96621802"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 09:10:10 -0700
X-CSE-ConnectionGUID: uA5JDggMSbqX1HxCjIVHgg==
X-CSE-MsgGUID: nR4zAWVCS4GxakWFQvZT9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="261368303"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.109.244]) ([10.125.109.244])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 09:10:09 -0700
Message-ID: <d6b63f62-0a0a-484b-b8bc-f825fbce2a8f@intel.com>
Date: Tue, 21 Jul 2026 09:10:08 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2 RESEND] tools/testing/cxl: Enable zero sized
 decoders under hb0
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org,
 danwilliams@nvidia.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, newtonl@nvidia.com, kristinc@nvidia.com,
 kaihengf@nvidia.com, kobak@nvidia.com, Vishal Aslot <vaslot@nvidia.com>
References: <20260721085715.39322-1-icheng@nvidia.com>
 <20260721085715.39322-3-icheng@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260721085715.39322-3-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/21/26 1:57 AM, Richard Cheng wrote:
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Changelog:
> 
> v6->v7:
>     - Rebase onto cxl/for-7.3/cxl-type2-test.
> 	- Integrate mock_zero_size_decoders with special-topology parameter
> 	  validation and reject its incompatible use with fail_autoassemble.
> 
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
>  tools/testing/cxl/test/cxl.c | 109 ++++++++++++++++++++++++++++++-----
>  1 file changed, 94 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 8ab2ce1262f3..fff2004a08c8 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -18,6 +18,7 @@ static int interleave_arithmetic;
>  static bool extended_linear_cache;
>  static bool fail_autoassemble;
>  static bool type2_test;
> +static bool mock_zero_size_decoders;
>  
>  #define FAKE_QTG_ID	42
>  
> @@ -872,14 +873,13 @@ static int cxld_registry_restore(struct cxl_decoder *cxld,
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
> @@ -1072,16 +1072,49 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
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
>  enum cxld_init_type {
> @@ -1114,7 +1147,7 @@ static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
>  	 * See 'cxl list -BMPu -m cxl_mem.0,cxl_mem.4'
>  	 */
>  	if (!is_endpoint_decoder(&cxld->dev) || !hb0 || pdev->id % 4 ||
> -	    pdev->id > 4 || cxld->id > 0)
> +	    pdev->id > 4 || cxld->id > (mock_zero_size_decoders ? 2 : 0))
>  		return MOCK_DECODER_INIT_DEFAULT;
>  
>  	return type2_test ? MOCK_DECODER_INIT_TYPE2_AUTO :
> @@ -1147,6 +1180,7 @@ static void mock_init_hdm_type2_cxled(struct cxl_endpoint_decoder *cxled,
>  	struct cxl_port *root_port;
>  	struct device *dev;
>  	u64 base;
> +	int id = 0;
>  
>  	base = window->base_hpa;
>  	cxld->hpa_range = (struct range) {
> @@ -1172,7 +1206,7 @@ static void mock_init_hdm_type2_cxled(struct cxl_endpoint_decoder *cxled,
>  	 */
>  	dport = port->parent_dport;
>  	root_port = dport->port;
> -	dev = device_find_child(&root_port->dev, NULL, first_decoder);
> +	dev = device_find_child(&root_port->dev, &id, match_decoder_by_index);
>  	/*
>  	 * Ancestor ports are guaranteed to be enumerated before
>  	 * @port, and all ports have at least one decoder.
> @@ -1232,6 +1266,20 @@ static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
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
> +		return;
> +	}
>  	cxld->hpa_range = (struct range) {
>  		.start = base,
>  		.end = base + mock_auto_region_size - 1,
> @@ -1255,9 +1303,11 @@ static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
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
> @@ -1307,6 +1357,26 @@ static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
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
>  }
>  
> @@ -2085,6 +2155,12 @@ static bool __init have_multiple_modparms(void)
>  		count++;
>  	if (type2_test)
>  		count++;
> +	if (mock_zero_size_decoders)
> +		count++;
> +
> +	/* Zero-size decoders require decoder[0] to preserve commit order. */
> +	if (fail_autoassemble && mock_zero_size_decoders)
> +		return true;
>  
>  	return count > 1;
>  }
> @@ -2493,6 +2569,9 @@ module_param(fail_autoassemble, bool, 0444);
>  MODULE_PARM_DESC(fail_autoassemble, "Simulate missing member of an auto-region");
>  module_param(type2_test, bool, 0444);
>  MODULE_PARM_DESC(type2_test, "Enable type 2 support testing");
> +module_param(mock_zero_size_decoders, bool, 0444);
> +MODULE_PARM_DESC(mock_zero_size_decoders,
> +		 "Mock committed, locked, empty decoders under host-bridge0");
>  module_init(cxl_test_init);
>  module_exit(cxl_test_exit);
>  MODULE_LICENSE("GPL v2");

