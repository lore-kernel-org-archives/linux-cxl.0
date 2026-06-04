Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F3648167B;
	Thu,  4 Jun 2026 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579701; cv=pass; b=SNg0dLWwiSpuOyLPdOi7BaMNinFINiT2MtI6/2UAGXNVz2tRT3LMGx+MgJvdUNQN/k4Y8QD0sYa8uAqbrv45TRdULtmyUg1ckyjD5CoumV3Njsk0n+eT5Ed+X7j6E/e3H2f+8sYrd2iU9cW8k2UU3EIENL+1nU2ebz1bWHvfu3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579701; c=relaxed/simple;
	bh=MMMJQJ3kbv13NnH5XlraKPLD9idUhSOjppL6nLO4TXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/atxLnFHRzs9iwOqmwdEG5vBpA1RE4ntks5G6By8U/QJySIhNu3Y/fvqCsxn9fpjveFfKbU+yReQPGv560KJ+kC63PRGNaWhQbQoTiF79XF+jW/opKK+lGpqgW/YVRY9oTICQmtfq/k+KWZi0KUpNfDE6B4KOZvdjjdR7guJmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=RUbyEodC; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="RUbyEodC"
ARC-Seal: i=1; a=rsa-sha256; t=1780579692; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DYSQyypJuLvJSKhJ25wX0kB90wblUVhNy6u97XOTXAU083io3/uxcs5dRSl6rugEoT6pPeJSSO7nCoDclPQXRrJlChIA5ied0nmVmCWYPZlA011jge5yW4cg0b1w00XkgOAuF40gy3n1uCj3aPI8qphf98PgWngYy+1ofEGnPBk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780579692; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GOa3uS5/mOmSzj2p3XNhlvDlNyO/mfnKKj4N402T3xQ=; 
	b=dYcB3nX6E0O4Mh/bgdJ7Z/tRNA5egWFpF/wEZ1QwqvYytU3lF59dpIBrXW3lySlekP0z+3aX156crHKgMzBoQqBA0X2pxJvMb4SK1udGWjP1W60rFsrR33GOcXgnKfMruHGj5ae/05D5/7CFtFcmraXcIWSk35x/7s2rH7Trw5A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780579692;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=GOa3uS5/mOmSzj2p3XNhlvDlNyO/mfnKKj4N402T3xQ=;
	b=RUbyEodC1kY0KpEO0jhUfPJtDPtzB4/g9M6mFUzvmnwiaPnze+w1Dbd32i+tLr8E
	CqUFVGDAp7e70ZrMw5Jc/e86yoocWm2ERFhXMaK/gyIqcmXMOOs31prOvasmJyYxQbt
	RT8g0soUbyMy8gj0cHq0vnz6xNHiYPojSleyTHDM=
Received: by mx.zohomail.com with SMTPS id 1780579689280576.7648943640623;
	Thu, 4 Jun 2026 06:28:09 -0700 (PDT)
Message-ID: <09a534c2-3dc2-4fd9-a69b-c26771af45f1@zohomail.com>
Date: Thu, 4 Jun 2026 21:28:02 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Fix NULL pointer within p->targets[]
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <djbw@kernel.org>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260530-fix_null_in_targets_array-v1-1-312c3bf1fe0f@zohomail.com>
 <aiCtet61qSddQ-Pr@aschofie-mobl2.lan>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <aiCtet61qSddQ-Pr@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227865b78cb1fa8d6567a60de280000462513c8a19e829e18f59f208c3c8217b0f1af4554e86a38f7:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/6/4 06:40, Alison Schofield 写道:
> On Sat, May 30, 2026 at 12:24:40PM +0800, Li Ming wrote:
>> cxl_region_remove_target() leaves a NULL pointer in the slot of the
>> removable endpoint decoder in p->targets array. However, p->targets
>> array replies on p->nr_targets to determine validity, which means when
>> p->nr_targets == p->interleave_ways, driver assumes all elements from
>> index 0 to (p->nr_targets - 1) are valid. The stale NULL pointer
>> violates this assumption and causes the driver to treat a NULL pointer
>> as a valid endpoint decoder.
>>
>> To fix this issue, when a endpoint decoder is removed by
>> cxl_region_remove_target(), always swap the last valid endpoint decoder
>> pointer into the slot of removal endpoint decoder to ensure all pointers
>> before p->targets[p->nr_targets] are valid.
>>
>> Fixes: 809ccef5385f ("cxl/region: Fix out-of-bounds access in cxl_cancel_auto_attach()")
>> Suggested-by: Alison Schofield <alison.schofield@intel.com>
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>> ---
>>   drivers/cxl/core/region.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index e90c024c8036..54018db87a4c 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2220,7 +2220,15 @@ static int cxl_region_remove_target(struct device *dev, void *data)
>>   			p->nr_targets--;
>>   			cxled->state = CXL_DECODER_STATE_AUTO;
>>   			cxled->pos = -1;
>> -			p->targets[i] = NULL;
>> +
>> +			/*
>> +			 * Swap the last valid target into the slot to
>> +			 * ensure no invalid target in p->nr_targets range.
>> +			 * The targets array will be re-sorted during the
>> +			 * last endpoint decoder attaching again.
>> +			 */
>> +			p->targets[i] = p->targets[p->nr_targets];
>> +			p->targets[p->nr_targets] = NULL;
>>   
>>   			return 1;
>>   		}
> Hi Ming,
>
> I'm replying to top post here, but I have read the Sashiko response
> and your response to that.
>
> I'm offering review on the target list holes, but deferring on the
> issue with cxl_rr_free_decoder because I think it's a narrow window
> and it would not belong in *this* patch. (and maybe I'm running
> out of steam too ;))
>
> For the target list holes. I think there may be a single change
> that can fix both the site you've fixed in this patch, and the
> decoder detach site that Sashiko calls out.
>
> Rather than add compaction at each removal site, make the AUTO
> 'appender' insert the decoder in the first free slot instead of
> blindly at p->targets[p->nr_targets].
>
>      /* Use first free slot. Do not assume nr_targets is dense */
>      for (pos = 0; pos < p->interleave_ways; pos++)
>              if (!p->targets[pos])
>                      break;
>      ...
>      p->targets[pos] = cxled;
>      cxled->pos = pos;
Yes, I think it can solve the problem, I will take a try.
>
>
> My reasoning, that you'll need to prove -
>
> - Removal only leaves a hole. The damage happens later in the appender
> Fix the appender and the hole becomes harmless no matter who created it.
>
> - It covers the cancel-auto site because a hole left by the staging
> cancel is skipped by the next append, so the swap-compaction in this
> patch is no longer needed.

Yes, if we use finding the first free slot for a decoder attachment, we 
will not need swap-compaction. But we should reuse p->interleave_ways 
instead of p->nr_targets for walking p->targets array in 
cxl_region_remove_target(), consecutive detach will have problem without 
that. Like this:

p->nr_targets = 4

[-1, 1, 2, 3]    # __cxl_decoder_detach() called for pos 1, remove it.


p->nr_targets = 3

[-1, NULL, 2, 3] # __cxl_decoder_detach() called for pos 3, but it have 
no chance to be accessed by cxl_region_remove_target().


Maybe Dave could drop the OOB fix, I will send out a patchset that 
includes both the "insert decoder in the first free slot" and the OOB fix.


>
> - It covers the decoder detach site similarly (per Sashiko). The NULL
> left by __cxl_decoder_detach() is filled on re-attach instead of being
> appended past. Your reproduce seems like it would verify that.
>
> - It needs no manual-vs-auto special case. An AUTO region has exactly
> interleave_ways slots and interleave_ways members, so first-free-slot
> keeps the array dense whenever it is full. The manual path is
> untouched.
>
> I'd probably rename to something like:
> cxl/region: Fill first free targets[] slot during auto-discovery
Will do
>
> BTW the fixes tag is not the OOB fix but is the original commit,
> the same one you used in the OOB fix. 87805c32e6ad

Sure, Will fix it, thanks.


Ming

>
> -- Alison
>
>
>> ---
>> base-commit: 809ccef5385fa1779c7db3de43272f3fc6a87a45
>> change-id: 20260530-fix_null_in_targets_array-124303a8ba0f
>>
>> Best regards,
>> -- 
>> Li Ming <ming.li@zohomail.com>
>>
>>
