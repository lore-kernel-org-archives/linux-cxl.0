Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7A52C159D
	for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749806837; cv=none; b=oveitW2DCSgIWOWZZEEBIVz8V116ny4PjTgWc1jbxORDLlJWiuOqwij6n1gvUgMQGIYop6M9MNwk2bFD69uOzsE023Y0xHbh7WAEa+rubEx2w6EPX2WFgOZGYJrkXpM2r4CBxxGDLuxKfVjK5jFfKO5hZOWYf/b/LzfY5FXeNZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749806837; c=relaxed/simple;
	bh=6tO5VYLM2T1L+Bh5vole73WL1rOpW9UksZR14TfFrDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=lye2FxvcR5aEsJLcg80zoZAAXbqMJDsgSCuvw0mFrm51XvPnrMECQB11gQhWEk2hRaTQXVNIkcUHlSUNHKlWYBC5zXjKK5DTtZAshrvrH/Qw825q/6U80Tbb/AXEALP1eRjDTgRCH8ef3HYS74w4oqONSIxqT1dD1u+jyMrLN1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JcjyL2jA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JcjyL2jA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749806832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dB/Gx1sOYTj3RBFxV3FcA/SYk77nCJNbmnFBuqoX6J8=;
	b=JcjyL2jAaYcpr0MNZIgaIo8UaRX/Y0tWmaP4dWcBGQCyVnumDbC2g9wZ5xDouXLFFYAnOO
	ggruDEg4gtaGPljBAdtW7oU6KZYJ/p1e4Oekp03UkW3nj8fxIICN2HM5ReD4UNZfGNZTKm
	wmQJvnFBuuLm7/wg4vk1+5kHVI46a+A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-dPwU2Vm8NwyAydCJQr4uuQ-1; Fri, 13 Jun 2025 05:27:11 -0400
X-MC-Unique: dPwU2Vm8NwyAydCJQr4uuQ-1
X-Mimecast-MFC-AGG-ID: dPwU2Vm8NwyAydCJQr4uuQ_1749806831
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f3796779so1537067f8f.1
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 02:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749806830; x=1750411630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dB/Gx1sOYTj3RBFxV3FcA/SYk77nCJNbmnFBuqoX6J8=;
        b=h/YoHtr10D8MP0D8up3JhDYM7L6gxpGrSTH7GNtMBbmAPeKkNbKYS6RmMy6GJOxmvg
         PZwNBEi+ClsLX9gzp27cFLsU6H51l3agGMYqDaoUYKeyXBtgO/FnfnKplLwyOwfhTIpH
         CQbQ9Wu31vg8NmlFM6W+lsLaYuRogaZkjeSCzGVf0oeuXiiWJHY90uWUgot9YUSpUkDG
         4WdeBO233tWAYmWw/+Szp38ETXcqG1xgE/AB/cuaVxdXUb0m/c94O5N3V3yoxTbpFjcX
         cZDDXDdsXYEiYa5EbIHY7vH2i3SexSiI/FhAB5lVBW+A+Vset3aekacCYvv/z+3FdN1a
         SeDw==
X-Forwarded-Encrypted: i=1; AJvYcCXcjj8FxZMTnifhKU3QrbojSoF48imthnPQBclU0EMPVoE0kWIQEbKtWcJ8HR0IZmfSdh2vik8lMIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJUnuR9sQRTKcXthwpZqkezMTynpt/V4l5mjByxPNt3S5yiW9o
	UBg7tjg1LGyaxT3eatLSLXv+7FVLoMLV0gMKO2Xu9CCC6HpJ+FmckBQ9mPN/TrWy9aKRDXy+jYC
	UN6e8dRKknMT7m80LeiZTXh53/c8UOeW/6rUEojpAP2fsihRxbOty9eRW7blCXA==
X-Gm-Gg: ASbGncsNF6cGj3oMHcFrzLaVKtVyxsxfwyKg/Bngdo8xdhcz6K1epAXg76a7WbiTkWD
	ukCUQgyBviqM2FzHiv44imkJl2GwzfPaJNKJdBGu+3qfNvcEvSLTe6wBbp8fwV6OPrA+8QwZArn
	eijuz4EGMQK/P7tf0gwfsPuHl0Mn/+HcXX9YpzP8NrX/qiXdrilf6JlgCHf/7exsljvMNSIU+pC
	GOdI2EKQQOk8VcDPePXvyyDArsKId2fmtsilfH2XAaVV5hbInoxngZcS8loVCUsqzkNn1YsdRbv
	oJziA7kJk2DitMJXTtZqttnDga/PtAQMMYe0KPVKWg5+Kr784KXetAt+p+RD2fCxkqJn1iNWjVi
	/FggnQ9Q=
X-Received: by 2002:a05:6000:24c8:b0:3a4:f787:9b58 with SMTP id ffacd0b85a97d-3a56874a137mr2481361f8f.58.1749806830389;
        Fri, 13 Jun 2025 02:27:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqj6NdODj43XbLFVDeV1qD7UYHV1rn0TfwsC4tf99O0oNc/40w2gplW02JFKnmYY0c01aDOg==
X-Received: by 2002:a05:6000:24c8:b0:3a4:f787:9b58 with SMTP id ffacd0b85a97d-3a56874a137mr2481334f8f.58.1749806829879;
        Fri, 13 Jun 2025 02:27:09 -0700 (PDT)
Received: from localhost (p200300d82f1a37002982b5f7a04e4cb4.dip0.t-ipconnect.de. [2003:d8:2f1a:3700:2982:b5f7:a04e:4cb4])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a5689e5f3dsm1827987f8f.0.2025.06.13.02.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 02:27:09 -0700 (PDT)
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
	Oscar Salvador <osalvador@suse.de>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 3/3] mm/huge_memory: don't mark refcounted folios special in vmf_insert_folio_pud()
Date: Fri, 13 Jun 2025 11:27:02 +0200
Message-ID: <20250613092702.1943533-4-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613092702.1943533-1-david@redhat.com>
References: <20250613092702.1943533-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: auwc3XboBhK26iXsfWakaCDgJSU5LCM4twFda8HXEAA_1749806831
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Marking PUDs that map a "normal" refcounted folios as special is
against our rules documented for vm_normal_page(). normal (refcounted)
folios shall never have the page table mapping marked as special.

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
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 19 ++++++++++++++++-
 mm/huge_memory.c   | 52 ++++++++++++++++++++++++++--------------------
 2 files changed, 47 insertions(+), 24 deletions(-)

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
index d1e3e253c714a..bbc1dab98f2f7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1536,15 +1536,18 @@ static pud_t maybe_pud_mkwrite(pud_t pud, struct vm_area_struct *vma)
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
@@ -1554,11 +1557,20 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
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
+
+		if (pfn_t_devmap(fop.pfn))
+			entry = pud_mkdevmap(entry);
+		else
+			entry = pud_mkspecial(entry);
+	}
 	if (write) {
 		entry = pud_mkyoung(pud_mkdirty(entry));
 		entry = maybe_pud_mkwrite(entry, vma);
@@ -1582,6 +1594,9 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 	unsigned long addr = vmf->address & PUD_MASK;
 	struct vm_area_struct *vma = vmf->vma;
 	pgprot_t pgprot = vma->vm_page_prot;
+	struct folio_or_pfn fop = {
+		.pfn = pfn,
+	};
 	spinlock_t *ptl;
 
 	/*
@@ -1601,7 +1616,7 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 	pfnmap_setup_cachemode_pfn(pfn_t_to_pfn(pfn), &pgprot);
 
 	ptl = pud_lock(vma->vm_mm, vmf->pud);
-	insert_pfn_pud(vma, addr, vmf->pud, pfn, pgprot, write);
+	insert_pud(vma, addr, vmf->pud, fop, pgprot, write);
 	spin_unlock(ptl);
 
 	return VM_FAULT_NOPAGE;
@@ -1623,6 +1638,10 @@ vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio,
 	unsigned long addr = vmf->address & PUD_MASK;
 	pud_t *pud = vmf->pud;
 	struct mm_struct *mm = vma->vm_mm;
+	struct folio_or_pfn fop = {
+		.folio = folio,
+		.is_folio = true,
+	};
 	spinlock_t *ptl;
 
 	if (addr < vma->vm_start || addr >= vma->vm_end)
@@ -1632,20 +1651,7 @@ vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio,
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

