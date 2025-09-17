Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A77E2566E9;
	Wed, 17 Sep 2025 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758142685; cv=none; b=GWvcWvZuLIS6z/TlHsndQ31tO34yS1TPzxyqXiUmfhkTHnv6eCBTZlX7EL9R+YURs9wBApjbfvo9DtZZCCsqEuVCd4J6kCjSIbzDrP4hiPXYqAxecrCwxzuKfbpRKYU3kmHm7oAzKkhPIq+Ucebyjq7aLFyBynFXoJ03/ESZiDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758142685; c=relaxed/simple;
	bh=moQIl8q101c8cCrSFiRPkaEjaxA18DdYcaYAJTpAXzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aeyVSx55vOTgZ+Q8ERbXmpbuEj1e2lnW04dvs00/q8yApyKr7YVsZLZJhDX/oPL1IS0U2h65t/qFObgCVaIOp4HCHr3+5GjPkgNEwZb8tcRuonhxLXZJfmHNSzoVht2ECPLmviMmupRdReWlrZeXgUvUf7qub+DitwLjaxR1WXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bfdlqI0z; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bfdlqI0z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758142683; x=1789678683;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=moQIl8q101c8cCrSFiRPkaEjaxA18DdYcaYAJTpAXzQ=;
  b=bfdlqI0zK+GTyYwLf7ZmPS8BiR8fCzd9WC15QRE9nfMOU1tU5BuRejcX
   KYPUnd5qM2J3m/rupOB/YUQZIUW522LPftayBAfDuhDOXt5/Wv5uMVEfQ
   krEooYm4E1NBLJeBnlvaBZwqigi0bm9SycoEIxhEnEXX8R8Ux5C7PZ/BD
   iBt1JZWKZRlZoYJLBuRuIjpDPMK84Ts21ZI0/c1yYstwtNbW98vN9c4Vl
   rl4BschRV9sXtvEg9+XyRi6ajNvWg4EHD4IQY0wNfAR2Yn7NbAanRcFs9
   jhVoDfRM9N87bm8l07lQehdoURwWWN4tQysA8qjra5H85CuYPOxVcX+rx
   g==;
X-CSE-ConnectionGUID: iWgkheDmSsuVA+1/ttQmQw==
X-CSE-MsgGUID: FkUa9khzSH6KUgWOKRrQoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="60530292"
X-IronPort-AV: E=Sophos;i="6.18,273,1751266800"; 
   d="scan'208";a="60530292"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 13:58:02 -0700
X-CSE-ConnectionGUID: CMzS1QJDTvq5S9Dq5pGkyQ==
X-CSE-MsgGUID: 49J6xT9FSXO1Vxn6kgTwnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,273,1751266800"; 
   d="scan'208";a="206279723"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.111.223]) ([10.125.111.223])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 13:58:00 -0700
Message-ID: <10d3ed8d-7688-4ced-841a-ce4e6d0b7f31@intel.com>
Date: Wed, 17 Sep 2025 13:57:59 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/11] cxl/region: Implement endpoint decoder address
 translation
To: Gregory Price <gourry@gourry.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-9-rrichter@amd.com>
 <20250915114614.000053f1@huawei.com>
 <aMsfWfwMhewTjHD3@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aMsfWfwMhewTjHD3@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/17/25 1:51 PM, Gregory Price wrote:
> On Mon, Sep 15, 2025 at 11:46:14AM +0100, Jonathan Cameron wrote:
>>> +	/*
>>> +	 * Since translated addresses include the interleaving
>>> +	 * offsets, align the range to 256 MB.
>>
>> So we pass in an HPA range without interleaving offsets and get back
>> one with them?  Is that unavoidable, or can we potentially push
>> this bit into the callback?  Probably with separate callbacks to
>> get the interleave details.
>>
>> Overall I'm not really following what is going on here.  Maybe
>> some ascii art would help?
>>
> 
> The endpoints in this case are encoded with "normalized" (base-0) with
> a size of only the memory they provide. As a result, the decoder
> interleave settings will always be passthrough (iw=1, ig=ignored).
> 
> This chunk translates the normalized address region to the relevant SPA
> region, and translates the IW/IG to what it actually is (i.e. what it 
> *would have* been on a "normal" system).
> 
> Took me a while when i originally reviewed and tested this set.
> 
> Example - this is how you'd expect a real system supported by this code
> to be programmed:
> 
> region {
>     .start = 0x20000000
>     .end   = 0x3fffffff
>     .iw    = 2
>     .ig    = 256
> }
> 
> endpoint1_decoder {
>     .start = 0x0
>     .end   = 0xfffffff
>     .iw    = 1
>     .ig    = 256
> }
> 
> endpoint2_decoder {
>     .start = 0x0
>     .end   = 0xfffffff
>     .iw    = 1
>     .ig    = 256
> }
> 
> when you do the translation from either decoder's hpa start/end,
> you want the following output:
> 
> range {
>     .start = 0x20000000
>     .end   = 0x3fffffff
>     .iw    = 2
>     .ig    = 256
> }
> 
> If you assume a "normal" system - this is the settings the decoders
> would have been programmed with in the first place.
> 
> You have to do the alignment because the translation function (may)
> only work on granularity alignment.
> 
> Example:
> endpoint1->to_hpa(0)         => 0x0
> endpoint1->to_hpa(0xfffffff) => 0xffffe00
> endpoint2->to_hpa(0)         => 0x100
> endpoint2->to_hpa(0xfffffff) => 0xfffff00
> 
> So this code applies the appropriate alignment and returns the
> translated iw/ig for use elsewhere in the stack when validating the rest
> of the decoders.

Having this explanation added to the Conventions document would be good to have.

> 
> (haven't gotten to later commits, but iirc it was eventually used)
> 
> ~Gregory
> 
>>> +	 */
>>> +	range.start = ALIGN_DOWN(range.start, SZ_256M);
>>> +	range.end = ALIGN(range.end, SZ_256M) - 1;
>>> +
>>> +	spa_len = range_len(&range);
>>> +	if (!len || !spa_len || spa_len % len) {
>>> +		dev_warn(&port->dev,
>>> +			"CXL address translation: HPA range not contiguous: %#llx-%#llx:%#llx-%#llx(%s)\n",
>>> +			range.start, range.end, ctx->hpa_range.start,
>>> +			ctx->hpa_range.end, dev_name(&cxld->dev));
>>> +		return -ENXIO;
>>> +	}
>>> +
>>> +	ways = spa_len / len;
>>> +	gran = SZ_256;
>>> +

