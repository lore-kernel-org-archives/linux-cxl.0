Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7491780603
	for <linux-cxl@vger.kernel.org>; Mon,  3 Jun 2024 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406048; cv=none; b=SWyt3vLkphtQT4tCSpVn3R/5mMJKdL5avwMdZrC7L/MBBk0B486SynF3lccKR9+5KS3ex8BCEqvxAsGPnj9CCn2ZlYmrh9XX6c1nXzmk9rbJLguUw/5XAdReKJipexhYlHBuTzoiZQnGrLvkuKO862obwe933O9me60LIhfDW0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406048; c=relaxed/simple;
	bh=nlJA3h5++aMg1vyaZzuTg+rfjjKdCFOJPXce3Iytofc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRD8BVbi+EK/LPinlky7XfhqLDBIPSkkZnahy39EjPlhjFUzBbtfzI/oPACXdgaXubNuRCDU6DnnctZWAhzkTZeSln2C6XnXq07wSIzFHzUlG6uSi/WzQKT/1VHqIVEAGQiOy/pgjQC2Bep3Jz1prFmNhgPAnYh2v2lkP9INolY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RpUEjdXj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RpUEjdXj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717406045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8VD2TQcDLtCxHsR0LVKOUuR/ssjlLzv+Eo4w2I6Ty8M=;
	b=RpUEjdXjOHeY9UUsxF9KhSls9AmsauZaUv7DjdVC3ow5zofcJGb0D3fOaUi1HZVusmqr0h
	IjYQ7TYr8jBzDJyGqXDEz7Mf+3skt33ytbgk/5ANgu15Mq9zF7LhZ7+ZZmjWCxyWtjEnDs
	9+XYzyLe+n8S1+awVYVWPMAd9jM+e0o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-JOCZ8a5ZMEelPk5gJEeuxQ-1; Mon, 03 Jun 2024 05:14:04 -0400
X-MC-Unique: JOCZ8a5ZMEelPk5gJEeuxQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35dbfac1c4cso1813772f8f.1
        for <linux-cxl@vger.kernel.org>; Mon, 03 Jun 2024 02:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717406043; x=1718010843;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8VD2TQcDLtCxHsR0LVKOUuR/ssjlLzv+Eo4w2I6Ty8M=;
        b=E6bBk5WgBaYtPJ/pCCs7lm07Zg0sKASyhG1h36Y0UcXTzXcEPK5pssbpgP1+Vdm2hw
         eqAQZYC+TCalqqSYc3otuCoZ52th5OSjaVYqqoqB/BD71hqpcWUhkVPpGIvmkyUfCdsP
         KJRnaOjQ2tbmw1Po6qOh+kmJnw3vBfhsuj2CYP3TilBoZMRagYEyMbNB+lP24vYpaHEF
         q0kYhC/sWGbHXjezlUu3/zZ1CGzSbIqJSVuIVKp3owMAjx25E7juyM88x7EqsPHwtLSy
         n4SZG6T+pRTINpaMida9ls/wEGosG5QCBf3OAMJ0xbcTXx403RfZakTgFUW+rf1jqjlb
         WLYw==
X-Forwarded-Encrypted: i=1; AJvYcCUr+TI9PiuKcDE3NbBPDsmeg8T1N0ELVhL8ozjtgBa0EZ7qrK2W1IMXPF90YJ9fZjbPOtBnPvVV/Qg2RAjNd/GJdIu5NlPEme0K
X-Gm-Message-State: AOJu0Yxo7CKbVEw3EJjlg8Io4Cldgeh3DUvKWmRgTcA/QXL8hEf/SGj/
	r7JwHNHXwbJO9PA+trAxRIXr1lW7V1fBurDSdiO7BbuiaK1E79gqEhSdQ3XuxvaceABKZ5LnUI/
	i+jWAk6WLC0n1PxH60IGPMKW5C2vh6/Z+Hm7+pIyBGhCTTvcBD545kBWXpg==
X-Received: by 2002:a5d:6ad0:0:b0:354:fa7d:dcfe with SMTP id ffacd0b85a97d-35e0f2703f3mr6538804f8f.23.1717406042953;
        Mon, 03 Jun 2024 02:14:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRyLDqI1mVK1RWVAKv8venSHCH+tsPol7enbSgRqhRPnHvb6/PQZoPdmcWJfImi/mZ4H2BNA==
X-Received: by 2002:a5d:6ad0:0:b0:354:fa7d:dcfe with SMTP id ffacd0b85a97d-35e0f2703f3mr6538781f8f.23.1717406042523;
        Mon, 03 Jun 2024 02:14:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c731:3d00:918f:ce94:4280:80f0? (p200300cbc7313d00918fce94428080f0.dip0.t-ipconnect.de. [2003:cb:c731:3d00:918f:ce94:4280:80f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04e845bsm8195878f8f.65.2024.06.03.02.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 02:14:02 -0700 (PDT)
Message-ID: <92ea53c6-a93b-4ab8-8aec-7f88300576eb@redhat.com>
Date: Mon, 3 Jun 2024 11:14:00 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 8/8] HACK: mm: memory_hotplug: Drop
 memblock_phys_free() call in try_remove_memory()
To: Mike Rapoport <rppt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
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
 <Zl13aA2ihYsLPcL6@kernel.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zl13aA2ihYsLPcL6@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.06.24 09:57, Mike Rapoport wrote:
> On Fri, May 31, 2024 at 09:49:32AM +0200, David Hildenbrand wrote:
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
>>>    	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
>>> -		memblock_phys_free(start, size);
>>> +		//		memblock_phys_free(start, size);
>>>    		memblock_remove(start, size);
>>>    	}
>>
>> memblock_phys_free() works on memblock.reserved, memblock_remove() works  on
>> memblock.memory.
>>
>> If you take a look at the doc at the top of memblock.c:
>>
>> memblock.memory: physical memory available to the system
>> memblock.reserved: regions that were allocated [during boot]
>>
>>
>> memblock.memory is supposed to be a superset of memblock.reserved. Your
> 
> No it's not.
> memblock.reserved is more of "if there is memory, don't touch it".

Then we should certainly clarify that in the comments! :P

But for the memory hotunplug case, that's most likely why that code was 
added. And it only deals with ordinary system RAM, not weird 
reservations you describe below.

> Some regions in memblock.reserved are boot time allocations and they are indeed a
> subset of memblock.memory, but some are reservations done by firmware (e.g.
> reserved memory in DT) that just might not have a corresponding regions in
> memblock.memory. It can happen for example, when the same firmware runs on
> devices with different memory configuration, but still wants to preserve
> some physical addresses.

Could this happen with a good old BIOS as well? Just curious.

> 
>> "hack" here indicates that you somehow would be relying on the opposite
>> being true, which indicates that you are doing the wrong thing.
>   
> I'm not sure about that, I still have to digest the patches :)

In any case, using "reserved" to store persistent data across 
plug/unplug sounds wrong; but maybe I'm wrong :)

-- 
Cheers,

David / dhildenb

