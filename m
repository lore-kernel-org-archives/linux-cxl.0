Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B79C1C8622
	for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 20:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739912235; cv=none; b=qPxqOT3TL+p1VKKURCv9fIt6JcMibN7dr7n2CpIczgpMPwCRYqiOBmpRlezfhH0w1ypcFznCLi2YEKd9kWZELkISwn4ta9pyDR5FI24iHNBCQEz9KRBVMGN7RVhdLZ07zmafu4HrJcKP5ogd12ItLmp/Gq7d0vSvbM4tupH0kek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739912235; c=relaxed/simple;
	bh=gpas5oUxzPV/XGxLFH15XGgXxDqbVNLYvjgja7B7R+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCoo7Vot3p95PhI1wOk+GScKUZiSt3RuwXHvyr7nYmOAt63SKOySW7mGX9+qw8Wx1rHmdv1NyPJjli2KPWzO7Ts6CnhadWfdBsVxp24+0ospEUy7yBVvasirhPFNddCYGGLqDSf55qO9h72UBKTBXIF+3yR7Syb34UPqlq+Se+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OFWfhLVq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFWfhLVq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739912232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6FsbwLcxUhHZW9FHTie3Ead3JpCjVkROaSdeAT2Lgyo=;
	b=OFWfhLVqlKtFVi3EP/h1X72IgDwgaLxHKz0gf4+bs3m8PbWzEDvbLQ8Ft1W2cqF0nduXTh
	6GgOMtPGXMeVdDSBpozEP6ds7p81AKH3ENN6q+9Q+HfFYqKa09IHvxlC3eD5qLqOwMH/DC
	f6B+4+O+YMg/Q7jB/AXFeqJ4VsN0AiM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-zTlKLvHzOsKNJ8fH7a9uOA-1; Tue, 18 Feb 2025 15:57:10 -0500
X-MC-Unique: zTlKLvHzOsKNJ8fH7a9uOA-1
X-Mimecast-MFC-AGG-ID: zTlKLvHzOsKNJ8fH7a9uOA_1739912230
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f44be93a8so1394195f8f.1
        for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 12:57:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739912229; x=1740517029;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6FsbwLcxUhHZW9FHTie3Ead3JpCjVkROaSdeAT2Lgyo=;
        b=c5LwCJ1T+T27AyK2Hzk+pWShPUOWjV0MewNh6Cm0UK2ky8Ezl8J61rlSrLCocWfqzJ
         KPBsrXZo1KUnlEfPF8LEbQEJ1JmmYK1D+adFlQQ5KJtTIfkveY4KNFKIyLCLVSId4f49
         lfHo5hzOBMTYllb9cN1ZkT696SLAvj/bxbNPuwh8d/TdxNx4arXygi0waleEeL4gcAMs
         N6NSpI8sDn7KUwcEWsAdohwcwhU0s0Gwm7Emxu3YEYVXsAJEKpiNwATnAuF0hk2sq7IX
         MuJgvCvajAFCIQso5TPx8JN2LUIbkLUC+HQDYtOAVunoo1nEPI/+NaKz9ZRBr1CSNpqC
         VEUw==
X-Forwarded-Encrypted: i=1; AJvYcCVvc277EzUwYqPZwqmIjfPAPSstZwNoU6HyIUOAxu5EHXFqFkY2ZubweVd6c2iAzi0NUJkU2vjS1lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAAZc+WLP3bb3gR971kevXsj4wAv6He78ri0PiK4l+dslxJ8Zj
	D6oBH8kfiV0QIvdTgm5IJN4MHjloX+EraWQ2Q4cMPbnGoRULo80E44OrvY959dRoR1ejoIwZLv7
	iKKWNw2jVCxwI0S1c+A/Ol2o3XkCP7u02+bTWjkHBESH7Kd7catWh/nC7hQ==
X-Gm-Gg: ASbGnctjAoLBQl3vladtO0TunBjB5IwO8DWhR7V3Y+JpW7Z7vIr0gUzh/07kP9ulSgC
	n8EYuczbfEocLDLQQ79w/7PbQEu5G4TGbGD/QPE38eyjOsZCpJd8n0MxISZueQdj2c1S2iuZAHk
	u3f4+3x1tpQSuNq+D9ghwwfRhlGLzwFO8isB2NOwrcRdU+tdhk+zXwd4LI8/v2si48k4r0vF6Iv
	yHC1OeZc3X/djvrc/d3wl2stjt+CE7dhlV4ZDMO6tQ1TYdELQGrxQRWFFvWOAG+4vXJvKxHePzE
	luDnjbwCzvTpXzhu/JFMlwHtRLCC3bI0wsTc0d8pio1mCUyd3DIskuVZNwy8kp24mxc0nh3AVaW
	l4RyU4RZfeZ5gzImgsgShfM3K2vSPCTZD
X-Received: by 2002:a05:6000:1faf:b0:38f:3392:9fd8 with SMTP id ffacd0b85a97d-38f5878dea4mr808588f8f.18.1739912229604;
        Tue, 18 Feb 2025 12:57:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhJl5VYJN1ZER6U6SOjF2yYBkVq3hxhtLzuzokjKHCH1grxuxyGuoLNfn8/aO4cMRuRSnstQ==
X-Received: by 2002:a05:6000:1faf:b0:38f:3392:9fd8 with SMTP id ffacd0b85a97d-38f5878dea4mr808574f8f.18.1739912229238;
        Tue, 18 Feb 2025 12:57:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af? (p200300cbc70dfb00d3ed5f441b2d12af.dip0.t-ipconnect.de. [2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43987d1865asm62509405e9.3.2025.02.18.12.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 12:57:08 -0800 (PST)
Message-ID: <bda4cf52-d81a-4935-b45a-09e9439e33b6@redhat.com>
Date: Tue, 18 Feb 2025 21:57:06 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CXL Boot to Bash - Section 3: Memory (block) Hotplug
To: Gregory Price <gourry@gourry.net>
Cc: Yang Shi <shy828301@gmail.com>, lsf-pc@lists.linux-foundation.org,
 linux-mm@kvack.org, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z7OWmDXEYhT0BB0X@gourry-fedora-PF4VCD3F>
 <CAHbLzkq6Me6nRaL6b09YxJ_nFkxb+n+M3-q_aJwOs2ZO4q8VCg@mail.gmail.com>
 <Z7TLwtQY3vGUw2bO@gourry-fedora-PF4VCD3F>
 <1b4c6442-a2b0-4290-8b89-c7b82a66d358@redhat.com>
 <Z7TswQbpPV590ADr@gourry-fedora-PF4VCD3F>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z7TswQbpPV590ADr@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zngC0OOYj_5uwl5EEtc0txYT7ZCWenUk73r13D7mQc0_1739912230
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.02.25 21:25, Gregory Price wrote:
> On Tue, Feb 18, 2025 at 08:25:59PM +0100, David Hildenbrand wrote:
>> On 18.02.25 19:04, Gregory Price wrote:
>>
>> Hm?
>>
>> If you enable memmap_on_memory, we will place the memmap on that carved-out
>> region, independent of ZONE_NORMAL/ZONE_MOVABLE etc. It's the "altmap".
>>
>> Reason that we can place the memmap on a ZONE_MOVABLE is because, although
>> it is "unmovable", we told memory offlining code that it doesn't have to
>> care about offlining that memmap carveout, there is no migration to be done.
>> Just offline the block (memmap gets stale) and remove that block (memmap
>> gets removed).
>>
>> If there is a reason where we carve out the memmap and *not* use it, that
>> case must be fixed.
>>
> 
> Hm, I managed to trace down the wrong path on this particular code.
> 
> I will go back and redo my tests to sanity check, but here's what I
> would expect to see:
> 
> 1) if memmap_on_memory is off, and hotplug capacity (node1) is
>     zone_movable - then zone_normal (node0) should have N pages
>     accounted in nr_memmap_pages

Right, we'll allocate the memmap from the buddy, which ends up
allocating from ZONE_NORMAL on that node.

> 
>     1a) when dropping these memory blocks, I should see node0 memory
>         use drop by 4GB - since this is just GFP_KERNEL pages.

I assume you mean "when hotunplugging them". Yes, we should be freeing the memmap back to the buddy.

> 
> 2) if memmap_on_memory is on, and hotplug capacity (node1) is
>     zone_movable - then each memory block (256MB) should appear
>     as 252MB (-4MB of 64-byte page structs).  For 256GB (my system)
>     I should see a total of 252GB of onlined memory (-4GB of page struct)

In memory_block_online(), we have:

	/*
	 * Account once onlining succeeded. If the zone was unpopulated, it is
	 * now already properly populated.
	 */
	if (nr_vmemmap_pages)
		adjust_present_page_count(pfn_to_page(start_pfn), mem->group,
					  nr_vmemmap_pages);

So we'd add the vmemmap pages to
* zone->present_pages
* zone->zone_pgdat->node_present_pages

(mhp_init_memmap_on_memory() moved the vmemmap pages to ZONE_MOVABLE)

However, we don't add them to
* zone->managed_pages
* totalram pages

/proc/zoneinfo would show them as present but not managed.
/proc/meminfo would not include them in MemTotal

We could adjust the latter two, if there is a problem.
(just needs some adjust_managed_page_count() calls)

So yes, staring at MemTotal, you should see an increase by 252 MiB right now.

> 
>     2a) when dropping these memory blocks, I should see node0 memory use
>         stay the same - since it was vmemmap usage.

Yes.

> 
> I will double check that this isn't working as expected, and i'll double
> check for a build option as well.
> 
> stupid question - it sorta seems like you'd want this as the default
> setting for driver-managed hotplug memory blocks, but I suppose for
> very small blocks there's problems (as described in the docs).

The issue is that it is per-memblock. So you'll never have 1 GiB ranges
of consecutive usable memory (e.g., 1 GiB hugetlb page).

> 
> :thinking: - is it silly to suggest maybe a per-driver memmap_on_memory
> setting rather than just a global setting?  For CXL capacity, this seems
> like a no-brainer since blocks can't be smaller than 256MB (per spec).

I thought we had that? See MHP_MEMMAP_ON_MEMORY set by dax/kmem.

IIRC, the global toggle must be enabled for the driver option to be considered.

-- 
Cheers,

David / dhildenb

