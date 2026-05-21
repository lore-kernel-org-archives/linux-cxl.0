Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC0B33EF;
	Thu, 21 May 2026 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379380; cv=none; b=AO5oeB1EaicGRR9cszixohRLeElNH9Ckcv6w23A4CEy+cRl1hHhzrmHyq+2NYd24vubf15dY6eax/XuUXoJII1IpIoiNHT5ZyhD8dHt8rjtEabf2ft79IFEBkq+AsGTvu4D4OeT/PkhhIKO65zaShworTEOhHQYe49IGZhpcb3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379380; c=relaxed/simple;
	bh=rwY1kB7Voc1IZjnEioHtoTjPLLXConZIA8gI5WU8Xyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c1FrMxx5qI86owULbnjcd0vlwjbrUzgP3xquz3FEcKfD+qmdvOCbIFl6N/aV8VbpuwXH1NkgFVAWXbJPHsBK5oEkJA+SYzBn5B7mB9jWVDAr3solUpSnvIiQhcbGchRQGG2iltBPAdDWLNTDHqcqBAtcSCEts4dCC42AzjreFCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RJHFFoz3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RJHFFoz3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779379378; x=1810915378;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rwY1kB7Voc1IZjnEioHtoTjPLLXConZIA8gI5WU8Xyg=;
  b=RJHFFoz3K7JOBY5Kugs1P/+uYHg06b6B+cZ84/WozK1fj7IJ2eWqcIjn
   666UhS/pIM45HdpGKnfnPLHcq8a6m6n1v6l2tM72aeHRXOyCRyIe5Yy06
   pxSsK9r3Ih0pO7dphbD+DgD1LDqh/UZYuf7FMWmAB+/fUvuVj3HB9TT7T
   Tw07djI76K/n9CohVGma2QYanMmnLL7JjfzNY3j3dd8tTrOIuZFBckWQZ
   hGBohCcAyICkn6jsdBii+ckE1bQJbt4+n7RkaHiVgkSMPzZA/N9zPPVTa
   npnuu1ZXSPj0FCLgMamYcloVUWr4GKbFTpwmBr0Xm5tfp+W33wSOJ9qsj
   A==;
X-CSE-ConnectionGUID: pqPh5/tIQcyHBmLZfv47ag==
X-CSE-MsgGUID: Ez3BqlbQT6enIjgGUDngTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="91694508"
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; 
   d="scan'208";a="91694508"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 09:02:57 -0700
X-CSE-ConnectionGUID: 6LOmIwv2S5Sy/TJ1VC4aRA==
X-CSE-MsgGUID: 6AwriqPcR2Kx1VJCnYe7IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; 
   d="scan'208";a="245606686"
Received: from cjhill-mobl.amr.corp.intel.com (HELO [10.125.110.16]) ([10.125.110.16])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 09:02:53 -0700
Message-ID: <f3a1e0cd-0274-46c1-bf24-7d7d81689051@intel.com>
Date: Thu, 21 May 2026 09:02:52 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tools/testing/cxl: Support multi-decoder shared-dport
 topology
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.ne
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 fabio.m.de.francesco@linux.intel.com, rrichter@amd.com,
 ming.li@zohomail.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, newtonl@nvidia.com, kristinc@nvidia.com,
 kaihengf@nvidia.com, kobak@nvidia.com
References: <20260521084806.28232-1-icheng@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260521084806.28232-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/21/26 1:48 AM, Richard Cheng wrote:
> Add "multi_decoder" module param to the cxl_test emulator. When enabled,
> mock_init_hdm_decoder() addtionally programs decoder X.1 on cxl_mem.0
> and cxl_mem.4 as a second auto-region carved from the next
> mock_auto_region_size of HPA in the same CFMWS window.
> The result is 2 committed switch decoders that share the same
> downstream-port target_map[].
> 
> This is inspired by [1] so the emulator can detect and test for scenario
> like that.
> 
> [1]: https://lore.kernel.org/all/20260108101324.509667-1-rrichter@amd.com/
> Signed-off-by: Richard Cheng <icheng@nvidia.com>

Hi Richard,
There are some refactoring in this series [1] with feedback from Alison surrounding cxl_test module params. May be a good idea to rebase on top of that.

[1]: https://lore.kernel.org/linux-cxl/20260519213734.69737-1-dave.jiang@intel.com/T/#t

DJ


> ---
>  tools/testing/cxl/test/cxl.c | 88 +++++++++++++++++++++++++++++++++---
>  1 file changed, 81 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 418669927fb0..929bbee471db 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -17,6 +17,7 @@
>  static int interleave_arithmetic;
>  static bool extended_linear_cache;
>  static bool fail_autoassemble;
> +static bool multi_decoder;
>  
>  #define FAKE_QTG_ID	42
>  
> @@ -1041,6 +1042,17 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
>  	WARN_ON_ONCE(!cxld_registry_new(cxld));
>  }
>  
> +static int decoder_by_id(struct device *dev, const void *data)
> +{
> +	int target_id = (int)(uintptr_t)data;
> +	struct cxl_decoder *cxld;
> +
> +	if (!is_switch_decoder(dev))
> +		return 0;
> +	cxld = to_cxl_decoder(dev);
> +	return cxld->id == target_id;
> +}
> +
>  static int first_decoder(struct device *dev, const void *data)
>  {
>  	struct cxl_decoder *cxld;
> @@ -1079,6 +1091,8 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  	struct cxl_memdev *cxlmd;
>  	struct cxl_dport *dport;
>  	struct device *dev;
> +	int max_decoder_id;
> +	int region_decoder_id = 0;
>  	bool hb0 = false;
>  	u64 base;
>  	int i;
> @@ -1129,9 +1143,16 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  	 * assignment those devices are named cxl_mem.0, and cxl_mem.4.
>  	 *
>  	 * See 'cxl list -BMPu -m cxl_mem.0,cxl_mem.4'
> +	 *
> +	 * When multi_decoder is enabled, additionally program decoder
> +	 * X.1 of the same endpoints as a second auto-region that shares
> +	 * the switch's downstream ports with the first region, so that
> +	 * the same dport ends up in target_map[] of two committed switch
> +	 * decoders simultaneously.
>  	 */
> +	max_decoder_id = multi_decoder ? 1 : 0;
>  	if (!is_endpoint_decoder(&cxld->dev) || !hb0 || pdev->id % 4 ||
> -	    pdev->id > 4 || cxld->id > 0) {
> +	    pdev->id > 4 || cxld->id > max_decoder_id) {
>  		default_mock_decoder(cxld);
>  		return false;
>  	}
> @@ -1142,9 +1163,14 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  		return false;
>  	}
>  
> +	region_decoder_id = cxld->id;
> +
>  	base = window->base_hpa;
>  	if (extended_linear_cache)
>  		base += mock_auto_region_size;
> +	/* Place the second auto-region right after the first. */
> +	if (region_decoder_id == 1)
> +		base += mock_auto_region_size;
>  	cxld->hpa_range = (struct range) {
>  		.start = base,
>  		.end = base + mock_auto_region_size - 1,
> @@ -1156,7 +1182,9 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  	cxld->flags = CXL_DECODER_F_ENABLE;
>  	cxled->state = CXL_DECODER_STATE_AUTO;
>  	port->commit_end = cxld->id;
> -	devm_cxl_dpa_reserve(cxled, 0,
> +	devm_cxl_dpa_reserve(cxled,
> +			     region_decoder_id *
> +				 (mock_auto_region_size / 2),
>  			     mock_auto_region_size / cxld->interleave_ways, 0);
>  	cxld->commit = mock_decoder_commit;
>  	cxld->reset = mock_decoder_reset;
> @@ -1165,12 +1193,23 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  	/*
>  	 * Now that endpoint decoder is set up, walk up the hierarchy
>  	 * and setup the switch and root port decoders targeting @cxlmd.
> +	 *
> +	 * For region 0 use switch-decoder slot 0 (selected by
> +	 * first_decoder()); for region 1 use slot 1 so that the two
> +	 * regions exercise the multi-decoder / shared-dport scenario.
>  	 */
>  	iter = port;
>  	for (i = 0; i < 2; i++) {
>  		dport = iter->parent_dport;
>  		iter = dport->port;
> -		dev = device_find_child(&iter->dev, NULL, first_decoder);
> +		if (region_decoder_id == 0) {
> +			dev = device_find_child(&iter->dev, NULL,
> +						first_decoder);
> +		} else {
> +			dev = device_find_child(&iter->dev,
> +						(void *)(uintptr_t)region_decoder_id,
> +						decoder_by_id);
> +		}
>  		/*
>  		 * Ancestor ports are guaranteed to be enumerated before
>  		 * @port, and all ports have at least one decoder.
> @@ -1179,23 +1218,36 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  			continue;
>  
>  		cxlsd = to_cxl_switch_decoder(dev);
> +		/*
> +		 * Region 0 (decoder.0) keeps the historical shortcut of
> +		 * stamping target[] directly so single-region setup is
> +		 * unaffected by dport-add ordering quirks of cxl_test.
> +		 *
> +		 * Region 1 (decoder.1, only programmed when
> +		 * multi_decoder=1) intentionally leaves target[]
> +		 * to update_decoder_targets() at dport-add time.
> +		 */
>  		if (i == 0) {
>  			/* put cxl_mem.4 second in the decode order */
>  			if (pdev->id == 4) {
> -				cxlsd->target[1] = dport;
> +				if (region_decoder_id == 0)
> +					cxlsd->target[1] = dport;
>  				cxlsd->cxld.target_map[1] = dport->port_id;
>  			} else {
> -				cxlsd->target[0] = dport;
> +				if (region_decoder_id == 0)
> +					cxlsd->target[0] = dport;
>  				cxlsd->cxld.target_map[0] = dport->port_id;
>  			}
>  		} else {
> -			cxlsd->target[0] = dport;
> +			if (region_decoder_id == 0)
> +				cxlsd->target[0] = dport;
>  			cxlsd->cxld.target_map[0] = dport->port_id;
>  		}
>  		cxld = &cxlsd->cxld;
>  		cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>  		cxld->flags = CXL_DECODER_F_ENABLE;
> -		iter->commit_end = 0;
> +		if (iter->commit_end < region_decoder_id)
> +			iter->commit_end = region_decoder_id;
>  		/*
>  		 * Switch targets 2 endpoints, while host bridge targets
>  		 * one root port
> @@ -1212,6 +1264,26 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  		cxld->commit = mock_decoder_commit;
>  		cxld->reset = mock_decoder_reset;
>  
> +		/*
> +		 * For the second region only target_map[] is set above,
> +		 * not cxlsd->target[]. On real hardware target[] gets
> +		 * populated when dports are added (BIOS-programmed
> +		 * decoders are read first, then dports get enumerated).
> +		 * cxl_test's order is reversed: dports were added long
> +		 * before this point, so re-fire the update here against
> +		 * each existing dport to mimic the real-hardware
> +		 * ordering and exercise update_decoder_targets() with
> +		 * pre-programmed decoders.
> +		 */
> +		if (region_decoder_id == 1) {
> +			struct cxl_dport *existing;
> +			unsigned long index;
> +
> +			xa_for_each(&iter->dports, index, existing)
> +				cxl_port_update_decoder_targets(iter,
> +								existing);
> +		}
> +
>  		cxld_registry_update(cxld);
>  		put_device(dev);
>  	}
> @@ -2049,6 +2121,8 @@ module_param(extended_linear_cache, bool, 0444);
>  MODULE_PARM_DESC(extended_linear_cache, "Enable extended linear cache support");
>  module_param(fail_autoassemble, bool, 0444);
>  MODULE_PARM_DESC(fail_autoassemble, "Simulate missing member of an auto-region");
> +module_param(multi_decoder, bool, 0444);
> +MODULE_PARM_DESC(multi_decoder, "Auto-program a 2nd decoder per endpoint sharing switch dports");
>  module_init(cxl_test_init);
>  module_exit(cxl_test_exit);
>  MODULE_LICENSE("GPL v2");

