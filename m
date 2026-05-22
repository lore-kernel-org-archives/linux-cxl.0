Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC7D3A3834;
	Fri, 22 May 2026 08:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779439777; cv=pass; b=LwPIoYmR3w6uCb5MK8zTPhfsJ9JH3JPEfPZrnx5Thxkn9JubNZNr+J/PiSqO7V2i9jk+spN6+uVGoLyu0He6YoOUkz0dDnqTYIdE7HUuydyTUivSQ3zVgWClCX7nFWvgjlPUFK3RuKK09euOUQ5V33V9kP0FfUSyGVS5ioOEEHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779439777; c=relaxed/simple;
	bh=VCNqmm8kjzrYMwFZeIu7tYzNRxEWMfU4GeEiFfKNisA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DfMdZvot18bo1OGyom/KWZwWQpJhLNFnzFzxJpjITFI/wqaRNK0EYgYl+xvXkAIBu509CIgVYneDRvP2tKB73VjURolTUiiZ5KUgobMdQaXQvM9N7SD0gPhd0WgJlPz6dnj54BSijZjI1hylyqX3RCbR+QILqs/ut5YqH/QbTvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=HXLBonOC; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="HXLBonOC"
ARC-Seal: i=1; a=rsa-sha256; t=1779439767; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LnzI2iHugur8mj80ltaidO3uQNXHnpWYeqsJETLunfwDkb3EnlBGhIdNM0KlfTDpHiQoQfcxHq/vAi5JJHAq05w7T0Lh5RgLDqqHccuV9oZI1RlQuuSuI4UW+fiPNIkI5kEoZcpT8pnyvgFON2kZCEmDznT/MHpl3jbCgGck0ig=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779439767; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=USJ2hhwlRdNIh464dNbcfB2qR8UIdgBLaFkTWfjRM3g=; 
	b=Rexu2V8N1+SKWppw1runEbONUkZhV3cCV5NKXxSccj7LHJ5+cuOazEJVgFTAbnvVo/KDPL2H+pHUKN+6DzIk5zwqzy5FsSPExdrb/JA3fB9gpc1zyTldXeGuqJoSExz6VFWfNQWxGV+gk+DwvBKiZVI5sx0WbV2N7N/Ha4kYto8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779439767;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=USJ2hhwlRdNIh464dNbcfB2qR8UIdgBLaFkTWfjRM3g=;
	b=HXLBonOC8XNBPc87lfBrc7uH33uFGnT9A+DmljetSt5jrr5VAsNzR9ZYaDRgg+uN
	vq8gkESP3Oi7WCP8UspPHYcoJBk0jkDIj2BRnt5ndjxXl7bb+6d7NC49MZMuGwdv2/V
	hNFykdQTEH30Z3wbAABdUP2db9kxwMp51Zr7NegY=
Received: by mx.zohomail.com with SMTPS id 1779439763589500.74481097419323;
	Fri, 22 May 2026 01:49:23 -0700 (PDT)
Message-ID: <f27fef4c-6b27-4027-88bb-0db57c1b346a@zohomail.com>
Date: Fri, 22 May 2026 16:49:17 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Fix out of bounds access in
 cxl_cancel_auto_attach()
To: Alison Schofield <alison.schofield@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <djbw@kernel.org>
References: <20260519-fix_out_of_bounds_access-v1-1-55fc60d83388@zohomail.com>
 <25b0125a-b0fb-4401-8596-3252d2f8cbd6@intel.com>
 <cedaee55-ff31-4aa0-981e-938db56b2b45@zohomail.com>
 <8a835dea-956f-4eab-931c-e1a54e14331d@intel.com>
 <ag6rFgctpwSNPWgt@aschofie-mobl2.lan>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <ag6rFgctpwSNPWgt@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112273dc5e20f9c61216eee764ebf00000a3729b387925dd7b994b9b61dde862cf36b427e81802ff5e1:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/5/21 14:52, Alison Schofield 写道:
> On Wed, May 20, 2026 at 07:59:21AM -0700, Dave Jiang wrote:
>>
>> On 5/20/26 5:30 AM, Li Ming wrote:
>>> 在 2026/5/20 01:18, Dave Jiang 写道:
>>>> On 5/19/26 6:23 AM, Li Ming wrote:
>>>>> In cxl_cancel_auto_attach(), it assumes cxled->pos is a valid index for
>>>>> accessing p->targets[]. However, cxled->pos can be set to -ENXIO in
>>>> It can be set to other error codes I think? I would just s/-ENXIO/negative errno/
>>> Sure, Will do that.
>>>>> cxl_region_sort_targets() if cxl_calc_interleave_pos() fails. This
>>>>> causes the driver to use a negative index to access p->targets[],
>>>>> resulting in out-of-bounds access.
>>>>>
>>>>> Fix it by walking p->targets[] instead of using cxled->pos directly.
>>>> Does the comment in cxl_region_sort_targets() need to be updated with the new changes?
>>> I'm not sure how to update the comment in cxl_region_sort_targets(). Any suggestion?
>> idk if we should just drop it entirely since the comment is no longer true. At least that second part. Alison?
> I'd like to see it replaced w this so we continue to have the
> debug info, but stop the lie that led to this issue.
>
> /*
>   * Record that sorting failed, but still continue to calc
>   * cxled->pos so that cxl_calc_interleave_pos() emits its
>   * dev_dbg() for every member, which is useful for auto
>   * discovery debug.
>   */
>
> snip
>
>>>>> +static int cxl_region_remove_target(struct device *dev, void *data)
>>>>>    {
>>>>> -    const struct cxl_endpoint_decoder *cxled = data;
>>>>> +    struct cxl_endpoint_decoder *cxled = data;
>>>>>        struct cxl_region_params *p;
>>>>>        struct cxl_region *cxlr;
>>>>> +    int i;
>>>>>          if (!is_cxl_region(dev))
>>>>>            return 0;
>>>>>          cxlr = to_cxl_region(dev);
>>>>>        p = &cxlr->params;
>>>>> -    return p->targets[cxled->pos] == cxled;
>>>>> +    for (i = 0; i < p->nr_targets; i++) {
>>>>> +        if (p->targets[i] == cxled) {
>>>>> +            p->nr_targets--;
>>>>> +            cxled->state = CXL_DECODER_STATE_AUTO;
>>>>> +            cxled->pos = -1;
>>>>> +            p->targets[i] = NULL;
>>>>> +
>>>>> +            return 1;
>>>>> +        }
>>>>> +    }
> Sashiko review looks like it is calling out a valid 'hole' issue above.
> Does the array need to be compacted when we remove an entry that is not
> the last. That would keep nr_targets same as 'first free slot', so
> there are no NULL holes. I think that fix goes in a separate patch.

Good catch, how about using p->interleave_ways instead of p->nr_targets 
as the loop condition? I think it can solve the problem.

BTW, where did you get the Sashiko review? I didn't get any email from it.


Ming

