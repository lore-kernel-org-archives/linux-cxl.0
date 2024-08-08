Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606B818FDD1
	for <linux-cxl@vger.kernel.org>; Thu,  8 Aug 2024 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131765; cv=none; b=IAp8gY4ztlnW9ZkG04QK82rktmJeTrCoTyzr6TlPOW692BsGhhdFABL+DkfIv6se+GRTHwGVAMiFUF8HSsb8VIqUG3pm9aRy9b99pTmZjA3RmdWP3zJZkAg2aT/1Q9K1p5wxzIywXcfHgRV0mNZJJRftt9ddgpk2MHDVUajDJ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131765; c=relaxed/simple;
	bh=mXuho5qRbcIktuppWuhYAb1FR0k6aVabcnCwkyhGc3A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpVdPg+QvuiaL0FjWPOY0W0vFydCTAon0WWYOdGB1thPMFEpXoScdK/zFVcM3FD+cik+MdfBhqToBejJKDyiOIz6uGFJhLcTOBwuDkBZVKeuZCR4UUOMKsNB/uhfsWa5PL2FQZJiZ76xqSrCPPBeifMadGnUMD/OHvOtgg4Kn7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=LdGvJKYu; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="LdGvJKYu"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b79fc76d03so6264466d6.1
        for <linux-cxl@vger.kernel.org>; Thu, 08 Aug 2024 08:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723131761; x=1723736561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRSFFXDfNtNVk7lGVeoRIubNta7FSFGwpVVL6fGvxf0=;
        b=LdGvJKYuAiuXr1Pgwa8qR0Tm1+o6wENHB9veXPs+HxeigAnOegl1HiFAsIovDIUBgp
         h+Ii9Wi5D8YgTZWvgIcVZRxfYPMkHYkDpaLRGBrsXHzCT4CFCQFLIBhBb7R5BvuSB8cY
         7AxsT+FjjLsEZwtwoCTptYwdW7lt/s7oJYIWK+CfmK5VgkzR1UaZIxyAo9xI1xhgcKlk
         Rr80o39Z7jQ+/2tVRCmLdSVX6BaaOfHg8YlFtL1uQ2dw3rDllnVrefMmz0fAV5S/lrQA
         U7rkln/Xpw8xfffF8w3ySuB+ZA/XATZDxc9FQTBmYuPuUpy1Uubiu7910pMSDZnJFrjK
         ocHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723131761; x=1723736561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRSFFXDfNtNVk7lGVeoRIubNta7FSFGwpVVL6fGvxf0=;
        b=dq9YOM/Pv2bNKy9nKI0q9/1NDQUK5bCBbcABFoW8hr9tvnCqycAoSiK3bh/wFqc0w7
         c/230QVgll1ryVIFSHlVSKNsMKDNV/5l1C/WdVLA8PivOaN93nRKDsQ1bFgyFZNs8unX
         blwl/fdFF66X8l7kaosrXSDFy00QLIrooaCjlTa7SOVvYxsO2LadAItLT6z7FluBAPHM
         weTdL0xKx9NaAPwDST8M/WSho6ELKA6297Begki835Xpi8o7D9TO1YZ1h2kEB0BxiBak
         Xs7x2e4ddWSQipSz2tRY21Z7kOJGHI8IMCltEJz/kjXTq5zDTEgnOVeAPN945PNMt3KG
         0iDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQH6fmkUcSw/E8zXeOaK49ZFMEj/piLS3xUFBvXB//IFJPKLPRa1wxUwTMmnZxB78XEEtRCDBkSlu3hDAU6KXKaVWA6hUyZAgY
X-Gm-Message-State: AOJu0YyaygSi5SL8gbwYfd1/KFkkPHPIL1Nx+gFtj7JGPiqyJByZx+tQ
	XxJh2/C8oeH9GQg3OUDc9AGEgxl7iPjwDviw7/0EehlFKojzhM2MlFuKnbWH4nQ=
X-Google-Smtp-Source: AGHT+IEedYPnvL6gKHQRQr0wt7cczChz5kQMKQlE59fzWebBtyv5plUCNw68Wg5Sa6xCxlvPXi39qw==
X-Received: by 2002:a05:6214:4604:b0:6b9:607e:275e with SMTP id 6a1803df08f44-6bd6bd3263bmr24643256d6.34.1723131761187;
        Thu, 08 Aug 2024 08:42:41 -0700 (PDT)
Received: from soleen.c.googlers.com.com (118.239.150.34.bc.googleusercontent.com. [34.150.239.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c7b72d9sm67160936d6.60.2024.08.08.08.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 08:42:40 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	cerasuolodomenico@gmail.com,
	hannes@cmpxchg.org,
	j.granados@samsung.com,
	lizhijian@fujitsu.com,
	muchun.song@linux.dev,
	nphamcs@gmail.com,
	pasha.tatashin@soleen.com,
	rientjes@google.com,
	rppt@kernel.org,
	souravpanda@google.com,
	vbabka@suse.cz,
	willy@infradead.org,
	dan.j.williams@intel.com,
	yi.zhang@redhat.com,
	alison.schofield@intel.com,
	david@redhat.com,
	yosryahmed@google.com
Subject: [PATCH v3 1/4] mm: update the memmap stat before page is freed
Date: Thu,  8 Aug 2024 15:42:34 +0000
Message-ID: <20240808154237.220029-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <20240808154237.220029-1-pasha.tatashin@soleen.com>
References: <20240808154237.220029-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is more logical to update the stat before the page is freed, to avoid
use after free scenarios.

Fixes: 15995a352474 ("mm: report per-page metadata information")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/hugetlb_vmemmap.c | 4 ++--
 mm/page_ext.c        | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 829112b0a914..fa83a7b38199 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -185,11 +185,11 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 static inline void free_vmemmap_page(struct page *page)
 {
 	if (PageReserved(page)) {
-		free_bootmem_page(page);
 		mod_node_page_state(page_pgdat(page), NR_MEMMAP_BOOT, -1);
+		free_bootmem_page(page);
 	} else {
-		__free_page(page);
 		mod_node_page_state(page_pgdat(page), NR_MEMMAP, -1);
+		__free_page(page);
 	}
 }
 
diff --git a/mm/page_ext.c b/mm/page_ext.c
index c191e490c401..962d45eee1f8 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -330,18 +330,18 @@ static void free_page_ext(void *addr)
 	if (is_vmalloc_addr(addr)) {
 		page = vmalloc_to_page(addr);
 		pgdat = page_pgdat(page);
+		mod_node_page_state(pgdat, NR_MEMMAP,
+				    -1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
 		vfree(addr);
 	} else {
 		page = virt_to_page(addr);
 		pgdat = page_pgdat(page);
+		mod_node_page_state(pgdat, NR_MEMMAP,
+				    -1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
 		BUG_ON(PageReserved(page));
 		kmemleak_free(addr);
 		free_pages_exact(addr, table_size);
 	}
-
-	mod_node_page_state(pgdat, NR_MEMMAP,
-			    -1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
-
 }
 
 static void __free_page_ext(unsigned long pfn)
-- 
2.46.0.76.ge559c4bf1a-goog

