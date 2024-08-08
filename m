Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2DE190041;
	Thu,  8 Aug 2024 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137548; cv=none; b=sGgv6zDLME0jDPPzlr1jhUbKaH/G9qmnFyPicX5I2gdj5BWMlnkBVybyaYlflg1jpmgBT4MTON0O7m1Ox8MP3M7y7ugKDst1JjR10fXkxVoh7fYvVFAh4gCHbGvCcjRja9E00aKQHZCz7odpb0PV2ev5ozR3idClh14vl8XKtr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137548; c=relaxed/simple;
	bh=Oa8mPJw+yGRM94BljBAmKCUy8rNKYdvodJfbQUwAoK4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7tyo5Yq1CZ0c1Dsqqe5BvlhX4PHfjjPpeOwy6p0+95nHIBLKYIvWkkGeFc8RoOyHtWbnRnCxOFRXhKdg1f34q+6DjPA6yUZTyRc9GPQmRhNhQph1+tTK/tKg7IaB0MHeF7GWew1Xle1aNr/ZKMILRBVpfaKPYZG+AqcWQ7u+Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=US2ReH1s; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="US2ReH1s"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5d5aecbe0a9so698788eaf.1;
        Thu, 08 Aug 2024 10:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723137546; x=1723742346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VZz7vSeeoaz6dXkhrDR8IE/3/HpRTkZcMQ2gtBBIQIM=;
        b=US2ReH1sqPtBCmOkp7/rNzn40tkIiNncpxfDk8duVXHXRak1dPrGy/ZcgeR3AqeM1P
         RnP6X9NpHI1oGLcWK4/5sU6J43Ryv/AzV4UI0G82S0mH0gxnbzAK/0iGKOkL8abSMc7g
         wmHDgUQyBmboJLxj4zOzeGx4yxJpsS/21n4iXF3IKM24TBel6J5z+wFSSZFM2yxV8tTQ
         B016CCk1z89CmCGs+bXq/gBLkQnVFZe8BgQEdcfOpPOZX/04bwTSIKlhnHeAy9+BoFAq
         jGgq2Rakj2x0G30Nv+A4MO+3YcqvYKAURvngXSrli+6MIjUAiY07Nj5Ap5sIjRMBZT0n
         x7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723137546; x=1723742346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZz7vSeeoaz6dXkhrDR8IE/3/HpRTkZcMQ2gtBBIQIM=;
        b=bwVLI9qYU/chASTQ3bC3ndhSY13h5Kp44mxOlHsfsQM+UoDV0mJNZVbXKKGmLnpKZt
         RpCrK3JlZW3Dd3FY3a8zQEZwzqVuBX6gX7xLKiKAgFG6SzMIzyGo22ji5dQJS6L8Rv1W
         wDn5cnztrujjbF14hIAxz7oJHq+WKEmTVch0KMPH6otsxfhaYfop2Aua9tt3PNfdSFny
         ZdviNz5UFAcwspJHd6rndHBGb6gfy9T+azuK6+vtIXJFMI9NkRg91WiUXETSvCe1vt6I
         7APme8lnZYqtVWy84bbaMr22nATnBBU/NiXwq85+1Bmbs84qw8pAY0qJGhGsSlWDlSz7
         5MHw==
X-Forwarded-Encrypted: i=1; AJvYcCX0dnW5pawKXjhe8SR8nsesuwml1pPUqlhA1gDziPBVuFS2txmIFraRbSolH+cat5WgbfxIlTTRkrik7iRBdByLSXJ0SR0Hb7BU75qMYA4DIf+d7RqL6jEXHTi56mXpk+ywpZZEFkjK
X-Gm-Message-State: AOJu0Yz554EpqaAEAMVZweYnD2GqQMuaQdg1e1XYm8uWifbEb8OssXOZ
	RXGMttYNVQV8cwHORWvBeI5Xm/CxRpI890tw3t25t+RdZRZ3pcooK5q4RQ==
X-Google-Smtp-Source: AGHT+IGpkO6uGbdUBwRJw5OQikqUXqUieR2xBW7JDvXvfmFNF5jiwvkNbNawxiiuo57CSI6LWluFFg==
X-Received: by 2002:a05:6358:5907:b0:1ac:f08a:c701 with SMTP id e5c5f4694b2df-1b15ce81232mr337774855d.0.1723137545971;
        Thu, 08 Aug 2024 10:19:05 -0700 (PDT)
Received: from fan ([2601:646:8f03:9fee:1fa7:f643:a5d2:2c9c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b7654bf910sm9983747a12.79.2024.08.08.10.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 10:19:05 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 8 Aug 2024 10:19:02 -0700
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	cerasuolodomenico@gmail.com, hannes@cmpxchg.org,
	j.granados@samsung.com, lizhijian@fujitsu.com,
	muchun.song@linux.dev, nphamcs@gmail.com, rientjes@google.com,
	rppt@kernel.org, souravpanda@google.com, vbabka@suse.cz,
	willy@infradead.org, dan.j.williams@intel.com, yi.zhang@redhat.com,
	alison.schofield@intel.com, david@redhat.com, yosryahmed@google.com
Subject: Re: [PATCH v3 2/4] mm: don't account memmap on failure
Message-ID: <ZrT-BoxDb4DTQz9X@fan>
References: <20240808154237.220029-1-pasha.tatashin@soleen.com>
 <20240808154237.220029-3-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808154237.220029-3-pasha.tatashin@soleen.com>

On Thu, Aug 08, 2024 at 03:42:35PM +0000, Pasha Tatashin wrote:
> When in alloc_vmemmap_page_list() memmap is failed to allocate, do
> not account, the memory is going to be release at the function exit.
> 
> Fixes: 15995a352474 ("mm: report per-page metadata information")
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  mm/hugetlb_vmemmap.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index fa83a7b38199..70027869d844 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -392,13 +392,10 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
>  
>  	for (i = 0; i < nr_pages; i++) {
>  		page = alloc_pages_node(nid, gfp_mask, 0);
> -		if (!page) {
> -			mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, i);
> +		if (!page)
>  			goto out;
> -		}
>  		list_add(&page->lru, list);
>  	}
> -
>  	mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, nr_pages);
>  
>  	return 0;
> -- 
> 2.46.0.76.ge559c4bf1a-goog
> 
