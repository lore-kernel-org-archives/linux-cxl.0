Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BE13F7A83;
	Tue, 17 Mar 2026 16:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766675; cv=none; b=EBvT/ncAf2MRD2QWE+5zKl5c9YEZvewLSR6xCRH/sMwhFpj4syTr3ZW4l0u9cziEdz40N34T4h5ybnZl202AmtelV5niRO2xuX7PQi1T7Lg5IbJsrX7lp7QovCJGxZhXmkXOUjGyleNkp/jlolVLM/fggeDPlwWnwhEnH3LqpR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766675; c=relaxed/simple;
	bh=0l6Twm5fWAYc2kE+D5nyqi/o8R2cJncgC9qwk29875U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxGjZST8ihE3ib5UNbuHKv9HDb5Bufwfzgo5lYi3IWWBccj/PRg7shYaH5Mz0FwgDe0stHw1ST5lWx1LxfYyBwa27d+tpLSscFboO4h+HFhgfNlkV227lWVjkagXk02KY1LqSsWEmM5Sck1alZ/g9LlrteWZL/Ldu/fUbOntSJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=is7iAYXq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="is7iAYXq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8092C19424;
	Tue, 17 Mar 2026 16:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773766675;
	bh=0l6Twm5fWAYc2kE+D5nyqi/o8R2cJncgC9qwk29875U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=is7iAYXqxhS295qB9qkyZKPyw/TDgW7GIBe8C1dgMEt3C0lFDzv9TfnIEuVRja4Ch
	 7Xh8nS2EDRCWYaK9cudk67IevARAf1HyKcfHzzIeECWQPewhL8isv1LtlmlL6KWuEU
	 F+/M4tJxfdZKbyqcSQySKCaUigGH8dJuFn5fzUPMUZV0ORHmUP5xNwicF4xEzZvPWd
	 rYMbjTGPtoD0JjPw9CyUsnOhXFnnqF/VkMhn+7Ytrq+7IYyPj5UqutKohLv1RynPSx
	 GlOKUGD2MjGkRjjJRfdzfSpAWjX3qoyrZavoUwT08vtLhfFr3FSBPvx8z2uWOHX6n2
	 WwrmLlEfTWW0g==
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
Subject: [PATCH 13/14] mm/sparse: move __section_mark_present() to internal.h
Date: Tue, 17 Mar 2026 17:56:51 +0100
Message-ID: <20260317165652.99114-14-david@kernel.org>
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

Let's prepare for moving memory hotplug handling from sparse.c to
sparse-vmemmap.c by moving __section_mark_present() to internal.h.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/internal.h | 9 +++++++++
 mm/sparse.c   | 8 --------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index bcf4df97b185..835a6f00134e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -987,6 +987,15 @@ static inline void sparse_init_one_section(struct mem_section *ms,
 	ms->section_mem_map |= SECTION_HAS_MEM_MAP | flags;
 	ms->usage = usage;
 }
+
+static inline void __section_mark_present(struct mem_section *ms,
+		unsigned long section_nr)
+{
+	if (section_nr > __highest_present_section_nr)
+		__highest_present_section_nr = section_nr;
+
+	ms->section_mem_map |= SECTION_MARKED_PRESENT;
+}
 #else
 static inline void sparse_init(void) {}
 #endif /* CONFIG_SPARSEMEM */
diff --git a/mm/sparse.c b/mm/sparse.c
index 6f5f340301a3..bf620f3fe05d 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -161,14 +161,6 @@ static void __meminit mminit_validate_memmodel_limits(unsigned long *start_pfn,
  * those loops early.
  */
 unsigned long __highest_present_section_nr;
-static void __section_mark_present(struct mem_section *ms,
-		unsigned long section_nr)
-{
-	if (section_nr > __highest_present_section_nr)
-		__highest_present_section_nr = section_nr;
-
-	ms->section_mem_map |= SECTION_MARKED_PRESENT;
-}
 
 static inline unsigned long first_present_section_nr(void)
 {
-- 
2.43.0

