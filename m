Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0290D4078DA;
	Mon, 21 Sep 2026 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020845; cv=none; b=G9XcUDQUC2kzqCZGHMTLV6Uli9lQvnw/bC549zA6+zmJ49mQ1/44XmbURm4buplBOgEyPvNmjmcmHnl8oZBWTHMD3Md9/eFgNQwE25DppbLsYFobJVUMbLuWtS74eRlv05dyjxAdWsz5QHptU6fdKfyuWyMBwVISrS2Lnkk/Dek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020845; c=relaxed/simple;
	bh=jwQvu4qZS6XE1lcAS+1uGAzJgDZ5r8Nhr1JAmrC9v1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BQihDSP4fpkUjyvSMtsfI4G94krcWfQ25jcBFRRu2+i2qXUoWisO1ahvkSuaWQ/m0UJQwYMDFir/+rVd/A7gprnhYrq4l4PkRFfKRjSsjtlUD1aLsDGn+rzwK6A0wg7AT3rkUub0VdfwhHeve+jKFtOdcVRDR+8erQOUkhGAz9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/21wIT5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/21wIT5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF4B1F00899;
	Mon, 21 Sep 2026 20:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790020843;
	bh=y62DVnMDdavAiYdaSQq1B6ymlLgshs+nlcdsOqXOLNo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=n/21wIT5DeOj0tDR10PV6a4TVmuf60zaeenrhNhRg3XkB2L3EFMMQpfrQPZU4O3cn
	 7cM9mxkE2KJRADMKeYoBo0kRy1TN/yvVfquwu7TsbYnRsL0u6KUytogk/JTcM3M76W
	 eKY/mdS0K+GGpPP95F8qt/P3cRCTvrTuC3q+4vS27DKAN3EcUm6Ong/KC6trt3v79S
	 vmLsPsF/iI/n4rok4KMmDye1qKWnWYa19FxP0Y3FqZ/VhwV8jKRRxFJmf5U5f1dOad
	 A1xy2vUEou15k3S5lbCjf6dRv9e4jRDF6ZLttGqtmSLc026V7phMcqmvBG6R7CtJN+
	 +2jvHiPg71Nrw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 21 Sep 2026 21:59:01 +0200
Subject: [PATCH v2 09/13] scripts/gdb: mm.py: remove fallbacks for
 SECTION_HAS_MEM_MAP and SECTION_IS_EARLY
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-b4-sparsemem_cleanups-v2-9-54d81d65e125@kernel.org>
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
 linux-fsdevel@vger.kernel.org, Seongjun Hong <hsj0512@snu.ac.kr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1344; i=david@kernel.org;
 h=from:subject:message-id; bh=jwQvu4qZS6XE1lcAS+1uGAzJgDZ5r8Nhr1JAmrC9v1A=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLI29rS9XfrH56DO7yuLD8a/lj7zzGK/7GEn1y3ayqLHL
 iyOqMxZ3lHCwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBE6p4wfBVQfSBYV7YgY+e0
 TAXW9gOOi04yqZw/JL50vWPyl2ybVob/idcrC7aKht2MUA15Faec3itQIvishkMytb931eSZa+w
 YAA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

There is no reason to handle the absence of the corresponding BIT
values. So let's remove the fallbacks.

Link: https://lore.kernel.org/r/vpz5zqg5nwbpolxbkip45vxxdt3lni7j2haal7q42skc3b57tu@uh4cec4x32dq
Cc: Seongjun Hong <hsj0512@snu.ac.kr>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 scripts/gdb/linux/mm.py | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/scripts/gdb/linux/mm.py b/scripts/gdb/linux/mm.py
index 193a88d763abf..7398105ff3f67 100644
--- a/scripts/gdb/linux/mm.py
+++ b/scripts/gdb/linux/mm.py
@@ -71,12 +71,8 @@ class x86_page_ops():
 
         self.NR_SECTION_ROOTS = DIV_ROUND_UP(self.NR_MEM_SECTIONS, self.SECTIONS_PER_ROOT)
 
-        try:
-            self.SECTION_HAS_MEM_MAP = 1 << int(gdb.parse_and_eval('SECTION_HAS_MEM_MAP_BIT'))
-            self.SECTION_IS_EARLY = 1 << int(gdb.parse_and_eval('SECTION_IS_EARLY_BIT'))
-        except:
-            self.SECTION_HAS_MEM_MAP = 1 << 0
-            self.SECTION_IS_EARLY = 1 << 3
+        self.SECTION_HAS_MEM_MAP = 1 << int(gdb.parse_and_eval('SECTION_HAS_MEM_MAP_BIT'))
+        self.SECTION_IS_EARLY = 1 << int(gdb.parse_and_eval('SECTION_IS_EARLY_BIT'))
 
         self.SUBSECTION_SHIFT = 21
         self.PAGES_PER_SUBSECTION = 1 << (self.SUBSECTION_SHIFT - self.PAGE_SHIFT)

-- 
2.43.0

