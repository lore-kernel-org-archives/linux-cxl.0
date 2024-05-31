Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BC41CD35
	for <linux-cxl@vger.kernel.org>; Fri, 31 May 2024 09:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717149319; cv=none; b=DY2ORTQ8w8AjtUpjL1UWfKxsGtFFo6+/lVyAXY6KEont1PuSBq58NjN3uSRx5hBQ96r9lpywOEolyyMznFwE/C3xeieH9f4NagiXTaCciwm7DU0LIg8UUFVJ2jxAQrMIRAltJ57h6ACnpCHsRL9DrEMoEYXz1DkRDWoymSbY9hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717149319; c=relaxed/simple;
	bh=N4DjseRBo8h90elgLYOhYCfMZwhg9PFQn6wTsVUfcKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LxBuQs4ItL1mdZCGE0UA23ib0F8ACCXrMikXPIMww9GNpyhEYo/FYbO0T9oai5+Lci5V/ufKc0C+nAqhiivyAKxGCRyvjTQz4pnsa0qVoeQIgKuOSlnv0m//Oh65zAQvVGMFKQlkfCR1ffvi2bxaKfzWdt7iSdN8HMO8nzHmF/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fs9Xz9MX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fs9Xz9MX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717149316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=n0X3AjZ12x1/Mcs1Z4Sjp/H7xN03mP51ZGWklROZHwc=;
	b=Fs9Xz9MXW0LzqLt+fqJ0ZOTwyXBqVMFeNFEoDBp4aKRDqTyOWPz3xcWpGzXnLusIri/WHE
	3EYVCZinqCzhuMuf9G2820GgbtrujYXDv7cjDPHj9bcMkPeKBxN/no7Ooz6pazG9Umbfk+
	JIstB8aRtLYd3zY+IaAJseM0k/BTUrk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-lEL0nr6QN8m7mmrWhHDxUg-1; Fri, 31 May 2024 05:55:14 -0400
X-MC-Unique: lEL0nr6QN8m7mmrWhHDxUg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ea402284c1so6258181fa.3
        for <linux-cxl@vger.kernel.org>; Fri, 31 May 2024 02:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717149310; x=1717754110;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n0X3AjZ12x1/Mcs1Z4Sjp/H7xN03mP51ZGWklROZHwc=;
        b=hNxZixDFqFnSKDF7r0jUFWxgMo0qluPjihZeel7hLXz9/I4a8GAr9DeRpSrEzJrmga
         TbsmTLF4KZgrqso8cKuBfCp1k0sBn2DqMIQ8ez3xPdl0VRJ+008TVFJJ4TfDs40VdUH9
         TNEO4f8Ar+jlqpxF4j7on+il4es2eiAC9l7o8Rc6q76TkemWeAAJL0JWMGxkhqPsWqRR
         XzLGKKLny4XFjxis2pafeCmF/KeQ/3hgJ29ERNNfOZp3kqzYR436nXS3gC8Xqd2QB5/t
         svqRvPWouCBjlWTAtpLnLqBYMYQhGRLBmKdhi2f9152hz7XudUv6nUg6bIONE8jzh4Ok
         WG7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUq0/UeMspCH86MKgVNU9MXYIN+QViZw6l6woRuvSD4EB42aieR9mPC8EJkestjY05csAP24fFs0Y2ceBTyadcDwoTnADtt118r
X-Gm-Message-State: AOJu0YyXZChZCi1Reht6fmKtQQBM8FhsJXIgddZzTocC9+SgPxImUrzI
	WuRmRd54V2RkOdwC0ZFfK9uL1yvZlColWD33d0fX+QsEJBgSy937JJhg0lUkAMuxvdylEoAs0F5
	+0iYas1+EOLjt+38yx2yW2B8YApLxKxx9p1yeiDqt4NdZdruqNLaxf96xBg==
X-Received: by 2002:a2e:9788:0:b0:2ea:82c7:bf6b with SMTP id 38308e7fff4ca-2ea951d6785mr9287501fa.49.1717149310373;
        Fri, 31 May 2024 02:55:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPYeYdU/A2TS42add9j01Yf3CcHxljRjCcMxn+uKUnR6lcUFaR5DzAvUXG5371qKUh5zYsBw==
X-Received: by 2002:a2e:9788:0:b0:2ea:82c7:bf6b with SMTP id 38308e7fff4ca-2ea951d6785mr9287211fa.49.1717149309777;
        Fri, 31 May 2024 02:55:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:a000:d4df:4b8f:37d4:59e4? (p200300cbc717a000d4df4b8f37d459e4.dip0.t-ipconnect.de. [2003:cb:c717:a000:d4df:4b8f:37d4:59e4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b84ba40sm19914915e9.19.2024.05.31.02.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 02:55:09 -0700 (PDT)
Message-ID: <4f734ec7-6277-4f5e-b291-6186f1eb5ecd@redhat.com>
Date: Fri, 31 May 2024 11:55:08 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 8/8] HACK: mm: memory_hotplug: Drop
 memblock_phys_free() call in try_remove_memory()
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Sudeep Holla <sudeep.holla@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>,
 Jia He <justin.he@arm.com>, Mike Rapoport <rppt@linux.ibm.com>,
 linuxarm@huawei.com, catalin.marinas@arm.com, Anshuman.Khandual@arm.com,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 Oscar Salvador <osalvador@suse.de>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, James Morse <james.morse@arm.com>
References: <20240529171236.32002-1-Jonathan.Cameron@huawei.com>
 <20240529171236.32002-9-Jonathan.Cameron@huawei.com>
 <b8654dcd-68e1-4823-9588-cfa401104741@redhat.com>
 <20240531104848.00006a95@Huawei.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240531104848.00006a95@Huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.05.24 11:48, Jonathan Cameron wrote:
> On Fri, 31 May 2024 09:49:32 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 29.05.24 19:12, Jonathan Cameron wrote:
>>> I'm not sure what this is balancing, but it if is necessary then the reserved
>>> memblock approach can't be used to stash NUMA node assignments as after the
>>> first add / remove cycle the entry is dropped so not available if memory is
>>> re-added at the same HPA.
>>>
>>> This patch is here to hopefully spur comments on what this is there for!
>>>
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> ---
>>>    mm/memory_hotplug.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>> index 431b1f6753c0..3d8dd4749dfc 100644
>>> --- a/mm/memory_hotplug.c
>>> +++ b/mm/memory_hotplug.c
>>> @@ -2284,7 +2284,7 @@ static int __ref try_remove_memory(u64 start, u64 size)
>>>    	}
>>>    
>>>    	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
>>> -		memblock_phys_free(start, size);
>>> +		//		memblock_phys_free(start, size);
>>>    		memblock_remove(start, size);
>>>    	}
>>
>> memblock_phys_free() works on memblock.reserved, memblock_remove() works
>>    on memblock.memory.
>>
>> If you take a look at the doc at the top of memblock.c:
>>
>> memblock.memory: physical memory available to the system
>> memblock.reserved: regions that were allocated [during boot]
>>
>>
>> memblock.memory is supposed to be a superset of memblock.reserved. Your
>> "hack" here indicates that you somehow would be relying on the opposite
>> being true, which indicates that you are doing the wrong thing.
>>
>>
>> memblock_remove() indeed balances against memblock_add_node() for
>> hotplugged memory [add_memory_resource()]. There seem to a case where we
>> would succeed in hotunplugging memory that was part of "memblock.reserved".
>>
>> But how could that happen? I think the following way:
>>
>> Once the buddy is up and running, memory allocated during early boot is
>> not freed back to memblock, but usually we simply go via something like
>> free_reserved_page(), not memblock_free() [because the buddy took over].
>> So one could end up unplugging memory that still resides in
>> memblock.reserved set.
>>
>> So with memblock_phys_free(), we are enforcing the invariant that
>> memblock.memory is a superset of memblock.reserved.
>>
>> Likely, arm64 should store that node assignment elsewhere from where it
>> can be queried. Or it should be using something like
>> CONFIG_HAVE_MEMBLOCK_PHYS_MAP for these static windows.
>>
> 
> Hi David,
> 
> Thanks for the explanation and pointers.  I'd rather avoid inventing a parallel
> infrastructure for this (like x86 has for other reasons, but which is also used
> for this purpose).

Yes, although memblock feels a bit wrong, because it is targeted at 
managing actual present memory, not properties about memory that could 
become present later.

>  From a quick look CONFIG_HAVE_MEMBLOCK_PHYS_MAP is documented in a fashion that
> makes me think it's not directly appropriate (this isn't actual physical memory
> available during boot) but the general approach of just adding another memblock
> collection seems like it will work.

Yes. As an alternative, modify the description of 
CONFIG_HAVE_MEMBLOCK_PHYS_MAP.

> 
> Hardest problem might be naming it.  physmem_possible perhaps?
> Fill that with anything found in SRAT or CEDT should work for ACPI, but I'm not
> sure on whether we can fill it when neither of those is present.  Maybe we just
> don't bother as for today's usecase CEDT needs to be present.

You likely only want something for these special windows, with these 
special semantics. That makes it hard.

"physmem_possible" is a bit too generic for my taste, promising 
semantics that might not hold true (we don't want all hotpluggable areas 
to show up there).

> 
> Maybe physmem_known_possible is the way to go. I'll give this approach a spin
> and see how it goes.

Goes into a better direction, or really "physmem_fixed_windows". Because 
also "physmem_known_possible" as a wrong smell to it.

-- 
Cheers,

David / dhildenb

