Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B30B1E1041
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955202; cv=none; b=OWQYIEoc5mOPbQZJNJAShWltQA7by3w/YFUXXjYzXTO1KczHKSbuNxpRhIa0BFAMm0WBxqM2aEbb/ri6vPPj2VGmMqx/zib9raPQMfXv1634j0cOa3diBitHumWq1YK2fWWjDpwXuU059Gm2tYau/8r85Dq/dac34f+N/ZHh6Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955202; c=relaxed/simple;
	bh=mxWh7ll8uxiPpIsYTT3ZtmhEUvYjQT1y5Uf0VRC+VX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TwdADbtJf/2g0E2x3V+9U/U3jth02UmstyrZ63Q2YspqCBroi4iDOB4C4i7AgDKLmGxtVje5sobWxlRtyzl9L8w4HO78dCVpmCsX/IgclK9LoR50re8H+piYg20oGR0lwiHgU8IZjol60co3YavfKhe5hua7PIvG4qKPuXILmNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CduYxAYE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CduYxAYE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739955195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y3RTKbzPGzhYU0bOzSORSMZdnlNJ+TKlrPge/3JxlnU=;
	b=CduYxAYE0pLhgBCEAxHw/S0rUCWHZ0DYNHe4ZWjt7VGDddllBeGnalDFntjRDYo+85czhU
	DbUzxNGW97bc3auiDSUmbc88A2pCQg86RRMPT4Kkdvs/nqlmfKn1adO74t9ocbI9y1r9/7
	Nxxnopp/f4ju5Pi71G0ewgcw8YPdVrQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-ulJlruG0N8SVGJU2g8Y84A-1; Wed, 19 Feb 2025 03:53:11 -0500
X-MC-Unique: ulJlruG0N8SVGJU2g8Y84A-1
X-Mimecast-MFC-AGG-ID: ulJlruG0N8SVGJU2g8Y84A_1739955191
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4399a5afc95so2622285e9.3
        for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 00:53:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739955190; x=1740559990;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y3RTKbzPGzhYU0bOzSORSMZdnlNJ+TKlrPge/3JxlnU=;
        b=aE0fViXNdJT4UytIZ40mvjj0zkJc0/CuhqSi+I60+JncJ4fEbsYb7lWxKPPrE9wmOC
         KVL4oxIOeY5cTMS1c8RMOj5RXKeAt8S+DT1OUr0UVfYXrOEqAJi1vsG2q34/WZqStjfx
         spVSA8XBZCdOkLbgOYzT7n+DwMrYX1UwIyI29lI+0+Fg7A/1qff5EFTpWmYXgbGa3Pof
         vw8VlHz/SG41vQFh8LZo8XmMSKl1QY137fxWJAVeh6JulqjL3JTCFsEmD00byfH6ybun
         ZAam7Sv9aIpTtR1V6M/aqnlPVS0y7EbXeX16XztbPYCLvgnZ/ib5RHWbIYvUWt6WoeAD
         kZfw==
X-Forwarded-Encrypted: i=1; AJvYcCUCUTWPnyPpD2inHnecK+Va8dniE2jjWP7vafLtmG81URJ5S+StwHBnEhnbeqSvq5KtHiYrK5HBnvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGsvAn/NOttO7F3G+9S/JW7I51E9310PPw5/4a+VqNZYaJXJYS
	RH6YN4vI3P8D/pW0zrNHsnf7Pme+qZWyPJfpd9gSiMTWlYMbOEF4tjP6Wrehaag0vCQiuwK1o0N
	pDUoX+eAKmWRG8j9W22gNpvoylvk4BckmvGYMRTlWIYZ16Ev4h3VkiSdXNHtfOojbh6YL
X-Gm-Gg: ASbGncvcrZkqOsJ5kE1Vp1FArgyrFPrmiHTALW2G975+m/bf8u8K18Is11zW4Uh2M10
	fE+pxY8K/toLwfQcHdx8udzqar5d46f41MkcyMU3O2ZuMnkHdgvTgFrHBeWk+LzCYzKtyxYdHiV
	tT0UDu0H3mfHu5zHfTogYclN+o/mto/+9poS6dcrUkMB69StMKAX2VN8PAyewwOd0zSP+dD8VxR
	kYTqsYFG1hcvbiiQCNLYuIazIjJGrJNZwPd2TKvRxFtni1N0lVtuidJFWJhbF2LODSzxpZ6+yFw
	5TV/vxxJ2vQEaYMiTYIiSdS681MxwS17vs4=
X-Received: by 2002:a05:600c:468d:b0:439:91dd:cfa3 with SMTP id 5b1f17b1804b1-43991ddd1f7mr71014715e9.29.1739955190484;
        Wed, 19 Feb 2025 00:53:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHx30RG+4JLoDz7Ka+fSqZ4eEfXF8qqBuHgGrd9WrXzZoAldBNNjBxMEAYKQO9+ocdK769P4w==
X-Received: by 2002:a05:600c:468d:b0:439:91dd:cfa3 with SMTP id 5b1f17b1804b1-43991ddd1f7mr71014465e9.29.1739955190069;
        Wed, 19 Feb 2025 00:53:10 -0800 (PST)
Received: from [192.168.3.141] (p5b0c68c8.dip0.t-ipconnect.de. [91.12.104.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4399c5f901bsm5799465e9.3.2025.02.19.00.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 00:53:08 -0800 (PST)
Message-ID: <e332391c-30fb-49c3-9c05-574b0c486a81@redhat.com>
Date: Wed, 19 Feb 2025 09:53:07 +0100
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
 <bda4cf52-d81a-4935-b45a-09e9439e33b6@redhat.com>
 <Z7UvchoiRUg_cnhh@gourry-fedora-PF4VCD3F>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z7UvchoiRUg_cnhh@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ClvJCnlca7su1GXAS8r-LLcwrZbs8G3bdeVbUbZNUCo_1739955191
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> What's mildly confusing is for pages used for altmap to be accounted for
> as if it's an allocation in vmstat - but for that capacity to be chopped
> out of the memory-block (it "makes sense" it's just subtly misleading).

Would the following make it better or worse?

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 4765f2928725c..17a4432427051 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -237,9 +237,12 @@ static int memory_block_online(struct memory_block *mem)
          * Account once onlining succeeded. If the zone was unpopulated, it is
          * now already properly populated.
          */
-       if (nr_vmemmap_pages)
+       if (nr_vmemmap_pages) {
                 adjust_present_page_count(pfn_to_page(start_pfn), mem->group,
                                           nr_vmemmap_pages);
+               adjust_managed_page_count(pfn_to_page(start_pfn),
+                                         nr_vmemmap_pages);
+       }
  
         mem->zone = zone;
         mem_hotplug_done();
@@ -273,17 +276,23 @@ static int memory_block_offline(struct memory_block *mem)
                 nr_vmemmap_pages = mem->altmap->free;
  
         mem_hotplug_begin();
-       if (nr_vmemmap_pages)
+       if (nr_vmemmap_pages) {
                 adjust_present_page_count(pfn_to_page(start_pfn), mem->group,
                                           -nr_vmemmap_pages);
+               adjust_managed_page_count(pfn_to_page(start_pfn),
+                                         -nr_vmemmap_pages);
+       }
  
         ret = offline_pages(start_pfn + nr_vmemmap_pages,
                             nr_pages - nr_vmemmap_pages, mem->zone, mem->group);
         if (ret) {
                 /* offline_pages() failed. Account back. */
-               if (nr_vmemmap_pages)
+               if (nr_vmemmap_pages) {
                         adjust_present_page_count(pfn_to_page(start_pfn),
                                                   mem->group, nr_vmemmap_pages);
+                       adjust_managed_page_count(pfn_to_page(start_pfn),
+                                                 nr_vmemmap_pages);
+               }
                 goto out;
         }
  
Then, it would look "just like allocated memory" from that node/zone.

As if, the memmap was allocated immediately when we onlined the memory
(see below).

> 
> I thought the system was saying i'd allocated memory (from the 'free'
> capacity) instead of just reducing capacity.

The question is whether you want that memory to be hidden from MemTotal
(carveout?) or treated just like allocated memory (allocation?).

If you treat the memmap as "just a memory allocation after early boot"
and "memap_on_memory" telling you to allocate that memory from the
hotplugged memory instead of the buddy, then "carveout"
might be more of an internal implementation detail to achieve that memory
allocation.


>>> stupid question - it sorta seems like you'd want this as the default
>>> setting for driver-managed hotplug memory blocks, but I suppose for
>>> very small blocks there's problems (as described in the docs).
>>
>> The issue is that it is per-memblock. So you'll never have 1 GiB ranges
>> of consecutive usable memory (e.g., 1 GiB hugetlb page).
>>
> 
> That makes sense, i had not considered this.  Although it only applies
> for small blocks - which is basically an indictment of this suggestion:
> 
> https://lore.kernel.org/linux-mm/20250127153405.3379117-1-gourry@gourry.net/
> 
> So I'll have to consider this and whether this should be a default.
> It's probably this is enough to nak this entirely.
> 
> 
> ... that said ....
> 
> Interestingly, when I tried allocating 1GiB hugetlb pages on a dax device
> in ZONE_MOVABLE (without memmap_on_memory) - the allocation fails silently
> regardless of block size (tried both 2GB and 256MB).  I can't find a reason
> why this would be the case in the existing documentation.

Right, it only currently works with ZONE_NORMAL, because 1 GiB pages are
considered unmovable in practice (try reliably finding a 1 GiB area to
migrate the memory to during memory unplug ... when these hugetlb things are
unswappable etc.).

I documented it under https://www.kernel.org/doc/html/latest/admin-guide/mm/memory-hotplug.html

"Gigantic pages are unmovable, resulting in user space consuming a lot of unmovable memory."

If we ever support THP in that size range, we might consider them movable
because we can just split/swapout them when allcoating a migration target
fails.

> 
> (note: hugepage migration is enabled in build config, so it's not that)
> 
> If I enable one block (256MB) into ZONE_NORMAL, and the remainder in
> movable (with memmap_on_memory=n) the allocation still fails, and:
> 
>     nr_slab_unreclaimable 43
> 
> in node1/vmstat - where previously there was nothing.
> 
> Onlining the dax devices into ZONE_NORMAL successfully allowed 1GiB huge
> pages to allocate.
> > This used the /sys/bus/node/devices/node1/hugepages/* interfaces to test
> 
> Using the /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages with
> interleave mempolicy - all hugepages end up on ZONE_NORMAL.
> 
> (v6.13 base kernel)
> 
> This behavior is *curious* to say the least.  Not sure if bug, or some
> nuance missing from the documentation - but certainly glad I caught it.

See above :)

> 
> 
>> I thought we had that? See MHP_MEMMAP_ON_MEMORY set by dax/kmem.
>>
>> IIRC, the global toggle must be enabled for the driver option to be considered.
> 
> Oh, well, that's an extra layer I missed.  So there's:
> 
> build:
>    CONFIG_MHP_MEMMAP_ON_MEMORY=y
>    CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
> global:
>    /sys/module/memory_hotplug/parameters/memmap_on_memory
> device:
>    /sys/bus/dax/devices/dax0.0/memmap_on_memory
> 
> And looking at it - this does seem to be the default for dax.
> 
> So I can drop the existing `nuance movable/memmap` section and just
> replace it with the hugetlb subtleties x_x.
> 
> I appreciate the clarifications here, sorry for the incorrect info and
> the increasing confusing.


No worries. If you have ideas on what to improve in the memory hotplug
docs, please let me know!


-- 
Cheers,

David / dhildenb

