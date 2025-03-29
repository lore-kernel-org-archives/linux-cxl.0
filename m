Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736D313DB9F;
	Sat, 29 Mar 2025 11:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743246154; cv=none; b=LgzQdEVDVZDIkCbRDXaWe09rdE1I/9QWLPzaGoGPjlYBqPfuF87NxsI3XET0VP17aL0B8rvS1TjoRe9HngGolRObd97mqduNP3PcdggPyj1u4LrZU7hHL3vO0Ood9Z/c+LqVFghBWyy5YuiP7+ucb4QHEstXvQ/4dnqZlc6yqDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743246154; c=relaxed/simple;
	bh=l6crxca4r7jaf55ZSnco5wxAGLEhNB1a7qmJEmUi54E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tX6iNy8F+1Wo5p0cAQHNwPK6HCLpQ8lFE83BR38uzjMdEeZxHObVa7LjVkvLqs7G4+EnLKOZ3yU3QDurKckN2VSc2Q9QJ8ubOC2dd6ySOhgaNbh0wyj1+tWudSYr40TRdt3C2P6qkJy4vH4clXm05y9pG2m30kI+gYlclFlTpZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlfzAxlj; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlfzAxlj"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e46ebe19368so2529193276.0;
        Sat, 29 Mar 2025 04:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743246151; x=1743850951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sz8keCqa5qupL5Rb/+bTM+6bhMdIOvmpSra9wTxqHOM=;
        b=HlfzAxlj52+TdVsSka9dISBWUuqm14mxuRBYr/DOVszHqc99om8lt5o7EjRTvYUmQI
         usTCOUwlxf17nFDwjfSiH5k3ZeFmwHr9rGsIdOW96K+yFM/B2R2VqE3pyXObcp50Df4N
         7UgC5u8rf9h5IiEbYRcdwIq2DRO//UEzYriqjzVNSZt/oE0yUOi++2xW0l3nUCqWvwZV
         UfmamB3/O2D3dq1xQ4MmWUPkWRd9HqZNLQGGR5zCvH3x6DouJnMLhJwbSKPS0KmQY1b9
         g1mItc7yBG0QGA3l5DijTcQLEVIVbBibBPZ/hGhFnqb5J629NjezrhPCi6V3veCwS8r7
         6Z6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743246151; x=1743850951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sz8keCqa5qupL5Rb/+bTM+6bhMdIOvmpSra9wTxqHOM=;
        b=K4cIIhsp8N5rB8o5btvzELeNooPY1aYYChyA499z6WupiyWB3dYI2L7FJ46p1u5s9z
         72yBw2NUwVM1OjFRoYcSjA7eCnmARxnddYQDzosreSKqYrRu5XWLPxbi3pmvm4+lRMpO
         qM5zYnzr6CV6yLG1XkObfD9y5B8Nuiq/MrLiGawxrhkUHJCTnDzpNaD09H6GMJGEZpXC
         73iDug0mf8NtiY6F7hhBTZiggZcCXs6g5pk2GlPAjLPj5/2XAEFWNnHC7I+dSx1qzdxp
         e43+wAe2rdcTiekPeCqpd7L6QhRZs+f9QZKcwBiFD49E2zbEZRs8fhMvo7gxt81ri39O
         d3Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVzaei/ODttPjIN8CNkxdlmcMFNafIS2WfoM4wI02PYyFVVQmSDzP3TfJ0WhFqD9//Bvx7OSofuv0Y=@vger.kernel.org, AJvYcCW6iwFUTPCPkW36L6aSNJxb4xkt+tirOq9DhbknfPsQpEjPoRGTnBC52NA9GnxzVsYJkh4EfD5/rdwJs1vq@vger.kernel.org
X-Gm-Message-State: AOJu0YwuUM/u/1GMrL4HvPV4QeFIFGeS35rgxuCyJlauWjYGZgMD48B2
	R+tl/9MXk0CukjzGCC7MrXLiEoU9vVyUMlh8Gh/2yTUOqpAgyKPY
X-Gm-Gg: ASbGncs7X/jBOYW1kguYp1aeHhRnqtPSXwRqLM3SdxL1+WkKQF0sEDRX9LDKpghOe8y
	uhg2O4dFdPI0DZvw56YhOWkuoPHMk0+rygUy16SeSodQdhgIEhymaYhgYI7Ixaoze7Mp//7HzFK
	71xUkAZMIxWxPRG84HA3c3TGxeWPCnux0IrNYZgJ1zlvrpP9hdQyAYQlb1sbApFX+oiKHECWMhO
	V6IBc2tQpxpWlwzjBKpyRNLF3Hx+/fH6NVnC9R7I/t30LfEHl0k3IILnpKE65qXxvoMBPmJu9JQ
	ouexs/j9SevoRYfZsD/D8hb3zC725rQBzLI3d9nt6XTcJw==
X-Google-Smtp-Source: AGHT+IGTHtzkeKtUtYf4ABEeM2lZ6bKxI1FNIxhtRBiZP9SDv3siVSdXIdoMhyiM9MahzTDX2SnQXA==
X-Received: by 2002:a05:690c:480a:b0:6fd:47a7:3fb2 with SMTP id 00721157ae682-702572d919bmr36632147b3.24.1743246151245;
        Sat, 29 Mar 2025 04:02:31 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:1::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7023a3bb561sm11682677b3.40.2025.03.29.04.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 04:02:30 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	yosry.ahmed@linux.dev,
	chengming.zhou@linux.dev,
	sj@kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	gourry@gourry.net,
	willy@infradead.org,
	ying.huang@linux.alibaba.com,
	jonathan.cameron@huawei.com,
	dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org,
	minchan@kernel.org,
	senozhatsky@chromium.org
Subject: [RFC PATCH 0/2] zswap: fix placement inversion in memory tiering systems
Date: Sat, 29 Mar 2025 04:02:28 -0700
Message-ID: <20250329110230.2459730-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, systems with CXL-based memory tiering can encounter the
following inversion with zswap: the coldest pages demoted to the CXL
tier can return to the high tier when they are zswapped out,
creating memory pressure on the high tier.

This happens because zsmalloc, zswap's backend memory allocator, does
not enforce any memory policy. If the task reclaiming memory follows
the local-first policy for example, the memory requested for zswap can
be served by the upper tier, leading to the aformentioned inversion.

This RFC fixes this inversion by adding a new memory allocation mode
for zswap (exposed through a zswap sysfs knob), intended for
hosts with CXL, where the memory for the compressed object is requested
preferentially from the same node that the original page resides on.

With the new zswap allocation mode enabled, we should observe the
following dynamics:

1. When demotion is turned on, under reasonable conditions, zswap will
   prefer CXL memory by default, since top-tier memory being reclaimed
   will typically be demoted instead of swapped.

2. This should prevent reclaim on the lower tier from causing high-tier
   memory pressure due to new allocations.

3. This should avoid a quiet promotion of cold memory (memory being
   zswapped is cold, but is promoted when put into the zswap pool
   because the memory allocated for the compressed copy comes from the
   high tier).
   
4. However, this may actually cause pressure on the CXL tier, which may
   actually result in further demotion (to swap, etc). This needs to be
   tested.

I'm still testing and collecting more data, but figure I should send
this out as an RFC to spark the discussion:

1. Is this the right policy? Do we need a more complicated policy?
   Should we instead go for the "lowest" node (which would require new
   memory tiering API)? Or maybe trying each node from current node
   to the lowest node in the hierarchy?

   Also, I hack together this fix with CXL in mind, but if there are
   other cases that I should also address we can explore a more general
   memory allocation strategy or interface.

2. Similarly, is this the right zsmalloc API? For instance, we can build
   build a full-fledged mempolicy-based API for zsmalloc, but I haven't
   found a use case for it yet.

3. Assuming this is the right policy, what should be the semantics? Not
   very good at naming things, so same_node_mode might not be it :)

Nhat Pham (2):
  zsmalloc: let callers select NUMA node to store the compressed objects
  zswap: add sysfs knob for same node mode

 Documentation/admin-guide/mm/zswap.rst |  9 +++++++++
 include/linux/zpool.h                  |  4 ++--
 mm/zpool.c                             |  8 +++++---
 mm/zsmalloc.c                          | 28 +++++++++++++++++++-------
 mm/zswap.c                             | 10 +++++++--
 5 files changed, 45 insertions(+), 14 deletions(-)


base-commit: 4135040c342ba080328891f1b7e523c8f2f04c58
-- 
2.47.1
