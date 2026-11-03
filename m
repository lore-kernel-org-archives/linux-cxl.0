Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.103
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793675316;
	b=mYZ8pWj7Z4jjHP14aEFr1riUmayrrjlgqsO4JjbPIcNiGL3u0lX4YRny/i/kTbiru5sO
	 xQVOO+ibHbF+gwmLAE7em2vW+q7rCPI14+MUNaFWqSlyECJjWX3o0DTNIiyCwLjQmVq4F
	 lFoCvX+5Md0W1B0V0iMgjEwopsolaBcY28L3I3RtXYnC8cqTN+j116+ZSoyYg3p2RC2xG
	 IsAskhN3q2uB90MwFC35qDxa+SN7pPTQxCA2Kvcd2Qx7mduKX2qJ9ttwu7ucZqseVmIl8
	 sXyLboP7XXzPqcVGJCXOKBH7h8xbHNHYNcayC/dCwySfNZeggiuaYMpXy8dgZoeU8zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793675316;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TcMB+7TMi2bLazC/QSSJVb+dN6unmraBocObaaHDrh4=;
	b=3Og9KPCmoG5s8HIAWcnMrWoWi7bw5XlYpKDW9+KdBQDIspdJ9Czb9td7f4epG7Nh2jXK
	 +PdCkoKCUwDVvHnNXiXmlHiHHag2+eY6BEodl6Px+SuBrlTDF/nqN9E5i7KimcRK38gvx
	 lEvh6YttKir1odJevto8smlDqXynQcbbIrRzIB8yhPr4RfkMqHEg8CCMetU2cNVkz+hPW
	 KYnYiNLQcJJNwZyEPtL7c9I2w+cTNZ2oqjogOBH5TpyMpEYe8mbBtzUSJCC2/U+vyqTd2
	 MBdIBCukO7hUSlYWiHDM0EwAqna6vH1cxvOaZ1tPhxXHdFhg6m6LvvLW/hiB0C2nh7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BmsTYcpv;
	arc=none smtp.remote-ip=95.215.58.103
Received: from mta1.migadu.com (out-103.mta1.migadu.com [95.215.58.103])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03342606A32E
	for <linux-cxl@vger.kernel.org>; Tue,  3 Nov 2026 03:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03342606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BmsTYcpv
X-Envelope-To: linux-cxl@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9TIi4e+jhWvSVLJqdtmuDmhXX3FHNuF+HLGG6Up3ljY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793675313; v=1; x=1794280113;
 b=BmsTYcpvBcL0jj9GzgWU7lQFWGvWOOXuL/EeT7HVmdXH9kJNUYlwsT0yiAkv3jXqQ8HbdXqg
 76dtaf2657lnh48AYtZ4MG3C94KqUFc67F7Lkl28tlNkA0qIjClaPgI/6vv2bTbzLgVteKC0R7x
 TCDlCyxCeGL1Nbq3QpQwgKvQ=
X-Envelope-To: linux-cxl@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 59608abf10f0d8e0;
	Tue, 03 Nov 2026 03:08:32 +0000
X-Mizu-Trace-ID: 59608abf10f0d8e0
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	ljs@kernel.org,
	kasong@tencent.com,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kees@kernel.org,
	peterz@infradead.org,
	jannh@google.com,
	pfalcato@suse.de,
	hughd@google.com,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	willy@infradead.org,
	jack@suse.cz,
	ziy@nvidia.com,
	lance.yang@linux.dev,
	riel@surriel.com,
	harry@kernel.org,
	apopple@nvidia.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	usama.arif@linux.dev,
	kas@kernel.org,
	matthew.brost@intel.com,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	osalvador@suse.de,
	minchan@kernel.org,
	muchun.song@linux.dev,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	youngjun.park@lge.com,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	jgg@ziepe.ca,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	josef@toxicpanda.com,
	stable@vger.kernel.org,
	usama.anjum@arm.com
Subject: Re: [PATCH v3 32/47] mm/mremap: fix moving PUD leaves
Date: Tue,  3 Nov 2026 11:08:26 +0800
Message-ID: <20261103030826.79600-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261031-fixes_core-v3-32-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-32-d6437171ecc3@kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Sat, Oct 31, 2026 at 10:40:01AM +0100, David Hildenbrand (Arm) wrote:
>From: Josef Bacik <josef@toxicpanda.com>
>
>pud_none_or_clear_bad() only really works on page tables. PUD leaves
>confuse the check and make us clear the page table entry and print a
>warning.
>
>Since commit aed877c2b4257 ("device/dax: properly refcount device dax pages
>when mapping"), this also leaks device-DAX folio references, mapcounts
>and RSS accounting, resulting in "Bad rss-counter state" warnings on exit.
>
>Allow PUD leaves in get_old_pud(). If a PUD leaf cannot be moved as a
>whole or the move fails, split it. This unmaps it with proper accounting
>instead of treating the leaf entry as a PMD table.
>
>Keep using pud_trans_huge() for now, in the future this code should be
>cleaned up to just check for PUD leaves.
>
>Fix generated by an LLM and sent by Josef Bacik in private.
>
>Fixes: a00cc7d9dd93 ("mm, x86: add support for PUD-sized transparent hugepages")
>Cc: stable@vger.kernel.org
>Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>[ david: fallthrough after splitting ]
>Reviewed-by: Pedro Falcato <pfalcato@suse.de>
>Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---
> mm/mremap.c | 9 ++++-----
> 1 file changed, 4 insertions(+), 5 deletions(-)
>
>diff --git a/mm/mremap.c b/mm/mremap.c
>index 91f0865f6aeea..1237718848f5c 100644
>--- a/mm/mremap.c
>+++ b/mm/mremap.c
>@@ -87,7 +87,7 @@ static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
> 		return NULL;
> 
> 	pud = pud_offset(p4d, addr);
>-	if (pud_none_or_clear_bad(pud))
>+	if (!pud_trans_huge(*pud) && pud_none_or_clear_bad(pud))
> 		return NULL;
> 
> 	return pud;
>@@ -847,11 +847,10 @@ unsigned long move_page_tables(struct pagetable_move_control *pmc)
> 		if (!new_pud)
> 			break;
> 		if (pud_trans_huge(*old_pud)) {
>-			if (extent == HPAGE_PUD_SIZE) {
>-				move_pgt_entry(pmc, HPAGE_PUD, old_pud, new_pud);
>-				/* We ignore and continue on error? */
>+			if (extent == HPAGE_PUD_SIZE &&
>+			    move_pgt_entry(pmc, HPAGE_PUD, old_pud, new_pud))
> 				continue;
>-			}
>+			split_huge_pud(pmc->old, old_pud, pmc->old_addr);

Right, copy_vma() already sets up the file and offset at the new address,
so we can let subsequent faults rebuild the mapping.

No need to build a PMD table just for the move ;)

Reviewed-by: Lance Yang <lance.yang@linux.dev>

> 		} else if (IS_ENABLED(CONFIG_HAVE_MOVE_PUD) && extent == PUD_SIZE) {
> 			if (move_pgt_entry(pmc, NORMAL_PUD, old_pud, new_pud))
> 				continue;
>
>-- 
>2.43.0
>
>
