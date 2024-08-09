Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2969015ADB1
	for <linux-cxl@vger.kernel.org>; Fri,  9 Aug 2024 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230627; cv=none; b=TVqGpy5qgSzEUb4gvLftHg0pwROqIqIWn+sv1Pu1u4n2xDEnNNXDcci7t6uHHv0ZHvFvspzWWuJ3AU2tfzGi3JwrEB25RssQReSkKerpLFZv99ROGf+jZ1flYdTXXPdPvdzzrRtLIzbJL193XZHRSq6zkTyb8abLwWlAGO8Uquw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230627; c=relaxed/simple;
	bh=RJOegQUHcv+I33+qU7btWGqlaiXtgvR83VFZU3SBof8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVstYSTAg5qcvrFteKEEJsqLRmRnqLMYHRDSIFlHiPYX1iSsEd5yKFfUIU4hs1KC2LjRPSvYnbdvgyH5AXEZccQMJQDHCHR6X2sFDwPMKruIondUo0mGHY0Wh6trtoH6L51xGYMvQycmCFotvdE5UshuzlvyUv7UI+U/1gpPAIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=uYA+/L7R; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="uYA+/L7R"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a1e31bc1efso142573685a.3
        for <linux-cxl@vger.kernel.org>; Fri, 09 Aug 2024 12:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723230625; x=1723835425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Zfyh9sb1bnT5AOZDmCrIADGqpbj2HcF73SygbadHf0=;
        b=uYA+/L7RTFZgX8NfVrQh9mJ6VZ8tc8fzhAeZaURwLkr95njqjSkhTQxmXAoSLFnuZP
         LZn3KD0cxc2V2KYPs5vLnC9R4izqsl17k1xCraa0+aa5R7ciLIapgNE6B8YrDIJLwN3+
         0r9qpEtjFvePVBk79KnYdgzGD0p+omYdLvHD4svxMd31XFn6Wywj3w3ZTTuQzcz160A+
         WQSQtmgJAFXzHTAbdCDcJuEl1KtUD034GeVFQ05RFlJkElqJUZhTxLxHnBlF8f8D8vYv
         Ze84vc/+ir5innrRdMCrlvAegTBfz30dX4cxppG4ZTAZW3CKqNMR1d/rKShjhHK2bZGZ
         RjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723230625; x=1723835425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Zfyh9sb1bnT5AOZDmCrIADGqpbj2HcF73SygbadHf0=;
        b=Ex6blYNRtOurF+Augi9HV2h3t7of0MhWYo1qbB/cBfs2P5biH0PivDNSQannnvUiwo
         erKk6bUvF/iHZgljvZiEE+376SdSWFsAQSkmpi5+e7fg5x3BPjOwgVUIEJeoyT0h4H1B
         Q/4n3BA8NigfvAJDyh8+RfWrnMrKiGgMBuS/UJVukyQ3j4CiSueQFa0jPrrzedLjmtge
         89aMj6SBDW9zILPuayC+JKZe7XypzqwO0iKVXNhpM//ohMu2dD+DImrvnoO+GAawUNRm
         5YZYhCPKuENp3Q3zWwse0VRPCAcw0uRA8tP1ETnaPiokRN0Hf9TmPfVAvxI3n1Ww2OpC
         6kBw==
X-Forwarded-Encrypted: i=1; AJvYcCUR2jpS0wabfAlUAkMzufQ1v9GjYh1CqqQqDgFscq8YVs1Wi6g8+w7MaRD2jJA+VfbkuH63i3gzjdeaRUG8UZtojispN9R4/XFn
X-Gm-Message-State: AOJu0Yxu5+pqetWePz6nBVm+UsuYxtwBa6bDA26It5DJtP0Pl90PLz6Q
	acHDSQA2zGt8j7xVsLnNQNq+kKjGa8qZbHIfJSVH7DL2oVejrqJE+gsz54iXdNU=
X-Google-Smtp-Source: AGHT+IEpJ4kA1QWE3b+JfVVjir9Z6DC5086gWvGsdlrOs2CaZZLaGQY0jZT/CHJjcUlLTfdiOhrm+w==
X-Received: by 2002:a05:620a:2486:b0:7a1:d9a6:a9af with SMTP id af79cd13be357-7a4c1860cf6mr306443585a.68.1723230624911;
        Fri, 09 Aug 2024 12:10:24 -0700 (PDT)
Received: from soleen.c.googlers.com.com (118.239.150.34.bc.googleusercontent.com. [34.150.239.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7df5a55sm5522085a.86.2024.08.09.12.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 12:10:24 -0700 (PDT)
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
Subject: [PATCH v5 1/3] mm: don't account memmap on failure
Date: Fri,  9 Aug 2024 19:10:18 +0000
Message-ID: <20240809191020.1142142-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <20240809191020.1142142-1-pasha.tatashin@soleen.com>
References: <20240809191020.1142142-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we fail to allocate the mmemmap in alloc_vmemmap_page_list(), do
not account any already-allocated pages: we're going to free all them
before we return from the function.

Fixes: 15995a352474 ("mm: report per-page metadata information")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/hugetlb_vmemmap.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 829112b0a914..4f51e0596197 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -392,13 +392,10 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
 
 	for (i = 0; i < nr_pages; i++) {
 		page = alloc_pages_node(nid, gfp_mask, 0);
-		if (!page) {
-			mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, i);
+		if (!page)
 			goto out;
-		}
 		list_add(&page->lru, list);
 	}
-
 	mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, nr_pages);
 
 	return 0;
-- 
2.46.0.76.ge559c4bf1a-goog

