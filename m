Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF45477E55;
	Fri, 22 May 2026 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464666; cv=none; b=Lh+dd2F6fVCOx6iNGKJdgligGkt/2fHKuzZkS145RU7obqrbIZaUtbrIUUIIqhNHncH31Wu+NlFWyCB+B2COypNuyx7zZlFXf9GSTdf2CNXcYlUxVKAvcpgmYlpd+2Mo4ZZRnoEamt5Lv751S9rrME3Pn/vnFlqUu+2DMgmZrfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464666; c=relaxed/simple;
	bh=F9h68o6fjyyP+4rPa/kaWaAIp9phw74Od7npmULhHXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kFmchxnQZxGLcnRH6/SABKaDljWDMKpb6u0ZpWcGRveb9zT+43tsWi9g62zXeErjyfsHktZZUVnRQC27lb0mD8t22p6hNDSKZVneuJmbZfKOdgs3yw0EA8EW9MvdDWQmy7JN/vAYeEE0anPcjPPrvEMfdaQVBb9hAC8y7YJsfQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=afULI31y; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="afULI31y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779464663; x=1811000663;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F9h68o6fjyyP+4rPa/kaWaAIp9phw74Od7npmULhHXM=;
  b=afULI31y455Z6rdFfnqK2yqN4tj75UTSpIKMbrZa9zw+QXiJ/qDXwUia
   qIE9DnHbut7dgwkl+jf8j3/V3X5H5YngbHAcg7F9KsPn8HnhOty0HmESa
   A7hp1xNzSfuaymiM+ZcZnJEkHS/9YwCVrqf9k42MMIZv5q7Wv3yoNsyu2
   ZMZwhptoiNZoEBNzyHcM7MYlcXuvyUYaZ56i+M16jSQB+ccj3Jhi5gQVC
   c2zatHB4vrGf3TuheXxwWmmsj6gMyvT7E2uuGaK1mzKOXTZ3CWWcfTwD8
   rAf1g3VFUm8w7IDEYKEqXaGPVTmcjrlEYjHIQ60rMQ0eofrmKK2taxU9V
   w==;
X-CSE-ConnectionGUID: jJnGzSJRQtei8hlSigbokg==
X-CSE-MsgGUID: zr6sKXQ3RMueAfsO7EfW3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="97818824"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="97818824"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 08:44:21 -0700
X-CSE-ConnectionGUID: THss/askQOKwJiiFvcRKdw==
X-CSE-MsgGUID: 9X5NLiCiRca9bNgwC1hYDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="240111453"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.110.86]) ([10.125.110.86])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 08:44:21 -0700
Message-ID: <e0ad8650-414a-4f9b-a419-60476c44e6a2@intel.com>
Date: Fri, 22 May 2026 08:44:20 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Fix out of bounds access in
 cxl_cancel_auto_attach()
To: Li Ming <ming.li@zohomail.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <djbw@kernel.org>
References: <20260519-fix_out_of_bounds_access-v1-1-55fc60d83388@zohomail.com>
 <25b0125a-b0fb-4401-8596-3252d2f8cbd6@intel.com>
 <cedaee55-ff31-4aa0-981e-938db56b2b45@zohomail.com>
 <8a835dea-956f-4eab-931c-e1a54e14331d@intel.com>
 <ag6rFgctpwSNPWgt@aschofie-mobl2.lan>
 <f27fef4c-6b27-4027-88bb-0db57c1b346a@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <f27fef4c-6b27-4027-88bb-0db57c1b346a@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/22/26 1:49 AM, Li Ming wrote:
> 
> 在 2026/5/21 14:52, Alison Schofield 写道:
>> On Wed, May 20, 2026 at 07:59:21AM -0700, Dave Jiang wrote:
>>>
>>> On 5/20/26 5:30 AM, Li Ming wrote:
>>>> 在 2026/5/20 01:18, Dave Jiang 写道:
>>>>> On 5/19/26 6:23 AM, Li Ming wrote:
>>>>>> In cxl_cancel_auto_attach(), it assumes cxled->pos is a valid index for
>>>>>> accessing p->targets[]. However, cxled->pos can be set to -ENXIO in
>>>>> It can be set to other error codes I think? I would just s/-ENXIO/negative errno/
>>>> Sure, Will do that.
>>>>>> cxl_region_sort_targets() if cxl_calc_interleave_pos() fails. This
>>>>>> causes the driver to use a negative index to access p->targets[],
>>>>>> resulting in out-of-bounds access.
>>>>>>
>>>>>> Fix it by walking p->targets[] instead of using cxled->pos directly.
>>>>> Does the comment in cxl_region_sort_targets() need to be updated with the new changes?
>>>> I'm not sure how to update the comment in cxl_region_sort_targets(). Any suggestion?
>>> idk if we should just drop it entirely since the comment is no longer true. At least that second part. Alison?
>> I'd like to see it replaced w this so we continue to have the
>> debug info, but stop the lie that led to this issue.
>>
>> /*
>>   * Record that sorting failed, but still continue to calc
>>   * cxled->pos so that cxl_calc_interleave_pos() emits its
>>   * dev_dbg() for every member, which is useful for auto
>>   * discovery debug.
>>   */
>>
>> snip
>>
>>>>>> +static int cxl_region_remove_target(struct device *dev, void *data)
>>>>>>    {
>>>>>> -    const struct cxl_endpoint_decoder *cxled = data;
>>>>>> +    struct cxl_endpoint_decoder *cxled = data;
>>>>>>        struct cxl_region_params *p;
>>>>>>        struct cxl_region *cxlr;
>>>>>> +    int i;
>>>>>>          if (!is_cxl_region(dev))
>>>>>>            return 0;
>>>>>>          cxlr = to_cxl_region(dev);
>>>>>>        p = &cxlr->params;
>>>>>> -    return p->targets[cxled->pos] == cxled;
>>>>>> +    for (i = 0; i < p->nr_targets; i++) {
>>>>>> +        if (p->targets[i] == cxled) {
>>>>>> +            p->nr_targets--;
>>>>>> +            cxled->state = CXL_DECODER_STATE_AUTO;
>>>>>> +            cxled->pos = -1;
>>>>>> +            p->targets[i] = NULL;
>>>>>> +
>>>>>> +            return 1;
>>>>>> +        }
>>>>>> +    }
>> Sashiko review looks like it is calling out a valid 'hole' issue above.
>> Does the array need to be compacted when we remove an entry that is not
>> the last. That would keep nr_targets same as 'first free slot', so
>> there are no NULL holes. I think that fix goes in a separate patch.
> 
> Good catch, how about using p->interleave_ways instead of p->nr_targets as the loop condition? I think it can solve the problem.
> 
> BTW, where did you get the Sashiko review? I didn't get any email from it.

You'll have to look, unless you cc Sachiko with your patch submission. I've asked to have linux-cxl added to Sachiko review.
https://sashiko.dev/#/?list=org.kernel.vger.linux-cxl


> 
> 
> Ming
> 

