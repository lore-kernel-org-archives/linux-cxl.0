Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4653D9DD1
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313088; cv=none; b=QKLoVZOsQvjcfj7tJdzDA3vRHuppZ1FTPoLGXO+soVubV8w7BfWblCXZlLziQvMXLz1FzOgqUApgIg86YNl+Y7IZmM1+1BGU5+mrVzxYHf9wsNoF7JnNcl3rinvvr5m6uP7TqqrvceYtA5K2OAB3jkBoFWRuMugJ9TVc+djp2ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313088; c=relaxed/simple;
	bh=1SN6XJVoKoHKUZTH//sJI/EbzT5E03VpQ6l9/BnrPjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozwicL+t3rXl3DTEaskfpK8qcrst7lZQ3wQGNEhvf8SJ2BzKDmUoPZgvRamwQ9Oy3K6uAcMYjaQZIdp+fBqqcQiK1TIjP7poRjE0kkLaJdfB5nRVWqoOMmSOgTf4T8+YTIRrNcEKLZFIfbe+iyQvafLJe312dpdZYxqy0zyydkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=urtwSwbs; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="urtwSwbs"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51a0188b92fso11689681cf.3
        for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 07:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782313085; x=1782917885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LbNsCaF8AqQRerBXt6jCH2X6FSKJPEhWXxoYu5Er/s=;
        b=urtwSwbsc4333ieufo1/Nh/1NCOekFAhYGDeXgRrRptYQj8MwIWcNHunEhBZilQSDm
         Ps4or5Cjp1+c+pOLSzTCgvfW/x6eZQa2TM9NlBB2lbTfzmjt0Ubuwoy2WnZjtxwLk0wt
         cnUVz0FsGN1tEghBij0+n2pTCYyaXxYEQmoSbD2WafmBqQr/lCt+jQaMKA/sJPXD2N3i
         zsV2JZWGBC4wgdRhn3R17i5YQHzFsfLGDyeWsm1SNmTyYUedWl+IVm4ciRq9D+2StL2L
         wH97ABg2mvXjSoJfmSeGRX7tixT0KMsOSgM6A0yb+MAbiXIEEif8AnS1zfgToOlfVkjF
         c0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782313085; x=1782917885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+LbNsCaF8AqQRerBXt6jCH2X6FSKJPEhWXxoYu5Er/s=;
        b=s2yqlXGIRV6VluCVybcrnAFJ1KpYPmeIeIVPOUmUAB+5ElC/EP5QH2mPlPjNh4u1pX
         anzgVy/MaI3AQQYdVPHAi+sgUqKpyMWqDesw19CginUeIWtLce8bcJX709Cg1S+649M8
         ln4sGLTIO8r+xmMD8LhMAs5bgJwl9k3iUhsHqBzTNGyEz+05Q3hLY7FUYI3KFYznr+n4
         jlC3OvWt7nUJ582V977s+DFLPJr99wNxsRs+4bfuL9Idze2Aly7dZOON85/qXjweF2Km
         aOZ+si3PcQ29SPuwwcBjhto9SVbwaCS+4VSglR/109/08ujiVW2A62mUCgknY7h5zz4e
         nHQw==
X-Forwarded-Encrypted: i=1; AFNElJ8graREIHrH5d4AqmapGBvMb9SWSboNVI9QuYKf0z2Th5ONmkEwZ5okC2xvw7WHKUW9sA5ojdHWR3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyROhXt2z5VyUZl+oEhfTXBLFVqMzNGlcsPFMZ+2so9fuloI0A
	4d+P74Ib/0ALE1aHvDybj6jRoUOMtozuXowbyxsIkmkSsIt7NsUeKPx/pZ9a4WJlyEo=
X-Gm-Gg: AfdE7ckSOtcsf15fJJKuj8EAPK+HdFdOrf336rXHaDqMd0cVlZD//4V+k7itgmHOSHz
	Bn0IyGZdV6MBy5MpHbAtGx5z0Ag6xI3Hh/QwltWltVRwAw5TRH6+Np0NNCg8oaVmAFLs6oXkpde
	8k+UY5q6B3nq1zidurJ+kiSxldqXo2mxG1MzEc07QaRSs/VAduFt/5r6e+EuuBkZaspk4XJ1pcx
	luhYYeCs9Wmnmv3y3JxQioJijD7sc0Tb6AzbZwuaQQ9Qc3TlJJBh2TkfI985dp7Sc+mUz7A8++a
	KMWXvk9POohpitSe2DD23fZbmEOZjrgHix4XFOPSMJJgrKIysQM9QFfY3ImoGDOoTfVDCWM+zZi
	ryc1ZCe48Gazc/u/hS6H25ENJNeuCxORZSW6v7N31oef0kUwV5p9ZhV+5IJ+p6jrzl7FEZYvNyT
	duygCd3U8f/2Ig9q5hcYxLfBRQWHVVJ3UC6ffY+ZN39MOqd2JkElRrv4hYUtvylLM2R1cpFrR80
	w==
X-Received: by 2002:a05:622a:2297:b0:50e:6182:b4c with SMTP id d75a77b69052e-51a61e49d5emr54674141cf.25.1782313085460;
        Wed, 24 Jun 2026 07:58:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a51ae8ee7sm49502301cf.24.2026.06.24.07.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:58:04 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org,
	nvdimm@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
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
	akpm@linux-foundation.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	shuah@kernel.org,
	gourry@gourry.net,
	alison.schofield@intel.com,
	Smita.KoralahalliChannabasappa@amd.com,
	ira.weiny@intel.com,
	apopple@nvidia.com
Subject: [PATCH v5 5/9] mm/memory_hotplug: offline_and_remove_memory_ranges()
Date: Wed, 24 Jun 2026 10:57:40 -0400
Message-ID: <20260624145744.3532049-6-gourry@gourry.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624145744.3532049-1-gourry@gourry.net>
References: <20260624145744.3532049-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

offline_and_remove_memory() handles a single contiguous range.

Callers that manage a device composed of several ranges (dax/kmem)
currently have to call it in a loop, which gives up atomicity.

In addition to pushing rollback logic into the driver, the lack
of atomicity creates a race condition between system daemons trying
to manage the same resource:

   - Manager 1:  Offlines memory blocks.    Removes device.
                                        ^^^^
   - Manager 2:  Detects offline memory blocks, re-onlines them.

Add offline_and_remove_memory_ranges(), which takes an array of ranges
and processes them as one operation under a single lock_device_hotplug():

  - Phase 1 offlines every block of every range.
  - Phase 2 removes the ranges only if all ranges are offline.
  - If any offline fails, the whole operation is reverted.

This gives callers all-or-nothing semantics for the offline step, so a
failed or interrupted unplug leaves the device in a consistent state.

This also resolves the battling managers race - the second manager's
operation simply fails when the block is destroyed / cannot be onlined.

offline_and_remove_memory() becomes a thin wrapper that passes its single
range to the new helper, so the offline/rollback logic lives in one place.

Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/memory_hotplug.h |  7 +++
 mm/memory_hotplug.c            | 94 ++++++++++++++++++++++++----------
 2 files changed, 74 insertions(+), 27 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index d3edeb80aadb..7f1da7c428dc 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -267,6 +267,7 @@ extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 extern int remove_memory(u64 start, u64 size);
 extern void __remove_memory(u64 start, u64 size);
 extern int offline_and_remove_memory(u64 start, u64 size);
+int offline_and_remove_memory_ranges(const struct range *ranges, int nr_ranges);
 
 #else
 static inline void try_offline_node(int nid) {}
@@ -283,6 +284,12 @@ static inline int remove_memory(u64 start, u64 size)
 }
 
 static inline void __remove_memory(u64 start, u64 size) {}
+
+static inline int offline_and_remove_memory_ranges(const struct range *ranges,
+						   int nr_ranges)
+{
+	return -EBUSY;
+}
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
 #ifdef CONFIG_MEMORY_HOTPLUG
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index a66346def504..7d56e0c6ede0 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -2429,58 +2429,98 @@ static int try_reonline_memory_block(struct memory_block *mem, void *arg)
  */
 int offline_and_remove_memory(u64 start, u64 size)
 {
-	const unsigned long mb_count = size / memory_block_size_bytes();
+	struct range range = { .start = start, .end = start + size - 1 };
+
+	return offline_and_remove_memory_ranges(&range, 1);
+}
+EXPORT_SYMBOL_GPL(offline_and_remove_memory);
+
+/**
+ * offline_and_remove_memory_ranges - offline and remove multiple memory ranges
+ * @ranges: array of physical address ranges to offline and remove
+ * @nr_ranges: number of entries in @ranges
+ *
+ * Offline and remove several memory ranges as one operation, serialized
+ * against other hotplug operations by a single lock_device_hotplug().
+ *
+ * This offlines all ranges before removing any of them.  If offlining any
+ * range fails, the entire process is reverted and nothing is removed.
+ * This provides a fully atomic semantic for unplugging an entire device.
+ *
+ * Each range must be memory-block aligned in start and size.
+ *
+ * Return: 0 on success, negative errno otherwise.  On failure no range has
+ * been removed.
+ */
+int offline_and_remove_memory_ranges(const struct range *ranges, int nr_ranges)
+{
+	unsigned long mb_total = 0;
 	uint8_t *online_types, *tmp;
-	int rc;
+	int i, rc = 0;
 
-	if (!IS_ALIGNED(start, memory_block_size_bytes()) ||
-	    !IS_ALIGNED(size, memory_block_size_bytes()) || !size)
+	if (!ranges || nr_ranges <= 0)
 		return -EINVAL;
 
+	for (i = 0; i < nr_ranges; i++) {
+		u64 start = ranges[i].start;
+		u64 size = range_len(&ranges[i]);
+
+		if (!IS_ALIGNED(start, memory_block_size_bytes()) ||
+		    !IS_ALIGNED(size, memory_block_size_bytes()) || !size)
+			return -EINVAL;
+		mb_total += size / memory_block_size_bytes();
+	}
+
 	/*
-	 * We'll remember the old online type of each memory block, so we can
-	 * try to revert whatever we did when offlining one memory block fails
-	 * after offlining some others succeeded.
+	 * Remember the old online type of every memory block across all ranges,
+	 * so we can revert if offlining a later block fails.  All entries start
+	 * as MMOP_OFFLINE so blocks we never touched are skipped on rollback.
 	 */
-	online_types = kmalloc_array(mb_count, sizeof(*online_types),
+	online_types = kmalloc_array(mb_total, sizeof(*online_types),
 				     GFP_KERNEL);
 	if (!online_types)
 		return -ENOMEM;
-	/*
-	 * Initialize all states to MMOP_OFFLINE, so when we abort processing in
-	 * try_offline_memory_block(), we'll skip all unprocessed blocks in
-	 * try_reonline_memory_block().
-	 */
-	memset(online_types, MMOP_OFFLINE, mb_count);
+	memset(online_types, MMOP_OFFLINE, mb_total);
 
 	lock_device_hotplug();
 
+	/* Phase 1: offline every block in every range. */
 	tmp = online_types;
-	rc = walk_memory_blocks(start, size, &tmp, try_offline_memory_block);
+	for (i = 0; i < nr_ranges; i++) {
+		rc = walk_memory_blocks(ranges[i].start, range_len(&ranges[i]),
+					&tmp, try_offline_memory_block);
+		if (rc)
+			break;
+	}
 
 	/*
-	 * In case we succeeded to offline all memory, remove it.
-	 * This cannot fail as it cannot get onlined in the meantime.
+	 * Phase 2: Remove each range. This essentially cannot fail as we hold
+	 * the hotplug lock . WARN if that assumption is ever broken.
 	 */
 	if (!rc) {
-		rc = try_remove_memory(start, size);
-		if (rc)
-			pr_err("%s: Failed to remove memory: %d", __func__, rc);
+		for (i = 0; i < nr_ranges; i++) {
+			rc = try_remove_memory(ranges[i].start,
+					       range_len(&ranges[i]));
+			if (WARN_ON_ONCE(rc)) {
+				pr_err("%s: Failed to remove memory: %d",
+				       __func__, rc);
+				break;
+			}
+		}
 	}
 
-	/*
-	 * Rollback what we did. While memory onlining might theoretically fail
-	 * (nacked by a notifier), it barely ever happens.
-	 */
+	/* On fail: roll back. Blocks that were already offline are skipped */
 	if (rc) {
 		tmp = online_types;
-		walk_memory_blocks(start, size, &tmp,
-				   try_reonline_memory_block);
+		for (i = 0; i < nr_ranges; i++)
+			walk_memory_blocks(ranges[i].start,
+					   range_len(&ranges[i]), &tmp,
+					   try_reonline_memory_block);
 	}
 	unlock_device_hotplug();
 
 	kfree(online_types);
 	return rc;
 }
-EXPORT_SYMBOL_GPL(offline_and_remove_memory);
+EXPORT_SYMBOL_GPL(offline_and_remove_memory_ranges);
 #endif /* CONFIG_MEMORY_HOTREMOVE */
-- 
2.54.0

