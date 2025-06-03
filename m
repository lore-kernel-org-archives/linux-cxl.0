Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80812228CB8
	for <linux-cxl@vger.kernel.org>; Tue,  3 Jun 2025 21:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748985404; cv=none; b=miUzAWrGi8sph6Rh9nY1W263pqy0DOXE6ij7TfzcTtuPS344Up6oHKs208zEphffsF+bOVnPzNRVQFECxpX6E+AqXMJqTXF4m4O0krCaqWXj6NNn9PYRwHx2t8boAN/Vwt8zIcMWnhm66T3CyeHNWfz7Sdgc5UX4qXMt5JxRhys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748985404; c=relaxed/simple;
	bh=8rYDS4TO8ABtj37UFmxpQriDVqi32huOFvyDHq7Vzio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=IN1MvqSsUKUSys10UAI1TWuEsxwyEsnjBalRTm9a8f9httZBaitcW82C72DWAmsSvoYKDvHs5Dx/IbkNRpLgmzwkaf/T9srjm89W3OU19mnH96QvaT/ITis2pmlQwvoao17x6v88GnncAzdjOAlV79vow5g00R3qhBRvx6uAh9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YwaZYonj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwaZYonj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748985401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mm1BYtQxm3N2Ps8LPBW/KCN7FYFGa741SkgBjReTkwo=;
	b=YwaZYonjyRqfQg207Ag0ayv9fFCPAj+ie0ZjsHGoYmPYNKWUxmCp2MLLFtznnIG1+Y1eeq
	yM68rI1sZf1tTeN4MZkvwzY4kJSpJBUZaaVBSnAB+WeoXaCO9tKFIzCArf9uneeP37L7SE
	JSJ30WjxAoQuOcTKJENKEk3GclmbRBE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-ibjfjG5WPwmdOlKxBWfFCA-1; Tue, 03 Jun 2025 17:16:40 -0400
X-MC-Unique: ibjfjG5WPwmdOlKxBWfFCA-1
X-Mimecast-MFC-AGG-ID: ibjfjG5WPwmdOlKxBWfFCA_1748985399
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-442dc702850so41432725e9.1
        for <linux-cxl@vger.kernel.org>; Tue, 03 Jun 2025 14:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748985399; x=1749590199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mm1BYtQxm3N2Ps8LPBW/KCN7FYFGa741SkgBjReTkwo=;
        b=bmKTGqr+/CzAH/3DgLp+UeuRRSrRJgnEXNr7cM/uuCbzNqqIu2Pj028y0g1XAkdvqU
         55aWK4JQaiVoTQEnMc6Ioq7h9jSA40AwipucOCdQhKf4pMPIb8patPtb2aknw6XPTVk6
         v4PlhaGPrjvP5t82CXWw7rNdp8NMss8zT+tDZyEkw9eEqzM7aLQt0vqhO3sG9Vyjg2bF
         Wv7r3TgoS7uTgVgkPnyDYK1+6q5BhkF4a97MTaso30D05hjU1I5hzmRAy3mxoQGW6eF7
         lC+XOuBt9iJSWqLO4bO5+SpeLDOJBPKsZl6boUgtLDRQdFe+XHaVMvuH8bXwGRuqHnvl
         JdUw==
X-Forwarded-Encrypted: i=1; AJvYcCWMLjG+oR7Dl6Vu8ChOzxdRN70xNK+DmLDM6dPLBNPaBHESs8vjI7+88M6eIWdX1W/HiUaFIW6Vk1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYx1USl5EQDgf7pb7SZjOyd9uR8NUGGnEqKyj84DHqj8TAavKD
	dMFy/ywLzWsrusTLPJ30bUFuTXCzmcJK/u9fHC+lmk7Zuidjp9AgXAj4Awa313zpOTg7Rs/ZSXj
	c/iRil9FpimF3q44pGrsg2UcV03ZZb7dTY0t2g4PCuVzMB9/ZJSQZtNkDqmsLfQ==
X-Gm-Gg: ASbGncsTTm7GtWPXiD1paYG68DRU69b1cE4vrSvAbxLGZBeUTa6eivhBkLUyv1t1GqB
	oUw+2gSeTosBS/4KCEaBDGm9LfhOLUu2fXFA9Zm+7Qgtx0rLJf+Xthy/defo9f4xS104jCafzNG
	Kjk70AaZQZys1gUqNOb23HdJ43oleNumKmIQAEjXbWqos9QIwOGrDlCU2YtEG0V/f4MkxmPWOYz
	/oFFkh6Ejtq4h/uyl9oXh7+jg2BUSBNWWeWM1xn8dQksMYjpC4fqFGuQnkfUAhobB87Htb32sLo
	BbzPF6RGuMBZEh0frWw+OuyafYcdRbrt4n9fCdKsxDJOwXd3nciuyBU7F1z1v01ndLw+t//q
X-Received: by 2002:a05:600c:1987:b0:442:ccf0:41e6 with SMTP id 5b1f17b1804b1-451f0a729d0mr2203725e9.3.1748985398861;
        Tue, 03 Jun 2025 14:16:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkS98RFt7+3OnGuaG+p0pWOXJwdXIjQziuSpjs39IDB1rfs5Wk39SoikwZ5SKry/PJpnQWlQ==
X-Received: by 2002:a05:600c:1987:b0:442:ccf0:41e6 with SMTP id 5b1f17b1804b1-451f0a729d0mr2203405e9.3.1748985398434;
        Tue, 03 Jun 2025 14:16:38 -0700 (PDT)
Received: from localhost (p200300d82f0df000eec92b8d4913f32a.dip0.t-ipconnect.de. [2003:d8:2f0d:f000:eec9:2b8d:4913:f32a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-450d7fa21e4sm180154785e9.11.2025.06.03.14.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 14:16:38 -0700 (PDT)
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
Subject: [PATCH v1 1/2] mm/huge_memory: don't mark refcounted pages special in vmf_insert_folio_pmd()
Date: Tue,  3 Jun 2025 23:16:33 +0200
Message-ID: <20250603211634.2925015-2-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: e5y880szYnA7ztg0qTBlg4OEmVR3n_upuz368PVK8SI_1748985399
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

Fix it by just inlining the relevant code, making the whole
pmd_none() handling cleaner. We can now use folio_mk_pmd().

While at it, make sure that a pmd that is not-none is actually present
before comparing PFNs.

Fixes: 6c88f72691f8 ("mm/huge_memory: add vmf_insert_folio_pmd()")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d3e66136e41a3..f9e23dfea76f8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1474,9 +1474,10 @@ vm_fault_t vmf_insert_folio_pmd(struct vm_fault *vmf, struct folio *folio,
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long addr = vmf->address & PMD_MASK;
 	struct mm_struct *mm = vma->vm_mm;
+	pmd_t *pmd = vmf->pmd;
 	spinlock_t *ptl;
 	pgtable_t pgtable = NULL;
-	int error;
+	pmd_t entry;
 
 	if (addr < vma->vm_start || addr >= vma->vm_end)
 		return VM_FAULT_SIGBUS;
@@ -1490,17 +1491,41 @@ vm_fault_t vmf_insert_folio_pmd(struct vm_fault *vmf, struct folio *folio,
 			return VM_FAULT_OOM;
 	}
 
-	ptl = pmd_lock(mm, vmf->pmd);
-	if (pmd_none(*vmf->pmd)) {
+	ptl = pmd_lock(mm, pmd);
+	if (pmd_none(*pmd)) {
 		folio_get(folio);
 		folio_add_file_rmap_pmd(folio, &folio->page, vma);
 		add_mm_counter(mm, mm_counter_file(folio), HPAGE_PMD_NR);
+
+		entry = folio_mk_pmd(folio, vma->vm_page_prot);
+		if (write) {
+			entry = pmd_mkyoung(pmd_mkdirty(entry));
+			entry = maybe_pmd_mkwrite(entry, vma);
+		}
+		set_pmd_at(mm, addr, pmd, entry);
+		update_mmu_cache_pmd(vma, addr, pmd);
+
+		if (pgtable) {
+			pgtable_trans_huge_deposit(mm, pmd, pgtable);
+			mm_inc_nr_ptes(mm);
+			pgtable = NULL;
+		}
+	} else if (pmd_present(*pmd) && write) {
+		/*
+		 * We only allow for upgrading write permissions if the
+		 * same folio is already mapped.
+		 */
+		if (pmd_pfn(*pmd) == folio_pfn(folio)) {
+			entry = pmd_mkyoung(*pmd);
+			entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
+			if (pmdp_set_access_flags(vma, addr, pmd, entry, 1))
+				update_mmu_cache_pmd(vma, addr, pmd);
+		} else {
+			WARN_ON_ONCE(!is_huge_zero_pmd(*pmd));
+		}
 	}
-	error = insert_pfn_pmd(vma, addr, vmf->pmd,
-			pfn_to_pfn_t(folio_pfn(folio)), vma->vm_page_prot,
-			write, pgtable);
 	spin_unlock(ptl);
-	if (error && pgtable)
+	if (pgtable)
 		pte_free(mm, pgtable);
 
 	return VM_FAULT_NOPAGE;
-- 
2.49.0

