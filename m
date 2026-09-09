Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B83566C5C;
	Wed,  9 Sep 2026 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960864; cv=none; b=qUjgY2hDBSStJY+2bK5wZlFQVwyMdGnV5Rtx35nnuClYcHJk7YWMLc370mvuK4bJPADah1Ac/OeWid+9fN939jWWo61VpKlR8cxkxcYTOQyHCfksucZ+K3un/58Qalr0RVP5Rs3DoKoCytbOaOJBV4Y6/ZWESxou8KJ7itYHOPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960864; c=relaxed/simple;
	bh=f5vfO3saF7PVVCMfIchqE3Iy0rnVBSpES3AbK2/MfAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=paYdgqg0jDqUfcVwwxa4PflALHcYH3cQ+zkGQdhr3EYIV4L7iPymSyzSPU85+nYLCHgYqMXSlznQVQRpk6ZWFBRnIlzcY7Zw9Cr/EaaOWjBrpn3rwzGFoVCstKbV/MSj7/D/Ag6nNeirzvIYpv0hdBACkNRHLaRuN1U8cT33vPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwklD36q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwklD36q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A141F00A3D;
	Wed,  9 Sep 2026 13:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960862;
	bh=wfXJR6x8v03fXUe0TqSKHDJiGieSJgGhDryfxeyRA9M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PwklD36qGjyYvFWApNCpE42qV3e3BOR2Kgo+jF5pn5Hgu//Dcgoq7Wm0kns9g21k8
	 ysL1SVlmIVtAuPqPttzOcHyVslyAAR/JaCZy6cXEpREMiKofKDuzHdP65D77cMfZcT
	 YixC8alIt/gUhMNsV8Kf563LegysoB1pqb1TEirBAYYW2igJPFScR4u61DqjA0zaVk
	 1ZutKHppQr1pIfljD22DLrSam3J9cYQ7Cu7mGLjZe6J4ByirBjg4gf1QOvSbzeUXXe
	 ydABST5FK+9hcfE1KgrhbZUqVmqaZQadLoEakZY8OCFoJBQZhq2FJUv+MH16EUVCEF
	 tYK2C8MitVVfA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 09 Sep 2026 15:32:56 +0200
Subject: [PATCH 03/12] mm/sparse: move initialization of section metadata
 to sparse_metadata_init()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-b4-sparsemem_cleanups-v1-3-008fc8d579fe@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2420; i=david@kernel.org;
 h=from:subject:message-id; bh=f5vfO3saF7PVVCMfIchqE3Iy0rnVBSpES3AbK2/MfAc=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIWJmjH7Uza+6Et22NRz/V4J2bhbw/eh/3xsNlWveUgt
 0nCVqaHHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAExEwYThN9ssvqU62d2f3le9
 nfYr/OaM3bfvWay+ternsu2mjSrVCWUM/6wvHXtrcutno3dRlaqEZ5u6U0riDf6AOd+iFh+Okpi
 3iwsA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Let's move the code responsible for initializing sparse metadata (usemap,
memmap) into a helper. Cleanup the variable while at it (e.g.,
"map_count").

Drop the rather obvious code comments.

No functional change intended.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/sparse.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 36e3d854febc5..a85a9c3840f6c 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -257,38 +257,39 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 	}
 }
 
+static void __init sparse_metadata_init(void)
+{
+	unsigned long start_section_nr = first_present_section_nr();
+	int nid_begin = sparse_early_nid(__nr_to_section(start_section_nr));
+	unsigned long section_nr, nr_sections = 1;
+
+	for_each_present_section_nr(start_section_nr + 1, section_nr) {
+		const int nid = sparse_early_nid(__nr_to_section(section_nr));
+
+		if (nid == nid_begin) {
+			nr_sections++;
+			continue;
+		}
+		sparse_init_nid(nid_begin, start_section_nr, section_nr, nr_sections);
+		nid_begin = nid;
+		start_section_nr = section_nr;
+		nr_sections = 1;
+	}
+	sparse_init_nid(nid_begin, start_section_nr, section_nr, nr_sections);
+}
+
 /*
  * Allocate the accumulated non-linear sections, allocate a mem_map
  * for each and record the physical to section mapping.
  */
 void __init sparse_init(void)
 {
-	unsigned long pnum_end, pnum_begin, map_count = 1;
-	int nid_begin;
-
 	if (compound_info_has_mask()) {
 		VM_WARN_ON_ONCE(!IS_ALIGNED((unsigned long) pfn_to_page(0),
 				    MAX_FOLIO_VMEMMAP_ALIGN));
 	}
 
-	pnum_begin = first_present_section_nr();
-	nid_begin = sparse_early_nid(__nr_to_section(pnum_begin));
-
-	for_each_present_section_nr(pnum_begin + 1, pnum_end) {
-		int nid = sparse_early_nid(__nr_to_section(pnum_end));
-
-		if (nid == nid_begin) {
-			map_count++;
-			continue;
-		}
-		/* Init node with sections in range [pnum_begin, pnum_end) */
-		sparse_init_nid(nid_begin, pnum_begin, pnum_end, map_count);
-		nid_begin = nid;
-		pnum_begin = pnum_end;
-		map_count = 1;
-	}
-	/* cover the last node */
-	sparse_init_nid(nid_begin, pnum_begin, pnum_end, map_count);
+	sparse_metadata_init();
 	sparse_init_subsection_map();
 	vmemmap_populate_print_last();
 }

-- 
2.43.0

