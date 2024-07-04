Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF4F1A3BBD
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jul 2024 08:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720080881; cv=none; b=hO1JPryhhxulladOW5KnuxuCQIWv6KK0MIaux9wUblenJZf/dozlWsT9aon8x6px5pmV6psVLbAhdLjr5tkKBw6RkmbXIE+ffcLYCEYwZtW0wcmT0llbdRXf3IM3oPS2NxGfNvY6Uxn5Mz2/Ke19N1HnZLrpE9XKkIsuhDZXEw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720080881; c=relaxed/simple;
	bh=E6cTkbd+Uo1iApHe8+Rt8ePbTv4sO/QA5EfP/gLEz+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bf6P7kdFYx1r2+7M0djEf8bhRgLBVjX5/0aDcR8sPSl0unC5hiuKy6rDlh8Oc9BeqWaEg94RTGgvZZa47Iazy/kyQnK0kORumc8h1NZKIEf+ezY6ueWuvA47f5P3QLhH632F2kUNe+Ao6zscUSX0ESpd7vC0A9kqSObgHMXmzog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LnmuG3pS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LnmuG3pS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720080878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NKAYwbOeNVx8H+U7NIZc3NPeZvy7lixprbWwSSr80cM=;
	b=LnmuG3pSz7rWPHYDuRCGNN5Csb+ilI3Airh0vn5C22MM+FimdSt3oxQ9wxOxg9xqoDtKJN
	KzbL+xJnLRf9qt5a9IzLz6qqESoQAHRrwgaXYmfrRgpal02k2ivkJ6UV7fQPnzlWRY2IDM
	kemviesn0gVSGv26pqgjITDvMYu38I0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-SHeVYp0RMLOwVsDiE1yoZA-1; Thu, 04 Jul 2024 04:14:35 -0400
X-MC-Unique: SHeVYp0RMLOwVsDiE1yoZA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42490ae735dso3934145e9.0
        for <linux-cxl@vger.kernel.org>; Thu, 04 Jul 2024 01:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720080874; x=1720685674;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NKAYwbOeNVx8H+U7NIZc3NPeZvy7lixprbWwSSr80cM=;
        b=i2Y/b1EgVP1jasgcI0yxCEPUAOsUXi/y9zA63Vqi8rcu+Urvfykoy/qacMVOHfxah0
         m+34vnGkXpL1c0jnq47XI/W3NNkate8uA+OSUpINkQDtiFA4wXvpfJ6B1UV+PfOVVasJ
         RLVkAiwaSeBlm9JtXSnwYVyu4I4EMsS6kV9dQHNkvpjyBpj5JTNvAP84Qizf3zxFQtXT
         tSY2nTN7YihNCSVx355tgKeBk3K3PCNJvbG/aIA/6ZL2wwLZ2saCxPogImeASDhwpeDP
         PPHzlsXycU/4PsSXmgSnTt1LjNFKEzxZEXY1v8eWfKEYN8+vHJmbSF/eCJibV5dC6hR/
         g2gA==
X-Forwarded-Encrypted: i=1; AJvYcCVRT8btIi2X7yCdOIBDcbBN3Wx8uhAlgrEA7jQHLNwmSIk1K5N/Hrt4EA54iC2Rc+2wDn95ytz0cSHQy3uWBmNAfscDoIWGmQtQ
X-Gm-Message-State: AOJu0YzdRer96U0OA7v5JYroyZpTv2+XL+CEvcbFvOHXYnqMKzKBDUD4
	EUQFdrT1HO6Ke3Ujw9Y8Y6CdIKomQSJyC0/oqK+CleX5NA82tA50EExpWUqHEGNMnzlB8ErISiV
	uMDrc1iU2YlLdwzz/biSLkjA8kJlSZibGH9HfMNtIAYsWynIB2vssJBanWg==
X-Received: by 2002:a05:600c:12d2:b0:425:73ba:e012 with SMTP id 5b1f17b1804b1-4264a3bc309mr7821645e9.7.1720080873817;
        Thu, 04 Jul 2024 01:14:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFysbtV4lijwjoywVl2Jz+9M+2rwRqroz1OcadDG27qREV/kETxgRExJ8TK56vfC6S7eartCQ==
X-Received: by 2002:a05:600c:12d2:b0:425:73ba:e012 with SMTP id 5b1f17b1804b1-4264a3bc309mr7821345e9.7.1720080873353;
        Thu, 04 Jul 2024 01:14:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:8600:f05d:97b6:fb98:2bc1? (p200300cbc7158600f05d97b6fb982bc1.dip0.t-ipconnect.de. [2003:cb:c715:8600:f05d:97b6:fb98:2bc1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2b4976sm13581405e9.48.2024.07.04.01.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 01:14:32 -0700 (PDT)
Message-ID: <95b2bba5-7652-48d8-b6ec-bae7faeed501@redhat.com>
Date: Thu, 4 Jul 2024 10:14:31 +0200
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
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>, Zi Yan <ziy@nvidia.com>,
 Johannes Weiner <hannes@cmpxchg.org>
References: <6a07125f-e720-404c-b2f9-e55f3f166e85@fujitsu.com>
 <5a4ef056-73c7-42e9-a839-43d42f8b7eab@fujitsu.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <5a4ef056-73c7-42e9-a839-43d42f8b7eab@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.07.24 09:43, Zhijian Li (Fujitsu) wrote:
> All,
> 
> Some progress updates
> 
> When issue occurs, calling __drain_all_pages() can make offline_pages() escape from the loop.
> 
>>
>> Jun 28 15:29:26 linux kernel: page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7980dd
>> Jun 28 15:29:26 linux kernel: flags: 0x9fffffc0000000(node=2|zone=3|lastcpupid=0x1fffff)
>> Jun 28 15:29:26 linux kernel: raw: 009fffffc0000000 ffffdfbd9e603788 ffffd4f0ffd97ef0 0000000000000000
>> Jun 28 15:29:26 linux kernel: raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
>> Jun 28 15:29:26 linux kernel: page dumped because: trouble page...
>>
> 
> With this problematic page structure contents, it seems that the
> list_head = {ffffdfbd9e603788, ffffd4f0ffd97ef0} is valid.
> 
> I guess it was linking to the pcp_list, so I dumped the per_cpu_pages[cpu].count
> in every in critical timings.

So, is your reproducer getting fixed when you call __drain_all_pages() 
in the loop? (not that it's the right fix, but a could datapoint :) )

> 
> An example is as below,
> offline_pages()
> {
> 	// per_cpu_pages[1].count = 0
> 	zone_pcp_disable() // will call __drain_all_pages()
> 	// per_cpu_pages[1].count = 188
> 	do {
> 		do {
> 			scan_movable_pages()
> 			ret = do_migrate_range()
> 		} while (!ret)
> 
> 		ret = test_pages_isolated()
> 
> 		if(is the 1st iteration)
> 			// per_cpu_pages[1].count = 182
> 
> 		if (issue occurs) { /* if the loop take beyond 10 seconds */
> 			// per_cpu_pages[1].count = 61
> 			__drain_all_pages()
> 			// per_cpu_pages[1].count = 0
> 			/* will escape from the outer loop in later iterations */
> 		}
> 	} while (ret)
> }
> 
> Some interesting points:
>    - After the 1st __drain_all_pages(), per_cpu_pages[1].count increased to 188 from 0,
>      does it mean it's racing with something...?
>    - per_cpu_pages[1].count will decrease but not decrease to 0 during iterations
>    - when issue occurs, calling __drain_all_pages() will decrease per_cpu_pages[1].count to 0.

That's indeed weird. Maybe there is a race, or zone_pcp_disable() is not 
fully effective for a zone?

> 
> So I wonder if it's fine to call __drain_all_pages() in the loop?
> 
> Looking forward to your insights.

So, in free_unref_page(), we make sure to never place MIGRATE_ISOLATE 
onto the PCP. All pageblocks we are going to offline should be isolated 
at this point, so no page that is getting freed and part of the 
to-be-offlined range should end up on the PCP. So far the theory.


In offlining code we do

1) Set MIGRATE_ISOLATE
2) zone_pcp_disable() -> set high-and-batch to 0  and drain

Could there be a race in free_unref_page(), such that although 
zone_pcp_disable() succeeds, we would still end up with a page in the 
pcp? (especially, one that has MIGRATE_ISOLATE set for its pageblock?)


-- 
Cheers,

David / dhildenb

