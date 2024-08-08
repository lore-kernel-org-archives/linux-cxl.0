Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99004190055
	for <linux-cxl@vger.kernel.org>; Thu,  8 Aug 2024 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131765; cv=none; b=PofftBqcsMTyZDaIL0B6pw8HA+P+tR/3SUqA3d45zcN9UHMg9Ec2D/X9Hy3Pw0epVnwBIh7t5m6H3UZrBzZg6pWVY6JkWRK1AZ7SVq3apz1G70zWOSxVsT3nLdFdco61XU5igozK29K6Z0bgKJe4KcSGkYUC5dxcN5ZPNO1DDjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131765; c=relaxed/simple;
	bh=8rI7joosp8awa/gMykJMhXumICc/dwUYMwOKiBmRUD4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSWMi1IYenJ8Nidm/O759UC+aaNhvgD9ddMnzeYdJxijshNCg3ySfN7gI8vRfPb5oOL9x/5WL52YngoNowYVNzfjo+4QC2tdJuHBfAatd1pjnxBrhUcr2jBw/QW5Y0CZS25zD7ZQPxcbqblTKl3bwcd6BN3H2lzJmjWmYOg///0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=I3DvwFD1; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="I3DvwFD1"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6bd6f2c9d52so2940116d6.3
        for <linux-cxl@vger.kernel.org>; Thu, 08 Aug 2024 08:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723131762; x=1723736562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3neo5ZpPv5S0nCnjgNJX6IioRmVVyTly9egBg9Jmdk=;
        b=I3DvwFD1yhMhHA27hYSf3nIl/t5ZOozebJXKpgalRDOdU9Qu00yO9H8ytGey8tlumc
         jOh5vejH/4EFFp54iHDfGExLyL/rlWj3dMxal74NrMcyIrkNfIzXXLYvuL37OautftRr
         Ee7xb5IwGhaBUH4CSmSFzzi19U+viFrk3e9HzIcvGnkpldmFEqKoKTzdEeBUGXtFZKPq
         Htw4dOxPDuFXEEGTPjmNb+diCNQowH5pDTULCMMtX1SO6OkMLpSAhG3WG49pLICF3Z7o
         kNmNr/jBSuq+h+AVfpHzz7Fk3cEV/+wzAXfGpeFtg1wg2clPA8632We/y5ecED111U9N
         7jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723131762; x=1723736562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3neo5ZpPv5S0nCnjgNJX6IioRmVVyTly9egBg9Jmdk=;
        b=oKEZxHs/bWLuV56e9TlPIah9/OILit7eKX7DjbI0jwMu2SIpvcLWPYHB1JSqoqu7Xs
         MFie42JPJDIkmhO+y3QP8t+9/JTa7Bbt51rRG0Td+G0LYphC2sQmD0h4jIbzAKCArUNu
         P38v245TjvowWU636R4YIl9SfNVhrzOZVxnb6vSsT5Cq5WlFvGXNcPkvbPGQYApMfW1a
         RsMrfqj0+xNufTBKJilmejkf3GoPgvnNHUI/iuoClIu13lFQRkOVTRCaJpWMnZv+Yt9O
         HLh3PZk05xtV2lHzNRHtAJVZGmqJdEG4LGRUbSz6NmDfe9hghBpKVRbcW9pOwVrD3mUW
         5PiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz5oVNUEbl0r/4c/t6R29+p7111jwS0UGJF+W73bEJIHOlUElpzFcYBx3v4+odp+594VDF9UUO0EML05zfY5hl9rzRMq7ZXLPz
X-Gm-Message-State: AOJu0YyVPH9MjLydDf1wN0Qeb3yAE2WcjnqjLk8Qpdj2kV0v8nb8mj54
	dHKy3Pgkc7zoxCX/RL6HMb9VXOFK9aGDbtfzDHMUgpa1MF16YkQ2udFSuQ1id24=
X-Google-Smtp-Source: AGHT+IESGfyB5HtXu4zt+BcOgb/gdPZpAEI0Yo2J7Xp64aGcrd7WAVMlzlbxNtl0uyZb/RHkn8qBZg==
X-Received: by 2002:a05:6214:3bc5:b0:6b4:4470:81a5 with SMTP id 6a1803df08f44-6bd6bcbb55fmr34927436d6.2.1723131762416;
        Thu, 08 Aug 2024 08:42:42 -0700 (PDT)
Received: from soleen.c.googlers.com.com (118.239.150.34.bc.googleusercontent.com. [34.150.239.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c7b72d9sm67160936d6.60.2024.08.08.08.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 08:42:41 -0700 (PDT)
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
Subject: [PATCH v3 2/4] mm: don't account memmap on failure
Date: Thu,  8 Aug 2024 15:42:35 +0000
Message-ID: <20240808154237.220029-3-pasha.tatashin@soleen.com>
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

When in alloc_vmemmap_page_list() memmap is failed to allocate, do
not account, the memory is going to be release at the function exit.

Fixes: 15995a352474 ("mm: report per-page metadata information")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 mm/hugetlb_vmemmap.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index fa83a7b38199..70027869d844 100644
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

