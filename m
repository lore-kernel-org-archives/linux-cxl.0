Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0932C15BB;
	Tue, 28 Jul 2026 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785248714; cv=none; b=HHyNfOoPk13lXJPG1INLyA592n1pueUSVz72DMB1QBvnvfNBeKTYZxxL1tEwRJajle9f8ARHreazvsRWd6iMyUxUolQuipVlcbQemjEYXkACbTMDzeDrxuZKJ/Bj2uHs5NHjtlQEQzEvZuANFLSa8rof3ncSKyApmmeIsr457/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785248714; c=relaxed/simple;
	bh=g75o0ELtof580ZWlQwrkWGhwCFhitHODOPiOQXdT4oE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a31thqCdQzQimZ+ExzN7I5YNTXe011Jq9h5b8AssojA+ImGUjaT5miCq1s9RMipdgnx92NNezTT9sijyHFw5fIj9eNael31xa21TjDYq/qVas86IjfrxB5ja9dn7Y7hsnITQ0w8GFeC7XYEjmy6iZZi4jaR0S9hoG7xXKeXmbD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GD1jU8JR; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GD1jU8JR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785248712; x=1816784712;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g75o0ELtof580ZWlQwrkWGhwCFhitHODOPiOQXdT4oE=;
  b=GD1jU8JRD5eu6lipKKuL0Hxls9/5Emt/vp/buhbmmmP1TPpDKbZieU/5
   sjomKq0cSEy26b9ZlcQdQOIzpB3atktiHitDesYcd2KC9D3ldnPpspi9U
   Lf/p//Gw3Mx9cjjfLfSEvBHA9EYwEFXiS3FZLYRiisnn9Qvg5q599roor
   0WmZ03R2VSWsLpjExN+HHSesrbwU0DQbHVR1OitCIHemrGe7+TlpJs81E
   E/aKtKbElokLZx23fTCDMWAzF3IIagNYAq/ath8EZcaZtukgvPtp/au9P
   b0dTP7BXPnN/TmwDD0cIEBBr7QUNMTTxl02YJzR2vY5p6i6zI5XmPUS4s
   A==;
X-CSE-ConnectionGUID: W7Tutrn/QpmEORs8F3juTQ==
X-CSE-MsgGUID: 4V4HCbmqT0OZzLhsdr2IYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85915530"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="85915530"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 07:25:12 -0700
X-CSE-ConnectionGUID: 5AAWgWabSO+O+JNYJoHf/w==
X-CSE-MsgGUID: Q/9by3ZzSJiedY5G6A46nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="284256435"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.111.111]) ([10.125.111.111])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 07:25:10 -0700
Message-ID: <210c8742-08db-4401-80eb-9ad9a8c14054@intel.com>
Date: Tue, 28 Jul 2026 07:25:09 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Restore passthrough decoder enable on region
 re-assembly
To: Richard Cheng <icheng@nvidia.com>
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com,
 vishal.l.verma@intel.com, djbw@kernel.org, iweiny@kernel.org,
 ming.li@zohomail.com, gourry@gourry.net, rrichter@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, sreddym@nvidia.com,
 smadhavan@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com,
 newtonl@nvidia.com, kristinc@nvidia.com, mochs@nvidia.com
References: <20260727103743.63343-1-icheng@nvidia.com>
 <d96567c3-df6f-4008-9678-c4fed3787309@intel.com>
 <amgQUnkQ1VjyXtzx@MWDK4CY14F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <amgQUnkQ1VjyXtzx@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/27/26 8:03 PM, Richard Cheng wrote:
> On Mon, Jul 27, 2026 at 01:25:48PM +0800, Dave Jiang wrote:
>>
>>
>> On 7/27/26 3:37 AM, Richard Cheng wrote:
>>> After a CXL endpoint is PCI hot-removed and the bus rescanned, an
>>> auto-discovered region fails to rebiuld and is lost, evne though the
>>
>> rebuild
>> even
>>
> 
> Hi Dave,
> Thanks for the review, I'll fix the typo in v2.
>  
>>> device's HDM decoder is still committed and decoding.
>>
> 
> I think this part is talking about physical remove/insert ? sorry maybe I commit message was too vague about the scenario.
> The case here is a SW-only teardown via sysfs, this is what I did.
> 
> """
> $ echo 1 > /sys/bus/pci/devices/$BDF/remove
> $ echo 1 > /sys/bus/pci/devices/$BDF/rescan
> """
> 
> No physical removal, no power cycle, no link-down, no reset. Linux drops and re-enumerates the same device, which never stopped running.
> The endpoint HDM decoder is still committed.
> 
> The device is byte-identical before and after, the kernel doesn't clear it either, the decoder is locked and cxl_decoder_reset() returns
> early for CXL_DECODER_F_LOCK before touching any register. The memory keeps decoding.

Given this is a single target passthrough, should we check the EP decoder for lock before going forward?
> 
> I don't think anything needs re-programming here? the only thing lost is kernel-side bookkeeping on the passthrough decoder, which is
> freed with port and reallocated with F_ENABLE clear on rescan. The endpoint recovers its state from HW.
> The passthrough decoder has no HW to recover from, that asymmetry is the bug.
> 
>> Also, a complete different device with possibly different size can be inserted. And the device showed up would be unconfigured. Given
>> there's no BIOS to program the device since the OS has taken over, should it be still considered part of the auto-region?
> 
> Agreed that would be wrong, and I don't think this patch allows it. A different or freshly-inserted device fails the existing endpoint
> checks, its own decoder won't come back COMMITTED with a matching HPA range, so cxl_add_to_region() won't re-assemble the auto-region
> relardless of what the passthrough decoder's flag says. This patch guards on the decode config still matching (iw, ig, spa_maps_hap()),
> and on !cxld->commit, so it can only ever touch a SW-only stub.
> 
> So the coverage here is SW-only, I should state it more clearly in v2.
> 
> Btw, the check "!cxld->commit" is doing a lot of implicit work in the code base, I think that's worth fixing regardless of the patch.
> "commit == NULL" is not unique to passthrough decoders, cxl_setup_hdm_decoder_from_dvsec() also sets "commit = NULL" for DVSEC-emulated
> RCD endpoint decoders, and root decoder never set it. My call happens to be safe, but that isn't visible from the condition.
> 
> I would suggest an inline helper like the following, do you think it's reasonable ?
> 
> """
> static inline bool cxl_decoder_is_passthrough(struct cxl_decoder *cxld)
> {
>     if (cxld->commit)
>         return false;
>     if (!is_switch_decoder(&cxld->dev) || is_root_decoder(&cxld->dev))
>         return false;
>     return to_cxl_switch_decoder(&cxld->dev)->nr_targets <= 1;
> }
> """
> 
> There're about 4 call site today, and it distinguishes "passthrough" from "has no commit routine" , which are currently the same check
> for different things.
> 
> Happy to send it as a separate patch and make this one a patch series if you prefer the shape.

Yeah I think if we can improve the clarity that would be a good thing. Thanks Richard!

DJ

> 
> Best regards,
> Richard Cheng.
> 
>> Any thoughts Jonathan?
>>
>>>
>>> A single-dport host bridge/root port has no HDM decoder capability, so
>>> its switch decoder is a SW-only passthrough. Its CXL_DECODER_F_ENABLE
>>> flag is cleared on region teardown and never restored on rescan, so
>>> cxl_port_setup_targets() fails with -ENXIO.
>>>
>>> Re-enable the passthrough decoder when its interleave and HPA config
>>> still match the region, it holds no HW state.
>>>
>>> Signed-off-by: Richard Cheng <icheng@nvidia.com>
>>> ---
>>>  drivers/cxl/core/region.c | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index 1e211542b6b6..011ceb5bae79 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -1574,6 +1574,19 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>>>  	}
>>>  
>>>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>>> +		/*
>>> +		 * A passthrough switch decoder holds no HW decode state.
>>> +		 * It's CXL_DECODER_F_ENABLE flag is pure software bookkeeping
>>> +		 * that is cleared when the region is torn down. On auto-discovery
>>> +		 * re-assembly after a subsequent rescan the decode config still
>>> +		 * matches the region, so restore the flag rather than fail to
>>> +		 * rebuild a region that HW is in fact still decoding.
>>> +		 */
>>> +		if (!cxld->commit && cxld->interleave_ways == iw &&
>>> +		    (iw <= 1 || cxld->interleave_granularity == ig) &&
>>> +		    spa_maps_hpa(p, &cxld->hpa_range))
>>> +			cxld->flags |= CXL_DECODER_F_ENABLE;
>>> +
>>>  		if (cxld->interleave_ways != iw ||
>>>  		    (iw > 1 && cxld->interleave_granularity != ig) ||
>>>  		    !spa_maps_hpa(p, &cxld->hpa_range) ||
>>>
>>> base-commit: 4539944e515183668109bdf4d0c3d7d228383d88
>>

