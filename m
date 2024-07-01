Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AB82AD05
	for <linux-cxl@vger.kernel.org>; Mon,  1 Jul 2024 07:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818076; cv=none; b=VF83/Hwpni+xQIz1jLgOOnQqRQor3cJNXr9u1P1Fl3/WY8+oRlPbOucTFCPfUThFu9cWsEYVof2kPnICY05R1Z/z+/47h+YhU5MVAhK7CNTY/HfP5QEzx4S7kBt5UP6VnnLqErtPVvZk6pSW/11BLaKdAAilcMkyjsRSW3D4zCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818076; c=relaxed/simple;
	bh=w/68zikoFldFlVDqSQv4LpGltKzxWIOHhpxyF6ulgRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKSQQvuQqT+mKxsjlPVgc2WzHrXzRqipuA33rto08cGFyo1dxYGEf5WYrH0pHQhvhdGX+RKQ76z7JC6GeisJVplQbWM/uPQDCgrhs0heCsVHSajwrxJFrURImrx1XSrUAlEGpCg3gPMhEWqX80xhWozXf76JQzlZJ9gySunYSTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZMCi4p9r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMCi4p9r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719818073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VZtx1TI9CHzvib+rgK9jrkHHn0d7MZ2Du3tOelQ2tzg=;
	b=ZMCi4p9rrezQigxRVcDirrOREzu36ZgPNuDrzVpne0f4FkpvRbi4am4u8aYuz0ROc/Tl6n
	Z+j5J29ki20GQa1OOxL6pUY+zOvxXGTOl8gBfTURAcBFKhySfgzKLy09QTiHDadbMnbsAu
	aKzoJurR+86qUvRhLAupnq73ZlJaIqg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-xYizOb6SN5K4YrciXMfORg-1; Mon, 01 Jul 2024 03:14:32 -0400
X-MC-Unique: xYizOb6SN5K4YrciXMfORg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-364255da852so1892945f8f.2
        for <linux-cxl@vger.kernel.org>; Mon, 01 Jul 2024 00:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719818071; x=1720422871;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VZtx1TI9CHzvib+rgK9jrkHHn0d7MZ2Du3tOelQ2tzg=;
        b=JOlwLOFFr/BGnCTBPIII84/aKEWOeoya0RtOlCdJY7AT/WSRONsJDBTUJBM4AOdgfI
         8Kk8ZDfkfnQFLk89/D9AA8gj3Y/0SLmmSmDUb9DY/aYFD1tdnrA0TrJEZbOV55q13IXc
         zFM4SSdaFTkZ6cSuPtAq2YGjtNd277tLG6+N1kD5g5PICscgxlvPO08TAiWOawFlPs7E
         UIN0qZ/tlNJO3UD3obCGPVHqcbieZSfyNZwc+gUHEtLxmXMxipxSyN/qjqLSRIKR5hqF
         FJc2SiJZq691oU68J9Q5oClevSwiSAxDVOsGu8RX8ZKepPIF0J532gs7RJPT47Qj9Rtd
         wNXA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ3l08o+GPKjyOBzmlfCLQyjMA9O9QT+bBe0gqneFnceq96FqIWCbIywcaPqJRsTRMp2CKm7kUgiE991r94Q0wJj5wsyZwd/ci
X-Gm-Message-State: AOJu0YxoEU0uC49YIA8mYEIQ4SLIm47GwIHAKn8EhoNUxuk2sRlgr4pU
	E+XrMc7TkpkrYJMLwivHsPZXfON6IQybpMCZlwzW6Ei3cRQRSQRYNeaDyjUB+LhuszRseZVkmDF
	eC33X9nGDT+oENHPjDmeba3R/Gw0+kf+I+o38SoaJnmHh8oj97B+Jo80YGA==
X-Received: by 2002:a5d:6483:0:b0:367:4d9d:56a5 with SMTP id ffacd0b85a97d-367757247fdmr3004294f8f.44.1719818071155;
        Mon, 01 Jul 2024 00:14:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHBkH8EmNBYc0VbYj0wklpvddeAsgKKczTBqdE81snbQRQuE6ATiW0y8fyo2ESK0CI0aeIZw==
X-Received: by 2002:a5d:6483:0:b0:367:4d9d:56a5 with SMTP id ffacd0b85a97d-367757247fdmr3004280f8f.44.1719818070682;
        Mon, 01 Jul 2024 00:14:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72e:2200:7ed7:c239:d423:3b31? (p200300cbc72e22007ed7c239d4233b31.dip0.t-ipconnect.de. [2003:cb:c72e:2200:7ed7:c239:d423:3b31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fb92fsm9278687f8f.88.2024.07.01.00.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 00:14:30 -0700 (PDT)
Message-ID: <68b4b249-ceac-4d5b-9d15-a2e33a1187e5@redhat.com>
Date: Mon, 1 Jul 2024 09:14:29 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG ?] Offline Memory gets stuck in offline_pages()
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
 Oscar Salvador <osalvador@suse.de>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <6a07125f-e720-404c-b2f9-e55f3f166e85@fujitsu.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6a07125f-e720-404c-b2f9-e55f3f166e85@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.07.24 03:25, Zhijian Li (Fujitsu) wrote:
> Hi all
> 
> 
> Overview:
> During testing the CXL memory hotremove, we noticed that `daxctl offline-memory dax0.0`
> would get stuck forever sometimes. daxctl offline-memory dax0.0 will write "offline" to
> /sys/devices/system/memory/memoryNNN/state.

Hi,

See

Documentation/admin-guide/mm/memory-hotplug.rst

"
Further, when running into out of memory situations while migrating 
pages, or when still encountering permanently unmovable pages within 
ZONE_MOVABLE (-> BUG), memory offlining will keep retrying until it 
eventually succeeds.

When offlining is triggered from user space, the offlining context can 
be terminated by sending a signal. A timeout based offlining can easily 
be implemented via::

	% timeout $TIMEOUT offline_block | failure_handling
"

> 
> Workaround:
> When it happens, we can type Ctrl-C to abort it and then retry again.
> Then the CXL memory is able to offline successfully.
> 
> Where the kernel gets stuck:
> After digging into the kernel, we found that when the issue occurs, the kernel
> is stuck in the outer loop of offline_pages(). Below is a piece of the
> highlighted offline_pages():
> 
> ```
> int __ref offline_pages()
> {
>     do { // outer loop
>       pfn = start_pfn;
>       do {
>         ret = scan_movable_pages(pfn, end_pfn, &pfn);  // It returns -ENOENT
>         if (!ret)
>            do_migrate_range(pfn, end_pfn);             // Not reach here
>       } while (!ret);
>       ret = test_pages_isolated(start_pfn, end_pfn, MEMORY_OFFLINE);
>       } while (ret);                                   // ret is -EBUSY
> }
> ```
> 
> In this case, we dumped the first page that cannot be isolated (see dump_page below), it's
> content does not change in each iteration.:
> ```
> Jun 28 15:29:26 linux kernel: page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7980dd
> Jun 28 15:29:26 linux kernel: flags: 0x9fffffc0000000(node=2|zone=3|lastcpupid=0x1fffff)
> Jun 28 15:29:26 linux kernel: raw: 009fffffc0000000 ffffdfbd9e603788 ffffd4f0ffd97ef0 0000000000000000
> Jun 28 15:29:26 linux kernel: raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> Jun 28 15:29:26 linux kernel: page dumped because: trouble page...

Are you sure that's the problematic page?

refcount:0

Indicates that the page is free. But maybe it does not have PageBuddy() set.

It could also be that this is a "tail" page of a PageBuddy() page, and 
somehow we always end up on the tail in test_pages_isolated().

Which kernel + architecture are you testing with?

> ```
> 
> Every time the issue occurs, the content of the page structure is similar.
> 
> Questions:
> Q1. Is this behavior expected? At least for an OS administrator, it should return
>       promptly (success or failure) instead of hanging indefinitely.

It's expected that it might take a long time (possibly forever) in 
corner cases. See documentation.

But it's likely unexpected that we have some problematic page here.

> Q2. Regarding the offline_pages() function, encountering such a page indeed causes
>       an endless loop. Shouldn't another part of the kernel timely changed the state
>       of this page?

There are various things that can go wrong. One issue might be that we 
try migrating a page but continuously fail to allocate memory to be used 
as a migration target. It seems unlikely with the page you dumped above, 
though.

Do you maybe have that CXL memory be on a separate "fake" NUMA node, and 
your workload mbind() itself to that NUMA node, possibly refusing to 
migrate somewhere else?

> 
>       When I use the workaround mentioned above (Ctrl-C and try offline again), I find
>       that the page state changes (see dump_page below):
> ```
> Jun 28 15:33:12 linux kernel: page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7980dd
> Jun 28 15:33:12 linux kernel: flags: 0x9fffffc0000000(node=2|zone=3|lastcpupid=0x1fffff)
> Jun 28 15:33:12 linux kernel: raw: 009fffffc0000000 dead000000000100 dead000000000122 0000000000000000
> Jun 28 15:33:12 linux kernel: raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> Jun 28 15:33:12 linux kernel: page dumped because: previous trouble page
> ```
> 
> What our test does:
> We have a CXL memory device, which is configured as kmem and online into the MOVABLE
> zone as NUMA node2. We run two processes, consume-memory and offline-memory, in parallel,
> see the pseudo code below:
> 
> ```
> main()
> {
>       if (fork() == 0)
>           numactl -m 2 ./consume-memory

What exactly does "consume-memory" do? Does it involve hugetlb maybe?


-- 
Cheers,

David / dhildenb

