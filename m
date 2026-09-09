Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B5B569F1A;
	Wed,  9 Sep 2026 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960949; cv=none; b=YPuWlaCw/d9U8LKbQ/LwGbkJrYlNkwtzFuBh7WnNCWGodY08sv64M4AWy7zaQKb2PzFDeu0pbFPtrD8hPhkP3b+nsQkaMW0pxBOv4Q+OiMzag8j9jF0GoioTEUAQwFAJvUZ7FhnhvfcJsrwMxXocqwbkd88cQrNVEfREjuaJldw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960949; c=relaxed/simple;
	bh=I1xFmYSCNfoZRtg/iuz9b+jqWmT7TApM4OSDy8PLZHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rNJD++V3z5HCIr4PV43moSANkPQGRRP5D/yJetylDPGhfCCikIEv/MDwikke2PJQyytONUKaHv72fcV00p0wpkXZN6t6BiQNtPku4lwcXBbp2v2zhTow5kTyVeHLVu/r1ltbd9XXAcsanzZQE+ajB9xCY2WQ3+XMiYTDGS0Du10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUP10OIi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUP10OIi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CCA1F00A3E;
	Wed,  9 Sep 2026 13:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960947;
	bh=ppqQV4pamAYsPTCmhaUztf71g95EkhNaJEiPUVBmZoE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lUP10OIiiOD0g1gKYxyCH57GeQCpOQLzLHyLszIH5wxx2hl1OGsyMlnlJy4o9hb9H
	 vTrOvVYAthk4gvleTtWAJw71P7fv0FXFCCXGNP8cBs9MBdObgrQ6MjlpBPLC/UPW2S
	 QX2T0FYx/bn46HOQjzuDWhc0YGbY/YL3k6D79wQHbNZbT7G+N1LGVnZ0OOvHnEvvGJ
	 9uRqg2cqO1vXaitIqGjFXRGf4ybQTmrIYuUF7g3DZjX671eT1b/hS56i9xzP6RED0F
	 u00fsWfWEkfTtbOja82QX9Qf+O/BwWhl6H6FvG+Jtl303l8DvzaWXdGCMUBbR5IwyX
	 Hw6rkhYHu33YA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 09 Sep 2026 15:33:05 +0200
Subject: [PATCH 12/12] mm/memory_hotplug: drop CONFIG_HAVE_ARCH_PFN_VALID
 handling from pfn_to_online_page()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-b4-sparsemem_cleanups-v1-12-008fc8d579fe@kernel.org>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
In-Reply-To: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Oscar Salvador <osalvador@suse.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-cxl@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1129; i=david@kernel.org;
 h=from:subject:message-id; bh=I1xFmYSCNfoZRtg/iuz9b+jqWmT7TApM4OSDy8PLZHc=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIWJpgJMyzyvB65vL27f85kbXdLt6gbDzY/Yp6Yf8VM0
 q7DdL5oRykLgxgHg6yYIktQ8H2Dly/X1Va78THDzGFlAhnCwMUpABP52MPIMCEkOfOdVfQq5xUS
 2W+mcbQLni1POiPosUizLu1HR5/6BIafjB+i52zNM5h+yPuoQ0/ve5nj2ncf8i+0Xq1Tdfdeq8B
 DNgA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Drop CONFIG_HAVE_ARCH_PFN_VALID handling, as CONFIG_HAVE_ARCH_PFN_VALID
is never used with CONFIG_MEMORY_HOTPLUG, as the latter depends on
CONFIG_SPARSEMEM_VMEMMAP. Make sure it stays that way.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory_hotplug.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index b428da66d279c..58ce35cb48f57 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -344,6 +344,8 @@ struct page *pfn_to_online_page(unsigned long pfn)
 	struct dev_pagemap *pgmap;
 	struct mem_section *ms;
 
+	BUILD_BUG_ON(IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID));
+
 	if (nr >= NR_MEM_SECTIONS)
 		return NULL;
 
@@ -351,13 +353,6 @@ struct page *pfn_to_online_page(unsigned long pfn)
 	if (!online_section(ms))
 		return NULL;
 
-	/*
-	 * Save some code text when online_section() +
-	 * pfn_section_valid() are sufficient.
-	 */
-	if (IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID) && !pfn_valid(pfn))
-		return NULL;
-
 	if (!pfn_section_valid(ms, pfn))
 		return NULL;
 

-- 
2.43.0

