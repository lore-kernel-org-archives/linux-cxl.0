Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2361A01DF
	for <linux-cxl@vger.kernel.org>; Thu,  5 Sep 2024 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540133; cv=none; b=ABxYx++yXGphaifB+BzPgm7PrU6smWlDwYfK4zyOyztB7ykdK4WnYa1JnJQseY8tIKxKgtbZ+NFoAv92HrPybKwRjePwxBSQuW2HWKnMbeKZ0MxGQqztNpL/osZytAb0S/55rS9kQ/nY4VO5xl8tDPeGBr6ZRLnNxmDMZal/8ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540133; c=relaxed/simple;
	bh=ps5UeX+0CZdJPnb+T0w5Dj5igBGNu0bBQbg77KpVoks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ag4xqNji3EHX31LfpMBqZqey1RXAk2W/dIiMC8KHirKIwcKP/OuwjeFTKHa3jDmCp7lbzKwqMCl/1xB3LfNODCMJ+ONqPuWqeyJonctGLGyiK4hqMR9wXwFB6hTFAH/MTiSj/a2nXNgifelPr39BSajxnnQgVPI+SSQvh4fvFOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N1V4BRpK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1V4BRpK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725540131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AWLjxlyG6MNJ9NNgOdjrfJv2TVSkbcHO8UdCdHklODg=;
	b=N1V4BRpKHOfNoO906zk87HxmHl1x4gHc1FI7ih7RYZdKH8yTPsa5RZ4vp9K4QouSIlMpCb
	PctyJ46Nc2G4S/hU1Vz0czK5ioOgY4LFOZxWjrfQriw8luaQ9HhTw6WwxavoBefRbRcD5l
	YRL0MdJlaK2y/bNFsLyyQ8i+RIGOZWs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547--0y0x5tAOUy8BWqXggUAmg-1; Thu, 05 Sep 2024 08:42:09 -0400
X-MC-Unique: -0y0x5tAOUy8BWqXggUAmg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3756212a589so539324f8f.2
        for <linux-cxl@vger.kernel.org>; Thu, 05 Sep 2024 05:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725540129; x=1726144929;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AWLjxlyG6MNJ9NNgOdjrfJv2TVSkbcHO8UdCdHklODg=;
        b=J3+DH5KjuMylm6fyK9VvSzpEAAgoK09jpUOHkvaes5/gcsz68nzybPgtDOMkCoQUDz
         8gBezvxOiGVdrrEt4pftf/IR2ClQo87E/h+aNszaSH2O3hRlEHiTYMqC3Jt4XtVzdDx5
         1eI1NyoVGwThqVFcsaBJXgQYYWNJLYzX/MLwB/EAbrIWkfZgFtJV3u4Ogbs7NL3oJA7Z
         dD73fhIAQXcsfh9SzOqkSb4Of0D4akQmJrwG7H46O5yoqEpRRfFiyRpcMTNH35Npwwlc
         hrJy1ziq630HWG5beAxGEw4q+jL2d57raDLZ3nTNnAXXhJEPSWLUX3kz3kIuj6OsOQtb
         797w==
X-Forwarded-Encrypted: i=1; AJvYcCVeD2xtkjJWtOEMid9ZKQVRFRXuOOC0uguqj8enqf0Ti3S/rynUHVvA0IxtkiCzGVYnGMv2W87ZtkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5H4ChU3keKzpo32ql4WC0j5PmKfcXRCLLqQKIuAMzy7qyGVB1
	d3xB5pQbTVj8D/K24nP0b2Cd45W7mF0/k/6OAljSl+Ptwyx15mChDkFhxJkYydUYiww6wHAtmvy
	VoaYDtZ0PnYSJT54BNnZjkj7HrFFj6jUOJ23s8DVcKqYZlVFxAJPUCXuIkw==
X-Received: by 2002:a05:6000:4402:b0:374:c429:b066 with SMTP id ffacd0b85a97d-374c429b877mr10108106f8f.63.1725540128705;
        Thu, 05 Sep 2024 05:42:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ76mkRukxOE2tVzMaf6gAkRBrdUVwIbrHp6flwPi8MX66gZWz5NSD6eAERJ4CoWW4rBpT8Q==
X-Received: by 2002:a05:6000:4402:b0:374:c429:b066 with SMTP id ffacd0b85a97d-374c429b877mr10108057f8f.63.1725540127841;
        Thu, 05 Sep 2024 05:42:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:5400:6c12:d0e2:3757:2963? (p200300cbc70854006c12d0e237572963.dip0.t-ipconnect.de. [2003:cb:c708:5400:6c12:d0e2:3757:2963])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42c7f172be3sm148917725e9.36.2024.09.05.05.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 05:42:07 -0700 (PDT)
Message-ID: <09d44b21-9739-417b-a76c-5383fcbde96b@redhat.com>
Date: Thu, 5 Sep 2024 14:42:05 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v2] Resource: fix region_intersects() for CXL memory
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
 "Huang, Ying" <ying.huang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Alistair Popple <apopple@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Baoquan He <bhe@redhat.com>
References: <20240819023413.1109779-1-ying.huang@intel.com>
 <ZsL-wfDYsUmWKBep@smile.fi.intel.com>
 <874j6vc10j.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <66d8f41cb3e6_3975294f9@dwillia2-xfh.jf.intel.com.notmuch>
 <ZtmOTYF9EWPeLg5u@smile.fi.intel.com>
 <65838cc0-9a20-4994-a0ef-9cd50bb00951@redhat.com>
 <Ztmlw1q3Djn94MRQ@smile.fi.intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Ztmlw1q3Djn94MRQ@smile.fi.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.09.24 14:36, Andy Shevchenko wrote:
> On Thu, Sep 05, 2024 at 01:08:35PM +0200, David Hildenbrand wrote:
>> On 05.09.24 12:56, Andy Shevchenko wrote:
>>> On Wed, Sep 04, 2024 at 04:58:20PM -0700, Dan Williams wrote:
>>>> Huang, Ying wrote:
>>>>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> 
> [..]
> 
>>>>>> You may move Cc list after '---', so it won't unnecessarily pollute the commit
>>>>>> message.
>>>>>
>>>>> Emm... It appears that it's a common practice to include "Cc" in the
>>>>> commit log.
>>>>
>>>> Yes, just ignore this feedback, it goes against common practice. Cc list
>>>> as is looks sane to me.
>>>
>>> It seems nobody can give technical arguments why it's better than just keeping
>>> them outside of the commit message. Mantra "common practice" nowadays is
>>> questionable.
>>
>> Just look at how patches look like in the git tree that Andrew picks up.
>> (IIRC, he adds a bunch of CCs himself that are not even part of the original
>> patch).
> 
> I know that and it's historical, he has a lot of the scripts that work and when
> he moved to the Git it was another long story. Now you even can see how he uses
> Git in his quilt approach. So, it's an exceptional and not usual workflow, hence
> bad example. Try again :-)

Point is, it doesn't matter what we do in this patch here if Andrew will 
unify it at all.

> 
>> Having in the git tree who was actually involved/CCed can be quite valuable.
>> More helpful than get_maintainers.pl sometimes.
> 
> First of all, there is no guarantee they _were_ involved. From this perspective
> having Link: tag instead has much more value and supports my side of arguments.

Link is certainly preferable. Usually when I fix a commit, I make sure 
to CC the people that are listed for the patch, because it at least 
should have ended up in their mailbox.

Often, it also helped to see if a buggy commit was at least CCed to the 
right persons without digging through mailing list archives.

-- 
Cheers,

David / dhildenb

