Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793074933;
	b=sFYheqAFG/8Q3poqXR80Yq3m9mmnRRlQ9GKF9G6WJKFot+NFnkWW6FwcE+JFgJE3Yufe
	 sjfdR+k3RTuJA2qQMsQLRkdlaGfN+Tdy7PHAzUI0okYl2FSLVDsXKZrl1SeO3nOXW10Oq
	 AJrxumkOYRv76V8uRxzOyqYesKo+RlH/PzQrMjQRr4QIBZtbyHiZA9TJsl2SXJ49g3yNp
	 7VB1qDSqVGoJzx1+f7rwRhFt53mvDGjgn9r+No4xlTOHb/cL9plCx8CQ2TjNcXvYV0vMN
	 yiZNb4HCs0TzwG67eRxFzyNMIebF8OyT5UmpeFesN025h+19Kzr479gvJTWotjbEwLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793074933;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fubOaxOgmofN/3iFYwSrZzfn2/O9nYxlfixW+9HNaRE=;
	b=MD23f7Lz40MCNFfNQfpKCMpmnO1uL2q97vQO+2iKO38rqgqAclOAkB2/XbL58Mb53LsQ
	 Sgfct1sl7TnMIiEq/7AsxKwAhsQua/5/c1GRvirF1hWVvWJs3fV85r5hK/3RiN6JPa5WC
	 TB/Syha6NhH7teUHGUlJiNVVdAWDowGxLFyM/h08cFrry/EWep8hF0QXwQSsF3OwE/+8J
	 37d7nBAb4kOMHgTFAlWo5si+GoetHisf/RJp4I9cnWppAyj8zTYj0TTSfj74oWbXoxdCl
	 N/sOHZnqkjbiCEJZOHE/0Ukg64wxXO0AP2/xmMFLB78k9l7hw9l//1Vje+Jkor6+N4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=GMv5hpEW;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2E2606A31A
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 04:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A2E2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=GMv5hpEW
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91986c5cb75so37222976d6.0
        for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 21:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793074932; x=1793679732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fubOaxOgmofN/3iFYwSrZzfn2/O9nYxlfixW+9HNaRE=;
        b=GMv5hpEWLffJj9XNe0rwhZUg80o07hoik0Uc+bdjO8vwxOQnXkUSF2+8mMCp1rmSGt
         422HUdWwtLS1VB4wScEs1vP49yWF/b/QIcZxcCvLGxpzxfdkG/QO4ChVjpkFxuKC50av
         6oet7ESWbw7JYI0zgNc+S3eHXRo19L931xfvoz5yHwgtnffWGdvqjFpmhI5R8RXOk1h8
         0QkNJnQBTryIkwOvq8GkKCIoMwQgtoiUncL6CeJHYrfyrJOlDrurfXyQUbvTS6lnsRWJ
         ZSvfU9OVAQxYd/F/o7A7Mx0OejzztF3cokITVw5wmyN2qP8i+PKMkKIgvSpomA/S4/Mz
         xU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793074932; x=1793679732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fubOaxOgmofN/3iFYwSrZzfn2/O9nYxlfixW+9HNaRE=;
        b=UBok2abu0mm+YZNleEjwxk6+L/AFjPsJKQN6bAUExRf4mQZNsqrCsxDDnjlhQ7XKa5
         V2PDcMLNQlgiT8LYg6QErHJ+Kg3ZoHZpnj10sxHWsQSxi+qJuBUeH4XwxiH4TATw2BO3
         XAC+5h7TkWWWzYqQayFUVqazI3Fz//SEmNV7OdIRu7L/W4txDaJ/39rhF2oG1n7nk6ql
         mRG8kFNodmzJS7w4FAIFUcbakU8Ter0PW1CZh2WsfUKK9kOp2O8srthfo5Lvy42V2wSi
         7/p7FfO5K7d2Cogb8Pc1C4Qg35d67GfsnaV5iysyB5JbytdYKb8utgro/xb18WGB3OD/
         amIA==
X-Forwarded-Encrypted: i=1; AKwUvByXwpgYO5axwMH4mFxkXOom2P/OFgbIlk8ByNicWnwfBB1Ud2NuVoYpEGbLZYtpirxZTH2KSZx3cWw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKA8WAiN0DMPtV4eMlMvyNdtqc1P4OTnCVF+3BSpSVfQZwn59BQ
	nPH97czlvoGdji1MM93nCX7mXeWGIJg/Ieww8R9WLVF2btYu6SCYYpMALgSDcvweMKQ=
X-Gm-Gg: AYBFou0OSpOpPndLwS+o1hz6ORTauho74aYZkBegRjes35xN1o4QaQ+jnZUh5lIUXBV
	Cnjf+xRlwv5AzfjKsePnW2evVyyOUD7i0DQqidoBLFjpSfDSNld4UceH8mPR8JXGvkSzQPSRUuL
	OgI33JVhQ+2+ieta2QaLywn9+5j/IyW6pz21hJiPohRWdbxXVLPm+OsUNCFwhc7a9kanzMFdufH
	N85ULGvkyFUOIoeIxj2qiTsZKM5//PR8JA9Aceog3DqJFH0+n6PUIes+LFR8nwABKr3lwUFcjc5
	/FmNh4LYHBF1ojHKJleC1w01KMJpH0ifldu/2RAUJH7KTh3L+zsdwVD43pz+3xXu9bJc895XxeS
	6WmxdaQafw7YbeoVrhKJhNjbtCSn4PHMT9XE93/mje0Yt5mRx1NZBYEhXc+brWOYypk1SQ71pDs
	YxkVeeSHcMexIPF/xA3pD7tHe9vRVRVGfoOZHxlc2EwmN7na7C/76ydfDcvG2FbHcTM9gG+md3n
	nhIYivaNTnwiUvaWXJ5mcys+7mu9D94a99DEBjBwNPvE95jmLxVPd0doPvNvwMdaZzt/elTl/0g
	oSHGs5hu+fENxaNDwUCoN9xpCqyaPbacqMqh+dTzAQ==
X-Received: by 2002:a05:6214:29ed:b0:91c:65d0:1d78 with SMTP id 6a1803df08f44-91c65d0312dmr64203956d6.50.1793074932283;
        Mon, 26 Oct 2026 21:22:12 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47bd01cdsm91139676d6.7.2026.10.26.21.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 21:22:11 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	rppt@kernel.org,
	osalvador@suse.de,
	muchun.song@linux.dev,
	iamjoonsoo.kim@lge.com,
	anshuman.khandual@arm.com
Subject: [PATCH 0/6] mm: fix pfn walker races with memory offline
Date: Tue, 27 Oct 2026 00:21:58 -0400
Message-ID: <20261027042204.3741307-1-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several pfn walkers check that a struct page is online, then use it
after memory offline has poisoned it (CONFIG_DEBUG_VM) or removal has
freed the vmemmap.  Five of the races crash the kernel; the sixth leaves
an offline spinning with the device hotplug lock held.

Patch 1 adds pfn_walk, an SRCU-fast read section that offline waits for
before poisoning the memmap.  Patches 2 and 5 use it; patches 3 and 6
hold get_online_mems() instead.

  1. compaction scanners
  2. page_owner reads
  3. memory_failure(), soft_offline_page(), unpoison_memory()
  4. alloc_contig_range() undoing another caller's isolation
  5. alloc_contig_pages() isolating a range that went offline
  6. the hwpoison-inject filter

All six are for stable.
  Patches 2 and 5 need patch 1
  patch 5 builds on patch 4
  patch 6 builds on patch 3

Testing
=======

Each race was reproduced on unmodified source in a QEMU guest with three
NUMA nodes and a pc-dimm left offline at boot (DEBUG_VM, KASAN,
lockdep).  A test module holds one task inside the window while the
offline or eject runs, then releases it.

         base                           this series
  patch  outcome                 runs   outcome                 runs
  -----  ----------------------  -----  ----------------------  -----
  1      GPF                     3/3    offline waits, clean    3/3
  2      GPF or #PF              6/6    offline waits, clean    6/6
  3      GPF, or unpoison of a   9/9    blocks, -EIO/-ENXIO     9/9
         poisoned page
  4      offline still looping   4/4    offline completes       3/3
         after 30s
  5      GPF                     3/3    offline waits, clean    6/6
  6      #PF                     3/3    eject waits, -ENXIO     3/3

Without forcing the window, offline/online cycling under compaction
faulted in 8 of 24 runs on base and 0 of 12 with patch 1.

Cost
====
I was unable to measure a discernable cost beyond noise, stddev of
walkers and scanners runtimes on real hardware was wildly inconsistent.
Leads me to believe this change is largely imperceivable.

Gregory Price (Meta) (6):
  mm/compaction: wait for pfn walkers before poisoning offlined memmap
  mm/page_owner: hold off memory offline while a page is read
  mm/memory-failure: keep the page online while handling it
  mm/page_alloc: don't undo another isolation in alloc_contig_range
  mm/page_alloc: keep the range online while alloc_contig isolates it
  mm/hwpoison-inject: keep the page online while filtering it

 mm/compaction.c      |  8 +++++++
 mm/hwpoison-inject.c | 55 +++++++++++++++++++++++++++++---------------
 mm/internal.h        | 41 +++++++++++++++++++++++++++++++++
 mm/memory-failure.c  | 31 +++++++++++++++++--------
 mm/memory_hotplug.c  | 16 +++++++++++--
 mm/mm_init.c         |  4 ++--
 mm/page_alloc.c      | 35 +++++++++++++++++++++++++---
 mm/page_alloc.h      |  7 +++++-
 mm/page_owner.c      | 45 +++++++++++++++++++-----------------
 9 files changed, 186 insertions(+), 56 deletions(-)

-- 
2.53.0-Meta

