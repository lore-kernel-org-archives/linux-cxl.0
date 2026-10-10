Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C46038E8A7
	for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791649296; cv=none; b=JUGi2zLST1DV1zcIfblVblzx/ipqi9koHotgdicCirT8qP8tlDJuJeJjb1V+skTigkbdEHgBLc4LwtNLJSkL5Zc19Ngy3D/aSx2SEwd1rSFscEJKXuMZt1NCXeDO3PK254oG3pr32RZkNTGkkRCTADP5QrFyO3BBmewreWeZ+0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791649296; c=relaxed/simple;
	bh=Jf9uxSOi0/xM7Jz6cv13LtM+3Zv+s2pvZFEqWS1Sh2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHxgHbwTW/eVXfH6cOYcB8+OCVojClc3jOZuYhFLcU07sWNVFBr6UN70ddOWu7H7Wp9MtLbRC064U3jQhH39vSlHb9167pmwmU209MIiYolTSUbFQS6GmqTlbz9ZejrsBKEMn6FRzXLpVdaCjXgh65nGshMQr6zl8z+rr3dQqJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amcIm2kT; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amcIm2kT"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-15dd124bbe7so1373350c88.1
        for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 09:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791649293; x=1792254093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EOFRoJt6U85Tsj+Ev9WdukczofMEitvTriF7KGly0Fw=;
        b=amcIm2kTOo/7Cy4qE08bncn+JjF7EGQQfqdFcaq91K9B46gYi7rw7ZzhfmNb6w83bS
         nCalWLB2harh4jzJ4JgNNkC69Hk3NQKdqmQ04QH2toQ+JsYSsVN5zVEpoR43ywSgffqb
         6v49iv6xHJCDNQdTaqiDfhgYyM1kml3ejp/+V1F6Hr8rXhgDXh/3LfZrS2YIELGeTOTx
         JHuxZBgPQYCQE+am9Ei+K3rELdexUqIQ/MiVuSwRDmCw5rHYdAuUFfsfFF1bJNudpNFH
         SD1Rwc8a7pXmGOLz3vRXOCdLFzB67DsUaOkw1x5UF8l3C6D+i3si/x7tiT0IH+ymAVEM
         Nabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791649293; x=1792254093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EOFRoJt6U85Tsj+Ev9WdukczofMEitvTriF7KGly0Fw=;
        b=I0UaTcq7iVqPccS/Myx2n0zonVwh4p4ozB71iapnmIlAHbaSZ8aaLX515y2DA2wBPn
         7hTzoIx4zFvt8JWYcAbpQsYelIE2LoS/MgimL3W6oBB6yFeMaORglbFNZJ/wcNh6z5VZ
         JPectwby+Z6FS3UmUIVgvdZxvwvQTSU76Nc6aLHJ7p0GokMLQ6cPzedDRPLPZwRTub6N
         uydC3OL0IZhig8kOHwK9K/Oy7dHg23hDmhKB8O7qNv/IsG+oSz2/O0HhK6zJzfLyfuIr
         v5Bbh8BhyxCyPUPUlbs1saWRe/gFbfP9WUsqQIEUFt6dqDK0hWisTAXM96guXfLoROSM
         I3ww==
X-Forwarded-Encrypted: i=1; AKwUvByDi/UAt1fbsQP5ieBQI4V0ugJP/1Wo2TB3T+eOek4TFPQHuUlaPEnbMwiOnXPX/WHAvyZwM0Lt0OM=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2WAYUT/N1LGWH6Wy8U+36QzFPS5j2nIlloV537sUhjWkggaaC
	uPRZu7iJ/pYF0pFvAA1yS2AGxpgTokYuABqGcLA8J5tr9DRG9bgtyisZ
X-Gm-Gg: AYBFou1pmmqakSsMewGbTbiQn3IgnYy1EQcpMPjScUCuXmCE4lriZYpB07jWh6lslKJ
	+3LmGPKPzzdfmp6aQqucfKLeGxJk0sCeQVzR2kMnmu8ZZa6LEsZkaEwVDAFsoGFxM2h4qjtixNO
	ClPKC55sCnAGxIEvWnbvyieO2rBPU6PEE6DKakpMAXVUm69atEnbsB4iwFK9GXp19OStV2K60iI
	4uzI61+1m8gH18kZRFhC+U9zWh25y7xwCE1dsQu7lRpe0cXNPPp8D8rzKhlSA3UjlYzyhathyjp
	71UuzB2VbOcMLW3ovKIM9q38aQkO6Rh+yJld4zpn2oJQv0EwbnGAz8wQVzY2NFDwshywiq8poK0
	WFIeZ7A1MZp8ufSKEOqwzjcwOxJ79wBiAhzKhy3YfDm5C+SK/1ku2T/esWx1ZqeU7BtAgO/iuG3
	dHkN8KUZcRbkGBxmDSdQYvQ6Jh+nyAqB8iTPq4KaFL9rrVEWCjn6uKt0uGYzwTwLrnPBJ4TOFkJ
	IgGb0DgIG26o6PXZQ==
X-Received: by 2002:a05:701b:2212:b0:144:c124:279 with SMTP id a92af1059eb24-16a5f7c79c8mr7463252c88.35.1791649292992;
        Sat, 10 Oct 2026 09:21:32 -0700 (PDT)
Received: from acer-nitro-anv15-41.. ([115.96.176.39])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a3f6186fsm15778622c88.14.2026.10.10.09.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 09:21:32 -0700 (PDT)
From: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Breno Leitao <leitao@debian.org>
Cc: Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Kiryl Shutsemau <kas@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Subject: [RFC PATCH 3/5] mm/memory-failure: Add a pre-online poison registry
Date: Sat, 10 Oct 2026 21:50:11 +0530
Message-ID: <20261010162017.62506-4-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010162017.62506-1-shaikhkamal2012@gmail.com>
References: <20261010162017.62506-1-shaikhkamal2012@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A frame can be known bad before its backing memory is onlined. A CXL
Type-3 device retains poison as DPA-based Media Error Records and can
report those records through GET_POISON_LIST after a reboot, kexec, or
device hotplug.

CXL poison can be retrieved while a region is being prepared, before
dax/kmem calls add_memory_driver_managed() for the range. At that point
there is no initialized struct page on which memory_failure() can
operate. The poison information must therefore be retained until the
corresponding pages pass through memory initialization.

Add a registry of sorted, nonoverlapping poisoned PFN ranges. Each
registration represents one owner and its independently managed memory.
For example, a CXL region registers the poisoned PFN ranges translated
from its device poison records and receives an opaque handle for that
range set. A second CXL region receives a separate handle for its own
ranges.

The owner uses its handle to remove exactly its registration after the
associated memory can no longer enter the allocator. Removing one CXL
region's registration does not affect poison ranges registered by
another region.

Keep each registered range set immutable and protect the registration
list with RCU. This keeps allocator-side lookups lockless while allowing
a registration to be removed safely after an RCU grace period. A later
patch will consult the registry before initialized pages are released
to the buddy allocator.

Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
---
 include/linux/memory-failure.h |  92 +++++++++++++++++
 mm/memory-failure.c            | 175 +++++++++++++++++++++++++++++++++
 2 files changed, 267 insertions(+)

diff --git a/include/linux/memory-failure.h b/include/linux/memory-failure.h
index d333dcdbeae7..ebb988c2fe12 100644
--- a/include/linux/memory-failure.h
+++ b/include/linux/memory-failure.h
@@ -11,9 +11,73 @@ struct pfn_address_space {
 				unsigned long pfn, pgoff_t *pgoff);
 };
 
+struct preonline_hwpoison;
+
+/**
+ * struct preonline_hwpoison_range - Pre-online poisoned PFN range
+ * @start_pfn: First PFN in the range
+ * @nr_pages: Number of consecutive PFNs in the range
+ */
+struct preonline_hwpoison_range {
+	unsigned long start_pfn;
+	unsigned long nr_pages;
+};
+
 #ifdef CONFIG_MEMORY_FAILURE
 int register_pfn_address_space(struct pfn_address_space *pfn_space);
 void unregister_pfn_address_space(struct pfn_address_space *pfn_space);
+
+/**
+ * preonline_hwpoison_register - Register poison before memory is onlined
+ * @ranges: Sorted, nonoverlapping PFN ranges in ascending start PFN order.
+ *          Adjacent ranges are accepted, but callers should coalesce them.
+ *          The array is copied and need not outlive this call.
+ * @nr_ranges: Number of entries in @ranges. Must be nonzero.
+ * @handle: Registration handle returned on success. Set to NULL on failure.
+ *
+ * Register PFN ranges that must be withheld when their backing memory is
+ * initialized. Pass the returned handle to
+ * preonline_hwpoison_unregister() only after the memory can no longer enter
+ * the allocator.
+ *
+ * Return: 0 on success, -EINVAL if @handle is NULL or @ranges is empty,
+ * unsorted, overlapping, or contains a zero-length entry, -EOVERFLOW on PFN
+ * wraparound, and -ENOMEM on allocation failure.
+ */
+int preonline_hwpoison_register(const struct preonline_hwpoison_range *ranges,
+				unsigned int nr_ranges,
+				struct preonline_hwpoison **handle);
+
+/**
+ * preonline_hwpoison_unregister - Remove a pre-online poison registration
+ * @handle: Handle returned by preonline_hwpoison_register(), or NULL
+ *
+ * Remove @handle from future pre-online poison lookups. The caller must first
+ * ensure that the associated memory can no longer be initialized or handed
+ * to the page allocator.
+ *
+ * Pages already marked as hwpoison remain marked.
+ */
+void preonline_hwpoison_unregister(struct preonline_hwpoison *handle);
+
+/**
+ * preonline_hwpoison_intersects - Does a PFN range cover a known-bad frame?
+ * @start_pfn: First PFN of the range to test
+ * @nr_pages: Length of the range in frames
+ *
+ * Return: %true if any registered range overlaps [@start_pfn, @start_pfn +
+ * @nr_pages), %false otherwise.
+ */
+bool preonline_hwpoison_intersects(unsigned long start_pfn,
+				   unsigned long nr_pages);
+
+/**
+ * preonline_hwpoison_contains - Is a single frame known bad?
+ * @pfn: Frame to test
+ *
+ * Return: %true if @pfn falls in a registered range.
+ */
+bool preonline_hwpoison_contains(unsigned long pfn);
 #else
 static inline int register_pfn_address_space(struct pfn_address_space *pfn_space)
 {
@@ -23,6 +87,34 @@ static inline int register_pfn_address_space(struct pfn_address_space *pfn_space
 static inline void unregister_pfn_address_space(struct pfn_address_space *pfn_space)
 {
 }
+
+static inline int
+preonline_hwpoison_register(const struct preonline_hwpoison_range *ranges,
+			    unsigned int nr_ranges,
+			    struct preonline_hwpoison **handle)
+{
+	if (handle)
+		*handle = NULL;
+
+	return -EOPNOTSUPP;
+}
+
+static inline void
+preonline_hwpoison_unregister(struct preonline_hwpoison *handle)
+{
+}
+
+static inline bool preonline_hwpoison_intersects(unsigned long start_pfn,
+						 unsigned long nr_pages)
+{
+	return false;
+}
+
+static inline bool preonline_hwpoison_contains(unsigned long pfn)
+{
+	return false;
+}
+
 #endif /* CONFIG_MEMORY_FAILURE */
 
 #endif /* _LINUX_MEMORY_FAILURE_H */
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 60e968243470..e89b400c3fa2 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2291,6 +2291,181 @@ static void kill_procs_now(struct page *p, unsigned long pfn, int flags,
 	kill_procs(&tokill, true, pfn, flags);
 }
 
+/**
+ * struct preonline_hwpoison - Owner of pre-online poisoned PFN ranges
+ * @list: Entry in the global owner list
+ * @rcu: Used to defer the free past a grace period
+ * @nr_ranges: Number of ranges in @ranges
+ * @ranges: Sorted, nonoverlapping PFN ranges
+ *
+ * The ranges are immutable after the object is added to the owner list, which is
+ * what lets readers walk them under RCU with no lock.
+ */
+struct preonline_hwpoison {
+	struct list_head list;
+	struct rcu_head rcu;
+	unsigned int nr_ranges;
+	struct preonline_hwpoison_range ranges[];
+};
+
+static LIST_HEAD(preonline_hwpoison_owners);
+/* Serialises writers only. Readers use RCU. */
+static DEFINE_MUTEX(preonline_hwpoison_lock);
+
+static int
+preonline_hwpoison_validate(const struct preonline_hwpoison_range *ranges,
+			    unsigned int nr_ranges)
+{
+	unsigned long previous_end = 0;
+
+	if (!ranges || !nr_ranges)
+		return -EINVAL;
+
+	for (unsigned int i = 0; i < nr_ranges; i++) {
+		unsigned long end;
+
+		if (!ranges[i].nr_pages)
+			return -EINVAL;
+
+		if (check_add_overflow(ranges[i].start_pfn,
+				       ranges[i].nr_pages - 1, &end))
+			return -EOVERFLOW;
+
+		/*
+		 * Require sorted, nonoverlapping ranges. Adjacent ranges
+		 * remain valid, although callers may coalesce them to reduce
+		 * storage and lookup overhead.
+		 */
+		if (i && ranges[i].start_pfn <= previous_end)
+			return -EINVAL;
+
+		previous_end = end;
+	}
+
+	return 0;
+}
+
+int preonline_hwpoison_register(const struct preonline_hwpoison_range *ranges,
+				unsigned int nr_ranges,
+				struct preonline_hwpoison **handle)
+{
+	struct preonline_hwpoison *owner;
+	int rc;
+
+	if (!handle)
+		return -EINVAL;
+
+	*handle = NULL;
+
+	rc = preonline_hwpoison_validate(ranges, nr_ranges);
+	if (rc)
+		return rc;
+
+	/*
+	 * The range array may be larger than a page, so do not require
+	 * physically contiguous memory.
+	 */
+	owner = kvmalloc(struct_size(owner, ranges, nr_ranges), GFP_KERNEL);
+	if (!owner)
+		return -ENOMEM;
+
+	owner->nr_ranges = nr_ranges;
+	memcpy(owner->ranges, ranges,
+	       flex_array_size(owner, ranges, nr_ranges));
+
+	/*
+	 * list_add_tail_rcu() publishes with a release barrier, so a reader
+	 * that observes the entry also observes the fully initialised
+	 * ranges[] above.
+	 */
+	scoped_guard(mutex, &preonline_hwpoison_lock) {
+		list_add_tail_rcu(&owner->list, &preonline_hwpoison_owners);
+	}
+
+	*handle = owner;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(preonline_hwpoison_register);
+
+void preonline_hwpoison_unregister(struct preonline_hwpoison *owner)
+{
+	if (!owner)
+		return;
+
+	scoped_guard(mutex, &preonline_hwpoison_lock) {
+		list_del_rcu(&owner->list);
+	}
+
+	/*
+	 * A reader may still be walking this entry. list_del_rcu() leaves its
+	 * forward pointer intact so that walk completes into the live list;
+	 * the free waits for a grace period.
+	 */
+	kvfree_rcu(owner, rcu);
+}
+EXPORT_SYMBOL_GPL(preonline_hwpoison_unregister);
+
+static bool preonline_owner_intersects(const struct preonline_hwpoison *owner,
+				       unsigned long start_pfn,
+				       unsigned long end_pfn)
+{
+	unsigned int low = 0;
+	unsigned int high = owner->nr_ranges;
+
+	/*
+	 * Find the first range whose inclusive end is greater than or equal
+	 * to start_pfn.
+	 */
+	while (low < high) {
+		const struct preonline_hwpoison_range *range;
+		unsigned long range_end;
+		unsigned int mid;
+
+		mid = low + (high - low) / 2;
+		range = &owner->ranges[mid];
+		range_end = range->start_pfn + range->nr_pages - 1;
+
+		if (range_end < start_pfn)
+			low = mid + 1;
+		else
+			high = mid;
+	}
+
+	if (low == owner->nr_ranges)
+		return false;
+
+	return owner->ranges[low].start_pfn <= end_pfn;
+}
+
+bool preonline_hwpoison_intersects(unsigned long start_pfn,
+				   unsigned long nr_pages)
+{
+	struct preonline_hwpoison *owner;
+	unsigned long end_pfn;
+
+	if (!nr_pages)
+		return false;
+
+	/* Fail safe: withhold a range we cannot reason about. */
+	if (WARN_ON_ONCE(check_add_overflow(start_pfn, nr_pages - 1, &end_pfn)))
+		return true;
+
+	guard(rcu)();
+
+	list_for_each_entry_rcu(owner, &preonline_hwpoison_owners, list) {
+		if (preonline_owner_intersects(owner, start_pfn, end_pfn))
+			return true;
+	}
+
+	return false;
+}
+
+bool preonline_hwpoison_contains(unsigned long pfn)
+{
+	return preonline_hwpoison_intersects(pfn, 1);
+}
+
 int register_pfn_address_space(struct pfn_address_space *pfn_space)
 {
 	guard(mutex)(&pfn_space_lock);
-- 
2.43.0

