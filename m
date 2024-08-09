Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2CE182A0
	for <linux-cxl@vger.kernel.org>; Fri,  9 Aug 2024 07:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188675; cv=none; b=OS1ADF/bHmtCibgAOuYWsdqBldLQrr0FWVDYNfYqmOWBFVmk59Elf9M8ZO/X6q1Mhy1wKu3ulr3PeTALS7IbO2CteWU2z6XJi96ruVPbprzg72su7uOyq8bKVy6SeKgr6CaeKVAAahtfYIXFMyH2/jswcA6mth9V/V99eZMBOnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188675; c=relaxed/simple;
	bh=AI6MQPM9BvoHHnsYc5GqiespVvdfM9oqFd4pjzEMsEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JgRX3ydkZ/RXt6W/rKFpAmoo1Qp3naV5Ffuu7Q5gbVHmcR8tp6izuxWy/xZcZkVZvzw21favR63H4RPJryvd/lXnLrOUA+w3ewgTYtqzm71LIYpwKw1r0cQK3gEeY+N/Z/yHLWzPHEZIwsPx8YmqRN93Bw4ot5FJC6p5sTpdrzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P1+Mq6wd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1+Mq6wd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723188672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YnRYGEv/LM94MKGdoZkn/zwYROhxuyklFtJICqYoxoo=;
	b=P1+Mq6wdBXMlvP3UAC6O9zoYlT/Tzg0HWvpmpBYAysbEF8hA1jZEdPzf3oU2ZW2/izpPvh
	I73HD55XG/aOSG7Il9q6cGMTIwgZYQU7l9QceppoarusUgZKeqJzR2Y06jPNlbWCjIfH+e
	42fIJhf4Nk/up8pDmcaia1qjnzJjx1U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-dc4RfSj7NLW-xR9eAbbU6g-1; Fri, 09 Aug 2024 03:31:10 -0400
X-MC-Unique: dc4RfSj7NLW-xR9eAbbU6g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3687a1a6846so964808f8f.3
        for <linux-cxl@vger.kernel.org>; Fri, 09 Aug 2024 00:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723188669; x=1723793469;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnRYGEv/LM94MKGdoZkn/zwYROhxuyklFtJICqYoxoo=;
        b=f0XTU+9iJRBQAxLq/6NG/4xkisUI415Lk7EYqZaWMEogZ1mobgnDQX2v6hfoI0PRME
         vGt+QxO8vZKR5qY1RgKjdNai88mtJqXAxM/DLWDf1Mf05FZiKAt4aMx5eX9PUn9KTwjI
         ygxN35U7mLxNXLz6Mg24i8suVrsGBFZ0rm2BwtyHadhtjbjxsdEtyo/pjqbxpv6e0RFq
         yHT4lZ8nBXQNDof8qv6otw+RY3vk1cNcPVswu0HwHoehV1cS/vYMSuKkazOPPDCGWiTp
         nYRwBpK0MfA+6LvBvnoy08w3dVojZKnDpoqu04v1NBctHVsbSbzizy9Z2BxzcnmxZBYo
         /UuA==
X-Forwarded-Encrypted: i=1; AJvYcCUT/EpyJDdI4PnKN2M4xEJk5EQ2iRAHOGxwf4HdKpI0oVHc9dKRKkVnz/bMTTP5a9BvQlQcB2DE/DCMnGq6HtGfhK0dnuOy70+h
X-Gm-Message-State: AOJu0YwmyyL7v9FzZQ6+pxQBbW0Hn6NRjN8S8T0NYpYS9bbqZ+BDV30p
	El9AVB+/jMOifaFj1iTZaP04o6dJtnveLZ4QRNWgw2kW57aWgn06ozxGNqykNyzNCbZOSyQeET8
	0nnp+ZiMa8ARR1/yKlieLG7onXV1dK2SmGmG1EHf2arFPjfOONNWTmScs6Q==
X-Received: by 2002:a5d:5989:0:b0:368:87ca:3d85 with SMTP id ffacd0b85a97d-36d5eb049f3mr422564f8f.29.1723188669370;
        Fri, 09 Aug 2024 00:31:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNwHH0K++ca2l0Q8K2cg1g53qKHd8GYeGrg0GgdlgP7XKRHsgS5j1+4zw9S1byApVbwUrv+A==
X-Received: by 2002:a5d:5989:0:b0:368:87ca:3d85 with SMTP id ffacd0b85a97d-36d5eb049f3mr422529f8f.29.1723188668836;
        Fri, 09 Aug 2024 00:31:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71c:4e00:b097:7075:f6ba:300a? (p200300cbc71c4e00b0977075f6ba300a.dip0.t-ipconnect.de. [2003:cb:c71c:4e00:b097:7075:f6ba:300a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d2716e3b3sm4407425f8f.42.2024.08.09.00.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 00:31:08 -0700 (PDT)
Message-ID: <b13cf452-4573-4202-8178-26a33e9f2185@redhat.com>
Date: Fri, 9 Aug 2024 09:31:06 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] mm: don't account memmap per-node
To: Pasha Tatashin <pasha.tatashin@soleen.com>, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-cxl@vger.kernel.org,
 cerasuolodomenico@gmail.com, hannes@cmpxchg.org, j.granados@samsung.com,
 lizhijian@fujitsu.com, muchun.song@linux.dev, nphamcs@gmail.com,
 rientjes@google.com, rppt@kernel.org, souravpanda@google.com,
 vbabka@suse.cz, willy@infradead.org, dan.j.williams@intel.com,
 yi.zhang@redhat.com, alison.schofield@intel.com, yosryahmed@google.com
References: <20240808213437.682006-1-pasha.tatashin@soleen.com>
 <20240808213437.682006-4-pasha.tatashin@soleen.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240808213437.682006-4-pasha.tatashin@soleen.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.08.24 23:34, Pasha Tatashin wrote:
> Fix invalid access to pgdat during hot-remove operation:
> ndctl users reported a GPF when trying to destroy a namespace:
> $ ndctl destroy-namespace all -r all -f
>   Segmentation fault
>   dmesg:
>   Oops: general protection fault, probably for
>   non-canonical address 0xdffffc0000005650: 0000 [#1] PREEMPT SMP KASAN
>   PTI
>   KASAN: probably user-memory-access in range
>   [0x000000000002b280-0x000000000002b287]
>   CPU: 26 UID: 0 PID: 1868 Comm: ndctl Not tainted 6.11.0-rc1 #1
>   Hardware name: Dell Inc. PowerEdge R640/08HT8T, BIOS
>   2.20.1 09/13/2023
>   RIP: 0010:mod_node_page_state+0x2a/0x110
> 
> cxl-test users report a GPF when trying to unload the test module:
> $ modrpobe -r cxl-test
>   dmesg
>   BUG: unable to handle page fault for address: 0000000000004200
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: Oops: 0000 [#1] PREEMPT SMP PTI
>   CPU: 0 UID: 0 PID: 1076 Comm: modprobe Tainted: G O N 6.11.0-rc1 #197
>   Tainted: [O]=OOT_MODULE, [N]=TEST
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/15
>   RIP: 0010:mod_node_page_state+0x6/0x90
> 
> Currently, when memory is hot-plugged or hot-removed the accounting is
> done based on the assumption that memmap is allocated from the same node
> as the hot-plugged/hot-removed memory, which is not always the case.
> 
> In addition, there are challenges with keeping the node id of the memory
> that is being remove to the time when memmap accounting is actually
> performed: since this is done after remove_pfn_range_from_zone(), and
> also after remove_memory_block_devices(). Meaning that we cannot use
> pgdat nor walking though memblocks to get the nid.
> 
> Given all of that, account the memmap overhead system wide instead.
> 
> For this we are going to be using global atomic counters, but given that
> memmap size is rarely modified, and normally is only modified either
> during early boot when there is only one CPU, or under a hotplug global
> mutex lock, therefore there is no need for per-cpu optimizations.
> 
> Also, while we are here rename nr_memmap to nr_memmap_pages, and
> nr_memmap_boot to nr_memmap_boot_pages to be self explanatory that the
> units are in page count.
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/linux-cxl/CAHj4cs9Ax1=CoJkgBGP_+sNu6-6=6v=_L-ZBZY0bVLD3wUWZQg@mail.gmail.com
> Reported-by: Alison Schofield <alison.schofield@intel.com>
> Closes: https://lore.kernel.org/linux-mm/Zq0tPd2h6alFz8XF@aschofie-mobl2/#t
> 
> Fixes: 15995a352474 ("mm: report per-page metadata information")
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Tested-by: Dan Williams <dan.j.williams@intel.com>
> ---

[...]

In general

Acked-by: David Hildenbrand <david@redhat.com>

Two nits below:


>   static void free_map_bootmem(struct page *memmap)
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 6f8aa4766f16..ad82c1bf0e63 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1033,6 +1033,23 @@ unsigned long node_page_state(struct pglist_data *pgdat,
>   }
>   #endif
>   
> +/*
> + * Count number of pages "struct page" and "struct page_ext" consume.
> + * nr_memmap_boot: # of pages allocated by boot allocator & not part of MemTotal
> + * nr_memmap: # of pages that were allocated by buddy allocator
> + */
> +static atomic_long_t nr_memmap_boot, nr_memmap;

I *think* the clean and portable way to do it is use ATOMIC_INIT(0) for 
both. [even though what you have likely works on all archs]

> +
> +void mod_memmap_boot(long delta)
> +{
> +	atomic_long_add(delta, &nr_memmap_boot);
> +}
> +
> +void mod_memmap(long delta)
> +{
> +	atomic_long_add(delta, &nr_memmap);
> +}
> +

Nit picking: (up to you)

I'd do it similar to totalram_pages_add():

memmap_pages_add()
memmap_boot_pages_add()

And call the variables something like

static atomic_long_t memmap_pages_boot, memmap_pages;


-- 
Cheers,

David / dhildenb

