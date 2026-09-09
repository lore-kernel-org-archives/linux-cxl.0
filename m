Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0105255C1D2;
	Wed,  9 Sep 2026 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960900; cv=none; b=Lz8+0YHAISsEibBj26Eo6hhXPkeQOgGp5zTU7/2Cv5jcycWiM2Raw9tgGr7shB2lSAA5p/MArlKWeRDxkRWLJ9AaH3iu1rrJxLuE9BwR4HSDHFj0caBzaWxp95bgHpEnHSh0A3XPalgzK+45PGE0ezawbwbC40u0UYdg1C9NrPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960900; c=relaxed/simple;
	bh=DA7ADutddsFmCEjmK+yDurz/oaDpzdkWvjLNiIYgvvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UNTlV0HlhWLggA0417arS4lYG1prRjoeyPGxcM/dWCTTew/Kf0nddxH0rfbiDUjkfrk7MqOEZRnxrKXE6K1Gr5JpRu/n6qiAxtakPJ3sAR5yaBVWCo4hJ3AZQBKvjHOEzmu4CQAuwfQEuo2shivC3Jr4MrgOwmAZghdXDw/lf4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRsmgCIw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRsmgCIw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9AF1F00A3A;
	Wed,  9 Sep 2026 13:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960898;
	bh=RbrTaD0MOwCU/dADLtwS3cqKnDKmO0natjZctaLbG/M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BRsmgCIwY0Z931Vf0ZjC6k0U+yWVRAZCHkkhlcXWETlu88ySO3sCpKrVMlBV0iwfx
	 uhI+WzvqD/3YQ8SMBuVeKSS3n9hx1GEVvZRBQVN+UZ6ykgBxwlGQRStGr9ZtQLU75j
	 5aH0gGEiUG3K64WjEPowzkxXP0T0DJT7FbdoM/VRe8+Cqvr0qaOBmdfjtxHK8E99jh
	 mCxckMTz3aD1mk4SOj53r+ZG94HF+mDeSiNjqjkOPLTKlbPE9tnTT1lHzT53+jY59q
	 em4ZD3q2xBchOgXc3/a8fw6iE6JpLL9tOd3EhDpAZ+Z9UGFQ1cTGuOHPZ35dJw+hKz
	 ndwC/p+XCnE6A==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 09 Sep 2026 15:33:00 +0200
Subject: [PATCH 07/12] mm/sparse: remove pfn_in_present_section()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-b4-sparsemem_cleanups-v1-7-008fc8d579fe@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1038; i=david@kernel.org;
 h=from:subject:message-id; bh=DA7ADutddsFmCEjmK+yDurz/oaDpzdkWvjLNiIYgvvA=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIWJhj9LT/1YHOplEHQxz9GrwpNzSyZjmz2tmhef2zS3
 OZzJVmKHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEzk5BqGf8bHdbuE5Vl+1wfJ
 rk3bxv5+Da8L//f8XY1WufOf/10fz83wV1ZXYe3Dd1PSZ0bz3Ofq3hL065LbnIjrSodf/jx98dm
 sNawA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Unused, let's remove it.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/mmzone.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 19296e8ef44f8..e0fac344f6ac2 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2315,13 +2315,6 @@ static inline unsigned long next_valid_pfn(unsigned long pfn, unsigned long end_
 
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
@@ -2351,9 +2344,6 @@ static inline unsigned long next_present_section_nr(unsigned long section_nr)
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

