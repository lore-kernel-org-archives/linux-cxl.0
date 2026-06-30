Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E907E2FB965
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 21:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854332; cv=none; b=qODLTVagku6i7aQcB5p0Y0PonPaCWSQbFvTV3q6rEqGbkbI+HdnAlMY25c/mbbNPpmOtuHU5mJ+VtSSQZ9XM3EltldyqYidW8iYzzMfNKyEmfOdqf6z6EYuvMHnbB9M/dIJec/Buhg7KVQWdQrkF4XZLck471mGGS9d+bFpFDqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854332; c=relaxed/simple;
	bh=AxVPyNXAmBtaz2ot1Td7JrEyAQDmKXyudrs+ZGIIj8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsrbgALZNmRTq5yVoHnLCw0Tgqpib+IPssok9Sqjo5fV6lCCC1ixD59wYq/v6RbbzNotd0OeAlIbTH+1iAFeX9VcVfWBLxd4d32QzHnVX5m9hkhD4W0/uiai3nFwPlYPsAy3q49sFXs/cEZd5wrNW47W85QCOI1CNSLYmOFf/z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MdPhCWE9; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MdPhCWE9"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8ef7b7651ecso12396606d6.1
        for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 14:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782854330; x=1783459130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SI86A/tUZQ+3KTQEDQQAFYWb5y1VZ6lRAmoYBSC2uM=;
        b=MdPhCWE9O4mkoklMV0Jd97OnJ9EW/4Jo9AOCGHCHJ0wdxl5AYYDTxBsH7e97PHOU+M
         o5csYTSvVm05J2fe9WKv+PHwUi14HVXaaePChN1T6Wm31vPHiiygzOyp8iHK1gF6qg2E
         i5Lo0IOdCBznILWWfPMwXiLeuUD1rJYt2hwTixlweD7wihrAoPo/DcLzuSO5pmuc2TZ6
         /MV3L/ZUTu3DAyi3IqzD4pQGRLR1DjxF4WP7RXMG26V+whwol6Hw0SvfiTADzbEGH1L7
         4CDdyxyvOQx6QokfnfKWgYqt/9tdMcimDDAtDK1NGo0Z5KIBQfsQ1o4Zagik/JOSJWy4
         Ri4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854330; x=1783459130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8SI86A/tUZQ+3KTQEDQQAFYWb5y1VZ6lRAmoYBSC2uM=;
        b=bI/7fLb8aUxrMjLtv3HY9z59e7P97tr5F6nRSmV+Nrej6jNdYt4W/a2SZWp5BY9rRM
         toT6PRAzhGDKG+oJ+NTFdOTV/sh1akFNEfC61bwO4F+x3Doufko+Dt4Gkl0HC6BWij9d
         ZuDrI8yP0J0QMKYRaAsGTZk0wQGagekhusQ4gzCXucqfFLfJ6lnBu9YRVlvylr5oAXoX
         +I3bhIEsjyMXLdU1glMvK4P/EooUoOovpW8wjsRhRetlPCTiJzEuqlP+/TaMsl57nI6i
         /Y44erSpHrmgx6pETB6YbA/JXp8V79DYlXCBHEcPlBhqj/HctxqaoVtmQ3EfyGAyDaFX
         vOJw==
X-Forwarded-Encrypted: i=1; AFNElJ/Pvz/g77a1TiNFn32fkl/KjKA8Sh9iX1ZrknKjh1xBcWzT76mtRcJF5qFR9zZlDraofam+RvVuTBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX00XTfh3H9mBVI2KrwPYdpKDLAJfJ5RT/LNSbQeK0VesdcPrw
	q03orSgCbAUrQ1QS67ssrfKzYPxxKhZiokiY+ZF+7CmmqHvNm4LpnayQsZfNSW8MgDM=
X-Gm-Gg: AfdE7cnZ2CERuynRFyhecqkDU3wtPf+G2DBavnrapwg2MSoD4cZ3uYxhlImZx0AT/Fn
	SKNqxPMNbhL1fRMymsLs3ct5lGbsqZX9LFIYKDvfbM5qBWMH7bWBoXCc+DS3Lcejuhj0QgORpMf
	QbrbvivlDHbIVXyVspyH7ynW/QejrmRFCT3sJaSahIQSElQIV8sz8v+CLi3lwl1vlZ3wdYszSMp
	R6d9MYCMKI98dajr0JEsN1j/OvTIM+ExwMtR5MHOzADy/AnXYiAsSJpJIw9+tYks9qMCD/XqhwA
	yJtkFwHVpQpHRN2YK4r+DN2BRsnYVZ2sSNixJwNH+tXa7cPVxC+S2Q5qIPFyZhKEsJqAk0P0VUk
	CpwZCuC/G9ynnJMkDpCfi7pkY5wShhGV2QGfn68u+4MkDjv+EyNz8kTIuuE8HC7bA76Prt42MYP
	mwMyPUkA8xyPzn9AY4g1AhP4vcm1dKfHaH1Ns8TZTgHXdQRosccnjgpYmjkWWf/aAecWRyk+fOP
	g==
X-Received: by 2002:a05:620a:6019:b0:92b:3203:ea70 with SMTP id af79cd13be357-92e696f3833mr471607485a.12.1782854329895;
        Tue, 30 Jun 2026 14:18:49 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e62366303sm335924285a.40.2026.06.30.14.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:18:49 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kernel-team@meta.com,
	david@kernel.org,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	shuah@kernel.org,
	gourry@gourry.net,
	iweiny@kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	apopple@nvidia.com
Subject: [PATCH v6 01/10] mm/memory: add memory_block_aligned_range() helper
Date: Tue, 30 Jun 2026 17:18:33 -0400
Message-ID: <20260630211842.2252800-2-gourry@gourry.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630211842.2252800-1-gourry@gourry.net>
References: <20260630211842.2252800-1-gourry@gourry.net>
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
boundaries.  Guard against end underflow when the range falls below the
first memory block boundary, returning an empty range instead.

Update dax/kmem to use this helper.

Signed-off-by: Gregory Price <gourry@gourry.net>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
 drivers/dax/kmem.c     |  4 +---
 include/linux/memory.h | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 3 deletions(-)

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
index 463dc02f6cff..1783299073e4 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -20,6 +20,7 @@
 #include <linux/compiler.h>
 #include <linux/mutex.h>
 #include <linux/memory_hotplug.h>
+#include <linux/range.h>
 
 #define MIN_MEMORY_BLOCK_SIZE     (1UL << SECTION_SIZE_BITS)
 
@@ -100,6 +101,32 @@ int arch_get_memory_phys_device(unsigned long start_pfn);
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
+	aligned.end = ALIGN_DOWN(range->end + 1, memory_block_size_bytes());
+	/* No whole block fits (e.g. range below the first boundary): empty. */
+	if (aligned.end <= aligned.start)
+		aligned.start = aligned.end;
+	else
+		aligned.end -= 1;
+
+	return aligned;
+}
+
 struct memory_notify {
 	unsigned long start_pfn;
 	unsigned long nr_pages;
-- 
2.53.0-Meta

