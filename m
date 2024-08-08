Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9DF191494;
	Thu,  8 Aug 2024 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137499; cv=none; b=EH7+Vh4dOKBaJdGJbskyRhwX0GpxZZqafX8pW1hhR0Ac8g4FIAh6IO6wvCgzbCDV9xNHOw3tbuvLp/PyorRNFL8nsxVScRa93eJZ/gEapJnQFCklGdjboBEDgk7BnPTobIxil1+IiuugmwhdEWOgiPB0QXO4kzObtfICmNG22WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137499; c=relaxed/simple;
	bh=Z0ccfJZRBZliCqfEpSf7bah5rnJrr5sOEWXmQMc+X20=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQZKrImRWCopkZXZpRgfad/W0zx6MfmgfvUvr9JB52bxXfAYK7yLgnxhPlV19Na2T4MYi/N9ACQYe8jI5Z/IYCq/7fiYvWHFZ7V//ZWL4hdNDooShfG95lzSC27V9vxvXXS1d9Pllz5LZc+HsZ646XFYvPBjKfN0XHu4dJQNWG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljqB/BZC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljqB/BZC"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ff3d5c6e9eso10744175ad.1;
        Thu, 08 Aug 2024 10:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723137498; x=1723742298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qtdCTxJ+gV/pWRIhjPS2ySd52aYjDMr8mpGfd6xYvDw=;
        b=ljqB/BZCA3JxH+uDKwj70ZEA9SpFeufjcBvkRycotjXTXE0zlwwTXHDi9SpPdn1QAD
         6JsiLrVwY+L9dQl2LvaFDEORAPUX3MhQ/moGvvppbAErWErRUp9+3zjBeIS1ojznCGd9
         9RBPaO4ZJzYlhkPlxg0N7ynDJpy2XgZmGKu4wTjhkAt/88h0yROWiUx7uHz0zyhLR1B9
         FnLjlmmB2v+/RVjC/pdRFL7oSiffO2diPTHP5ru9ILT16/9vuN4QoKFdLY0k1cZlb+83
         9HKP+Lw0WmWSsVO84wKYhHDcMffyCZOsTJ9kWGo3h2WLrKayEC3xDzdHtZ9KMBG3FwFx
         TgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723137498; x=1723742298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtdCTxJ+gV/pWRIhjPS2ySd52aYjDMr8mpGfd6xYvDw=;
        b=nGrq3R/WIHjSyR/+dhzB9WUyhkEd8oF9fEVVL0a9G1z9Pqk0rVYcLEiPju2r9p0xKD
         oG+BhQu5n78hWDiEyiGkVX/hkSlMbntug/d7lF45P4NjN9PDnFETa+YdqlizlZl8Mkza
         ZmF6GvrNdUc5IQ7PhSQ07E6UeJW3FsVjk3WTskDPxnL0RdUsWJagiRAVVcFMa9mj8PkG
         N0636fA7y8xzuEHACx98Yjuhs4fCGt2KELjQl5BKNeKh9zckePIs6IqNcfoF4Cy8SueY
         amBcxfHaFuxX9lgQP4tKQ4AH7Ivh3TUVVdOJb0+6LdYpcHE2JAK0AFS7KdfsGaCufMZS
         N89Q==
X-Forwarded-Encrypted: i=1; AJvYcCUiOBuxtNkTxupzQf/v2bRcyUpyJD+K0xE6CY+mZq9Fj0vToygmvVAb8UVQUY61pQIKUX4JWMUPcA7zwyTBr38HIojfrioxOyGxbCN1Hl3BPycX/nDZF+ssqzgGfFrV0prissJrmQuu
X-Gm-Message-State: AOJu0YyIGE++zE4BC7IUBQ9BjsnuA6JMU19TByHUD1l+34AyC/WOtVHa
	DJG+aNgYoVeIYM83qoA+j5bMjBYr8YgfwtiOXlp0fIpPANEoFpOW
X-Google-Smtp-Source: AGHT+IEgKnFfIuChgyyBkSUfxrJRZx4h353kQoDz9j2DscVKuyaaoYkHnrd0cgpIEQoZE6xn7vRV0w==
X-Received: by 2002:a17:903:189:b0:1ff:3b0f:d5e2 with SMTP id d9443c01a7336-2009525fcb4mr33389845ad.32.1723137497583;
        Thu, 08 Aug 2024 10:18:17 -0700 (PDT)
Received: from fan ([2601:646:8f03:9fee:1fa7:f643:a5d2:2c9c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59295294sm127164895ad.253.2024.08.08.10.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 10:18:17 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 8 Aug 2024 10:17:59 -0700
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	cerasuolodomenico@gmail.com, hannes@cmpxchg.org,
	j.granados@samsung.com, lizhijian@fujitsu.com,
	muchun.song@linux.dev, nphamcs@gmail.com, rientjes@google.com,
	rppt@kernel.org, souravpanda@google.com, vbabka@suse.cz,
	willy@infradead.org, dan.j.williams@intel.com, yi.zhang@redhat.com,
	alison.schofield@intel.com, david@redhat.com, yosryahmed@google.com
Subject: Re: [PATCH v3 1/4] mm: update the memmap stat before page is freed
Message-ID: <ZrT9x_LMwdYo5bHJ@fan>
References: <20240808154237.220029-1-pasha.tatashin@soleen.com>
 <20240808154237.220029-2-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808154237.220029-2-pasha.tatashin@soleen.com>

On Thu, Aug 08, 2024 at 03:42:34PM +0000, Pasha Tatashin wrote:
> It is more logical to update the stat before the page is freed, to avoid
> use after free scenarios.
> 
> Fixes: 15995a352474 ("mm: report per-page metadata information")
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  mm/hugetlb_vmemmap.c | 4 ++--
>  mm/page_ext.c        | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 829112b0a914..fa83a7b38199 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -185,11 +185,11 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
>  static inline void free_vmemmap_page(struct page *page)
>  {
>  	if (PageReserved(page)) {
> -		free_bootmem_page(page);
>  		mod_node_page_state(page_pgdat(page), NR_MEMMAP_BOOT, -1);
> +		free_bootmem_page(page);
>  	} else {
> -		__free_page(page);
>  		mod_node_page_state(page_pgdat(page), NR_MEMMAP, -1);
> +		__free_page(page);
>  	}
>  }
>  
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index c191e490c401..962d45eee1f8 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -330,18 +330,18 @@ static void free_page_ext(void *addr)
>  	if (is_vmalloc_addr(addr)) {
>  		page = vmalloc_to_page(addr);
>  		pgdat = page_pgdat(page);
> +		mod_node_page_state(pgdat, NR_MEMMAP,
> +				    -1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
>  		vfree(addr);
>  	} else {
>  		page = virt_to_page(addr);
>  		pgdat = page_pgdat(page);
> +		mod_node_page_state(pgdat, NR_MEMMAP,
> +				    -1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
>  		BUG_ON(PageReserved(page));
>  		kmemleak_free(addr);
>  		free_pages_exact(addr, table_size);
>  	}
> -
> -	mod_node_page_state(pgdat, NR_MEMMAP,
> -			    -1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
> -
>  }
>  
>  static void __free_page_ext(unsigned long pfn)
> -- 
> 2.46.0.76.ge559c4bf1a-goog
> 
