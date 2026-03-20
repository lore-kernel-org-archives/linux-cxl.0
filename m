Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D9C3358A7;
	Fri, 20 Mar 2026 22:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774044832; cv=none; b=R9riHJlsxO/QRK7JbhgVMMtzoKA/DHrHVxUeNhDbGxOw66pLJ7j/TK7gPdpVI4bJFKUmKeqe0W3ALS9p5WGp5WFoSJso65RpfLs0sGQNtH7vdU9s2Atw2PGmefAeDidPBOk/PvXelS6aRZKyaAybH76NfdlGM9ti2ROPfoIUD2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774044832; c=relaxed/simple;
	bh=XBR2EPoKpXeNjq1txkLBTh/DgkCJHtoC1PlnginQxtA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N5XsaxTEW5H7FruIhvRf8p9ruUF/0GiTPKGzHfe3Fmj/FLs7hYC2yiDBNWF0/i/A4n0x5rUNL8mxm99ni+NM2lMtHsvBBYG08Uh8aNOWqya0UsC8g9x3/pvM8JQxGzJBVnqpDyLd8MzZjpthlP7AgIoTeMyyBmtCjOVrL/l3YPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tInuY984; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tInuY984"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECA5C2BC87;
	Fri, 20 Mar 2026 22:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774044832;
	bh=XBR2EPoKpXeNjq1txkLBTh/DgkCJHtoC1PlnginQxtA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tInuY984yzdIEuaZJXpPPAPu/jx6o88MxmPXqoEhhmH9XAKSJMbP9JmVw7KDYMdYI
	 cYFzrC3mXShUxMELrJRAOb8iFHCYRFYnMXADOypUly2tPI5LhdRJAlx6Y7vIsodwEE
	 Tb8WTg9dueCXRj24fln2u12nVVjS4oL3Ny2O8BgKFv5WAfttURT/QkCV02wu1LukEt
	 +WqU5eLPOYBtokHGt2yPjG/XvcY29bKMFzXiTW0vweT3cJdrcDYhDTgUwEXHa4yEL4
	 Ov9DFUt9eHboVve5zoTrH8Bv9mnM+yD+kzQ6+YJzB4D+h8DGu8XFoU9yIoZlUTet3N
	 5V0hxSVsZnYcA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Fri, 20 Mar 2026 23:13:34 +0100
Subject: [PATCH v2 02/15] mm/memory_hotplug: remove for_each_valid_pfn()
 usage
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-sparsemem_cleanups-v2-2-096addc8800d@kernel.org>
References: <20260320-sparsemem_cleanups-v2-0-096addc8800d@kernel.org>
In-Reply-To: <20260320-sparsemem_cleanups-v2-0-096addc8800d@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Oscar Salvador <osalvador@suse.de>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
 linux-cxl@vger.kernel.org, linux-riscv@lists.infradead.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.13.0

When offlining memory, we know that the memory range has no holes.
Checking for valid pfns is not required.

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory_hotplug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 969cd7ddf68f..0c26b1f2be6e 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1746,7 +1746,7 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 {
 	unsigned long pfn;
 
-	for_each_valid_pfn(pfn, start, end) {
+	for (pfn = start; pfn < end; pfn++) {
 		unsigned long nr_pages;
 		struct page *page;
 		struct folio *folio;
@@ -1796,7 +1796,7 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 	static DEFINE_RATELIMIT_STATE(migrate_rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
 
-	for_each_valid_pfn(pfn, start_pfn, end_pfn) {
+	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
 		struct page *page;
 
 		page = pfn_to_page(pfn);

-- 
2.43.0

