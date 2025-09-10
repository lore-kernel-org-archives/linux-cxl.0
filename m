Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F63190685
	for <linux-cxl@vger.kernel.org>; Wed, 10 Sep 2025 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517810; cv=none; b=Wq5lQJHcCyojjFpguxc3tliwxTdqQ9AdiYHUMOCWuTiptkNLxysYKDVijdCAqOe/GznxezPYFyAB0tuNKFOlUpv7IGDWZskZqKABTXjKoMv71FvArQORUf/TfLg6FnccJH36Ptvo3l6ToyaSKWwpfYPaXd778Os2GxjsJn0F+bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517810; c=relaxed/simple;
	bh=QhCvpMTNSsgr9LWw1PZx4hghFj/iRVkwtH24QwHi0vY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HWgY/eH4qu0nv+/Dx0HG9vcAZXtNYqVFtULPHLc239S+cv78UI/C+ewRm5hEXxzwD5ew7yHxtxdv6QMZG7nWJ853jxfiMas+x0LNFG6+5YdFWnI0MdHKwH+FWVe3o5tQwBse1o2KCB9BErW20nln6ZPIF91qTX65iEIMTTwuI/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ecbANyh0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ecbANyh0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757517809; x=1789053809;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QhCvpMTNSsgr9LWw1PZx4hghFj/iRVkwtH24QwHi0vY=;
  b=ecbANyh0onO/SvQasatRXrVkfxgDRAoAUB14ShT4tDSXz5+4t28WeNA6
   ccskO1uSkfE8xNzin5UEjvocIoAqMibGsDgYeU+eQWu8WAw7sRhEdlDnN
   QZqTj9klxLqreC+qQjTQ9mij1Tsd6bowZUCbknAR+1KLW2vTBBBwpCL3R
   acv8R/tVolm74pRVbPprI7FSYtF0lZWETHY8FfNugVbtcDguIEEtPdzB0
   u8GLLuDBzzM0MZ+DH39krk4oOgSFPWye1SYClmmEpqV8tlMB2OharWnzj
   hxhsG1oJSz5jB9EKmKEoxa5u0nJGpPC4Clyxrc83mTJnr4PXWSBmOjy6M
   A==;
X-CSE-ConnectionGUID: Lbu4vk39T/qGSw38DvHQeg==
X-CSE-MsgGUID: fXPTR5JpTX67xPzHzIJh/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="59942996"
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="59942996"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 08:23:28 -0700
X-CSE-ConnectionGUID: YhipjQb3Qk+X5ZYITxP7nA==
X-CSE-MsgGUID: aPOhpkC5TDuTbZHAtWmSNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="173503187"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.110.219]) ([10.125.110.219])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 08:23:28 -0700
Message-ID: <26c7ca6f-eb5f-4f20-8dba-e62e43e3e1b5@intel.com>
Date: Wed, 10 Sep 2025 08:23:26 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/acpi: Limit XOR map application based on host
 bridge ways
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
References: <20250813032918.2899852-1-alison.schofield@intel.com>
 <d18a9fa9-ccd6-4fe8-83d1-e9838b15c5dd@intel.com>
 <aMCffjilTbkXT9P5@aschofie-mobl2.lan>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aMCffjilTbkXT9P5@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/9/25 2:43 PM, Alison Schofield wrote:
> On Wed, Aug 20, 2025 at 08:44:34AM -0700, Dave Jiang wrote:
>>
>>
>> On 8/12/25 8:29 PM, alison.schofield@intel.com wrote:
>>> From: Alison Schofield <alison.schofield@intel.com>
>>>
>>> The CXL specification defines one set of XOR maps per Host Bridge
>>> Interleave Granularity (HBIG), but the number of maps to apply
>>> depends on the Host Bridge Interleave Ways (HBIW) for each region.
>>>
>>> Currently, cxl_xor_hpa_to_spa() incorrectly applies all available
>>> XOR maps regardless of the region's host bridge interleave ways.
>>> This causes incorrect address translations when multiple CXL regions
>>> with the same HBIG but different HBIW's coexist.
>>>
>>> Example scenario with 3 XOR maps defined for 256-byte granularity:
>>> - 4-way interleave region:  should apply 2 maps (was applying 3)
>>> - 8-way interleave region:  should apply 3 maps (correct)
>>> - 12-way interleave region: should apply 2 maps (was applying 3)
>>>
>>> Per CXL 3.2 Section 9.18.1.4 and Table 9-22, fix this by using
>>> a lookup table to determine the correct number of XOR maps based
>>> on host bridge interleave ways.
>>>
>>> Fixes: 3b2fedcd75e3 ("cxl: Restore XOR'd position bits during address translation")
>>> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
>>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>>
>> Applied to cxl/next
>> c7ad33d50282168fbfed1c6662503b0d979a67c8
> 
> This patch can be dropped as there is nothing to fix.
> 
> The story above is true, but I missed the piece that came before. The
> CXL driver actually stores a customized list of xormaps per root decoder
> (see cxl_parse_cxims()) so there cannot be any extra maps in it's root
> decoder platform data (struct cxl_cxims_data).
> 
> This came up during testing when I moved out of tree code for address
> translation into the cxl-translate test module. In that case there was
> only one struct cxl_cxmis_data, not multiples per region interleave (or
> per root decoder) and so I was alarmed when all the xormaps were always
> applied by the CXL driver. Now I know that is working as designed, and
> it is the test module that needs to change.
> 
> My apologies for crying wolf!

Dropped from cxl/next

> 
>>
>>> ---
>>>
>>> Changes in v2:
>>> - Use CXL_DECODER_MAX_INTERLEAVE in hbiw_to_nr_maps[] definition (Dan)
>>> - Rebase onto latest cxl/next
>>>
>>>
>>>  drivers/cxl/acpi.c | 18 +++++++++++++++---
>>>  1 file changed, 15 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>>> index f1625212b08b..26c494704437 100644
>>> --- a/drivers/cxl/acpi.c
>>> +++ b/drivers/cxl/acpi.c
>>> @@ -16,19 +16,31 @@ struct cxl_cxims_data {
>>>  	u64 xormaps[] __counted_by(nr_maps);
>>>  };
>>>  
>>> +/*
>>> + * There is one CXIMS, therefore one set of XOR maps, that all CXL Windows with
>>> + * the same host bridge granularity share. The number of maps to apply at address
>>> + * translation is based on the Host Bridge interleave ways of the CXL Window.
>>> + * CXL Specification 3.2 Section 9.18.1.4 and Table 9-22.
>>> + */
>>> +#define HBIW_TO_NR_MAPS_SIZE (CXL_DECODER_MAX_INTERLEAVE + 1)
>>> +
>>> +static const int hbiw_to_nr_maps[HBIW_TO_NR_MAPS_SIZE] = {
>>> +	[1] = 0, [2] = 1, [3] = 0, [4] = 2, [6] = 1, [8] = 3, [12] = 2, [16] = 4
>>> +};
>>> +
>>>  static const guid_t acpi_cxl_qtg_id_guid =
>>>  	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
>>>  		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
>>>  
>>>  static u64 cxl_apply_xor_maps(struct cxl_root_decoder *cxlrd, u64 addr)
>>>  {
>>> +	int nr_maps_to_apply = hbiw_to_nr_maps[cxlrd->cxlsd.nr_targets];
>>>  	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
>>> -	int hbiw = cxlrd->cxlsd.nr_targets;
>>>  	u64 val;
>>>  	int pos;
>>>  
>>>  	/* No xormaps for host bridge interleave ways of 1 or 3 */
>>> -	if (hbiw == 1 || hbiw == 3)
>>> +	if (!nr_maps_to_apply)
>>>  		return addr;
>>>  
>>>  	/*
>>> @@ -50,7 +62,7 @@ static u64 cxl_apply_xor_maps(struct cxl_root_decoder *cxlrd, u64 addr)
>>>  	 * bits results in val==0, if odd the XOR result is val==1.
>>>  	 */
>>>  
>>> -	for (int i = 0; i < cximsd->nr_maps; i++) {
>>> +	for (int i = 0; i < nr_maps_to_apply; i++) {
>>>  		if (!cximsd->xormaps[i])
>>>  			continue;
>>>  		pos = __ffs(cximsd->xormaps[i]);
>>>
>>> base-commit: d9412f08e25a5b66f9021739c090cc9b8f1089b1
>>

