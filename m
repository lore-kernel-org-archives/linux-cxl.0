Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377AA3C1994;
	Thu, 19 Mar 2026 11:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773918715; cv=pass; b=r/fqQ0TfvAeO+T+VmBcgJx7E7WY2AiNTk59LDXxAT5azJelkWac+rFQ4bfPsYgbTXqaCOtBPA9aix7nMQdDdE/eIH2aYlko7ehUR4fE9wYwSX0nukPSeMrAWCp1H0iIiT1MMKlxff3XfayLeWZZ15oq7jEVDLgiuDFJIa1ew+tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773918715; c=relaxed/simple;
	bh=8enFaI0Xpshnx8NTdJPcbIB+7j0NmWlY+Ki0wwgJh9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PIqK3My7G0k4y9LuIMAnjVVW48McvqiSmzjzqJZ3v9nFIj3VUnkzk7vk7VyLP+JgX/xEUl5NYjb2LYgjSOSputG6eND1fG4c2M+/H3I5dSlVKHtJyjZjgJpAK46DVDUz3aXhXP4G94KkL3K1/m4l663Izmm7aqFNiZvo2TOjc4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Pf0Gbb7P; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Pf0Gbb7P"
ARC-Seal: i=1; a=rsa-sha256; t=1773918702; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=G2KFIxbA9bgAWFjvw0k855eBSBDvUgzJW9LCX8AUxpKez+xOlU6v9GQMCWlOEbqHQ5nZbbbQIY8J15657OX0hYXM/x1mbhDJ2nlEQdVTbPQpB/8LBrKJ4Vr48LcHeBVyEFT+Bi6eChVytojfo58setMAJS6e2RDykU8oXXk9BEY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773918702; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9xNbJd6eNoKvWQudMYAZu2EOUdzU/Q3F479XcjRaRKk=; 
	b=jmxsLmS03+CuyGCLRcZ3DeZGoCIAp1dKdyymx18Gi8bFJqH2UEPpS8IaNhvPQlwSPx0/orvNWGLBLzKDRSUrqClqd704y5Ib3UWZnxSFV+bWCk1Ua0yn5blFlveaRSX1i+7DkzRMNSxljatC+eoQPnFb7JqstcphAFquIC6i3v0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773918702;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=9xNbJd6eNoKvWQudMYAZu2EOUdzU/Q3F479XcjRaRKk=;
	b=Pf0Gbb7Pjtoeo10b3h1GjcWSjoMawwoY3Ph0HzDGL5148FoHjl66E17InwOL9a6P
	6ITrXmrCfDl24DmvcRQcAATTXacWlVplj3HwS8Ybua9vGN4/CfoWYK+Q0m1DLXcHUJn
	2tAQxxgae+XxTj/ke5pZHG4nDJUQwLcZrtOzvg8g=
Received: by mx.zohomail.com with SMTPS id 1773918700594461.5822884998462;
	Thu, 19 Mar 2026 04:11:40 -0700 (PDT)
Message-ID: <291ac46e-67cb-4732-8626-e0c434ede12f@zohomail.com>
Date: Thu, 19 Mar 2026 19:11:34 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/hdm: Add support for 32 switch decoders
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
References: <20260318-add_support_for_32_decoders-v1-1-bb7b41efde2a@zohomail.com>
 <69f68851-9e02-431a-9331-8f687bb2fa4a@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <69f68851-9e02-431a-9331-8f687bb2fa4a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122883dafd051bca49f3013723c8000059bba104775c262d16cf0fef00224de091d8f8633b187fd7b263:zu0801122768f1dde2545e5dcb3b582ad600000677fc07c3c5c6232081c3f3dc3bf5b37306e57db581188702:rf0801122d47ed7f609cf86ffd73ea2c0c00001e2688ca9f83917f05a44bb395d2d5201cc27669071415735ddc2242125ad5:ZohoMail
X-ZohoMailClient: External


在 2026/3/18 23:40, Dave Jiang 写道:
>
> On 3/18/26 6:00 AM, Li Ming wrote:
>> Per CXL r4.0 section 8.2.4.20.1. CXL host bridge and switch ports can
>> support 32 HDM decoders. Current implementation misses some decoders on
>> CXL host bridge and switch in the case that the value of Decoder Count
>> field in CXL HDM decoder Capability Register is greater than or equal to
>> 9.
>>
>> Update calculation implementation to ensure the decoder count calculation
>> is correct for CXL host bridge/switch ports.
>>
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>> ---
>>   drivers/cxl/cxl.h | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 9b947286eb9b..466b8eeefed7 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -77,7 +77,12 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>>   {
>>   	int val = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
>>   
>> -	return val ? val * 2 : 1;
>> +	if (!val)
>> +		return 1;
>> +	else if (val <= 8)
>> +		return val * 2;
>> +	else
>> +		return 4 * (val - 4);
> That looks a bit messy. How about:
>
> switch (val) {
> case 0:
> 	return 1;
> case 1..8:
> 	return val * 2;
> case 9..12:
> 	return val 4 * (val - 4);
> default:
> 	return -ENXIO;
> }
>
> DJ

Sure, will do that in v2.


Ming

