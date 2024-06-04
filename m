Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E00DF42
	for <linux-cxl@vger.kernel.org>; Tue,  4 Jun 2024 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493981; cv=none; b=eD5f8nyn5hGRaxu0hMNHTfyYj1qokl18lJssSVL4uv3sergaviW9SvbWIgvhYY7t1iFfUKRw4nKwLqNQxNN4f6MOQ2oZlJUKqvLg/9q18ZKmQ4SidBAdwqhqXDP1HgcD5nTZBcs/gKKWXhbJZ3rwfwHpO10UNRSiw+9Xf3IPiJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493981; c=relaxed/simple;
	bh=ffa39EYttn/P6USElekoFOIe3LxyMo7Yw87wrZyhyPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZrK/iWYBtij6MqwDsmB18EXwQHtEcnyZ503jA5hzeXoI2ZH99jv5I7v0wftFIA0fK5ukFvW1SIlTF5AztvuB4XlOwi2D5p8YmvSCm6wUsP4iR0lYNrtcit9L0l+CBWh4q8vCO4DKgR3i6V63GD5Q0lQHsKRCpWVhpRnGj6OUxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XmB/ZTEz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmB/ZTEz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717493978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2+GuYhr1AcupkVuKlx50Mih9JCQ9xwQB5jfJ1NebFlw=;
	b=XmB/ZTEzpbBvc2vM2fyl1AR5DsFEr+zpsTXh4YiMb30w++QV5rLNB1TupWvyL8EQVCkOLe
	ZQwv10eSFdAf/wLIs+l/XDOvVyj1ACyXEQJlgVs9oFfZABI61bNgKoYjaQzYQeW4zVAkqp
	fy3zisUOGgcmuvLaTUah1k/2TuUDRA8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-71RN7-0eM8qdS-TXIQmP8g-1; Tue, 04 Jun 2024 05:39:31 -0400
X-MC-Unique: 71RN7-0eM8qdS-TXIQmP8g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35e7e851decso438203f8f.3
        for <linux-cxl@vger.kernel.org>; Tue, 04 Jun 2024 02:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717493970; x=1718098770;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2+GuYhr1AcupkVuKlx50Mih9JCQ9xwQB5jfJ1NebFlw=;
        b=AgHAUX82JS4Z7yY2w1hZmePzhYqu3mjHXf5EhgB2fs283yasuUerR+FQXwUy2Jj3DR
         fL/yWBUef3gyTU7K5PauEzww69AN00xFe5U6TLo3uUYiTNvNoJQ6eabMUmxqCxDbPkT3
         0A8k4jisz/rnbbO4mzivzs4v1KM20dzafkXxnmQxU4kRmw4tf8fpg1OmKhyg1bXjsyoy
         mEsZcY0lt3Jc5NzMKQieQXLRMu3WS0TK3ngzSz4N1jAOU1ak6T878RxhlgVtEN6sFCpB
         CqsFqx+U/h1efgr/00BRTcy5LTef3t2o/cehUz9euw4LMVFglUhkERpnkDhhHZFsXCDn
         +lqA==
X-Forwarded-Encrypted: i=1; AJvYcCWxQiI0lf4SgvBwPzgMZGeTftYhu7SRi/6vOSQX/k3EmrLYdlAfrEp9d7TOBdOCpNfsYJMXmZVkrI2q2PIwvPPpXo5hNtgrPUw3
X-Gm-Message-State: AOJu0Yy9i7TF5CfI/wEykqP7sW6XUkmSw+9LNRawpAAsZgF0E3RwYSBQ
	TchsclUmzK1FfAdFpcegX+kkSg3doDfE01zodsjpINPn1lgiwfwQumti1L5wIvnnJJmbQAz/6tM
	IhCHRkUBdvXgEgNF4jVRTJHUqTr2QHHPJ1cYKP0pSaqEhTh9l2Q5vr3yICA==
X-Received: by 2002:a5d:58c4:0:b0:355:130:98a7 with SMTP id ffacd0b85a97d-35e0f30dfbdmr7636911f8f.54.1717493969956;
        Tue, 04 Jun 2024 02:39:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbIT6cEr6IpwWlY/N2cMlUkmsOd3epQEzlzWOY/L899u+5gbKB7ODatqPafppvYwbFkjowNQ==
X-Received: by 2002:a5d:58c4:0:b0:355:130:98a7 with SMTP id ffacd0b85a97d-35e0f30dfbdmr7636891f8f.54.1717493969508;
        Tue, 04 Jun 2024 02:39:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73a:3a00:a025:9b06:549e:c16b? (p200300cbc73a3a00a0259b06549ec16b.dip0.t-ipconnect.de. [2003:cb:c73a:3a00:a025:9b06:549e:c16b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0d3csm10992170f8f.19.2024.06.04.02.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 02:39:29 -0700 (PDT)
Message-ID: <900bd9b6-a788-4c71-9b43-aff4855ba234@redhat.com>
Date: Tue, 4 Jun 2024 11:39:27 +0200
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
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zl7f9gpdg99keirF@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.06.24 11:35, Mike Rapoport wrote:
> On Mon, Jun 03, 2024 at 10:53:03PM +0200, David Hildenbrand wrote:
>> On 03.06.24 12:43, Mike Rapoport wrote:
>>> On Mon, Jun 03, 2024 at 11:14:00AM +0200, David Hildenbrand wrote:
>>>> On 03.06.24 09:57, Mike Rapoport wrote:
>>>>> On Fri, May 31, 2024 at 09:49:32AM +0200, David Hildenbrand wrote:
>>>>>> On 29.05.24 19:12, Jonathan Cameron wrote:
>>>>>>> I'm not sure what this is balancing, but it if is necessary then the reserved
>>>>>>> memblock approach can't be used to stash NUMA node assignments as after the
>>>>>>> first add / remove cycle the entry is dropped so not available if memory is
>>>>>>> re-added at the same HPA.
>>>>>>>
>>>>>>> This patch is here to hopefully spur comments on what this is there for!
>>>>>>>
>>>>>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>>>> ---
>>>>>>>      mm/memory_hotplug.c | 2 +-
>>>>>>>      1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>>>>>> index 431b1f6753c0..3d8dd4749dfc 100644
>>>>>>> --- a/mm/memory_hotplug.c
>>>>>>> +++ b/mm/memory_hotplug.c
>>>>>>> @@ -2284,7 +2284,7 @@ static int __ref try_remove_memory(u64 start, u64 size)
>>>>>>>      	}
>>>>>>>      	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
>>>>>>> -		memblock_phys_free(start, size);
>>>>>>> +		//		memblock_phys_free(start, size);
>>>>>>>      		memblock_remove(start, size);
>>>>>>>      	}
>>>>>>
>>>>>> memblock_phys_free() works on memblock.reserved, memblock_remove() works  on
>>>>>> memblock.memory.
>>>>>>
>>>>>> If you take a look at the doc at the top of memblock.c:
>>>>>>
>>>>>> memblock.memory: physical memory available to the system
>>>>>> memblock.reserved: regions that were allocated [during boot]
>>>>>>
>>>>>>
>>>>>> memblock.memory is supposed to be a superset of memblock.reserved. Your
>>>>>
>>>>> No it's not.
>>>>> memblock.reserved is more of "if there is memory, don't touch it".
>>>>
>>>> Then we should certainly clarify that in the comments! :P
>>>
>>> You are welcome to send a patch :-P
>>
>> I'll try once I understood what changed ever since you documented that in
>> 2018 -- or if we missed that detail back then already.
>   
>>>> But for the memory hotunplug case, that's most likely why that code was
>>>> added. And it only deals with ordinary system RAM, not weird reservations
>>>> you describe below.
>>>
>>> The commit that added memblock_free() at the first place (f9126ab9241f
>>> ("memory-hotplug: fix wrong edge when hot add a new node")) does not really
>>> describe why that was required :(
>>>
>>> But at a quick glance it looks completely spurious.
>>
>> There are more details [1] but I also did not figure out why the
>> memblock_free() was really required to resolve that issue.
>>
>> [1] https://marc.info/?l=linux-kernel&m=142961156129456&w=2
>   
> The tinkering with memblock there and in f9126ab9241f seem bogus in the
> context of memory hotplug on x86.
> 
> I believe that dropping that memblock_phys_free() is right thing to do
> regardless of this series. There's no corresponding memblock_alloc() and it
> was added as part of a fix for hotunplug on x86 that anyway had memblock
> discarded at that point.

So when we re-add that memory, we might have still ranges as "reserved". 
It does sound weird, but you're the boss :)

-- 
Cheers,

David / dhildenb

