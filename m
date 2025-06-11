Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559E227AC57
	for <linux-cxl@vger.kernel.org>; Wed, 11 Jun 2025 12:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749643638; cv=none; b=KQxK3zJQ0REEkQdRRVPN4kTAHagi+3IjtT9AakDCpTDKJQ3MaZRA0C15/ydAVGMlboMJLQqdBlRtR4J/8JNGzaYLuccqoaa+4ALoT5SZGFHgZWf2r4bT8WFcN1p8VmXqNHozThUVg8dUYgXxKGJxGobEgHzpYQlaUAYOFfoQMjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749643638; c=relaxed/simple;
	bh=lDuMcIkqdVYfT9oTqnsRg9TwWuYN2/pKXvzQU1WFu8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=TbJ8TiXQ81k7UvFju17F5/CmNOpE9iUANPlC0v9grZsJAZwVZhdm25m/udz1zsRA5qherufGxHa0y3vVe8oAON+mGrjtI6lbfKsbI/ck3saajV2LNLnjWX5C0EFj+uAA67hlu+22kEdNd3CHoGwlNBDRXAnC78M0sKXqrtdmBpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K1LSq7GX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1LSq7GX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749643635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UtWlysWlQBjRkoN9+CJXCvGFy/ErJq/rTFp6EVa14FI=;
	b=K1LSq7GX/U83F5Mpdf4tBC1DdyIi5onAS2QF3gFYATFb2EdV21xMN7xdhZellq66CyGYpF
	auk58mpkC7bTwna2GlUwvdSFCKYrS0YjVyL80dSYtMZiP5QMMp65LjhHeB/WYOi0RjL2a8
	+jmtobYpXyeDIzwEHXEVg5QpniHvkO4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-C21OlQz4N7mx4aHKV2hYEQ-1; Wed, 11 Jun 2025 08:07:14 -0400
X-MC-Unique: C21OlQz4N7mx4aHKV2hYEQ-1
X-Mimecast-MFC-AGG-ID: C21OlQz4N7mx4aHKV2hYEQ_1749643634
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6face1d593bso128674016d6.3
        for <linux-cxl@vger.kernel.org>; Wed, 11 Jun 2025 05:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749643634; x=1750248434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtWlysWlQBjRkoN9+CJXCvGFy/ErJq/rTFp6EVa14FI=;
        b=n+m7hVCZc/fc6fALHD8e5V7GCax6aes9BoWrC/0uJ8gjOfO44Iurk/wcagM9fzA2rD
         l2oP2AnhUB12O2gGhTm6H7NF6KUC/CGtSBf6PA+8uxwORYm3vdvSp744sjvtdrHrHQYN
         pqEO/tzhJbhzwvG4HJOejjTPijFdjyOBx8ZoNeOHSALoGyXDav2urgWpSnr4IltEJ3Vf
         o3vAeavOjv3mSkyEUyb672NVvVAZrMVjrKO7SSKrPh2hd/wAjE/hAXWDG3JphDv+1NKg
         1PacYEMRHOJONxNsABtSNpKXQX3u8pevxntaIVNsGz6ggo4JEYKFZBn36kE9qT/tLmZB
         k5bg==
X-Forwarded-Encrypted: i=1; AJvYcCVKjZbOY8/a9KudaQKkFo8KuVcF1mzaK7tD6YjuJ5I2Y2qtI1Z9CF69eGXm834d4q3n8g1dpaKB6W0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6KlO8p0GwQ/xyuMNTWHHn/M/CXM4P57hm2IShZaabGaosA3iP
	4J4DyyYXPlWmh80X8WbiAaMGaNM0yAkqOqaFl3fAPuItNLMJs/IbLDDFrSbL4vRWOupmIlq5ZtS
	pW9f/GoPXh9nl9GemKX1X20kaX1N8nil2QDWxh3Lc9QSgWxnzLGSgcFY3TbVu7A==
X-Gm-Gg: ASbGncsyQvBb1dDxv7GRdTrCTZU7FKrVObu6LZZ5JXudFT27BXTUY1Lg5kIzrZ1fJPP
	wQ0NiGUuB8ERbOMlEQx75l2x+OYEDhCLp7rCkNbd9QF9BCx5nPahR4HFI4H15mzTklSPzwunltO
	OXVqti9HV+4AWjVk0FONhMGLG7Y/fp/vVYGMBA1GNGW6yrl2y4S22csJxPJXt2Yh/gqQH9Q58YM
	qz/iV2JuMeEbTK9Va8ssHZMgmTrBSZNGQxZ6pAu2eFTTrkI6rh9kqodotCJZTCAq82o1+2skGE5
	zaIvod5qsh9XqWLBV8a5UNz6FFtpnund83I1U8Unng==
X-Received: by 2002:a05:6214:2247:b0:6fb:eff:853f with SMTP id 6a1803df08f44-6fb2d1355e8mr38204116d6.11.1749643633913;
        Wed, 11 Jun 2025 05:07:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM4p2qx6IwsF7ygt/fJLoNiy0HXlnShIRf40WhWevNTjDTOZVqQY8Q1r9EhVLBlQWkw0T8DQ==
X-Received: by 2002:a05:6214:2247:b0:6fb:eff:853f with SMTP id 6a1803df08f44-6fb2d1355e8mr38203456d6.11.1749643633381;
        Wed, 11 Jun 2025 05:07:13 -0700 (PDT)
Received: from localhost (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fb09b2a1b6sm80566356d6.100.2025.06.11.05.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 05:07:12 -0700 (PDT)
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
	Dan Williams <dan.j.williams@intel.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 3/3] mm/huge_memory: don't mark refcounted folios special in vmf_insert_folio_pud()
Date: Wed, 11 Jun 2025 14:06:54 +0200
Message-ID: <20250611120654.545963-4-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611120654.545963-1-david@redhat.com>
References: <20250611120654.545963-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AetXTjioo7k6nih8NSW5C0UlLmqg-ULDdPGUN2532ls_1749643634
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

Fix it just like we fixed vmf_insert_folio_pmd().

Add folio_mk_pud() to mimic what we do with folio_mk_pmd().

Fixes: dbe54153296d ("mm/huge_memory: add vmf_insert_folio_pud()")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 19 ++++++++++++++++-
 mm/huge_memory.c   | 51 +++++++++++++++++++++++++---------------------
 2 files changed, 46 insertions(+), 24 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fa538feaa8d95..912b6d40a12d6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1816,7 +1816,24 @@ static inline pmd_t folio_mk_pmd(struct folio *folio, pgprot_t pgprot)
 {
 	return pmd_mkhuge(pfn_pmd(folio_pfn(folio), pgprot));
 }
-#endif
+
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
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
+#endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif /* CONFIG_MMU */
 
 static inline bool folio_has_pincount(const struct folio *folio)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7e3e9028873e5..4734de1dc0ae4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1535,15 +1535,18 @@ static pud_t maybe_pud_mkwrite(pud_t pud, struct vm_area_struct *vma)
 	return pud;
 }
 
-static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
-		pud_t *pud, pfn_t pfn, pgprot_t prot, bool write)
+static void insert_pud(struct vm_area_struct *vma, unsigned long addr,
+		pud_t *pud, struct folio_or_pfn fop, pgprot_t prot, bool write)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pud_t entry;
 
 	if (!pud_none(*pud)) {
+		const unsigned long pfn = fop.is_folio ? folio_pfn(fop.folio) :
+					  pfn_t_to_pfn(fop.pfn);
+
 		if (write) {
-			if (WARN_ON_ONCE(pud_pfn(*pud) != pfn_t_to_pfn(pfn)))
+			if (WARN_ON_ONCE(pud_pfn(*pud) != pfn))
 				return;
 			entry = pud_mkyoung(*pud);
 			entry = maybe_pud_mkwrite(pud_mkdirty(entry), vma);
@@ -1553,11 +1556,19 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 		return;
 	}
 
-	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
-	if (pfn_t_devmap(pfn))
-		entry = pud_mkdevmap(entry);
-	else
-		entry = pud_mkspecial(entry);
+	if (fop.is_folio) {
+		entry = folio_mk_pud(fop.folio, vma->vm_page_prot);
+
+		folio_get(fop.folio);
+		folio_add_file_rmap_pud(fop.folio, &fop.folio->page, vma);
+		add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PUD_NR);
+	} else {
+		entry = pud_mkhuge(pfn_t_pud(fop.pfn, prot));
+		if (pfn_t_devmap(fop.pfn))
+			entry = pud_mkdevmap(entry);
+		else
+			entry = pud_mkspecial(entry);
+	}
 	if (write) {
 		entry = pud_mkyoung(pud_mkdirty(entry));
 		entry = maybe_pud_mkwrite(entry, vma);
@@ -1581,6 +1592,9 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 	unsigned long addr = vmf->address & PUD_MASK;
 	struct vm_area_struct *vma = vmf->vma;
 	pgprot_t pgprot = vma->vm_page_prot;
+	struct folio_or_pfn fop = {
+		.pfn = pfn,
+	};
 	spinlock_t *ptl;
 
 	/*
@@ -1600,7 +1614,7 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 	pfnmap_setup_cachemode_pfn(pfn_t_to_pfn(pfn), &pgprot);
 
 	ptl = pud_lock(vma->vm_mm, vmf->pud);
-	insert_pfn_pud(vma, addr, vmf->pud, pfn, pgprot, write);
+	insert_pud(vma, addr, vmf->pud, fop, pgprot, write);
 	spin_unlock(ptl);
 
 	return VM_FAULT_NOPAGE;
@@ -1622,6 +1636,10 @@ vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio,
 	unsigned long addr = vmf->address & PUD_MASK;
 	pud_t *pud = vmf->pud;
 	struct mm_struct *mm = vma->vm_mm;
+	struct folio_or_pfn fop = {
+		.folio = folio,
+		.is_folio = true,
+	};
 	spinlock_t *ptl;
 
 	if (addr < vma->vm_start || addr >= vma->vm_end)
@@ -1631,20 +1649,7 @@ vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio,
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
-		folio_get(folio);
-		folio_add_file_rmap_pud(folio, &folio->page, vma);
-		add_mm_counter(mm, mm_counter_file(folio), HPAGE_PUD_NR);
-	}
-	insert_pfn_pud(vma, addr, vmf->pud, pfn_to_pfn_t(folio_pfn(folio)),
-		       vma->vm_page_prot, write);
+	insert_pud(vma, addr, vmf->pud, fop, vma->vm_page_prot, write);
 	spin_unlock(ptl);
 
 	return VM_FAULT_NOPAGE;
-- 
2.49.0

