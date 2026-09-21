Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FAB2C3757;
	Mon, 21 Sep 2026 20:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020825; cv=none; b=CU1QpfmySGhbfI2MmE1v/X3TnmdfTCgwYXOEAETGS1oKVeDFwuFJBLY5RuQ3HeAGLNUfGyp2ryL78+NLnml3KMGrvVx0DZLTIU4KYRZipl2AQxJqX2tr1vHIueSfjBeyYNPgWmxIdrDyvTpS7cwn3Rm3jXSnyYMgWV/ClfM5K/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020825; c=relaxed/simple;
	bh=Jle8I94CDmdb6pvC+qkgL9TgIKRqIkcLTUltvuexjhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j+uK4ieLedmfzoWls/TKln68Dgob3x0eXzwAYlOI3MBkgE3UgCP5qBftXJMG8Moo2GJfEPnE8oGQhj2DN0w4ugU1rVhneIt9e0e0LPoptKW9WH+A3Q97DUDe4kydZJCEcXrJIFn7tcou2yljzK5cNu1NXaXh37mnvnhcx4p2Drs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcANY6MP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcANY6MP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD45C1F000FF;
	Mon, 21 Sep 2026 20:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790020823;
	bh=BWjdXfohek7UjopKrNfrvbb5fe9CUNtaKf7mkTIpAPM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RcANY6MPoJ2cYKtAT9WPPzebl6rnP5o06GtQRzAxnS2cy1JZ5rgXmtN1t5ZGKsbbH
	 25x3qs1W6FlHMH+KF9gdSLgkXJJDREvTRnQOsdNal5ankk+VYml4E3fGwimsdCp+vM
	 NphSgLOkAm8GFPTWivHmIIzFeB7/OnEU35Yc3BVa4QQQv05VDFFeVgjETOBb2q9efS
	 UfR3jAZA1LhbPlCRhFxkd+wgwhcEzqtp1K1JVxIW5XjepqiRLEQ9j3mzScmCq15cuF
	 txdI0eKbUsdLOcCl/QC9e9PRxydnF8kcOTUTluQs+R8x/ciTLTZ7+1Y/in+RED0gUP
	 xjPfr/4voZJnA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 21 Sep 2026 21:58:59 +0200
Subject: [PATCH v2 07/13] mm/sparse: remove pfn_in_present_section()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-b4-sparsemem_cleanups-v2-7-54d81d65e125@kernel.org>
References: <20260921-b4-sparsemem_cleanups-v2-0-54d81d65e125@kernel.org>
In-Reply-To: <20260921-b4-sparsemem_cleanups-v2-0-54d81d65e125@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kairui Song <kasong@tencent.com>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>, 
 Oscar Salvador <osalvador@suse.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-cxl@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195; i=david@kernel.org;
 h=from:subject:message-id; bh=Jle8I94CDmdb6pvC+qkgL9TgIKRqIkcLTUltvuexjhY=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLI29rR5GKiXvujIEuRX+Shp77folP9Hhcre57Mi2+uuh
 UzlW3W7o5SFQYyDQVZMkSUo+L7By5fraqvd+Jhh5rAygQxh4OIUgIl8DWNkmH3816TKqS9/GBwT
 FvpV72i/X7Pp4S2vhPiCTQ81t7TUMDIytObKHBOrfc2cGm/kGp2tX7D0qsnpc8I8L2xSHCW7wzZ
 zAAA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Unused, let's remove it.

Acked-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/mmzone.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 0c2fea48c261b..a3937577fbfb2 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2326,13 +2326,6 @@ static inline unsigned long next_valid_pfn(unsigned long pfn, unsigned long end_
 
 #endif
 
-static inline int pfn_in_present_section(unsigned long pfn)
-{
-	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
-		return 0;
-	return present_section(__pfn_to_section(pfn));
-}
-
 static inline unsigned long next_present_section_nr(unsigned long section_nr)
 {
 	while (++section_nr <= __highest_used_section_nr) {
@@ -2362,9 +2355,6 @@ static inline unsigned long next_present_section_nr(unsigned long section_nr)
 #else
 #define pfn_to_nid(pfn)		(0)
 #endif
-
-#else
-#define pfn_in_present_section pfn_valid
 #endif /* CONFIG_SPARSEMEM */
 
 /*

-- 
2.43.0

