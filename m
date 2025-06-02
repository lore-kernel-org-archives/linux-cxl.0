Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB941DF58;
	Mon,  2 Jun 2025 23:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748908657; cv=pass; b=HD8qUIZiV09nO3Ua612dkNABFgRzqYB5oBLc9n57K7yX8AiwC9uSaKwAWRbJTQpn1fNn6Lw7Or/CUoMLV1MtU+9odRD7+LSUeWbz+yfxP+tsI0NZ5bCfE6fglA/19pn+t9HwPTvzvMnc0tBnf/KDvf9D0zdHy5YmLoWBF48tpAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748908657; c=relaxed/simple;
	bh=/AaMx1KkKov7euq9bW+sYnENG609KtIIwk6/21G5uX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0bN63gog2RDVozK9/RyfY1NAYMot3k+T88l/7KUn/wxPZrr6EmvbeSxJYX9hEY+F9OZZbEDhTtA3FKdQqJNdFM3nTu7Yx7Khq5aw3fz2YxucYLkM4lOnwlP67gs0oONaHiZstVmB2rVSv9fFrB7fCQ/uBU8p+UzRfd0xE2P9GI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=JTz9FegJ; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="JTz9FegJ"
ARC-Seal: i=1; a=rsa-sha256; t=1748908641; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NNVXAClyAcq/e2T5opLAHhfNV6NwyBnLFJhl35TQz9WLnWO0RratY7XA2DO7Yfn1rXuSYENyg4GvLLpQyldrl2xhUPtbCZG7UNj9wE9YgFjxv+MOW+mgTQ2a6LCoKB1bgZGfCmgVykmdxdQb57cN+QmF+um7w6ebkQkN3Pl//pw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1748908641; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=n532nxp0rDiHnAPdPPmvoKaXfwAx/Gwgb+t1Ew+OE78=; 
	b=Kpe82yjzriHWBYNE6eFgZ1i3wIeyW19vzfnFidwnQ/hGZB7DDefTutHjKmqWCpote+3cbreKPxHgOWemLVF3fbTR6+JIllUoYuwErm8l5HiCJSP4AtVZuqvF1iI9U3G1Jf3lUc7WfxBK8cnsA6p9VjQt9iMMhfqbXUIbHhX8kGI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748908641;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=n532nxp0rDiHnAPdPPmvoKaXfwAx/Gwgb+t1Ew+OE78=;
	b=JTz9FegJ9xulv73NU9Dcj4vx7KB6cvbFKCCBiPyPv025xHw2GWOZZejMaizzieJd
	0uxWkj/MYJcD3KRm9+GIbzIZ0mh8vWc/zhuiMgLzEA7eun8SykSXCVFeo/Lb9aowy/W
	zVV9/WrrxMfEQU+mgrcE26BMw44PVYq2DLhhiVfY=
Received: by mx.zohomail.com with SMTPS id 1748908639508232.13497197880224;
	Mon, 2 Jun 2025 16:57:19 -0700 (PDT)
Message-ID: <96fedb6e-6184-4609-b249-4289f61d5003@zohomail.com>
Date: Tue, 3 Jun 2025 07:57:15 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] cxl/edac: Fix the min_scrub_cycle of a region
 miscalculation
To: Shiju Jose <shiju.jose@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: "dave@stgolabs.net" <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>,
 "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250530122852.10139-1-ming.li@zohomail.com>
 <aDn4o8Fw91vQ9D-D@aschofie-mobl2.lan>
 <bba0fc4616d54babb2b0113967acc95f@huawei.com>
 <aD3V1MbVV7RZmbu0@aschofie-mobl2.lan>
 <d036c22fc0e348a3ba7ecb0b4dbf35ba@huawei.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <d036c22fc0e348a3ba7ecb0b4dbf35ba@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr080112277d4a4e08dae40075da27ef7a0000e03eddd12b2ed080b156ee8a2c0a0378a3d7161711dfc98d5b:zu08011227e0631b9cf8211257fcf9409f0000f061b07ac347fc45990b661dabd6733427bef424ef9a1b4a66:rf0801122d686c01d30ab0e615a9d5827b0000ad623da6fb84ea20954cec980ecafd9ee96efd5bc06bb8b9c255369281a091:ZohoMail
X-ZohoMailClient: External

On 6/3/2025 1:25 AM, Shiju Jose wrote:
>> -----Original Message-----
>> From: Alison Schofield <alison.schofield@intel.com>
>> Sent: 02 June 2025 17:48
>> To: Shiju Jose <shiju.jose@huawei.com>
>> Cc: Li Ming <ming.li@zohomail.com>; dave@stgolabs.net; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>> vishal.l.verma@intel.com; ira.weiny@intel.com; dan.j.williams@intel.com; linux-
>> cxl@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [RFC PATCH 1/1] cxl/edac: Fix the min_scrub_cycle of a region
>> miscalculation
>>
>> On Mon, Jun 02, 2025 at 08:23:34AM +0000, Shiju Jose wrote:
>>>> -----Original Message-----
>>>> From: Alison Schofield <alison.schofield@intel.com>
>>>> Sent: 30 May 2025 19:28
>>>> To: Li Ming <ming.li@zohomail.com>
>>>> Cc: dave@stgolabs.net; Jonathan Cameron
>>>> <jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>>>> vishal.l.verma@intel.com; ira.weiny@intel.com;
>>>> dan.j.williams@intel.com; Shiju Jose <shiju.jose@huawei.com>; linux-
>>>> cxl@vger.kernel.org; linux-kernel@vger.kernel.org
>>>> Subject: Re: [RFC PATCH 1/1] cxl/edac: Fix the min_scrub_cycle of a
>>>> region miscalculation
>>>>
>>>> On Fri, May 30, 2025 at 08:28:52PM +0800, Li Ming wrote:
>>>>> When trying to update the scrub_cycle value of a cxl region, which
>>>>> means updating the scrub_cycle value of each memdev under a cxl
>>>>> region. cxl driver needs to guarantee the new scrub_cycle value is
>>>>> greater than the min_scrub_cycle value of a memdev, otherwise the
>>>>> updating operation will fail(Per Table 8-223 in CXL r3.2 section
>> 8.2.10.9.11.1).
>>>>> Current implementation logic of getting the min_scrub_cycle value
>>>>> of a cxl region is that getting the min_scrub_cycle value of each
>>>>> memdevs under the cxl region, then using the minimum
>>>>> min_scrub_cycle value as the region's min_scrub_cycle. Checking if
>>>>> the new scrub_cycle value is greater than this value. If yes,
>>>>> updating the new scrub_cycle value to each memdevs. The issue is
>>>>> that the new scrub_cycle value is possibly greater than the minimum
>>>>> min_scrub_cycle value of all memdevs but less than the maximum
>>>>> min_scrub_cycle value of all memdevs if memdevs have a different
>>>>> min_scrub_cycle value. The updating operation will always fail on
>>>>> these memdevs which have a greater min_scrub_cycle than the new
>> scrub_cycle.
>>>>> The correct implementation logic is to get the maximum value of
>>>>> these memdevs' min_scrub_cycle, check if the new scrub_cycle value
>>>>> is greater than the value. If yes, the new scrub_cycle value is fit for the
>> region.
>>>>> The change also impacts the result of
>>>>> cxl_patrol_scrub_get_min_scrub_cycle(), the interface returned the
>>>>> minimum min_scrub_cycle value among all memdevs under the region
>>>>> before the change. The interface will return the maximum
>>>>> min_scrub_cycle value among all memdevs under the region with the
>> change.
>>>>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>>>>> ---
>>>>> I made this change based on my understanding on the SPEC and
>>>>> current CXL EDAC code, but I am not sure if it is a bug or it is designed this
>> way.
>>>> The attribute is defined to show (per
>>>> Documentation/ABI/testing/sysfs-edac-
>>>> scrub)
>>>>   "Supported minimum scrub cycle duration in seconds by the memory
>>>> scrubber."
>>>>
>>>> Your fix, making the min the max of the mins, looks needed.
>>>>
>>>> I took a look at the max attribute. If the min is the max on the
>>>> mins, then the max should be the max of the maxes. But, not true. We do
>> this:
>>>> instead: *max = U8_MAX * 3600; /* Max set by register size */
>>>>
>>>> The comment isn't helping me, esp since the sysfs description doesn't
>>>> explain that we are using a constant max.
>>> CXL spec r3.2 Table 8-222. Device Patrol Scrub Control Feature
>>> Readable Attributes does not define a field for "max scrub cycle
>>> supported".  Thus for max scrub cycle, returning max value of (U8_MAX) of
>> patrol scrub cycle field.
>>
>> Understand that now, thanks. I'm still wondering if both these deserve more
>> explanation in Documentation/ABI/testing/sysfs-edac-scrub
>> explaining the calculations. Like if the device represents an aggregate of
>> devices, like a region, the min scrub cycle is the max of the mins, whereas if the
>> device is a single, it's exactly what the device returned.  And for max, explaining
>> what you replied above.
> Not sure is it appropriate to add these CXL scrub specific details to the generic file   
> Documentation/ABI/testing/sysfs-edac-scrub?
>
> CXL region specific details were added under section 1.2. Region based scrubbing
> of Documentation/edac/scrub.rst. May be better add these details for CXL specific
> min and max scrub cycle calculation to the Documentation/edac/scrub.rst?
>
> How do you want to post these suggested doc changes, in a follow-up patch now?
>
> Thanks,
> Shiju

I can include the doc changes in next version.


Thanks

Ming


>> Regardless of this noise I'm making about the Docs.. I think Ming should go
>> ahead and v1 the fix for the min calc.
>>
>> --Alison
>>
>>> Thanks,
>>> Shiju
>>>>
>>>>> base-commit: 9f153b7fb5ae45c7d426851f896487927f40e501 cxl/next
>>>>> ---
>>>>>  drivers/cxl/core/edac.c | 8 ++++++--
>>>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
>>>>> index
>>>>> 2cbc664e5d62..ad243cfe00e7 100644
>>>>> --- a/drivers/cxl/core/edac.c
>>>>> +++ b/drivers/cxl/core/edac.c
>>>>> @@ -103,10 +103,10 @@ static int cxl_scrub_get_attrbs(struct
>>>> cxl_patrol_scrub_context *cxl_ps_ctx,
>>>>>  				u8 *cap, u16 *cycle, u8 *flags, u8 *min_cycle)
>>>> {
>>>>>  	struct cxl_mailbox *cxl_mbox;
>>>>> -	u8 min_scrub_cycle = U8_MAX;
>>>>>  	struct cxl_region_params *p;
>>>>>  	struct cxl_memdev *cxlmd;
>>>>>  	struct cxl_region *cxlr;
>>>>> +	u8 min_scrub_cycle = 0;
>>>>>  	int i, ret;
>>>>>
>>>>>  	if (!cxl_ps_ctx->cxlr) {
>>>>> @@ -133,8 +133,12 @@ static int cxl_scrub_get_attrbs(struct
>>>> cxl_patrol_scrub_context *cxl_ps_ctx,
>>>>>  		if (ret)
>>>>>  			return ret;
>>>>>
>>>>> +		/*
>>>>> +		 * The min_scrub_cycle of a region is the maximum value
>>>> among
>>>>> +		 * the min_scrub_cycle of all the memdevs under the region.
>>>>> +		 */
>>>>>  		if (min_cycle)
>>>>> -			min_scrub_cycle = min(*min_cycle, min_scrub_cycle);
>>>>> +			min_scrub_cycle = max(*min_cycle, min_scrub_cycle);
>>>>>  	}
>>>>>
>>>>>  	if (min_cycle)
>>>>> --
>>>>> 2.34.1
>>>>>

