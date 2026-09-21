Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2024A43E9E0;
	Mon, 21 Sep 2026 20:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020877; cv=none; b=jpUfl3/qarT72FKy92FO6ed5SATW1s51R80cdJYwwpTeE2kKquPAXeW6ssK4SMXWYAIyQ9/6BkUrV8nLoR9xeONuzfC38P1jDVMKzztTJbBt5z8KIxx5UPYV72PDSgtnVDCsCbUMadq04+W/5hU8wIPo89eealTc3QjpPMDCSLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020877; c=relaxed/simple;
	bh=kW71CGw1PYjxPgKG6zvCBhURTueD7ZfqBQYFE8KvMsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YIEPdUUl53jLYFm8MHlKCw74Dy0pGySo67pqG33rlYgCBZ5U5BWN1ZZ+5ub5K/U/GbX08o9NAdgn8J++Za+qXQTFWIKTZ+XwAXY0fehHD8ouAp4q5Rp+YGCjPAWzP4zNuIGSGf7uqshTwByspScD9C2wVsspTbNJWkyn/ImTv5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPA7bQ0Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPA7bQ0Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142131F000FF;
	Mon, 21 Sep 2026 20:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790020873;
	bh=AX6nGJVBYsmzhxob//RZpUMd+OEByTGb1my+643nlcM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lPA7bQ0Y8NxC0wuxHCH8bXKmGCDNvYNwrEnqOF9CaZeXU6vSkj2f3dtIY254mbADY
	 3wrcuT/NmJsCr5vJIcN2+Rz8l5EE0EOLaufW17kc9fxVSj7Frao5VgbBSKfe2t0+EQ
	 tQC6mXZmOFpNtg3z5krpUo/v1PYq89Cv8XZNO49C29i62EzNT3KJcJZFd2KG+E1ooX
	 TGojP2sXyqOw+85W+UJEEzDVsBAqzEmh33DjIPdbbGUJbarzWsQ5a0VtjQk2N1emnG
	 OalGVrUHAe1GmmuW/Z0uLwW3dHLhlQWFGXu15hYmBp/c5bFFtYDlku6c1HEPC81FYc
	 ZoHoVwdO7VSUQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 21 Sep 2026 21:59:04 +0200
Subject: [PATCH v2 12/13] fs/proc/page: clarify comment in
 get_max_dump_pfn()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-b4-sparsemem_cleanups-v2-12-54d81d65e125@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1209; i=david@kernel.org;
 h=from:subject:message-id; bh=kW71CGw1PYjxPgKG6zvCBhURTueD7ZfqBQYFE8KvMsc=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLI29rSJql0Rmifnxm7RJB25RG++8bZ1RycJLL/6xmvXc
 u8ejZNHOkpZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZjI1UhGhnkph/08EjdN0PbP
 n3Poxc1Ndb6bredc2LR4i2hVj+mMJycZGfb5KoXvrJq+fdGnK+LJ6YcM9y/Q+PPTvDG5Zm+v9EX
 H1fwA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

pfn_to_online_page() will only succeed on some PFNs within the same
section, not necessarily all. Let's make that clearer.

While at it, rephrase it to "Allow inspection of".

Acked-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/proc/page.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index f90e1030825e9..6aa99e42ec222 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -31,10 +31,9 @@ static inline unsigned long get_max_dump_pfn(void)
 {
 #ifdef CONFIG_SPARSEMEM
 	/*
-	 * The memmap of early sections is completely populated and marked
-	 * online even if max_pfn does not fall on a section boundary -
-	 * pfn_to_online_page() will succeed on all pages. Allow inspecting
-	 * these memmaps.
+	 * If max_pfn does not fall on a section boundary, pfn_to_online_page()
+	 * can succeed on PFNs beyond max_pfn within the same section. Allow
+	 * inspection of these memmaps.
 	 */
 	return round_up(max_pfn, PAGES_PER_SECTION);
 #else

-- 
2.43.0

