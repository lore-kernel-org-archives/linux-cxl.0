Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8210D391E61
	for <linux-cxl@vger.kernel.org>; Sat, 21 Mar 2026 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774105454; cv=none; b=F7gGU3Te7/OJbZL7vrbbJkD8GNEP96Oz3Up2UHxtRRGKI2KeRWLvvbY6+zMfYgwf928UaKHb9+apsqeam0sp6nCr9LOZPkMl/A9/L1uZJGtlGWpr4FQKuZRKmd36oA5gbrFOKh/miEJbDN8aXpN+eh28lD9uyXsmwDOBU6arFYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774105454; c=relaxed/simple;
	bh=4aQ6c6cuuLgbidEXo4JUWgHdhHA0vPcOx/O2oIS0jG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpoOHuzKlANoTwJSvWblUR/1tS23frnsNO9bHlDpIb9+p0BgkE3Ta1rnPtx9EQZbckOUUk/q+jPFYq4ouuz8swl0rsQIIPfcfS7eAGb/lPkSv887uBAVbNlyvgpOavVdHNWln2oO1GHpdGPReUm1jFVE9Jx1dt5pXHx+1t64cN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=R5ga+0W7; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="R5ga+0W7"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cfbbdbaf3cso280474785a.0
        for <linux-cxl@vger.kernel.org>; Sat, 21 Mar 2026 08:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774105452; x=1774710252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZlQlpoI2kyeTHm+ataFfQwGqNyciJ5dRDvCF4GFSVw=;
        b=R5ga+0W7o8L6lu7qQbjqT2SdycQ73uUvbF2FiFvjEK56tXWOWqR+yKjEszzehSyE6o
         6hnJZx0RSCqr71IQeYlSnHOuZOcQgK4Rq9oEMbh1QcQfhKzdYVv9MzHNDgnLi7ClFY29
         UMQft4AUZAaXEgE02UJwxjWGCgfxRgKexyuAwTjIFa1Qv4IjOazmy0ZPtaz7MscBCPYc
         6G1ZOMUiH9Df5wjwb21yKNPX/GbncOiDcg8dMCfiKscYozUlf9sOhKMYiFbe/9uRc77J
         /bs4tlnFNcpQL1bNsNryKve3Dmj39MDX3POD1OL2iwcgvMskOfQ46PGdjJLa9T2cjp4r
         EfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774105452; x=1774710252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EZlQlpoI2kyeTHm+ataFfQwGqNyciJ5dRDvCF4GFSVw=;
        b=PffIcioLQleMcMEPaaL8FnNQvg9M3a8xEjV+p4/5RucLFKJV64aSMhLLwvkLsDkzhp
         g/Ik+IP0rkUEIfe/Xy4qZqaob9D1IzmLRG00BGTBDu0Z0YGzLL448ou44VIY4i4LLzhU
         6s09yk7S14znj8GBOzw4I9X/FiuveJeEhly/jiNQu+fnFekricLVr+rHTC/mDt6rHtKA
         O4S0P+m4QG6Gnm17peA1Pupgx0622D0dkVgkWLD5irB+s4N/DT7ag8S+ikboAOLBUax/
         UFYVr9RoGSDiFyRMxN6MX/fsvKIZOz0Lx0kgB21J8MTkjn0Sk3Z+PtX2QkQJxbLcw8e7
         KBhg==
X-Forwarded-Encrypted: i=1; AJvYcCW/dOU3woinkRIgolV8ZBeEE7pCCOotOQNYsN89kjDIRf6JM8smJyaQ+7f65L1Te4QR0tq8LxmvlN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPUsCjbd7r2x80UGam6AtHenDwTRlRewq3JS1LEMoC3Y3tmfKo
	w39yU9A6zxhg4LCBur3677Xt71wqRTjAOY7QxHZt/GYrqhR3C0S3Wk0cU2+5OavNH/A=
X-Gm-Gg: ATEYQzyCoA1jYh5BdUYDOJM4YG6AyDQXLNiqhfD3EqeYdwko3Xfq2KfXyUEmnD1et2i
	7k7hNhQlx4clDsWeWDMms8h9Oec8YUWyWEuylmgyRWjhA4qQl6Hi6p57tCyyxz90ltNA4WZAG5g
	X6kwKzvseXOcoKNTlfvu8AdDrWav+O2NnFBp42XrPMNoPnrrMvGQ5hPfx+bgF8Oi5BdZGxbhkFf
	1K2PyQk9A1On6p+wKgC+WYdC4tIw2nvQkde4dOI6+8WcdbE71cnkUJS++XrP/zlHujQewpb7U8A
	L2ZnLkxdxg5dmWdsmicQQCSZM5vUswIvvh7ZVVpqfPtdeZomSutnBpAWVFV7xCtYKDHcEVjYfCs
	9GKWRIfgXttO0gBeAt+9T/Amv8kYI878suXZEMHnnj6Idegvp3Zb4Syqw4z4bXB7UBP/QD0xAaZ
	lHt/THFOYUZgNVCX3TnWN6k3th95PknCKFCphEKgXqNhaTPDCFZySqEM4luX948HAQ45snfjPSD
	OGxyKh3tRiHkGvFUYzpILeh7w==
X-Received: by 2002:a05:620a:454b:b0:8cd:8ce4:c0ad with SMTP id af79cd13be357-8cfb9e4b1b4mr1481729385a.22.1774105452426;
        Sat, 21 Mar 2026 08:04:12 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc90ba89fsm391979885a.40.2026.03.21.08.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 08:04:11 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	osalvador@suse.de
Cc: dan.j.williams@intel.com,
	ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 2/8] mm/memory: add memory_block_align_range() helper
Date: Sat, 21 Mar 2026 11:03:58 -0400
Message-ID: <20260321150404.3288786-3-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321150404.3288786-1-gourry@gourry.net>
References: <20260321150404.3288786-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory hotplug operations require ranges aligned to memory block
boundaries.  This is a generic operation for hotplug.

Add memory_block_align_range() as a common helper in <linux/memory.h>
that aligns the start address up and end address down to memory block
boundaries.

Update dax/kmem to use this helper.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/kmem.c     |  4 +---
 include/linux/memory.h | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index eb693a581961..798f389df992 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -26,9 +26,7 @@ static int dax_kmem_range(struct dev_dax *dev_dax, int i, struct range *r)
 	struct dev_dax_range *dax_range = &dev_dax->ranges[i];
 	struct range *range = &dax_range->range;
 
-	/* memory-block align the hotplug range */
-	r->start = ALIGN(range->start, memory_block_size_bytes());
-	r->end = ALIGN_DOWN(range->end + 1, memory_block_size_bytes()) - 1;
+	*r = memory_block_align_range(range);
 	if (r->start >= r->end) {
 		r->start = range->start;
 		r->end = range->end;
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 5bb5599c6b2b..17cdf6ba3823 100644
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
+ * memory_block_align_range - align a physical address range to memory blocks
+ * @range: the input range to align
+ *
+ * Aligns the start address up and the end address down to memory block
+ * boundaries. This is required for memory hotplug operations which must
+ * operate on memory-block aligned ranges.
+ *
+ * Returns the aligned range. Callers should check that the returned
+ * range is valid (aligned.start < aligned.end) before using it.
+ */
+static inline struct range memory_block_align_range(const struct range *range)
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
2.53.0

