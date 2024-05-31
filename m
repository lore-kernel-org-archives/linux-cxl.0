Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675EF54673
	for <linux-cxl@vger.kernel.org>; Fri, 31 May 2024 07:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717141784; cv=none; b=H+2kLoJowOAr1jwzDODZXnyPHgjnFXjO0NY15ribt4NV73UbYtl8m6bfV1CSmoS5MJeVGkujwKXovRa4NRqth0XgqvyVB4hbma3UrvqfLMg7PW+OlSPXibIHHvS367Agdkg2j6YGAZ+XWl98x0ltv5P/1lbX8XboMgv4dE4skF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717141784; c=relaxed/simple;
	bh=J8XqW3ukXxW47+D8NWb4HuSXlORbvdWOvk68vyDMp7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZJu1vsifxmGb/D9obuAn2DAKt623bJutwH8Bw+LsQAS4Hvz//RSkK7dQRCAEGS7gwpfCyDdI5ms3n9W1NCRTBT5PwLUmjPDuyGayND2MQhg4VwLOR8Y9jCwlK8Sau+I6YZj0uowB4t4ztCdsNjCB8F+oDw04a/qvuQB8lxuSFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=buMju75B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="buMju75B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717141781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=E5KOtTrSlSwhhS5Nk0jrn7V64PVkm6byBCg4HjlZYvg=;
	b=buMju75Bl06Uxz1cejRBcVow7xfILlBalwrIdb+jGabWQgFsycaFgClUOpxpNslQp1CXp7
	LHYVUfy2TvooMLx27abxBZrUiwajWCd+FMFwBjLJFeAvPyY/4+e6yI7TycT72gdeC3PZBi
	6WcA18OyRVqh7l87vMrNvM9j3PweRqc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-MHuVMCT7PqOaJ-5T7OBVKA-1; Fri, 31 May 2024 03:49:37 -0400
X-MC-Unique: MHuVMCT7PqOaJ-5T7OBVKA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2e95a1eb00eso15267461fa.0
        for <linux-cxl@vger.kernel.org>; Fri, 31 May 2024 00:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717141776; x=1717746576;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E5KOtTrSlSwhhS5Nk0jrn7V64PVkm6byBCg4HjlZYvg=;
        b=r/bA1wPf6TYOycTGmeeCUYCH3PqE1AUiY9RMvT39lK9btqp8/j3fHY9u7kdR5s6/KQ
         dOwn92FwfQ6ok2oTMJf6/pTwqZSHxrwEE64kdZrJJF4ps7xvgDJN1uAPqbKpx0iwE1do
         hLRpxEZwYEc+mbCMeGCtRiTM+SQbPWpql1EKClJno19rUsWxUqJwGIQqUdLxj8fqjNlz
         POVc86sAATGO+FjQ18vhG5KR2siHALCUy4xFB6l2KGsCSP5/NP1jAC1KaosP6qqBEgT9
         alQM3Iv11as4plv1dfVWIZ+EFm9uUa+GHR+QDX0Dot7XGSac+GW96wFgXP5qMnheLOco
         Qnyw==
X-Forwarded-Encrypted: i=1; AJvYcCWg6nfw8PcsfgyXI4sIaa5TIb7jSlY/rAE6r1mYsPrCuORhaz5w5QdgK7MW+qgw4hpvF7vx0QUkRuXNGfmaD1GAtfStj5L8dYjG
X-Gm-Message-State: AOJu0Yz8eq5cTspQYIv0KdqcWv+oIEfQgwWJr1icsRShJw9jaK9vaWLV
	h9qiEGTbKUUv1uprGlQVX57VN3m8QMy7U7lBICA9uvnNCBsQq7y5+Uo6GYKx1vIlCmDTKV1dTdu
	3JQipRvPIyVZqllfheQw1CwjxqjaldgsBlmzE1XkZTlnuJUysWspcdw8tOg==
X-Received: by 2002:a2e:874d:0:b0:2e9:8b00:73f0 with SMTP id 38308e7fff4ca-2ea95167021mr8783381fa.28.1717141776336;
        Fri, 31 May 2024 00:49:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHia723V7h/yOiPB53bvyk5ZO6GR7mJAqyPrMFmdGpYQ5uIoNIonWbpxC8HY0JmyVWMpnKQVA==
X-Received: by 2002:a2e:874d:0:b0:2e9:8b00:73f0 with SMTP id 38308e7fff4ca-2ea95167021mr8782851fa.28.1717141775745;
        Fri, 31 May 2024 00:49:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:a000:d4df:4b8f:37d4:59e4? (p200300cbc717a000d4df4b8f37d459e4.dip0.t-ipconnect.de. [2003:cb:c717:a000:d4df:4b8f:37d4:59e4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b838b55sm16831465e9.5.2024.05.31.00.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 00:49:35 -0700 (PDT)
Message-ID: <b8654dcd-68e1-4823-9588-cfa401104741@redhat.com>
Date: Fri, 31 May 2024 09:49:32 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 8/8] HACK: mm: memory_hotplug: Drop
 memblock_phys_free() call in try_remove_memory()
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Sudeep Holla <sudeep.holla@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>,
 Jia He <justin.he@arm.com>, Mike Rapoport <rppt@linux.ibm.com>,
 linuxarm@huawei.com, catalin.marinas@arm.com, Anshuman.Khandual@arm.com,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 Oscar Salvador <osalvador@suse.de>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, James Morse <james.morse@arm.com>
References: <20240529171236.32002-1-Jonathan.Cameron@huawei.com>
 <20240529171236.32002-9-Jonathan.Cameron@huawei.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240529171236.32002-9-Jonathan.Cameron@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.05.24 19:12, Jonathan Cameron wrote:
> I'm not sure what this is balancing, but it if is necessary then the reserved
> memblock approach can't be used to stash NUMA node assignments as after the
> first add / remove cycle the entry is dropped so not available if memory is
> re-added at the same HPA.
> 
> This patch is here to hopefully spur comments on what this is there for!
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   mm/memory_hotplug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 431b1f6753c0..3d8dd4749dfc 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -2284,7 +2284,7 @@ static int __ref try_remove_memory(u64 start, u64 size)
>   	}
>   
>   	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
> -		memblock_phys_free(start, size);
> +		//		memblock_phys_free(start, size);
>   		memblock_remove(start, size);
>   	}

memblock_phys_free() works on memblock.reserved, memblock_remove() works 
  on memblock.memory.

If you take a look at the doc at the top of memblock.c:

memblock.memory: physical memory available to the system
memblock.reserved: regions that were allocated [during boot]


memblock.memory is supposed to be a superset of memblock.reserved. Your 
"hack" here indicates that you somehow would be relying on the opposite 
being true, which indicates that you are doing the wrong thing.


memblock_remove() indeed balances against memblock_add_node() for 
hotplugged memory [add_memory_resource()]. There seem to a case where we 
would succeed in hotunplugging memory that was part of "memblock.reserved".

But how could that happen? I think the following way:

Once the buddy is up and running, memory allocated during early boot is 
not freed back to memblock, but usually we simply go via something like 
free_reserved_page(), not memblock_free() [because the buddy took over]. 
So one could end up unplugging memory that still resides in 
memblock.reserved set.

So with memblock_phys_free(), we are enforcing the invariant that 
memblock.memory is a superset of memblock.reserved.

Likely, arm64 should store that node assignment elsewhere from where it 
can be queried. Or it should be using something like 
CONFIG_HAVE_MEMBLOCK_PHYS_MAP for these static windows.

-- 
Cheers,

David / dhildenb

