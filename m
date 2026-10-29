Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793238537;
	b=KzBJG9Te5wprojwgrxJlUDvC68yJHN1uxdgyseAtVKYvg4l8GR3qtnI9m+tTX0jtSQgz
	 mkzzFBNdKsabbGJR70J6CC+wCOiRZGohS9JitEoZvD8pDVFspO91ruhUC1Eh6Hd2AJQbM
	 GEsG/Cm1AX2yn7L/aUa57YpdzTlEuAkNHpMNF2BAnepuqzZu3ulAJ3D7S48iP5ayfXYKC
	 KBjX8y3FgsQ8lE65+yrmlmt+DGrralVCsYlGNQ4XRGifi0Hn6u0o2uP7qvCIAgUN1TV3x
	 JCVEqxiULncKZGY6mDHjB3NP7nbjk21sJTDAsISOE3wHV6HB/VBpTN/hrGRzr2/gmyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793238537;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=WpPpjm9qqTzsBHBWliVMSUioS6+fsJ4niawtYuOMrWQ=;
	b=OGHA9K0lEnBw5C19LPpNt81VdBIruwu2J5JF/Q1EjMRTf85ixZa6sU823Lx+isrD9Gf7
	 fL9KlhkSNjZkya0Ngry439zgJHn3Nbs6n4JscAmB/nbqxkrXUep18Yde2IxSwahMZmSkq
	 64/2trZV40U00o+rHuFuywCFwSc0IJBnvLJjSCtYXfFJQW51UnKQTi5zig/hn1hI12pvC
	 sXZZVaeKRZl3WP/CmCJ2Ex8qUdZuPWJuFLVuEjI/g+lBUSroQOvjRmhho8UtQ81m/4h93
	 y0JYPwtjSeHhzFh94HYHkbsmvDdmqErmMgDupxPMWyTKblzLLrvXiNGhoEHxOy7lAIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=BoVyrxHL;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E3D606A31F
	for <linux-cxl@vger.kernel.org>; Thu, 29 Oct 2026 01:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3E3D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=BoVyrxHL
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c315869241fso251248666b.0
        for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 18:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793238535; x=1793843335; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WpPpjm9qqTzsBHBWliVMSUioS6+fsJ4niawtYuOMrWQ=;
        b=BoVyrxHL0J/es+BtxA3ZGTbS/DVq4pf4tZK3IXlwuavJCQp9ZgDbhOmfgzjP0Vgo4Q
         O7nsgVSMAufKHiGA2urFI/8Cpcsz+94tTIkehaDZ0FnZdrXDfElhPbySA2FacNShYf8v
         e1HeuTTKH3pcl6hHWbzMUReNQps3W7G601tERrUbV5tTsUaWEKIOI2xlTt3+ty752RZq
         j7YiHOk/V+B+oR38IBlKlNrooIh39EeynSMsGDHUNZcxT8iRUpcuczBRO6GMb2GXwsBW
         no8UR7YRtSjq6TeU5v3IJW5HkcDJGMQu+1uzT2kCKHIh33Q8oUKAqS9tRbC7LrYfjA9c
         vC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793238535; x=1793843335;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WpPpjm9qqTzsBHBWliVMSUioS6+fsJ4niawtYuOMrWQ=;
        b=ZQ+vA4Y81k8gnrYUP6atRsAeK1MDmh2Y/WwezeiU0bKUFG3SIhLTCngZSOgsoNjuXS
         Tm86yIlE3I9QKmqnc7Sr4E/kZEhwe+/IjB0fCcaTZWKhqKDDRjyJtsiOlpY8wM/X50bB
         gKoOAvD8unugLU+64eX9W0f51xaAikzM/9jhC7s5GAUayDRuPWMG3x6mhxoPOs/m7zzq
         rngf9rLy2DmH42sGbtC+x/aQWpOqPPkr6yJ5+GgozhnZeWUR43xcEGsOs7inxnHfIV6g
         bQJs8122EAeGjC8G1tTUFxYDK6Jfs3oJayygxW4+gVuj5r+bVWhRxXj7GSOkWTsrg7xC
         zZwA==
X-Forwarded-Encrypted: i=1; AKwUvByoF5TphO7y5VtCpFbTxRO56dbwoDF8bWHjaRaSp/DfWdhpXdPUwduD3QtwsQW+QV5dGh7xHgGcp+A=@vger.kernel.org
X-Gm-Message-State: AFq9FYLw08d3MZxtvyl3PuQG4pt5SbgUNwlIVvBk+1Eaq3ZMl8W53xf+
	67/neToBmwUTWvw31i4VkYq30elBspkkBO87+hMrbIZHcd+FPq58xoYMgc2HgQY6rUI=
X-Gm-Gg: AYBFou2MYQIxPb2hMABn6AVEHbufarGtSKtAhu7Hk72m94Rlx1Nrwmzs4WymV9wSRmG
	6lvVf9TlEiBHZWLqeeqYBd9ZulFlNGK0KnRNb4rTIfo+6rqd/iJi1VQNJ0Ye+hyH1ylPWCs9tEr
	b2uKKVeEKIPfC6lvEjrVRh1S33YJ5/QyWVp7CkCBwbAFvASkqxA1cTFD5ukR4SeQJRSl8G57GmE
	79M4kWInOyRuORJSfXX3YDcxlrfX4mb05ikEnCVqYNnKRR3r3mqOfpN6CpPagcNSUFvfTw77vVZ
	L5ToaBl1bP4GviM3a3SxizRKKjPJdO1Bl5r6i0MsJZ58Lz+7JUbhUI7PynfGQ6x0bX81AY/Um7I
	4rjuDyImPI1suWHVK9K9dCOBqSZteyFnp+Dt/y0aeV3IYWFKvMJDwb6pFgc10MQcieIrv48qwLQ
	JgqpPPpt4PFq+jlkvkx+lqonma2o17rYfMAMH3NBu6GVItqiTXWkR/f/58FKfWow8I4g3XL+OfD
	/P2afnvBjLiwieEQOSh2anhwrraepEHGVz1f/4nDmudAFoMWEhkZsDTAlZZt5TUnl09VmYp1wpV
	rnK41cGSJLJOTypRWP+A
X-Received: by 2002:a17:906:ef0b:b0:c41:b94c:4539 with SMTP id a640c23a62f3a-c49bddac7b0mr353178966b.6.1793238535200;
        Wed, 28 Oct 2026 18:48:55 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:4e::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b495ac454fsm2147232a12.1.2026.10.28.18.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:48:53 -0700 (PDT)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 18/46] mm/khugepaged: check if PTE table is empty in
 try_collapse_pte_mapped_thp()
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-cxl@vger.kernel.org
In-Reply-To: <20261027-fixes_core-v1-18-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-18-6f74bec9a5bb@kernel.org>
Date: Wed, 28 Oct 2026 18:48:51 -0700
Message-Id: <179323853182.453251.8510731747954180380.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> The existing code is rather horrible and already resulted in bugs in the
> past: we special-case UFFD inserting anonymous folios by grabbing the PMD
> lock early, but ignore any other markers (guard, poison through uffd) that
> could have been inserted into the page table in the meantime, effectively
> dropping them.
> 
> Let's just unify and simplify the locking: try to grab the PMD table
> lock and if that fails, flush the TLB, drop the PTE lock, take PT locks in
> the right order and check if the page table is still empty.
> 
> We still perform the heavy lifting (zapping the folio ptes) under PTE table
> lock only.
> 
> Include <linux/hugetlb.h> for now, as x86's flush_tlb_range() macro
> depends on hugetlb helpers. This dependency needs a separate cleanup.
> 
> Both issues this fixes are rather corner cases. Let's not CC stable for
> now.
> 
> Fixes: f807123d578d ("mm: allow guard regions in file-backed and read-only mappings")
> Fixes: 1043173eb5eb ("mm/khugepaged: collapse_pte_mapped_thp() with mmap_read_lock()")
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

This patch is painful. It's taking me a bit to wrap my head around.

I get that you want to avoid taking both locks while zapping, but
wouldn't it be simpler?  I suppose we don't know what kind of
regressions might pop up with that though, bah.

I can say that I've reproduced and tested the before/after state,
and it looks stable.

Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>
