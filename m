Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB6022D784
	for <linux-cxl@vger.kernel.org>; Tue,  8 Apr 2025 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744136323; cv=none; b=qvgf4iwqwfQGJA4AB5Kvv+6cZNh495pzjgcGJLoQ/PXHhwDacRmwEYKnvh+D8Ml2EsBcRAOccYSs67R3iO7Ag8RxC7TrsIMx55PByhKl9BD2Kht78Eb4DQnHUcGxFH5TxWkLih40GevP9twncuxQe9pgFNNgqLBWuiML75DayO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744136323; c=relaxed/simple;
	bh=33JDFRyvDs8HR1vl7NYCjQs8vBWEkaxL/bF60gGL8Uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UVFFC17r/+l9jvHGDNotbKxHWorR+FZ84H16BjVgM4GrRLi9C2OFUfJu6uKDAYldLxMuPaRb94RNKN1ip9oNCC3Ac040wv2/rxlMezTYQkdihqcdO4HCZPXRX3+p1hoZb0FDKKYDWC3ZG22JUeBmSKWjDZ/5wUJD1uKHcTmc54A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a3tEIf5o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3tEIf5o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744136320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a5MNTcQLVVXVMARql3CFcEx28D/XK8NJIFEW1cH0fos=;
	b=a3tEIf5oKiW8ZtT2gfpSq1LBkMZMqc51MPJoHR0Ped3ECoIB5UwX51zs0+Mw93ZPY6B4Kv
	XhZRyY5lVus5E4vJBbnyDcK5VQZ+biZs4ltn9p4kPGYzYmp1p3HMTp+8b7QPeMgEzB0/GY
	ysOg0SFgt3SZ9wHbCiHtncN8zoho7RI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-_UBpDH5mPVyWa5d1kcwEfw-1; Tue, 08 Apr 2025 14:18:38 -0400
X-MC-Unique: _UBpDH5mPVyWa5d1kcwEfw-1
X-Mimecast-MFC-AGG-ID: _UBpDH5mPVyWa5d1kcwEfw_1744136317
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d22c304adso31706155e9.0
        for <linux-cxl@vger.kernel.org>; Tue, 08 Apr 2025 11:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744136317; x=1744741117;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a5MNTcQLVVXVMARql3CFcEx28D/XK8NJIFEW1cH0fos=;
        b=C48YvAA0MqCdcojhrVCKjmUc2T4vhADaayx4WK2iY6p+VMEslHBnewV/KnDr5lY4pF
         o8+TiR8hX8psqIv4+M/xid496HKRDpL1u0nFCf7uzSLR3XK4XX9hHR6wgPUFbDpRdLCb
         BTyVQGq9/7eosoZzwes1F4HmCqihfg/582qrfYPwHvJtoeeNiX+vzu4QhUcpvryH7HLS
         J3Gn6x8cMqcj73kOTmIfAaeF3xO8ifuglfL3nL0PuEp1AOlLcBIhJsr4exw7zHI9YSDC
         FnMbOTX9D0synzt0gz2L4zbNWlaSp7mtUyEdAmY0TabM/3B0/byqonwJbxIAYDXbcigC
         o/LA==
X-Forwarded-Encrypted: i=1; AJvYcCVWq/GKT+U5lBZQUfaWFp0958gMRrQDv6pH2DGpAxuZ/2ldnI/ZKAF1XarKNL7XwYFYCLnckFUOezc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfd9xl6SEi6JzSA8FPL1JZriQNIvim6Qvzzo0lXML594qMBq1h
	WCoMk0hch0UMRgu8isOyoptL+gwkxcH9ZlmKmIWpKx7AV2xkMB4E2ovJwetYRdRxTL7S4FokLiU
	KV0XZmyeUUNyxtLm8vM01DKV5bLfcvnwr9G2t0gHfJF4KQSFKTw4JTnwvew==
X-Gm-Gg: ASbGncsT+PbZ1m95At0sXcgVnkx+pqPz6k6tv5CMSpcF5cZpgWLigSvZGkZUPvIIABE
	k56+QcaqzTVv13rxowCXvsckTUoC4nOBnR7GAd7pLW3Zc/KB4emeS0ud9wKW0fnmtZyo3cF1S7i
	C9/5541/5guCWfw1nzqAfgIw/OFqwWwU2WC8qoST7v0DIxxOBqM7qcKzz2CWIkw7X+DsIMtYRlJ
	8RPf9qxuBEkwPzdVncqkI4qaHwE5akuL2hLOZ494KyGP+g/4iYoryHOa03Dpuf45OVL8Ta3BxHy
	9MQFvg/9On3ZmDfuOEL2izxdyIZoOKPaxkzG0prnjCQscCX93IwVXw8OQ7E/qZtczlXXwFCK7G1
	7kC76XgV1wMJnew65/pT1PKrkN63W2WGfdLg7jHtc
X-Received: by 2002:a05:600c:cc7:b0:439:9737:675b with SMTP id 5b1f17b1804b1-43f1ef4ed59mr687705e9.7.1744136317496;
        Tue, 08 Apr 2025 11:18:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHt6LtzhtOCodKlEDsv24JUxo5GCvyjuPDd1u+OK+hcqeg+gGGG7/Q1UKS8qILxl7CGg59mw==
X-Received: by 2002:a05:600c:cc7:b0:439:9737:675b with SMTP id 5b1f17b1804b1-43f1ef4ed59mr687595e9.7.1744136317185;
        Tue, 08 Apr 2025 11:18:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:4f00:a44a:5ad6:765a:635? (p200300cbc7074f00a44a5ad6765a0635.dip0.t-ipconnect.de. [2003:cb:c707:4f00:a44a:5ad6:765a:635])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1630ddesm172061645e9.5.2025.04.08.11.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 11:18:33 -0700 (PDT)
Message-ID: <60ae4d6b-3ace-482b-9945-1261003f3785@redhat.com>
Date: Tue, 8 Apr 2025 20:18:32 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mm,slub: Do not special case N_NORMAL nodes for
 slab_nodes
To: Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>
Cc: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-cxl@vger.kernel.org
References: <20250408084153.255762-1-osalvador@suse.de>
 <20250408084153.255762-2-osalvador@suse.de>
 <92ff4f7f-90d2-48ab-8f7d-7fc3485276b5@redhat.com> <Z_UwPmyxyu8YNLG_@harry>
 <b26b32c9-6b3a-4ab4-9ef4-c20b415d5483@redhat.com>
 <d581417f-7756-4ce7-8a5a-49149db33b8c@suse.cz>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d581417f-7756-4ce7-8a5a-49149db33b8c@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6CZ00s6Ja7ua1UstJTDWFDie4ZcpsRh_uFYLcPoKBEU_1744136317
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.04.25 19:55, Vlastimil Babka wrote:
> On 4/8/25 16:25, David Hildenbrand wrote:
>> On 08.04.25 16:18, Harry Yoo wrote:
>>> On Tue, Apr 08, 2025 at 12:17:52PM +0200, David Hildenbrand wrote:
>>>> On 08.04.25 10:41, Oscar Salvador wrote:
>>>>> Currently, slab_mem_going_going_callback() checks whether the node has
>>>>> N_NORMAL memory in order to be set in slab_nodes.
>>>>> While it is true that gettind rid of that enforcing would mean
>>>>> ending up with movables nodes in slab_nodes, the memory waste that comes
>>>>> with that is negligible.
>>>>>
>>>>> So stop checking for status_change_nid_normal and just use status_change_nid
>>>>> instead which works for both types of memory.
>>>>>
>>>>> Also, once we allocate the kmem_cache_node cache  for the node in
>>>>> slab_mem_online_callback(), we never deallocate it in
>>>>> slab_mem_off_callback() when the node goes memoryless, so we can just
>>>>> get rid of it.
>>>>>
>>>>> The only side effect is that we will stop clearing the node from slab_nodes.
>>>>>
>>>>
>>>> Feel free to add a Suggested-by: if you think it applies.
>>>>
>>>>
>>>> Do we have to take care of the N_NORMAL_MEMORY check in kmem_cache_init() ? Likely it
>>>> would have to be a N_MEMORY check.
>>>>
>>>>
>>>> But, I was wondering if we could get rid of the "slab_nodes" thingy as a first step?
>>>
>>> The following commit says that SLUB has slab_nodes thingy for a reason...
>>> kmem_cache_node might not be ready yet even when N_NORMAL_MEMORY check
>>> says it now has normal memory.
>>
>> node_states_set_node() is called from memory hotplug code after
>> MEM_GOING_ONLINE and after online_pages_range().
>>
>> Pages might be isolated at that point, but node_states_set_node() is set
>> only after the memory notifier (MEM_GOING_ONLINE) was triggered.
>>
>> So I don't immediately see the problem assuming that we never free the
>> structures.
> 
> Hm, I think it still exists. So consider:

Ah, now I understand the problem, thanks for pointing that out.

> 
> - slab_mem_going_online_callback() creates kmem_cache_node for the new node
> for existing caches under the mutex
> 
> Then a cache creation races with "node_states_set_node() is set only after
> the memory notifier (MEM_GOING_ONLINE) was triggered" in a way that it
> doesn't see the node set yet - kmem_cache_node for the new node on the new
> cache will be missing.
> 
> The root issue is node_states_set_node() doesn't happen under slab_mutex.
> slab_nodes update happens under the slab_mutex to avoid this race.

We could by grabbing the mutex in MEM_GOING_ONLINE and putting it in 
MEM_CANCEL_ONLINE / MEM_ONLINE when a node is going online.

We use something similar in virtio-mem code to sync over the whole 
onlining period.

Of course, if someone would try creating a cache from inside a notifier, 
it would be problematic. (unlikely, but pointing it out)

Onlining a node is not a particularly common operation, so maybe ... 
good enough.

Let me think about other alternatives that require minimal adjustments.

-- 
Cheers,

David / dhildenb

