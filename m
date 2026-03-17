Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411653BFE59;
	Tue, 17 Mar 2026 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766629; cv=none; b=d3I5/kHbWK4EykngiG16XrDkW0ALpgVzqSrEMn7dT9fVDI6Xuz9+1XU6ul4NygkNPtINTQVGqLcWR3i6dPQh7C3YhblOCmO94zH+/YJ80yR3RzY8g+E89IVEB+ek3q7RNzaMfVJvqGzPdvlnawRVtZJn0jz5NR6xWgTdnH35Q+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766629; c=relaxed/simple;
	bh=kzrTKM3vlrjilIM3sQvWnlvy3VBosxv9H7E3QmkzRlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrei39pgORKEDGCQQimSygmKq4bQ0XRNlOVm6M3uJPsshoXMgtmwh8PkQ8u71nEoWhM13qafP58Cs8LFW3mJ4YjMYQ4+Zqh/4z7SiuyO3tAH/Z5um0f+QZzjsS3TFIhsQNxi6dL91TbHs3sDXLPPHf++V9WRsQeYqDkWuxvRhQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHskvkxx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHskvkxx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62C5C2BCAF;
	Tue, 17 Mar 2026 16:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773766629;
	bh=kzrTKM3vlrjilIM3sQvWnlvy3VBosxv9H7E3QmkzRlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QHskvkxx07TedlGeSfCg3qWrbY+3uik23yxdt4OBz7Ty8WtpRTbVRWFH27KQzM7ih
	 DMHCC6mbfKZd5XFSR4idzYoIP8JoBJXzxxedXgJ1qEdJo62bf9cMlJirqoQ35/wGrk
	 k928oEnRTJNB1+nuXT0TnCr036BPdr782+F1/qr5oU3luAsNCEI4oy7y9gVY+ddcv/
	 aguPC8Ef0KfVcO0aD/qWl0X6tfm45jxxrCfboq0PgYA/OdDH9+M1tgRCvlLpH3G3pF
	 Vo5vhQmp/XBajQRU26TkQBt1sGRmzjjQtpQGDg8Bm6/IRpRQJUX0gESRAuFhynz+x1
	 3xzcWj1mRkogQ==
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
Subject: [PATCH 02/14] mm/sparse: remove WARN_ONs from (online|offline)_mem_sections()
Date: Tue, 17 Mar 2026 17:56:40 +0100
Message-ID: <20260317165652.99114-3-david@kernel.org>
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

We do not allow offlining of memory with memory holes, and always
hotplug memory without holes.

Consequently, we cannot end up onlining or offlining memory sections that
have holes (including invalid sections). That's also why these
WARN_ONs never fired.

Let's remove the WARN_ONs along with the TODO regarding double-checking.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/sparse.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index dfabe554adf8..93252112860e 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -638,13 +638,8 @@ void online_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
 		unsigned long section_nr = pfn_to_section_nr(pfn);
-		struct mem_section *ms;
-
-		/* onlining code should never touch invalid ranges */
-		if (WARN_ON(!valid_section_nr(section_nr)))
-			continue;
+		struct mem_section *ms = __nr_to_section(section_nr);
 
-		ms = __nr_to_section(section_nr);
 		ms->section_mem_map |= SECTION_IS_ONLINE;
 	}
 }
@@ -656,16 +651,8 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
 		unsigned long section_nr = pfn_to_section_nr(pfn);
-		struct mem_section *ms;
+		struct mem_section *ms = __nr_to_section(section_nr);
 
-		/*
-		 * TODO this needs some double checking. Offlining code makes
-		 * sure to check pfn_valid but those checks might be just bogus
-		 */
-		if (WARN_ON(!valid_section_nr(section_nr)))
-			continue;
-
-		ms = __nr_to_section(section_nr);
 		ms->section_mem_map &= ~SECTION_IS_ONLINE;
 	}
 }
-- 
2.43.0

