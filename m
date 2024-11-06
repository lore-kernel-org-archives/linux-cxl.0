Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3A9205154
	for <linux-cxl@vger.kernel.org>; Wed,  6 Nov 2024 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908747; cv=none; b=OhxxFJFV0aEcuHmOMTrwiVTwoVqDza1y6AnBhij/9XVaTa+aiR2mUeb8tzuONGh50aYHBYFm/GICTEBq5L3Z8F9HEo47RcZlwzdH7JpWxT0fVVU8pq328OgDnjvUvnZGZwovR6XddvLAb0Abz0A1zSoqUqXKQs2VobAZ6keIlHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908747; c=relaxed/simple;
	bh=SC4txGz5NoH743U6+tsH0RKT8dY+2Y1qyxiWEtmJVVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpUqSQcZgZqy0cJi9hKl42vT4T+XF++mMe2loL7a5HdY1K/uCNa5RkTkGx83XnG0ordLQneqqxQbDeDVv3vHngK8AnwV2IyCDDi5JADkWYLIn/pRbD0a3i19pzsdHTDNVTXLWbubzdBpqfc+3+9rz34rIrYiS2bZ3BUHjR3IVzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qBwZo1GP; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qBwZo1GP"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b15d330ce1so503504885a.1
        for <linux-cxl@vger.kernel.org>; Wed, 06 Nov 2024 07:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730908744; x=1731513544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhjUN4fArKWWoXRi7BXSpLcpyo3J42V+ZDp+ucOnHvE=;
        b=qBwZo1GPAzNG4RgIgkz34dzNdRI1UYQ0/49eFDAqcm6ZEsaT36dOWd9XS7CvJoXFlz
         qCPxRJw3XQLomnG2xGUzcZ0aKtnLF/SoaQyBKYRdw+r4wL/O7E9LM7QhKl4VlxfLxlst
         yNGWKB4IWbdgORa5ptLYfD2aNbTf1I/DKC8xwkd8F3G/dgX4SY+92shDH/NpbIiU8Mhd
         0634kJv4QUrjpijMnnt4yHuM1PKyMiMFcLV5P3rLKoxtYRln0uEwvwbd3wFhd1GNhdAt
         T/4XjwFUuTs+xn7H3+KtFTSmcnQFT73fZ/0Qdpbre/kRc7XpI1DhBMHVqg67bL7qtDrS
         o+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730908744; x=1731513544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhjUN4fArKWWoXRi7BXSpLcpyo3J42V+ZDp+ucOnHvE=;
        b=r+/Q7dVFPLVtONGcaueRhK8lDUBhyeR9S82lAxmFY/M6Ztq99/okj4v6gg7z/CR9Rz
         wjJftI7hbPbSbZs9xjK6l9J0NUuPBLFW2vqZKUKWw2tt0syxhreZyoNG45Nf90sTXxBf
         YB7+r1jkyWex/RjPcGIty18z29jk28PpMWOuc+Oai9MZdflQILah2GKcNyQXibP7Y0+s
         J2LiqrMC+jHF4SuE0so6XoGOmFV97NvK1sIlIcEUOyC2tiXA5b0DkKgOW9neuqjO8+Gl
         H3Fl+vxhnUOhoT2nnhg1FmguuALbolz9HjBq/2honV+KhrKcPONGyMPGypjjKqMmmJHb
         cTaQ==
X-Gm-Message-State: AOJu0YxTLZ/3zOzc9oBRFZ07Ynbqs7qtUd0QXFqQkpj4Ud0MFEWulrMh
	zaMSbN4G8AM2QefEee0Zq85lRXhdbS9/ER5Fq9nkRgrGx3aAjsJsvkWpFCSuFYs=
X-Google-Smtp-Source: AGHT+IGyyNaqJP5GT84XkBpTnZi+GYICvytezSItQpJFP+BO2bYKSnE0l+VTemNGpDBYq2sb9frOVw==
X-Received: by 2002:a05:620a:190f:b0:7a9:b456:c5e6 with SMTP id af79cd13be357-7b2f253d534mr3445707985a.42.1730908744203;
        Wed, 06 Nov 2024 07:59:04 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39f7b85sm641377285a.31.2024.11.06.07.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:59:03 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
	Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	rrichter@amd.com,
	Terry.Bowman@amd.com,
	dave.jiang@intel.com,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	gourry@gourry.net,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rafael@kernel.org,
	lenb@kernel.org,
	david@redhat.com,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	rppt@kernel.org
Subject: [PATCH v6 2/3] x86: probe memory block size advisement value during mm init
Date: Wed,  6 Nov 2024 10:58:46 -0500
Message-ID: <20241106155847.7985-3-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241106155847.7985-1-gourry@gourry.net>
References: <20241106155847.7985-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Systems with hotplug may provide an advisement value on what the
memblock size should be.  Probe this value when the rest of the
configuration values are considered.

The new heuristic is as follows

1) set_memory_block_size_order value if already set (cmdline param)
2) minimum block size if memory is less than large block limit
3) if no hotplug advice: Max block size if system is bare-metal,
   otherwise use end of memory alignment.
4) if hotplug advice: lesser of advice and end of memory alignment.

Convert to cpu_feature_enabled() while at it.[1]

[1] https://lore.kernel.org/all/20241031103401.GBZyNdGQ-ZyXKyzC_z@fat_crate.local/

Suggested-by: Borislav Petkov <bp@alien8.de>
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/init_64.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index ff253648706f..2622dc7c78ba 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1452,16 +1452,21 @@ static unsigned long probe_memory_block_size(void)
 	}
 
 	/*
-	 * Use max block size to minimize overhead on bare metal, where
-	 * alignment for memory hotplug isn't a concern.
+	 * When hotplug alignment is not a concern, maximize blocksize
+	 * to minimize overhead. Otherwise, align to the lesser of advice
+	 * alignment and end of memory alignment.
 	 */
-	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
+	bz = memory_block_advised_max_size();
+	if (!bz) {
 		bz = MAX_BLOCK_SIZE;
-		goto done;
+		if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+			goto done;
+	} else {
+		bz = max(min(bz, MAX_BLOCK_SIZE), MIN_MEMORY_BLOCK_SIZE);
 	}
 
 	/* Find the largest allowed block size that aligns to memory end */
-	for (bz = MAX_BLOCK_SIZE; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
+	for (; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
 		if (IS_ALIGNED(boot_mem_end, bz))
 			break;
 	}
-- 
2.43.0

