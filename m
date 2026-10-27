Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793096590;
	b=y953zBVkD0bz21ULwTDjxOkVYvIV2+PapnBe2mATIpp0CbEQsKPyyGrTfi6Xkm0ZZ+P5
	 BwBsghjSD6kJD2SkTRIXXypRw2Kja0AUZWKptuca3D589YhBibhOGhsKalC101UFsRiih
	 1CtQJl9v1qXOjYWdmNeQF0C2QWz2PLdxoKEkw4ufpbap1b3BVBfs+EpG+I8OQlQndVp7m
	 h49YOAaQ+WJL6vipRJq9upwSGaBK8Ne4JJoAjTFO0WhUMdeLkD0waZhFl+zlWW1+Ae7mh
	 pKQbuiXb+/gWe/wuAZvXllnQoC/lStn3MeZ+t+18Z0MrW0gVSei7fdh0aVqOj3/BT8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793096590;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HuWBfUhRw2eXbrJVRrdIsgOVF/qwEOWqwz0sZ/JDeUA=;
	b=BjMENTuU9zWYBun0nudqDLRv/HvRfeGRo67LBjYMa9oQfsxK0msCbji6/Ua0rzi7gH2M
	 mQKl8tqZKBQSGv7wX+QCr89UZ3fPpohaqKQR1T1yF1VZGwQcveMH0t44bxuBxSPLriArP
	 tdOWYI/kLiFkGlE7JgRcKqvmGSCMXP1gnRgW5entZ9PfDTo9iOw2u/RvndYkySNZpBYtt
	 WEa6qKR6R69hx1ytQXJhETkotWWoUZWuEQXGP/8m8awYEmkX4SIEb3/2c5sgGRh836Lf0
	 mCj99rNJ2wSaKbCCXFWVSH4SNuVRk/NgAlsGwJAhJhJOx0Q+T3xq5FFwlDNP3uJYhJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rlxPCoS9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBBA606A31D
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 10:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDBBA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rlxPCoS9
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c3fd91337baso565928066b.3
        for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 03:23:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793096588; cv=none;
        d=google.com; s=arc-20260327;
        b=ItKQcTacjG5NvUKZ3lbBwltpZhABvZtjZtcU2xY6kC/FnLmxUy7MHhBxqEjWpuprDr
         UUvwJ9vBoJNG8AbyllpPfv+dhOPl/w7lfuIog3qU/OV4fZ0+vsseJlXwvw7nggcB7ssV
         pda/z52nY8TyIoMWZpNB+dTvbbN+NXSu7HxaBgZ+ZAXcr3Z9xbMfvEwIgTpc5BIxFpDS
         06fvyyrQYiPbxPPTnQyNKTC4qk3FJAwhT2uzD8EtUWoGbzy0AE5AfPh1gQH9Mz2ZI6ka
         13vkodTRQ64pK9W8owwJgsR8t8kPWUGzq2hoeLvtXDTAhnFBYrMrWS4ZoxIvTWfX5Bk+
         IHxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HuWBfUhRw2eXbrJVRrdIsgOVF/qwEOWqwz0sZ/JDeUA=;
        fh=qEVlIc20U3w5q6hAY3gaCOWiZNjl0ujc9Xyc9qx4sRg=;
        b=oGWo13NYNagKEMZzJDhhy6zUZfWlQDF/PyCD6relWasZBlDFHICYOYNXmS/lhKZZfM
         /sM3DbakGrnCph+MX8rf4aTRRu41lnv8i9z3BqYWk6eiHvUvoBZ3tR3GFcV7p13TgL3E
         0ad9O0SoA34w+Yjj4cudR1WWradhHIKBi7g3HsB8mdl5hTyAYuGy/6G3lldJSJiFlVHw
         zqqF78mA0X2uMA6SYdQP3D5lr7rAo/x8V7WKVT3LHd+EHqNqm7gaQfVomX0SeCDCxE9l
         8VVcraYDVmWT3q2ZpnCRdBaRgIdzOhDFQQGHDoLF/n45yFpw8QdTOKpJ3RZAxLzQpsHI
         7aiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793096588; x=1793701388; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HuWBfUhRw2eXbrJVRrdIsgOVF/qwEOWqwz0sZ/JDeUA=;
        b=rlxPCoS9TacJB5sbR4/DuCvg1gHofa48v4RHRIbBlyZQUhw6r7bL6zg7MUtgoZBxKQ
         lt+YYPbrvQtc79S9rfvuPcGOb7C0BZY3qgF3U0I/tVnJgBGJx6xt/DMQpY30uai4QsoX
         P5Z/pcj6R7IGmpyEZjIkQ8RE3etZC17RDFgvcM6Y+9bhDyYYZoMMp/cQ3dx0FSoFEG3E
         yCnpC60BmhPOCYYuljKb2FIw3gC9JotwIBxNU1pFqurxlv0c49doWeUpfGKBEj/1fv6d
         Iu3zIa2GIe2Vu2FDkwEINlHF1PCgOTqXmfejtN27WWbwQvMYwFzZDiaJKRXsAeQtFbxn
         7XPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793096588; x=1793701388;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HuWBfUhRw2eXbrJVRrdIsgOVF/qwEOWqwz0sZ/JDeUA=;
        b=JuuG80hWba2iSvfTMZ+IzLodJ+nk/LSIP3hsHSp/tJ8HlcNP4RBOSfZ4/+ZlykSbRr
         98ue2ZrPuloqn7g6cT79voEkFvu4T8cWD/4kXmkA37njuWttfYgj+LvljD9NuUYcLWel
         s6Xv6//lmFn8posZNzf83a7VrnQmqZy4LqC/eTvn3J1jFdW+O7CTThaRAUOpd+impGek
         cFwAVzZK1pfTBzMdbk+nIOkpnUs/tyBTlcgfwFK7NWSHOMHnCdrx3oWkAIYFN9Mxvcvd
         54leJooy/NCSh0Qt0Qj4YUxQPPfsVpnERFnYfV59j6dxneLBbhoiSlQ8JDF8D9mJUsQR
         1q7w==
X-Forwarded-Encrypted: i=1; AKwUvBwIMgsOeDlaYHa7aDUgelzOW/dhzfCa00PCkgINDQgD+uwXTZrI1LEjgOz/TfalkGKCtv+fBpJitkk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3PslrdxRDB6Oa8J82Y6u4b9MS7KL48V4elKIQ6dZiXIz5scDu
	Uov2/hLr+wSCZEF8UFG7OyBpowMTJFQMNRFRRqR/SAuV2djPKyFxfAgTyjxYcWMHY7x5PMxqfz1
	s8pgjXaiDZS1gcHyp/BTBWShhAqKw9cM=
X-Gm-Gg: AYBFou1g05aRpTI/1tP/VjX3X4pheqR3tcvm8WBaHyUV/Srn6ietcGxAamboDrmH25U
	9qdbtqSb4vOtRBE9NLiouR1WLnzvD9bnYtr7Mqnf2VnwBwGp8wxKqX0/hr6EfO5fuZc2lt1pe7Y
	KyxSYpd2UYaoKHRwoAWOGpVLUZ3Ndi8MZxa98/rAhuHT9vXzfouazePYWP8lqvM/m+JlA4cqxoQ
	Kz1Qx8rOC83sLf7g8jNag1dXFbeWjPeO3FMAe8reZSy+UxckwjrquD1tj9yxEJ26VFTD34GXh0I
	UWUBPa1TvnOA6MqOmCv6AJgFonelWFr3yWS23WRSYTOcGrefS1xc+WAMRuxGL2eyXRgCdp7aXDu
	hr2kP+HFWHOS+ank02EJHy1n9xLl+HfjNXtCLrR/a1Fw/vwkR9gj3Fj1tw7r70i3iNBb9AQ==
X-Received: by 2002:a17:907:86a3:b0:c31:5bb8:4b3b with SMTP id
 a640c23a62f3a-c46bdaf85e3mr1028439166b.2.1793096587718; Tue, 27 Oct 2026
 03:23:07 -0700 (PDT)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org> <20261027-fixes_core-v1-1-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-1-6f74bec9a5bb@kernel.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 27 Oct 2026 18:22:29 +0800
X-Gm-Features: AclHuK-sc-Sst_xgCP0rWexz2ICrmdMlmxE50eDjh8zWXXtcyxqz8s5Avp5yS-o
Message-ID: <CAMgjq7CgeA5OYUuXAQF-PQ_LkmsLw2V3VzRwPUdMYTcGCmYCbA@mail.gmail.com>
Subject: Re: [PATCH 01/46] mm/mglru: don't use stack pointers when walking PUD
 and PMD tables
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 7:18=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> From: Josef Bacik <josef@toxicpanda.com>
>
> MGLRU passes stack copies of page-table entries in walk_pud_range() and
> walk_pmd_range() when walking to the next level. These copies can become
> stale when khugepaged or MADV_DONTNEED (CONFIG_PT_RECLAIM) removes a PTE
> table concurrently.
>
> This pattern dates back to commit bd74fdaea146 ("mm: multi-gen LRU:
> support page table walks"). Likely, earlier locking masked the latent
> bug. Later changes exposed it: commit 1d65b771bc08 ("mm/khugepaged:
> retract_page_tables() without mmap or vma lock") allowed concurrent
> retraction, and commit cf4a65539c13 ("memcg-v1: no need for memcg locking
> for MGLRU") dropped the walker's outer RCU protection.
>
> The fix is simple, so just fix the original commit so we don't have to
> speculate. To fix it, pass the actual PMD/PUD pointers. This restores the
> RCU-protected lookup and validation against the live PMD. Note that the P=
UD
> handling is required as well to handle folded page tables correctly in al=
l
> cases.
>
> Fix generated by an LLM and sent by Josef Bacik in private.
>
> Fixes: bd74fdaea146 ("mm: multi-gen LRU: support page table walks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: handle walk_pud_range() as well, clarify+simplify description,
>          adjust Fixes: ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/vmscan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Kairui Song <kasong@tencent.com>
