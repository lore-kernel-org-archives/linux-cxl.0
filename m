Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F082820D7
	for <linux-cxl@vger.kernel.org>; Wed, 11 Jun 2025 12:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749643633; cv=none; b=T0TjXrWlJwwpF9h5K6C3RxyahY8HRdL2AJiS2cyhz2riwzfNS3dRXrPAFV6XQQzk46Juli+LzgJT+AfJ0C6cJDztOP3wgJ7alEQokK7mfI864LoOMVClcn9k3bEOCzx/ifX0CVEJWcX4NwLnQ1+dpMY8g+1vbRte9afFP7oFNcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749643633; c=relaxed/simple;
	bh=d7UzkQtVY7kuIxcI/EZc5YSadWXv/sCE0nDIA2XsSqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=sccLb6LBsII1DgaD/VZeHFf91a8S00zZ+6VTwV1pBfIv8eLUGMtd7Xs1DHooWUcb1nPJpDvksGvybyzUbPe/eaFEEi8/Uy0fUTmuLFTzxr5QohltNhx+D5P0WAQ3TVcAplWYCxkGdUPIBTXNTxXxHUih+Q5GuDmS8Br6PB133E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GpIHQh7p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpIHQh7p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749643631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gYmY9lqRnj4cw3caoSyKqMYCbf0QdwGbw8D5FFvmOek=;
	b=GpIHQh7p0WZigrSTkPZVEuDJD8xq7h8jJG5xUqRNP4CdIKQynCA6T+dyppZGXw/iIo6s54
	MzQ9XzAh7tRacPjW8sa7lgYonXboikMIFd94ZkaNLptej46Nw2eNp6TqmpV+Ga69/jTSqe
	a4mMY3sNNgMCok+UVNcw3e3n8g5i5O4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-bKGrNR91Ms6mIM9Wjwc-Ww-1; Wed, 11 Jun 2025 08:07:10 -0400
X-MC-Unique: bKGrNR91Ms6mIM9Wjwc-Ww-1
X-Mimecast-MFC-AGG-ID: bKGrNR91Ms6mIM9Wjwc-Ww_1749643629
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a6fb9bbbc9so114394201cf.0
        for <linux-cxl@vger.kernel.org>; Wed, 11 Jun 2025 05:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749643629; x=1750248429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYmY9lqRnj4cw3caoSyKqMYCbf0QdwGbw8D5FFvmOek=;
        b=dr+w/+myz9k/eBIuKziUrkTV5gRfaYi5grZ6+tzAWzF2agWZVQW93ltpOQy3jcaVK9
         eDwMMuQKnJQ3gWlweMclEMuseZ4QidudnmJmFUv4KVGIM5vIObFsyBBTu1S2LOkL5IyW
         x+jUT+UxAkvWLwOyp3SXAv93tbEgIqRbE/lHQmP0iKKZAoyxv95K+Y1j83vguBx/GmOu
         GaALqbbMJS/lnRRkfvo3RER+E2yGdpomuKEznTgZ2JnEC8BvMky8fTEpZz/gl9nyobW5
         I22RMvWXwD6Hp3FvkLEYhY0YcJ6oglqu4yBIJeKFm2G6VIoN+jUpedjUP1cvYtGqBSmT
         2ioA==
X-Forwarded-Encrypted: i=1; AJvYcCU7gbwil2iOBhfm2OqQkBhiZ5LN0+duAdE/Lmbk1cQ95FFsa8Qlf4HF7LPB7YBrwReKGSrT6pZ7Z0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9GA73z2gnHki3dCDSYD+TH4GHCqo9FZJQHREPBXkQc6Q3lxxe
	2r3mVGL6jNrEK56/jo1//f3XRJ4gtIALKaoPhPn7W8j1k0ASGDbLYwFuPx7J3qnnLqi0nlYi/pU
	wO98yGLviGATySLgJXi02QcWFY4e4kFHIPGKQrmSvSmBj/G+OfcgFHLBf4SGNSg==
X-Gm-Gg: ASbGnct6QwGbt3pdpsoTnL+BbhI8/NpWydc8s/ajuzvFL05/0c3Rx3wH37fjzfeTFvZ
	jqEdnbdi0b6FZQM0tdLXt+fSn1HMGmetFtSR4aXG/l6UK4YRdaCkz+y0fp9z+QRoWod4pFSJllL
	iJqeQusUYHaAyM0KXXs8N2aWRISkGHKp3ItHpnU8rlj31h/92BXCJB5es9NxfaJcmHqaaaHRMF7
	smiMdbKRx2gDLesLjqVMFYutvS/i7TeKRKPfisH+PgUGCCUH7A894aOAvDODVcKm0LBna0rAvE5
	zdehEuLoVeagQiC4Gy9Q59liIPo+TPOJmgKWut3fyQ==
X-Received: by 2002:a05:622a:258c:b0:499:23e5:a39e with SMTP id d75a77b69052e-4a714b5f095mr41022961cf.18.1749643629313;
        Wed, 11 Jun 2025 05:07:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFkRu3pD31QY49jF7czwiN04VZspGiT3brE6ESvHTJ+EUAthmLASS1EV2SOMHG5iqhG7+Byg==
X-Received: by 2002:a05:622a:258c:b0:499:23e5:a39e with SMTP id d75a77b69052e-4a714b5f095mr41022301cf.18.1749643628891;
        Wed, 11 Jun 2025 05:07:08 -0700 (PDT)
Received: from localhost (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4a619865e74sm87713091cf.61.2025.06.11.05.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 05:07:08 -0700 (PDT)
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
Subject: [PATCH v2 2/3] mm/huge_memory: don't mark refcounted folios special in vmf_insert_folio_pmd()
Date: Wed, 11 Jun 2025 14:06:53 +0200
Message-ID: <20250611120654.545963-3-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: ASg_PCLMjpOR-wKbViK4j-mhvFeQHnkAzBbzUuH3y4I_1749643629
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Marking PMDs that map a "normal" refcounted folios as special is
against our rules documented for vm_normal_page().

Fortunately, there are not that many pmd_special() check that can be
mislead, and most vm_normal_page_pmd()/vm_normal_folio_pmd() users that
would get this wrong right now are rather harmless: e.g., none so far
bases decisions whether to grab a folio reference on that decision.

Well, and GUP-fast will fallback to GUP-slow. All in all, so far no big
implications as it seems.

Getting this right will get more important as we use
folio_normal_page_pmd() in more places.

Fix it by teaching insert_pfn_pmd() to properly handle folios and
pfns -- moving refcount/mapcount/etc handling in there, renaming it to
insert_pmd(), and distinguishing between both cases using a new simple
"struct folio_or_pfn" structure.

Use folio_mk_pmd() to create a pmd for a folio cleanly.

Fixes: 6c88f72691f8 ("mm/huge_memory: add vmf_insert_folio_pmd()")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 58 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 49b98082c5401..7e3e9028873e5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1372,9 +1372,17 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 	return __do_huge_pmd_anonymous_page(vmf);
 }
 
-static int insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
-		pmd_t *pmd, pfn_t pfn, pgprot_t prot, bool write,
-		pgtable_t pgtable)
+struct folio_or_pfn {
+	union {
+		struct folio *folio;
+		pfn_t pfn;
+	};
+	bool is_folio;
+};
+
+static int insert_pmd(struct vm_area_struct *vma, unsigned long addr,
+		pmd_t *pmd, struct folio_or_pfn fop, pgprot_t prot,
+		bool write, pgtable_t pgtable)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pmd_t entry;
@@ -1382,8 +1390,11 @@ static int insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 	lockdep_assert_held(pmd_lockptr(mm, pmd));
 
 	if (!pmd_none(*pmd)) {
+		const unsigned long pfn = fop.is_folio ? folio_pfn(fop.folio) :
+					  pfn_t_to_pfn(fop.pfn);
+
 		if (write) {
-			if (pmd_pfn(*pmd) != pfn_t_to_pfn(pfn)) {
+			if (pmd_pfn(*pmd) != pfn) {
 				WARN_ON_ONCE(!is_huge_zero_pmd(*pmd));
 				return -EEXIST;
 			}
@@ -1396,11 +1407,19 @@ static int insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 		return -EEXIST;
 	}
 
-	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
-	if (pfn_t_devmap(pfn))
-		entry = pmd_mkdevmap(entry);
-	else
-		entry = pmd_mkspecial(entry);
+	if (fop.is_folio) {
+		entry = folio_mk_pmd(fop.folio, vma->vm_page_prot);
+
+		folio_get(fop.folio);
+		folio_add_file_rmap_pmd(fop.folio, &fop.folio->page, vma);
+		add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PMD_NR);
+	} else {
+		entry = pmd_mkhuge(pfn_t_pmd(fop.pfn, prot));
+		if (pfn_t_devmap(fop.pfn))
+			entry = pmd_mkdevmap(entry);
+		else
+			entry = pmd_mkspecial(entry);
+	}
 	if (write) {
 		entry = pmd_mkyoung(pmd_mkdirty(entry));
 		entry = maybe_pmd_mkwrite(entry, vma);
@@ -1431,6 +1450,9 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 	unsigned long addr = vmf->address & PMD_MASK;
 	struct vm_area_struct *vma = vmf->vma;
 	pgprot_t pgprot = vma->vm_page_prot;
+	struct folio_or_pfn fop = {
+		.pfn = pfn,
+	};
 	pgtable_t pgtable = NULL;
 	spinlock_t *ptl;
 	int error;
@@ -1458,8 +1480,8 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 	pfnmap_setup_cachemode_pfn(pfn_t_to_pfn(pfn), &pgprot);
 
 	ptl = pmd_lock(vma->vm_mm, vmf->pmd);
-	error = insert_pfn_pmd(vma, addr, vmf->pmd, pfn, pgprot, write,
-			pgtable);
+	error = insert_pmd(vma, addr, vmf->pmd, fop, pgprot, write,
+			   pgtable);
 	spin_unlock(ptl);
 	if (error && pgtable)
 		pte_free(vma->vm_mm, pgtable);
@@ -1474,6 +1496,10 @@ vm_fault_t vmf_insert_folio_pmd(struct vm_fault *vmf, struct folio *folio,
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long addr = vmf->address & PMD_MASK;
 	struct mm_struct *mm = vma->vm_mm;
+	struct folio_or_pfn fop = {
+		.folio = folio,
+		.is_folio = true,
+	};
 	spinlock_t *ptl;
 	pgtable_t pgtable = NULL;
 	int error;
@@ -1491,14 +1517,8 @@ vm_fault_t vmf_insert_folio_pmd(struct vm_fault *vmf, struct folio *folio,
 	}
 
 	ptl = pmd_lock(mm, vmf->pmd);
-	if (pmd_none(*vmf->pmd)) {
-		folio_get(folio);
-		folio_add_file_rmap_pmd(folio, &folio->page, vma);
-		add_mm_counter(mm, mm_counter_file(folio), HPAGE_PMD_NR);
-	}
-	error = insert_pfn_pmd(vma, addr, vmf->pmd,
-			pfn_to_pfn_t(folio_pfn(folio)), vma->vm_page_prot,
-			write, pgtable);
+	error = insert_pmd(vma, addr, vmf->pmd, fop, vma->vm_page_prot,
+			   write, pgtable);
 	spin_unlock(ptl);
 	if (error && pgtable)
 		pte_free(mm, pgtable);
-- 
2.49.0

