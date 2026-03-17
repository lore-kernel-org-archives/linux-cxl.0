Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6243BFE59;
	Tue, 17 Mar 2026 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766625; cv=none; b=S2zvBMlSBlVnh31JI6z6UZa9yIx3RJDQTzHhJRycTne07ZSp7MK3ZvcPeU+SPJitbp2dPvXX+rnVC+LCFRnKdRRAwTjgX1Y4cHD1oMCLFqCxYiyLqXQdlUkd9nMVhjNf4Ry7ZlVBujoi+9uL8hxNDeil7TTR186k9tDJ2QJkY+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766625; c=relaxed/simple;
	bh=enaf/WHlxY0+rUz/sR0jg/TQSIcygwkranNM2RjUkME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=We7IN/m8lyhTeeUa3ItTdssl/Z+HEFLhS6suNEVhKqEyUuc320VMJ9EpajmG9GieHWSboyz8SnEyOdHaj+1whmM6HV/hXwfbBWHGKDcvDQ+1vI9CWbJtYcJ5fLDZAEWlnk8ZaEBoZgEb77aKhqh+0trj3VUtIGB31vWCz/x1oxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LO80KQZL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LO80KQZL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB83C4CEF7;
	Tue, 17 Mar 2026 16:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773766625;
	bh=enaf/WHlxY0+rUz/sR0jg/TQSIcygwkranNM2RjUkME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LO80KQZLO7/y5oXQFwtwUJ0/a9RhLfjeBQuSn8qocvIykFu/p0BLR7KGJKb2A5JqP
	 PPoruzqnYUL8+CG8tw0kc6SqV14FbtFCEBTdKN1cuyY2OkyZfa8sXIAtPRxszTOJdX
	 cFa/uDAO+FzUH/CSM3+jM2HdbYBNvbFkmuw6iozaq8GeqCFVitPnVz18N35lN7/188
	 6MlhgdwanmY0jnhsl+jgHYJNmaVnUqb1Oggk6TLSnA6tgghgwlH/1bRQcUKaJJdkU5
	 IjedjUKfm3/olQK+OP4IaqHxQetBGgX59nK99evDpDoCe5igVI6ojJkVhNSNB+0mjh
	 JvE7X95S26utA==
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
Subject: [PATCH 01/14] mm/memory_hotplug: remove for_each_valid_pfn() usage
Date: Tue, 17 Mar 2026 17:56:39 +0100
Message-ID: <20260317165652.99114-2-david@kernel.org>
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

When offlining memory, we know that the memory range has no holes.
Checking for valid pfns is not required.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory_hotplug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 86d3faf50453..3495d94587e7 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1746,7 +1746,7 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 {
 	unsigned long pfn;
 
-	for_each_valid_pfn(pfn, start, end) {
+	for (pfn = start; pfn < end; pfn++) {
 		struct page *page;
 		struct folio *folio;
 
@@ -1791,7 +1791,7 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 	static DEFINE_RATELIMIT_STATE(migrate_rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
 
-	for_each_valid_pfn(pfn, start_pfn, end_pfn) {
+	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
 		struct page *page;
 
 		page = pfn_to_page(pfn);
-- 
2.43.0

