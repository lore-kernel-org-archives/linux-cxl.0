Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5831F3F1AAB;
	Wed, 20 May 2026 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289167; cv=none; b=HJ2OQm4rTAHqCGXyNEG/h/IYp6oKys0jAdFRwmstpdSru+O9mWWD6FxivwGOayVaMGYqWCbWFHElYQZAcPx3Ywitlu8/JYOD7iKuSSVGyqebginGVitcoh4Q9g9/RqZUYHzbpjOhbFLEhfPQOdLFv3Vn7EeVX0eqh9vpM4tGwiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289167; c=relaxed/simple;
	bh=HPQnB/wg9UwBu5AE8gehW6Kw6CCIDFaJ/8UovYpXoVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TBDdA1U/dyYX6VdGtcKju+hTPpnvDVd8PPNDLlidJjoduAqnfyBNtlleAUnVRHjTMchAaMsiSID7B/mxhUs8gXKitRzY8AJtsJ/TrFgHCMBVbm24t9kcuyYysXckVBkuBcoua1SBQ1533c84ONN8u3gWki8iAjtNPyJaEsXwVjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QsXv1lwU; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QsXv1lwU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779289164; x=1810825164;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HPQnB/wg9UwBu5AE8gehW6Kw6CCIDFaJ/8UovYpXoVE=;
  b=QsXv1lwUcCvQCdtbn/e+czdH5CvxQqaS+PzToXeuAewjjW0az58EUOlk
   /8HmNtaKvUU9BVbaqsUUqJ6fCltf83tLep+HYWdt7GHxtGBLHyBMTijAo
   LIEinyhO+2c/GIkuwpbHJ0MnnNVL8X/iOKpF+hwslsC+YYC2otBoMning
   uJcmDORe9lJF6rYfxuPWR7EzeL8C755OJbzjVdjGM0fQzG+tSahRKbtvv
   +hpfNJ0sm5Ul5Fe2+xdoGFoi2/CkfG2c2LaD+mvk8ugivwBUzp0ey10qe
   Cju1RqiAaBwgglKb5+54nncvtOXGIFZM5KyvldpQKp+UPQFMPQ4roTdX8
   A==;
X-CSE-ConnectionGUID: PszC9QG9QXCSqFNyTfLDPQ==
X-CSE-MsgGUID: FDjIaxhLR9ayTU7YaFb/+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="102868226"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="102868226"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 07:59:23 -0700
X-CSE-ConnectionGUID: GKLVY0yCRjWwvK2YO05caA==
X-CSE-MsgGUID: gcDnVwl9T4yhMmN8vsM+mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="240072001"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.109.205]) ([10.125.109.205])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 07:59:22 -0700
Message-ID: <8a835dea-956f-4eab-931c-e1a54e14331d@intel.com>
Date: Wed, 20 May 2026 07:59:21 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Fix out of bounds access in
 cxl_cancel_auto_attach()
To: Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <djbw@kernel.org>
References: <20260519-fix_out_of_bounds_access-v1-1-55fc60d83388@zohomail.com>
 <25b0125a-b0fb-4401-8596-3252d2f8cbd6@intel.com>
 <cedaee55-ff31-4aa0-981e-938db56b2b45@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <cedaee55-ff31-4aa0-981e-938db56b2b45@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/20/26 5:30 AM, Li Ming wrote:
> 
> 在 2026/5/20 01:18, Dave Jiang 写道:
>>
>> On 5/19/26 6:23 AM, Li Ming wrote:
>>> In cxl_cancel_auto_attach(), it assumes cxled->pos is a valid index for
>>> accessing p->targets[]. However, cxled->pos can be set to -ENXIO in
>> It can be set to other error codes I think? I would just s/-ENXIO/negative errno/
> Sure, Will do that.
>>
>>> cxl_region_sort_targets() if cxl_calc_interleave_pos() fails. This
>>> causes the driver to use a negative index to access p->targets[],
>>> resulting in out-of-bounds access.
>>>
>>> Fix it by walking p->targets[] instead of using cxled->pos directly.
>> Does the comment in cxl_region_sort_targets() need to be updated with the new changes?
> 
> I'm not sure how to update the comment in cxl_region_sort_targets(). Any suggestion?

idk if we should just drop it entirely since the comment is no longer true. At least that second part. Alison?


> 
> 
> Ming
> 
>>
>>> Fixes: 87805c32e6ad ("cxl/region: Fix use-after-free from auto assembly failure")
>>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>> The rest LGTM
>>
>> DJ
>>
>>> ---
>>>   drivers/cxl/core/region.c | 35 ++++++++++++++++-------------------
>>>   1 file changed, 16 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index e50dc716d4e8..551228bc91f5 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -2202,18 +2202,30 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>>>       return 0;
>>>   }
>>>   -static int cxl_region_by_target(struct device *dev, const void *data)
>>> +static int cxl_region_remove_target(struct device *dev, void *data)
>>>   {
>>> -    const struct cxl_endpoint_decoder *cxled = data;
>>> +    struct cxl_endpoint_decoder *cxled = data;
>>>       struct cxl_region_params *p;
>>>       struct cxl_region *cxlr;
>>> +    int i;
>>>         if (!is_cxl_region(dev))
>>>           return 0;
>>>         cxlr = to_cxl_region(dev);
>>>       p = &cxlr->params;
>>> -    return p->targets[cxled->pos] == cxled;
>>> +    for (i = 0; i < p->nr_targets; i++) {
>>> +        if (p->targets[i] == cxled) {
>>> +            p->nr_targets--;
>>> +            cxled->state = CXL_DECODER_STATE_AUTO;
>>> +            cxled->pos = -1;
>>> +            p->targets[i] = NULL;
>>> +
>>> +            return 1;
>>> +        }
>>> +    }
>>> +
>>> +    return 0;
>>>   }
>>>     /*
>>> @@ -2222,25 +2234,10 @@ static int cxl_region_by_target(struct device *dev, const void *data)
>>>    */
>>>   static void cxl_cancel_auto_attach(struct cxl_endpoint_decoder *cxled)
>>>   {
>>> -    struct cxl_region_params *p;
>>> -    struct cxl_region *cxlr;
>>> -    int pos = cxled->pos;
>>> -
>>>       if (cxled->state != CXL_DECODER_STATE_AUTO_STAGED)
>>>           return;
>>>   -    struct device *dev __free(put_device) =
>>> -        bus_find_device(&cxl_bus_type, NULL, cxled, cxl_region_by_target);
>>> -    if (!dev)
>>> -        return;
>>> -
>>> -    cxlr = to_cxl_region(dev);
>>> -    p = &cxlr->params;
>>> -
>>> -    p->nr_targets--;
>>> -    cxled->state = CXL_DECODER_STATE_AUTO;
>>> -    cxled->pos = -1;
>>> -    p->targets[pos] = NULL;
>>> +    bus_for_each_dev(&cxl_bus_type, NULL, cxled, cxl_region_remove_target);
>>>   }
>>>     static struct cxl_region *
>>>
>>> ---
>>> base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
>>> change-id: 20260519-fix_out_of_bounds_access-8838759ee5a6
>>>
>>> Best regards,

