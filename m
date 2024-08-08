Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF9B14659D
	for <linux-cxl@vger.kernel.org>; Thu,  8 Aug 2024 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723140780; cv=none; b=U911mOuocINvKKsqra/J4LKYd07ZYUDC6BQcdCBevVSaE+N7L+9QG2niqiJYh+7JNHh/b8Ay2rGgolT1cZTHugceRuDVAQmvzBNenfU4MvsLKsoiLXiywOacumho2Olr6yzfXxZTeGmdl8OIi2oZxu2HiTBhbAJ7ksPyANsRQZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723140780; c=relaxed/simple;
	bh=VrjY+3ZdCYNijwzf5GMnqknTkVXUne9BO+PHggg/zWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z8WXS8jl+DiSj+S11GIMYt0CxVxQfqj1KwEPd/hLMLWBwCM6vMuWf/1FQ18oJzLkI3emCz+qI5wx9OmmUClFJT9IKywcNi/CzfYrHEGP+q5bHHCCJxFPylm0LoIGZEz3IkZyDNAfo1MfcjJZHNjRp3VJjKVTo5T8JAOsODAsof0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CEbwGqZ6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CEbwGqZ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723140777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Sby/LX1Z7JxkNjpyIbfQ0FNVYX/5ZiYS7SaHjE6I1kI=;
	b=CEbwGqZ6v27JjgsHdbTe3pBn2qpN9rmJWQGs/6NXgrGqqPOsNQ2YI0Lq/RfTd4SMrzcJiw
	6vcXpIOhJN6CfKw8VeR2AmtRVAS5znZNT+NF3BghJuLHEuuN08jMN2/B+m27z5cijMwHsf
	UNpJOiTEI0RB6bRuCkjMSvU9zi7aosE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-Zqgb3QGGPhORpt_G81d9SA-1; Thu, 08 Aug 2024 14:12:55 -0400
X-MC-Unique: Zqgb3QGGPhORpt_G81d9SA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3683f34d8d9so552548f8f.3
        for <linux-cxl@vger.kernel.org>; Thu, 08 Aug 2024 11:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723140774; x=1723745574;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sby/LX1Z7JxkNjpyIbfQ0FNVYX/5ZiYS7SaHjE6I1kI=;
        b=SLdvfhbx8UG0gh3Q+qhwXNv1a7G6DqhPvVCIRVH4puCRszbjNjC1EH01xvn084lxlo
         v6InYjm7f7ethPiQLAm46t8FSyYaeqThC607aL4TrEYeboYb6Nx8tn/pXcaTXq1rGSKQ
         eGfKum5tU9qyT9k59x4N8Cf+CoesD+cJcLqgPoYVIi29WRnV69L0APQ7pLSQ38h2m7fL
         E2xTtfZ31WDPbbd128/yLdlgfHunI7lb5/miTSqrCjSVb3GkPRTEu6EoGj2AgOTIMBJc
         QZqTBMh8ov/I8IVr3hgL+cp/D9lzYuULLBgVXIniqJGXf7EtEWZRLFlj6Er7lf2fW/wM
         6QJA==
X-Forwarded-Encrypted: i=1; AJvYcCU8b3MJs/QVny5glIKQICGNLp3CDS7sY5ZOqonsjqbWrtiYYtRn3kkx2kKmm7twySoMmAwtNy0xr+i6xoul7nuhiDYuz0bbCtza
X-Gm-Message-State: AOJu0YxzrdCImMyXGXy/0XX/W0EJcCqW5uXyvVjzZsSSRMMFh1ibfoob
	WuxgkNUhqhUEnVfxMd6SfybabglOImGap/kYw811S5BcwssJgx8wPlCd7rFqsUrnEZEKHW4vAyp
	9VUaODndhCcf1y0gh/GAtpFdmIqA5whvRUcemXz+NXJNFmB4ImtqmOj8zwEsPC7RPGu8H
X-Received: by 2002:adf:fa4f:0:b0:368:3ee5:e3e1 with SMTP id ffacd0b85a97d-36d273cde58mr1692239f8f.7.1723140774259;
        Thu, 08 Aug 2024 11:12:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYjRZzGeEoOB+7CuuXgLrCB1uYf8qQUNYyEmlp1E1bTlB1Ve2QnSpVqkr+g30YSrqwVM9+EA==
X-Received: by 2002:adf:fa4f:0:b0:368:3ee5:e3e1 with SMTP id ffacd0b85a97d-36d273cde58mr1692213f8f.7.1723140773726;
        Thu, 08 Aug 2024 11:12:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:2a00:f151:50f1:7164:32e6? (p200300cbc7132a00f15150f1716432e6.dip0.t-ipconnect.de. [2003:cb:c713:2a00:f151:50f1:7164:32e6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27229689sm2693875f8f.95.2024.08.08.11.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 11:12:53 -0700 (PDT)
Message-ID: <24003526-ba18-42fb-b5c0-7b89872eb61e@redhat.com>
Date: Thu, 8 Aug 2024 20:12:51 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] mm: don't account memmap on failure
To: Pasha Tatashin <pasha.tatashin@soleen.com>, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-cxl@vger.kernel.org,
 cerasuolodomenico@gmail.com, hannes@cmpxchg.org, j.granados@samsung.com,
 lizhijian@fujitsu.com, muchun.song@linux.dev, nphamcs@gmail.com,
 rientjes@google.com, rppt@kernel.org, souravpanda@google.com,
 vbabka@suse.cz, willy@infradead.org, dan.j.williams@intel.com,
 yi.zhang@redhat.com, alison.schofield@intel.com, yosryahmed@google.com
References: <20240808154237.220029-1-pasha.tatashin@soleen.com>
 <20240808154237.220029-3-pasha.tatashin@soleen.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240808154237.220029-3-pasha.tatashin@soleen.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.08.24 17:42, Pasha Tatashin wrote:
> When in alloc_vmemmap_page_list() memmap is failed to allocate, do
> not account, the memory is going to be release at the function exit.

I would write it as

"When we fail to allocate the mmemmap in alloc_vmemmap_page_list(), do 
not account any already-allocated pages: we're going to free all them 
before we return from the function."

Acked-by: David Hildenbrand <david@redhat.com>

> 
> Fixes: 15995a352474 ("mm: report per-page metadata information")
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>   mm/hugetlb_vmemmap.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index fa83a7b38199..70027869d844 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -392,13 +392,10 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
>   
>   	for (i = 0; i < nr_pages; i++) {
>   		page = alloc_pages_node(nid, gfp_mask, 0);
> -		if (!page) {
> -			mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, i);
> +		if (!page)
>   			goto out;
> -		}
>   		list_add(&page->lru, list);
>   	}
> -
>   	mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, nr_pages);
>   
>   	return 0;

-- 
Cheers,

David / dhildenb

