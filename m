Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AC949630
	for <linux-cxl@vger.kernel.org>; Wed,  5 Jun 2024 08:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575822; cv=none; b=XQxSXfW1pMhcQQHfdbm4OZdZotypz7yHk6FZy1rqw2guTxx5KLU9EcQa3F4H7Ot8pUytOKS2FOOCwYFeABJDNc5LOFbPwXIikVm4nmcEgBN3xCYlkjLlDKCPAJlJOZwMXPY0QAcaVEykPg0o+L/yekTmxpUYDOL0M/0ZFm0a8qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575822; c=relaxed/simple;
	bh=iGtw1jqCZKUuhm3sXEesfyAO8PYcVzVOhoVVrmbEroQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CcQKrsNdDB/IZb8OSL+XFBXnOlGm26bn1oAIwFTAIBjwDW4fj1OhfJIf3QDBjhCsyyrJC+ICIjFvagMQ21cbRMYR2GY0NHiWdsYnStcAAcqGc+BCSdDkc5/LMldmokIIOP5dQ6yO4q/DuimbHK5Or9huR/kbgyRTtzWxZ+9lIDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZyw/wk7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZyw/wk7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717575820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FrXRJSl24pMWxTSTUa5BAvS/aN3UcspqvTrML27gFfI=;
	b=fZyw/wk753Bq132gl86QN9N9mvSRrRi3snJjJlgh9rcai8TtlC4vDGCOkChQiZ4srCd17W
	2hHtuMgTwW+Tns66K1TyIaEAobV3BLBNVPYN9RblUXRxfDOVOaVgmoT6/ulkZmhe2wqqkX
	CNHR2Wysoazh9AP5yXEIwmIVPTnS6OQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-Xgl14_KrOIq6UN4Zf3UPeA-1; Wed, 05 Jun 2024 04:23:37 -0400
X-MC-Unique: Xgl14_KrOIq6UN4Zf3UPeA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4212f105f0bso13586335e9.0
        for <linux-cxl@vger.kernel.org>; Wed, 05 Jun 2024 01:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575816; x=1718180616;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FrXRJSl24pMWxTSTUa5BAvS/aN3UcspqvTrML27gFfI=;
        b=fJ4RXzTMlegXib+h0O2Y8kilRSjPKRGzzNezYsvkgSCQKy9mwHVEiF7wgkFwh6JpjZ
         MCpGZ6eW9wOwnNIVxYGr/A7zKJ3CR6FnLbg9zBIQQB1v2XPi4J2BTMiMG1Bm4OAnXMSN
         dvV9z05tqGxip3689PzGGLYrKkdM9SFOxGvG7oeJFU+RC48R9OekWavxovYSk2hmBn0B
         k1IMnypq24fnk+Auv2AZ33UFixf09n0ope3nw/XDc02uGh4j0CCt6aiCTWSl4a5jRx8n
         LqvFID5A2DEniuJS2b53dXgRwnWm5B27cFg/2fVBPgkfdGAbINySCYTm2HzCNO60BIqq
         OQig==
X-Forwarded-Encrypted: i=1; AJvYcCXf3ss84ZFfDWP59VWa3FJ1/z4BybZCkZ4CwAmNlyNiqs6943wBv9PuBJU6q/gSi1+tu/T2LLOTAGcHhNPbbT7AkwPhYzZvpOwd
X-Gm-Message-State: AOJu0Yy3N8A3VoLN4cVQnygh51Px2uUD8z5smaNagjK1YRVtKhEg1I5j
	wqKU+TjbyJtYJaDwx8+/VPrLmdoXzryoqMlaKkDJEh/FuGqSrJAw4alyhcqDdmdafmvv1zPw2q8
	PKnk5UCt1b/FWvrhSjJxFjtzS97zviEbM1inz7tV6XWeGwTeVws55Dfb5bA==
X-Received: by 2002:a5d:5f8f:0:b0:354:f7f3:5e68 with SMTP id ffacd0b85a97d-35e8ef86ca1mr1729242f8f.43.1717575816002;
        Wed, 05 Jun 2024 01:23:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUm8r8YIaH0IadkJhkR+rTF3BoaMFsjrFZeC20i2LbK1E/8UZX1p7PoCk8VCAl4/oUMJfZcw==
X-Received: by 2002:a5d:5f8f:0:b0:354:f7f3:5e68 with SMTP id ffacd0b85a97d-35e8ef86ca1mr1729214f8f.43.1717575815568;
        Wed, 05 Jun 2024 01:23:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:3100:19a8:d898:8e69:6aff? (p200300cbc706310019a8d8988e696aff.dip0.t-ipconnect.de. [2003:cb:c706:3100:19a8:d898:8e69:6aff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd062eda6sm13725694f8f.86.2024.06.05.01.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 01:23:35 -0700 (PDT)
Message-ID: <785a8370-e40a-4a86-8534-c25503678318@redhat.com>
Date: Wed, 5 Jun 2024 10:23:33 +0200
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
 <92ea53c6-a93b-4ab8-8aec-7f88300576eb@redhat.com>
 <Zl2eNQF7S9zlUFne@kernel.org>
 <da88fa70-203e-49e6-bf4d-22cd161ef8d1@redhat.com>
 <Zl7f9gpdg99keirF@kernel.org>
 <900bd9b6-a788-4c71-9b43-aff4855ba234@redhat.com>
 <ZmAbA-kXEfKBKj4-@kernel.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZmAbA-kXEfKBKj4-@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.06.24 10:00, Mike Rapoport wrote:
> On Tue, Jun 04, 2024 at 11:39:27AM +0200, David Hildenbrand wrote:
>> On 04.06.24 11:35, Mike Rapoport wrote:
>>> On Mon, Jun 03, 2024 at 10:53:03PM +0200, David Hildenbrand wrote:
>>>> On 03.06.24 12:43, Mike Rapoport wrote:
>>>>> On Mon, Jun 03, 2024 at 11:14:00AM +0200, David Hildenbrand wrote:
>>>>
>>>>> The commit that added memblock_free() at the first place (f9126ab9241f
>>>>> ("memory-hotplug: fix wrong edge when hot add a new node")) does not really
>>>>> describe why that was required :(
>>>>>
>>>>> But at a quick glance it looks completely spurious.
>>>>
>>>> There are more details [1] but I also did not figure out why the
>>>> memblock_free() was really required to resolve that issue.
>>>>
>>>> [1] https://marc.info/?l=linux-kernel&m=142961156129456&w=2
>>> The tinkering with memblock there and in f9126ab9241f seem bogus in the
>>> context of memory hotplug on x86.
>>>
>>> I believe that dropping that memblock_phys_free() is right thing to do
>>> regardless of this series. There's no corresponding memblock_alloc() and it
>>> was added as part of a fix for hotunplug on x86 that anyway had memblock
>>> discarded at that point.
>>
>> So when we re-add that memory, we might have still ranges as "reserved".
> 
> I don't see how anything can become reserved on the hotplug path unless
> hotplug is possible before mm_core_init().
> There are no memblock_reserve() calls in memory_hotplug.c, no memblock
> allocations possible after mm is inited, and even if memblock_add() will
> need to allocate memory that will be done via slab.

I had the following in mind:

(1) DIMM is part of boot mem and some boot allocation ended up on it
(2) That boot allocation got freed after the buddy is already up
     (memblock.reserved not updated)
(3) We succeed in offlining the memory and unplugging the DIMM

Now we have some "reserved" leftover from memory that is no longer 
physically around.

(4) We re-plug a DIMM at that position, possibly with a different NUMA
     assignment.

On bare metal, this is unlikely to happen. With current QEMU, it won't 
happen because (hotunpluggable) DIMMs are usually not part of bootmem; 
that is, e820 and friends only indicate it as "hotpluggable but not 
present memory" range. It could be possible after kexec (for example, we 
add that memory to the e820 of the new kernel), but that's rather a 
corner case.

(3) is already unlikely to happen, so removing that memblock_phys_free() 
probably won't change anything in practice.

> 
>> It does sound weird, but you're the boss :)
> 
> Nah, it's mm/memory_hotplug.c, so you are :)
> 

Well yes :) but it's your decision whether we want to use 
memblock.reserved memory to store this persistent NUMA node assignment 
for the fixed memory windows. Essentially another user of 
memblock.reserved we should then document ;)

Removing the memblock_phys_free() call sounds like being a requirement 
for that (although it might make sense independently) use case.

I'm not sure whether memblock.reserved is the right datastructure for 
this purpose, but if you think it is, Jonathan would have green light on 
the general approach in this RFC.

-- 
Cheers,

David / dhildenb

