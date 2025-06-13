Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D703728135D
	for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 09:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749806831; cv=none; b=gKz7dF5ATVFOnlBsRG81YgPpHwv9sEDfgGexTswDX2r1aw+n4MlgRApXNh19Q59j5wZ37o/xDFTWWFZDzFe+K6VeBZnud0cM8oWba2i6dUlCntra4xC7+mCqHYbyZMdv96clPN0XMHc0+H/giU3vvvQzqY1tYyBhLBH0Czgi5Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749806831; c=relaxed/simple;
	bh=j64RqC0yW0IWSRsztwobsHrNoaRlkxqGA0a2OxsS0xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=GFOue5D8TQ6WgC6Sj6aLKRVaQRbZHTlLNF7n/BMsGaCHHH13xE6jtzV5EzKtQ1uXsuksCiR3VsgxddwvZJ4KA9PrAKQLFPP4QXIu8RCxsMip+d2PIEM0eoaWKbLEkpzCHsKlnC7HCOqs0A5VLrkSgwtQNslDZ9I2hKy7LYHy0xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YPClmD/5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPClmD/5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749806828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BuuwdyX0QESH0B5VKvKy/eQpha6SfRiQdyfEZdmDLAI=;
	b=YPClmD/5Y6TW07aF2SSMRfSQzcc+qAC/MewXRb3C89eU1WH1i9WY38ic4xK8F7PNHkV7f+
	1vXtnUU+8lM/Yj+2zo+7iR0F972lViQLGwgEoPCLcSf8cOqUShaGEhVWEDlGbC3Cnm8ZUd
	tUgniHYwqhIbU558aPleCDN5LM3JpwA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-teR2evAhOv-UbjErmWIT_w-1; Fri, 13 Jun 2025 05:27:07 -0400
X-MC-Unique: teR2evAhOv-UbjErmWIT_w-1
X-Mimecast-MFC-AGG-ID: teR2evAhOv-UbjErmWIT_w_1749806826
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso13337925e9.0
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 02:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749806826; x=1750411626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BuuwdyX0QESH0B5VKvKy/eQpha6SfRiQdyfEZdmDLAI=;
        b=gcql6m7uWSM7ZOcBskWbhsc9x1ODz5YLJDIGcJfzPHz3svKqSjxHsBeXsuwvEOZQY5
         PHqUXn/jUDPHoBGNHP11lSjiuav6nZuYD8flOlvQRo8E8SciMf4i8DsWQ7mRQFJyx0us
         JoMGI38Y+TRhQ383QJwxifHJ8NIIcI6wOjK8NNRAQY3KcqikLgH+JcJ49XxuBf6kJxHp
         gJheLGozqKMXJyz2X/8CAtwA3Q/sEE7riyX7zSC8Uwt9+pB4nxnOwJGn/k931V5HueIf
         S6s8IHBK8nnjL+VAHyaLohuz0a9culzvT2irJFYraHFr0RO41zFAaUp5nGjH/P8YHP7v
         sT4w==
X-Forwarded-Encrypted: i=1; AJvYcCWmKs5KAc5KF6mMnSWSU59J0XOVsHrR3CNVrUncAix82t8Tz+wiAvvouvs3rjbT5ta5tf2F1yzpGms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm0EaFYO3lSsOlR9NY1WdAzdOBNEQOmVjOWykE0Ajw4nJqOD9o
	acGYyi/S3inbvQVrKyi4d/YfXLE3cd+w+clkequr5xzAFDl8OzPlt7NBCEsZydiTQ8/VNXucPlS
	NfpnUNdCcX/fS4T9bJRyDfUFd/2R+3q48dtuZYVBpOMYD2ku/2hQEd0CHGonoZg==
X-Gm-Gg: ASbGncv4zNJCYGsjW+GWsKN9V/f5DrJlEvnNM3jFzmWJPSN27u6vYLxDJ3ShYlSpOXk
	vqtw4esMdmtdmCaQ0fUlHf+8gsniPSCHq8t+28rpVQX4Jy5JtCNj4NNwzb98v/YgRZg+c4sTJEI
	Bzs11Y2G7UGZj5lw/7o9C3VflJbYpPrqRBR5HQs5xfQBhOF2vyEXq6iH24v4iVN6lTY/lzlED1S
	5Vuq4ZnG0gqMam9AHV/9ttYMUFUap2Q7gqyNO1QSRMt0acRRbbfYYJ3GvfM89gomK0qbMME0vro
	8Ksak5h8tXOJ2nY2wUGW8pJc93hZ5iGP4bXe4S4tdq9ow0x47YRIvrs+9xeheFohNY6yxl/mJ52
	t64gPGug=
X-Received: by 2002:a05:600c:8b44:b0:440:61eb:2ce5 with SMTP id 5b1f17b1804b1-45334ad836amr23540725e9.17.1749806826447;
        Fri, 13 Jun 2025 02:27:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP4hRMlxC0kkYbbJprcfwWEfFpKdqbkbnkLg58Cogqr6OsnbV5xlaTNzlLDv0FGfkKMNYSyQ==
X-Received: by 2002:a05:600c:8b44:b0:440:61eb:2ce5 with SMTP id 5b1f17b1804b1-45334ad836amr23540385e9.17.1749806826108;
        Fri, 13 Jun 2025 02:27:06 -0700 (PDT)
Received: from localhost (p200300d82f1a37002982b5f7a04e4cb4.dip0.t-ipconnect.de. [2003:d8:2f1a:3700:2982:b5f7:a04e:4cb4])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4532e24420csm45559825e9.20.2025.06.13.02.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 02:27:05 -0700 (PDT)
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
	Jason Gunthorpe <jgg@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] mm/huge_memory: don't ignore queried cachemode in vmf_insert_pfn_pud()
Date: Fri, 13 Jun 2025 11:27:00 +0200
Message-ID: <20250613092702.1943533-2-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: rqvcGVu_pWOvKysbnEohGkySiZSjuTSb3XXZ3z763AY_1749806826
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

We setup the cache mode but ... don't forward the updated pgprot to
insert_pfn_pud().

Only a problem on x86-64 PAT when mapping PFNs using PUDs that
require a special cachemode.

Fix it by using the proper pgprot where the cachemode was setup.

It is unclear in which configurations we would get the cachemode wrong:
through vfio seems possible. Getting cachemodes wrong is usually ... bad.
As the fix is easy, let's backport it to stable.

Identified by code inspection.

Fixes: 7b806d229ef1 ("mm: remove vmf_insert_pfn_xxx_prot() for huge page-table entries")
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Dan Williams <dan.j.williams@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d3e66136e41a3..49b98082c5401 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1516,10 +1516,9 @@ static pud_t maybe_pud_mkwrite(pud_t pud, struct vm_area_struct *vma)
 }
 
 static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
-		pud_t *pud, pfn_t pfn, bool write)
+		pud_t *pud, pfn_t pfn, pgprot_t prot, bool write)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	pgprot_t prot = vma->vm_page_prot;
 	pud_t entry;
 
 	if (!pud_none(*pud)) {
@@ -1581,7 +1580,7 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 	pfnmap_setup_cachemode_pfn(pfn_t_to_pfn(pfn), &pgprot);
 
 	ptl = pud_lock(vma->vm_mm, vmf->pud);
-	insert_pfn_pud(vma, addr, vmf->pud, pfn, write);
+	insert_pfn_pud(vma, addr, vmf->pud, pfn, pgprot, write);
 	spin_unlock(ptl);
 
 	return VM_FAULT_NOPAGE;
@@ -1625,7 +1624,7 @@ vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio,
 		add_mm_counter(mm, mm_counter_file(folio), HPAGE_PUD_NR);
 	}
 	insert_pfn_pud(vma, addr, vmf->pud, pfn_to_pfn_t(folio_pfn(folio)),
-		write);
+		       vma->vm_page_prot, write);
 	spin_unlock(ptl);
 
 	return VM_FAULT_NOPAGE;
-- 
2.49.0

