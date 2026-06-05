Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED363C5838
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 21:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780694362; cv=none; b=LqvLeLPJOqqPpQjaT01wrWqI4OKyJwMhW9yZ1AXp3sMyCsyjGhj7/SdSVIMHUeLghlvOvlqrVQb8DWLMcmZ1Mx0EBGjl2+ljVeVhgu2XiwV+ABUyYGDlZj+TMVqatrp/FpC4IRvW7tMl3+y2TvqDBq+QRnObuf0jnZ1WzWZSXok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780694362; c=relaxed/simple;
	bh=YJUG2rEhZbZqBSQUXpRy6AdNHxz+6J4JkjRoL4CcAe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCxXAHRj1lwZcMu7OlL+PTbf3mGW+JFosRF3WCV2ctaSZhf6J6HWw30Cb2r3RaHYHRQzMrT4DDwVzza+n66qIUq4wsIC9XKGVWT5eJ08QWtbY+Siwg5upswZzcxkwY3+2CvxdF4xaHIR+WRTDRhh2yTMS5nONW1IS7Rpg5FeCnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dW6h/ZpC; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dW6h/ZpC"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ccf887de87so27328666d6.0
        for <linux-cxl@vger.kernel.org>; Fri, 05 Jun 2026 14:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780694357; x=1781299157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8jLd2zqvW28XOaQQClXDDIz8D3hNjBgUh/nqgs8cgE=;
        b=dW6h/ZpCK+KXuztZ7tEiWySIC9UaJFQEnGX0l+MBOiFUAzMijD33W78SUYk+Q8Ysm7
         pEArvIxiJeSgh9gJxhKzpZOXPaBCsr+d42cDt1fJHzgF0wa99gpisD7KFIPHTVd8OOl/
         XiZmy9WSuc2pC5qwTgXi4pW0RckTbJdnqsIthMk4+OLf+QB78Mi56Idv1CvL722uIFiZ
         5xXFxdVA1Td8OkbKcxyZkC7+RtbiqvIgWKEE9L9nwD+tgr8Odj6IusiHNOkVu0s4+mOy
         UEKJ+4fu8BO2SSbNaqrKLsfyWHt0cnxsjgUXxIjv4mZ1MzecOW71on7fAc5bOegh2kZV
         km3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780694357; x=1781299157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f8jLd2zqvW28XOaQQClXDDIz8D3hNjBgUh/nqgs8cgE=;
        b=Nj/Xd9jnNQcgaHDSKTjg3af+PFdAjoRDpadNSHTTnQ8JiAvjxebMIbL08OjeNs28da
         J8u8HT9mWRMa8XKye8QAmd7nZSEJs7KfDu6iqp5PQhiLmGyaslmVeMIYKmo/ryKBhGNd
         Gce4PsBuj4R/Lm2npvo/czW7Dwy5SjCcNvF3JSYIp48G5+pBKYBaCJgActerdEnSaB4w
         CwBIQJnYIEDLGuVJJfeE/vpfp1VwXjtb7w+eTOwYKcElWBoO8w3nc6b/vTyYKdhSqCFo
         TPCK8shx7qDzR4RLg9xDnXLxivZyN1aGWq/fDCltPqvkOV2m/rvDoVeD2MxB8a/HNIuE
         cjxA==
X-Forwarded-Encrypted: i=1; AFNElJ8yQUCP6Dv1/muJaPEiX38OgoMDl156Ku18iQf14pMBtUwgWkRhVlnxxZ/pqqr6XNUoKDQ1AZsYaDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxku0AtNygT4aT1YroVAzOKK3ROn1jf77r27RjS7LRaH75ZDa6W
	YQ8VvSuUkhYXccxjODLjFbvNFzSlSnVF0bhiHS7i+q/kbppr5a2Z9osJVP3uCVU9HU4=
X-Gm-Gg: Acq92OErVR3yBqLCwgMuqbPb0tOTXbtZ2MsSkHgGMHDJPAFF6sqYqT+2x5rvA0rRRLZ
	DJFGAW5Uycich1BjFZiFX3+R2jY/cLN3K/+JrG1dcs7pbtmaLLK07HVIYWx/W3LXaJyhs5c/qTk
	hhtFVXiEezUE8QRWSuJLKU9pv7lBotZ858ANAzUknZk68fRVyqCnOsl2xMIQ72yel9sgqUIHDMa
	2yTTHmHllDRuIQ6xu38HHWGLRjD6o4TV9YqtZlOOM8seOXnihVix99eQXTdGO2XB6lb/jcUVByk
	XykDepUAAixfiemYbARvKgvMC0PYswwX2z+Yqy7Soh7Tq7Ds1mVvHyTsfEc3aGP0aOGYqf+G/sI
	vm81D8CmSFjnzyvd+XHndbtVclHbopPZIqtkN9nbdCccdhMBkKfJLO2h0N1zk9hyaopCJ7UPHjQ
	Dt56Hb1xYlz81RGdE09inbsBWPAIGfXae5S5CGL6eXCnAYIGan/fVr0mNJqqxObv5m8HeG3Roc4
	rP+qFh31lfcCTA2a0nuFgo=
X-Received: by 2002:ad4:560e:0:b0:8cc:f88e:2703 with SMTP id 6a1803df08f44-8cee5fe4e30mr72255516d6.12.1780694356950;
        Fri, 05 Jun 2026 14:19:16 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd277bbcsm90518196d6.49.2026.06.05.14.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 14:19:16 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org,
	nvdimm@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	linux-cxl@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	shuah@kernel.org,
	gourry@gourry.net,
	alison.schofield@intel.com,
	Smita.KoralahalliChannabasappa@amd.com,
	ira.weiny@intel.com,
	apopple@nvidia.com
Subject: [PATCH v4 1/9] mm/memory: add memory_block_aligned_range() helper
Date: Fri,  5 Jun 2026 22:19:03 +0100
Message-ID: <20260605211911.2160954-2-gourry@gourry.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605211911.2160954-1-gourry@gourry.net>
References: <20260605211911.2160954-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory hotplug operations require ranges aligned to memory block
boundaries.  This is a generic operation for hotplug.

Add memory_block_aligned_range() as a common helper in <linux/memory.h>
that aligns the start address up and end address down to memory block
boundaries.

Update dax/kmem to use this helper.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/kmem.c     |  4 +---
 include/linux/memory.h | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index a18e2b968e4d..592171ec10f4 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -33,9 +33,7 @@ static int dax_kmem_range(struct dev_dax *dev_dax, int i, struct range *r)
 	struct dev_dax_range *dax_range = &dev_dax->ranges[i];
 	struct range *range = &dax_range->range;
 
-	/* memory-block align the hotplug range */
-	r->start = ALIGN(range->start, memory_block_size_bytes());
-	r->end = ALIGN_DOWN(range->end + 1, memory_block_size_bytes()) - 1;
+	*r = memory_block_aligned_range(range);
 	if (r->start >= r->end) {
 		r->start = range->start;
 		r->end = range->end;
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 463dc02f6cff..9f5ef0309f77 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -20,6 +20,7 @@
 #include <linux/compiler.h>
 #include <linux/mutex.h>
 #include <linux/memory_hotplug.h>
+#include <linux/range.h>
 
 #define MIN_MEMORY_BLOCK_SIZE     (1UL << SECTION_SIZE_BITS)
 
@@ -100,6 +101,27 @@ int arch_get_memory_phys_device(unsigned long start_pfn);
 unsigned long memory_block_size_bytes(void);
 int set_memory_block_size_order(unsigned int order);
 
+/**
+ * memory_block_aligned_range - align a physical address range to memory blocks
+ * @range: the input range to align
+ *
+ * Aligns the start address up and the end address down to memory block
+ * boundaries. This is required for memory hotplug operations which must
+ * operate on memory-block aligned ranges.
+ *
+ * Returns the aligned range. Callers should check that the returned
+ * range is valid (aligned.start < aligned.end) before using it.
+ */
+static inline struct range memory_block_aligned_range(const struct range *range)
+{
+	struct range aligned;
+
+	aligned.start = ALIGN(range->start, memory_block_size_bytes());
+	aligned.end = ALIGN_DOWN(range->end + 1, memory_block_size_bytes()) - 1;
+
+	return aligned;
+}
+
 struct memory_notify {
 	unsigned long start_pfn;
 	unsigned long nr_pages;
-- 
2.54.0

