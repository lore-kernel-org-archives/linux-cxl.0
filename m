Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7982870810;
	Thu, 13 Feb 2025 04:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739420146; cv=pass; b=NbEFsCR5EoGC916sU0DcOvFIQV3ln+RMnCDLvhXEIuETY5oyPtB7fT/iBZJw9B3gFEbtSNHZigOUvb8xYvhLPmq3kOOEhPeA0C+NWrVNRLqctLIpqf+DFvFIwCkOv9wdYOX/kf5ETOK04n7sNMdSYdCM7dTIJvjeLAqNed7IMIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739420146; c=relaxed/simple;
	bh=qRLrJsVRTZ+WWw41jpvi8qCG0lbc4O9YO80RcNk63B4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMW5eKkkXYp47n2fdjvr3lSg93zVaS/9M59bHh6OphHpH61iOO1aDYccTvBt4UnZqbwzFID5YkDyNNRRkUEa1z9fU0GER2Vw5b7RYuBKnSsPdXl8TJVtdt3WucNYCSbYPzfspjjFmLtOx3PHE+lcVp2gGawgahkHR8NfmhBWlyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=FuftZmEp; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="FuftZmEp"
ARC-Seal: i=1; a=rsa-sha256; t=1739420131; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=d4jhk0HkQAXO2XIk3inKmktR6ewF51lw7GQmceAe3sExk1wLkQV2sBJm9XKkJHVriIpO/bRvdFzIgj4x1r6O6yZHK8rz2vIfIZBSh37cfyOFaKqyLqDX9+Jl2bQ1gpRtQEMoTfread7DvwUj7j+vKPQ3ReVEAbFPtGw6N8oxNKc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739420131; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4ToEDu8hKvNWByGuJPfWdRectEFq8etbekmoQIvQ/no=; 
	b=BcHTkYkzkbodpHQZmPBGbrE4EowoaaZYrQKEQSiB3Sw7/TShji5L9Rgho18cEiXeP7wYnTuz+6+qdXFQE4QLVOPWd44XUTLepV3rZ2LI8i0J/FYdS++AtXXH8XveIENsVO6WhXt6Y21WO/xogFY8dg6R8wlC94nW3ZESkzkScYE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739420131;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=4ToEDu8hKvNWByGuJPfWdRectEFq8etbekmoQIvQ/no=;
	b=FuftZmEpeeUoK6b6YLs4+nqG8RXHjyVjKQeLf2n0dIMs3dp6efoVs4tJlF/r5usH
	y9t/EWGFND8nWjMIjey/G/7fZDNkWEOTwa5GfJV03tuykvyFEstxBBWAn2+0yK6YVro
	evj5eR9fOv1OE7gANKRwHDcT3HGX9ALIteB24MMc=
Received: by mx.zohomail.com with SMTPS id 1739420128330834.3986541056635;
	Wed, 12 Feb 2025 20:15:28 -0800 (PST)
Message-ID: <cf0421d6-f002-4dc1-b3cd-5b535d79cc1d@zohomail.com>
Date: Thu, 13 Feb 2025 12:15:24 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/7] cxl/region: Drop goto pattern of
 construct_region()
To: Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dave@stgolabs.net, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250211075727.351895-1-ming.li@zohomail.com>
 <20250211075727.351895-8-ming.li@zohomail.com>
 <20250211173606.00004d33@huawei.com>
 <d848f0ab-5055-4cda-8531-258c6fa7280e@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <d848f0ab-5055-4cda-8531-258c6fa7280e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr080112271d77f85e48e997955392a03b00007472e1e0cd7a6a76749b207e70f14a6877e49e11328c65ae00:zu08011227318bf9d040207c88550d2aa200000ac7a2c6c48efcceab0d99b60c9ea3af0c6a8e322a0f936ac5:rf0801122debabfad60d5f832903152e720000189c8cbc9a0a94ded23112e2848deb9ad4a3e67db15163b25a5441e5ff000f:ZohoMail
X-ZohoMailClient: External

On 2/12/2025 5:24 AM, Dave Jiang wrote:
>
> On 2/11/25 10:36 AM, Jonathan Cameron wrote:
>> On Tue, 11 Feb 2025 15:57:27 +0800
>> Li Ming <ming.li@zohomail.com> wrote:
>>
>>> Some operations need to be procted by the cxl_region_rwsem in construct
>>> region(). Currently, construct_region() uses down_write() and up_write()
>>> for the cxl_region_rwsem, so there is a goto pattern after down_write()
>>> invoked to release cxl_region_rwsem.
>>>
>>> construct region() can be optimized to remove the goto pattern. The
>>> changes are creating a new function called __construct_region() which
>>> will include all checking and operations protected by the
>>> cxl_region_rwsem, and using guard(rwsem_write) to replace down_write()
>>> and up_write() in __construct_region().
>>>
>>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>>> ---
>>>  drivers/cxl/core/region.c | 71 +++++++++++++++++++++------------------
>>>  1 file changed, 39 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index 36f3771818d3..170278bdcedc 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -3217,49 +3217,31 @@ static int match_region_by_range(struct device *dev, const void *data)
>>>  	return rc;
>>>  }
>>>  
>>> -/* Establish an empty region covering the given HPA range */
>>> -static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>> -					   struct cxl_endpoint_decoder *cxled)
>>> +static int __construct_region(struct cxl_region *cxlr,
>> This is only factoring out part, so I'm not sure the naming makes sense.
>> I don't have a better name however as this is doing various different things...
>> setup_region() doesn't feel right either...
> setup_auto_region()? construct_auto_region()?
>
> DJ

Will use construct_auto_region() in V2 if no a better name, thanks for that.


Ming

