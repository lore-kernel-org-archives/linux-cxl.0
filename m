Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044C9238C1E
	for <linux-cxl@vger.kernel.org>; Tue,  3 Jun 2025 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748985405; cv=none; b=CDIKPo32omOaf7H2sV3Jc1/oAjA8bPa62CFPTorDPH1SuLaveVE/L7KLmwDVTGw1PBk6CwTO9NHbhQagZ3DtGDG8GNVfcgt93T6axgevkHIhGisrTjZrtAmQrfiwzhfGmSvkdu1K1l1s5twosELxrHDbB5IOkw5oiVD6GD69m+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748985405; c=relaxed/simple;
	bh=YiuIbH1YicSvYtWptE6HogEJ1VuNCKkLtGqFeSs9x1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=TsBkgbaeIcO3Nu3VepOP0z9cO5Qt+zDmO3FPE1M9s7vA4R5BW0tRloU+lEfor3DvECf66fYQjeBMDUtQzjt1VZPyOmhuwbh6jOR8shhBbvK1PhPy/dNxnZ4BP0rzjAUkTCT9oRSI6YTY8NAbdcBcI2gdsl8LgLBGa8gF7jCEV00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aaef0icm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aaef0icm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748985402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=odfwWYBsPrR2NiRATGhjsNB6SzvCCkIpMqMTiNvN67g=;
	b=aaef0icm46ypIjGpWeHqAXOb3sU2E2PgDwjhcDf4+mnj2dMtms/eGZqTpz8ZrcV4P6bjV6
	/QysUf6/6euZfOm/NBiwxl8PKLUV2mAQaTrtMjMQS/UgO1AqLAGqP0Ojyg6UGoGiyGc4Fa
	NhpTNurshsKqXF/RgyPG2JsW8r44uBw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-GKi_hClIONC7WBrtiPl82g-1; Tue, 03 Jun 2025 17:16:42 -0400
X-MC-Unique: GKi_hClIONC7WBrtiPl82g-1
X-Mimecast-MFC-AGG-ID: GKi_hClIONC7WBrtiPl82g_1748985401
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d3f03b74so19530395e9.3
        for <linux-cxl@vger.kernel.org>; Tue, 03 Jun 2025 14:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748985401; x=1749590201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odfwWYBsPrR2NiRATGhjsNB6SzvCCkIpMqMTiNvN67g=;
        b=S8p8QNcdImAtD8CzO0wtYn95nPRS33Z/gkFW7oH4wGaNKVvdb+MFfK8jLcJQ0hWOTd
         7j/l6B/xkgge7iNEohrqrxPOECjkYHqdYEMWyoYiuUVK4F5eyKY7CxvCl00Awv39K8BA
         V/yX0lPiQETAR9Oy03CkJQurNXT2ld/Vg6cbfLcZMEwIXQQ8zk9d+1DdkOqmvEfvoXoE
         jH/JuNuSykF866pWX75EdAKk1YaTLGknMpqKHxZbySt/G+QparmJIbKpY6GriJxlb0rE
         lK58Nhsw3e8asonR5CB53nikV8EY8oeeWHUIxRkbQGszJKDbam8Zf22B7omq7/yMWDF+
         Qu7w==
X-Forwarded-Encrypted: i=1; AJvYcCVnrfcvR0xh+x+RxqotIwZO+Bdv64yNTeIBL8m7O0eGhnqUBuEYFBjY9RNBb3Zgohyh5+IB+4Y2zQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ3zYw0haZrJRNxEmsbpodNYu8KQrijiDgLyJmEeIXhuPU8wR8
	eGOhV/5blp8oUWSOUeUPJQvoWmog798c/5a3vFtA+izlrg38zZbFn5AqLenN0lgsEDjJb4z7Ukv
	Of6gGRGlMUOD1P5LZHMm+tjFx1j4H3Z0kmijjkRF4Flwa2ue5XO3CpE6rvSHekg==
X-Gm-Gg: ASbGnctB31IPtV622+zWtRM6lXzJk1uiq12/Z6Wb1U8UBeYjD4Ev7awtAeydFYQ/4cV
	aNRYvtNCKoKfJbii9PMP+03zAvEOESIEpeIymuk0w8H+50AqwBHKxAJiXVFtfBtXjrlD79SCHd5
	dGRx6oJ5WncNfinDlIpYnVQ3EMgwYa/+Sfdu+X5BU0YGMmT2cw7ienKIC1Tr1RjCLB9txblyT56
	JbrSKmYSgfXyo8q4EKD8CYlxHbgi0VEc0n936+DWmhAoZJJMARjm9Mvp+9Yt95GgwFN+TESDTzy
	Jwl6YIEm7CFverEqrQmnzBKfy9ldeSaP22L2dL9zwGN+rev+4BHRIAbNcl6kqSvJTkMcUS8G
X-Received: by 2002:a05:600c:8b53:b0:450:d386:1afb with SMTP id 5b1f17b1804b1-451f0a77343mr1734575e9.9.1748985400738;
        Tue, 03 Jun 2025 14:16:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU0uCWB4mipEA75Rgm+06vlkE4Cg+21PNhH9TeTgvc29mcVV+kilTSDzcCPjrD9lEWlpu3Rw==
X-Received: by 2002:a05:600c:8b53:b0:450:d386:1afb with SMTP id 5b1f17b1804b1-451f0a77343mr1734345e9.9.1748985400273;
        Tue, 03 Jun 2025 14:16:40 -0700 (PDT)
Received: from localhost (p200300d82f0df000eec92b8d4913f32a.dip0.t-ipconnect.de. [2003:d8:2f0d:f000:eec9:2b8d:4913:f32a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a4efe5b96fsm19175970f8f.8.2025.06.03.14.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 14:16:39 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alistair Popple <apopple@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v1 2/2] mm/huge_memory: don't mark refcounted pages special in vmf_insert_folio_pud()
Date: Tue,  3 Jun 2025 23:16:34 +0200
Message-ID: <20250603211634.2925015-3-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603211634.2925015-1-david@redhat.com>
References: <20250603211634.2925015-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wO59_Ys9NfZb8TNlbtTLnr4KIT9VclQfy9b1jQpdTAo_1748985401
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Marking PUDs that map a "normal" refcounted folios as special is
against our rules documented for vm_normal_page().

Fortunately, there are not that many pud_special() check that can be
mislead and are right now rather harmless: e.g., none so far
bases decisions whether to grab a folio reference on that decision.

Well, and GUP-fast will fallback to GUP-slow. All in all, so far no big
implications as it seems.

Getting this right will get more important as we introduce
folio_normal_page_pud() and start using it in more place where we
currently special-case based on other VMA flags.

Fix it by just inlining the relevant code, making the whole
pud_none() handling cleaner.

Add folio_mk_pud() to mimic what we do with folio_mk_pmd().

While at it, make sure that the pud that is non-none is actually present
before comparing PFNs.

Fixes: dbe54153296d ("mm/huge_memory: add vmf_insert_folio_pud()")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 15 +++++++++++++++
 mm/huge_memory.c   | 33 +++++++++++++++++++++++----------
 2 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0ef2ba0c667af..047c8261d4002 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1816,6 +1816,21 @@ static inline pmd_t folio_mk_pmd(struct folio *folio, pgprot_t pgprot)
 {
 	return pmd_mkhuge(pfn_pmd(folio_pfn(folio), pgprot));
 }
+
+/**
+ * folio_mk_pud - Create a PUD for this folio
+ * @folio: The folio to create a PUD for
+ * @pgprot: The page protection bits to use
+ *
+ * Create a page table entry for the first page of this folio.
+ * This is suitable for passing to set_pud_at().
+ *
+ * Return: A page table entry suitable for mapping this folio.
+ */
+static inline pud_t folio_mk_pud(struct folio *folio, pgprot_t pgprot)
+{
+	return pud_mkhuge(pfn_pud(folio_pfn(folio), pgprot));
+}
 #endif
 #endif /* CONFIG_MMU */
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f9e23dfea76f8..7b66a23089381 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1629,6 +1629,7 @@ vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio,
 	pud_t *pud = vmf->pud;
 	struct mm_struct *mm = vma->vm_mm;
 	spinlock_t *ptl;
+	pud_t entry;
 
 	if (addr < vma->vm_start || addr >= vma->vm_end)
 		return VM_FAULT_SIGBUS;
@@ -1637,20 +1638,32 @@ vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio,
 		return VM_FAULT_SIGBUS;
 
 	ptl = pud_lock(mm, pud);
-
-	/*
-	 * If there is already an entry present we assume the folio is
-	 * already mapped, hence no need to take another reference. We
-	 * still call insert_pfn_pud() though in case the mapping needs
-	 * upgrading to writeable.
-	 */
-	if (pud_none(*vmf->pud)) {
+	if (pud_none(*pud)) {
 		folio_get(folio);
 		folio_add_file_rmap_pud(folio, &folio->page, vma);
 		add_mm_counter(mm, mm_counter_file(folio), HPAGE_PUD_NR);
+
+		entry = folio_mk_pud(folio, vma->vm_page_prot);
+		if (write) {
+			entry = pud_mkyoung(pud_mkdirty(entry));
+			entry = maybe_pud_mkwrite(entry, vma);
+		}
+		set_pud_at(mm, addr, pud, entry);
+		update_mmu_cache_pud(vma, addr, pud);
+	} else if (pud_present(*pud) && write) {
+		/*
+		 * We only allow for upgrading write permissions if the
+		 * same folio is already mapped.
+		 */
+		if (pud_pfn(*pud) == folio_pfn(folio)) {
+			entry = pud_mkyoung(*pud);
+			entry = maybe_pud_mkwrite(pud_mkdirty(entry), vma);
+			if (pudp_set_access_flags(vma, addr, pud, entry, 1))
+				update_mmu_cache_pud(vma, addr, pud);
+		} else {
+			WARN_ON_ONCE(1);
+		}
 	}
-	insert_pfn_pud(vma, addr, vmf->pud, pfn_to_pfn_t(folio_pfn(folio)),
-		write);
 	spin_unlock(ptl);
 
 	return VM_FAULT_NOPAGE;
-- 
2.49.0

