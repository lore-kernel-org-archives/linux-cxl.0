Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBE21CDFCB
	for <linux-cxl@vger.kernel.org>; Fri, 11 Oct 2024 08:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728633770; cv=none; b=FiKLYjVVMnIkdIr69d+4x/lctVdk0fDk6INoWjp784fwW6EjH/q30NiqyzwNFaSjf79CzJKJigEp0BtOIR28aO0aB996PfZq6weTs4mDdU0goYjWQnut32TgNMRnrl1I9dgQS/crKQvVj2WRRQ17gFqY/f/g/4fBgptkqfE3zo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728633770; c=relaxed/simple;
	bh=1G264mSt1wDpJu1JQeDDMl9wkPpmKTs55H1pI5t3wlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DfIafS5vK/SEzsTi8fGmE0MIwpJ+GgOPJQRDa3dF77FDOL4W6PNfTqGYGeHeEU9u8lQTEnhigooPqlpFY/6a+JkbqbeAadl7nHIIBRp2WIpyXBBiS3Eg7zNFub9BftBqmlxqokOkzQewD9dvL16jzyk7v7sgM+PIUuVmHH7r8ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eqj2C9Ys; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eqj2C9Ys"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728633767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MYsgRWZ2elMUceKOyVwh2dp6xwsZZnMsD+W4voqg/yQ=;
	b=Eqj2C9YsOrCqfMiP48IOiOh9tpKf3KdJ2Suw4CJf8nwqRMMYB5uuZ/Mzzzioyyiaa8oUMD
	imosAKteMRAqLMYXV/rlgiZgHlcsROKeOXUHGHkNF81eoZIPdM4aT3HCfdl+t9AR2QtoIS
	BmxcAo783Cc5KOtQ5Q0PJh5WwjuIWPA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-c0O4wMHpNbSNF4G7nJez1Q-1; Fri, 11 Oct 2024 04:02:46 -0400
X-MC-Unique: c0O4wMHpNbSNF4G7nJez1Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d5606250aso183275f8f.2
        for <linux-cxl@vger.kernel.org>; Fri, 11 Oct 2024 01:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728633765; x=1729238565;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYsgRWZ2elMUceKOyVwh2dp6xwsZZnMsD+W4voqg/yQ=;
        b=VYJ/0STVwZ8W9YvTT+Ufji1CH+uL+IIjrRwTqubVat34jm2Fsupbz7d/q3LpeQRoVC
         iyzr9IGoViJYRreBiEDk1PgMEoXGtJ/Zrjz6lihPQnUYbI+PgeCcAgSTa4hM+MJ40QQ0
         LHm87FwUDkaGP7vQTvVRvts4pMLvdiHOndS5LXiCoSsuZ8iVQ0Nx49LLyZtXxZeegMh/
         Xhw3BhE1vORjq+rbx0nvK8/vgTRUAenZYPofHKYl7xOMw05rtLRvepPAxHURD6EfIy8P
         hYy+MT7y02/dLJG6uupGrVKO4bRhwMkHezwQtKWXwg6JwEAa9e128VFYm9QBjZQIm3pL
         jH3A==
X-Forwarded-Encrypted: i=1; AJvYcCUtEc+LFIAtEvJWlAoPsDEhxXbYguzLK4/QS0uQvVSi2G3Y6tYkhxPKlxJK5rJz6dzFsbzd3V63zsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsWa0/JVX4dAYtOFOmEtxt5C0P2Fbrb0MdhvdimnS00xGngtuy
	J8j7Vmzc89HslWJgdzPud8Lc7Q0lZCGWVrF2ZiMJ0M3V2e6OGTnwBEO2xnxPdLQ2Togpu08Wxcl
	hB6840dImQfWkzvQ3OI3LFAcbnN1pD6DHkrstbJyc8DZ5UE6Wxs4rEtXSGg==
X-Received: by 2002:a5d:68c5:0:b0:37d:46a8:ad4e with SMTP id ffacd0b85a97d-37d551b9740mr1265154f8f.15.1728633765274;
        Fri, 11 Oct 2024 01:02:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo7+4xRpA1JoxH0XqSKVac7zQZzx7kkHvki+5IpOKjjCKTnEd6UAWtOAHGVXrr3WY1ItORWQ==
X-Received: by 2002:a5d:68c5:0:b0:37d:46a8:ad4e with SMTP id ffacd0b85a97d-37d551b9740mr1265124f8f.15.1728633764773;
        Fri, 11 Oct 2024 01:02:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c749:9100:c078:eec6:f2f4:dd3b? (p200300cbc7499100c078eec6f2f4dd3b.dip0.t-ipconnect.de. [2003:cb:c749:9100:c078:eec6:f2f4:dd3b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b918073sm3301558f8f.113.2024.10.11.01.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 01:02:44 -0700 (PDT)
Message-ID: <38566dbf-1293-4fd5-9cbd-385e6c35344c@redhat.com>
Date: Fri, 11 Oct 2024 10:02:43 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] resource: Avoid unnecessary resource tree walking in
 __region_intersects()
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alistair Popple <apopple@nvidia.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>
References: <20241010065558.1347018-1-ying.huang@intel.com>
 <d129bbe4-8ae8-4915-bd9c-b38b684e8103@redhat.com>
 <87set3a1nm.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <87set3a1nm.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.10.24 03:06, Huang, Ying wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 10.10.24 08:55, Huang Ying wrote:
>>> Currently, if __region_intersects() finds any overlapped but unmatched
>>> resource, it walks the descendant resource tree to check for
>>> overlapped and matched descendant resources.  This is achieved using
>>> for_each_resource(), which iterates not only the descent tree, but
>>> also subsequent sibling trees in certain scenarios.  While this
>>> doesn't introduce bugs, it makes code hard to be understood and
>>> potentially inefficient.
>>> So, the patch renames next_resource() to __next_resource() and
>>> modified it to return NULL after traversing all descent resources.
>>> Test shows that this avoids unnecessary resource tree walking in
>>> __region_intersects().
>>> It appears even better to revise for_each_resource() to traverse the
>>> descendant resource tree of "_root" only.  But that will cause "_root"
>>> to be evaluated twice, which I don't find a good way to eliminate.
>>
>> I'm not sure I'm enjoying below code, it makes it harder for me to
>> understand what's happening.
>>
>> I'm also not 100% sure why "p" becomes "root" and "dp" becomes "p" when
>> calling the function :) Likely this works as intended, but it's confusing
>> (IOW, bad naming, especially for dp).
>>
>>
>> I think you should just leave next_resource() alone and rather add
>> a new function that doesn't conditionally consume NULL pointers
>> (and also no skip_children because you're passing false either way).
>>
>> static struct resource *next_resource_XXX(struct resource *root,
>> 		struct resource *p)
>> {
>> 	while (!p->sibling && p->parent) {
>> 		p = p->parent;
>> 		if (p == root)
>> 			return NULL;
>> 	}
>> 	return p->sibling;
>> }
>>
>> Maybe even better, add a new for_each_resource() macro that expresses the intended semantics.
>>
>> #define for_each_resource_XXX(_root, _p) \
>> 	for ((_p) = (_root)->child; (_p); (_p) = next_resource_XXX(_root, _p))
> 
> Yes.  This can improve code readability.
> 
> A possible issue is that "_root" will be evaluated twice in above macro
> definition. 

Do you mean that we would process it twice in the loop body, or what 
exactly do you mean with "evaluate" ?


And just I understand what we want to achieve: we want to walk the 
subtree below "root" and prevent going to root->sibling or root->parent 
if "root" is not actually the "real root", correct?

X
|--------|
A----D   E
|
B--C


So assume we start walking at A, we want to evaluate A,B,C but not D,E,X.

Does that sum up what we want to achieve?

-- 
Cheers,

David / dhildenb

