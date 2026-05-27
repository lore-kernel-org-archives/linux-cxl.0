Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06FE40F8E4;
	Wed, 27 May 2026 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888789; cv=pass; b=qEF6XHnyMx4Vx09gINu5ZBDH/bWBT8UC+tDjj9MSTMNG+lDA8Tos64s1RQ52ySNIyDUj702YZN3aDQlLPSgmXodJsOQHZVN+knUXtlbM4/Nbpo1kiqhES9xH68wA96OQrRAeWIY1IlrpzfMpliJoFrYlqDGPhQmAYuAtRWv3XvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888789; c=relaxed/simple;
	bh=Jlv0h7sW4FP6lUUZZW2xuMdsi1yllOumflr2VeS88TA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8gtW31p3O3tbUMn8YZN7bjLhz6QMl/TiDLGNKzIIDasxnE8KXenbHOAMmLtG3VukG/zsMLyZeOMOzfHmuYeP1z4X5E+7f9cMHBT4FPB2pRkdbZhLyg7eqrrs8SjSy3BqPZOAAJv05IJpFboGpsQrB9XYLwK4fyaXKk5/3RDjT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=C+qnGbGG; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="C+qnGbGG"
ARC-Seal: i=1; a=rsa-sha256; t=1779888782; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Nm+KgtG0IcBb9WwPyBrcli9A9V1xvpXByxX5ZbGkvUSizP2c2vEzQoFCh8yBd7dkGdArWlQFuWYbcpAXcWkLi50XDAig7lapMI7SrBvWSvzsFzNoVZAHYfETA84lSKzncOuaXYl2v/YrC1d0cIoMxrTxw2D9dEXrsCMrkrZvsKY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779888782; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Vgp9dnYWiMOfwoVPo1Vxv5REqIFiVsR13BzejnM1gOI=; 
	b=YUNCRMZTrSiAuH1ZMuHX2a3/eCe9sHxOXhtsWrCfB8CdKKD6ykhod5CPZef34MWXAGMT7iqm9MZeWuqaHvolGuHSDKiTNk6+DAfLgksuBgi6WT5e71QIFgnMkpaSDyZTVRocNFMqV/2eWeWcLOydIrx/Mh62YT77wbl89ShZ5xw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779888782;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=Vgp9dnYWiMOfwoVPo1Vxv5REqIFiVsR13BzejnM1gOI=;
	b=C+qnGbGGpGTb4muqa6J83OivZ+Q9LbL3eKRW9VbNd95sqmSjpEaV9F58MB9vARLs
	dwg8+sVmUInBYkzt5XU1QQjAv+6MMvizkyFxoKYJBD77f6D5wVKn3i55xCIRQi8yfaP
	AMsnJFoR1+SJ6IzLDfccveULwY3VgKXJ5WK2GEx0=
Received: by mx.zohomail.com with SMTPS id 1779888778732794.2749209878926;
	Wed, 27 May 2026 06:32:58 -0700 (PDT)
Message-ID: <1f7d91e1-94e0-41cd-b1bc-72d8905358fd@zohomail.com>
Date: Wed, 27 May 2026 21:32:54 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] cxl/region: Fix out-of-bounds access in
 cxl_cancel_auto_attach()
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, djbw@kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260524095620.636535-1-ming.li@zohomail.com>
 <ahYnR1hMdweV5o3U@aschofie-mobl2.lan>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <ahYnR1hMdweV5o3U@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227381fadb4a7a0c7a250b792e30000e06b727231b6d216d489e6e5730ce3df9f961d211bac9b3c1b:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/5/27 07:05, Alison Schofield 写道:
> On Sun, May 24, 2026 at 05:56:20PM +0800, Li Ming wrote:
>> In cxl_cancel_auto_attach(), it assumes cxled->pos is a valid index for
>> accessing p->targets[]. However, cxled->pos can be set to negative errno
>> in cxl_region_sort_targets() if cxl_calc_interleave_pos() fails. This
>> causes the driver to use a negative index to access p->targets[],
>> resulting in out-of-bounds access.
>>
>> Fix it by walking p->targets[] instead of using cxled->pos directly.
>>
>> Fixes: 87805c32e6ad ("cxl/region: Fix use-after-free from auto assembly failure")
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>> ---
>> Changes from v1:
>> - Update commit log. (Dave)
>> - Update comment in cxl_region_sort_targets(). (Dave)
>> - Fix potential 'hole' issue. (Alison & Sashiko review)
> The switch in v2 to walk using p->interleave_ways instead of
> p->nr_targets fixes the 'hole' issue inside the cancel walker
> but there are more places where a corrupt target array will
> cause problems.
>
> cxl_region_attach_auto() and cxl_region_sort_targets() both assume
> that p->targets[] has no NULL gap. We need to compact that array on
> cancel so that nr_targets remains the index of the first free slot,
> with no gap below it.

I think I got your point, if cxl_region_attach_auto() is called after 
cxl_cancel_auto_attach(), It will rewrite p->targets[p->nr_targets] with 
the new cxled, the previous cxled in the slot will be dropped.


> If you do want to fix both things in one patch, then uplevel the subject
> line to something like:
>          cxl/region: Fix corruption of p->targets[] on auto-attach cancellation
> and have the body describe and address both the OOB access and the compaction.
>
> BTW I don't feel too strongly about combined vs separate patches, but I
> don't think this OOB patch should add in a partial fixup for the hole issue.

If my understanding is correct, I think they are two different issues, 
split into two separate patches would be better.

Ming

>
>> ---
>>   drivers/cxl/core/region.c | 40 +++++++++++++++++++--------------------
>>   1 file changed, 19 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index e50dc716d4e8..8956b049c462 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2011,8 +2011,9 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
>>   		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
>>   		/*
>>   		 * Record that sorting failed, but still continue to calc
>> -		 * cxled->pos so that follow-on code paths can reliably
>> -		 * do p->targets[cxled->pos] to self-reference their entry.
>> +		 * cxled->pos so that cxl_calc_interleave_pos() emits its
>> +		 * dev_dbg() for every member. which is useful for auto
>> +		 * discovery debug.
>>   		 */
>>   		if (cxled->pos < 0)
>>   			rc = -ENXIO;
>> @@ -2202,18 +2203,30 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>>   	return 0;
>>   }
>>   
>> -static int cxl_region_by_target(struct device *dev, const void *data)
>> +static int cxl_region_remove_target(struct device *dev, void *data)
>>   {
>> -	const struct cxl_endpoint_decoder *cxled = data;
>> +	struct cxl_endpoint_decoder *cxled = data;
>>   	struct cxl_region_params *p;
>>   	struct cxl_region *cxlr;
>> +	int i;
>>   
>>   	if (!is_cxl_region(dev))
>>   		return 0;
>>   
>>   	cxlr = to_cxl_region(dev);
>>   	p = &cxlr->params;
>> -	return p->targets[cxled->pos] == cxled;
>> +	for (i = 0; i < p->interleave_ways; i++) {
>> +		if (p->targets[i] == cxled) {
>> +			p->nr_targets--;
>> +			cxled->state = CXL_DECODER_STATE_AUTO;
>> +			cxled->pos = -1;
>> +			p->targets[i] = NULL;
>> +
>> +			return 1;
>> +		}
>> +	}
>> +
>> +	return 0;
>>   }
>>   
>>   /*
>> @@ -2222,25 +2235,10 @@ static int cxl_region_by_target(struct device *dev, const void *data)
>>    */
>>   static void cxl_cancel_auto_attach(struct cxl_endpoint_decoder *cxled)
>>   {
>> -	struct cxl_region_params *p;
>> -	struct cxl_region *cxlr;
>> -	int pos = cxled->pos;
>> -
>>   	if (cxled->state != CXL_DECODER_STATE_AUTO_STAGED)
>>   		return;
>>   
>> -	struct device *dev __free(put_device) =
>> -		bus_find_device(&cxl_bus_type, NULL, cxled, cxl_region_by_target);
>> -	if (!dev)
>> -		return;
>> -
>> -	cxlr = to_cxl_region(dev);
>> -	p = &cxlr->params;
>> -
>> -	p->nr_targets--;
>> -	cxled->state = CXL_DECODER_STATE_AUTO;
>> -	cxled->pos = -1;
>> -	p->targets[pos] = NULL;
>> +	bus_for_each_dev(&cxl_bus_type, NULL, cxled, cxl_region_remove_target);
>>   }
>>   
>>   static struct cxl_region *
>> -- 
>> 2.43.0
>>
