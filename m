Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B958B8003D
	for <linux-cxl@vger.kernel.org>; Sun, 12 Apr 2026 04:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775968792; cv=none; b=GCka0wkwVTpbh3/ePhGyWyCwbKJATucaxLqWhb1L2Myg+lr2P2TwmAy9L2WLnvagDhh/5sxnzO1uOxkSEY9ShOaGOvVJxv2NHixkcgtF0Sy43C7D3R8pAtVOT6Txv+bLJt8rC8/6Fe/YXUG71G/tbup+VTOpOmMS0SpqZOGrb4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775968792; c=relaxed/simple;
	bh=tf8rVA79elsb4kMbPWz6K+OTBy98jjmAhbv3JNIeBN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5kqC8JSQ0vxRTjKgBDhiopI8VOnFGG6P+MAS4M1fHclJjb7DhA1gDHw2a3UM8aLAtiL5G374a1TOhzIforoybw6uNXO6VR59oaLC+Lsl1CDKKg/v3slC2ql1e1j/tfnY0IZTVOfUGEdlmrsLGVHo1xJk1KIY4rFS9vRg3JQZeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCEBmhNR; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCEBmhNR"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c1a170a50so2998693c88.0
        for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 21:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775968789; x=1776573589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kRdR1dc5/UfNuJsTk7iiKeGwmqYxW3GpWumyMvQ9lak=;
        b=nCEBmhNRIlosZ3b2ErYtS/mVXy8dEHNgycQCWqT5RKolt0V45bDTJmTXN1Jp75BllT
         ZBixplEgKZTeSTyxBgVi1+TJRNSfaWtWVKwf0ECTh86tF+khEcZ1zQUiqUQ4cTmHNFl2
         VkLznAUCTIwTEBd9OBfeqm31LFv8GpfTNa4mRdiOlpHqHqoHg7K80j46pA+Hb0te6kRZ
         oEbpkKcc17BdzdRa1wrwzr94XmJ5BvmbSe2nFAjgLwI++LaFNLyLa28wuErIP7VZNfYP
         pxJJ9WK0qExvE4QYN91nydpchTTAinx+EXssN2XwEtsdBu+9L2pFwGQBSEvCeXp05xWE
         rK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775968789; x=1776573589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRdR1dc5/UfNuJsTk7iiKeGwmqYxW3GpWumyMvQ9lak=;
        b=l8Xfu3I4Xi8jIbdjpc5jtbVLGqYR05kYoaHr/qmAjZYp73ekB5CqwF8vWHkHyLFPwC
         gQmN1B5G8kfzoQFKaKqBDQkApr6xs8VXS857+kd/xUENkSDGaFEhw73xlhbtTfL2UN5U
         X47e9g20n+BmW1oC47z23zGHcofTHv/zC5ZSvZdBZHX/PdYFFF6WwZbIXsAGoRkzPrpO
         75bFsBZePTdo34rs5BG+EOmeyRSKJuDq4w97dVBzAdbPc7PDzX8SwOWSZx7cIR2Hyi7+
         8IeyYExKEnxhUFhYFUbU02CRn4lGZVcdSK1DZeOgM64dQxmp7u2rixlhzwerCqYsRBFr
         bT5A==
X-Forwarded-Encrypted: i=1; AJvYcCUo97zGVOhQmdW54x2vVJrhm7388bHQ5/j2U2IwiBTo3cqve1QpcW8D6KHXl8Unbw5VIfftGCLVseQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpr9SqYus+kL3q06DTBAOFPZihv6K5F3W9Hqlo5AE9aDZLkYpq
	ZQQo82HBYThHkIC0lxVobAkc0ha1YnQ6jIgUsF206PypQEqqOGrrUvI6
X-Gm-Gg: AeBDieu0y2JCvkN3lSws5+4DPCvQR8HyzpghyyX8NGzqsLCyLTVx+NX4BZGMjyaajl/
	SH/l9ndaLTGU9KP2x/bW0od4laYqWj9OAti6UP61e7ctAwuD5DWycywdJLkPbuXf0ZjTrG5GhhE
	pJmlYua7RDCr1Zmda0Br4b7Bahn2Sqd6de8NHKJFhSh6Avq6v+wOytgCPe9Zsqmm085f5BHUjw0
	tRe1WBwVTNO994fI73cX0a94yvQECYKce9LyX14aoUgHftHLDD69KS9lcsdrgMKLn+8d+HETzJd
	OtiLsneYI1INviUABdXqiqv0DlNVkbXKEGt1Bts/S2IgwI3oEpOILdTNK152EcZN4Cw/ElUuMQx
	El/eT9f274GivvEOE8fhGS4yO6A0x38IltF6WPBdaiABHeQozCu4ZXLscCDVo4FIG2GLQD5taA0
	BoK/3Gx5lZz6mLigIPPFofG4D8ogBjNMduyKdZ
X-Received: by 2002:a05:7022:517:b0:128:dab3:f528 with SMTP id a92af1059eb24-12c34e892c2mr5118834c88.8.1775968788704;
        Sat, 11 Apr 2026 21:39:48 -0700 (PDT)
Received: from fedora ([2601:644:937c:6c90::f8b0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561bde70csm13449412eec.15.2026.04.11.21.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 21:39:48 -0700 (PDT)
Date: Sat, 11 Apr 2026 21:39:45 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/zone_device: Do not touch device folio after calling
 ->folio_free()
Message-ID: <adsiEY671D8mFZao@fedora>
References: <20260410230346.4009855-1-matthew.brost@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410230346.4009855-1-matthew.brost@intel.com>

On Fri, Apr 10, 2026 at 04:03:46PM -0700, Matthew Brost wrote:
> The contents of a device folio can immediately change after calling
> ->folio_free(), as the folio may be reallocated by a driver with a
> different order. Instead of touching the folio again to extract the
> pgmap, use the local stack variable when calling percpu_ref_put_many().
> 
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Balbir Singh <balbirs@nvidia.com>
> Cc: linux-mm@kvack.org
> Cc: linux-cxl@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Fixes: d245f9b4ab80 ("mm/zone_device: support large zone device private folios")
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>

With the cc-stable:

Reviewed-by: Vishal Moola <vishal.moola@gmail.com>

> ---
> Stack trace:
> 
> [  631.875165] [IGT] xe_exec_system_allocator: starting subtest threads-many-new-prefetch
> [  632.282992] Oops: general protection fault, probably for non-canonical address 0x900000000000000: 0000 [#1] SMP NOPTI
> [  632.293469] CPU: 8 UID: 0 PID: 59267 Comm: xe_exec_system_ Not tainted 7.0.0-rc7-xe+ #281 PREEMPT(full)
> [  632.316023] RIP: 0010:free_zone_device_folio+0x149/0x240
> [  632.339782] RSP: 0000:ffffc90023d1fd00 EFLAGS: 00010206
> [  632.344947] RAX: 0900000000000000 RBX: 0000000000000001 RCX: 0000000094472d4d
> [  632.351991] RDX: ffffffff8155c76f RSI: 000000006f2213bf RDI: 000000008e84943a
> [  632.359042] RBP: ffffea0ff4030001 R08: 0000000000000000 R09: 0000000000000001
> [  632.366094] R10: 0000000000000028 R11: 0000000000000000 R12: ffff88811828e400
> [  632.373145] R13: 0000000000000000 R14: 000fffffc0000000 R15: 0000000000100073
> [  632.380194] FS:  00007f2f0fdfe6c0(0000) GS:ffff88890a7e7000(0000) knlGS:0000000000000000
> [  632.388186] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  632.393870] CR2: 00007f2f002e90f8 CR3: 0000000106708002 CR4: 0000000000f70ef0
> [  632.400919] PKRU: 55555554
> [  632.403605] Call Trace:
> [  632.406039]  <TASK>
> [  632.408131]  do_swap_page+0x146d/0x18c0
> [  632.411938]  ? __pte_offset_map+0x3e/0x190
> [  632.415994]  __handle_mm_fault+0x6e8/0x8d0
> [  632.420053]  handle_mm_fault+0xbf/0x250
> [  632.423855]  ? lock_mm_and_find_vma+0x41/0x6f0
> [  632.428256]  do_user_addr_fault+0x168/0x690
> [  632.432399]  exc_page_fault+0x74/0x200
> [  632.436117]  asm_exc_page_fault+0x26/0x30
> [  632.440092] RIP: 0033:0x5587554ff70d
> [  632.462142] RSP: 002b:00007f2f0fdfc970 EFLAGS: 00010246
> [  632.467308] RAX: 0000000000003fc0 RBX: 00007f2f082e1fc0 RCX: 00007f2f12b3287d
> [  632.474355] RDX: 0000000000000000 RSI: 00000000c048644a RDI: 0000000000000003
> [  632.481404] RBP: 00007f2f082e1fc0 R08: 00007f2f0fdfc958 R09: 0000000000000066
> [  632.488450] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> [  632.495495] R13: 00007f2f082de000 R14: 0000000000c00002 R15: 00007f2f1319e000
> [  632.502547]  </TASK>
> ---
>  mm/memremap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memremap.c b/mm/memremap.c
> index ac7be07e3361..053842d45cb1 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -454,7 +454,7 @@ void free_zone_device_folio(struct folio *folio)
>  		if (WARN_ON_ONCE(!pgmap->ops || !pgmap->ops->folio_free))
>  			break;
>  		pgmap->ops->folio_free(folio);
> -		percpu_ref_put_many(&folio->pgmap->ref, nr);
> +		percpu_ref_put_many(&pgmap->ref, nr);
>  		break;
>  
>  	case MEMORY_DEVICE_GENERIC:
> -- 
> 2.34.1
> 
