Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C9324E4A1;
	Wed, 20 May 2026 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280259; cv=pass; b=G0grFYy3ThYqnFIGCgkO+IWqzvTaj12YhLgPVWF09WyE20l/B7G1sUV+TRBt4vRf4/kFFN41ODpAWDS1cUfu8NKe+oWxdDiuX+aqXOluwbgZaNKKNz3Y365leFSlI8JbNDwe4dzJshDPIZtEHACw0k6jaxwSQn5Uno3FrzfouDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280259; c=relaxed/simple;
	bh=D/E8bOlYbAQLaoWRsGtN/wkdCb1mry2YvwBc0gSTAEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rMAfub5P5LdW8edNP37o8hmFEfu2GSQkr55raXODVsYo5843PSoJ/wh9qEqnXGxK0ci47jz7knkGDkrjkrLkBlNvCmzaNE5LVU1+Nk2nly3sQKzGhsOVDOD0Lm7JKAXlkoVKUIE0courLP0LWEjuZ9AziuMJ0fX0CZMRn0YF7Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=a35+TJcJ; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="a35+TJcJ"
ARC-Seal: i=1; a=rsa-sha256; t=1779280253; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FlBqqwykN+UzgOa0QEYBkCwPy7Ew5o+sGR96NRvtghIFcHnXQdegKU7TwLIZI64JWT1+we84iy5VAbp7Kp3cQsLgZu+ToBanHyPOLmK/KG8XDKStlZCym74wawUZUHdHiKoVoERgZ7BBiqvycFy7vggCc3ts5iRLyyxA+9XApFM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779280253; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xaLVCwWHO2IitJboH5v3OY7agVIZ3ZfkISRk+DFsucU=; 
	b=j44Khp91vX8K9WfKRCdbrVN0Yb9zlCN36hX3khwvPVQ27F8eR4ZjkbRoXYN2VaDoxmwYunzf/BdsDpKTDSzH++GYqCcfNda1PLFpox0ZyiVZg78idzRuqrA2xZzL5I6e4UWlxpKcDICz29U/m6iXwHhqCyxBBm+hhqB1RL7/sv4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779280253;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=xaLVCwWHO2IitJboH5v3OY7agVIZ3ZfkISRk+DFsucU=;
	b=a35+TJcJwHTZMbHX01RpUqv7Qfj+D9CSMA6Ib/0SzM7++7ReEwg0y5bOrXnTr/ua
	HsbbR26sa+TrR05Q84B3VMxSyGhtd6NsDxTOUbvDE7BLnkfmIGscduIJszRX0KI8bCK
	HwdEgBMezI/rAVhoaK29fjsQe55K9ep/y4QknCQM=
Received: by mx.zohomail.com with SMTPS id 1779280251420104.15642641922364;
	Wed, 20 May 2026 05:30:51 -0700 (PDT)
Message-ID: <cedaee55-ff31-4aa0-981e-938db56b2b45@zohomail.com>
Date: Wed, 20 May 2026 20:30:47 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Fix out of bounds access in
 cxl_cancel_auto_attach()
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <djbw@kernel.org>
References: <20260519-fix_out_of_bounds_access-v1-1-55fc60d83388@zohomail.com>
 <25b0125a-b0fb-4401-8596-3252d2f8cbd6@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <25b0125a-b0fb-4401-8596-3252d2f8cbd6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112270888d34bd454ec8210ad6a4f00000eb6419a7c23a9af36d7b8efa7096f58cfb20d6ca4230c6560:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/5/20 01:18, Dave Jiang 写道:
>
> On 5/19/26 6:23 AM, Li Ming wrote:
>> In cxl_cancel_auto_attach(), it assumes cxled->pos is a valid index for
>> accessing p->targets[]. However, cxled->pos can be set to -ENXIO in
> It can be set to other error codes I think? I would just s/-ENXIO/negative errno/
Sure, Will do that.
>
>> cxl_region_sort_targets() if cxl_calc_interleave_pos() fails. This
>> causes the driver to use a negative index to access p->targets[],
>> resulting in out-of-bounds access.
>>
>> Fix it by walking p->targets[] instead of using cxled->pos directly.
> Does the comment in cxl_region_sort_targets() need to be updated with the new changes?

I'm not sure how to update the comment in cxl_region_sort_targets(). Any 
suggestion?


Ming

>
>> Fixes: 87805c32e6ad ("cxl/region: Fix use-after-free from auto assembly failure")
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
> The rest LGTM
>
> DJ
>
>> ---
>>   drivers/cxl/core/region.c | 35 ++++++++++++++++-------------------
>>   1 file changed, 16 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index e50dc716d4e8..551228bc91f5 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2202,18 +2202,30 @@ static int cxl_region_attach(struct cxl_region *cxlr,
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
>> +	for (i = 0; i < p->nr_targets; i++) {
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
>> @@ -2222,25 +2234,10 @@ static int cxl_region_by_target(struct device *dev, const void *data)
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
>>
>> ---
>> base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
>> change-id: 20260519-fix_out_of_bounds_access-8838759ee5a6
>>
>> Best regards,
