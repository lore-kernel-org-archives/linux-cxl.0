Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174DE568FD7;
	Wed,  9 Sep 2026 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960939; cv=none; b=NwepA4ijb24nWze/neLKAc60Q9GLdk+ojnYpO2fa0nF3/tDbF+XJEmnHyAuQ4+fHHvaq03g7IKacybUrQmNFTaE/nmAA7zhgHzkGP6tHk/MQxeZtC7tu8/tJqwsiVb8RsdLe0WgySX48Eybpn+pE0LVG1S3+56UVf0OY5fC3hSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960939; c=relaxed/simple;
	bh=elFTRUDefqtCYtZsGvjwDH8AmlVM1CM5zJvcDj1v4k4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oU55aaH8fKhwXiq77HSlYazLh1W4Z847XkQtNPPU+UxslB67obxnSb2zbvkBGXVOOBi5CO7lk5JjsV2Li+qVnZ7kK/iFBG65Ll1rsqUaWCYD0Vw4orudlOLe6QkEClkj2SmfZzuokSM3r43e1IOOEwcO46pptUNXGcvUNcdXQdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIGyAPDE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIGyAPDE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50331F00A3F;
	Wed,  9 Sep 2026 13:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960937;
	bh=H1aBakRnV2iGUhIOAlr/N+D/FmN54uy58dpZhC/x4NY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VIGyAPDEKWd20kwvIUqot+xQIE1FKSVvgNyZ/BCaSBYBZ4/l7RmtwfUKsLtebNCZC
	 KUyOuqdC7+6aDRTaV1D3LxHQ9jcb8ulJWjSiHbeVDIaV9LTxKQtl2kvyiCOKuiOd0B
	 Rl5dwNfAArIAw6DLBbH8KfEbMCs1DGQKausO5zq8k/HjKGOfi9RcFBbS5TrbaolCAp
	 bgFnI7XplUYPs4LONuG6s/f7TGDl+N+VbjGs2+CKIMZSFpZ6igjtJ9E7jJs+bJJ+yy
	 PXooZ4itjy+6yrPhTiIiI8A9nIgqzsg18kC/pgJBbg/o6baV8bGpycq2hlzZs2JIsO
	 OMjP5QzdY7mLg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 09 Sep 2026 15:33:04 +0200
Subject: [PATCH 11/12] fs/proc/page: clarify comment in get_max_dump_pfn()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-b4-sparsemem_cleanups-v1-11-008fc8d579fe@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=998; i=david@kernel.org;
 h=from:subject:message-id; bh=elFTRUDefqtCYtZsGvjwDH8AmlVM1CM5zJvcDj1v4k4=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIWJphmno7ZtaEjffuh/wH302o/Tb+27Zvs1DvC0Q0q6
 ftjn2RrdJSyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjCR6NmMDMtvbK71sotI4+J/
 o3Jcb+/Hh59sA5ctevyKp9qXn6c0LZPhD6fr25qaNd2XSyMTtt5Kf7j1029HxWYPp81f1I45Zey
 8yQwA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

pfn_to_online_page() will only succeed on some PFNs within the same
section, not necessarily all. Let's make that clearer.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/proc/page.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 260772b20bd99..6856ff3e3cf28 100644
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
+	 * inspecting these memmaps.
 	 */
 	return round_up(max_pfn, PAGES_PER_SECTION);
 #else

-- 
2.43.0

