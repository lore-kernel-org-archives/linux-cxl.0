Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62C01A239B
	for <linux-cxl@vger.kernel.org>; Wed,  5 Mar 2025 04:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741149702; cv=pass; b=Sf0p/nCboytUR/RXkOH1W3fuqvE6utBXAfo4yWZzXRFS8HBZmdC3DJvCJNAdN572FGqoE/YulLd6145nGYrGIEUimA1bixLIs/JUfXrEU2Nqw+w0zPUE++uvKXFepDuOGU5AfraG/8SRFIoBGoYYKPUQMa40gDKkeZbffLokrS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741149702; c=relaxed/simple;
	bh=7lcPDkvgyPuzbyG/rzkV0nkvwB957lU0hSF5+FhFl3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h86uq4awEdueUeJDRY7B/kyxDMkiUBw6YFMVlEPgFlOMXqSe8o36dddcmy+IMkiBHqsWdq9MRoTO3wg91J5WTyTvULE5l2hUukpdgZJyhHN5FgGojZ2knv2NCs+FhRuX73gPevAkBMrX5foqCner27OfZDb0NMswVafglHYVcBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Us0Vnrlk; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Us0Vnrlk"
ARC-Seal: i=1; a=rsa-sha256; t=1741149688; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fgUZCGAU4o3Yv9gPL+tRCGyfa6Bl3RcK1/o2Vn23uZYIdBKtykDUZNVdWmVY98E5dT/XgX4+RflP8oPaV7drNaUbsosR+yRLnhJuehaBigNrRuMaqHWA7QFOLSDQE8SWmQeKOIbycMvTkX7ASMZqZPHtkbTm6xfSKYD4x4EhY6o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741149688; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=orLrXIuS4HqRYT3fR641HcspDQ8g/MoUDqjsAltpl4k=; 
	b=Z5gcizbCrFmZGvVIiOB9E1prbvW4tceWGDaliW50qkl4Vm/F6nizjJsWP1ZID+YCWBTgnhjtW9XP3s5HkW3y7q6Vspi6w2EC99fO/1BuSIPt7jCUrmyiJIrgrfMFTGAHgVSDtAtPGpFtZwW3ib8Ectb5viU5kh1zFKSjj155NCA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741149688;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=orLrXIuS4HqRYT3fR641HcspDQ8g/MoUDqjsAltpl4k=;
	b=Us0Vnrlk2SOLDJfFJbGOmB8d9Snr+1hIsPXXDlZj6k3ayP5jA/YcCLA/OYlsmit8
	+OVy77R6kAcv6E6IiFrHeCShvB9OgwXKkmDxIgGfELMRPQ1Qk0Y0og4H4aGAz7cne+c
	+njHRHCdCBW1F+jJPSrkWGrQKyR1krgHLVY0hfQw=
Received: by mx.zohomail.com with SMTPS id 1741149685234443.59946360622394;
	Tue, 4 Mar 2025 20:41:25 -0800 (PST)
Message-ID: <f2b70e5f-b72b-4c5a-9eb3-df0aaa421430@zohomail.com>
Date: Wed, 5 Mar 2025 12:41:26 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Quiet some dev_warn()s in extended linear
 cache setup
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
References: <20250304043315.2502110-1-alison.schofield@intel.com>
 <12e0d842-0ff3-4c8a-9bc2-b5c1436521e1@zohomail.com>
 <Z8edZPIWsjSLiEac@aschofie-mobl2.lan>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <Z8edZPIWsjSLiEac@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr080112273574956f61589b6759bf3675000062fb8b5cf15608624749a64a9359c33349d0ac19323851bd0b:zu080112279bb7b78f3bf10db5dae72b260000f79322dfa0c067da2a556cc8b99aa4f2cd2218d10aa872b20b:rf0801122d07bcb78b3f1ed3473a793b0c0000b1350e58edaf93ada13a20cb90ae7170593ebb8394fac1ef4b50cc65380b07:ZohoMail
X-ZohoMailClient: External

On 3/5/2025 8:40 AM, Alison Schofield wrote:
> On Tue, Mar 04, 2025 at 01:14:47PM +0800, Li Ming wrote:
>> On 3/4/2025 12:33 PM, alison.schofield@intel.com wrote:
>>> From: Alison Schofield <alison.schofield@intel.com>
>>>
>>> Extended Linear Cache (ELC) setup code emits a dev_warn(), "Extended
>>> linear cache calculation failed." for issues found while setting up
>>> the ELC.
>>>
>>> For platforms without CONFIG_ACPI_HMAT, every auto region setup will
>>> emit the warning because the default !ACPI_HMAT return value is
>>> EOPNOTSUPP. Suppress it by skipping the warn for EOPNOTSUPP. Change
>>> the EOPNOTSUPP in the actual ELC failure path to ENXIO.
>>>
>>> In a much less likely path, the dev_warn() is emitted if the size of
>>> the region resource is NULL. Move that size check out of the ELC setup
>>> code since NULL resource size is unrelated to the ELC setup and should
>>> cause an immediate failure to construct the auto region.
>>>
>>> For good measure, add the rc value to the dev_warn(). It will either
>>> be the -ENOENT returned by HMAT if the mem target is not found, or
>>> the -ENXIO from the region driver calculation.
>>>
>>> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
>>> ---
>>>  drivers/cxl/core/region.c | 16 ++++++++--------
>>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index 8537b6a9ca18..2d2d2f221902 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -3235,13 +3235,10 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
>>>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>>>  	struct cxl_region_params *p = &cxlr->params;
>>>  	int nid = phys_to_target_node(res->start);
>>> -	resource_size_t size, cache_size, start;
>>> +	resource_size_t size = resource_size(res);
>>> +	resource_size_t cache_size, start;
>>>  	int rc;
>>>  
>>> -	size = resource_size(res);
>>> -	if (!size)
>>> -		return -EINVAL;
>>> -
>>>  	rc = cxl_acpi_get_extended_linear_cache_size(res, nid, &cache_size);
>>>  	if (rc)
>>>  		return rc;
>>> @@ -3253,7 +3250,7 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
>>>  		dev_warn(&cxlr->dev,
>>>  			 "Extended Linear Cache size %pa != CXL size %pa. No Support!",
>>>  			 &cache_size, &size);
>>> -		return -EOPNOTSUPP;
>>> +		return -ENXIO;
>>>  	}
>>>  
>>>  	/*
>>> @@ -3304,15 +3301,18 @@ static int __construct_region(struct cxl_region *cxlr,
>>>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>>>  				    dev_name(&cxlr->dev));
>>>  
>>> +	if (!resource_size(res))
>>> +		return -EINVAL;
>>> +
>> Hi Alison,
>>
>>
>> There is a 'res = kmalloc(sizeof(*res), GFP_KERNEL);' in __construct_region() before this return, I think that you should release 'res' before returning -EINVAL.
> Thanks for the review. I zoomed out a bit and can't find how
> we can get here without a valid hpa_range which makes me
> want to remove the check altogher. Then again it's harmless,
> and not in any performance path.
>
> Checking with DaveJ ?
>
You are right, __construct_region() is only invoked during region auto-assembly. the size of cxled's hpa_range is already checked in init_hdm_decoder() if the cxl endpoint decoder is committed.


Ming

>> Other looks good to me.
>>
>> Reviewed-by: Li Ming <ming.li@zohomail.com>
>>
>>
>> Ming
>>
>> [snip]
>>
>>

