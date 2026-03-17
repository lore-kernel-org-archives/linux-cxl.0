Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B523F54B8;
	Tue, 17 Mar 2026 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766633; cv=none; b=Fa9neVNDo0Jz2i33zqSuHybwPiU4/LOfsdHi5hzysYRHpOvHLPAEUqol6adhtX8eZvIlxwYAQfrmXXsw+1J0MHash67mrWpuNaRkJdjS4T/b4wr3OakLIhLR65degoEgyxoinEGOUVuxFuyzWF+5NJiAr+cW5Oek73dDhh6K29w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766633; c=relaxed/simple;
	bh=S7b2x+XCPU3hZXm9d9xUfsF2uL49ITfLzqYao4p5RE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0VyctOCOiNJkMGoJxvlzU6mtqbmkXUdA2sdlCRYBA1VHDrTrXuuEbW7CImppp6gOfDHNVjBzrr0Ik10IHZr1fqgMtnw1qIkuXy1m9yU7Me0K2DY8bCvRPGEuPYFMqokM0p2LZQ6eBfb2nveBO8VGR2QAC2tzoTgAr+9VfYZ/kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCvcqHBj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCvcqHBj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8BDC2BCB4;
	Tue, 17 Mar 2026 16:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773766633;
	bh=S7b2x+XCPU3hZXm9d9xUfsF2uL49ITfLzqYao4p5RE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jCvcqHBjzL3lu3EJ5SPQRk5NuzUuC9Fj6pxDzon+/Ch75acKDiD4ExWCHzKSe6+qj
	 u/ZuFOgoddAAb299UuHlc0qCCIQIXTcXL1e1HMsvYmP+VH0FYHJCkahfLJf3pJqV1X
	 JhSGAG8ez7/xsOL3Pw2yr5spDTXfAguZfBWr7NOycl9dZ41cHkvtmNA+RApcjcK56m
	 KcMgORh+yhCGxDGacFTMfKa37B+6BUGtk/7t0Hmzz3NoYqsKdjm/wx/5AmC9Eq9Cgn
	 +zKx5AiXEG9EcdM7j0VHxRfxxjvS03ZheB4k7eAoNR1p8mfDb5hyZmfPfk7fhS8nOK
	 XqQGiBDJM6qaQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH 03/14] mm/Kconfig: make CONFIG_MEMORY_HOTPLUG depend on CONFIG_SPARSEMEM_VMEMMAP
Date: Tue, 17 Mar 2026 17:56:41 +0100
Message-ID: <20260317165652.99114-4-david@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317165652.99114-1-david@kernel.org>
References: <20260317165652.99114-1-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ever since commit f8f03eb5f0f9 ("mm: stop making SPARSEMEM_VMEMMAP
user-selectable"), an architecture that supports CONFIG_SPARSEMEM_VMEMMAP
(by selecting SPARSEMEM_VMEMMAP_ENABLE) can no longer enable
CONFIG_SPARSEMEM without CONFIG_SPARSEMEM_VMEMMAP.

Right now, CONFIG_MEMORY_HOTPLUG is guarded by CONFIG_SPARSEMEM.

However, CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG is only enabled by
* arm64: which selects SPARSEMEM_VMEMMAP_ENABLE
* loongarch: which selects SPARSEMEM_VMEMMAP_ENABLE
* powerpc (64bit): which selects SPARSEMEM_VMEMMAP_ENABLE
* riscv (64bit): which selects SPARSEMEM_VMEMMAP_ENABLE
* s390 with SPARSEMEM: which selects SPARSEMEM_VMEMMAP_ENABLE
* x86 (64bit): which selects SPARSEMEM_VMEMMAP_ENABLE

So, we can make CONFIG_MEMORY_HOTPLUG depend on CONFIG_SPARSEMEM_VMEMMAP
without affecting any setups.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index ebd8ea353687..c012944938a7 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -472,7 +472,7 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
 menuconfig MEMORY_HOTPLUG
 	bool "Memory hotplug"
 	select MEMORY_ISOLATION
-	depends on SPARSEMEM
+	depends on SPARSEMEM_VMEMMAP
 	depends on ARCH_ENABLE_MEMORY_HOTPLUG
 	depends on 64BIT
 	select NUMA_KEEP_MEMINFO if NUMA
-- 
2.43.0

