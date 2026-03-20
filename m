Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3B03B6371;
	Fri, 20 Mar 2026 12:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774011427; cv=pass; b=abg3I2cwSuzZRCmkBOzJgcYzMEoULGeZhA5/DsPitbAB9c2uhrBeSbbcibrrZzRFxVMcHew6DuQjFMD9rKLCyesDxjfMklSdU5r7c96U2PBy2ZoPfo3ivBpL9JgBXD6Xcx+f19Kq//ZCAGsG86SFMYJccO/3wRgfQbhNlFRJqBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774011427; c=relaxed/simple;
	bh=zSaepMYM55O16odBVqqh39LAD5jUzoN0jCx1n8alfF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aWYrgGDlPjRgBxevufxcaJNr3rbk+8B8e3PDrSZ8SyBD/DLzpVOmLhXUwjtRuaEItGnwD2OgX8gyBdXcQFOAMtkZJnHwJSVGRY4uxl8wOheFhObzpoVleMwJqQARGDTMViQtPH4q48SWD8el681BKS0+Ej1/xmvjreQ66PsLJzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Q5IQTC/c; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Q5IQTC/c"
ARC-Seal: i=1; a=rsa-sha256; t=1774011414; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NLAkP/RGzEgjeskX0BRE8DKlApH56t/t3hxHj6d80+Xy9px2UxDKqJgjuqaKRF4tVstddPUWP/0HdCADgVCVIP3N9IGMhZG2gj1+BwFjLdSpmEs9nsBJMe95HnsDfOlKU5DE7X9ZV2UL1e2FPqvRGZLE580lNG9oLoCpelBXLwc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774011414; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LkZsWWSRjP5Q74DR0+bJDqxc8/Y5UNABD0huAkZ64e8=; 
	b=jbEdxz9zYbeKiNhjTz1IcJK6molrP3mG+LClyjJbZkUMNRFBlBmiffLmihAzwiF99OPw4uVkJD+345o9KkVhc1T5Nq4qvECre9nntpFs5yyNviMVwwToWKGhiD0uH9Dd1g9jYmwOhEN9i88Bcwy8Ltx3zOLgze1+5QOYY6kJHM8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774011414;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=LkZsWWSRjP5Q74DR0+bJDqxc8/Y5UNABD0huAkZ64e8=;
	b=Q5IQTC/cidleXp0MIsQQYCdXLdowHYNuUKme7AZ/bIUsU/FPjl9ahjvvDavAl/9D
	erxoO+LS+qQ1n5kTC/pXTrwexMLrpUWTLjHFCAgO0Y4sn2qq9oSNU3l4iVK4UfE+oGq
	5b/1nX8hwajqW5fNtQxszbMenK4lXjtCKog5jvic=
Received: by mx.zohomail.com with SMTPS id 1774011412182471.4492405073473;
	Fri, 20 Mar 2026 05:56:52 -0700 (PDT)
Message-ID: <b0997e23-329c-453c-95d2-9f8a239440f6@zohomail.com>
Date: Fri, 20 Mar 2026 20:56:48 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/hdm: Add support for 32 switch decoders
To: Alison Schofield <alison.schofield@intel.com>,
 Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
References: <20260318-add_support_for_32_decoders-v1-1-bb7b41efde2a@zohomail.com>
 <69f68851-9e02-431a-9331-8f687bb2fa4a@intel.com>
 <291ac46e-67cb-4732-8626-e0c434ede12f@zohomail.com>
 <abyrCJGqMTsyPnMN@aschofie-mobl2.lan>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <abyrCJGqMTsyPnMN@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122873ada527f25ff83c9e1bc503000012335693f1fcec6c3622ad9c0694798a09ccf75deec50c29e70c:zu080112276ff03b2197561995fe9f78140000d7956b4c41aace435e288a3e5d93b1eb051208be99428b7fae:rf0801122d8b6e58dfa6d501462b0879c9000063670d981458a1767ccb0ca4c18f4b06718bc3bd8c915d93966cb7f33c284a:ZohoMail
X-ZohoMailClient: External


在 2026/3/20 10:03, Alison Schofield 写道:
> On Thu, Mar 19, 2026 at 07:11:34PM +0800, Li Ming wrote:
>> 在 2026/3/18 23:40, Dave Jiang 写道:
>>> On 3/18/26 6:00 AM, Li Ming wrote:
>>>> Per CXL r4.0 section 8.2.4.20.1. CXL host bridge and switch ports can
>>>> support 32 HDM decoders. Current implementation misses some decoders on
>>>> CXL host bridge and switch in the case that the value of Decoder Count
>>>> field in CXL HDM decoder Capability Register is greater than or equal to
>>>> 9.
>>>>
>>>> Update calculation implementation to ensure the decoder count calculation
>>>> is correct for CXL host bridge/switch ports.
>>>>
>>>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>>>> ---
>>>>    drivers/cxl/cxl.h | 7 ++++++-
>>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>>> index 9b947286eb9b..466b8eeefed7 100644
>>>> --- a/drivers/cxl/cxl.h
>>>> +++ b/drivers/cxl/cxl.h
>>>> @@ -77,7 +77,12 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>>>>    {
>>>>    	int val = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
>>>> -	return val ? val * 2 : 1;
>>>> +	if (!val)
>>>> +		return 1;
>>>> +	else if (val <= 8)
>>>> +		return val * 2;
>>>> +	else
>>>> +		return 4 * (val - 4);
>>> That looks a bit messy. How about:
>>>
>>> switch (val) {
>>> case 0:
>>> 	return 1;
>>> case 1..8:
>>> 	return val * 2;
>>> case 9..12:
>>> 	return val 4 * (val - 4);
>>> default:
>>> 	return -ENXIO;
>>> }
>>>
>>> DJ
>> Sure, will do that in v2.
> Hi Ming,
>
> You may have already spied this while implementing. Before this change
> this function could only return 1 or val*2, so never negative. Adding
> -ENXIO changes that and could wrap to huge value in the decoder for
> loops. Change decoder_count field to int to clean that up.
>
> Or, you could do something like this:
> 	WARN_ONCE(1, "reserved HDM decoder count field: %d\n", val);
>          return 0;
>
> I like the ENXIO and type cleanup or maybe you have something else?
>
> --Alison
>
Hi Alison,

I considered returnning 0 before, but both Dave and you prefer 
returnning ENXIO solution, I will do that in V2.


Ming

