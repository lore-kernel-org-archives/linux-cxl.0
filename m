Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C4D1FF5EA;
	Wed, 16 Apr 2025 01:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744766097; cv=pass; b=qchiYSORTG3WZDz38GINK7zBFf3YG+3fqNt/bb8v8pGPDoNGKyelLU6KwooIfzicHY3JKmmHT5bP1gq2hDjZPIowUB8yuqjla0bLp6wGk9ncrt1qY7LZjjlE/tHQxkPl1jWvL87jjCdr3l4pBgXN9aGtdI3SvtvjNXxnN52zspI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744766097; c=relaxed/simple;
	bh=hI3gAKOmD6sFkGDsNGgFSX/Jv8+TujdNdV9u35KB8to=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jw+hQUFBJ67EDw7d/9k77esM0Wctgutm5esIriJwmnd0e/3ZCOKEdbQK2OvMEvl1VUys2kP6su+c4FCZv6n0Hlv0JiPaCSJyrXqcf20V3NOqvfXVjWMDxySItuajq3XbUI0dUyZoFcKPwjbAg90yN4jANqf2HR43qKfcb5Qgvag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=B63ae9QE; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="B63ae9QE"
ARC-Seal: i=1; a=rsa-sha256; t=1744766070; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dn7A2sue4xZpfH+zinKpmIDGSWH3WCwMowKYkEY5vJ6QwOY3KXQMAPzcnxre+UTB8BpI72xDvdgXgjGnHXVgFBdKf5fKe4B1k5pTfDDkQJR4t16tM5HdOAi02ET4b12v7v9QaOLPblowr12QVw32aM9av9ThbmUdWmq4cAclw2U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744766070; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+LI5T3J5MAN1KKsgdLSHsP89HjE3OBgeTAgz3g5seVM=; 
	b=mKQbF/HB4tR4kjuBP9WGHF4ikdRpmr+9g672U2HnDzdit0kGVKJkPax+tMWC8j6M8pfSe4XO0DKXF/mhznQWKL7V4TeAgRNOoHosPdQ7DgWHn0ZkRllDv+HYfGPWjjjv7rNGQigvCaQRfIi1GmIZZAyv5OK0iegPIOol0DAI5uU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744766070;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=+LI5T3J5MAN1KKsgdLSHsP89HjE3OBgeTAgz3g5seVM=;
	b=B63ae9QE/z6GM5hCyDn8oqNmVjhLXbeKY4IgP5WyYrkc3xgWLF8ttyaUSTLhQmCD
	zWpAN9gGCjwvrKj9s0M1ZODV5PJO3soCrH2Jmk+fcQ2ErRs/AjzfyJJK1y1ml4U3I6f
	Iitel2FO4GO8uaSzf84GNh2GCwNGJalJxbMthaSU=
Received: by mx.zohomail.com with SMTPS id 1744766066825261.9631799083443;
	Tue, 15 Apr 2025 18:14:26 -0700 (PDT)
Message-ID: <9c835759-8a67-4479-854f-4a96edee2933@zohomail.com>
Date: Wed, 16 Apr 2025 09:14:23 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] cxl/feature: Using Full Data Transfer only when
 offset is 0
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 shiju.jose@huawei.com, John Groves <John@groves.net>
References: <20250410024726.514170-1-ming.li@zohomail.com>
 <20250415153601.00001824@huawei.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250415153601.00001824@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227bb9f4feaa7b1eb4dc487c32e00008e94edfb1f3c6f4e41a77c51a9416b2c1679098cc75600d776:zu08011227cd79a628e40c8290afab14b8000090e0a949404b929e09e128f6589dfb4cd7e39d6806a6905e5a:rf0801122d57fb5ee473ad5723fb6e36600000d853edbb2a7d299a1cc24ab5485c70e0e630c36eb7f030e261c9b0d10754b5:ZohoMail
X-ZohoMailClient: External

On 4/15/2025 10:36 PM, Jonathan Cameron wrote:
> On Thu, 10 Apr 2025 10:47:26 +0800
> Li Ming <ming.li@zohomail.com> wrote:
>
>> Per CXL r3.2 section 8.2.10.6.3 Set Feature(Opcode 0502h)
>>
>> "If the Feature data is transferred in its entirely, the caller makes
> entirety 
>
>> one call to Set Feature with Action = Full Data Transfer. The Offset
>> field is not used and shall be ignored."
>>
>> It implies if using Full Data Transfer, the received data will be
>> updated from offset 0 on device side.
>>
>> Current driver implementation is if feature data size is less than mbox
>> payload - set feature header, driver will use Full Data Transfer even if
>> user provides an offset. Per above description, feature data will be
>> written from offset 0 rather than the offset value user provided, the
>> result will not be what user expects.
>>
>> The changes is checking if the offset caller provides is equal to 0, if
>> yes, using Full Data Transfer, if not, using Initiate Data Transfer -
>> Finish Data Transfer.
>>
>> After the changes, all Set Feature transfer scenarios are below:
>>
>> 1. data size + header is less than mbox payload and offset is 0
>> 	Full Data Transfer
>>
>> 2. data size + header is less than mbox payload and offset is not 0
> Is it valid to call this function with a none zero offset? I'm not sure.
> In my possibly entirely incorrect mental model the offset should be
> an internal detail of how we get the features that we should not expose to
> userspace (oops).  The specification is confusing on this point so I think
> we should ask for a clarification.
>
> There is text that for example says
> "Once the _entire_ Feature data is fully transferred to the device (i.e.
>  Action = Full Data Transfer or Action = Finish Data Transfer"), the
>  device shall update the attribute(s) of the Feature."
>
> What does 'entire Feature data mean here?'  The whole thing or just
> the bit from offset used in Initiate Data Transfer onwards?
>
> I'd read entire as meaning all of it so effectively the offset passed
> to this function should always be zero.
>
> I'll send a query and let you know the answer. Maybe I'm reading too
> much into that 'entire'.
>
> J

Thanks for that.

I have the same doubt too. 'entire' can be whole feature data or just mean a part of feature data needed to be updated.

If 'entire' means whole feature data, it will require Initiate Data Transfer to be with an zero offset. But I can't find any description of SPEC including this hint.

And current set feature implementation does not have such limitation either, so I made current solution. I agree with you that we should have an accurate answer.


Ming

[snip]


