Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B02E3112A5
	for <linux-cxl@vger.kernel.org>; Sun, 28 Jun 2026 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782683133; cv=none; b=LTGQxPmAQ3spy0vec59W/wVUNDoH90kuIHM5kR+sdYWvSsFMFxjCBWZI6SUI0kX5mlBsEjKK8i9LsBj6UBg/dE03+Xt0TNhXtriJyEBcnFHVbeufS3Yf9ZrIK+mZUOPPRvHfXKc0GvFjq5Cgtz2cWh5ej7B5DX245tPxnrHAd2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782683133; c=relaxed/simple;
	bh=/ZbPZaKN0+YnP2ecSMeNXI74pNvLNA/7+KkELfzlBQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lI1GlI/X4e0NQPy2h4rVeRkRD5Wyu31nhRqogsSlBkdMrYpGfjHL4sJJ+V8z2CSybZIxcmTyVGaI4nxkQNkvx0lSrFm8KrCGJPeC11ejBIgE/Fa9t5maWrFo0b+4312fSXq4TF7ugs/f4wFsFG7896U9vUCVcuOyFYVXhbxPRG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QXgjva6G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXgjva6G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782683131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=RCuiBN9uCkmY04AJpyhIWd7gPOrcS7Rrqdc+Y3Kk15Y=;
	b=QXgjva6Gi4O6YD887grlurtmwnNtsBHmgFCB9P6+1grfVCTxWq7NiEgsEO9H2E5JF3YXDQ
	SWJRJ3U1iPgS2ls/YgITViE2qwkUYFr9Iz9xYcZtBxlzKC7JYRGhELOzqyQI/IkZDzfSHi
	H96CjvTTxdAxJ+34aU5geKhLQvpJ0HE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-Kh6DYHFKN46hKj9XzVzAOg-1; Sun, 28 Jun 2026 17:45:29 -0400
X-MC-Unique: Kh6DYHFKN46hKj9XzVzAOg-1
X-Mimecast-MFC-AGG-ID: Kh6DYHFKN46hKj9XzVzAOg_1782683128
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-46edff99956so1261314f8f.2
        for <linux-cxl@vger.kernel.org>; Sun, 28 Jun 2026 14:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782683128; x=1783287928;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RCuiBN9uCkmY04AJpyhIWd7gPOrcS7Rrqdc+Y3Kk15Y=;
        b=Q49/Q4C7bUKQhNMcJe9StPRGlBQPlAy/AjYFYdiycl+8r1BHeEivUY1oQgLF/W14zn
         ub2BUK2MZW7JbLzU4s38kEgNHtUaFnsXYBxzNGtMilbSSMd2i1wk/aPkF9nH10u5qxCC
         FYHcXdmXWFd1poa98UH6yoc4FpZRsy8XrjOR03+L7oAQnkMVI3iZUotUMGdb7ER3GDz7
         XGm0Pnl6yFleEE6mJGuAlfZ8CW8F1cWtMEpG32Lwwi3ft4J/8Ot0qG28cNjkaIHf9Y1T
         4ii90luwiAnMAk9ZEsl86UG9hTUfpnLv8tiHZ8HkeKz/+3Hi7HgvhG5OiwvyXLmwdBc5
         t5hQ==
X-Forwarded-Encrypted: i=1; AHgh+RrMUDVYm8O5a/n8sLTWn6F+U07pIqy57DiqFvs8hWGzFZff6HB4BNH3CLkGr3It2fzAcyOS1QPuJnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwFMEgIvDwmdJGL8royExj5wyNc1REFLhr1tfEeRvFVAuCA6Zx
	L4/29tp0xAG0MN7rRMMQZ0ee3+taJ73P28qEE8E0B4gEhh4fKUSMHIHgAKxcX4a8bYp7zyvwfvV
	5OhN8GROjN0EiYu7ABCN+EzEbH2aKHIxEISnY2XiIrh+QX1moIku0Apz4O4bypQ==
X-Gm-Gg: AfdE7cl8A5R2lMYd25hECi6wk2VDwre+/ippyaolduBMIsBHmGT77O0TgieyazsGRky
	uGcTobepdlRfgXTtun/L9MMDP/FS0aJAGBmXfUXp8pvMDdMI+m3/H9XtpKhlZh135HdymgVo4wv
	4/fX8QNzBKH2jFgiLmTCp9/io99pXcm6YeOoMpGJ4wXulVJgGiXZV3LGBydwb6l1XFshZCHX9iM
	VVS9m3fj8nqeOZjYRtIrfCy+ywHFIhj8vvBDqKX+gWIAfJgP6qe3XePfswxOj5N6ttanx5Iy+70
	yHKc4f1YneLKQ6gTIQqmMkKTcXhnA2iU/Qe21neVcP3lsj75QRJIyufQR1gRBsvWoZS6MM6uq7E
	Q
X-Received: by 2002:a05:6000:2387:b0:460:e4d:bd46 with SMTP id ffacd0b85a97d-46dc0d0eae8mr23677102f8f.21.1782683128242;
        Sun, 28 Jun 2026 14:45:28 -0700 (PDT)
X-Received: by 2002:a05:6000:2387:b0:460:e4d:bd46 with SMTP id ffacd0b85a97d-46dc0d0eae8mr23677067f8f.21.1782683127520;
        Sun, 28 Jun 2026 14:45:27 -0700 (PDT)
Received: from redhat.com ([31.187.78.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4730937e18dsm8325636f8f.21.2026.06.28.14.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 14:45:27 -0700 (PDT)
Date: Sun, 28 Jun 2026 17:45:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andi Kleen <andi@firstfloor.org>,
	Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
	Rik van Riel <riel@redhat.com>, Vlastimil Babka <vbabka@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>, Byungchul Park <byungchul@sk.com>,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH 0/2] mm: memory-failure: fix HWPoison flag race with
 non-atomic page flag ops
Message-ID: <cover.1782676497.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aXX9vW7gVC_0aA0s9UvUMuOnBiyCVIKJhjf3Pli76AI_1782683128
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I don't like it that we are adding overhead to the good path for
the benefit of memory failure, which never triggers on many systems,
but I don't have a better idea. Pls take a look.

Non-atomic page flag operations (page->flags.f &= ~mask, __set_bit,
__clear_bit) can race with atomic TestSetPageHWPoison() in
memory_failure().  The non-atomic RMW reads flags, memory_failure()
atomically sets HWPoison, then the RMW writes back the old value
without HWPoison, clobbering the bit.

The race was confirmed by injecting a cpu_relax() delay between the
load and store of the non-atomic RMW in __free_pages_prepare, then
running concurrent MADV_HWPOISON injection.  The clobbered HWPoison
bit was observed repeatedly.

This series fixes the race by:

1. Having memory_failure() call synchronize_rcu() + retry after
   setting HWPoison, so that any in-flight non-atomic RMW that
   read the old flags value completes before we proceed.

2. Wrapping all non-atomic page flag operations in
   rcu_read_lock/rcu_read_unlock (CONFIG_MEMORY_FAILURE only),
   so that synchronize_rcu() actually drains them.

Performance impact (page alloc+free microbenchmark, 200K iterations,
20 runs, KVM guest, error bars are 3-sigma):

  !PREEMPT_RCU (x86):
                         insns/iter      cycles/iter
    base:                12237 +/- 1     17954 +/- 136
    patched:             +22 +/- 1       -124 +/- 122
                         (+0.18%)        (within noise)

  PREEMPT_RCU:
                         insns/iter      cycles/iter
    base:                12512 +/- 3     18541 +/- 214
    patched:             +95 +/- 3       -12 +/- 161
                         (+0.76%)        (within noise)

When !CONFIG_MEMORY_FAILURE, all wrappers compile away completely.

Suggested-by: David Hildenbrand <david@redhat.com>

Michael S. Tsirkin (2):
  mm: memory-failure: use RCU to fix HWPoison flag race
  mm: wrap non-atomic page flag ops in RCU for HWPoison safety

 include/linux/mm.h         |  7 ++++
 include/linux/page-flags.h | 81 +++++++++++++++++++++++++++++++++++---
 mm/huge_memory.c           |  2 +
 mm/memory-failure.c        | 54 +++++++++++++++++++++----
 mm/memremap.c              |  6 ++-
 mm/mm_init.c               |  2 +
 mm/page_alloc.c            |  4 ++
 mm/slub.c                  |  2 +-
 8 files changed, 143 insertions(+), 15 deletions(-)

-- 
MST

