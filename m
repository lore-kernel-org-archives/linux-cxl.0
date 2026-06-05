Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA2B3C1412
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 21:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780694373; cv=none; b=GYDqEjc2gA8H43j8sGAqkgeKgbamzhE2M7Hqlg0zDggTVYreealP7g7RlgJE6uyHF49F6cyDKiF5RELOQiHSAiSoJxCaoOQmOVdVw4B/YuQArJCUJV5PAYZKfNA4TNqd7cjkDf1JGihHi/hI8KNSL0JYnVh96RmqQm3znx3VBUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780694373; c=relaxed/simple;
	bh=43zFHi5h2geuF8B5bCDMfCmgrfTcOhgF/U/MHNHLK9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnEVF+QJH0GNvGA2TOwvkQoHtFQkOpHQgOjXsZPstxd3vtk6vE8RXvTqj9kOvq+zz/D892vPxjV0AtZyBxQ0/lGtptIqORV3j5sPl+k541OcY+faAmlsMyD4Rbggh82xQFW7p6iHeLHwt+2hhV6ueof59A8JAaXngPb3glKiPyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QIHTVSE0; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QIHTVSE0"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8cce87d7995so24709936d6.0
        for <linux-cxl@vger.kernel.org>; Fri, 05 Jun 2026 14:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780694364; x=1781299164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dc8rrr2XcrLtsxKN6sh//CYz2F36Y4vG25xCNA+gt8=;
        b=QIHTVSE0c0+StUhXBxpssnjOgjk6DiHtPsPVfBtlfNB4Kmzqeb9jZk1cGdMmYk83bN
         5S2diiBm6kMO+CtEh02e0hUZi2ZcqbatzToVZvKB/KQxB5Ljp055H6K6TdiOd1HNmq+h
         3K7bmnOgtqHF1jV6vW4sEFZG7O5J+y4UvLytbn2XxiCkM7Tb//dS2Z4LBlBjyVvB4oyi
         W2SUcLEb+mlkC9wnJ6LFfFshrQcte0HrwoThnuXDbSP7Xk9miyt0AwihA+pltGNYFb52
         klD7FqGYTdyya8D3O6ITpoOgKRKqwlVDwj38AtmxsUvJ96W4W0+KZOByS87VxvmBcgHi
         sTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780694364; x=1781299164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/dc8rrr2XcrLtsxKN6sh//CYz2F36Y4vG25xCNA+gt8=;
        b=T3QUpxC+hNqnHhuf7ppBuGBD38kG2vc0bE4IesjmaCXNQmHhKM3JbQF92xw7mvWnXT
         UBdm/aPqtliY1fjrlzPjBaxdKICZqzN0NZks0BF2AIEvgTRaku2r63ycu34MOCW5Y5LA
         a5lI4SF4lf5FQRVZD70YwaXlYpNVKA9I7fVbDVVqq1bK1tm6/YrugPx/sPPbrk2njouE
         6d5UmCMjjUnLNypsvoYtcT+d0YTy5fX7yqfHJ3X6pa82ja76Jd75qJmLeuwBpnSnI0Yv
         pSscIX+iP3+xRW+QspYX3Xr0L4gNtqZaOd9kW8fJI57MH5ZXNGj1kCeGxC1MXp5e3Lrt
         rkVw==
X-Forwarded-Encrypted: i=1; AFNElJ+Db9PLBJ6APB6Ii3UWSia68f4o0BRVEzCpZyGutjkAfwGtTh1gbUGPiwU2DBXSovs9rJ8OAm5SELA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSnIbSEpFxIQQmjyTjbRDAbLQnQ19aP9JM1ER8YaVF5HTyINRF
	ioABlrvRMPfB1tl9eFzYfdw1PnafMB+Q+42jPo1u3BjIrZMhZFcWTWQMGvArnb88jms=
X-Gm-Gg: Acq92OF1x4BvW+c7/XF7ow9r9mUE6iA1p1hvuaTHmJC+0Jlg865SJgdiMHVw6VEbBl6
	pQAHojOqzYHwZdC9xrD/QCTWthkuSQuZ4tVNJt4DoB/VdpFzUHYU0eGxS0MtiO8SM9hdWf2mIkn
	66iRyKoGBq794PuJ2ZTh+AT5a8c+JdZs4R/8b24HFdXg1sJFsLjArTOaqGSafpWF4cl5f2i31vJ
	CLS51knlZqp7UbaOCwMLW3hknplamcipBYTIMIcCovhB/GKndwx2py6pmk63TSJ8lL/Rpw/0W7q
	7b5TiiulcPNMCuYCku8TErIVlFCC4wYOCctDES3+0Xmg8aCRa7KkZr9bZJfTtC9dRD4Gos7jQDL
	AEbxUQf+9fCrgkmK8QMIkpWw8kCK8lAhjegsWCq2MC9VPycUML9kWqiCnHNVVyHS3AkjyyHvHaL
	IxnwUcQyBX6aPmEF8IORcQWKUAvnoT61KpqOh91194VOKcSvkoH8dz3oB4gcYKDJNIEZ8/24LkS
	c9MV1h6a9IC8R67zKd7etRw1QPtR0j9oQ==
X-Received: by 2002:a05:6214:5904:b0:8cc:f135:52ab with SMTP id 6a1803df08f44-8cee625b0ffmr97629096d6.39.1780694363997;
        Fri, 05 Jun 2026 14:19:23 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd277bbcsm90518196d6.49.2026.06.05.14.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 14:19:23 -0700 (PDT)
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
Subject: [PATCH v4 4/9] mm/memory_hotplug: add __add_memory_driver_managed() with online_type arg
Date: Fri,  5 Jun 2026 22:19:06 +0100
Message-ID: <20260605211911.2160954-5-gourry@gourry.net>
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

Existing callers of add_memory_driver_managed cannot select the
preferred online type (ZONE_NORMAL vs ZONE_MOVABLE), requiring it to
hot-add memory as offline blocks, and then follow up by onlining each
memory block individually.

Most drivers prefer the system default, but the CXL driver wants to
plumb a preferred policy through the dax kmem driver.

Refactor APIs to add a new interface which allows the dax kmem module
to select a preferred policy.

Overriding the configured auto-online policy is only safe for known
in-tree modules, where we know the override reflects a different,
user-requested policy.  We do not want arbitrary out-of-tree drivers
silently overriding the system-wide onlining policy, so restrict the
new interface to the kmem module using EXPORT_SYMBOL_FOR_MODULES()
rather than a plain EXPORT_SYMBOL_GPL().  Other in-tree modules (e.g.
cxl_core) can be added to the allowed list as the need arises.

Refactor add_memory_driver_managed, extract __add_memory_driver_managed
- Add proper kernel-doc for add_memory_driver_managed while refactoring
- New helper accepts an explicit online_type.
- New helper validates online_type is between OFFLINE and ONLINE_MOVABLE

Refactor: add_memory_resource, extract __add_memory_resource
- new helper accepts an explicit online_type

Original APIs now explicitly pass the system-default to new helpers.

No functional change for existing users.

Cc: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/memory_hotplug.h |  3 ++
 mm/memory_hotplug.c            | 61 +++++++++++++++++++++++++++++-----
 2 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index f059025f8f8b..d3edeb80aadb 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -294,6 +294,9 @@ extern int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
 extern int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
 extern int add_memory_resource(int nid, struct resource *resource,
 			       mhp_t mhp_flags);
+int __add_memory_driver_managed(int nid, u64 start, u64 size,
+				const char *resource_name, mhp_t mhp_flags,
+				enum mmop online_type);
 extern int add_memory_driver_managed(int nid, u64 start, u64 size,
 				     const char *resource_name,
 				     mhp_t mhp_flags);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 494257054095..7d145217adc6 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1494,10 +1494,10 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
  *
  * we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLUG
  */
-int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
+static int __add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags,
+				 enum mmop online_type)
 {
 	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
-	enum mmop online_type = mhp_get_default_online_type();
 	enum memblock_flags memblock_flags = MEMBLOCK_NONE;
 	struct memory_group *group = NULL;
 	u64 start, size;
@@ -1585,7 +1585,7 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 		merge_system_ram_resource(res);
 
 	/* online pages if requested */
-	if (mhp_get_default_online_type() != MMOP_OFFLINE)
+	if (online_type != MMOP_OFFLINE)
 		walk_memory_blocks(start, size, &online_type,
 				   online_memory_block);
 
@@ -1603,7 +1603,13 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	return ret;
 }
 
-/* requires device_hotplug_lock, see add_memory_resource() */
+int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
+{
+	return __add_memory_resource(nid, res, mhp_flags,
+				     mhp_get_default_online_type());
+}
+
+/* requires device_hotplug_lock, see __add_memory_resource() */
 int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags)
 {
 	struct resource *res;
@@ -1631,7 +1637,15 @@ int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags)
 }
 EXPORT_SYMBOL_GPL(add_memory);
 
-/*
+/**
+ * __add_memory_driver_managed - add driver-managed memory with explicit online_type
+ * @nid: NUMA node ID where the memory will be added
+ * @start: Start physical address of the memory range
+ * @size: Size of the memory range in bytes
+ * @resource_name: Resource name in format "System RAM ($DRIVER)"
+ * @mhp_flags: Memory hotplug flags
+ * @online_type: Auto-Online behavior (offline, online, kernel, movable)
+ *
  * Add special, driver-managed memory to the system as system RAM. Such
  * memory is not exposed via the raw firmware-provided memmap as system
  * RAM, instead, it is detected and added by a driver - during cold boot,
@@ -1639,6 +1653,7 @@ EXPORT_SYMBOL_GPL(add_memory);
  *
  * Reasons why this memory should not be used for the initial memmap of a
  * kexec kernel or for placing kexec images:
+ *
  * - The booting kernel is in charge of determining how this memory will be
  *   used (e.g., use persistent memory as system RAM)
  * - Coordination with a hypervisor is required before this memory
@@ -1651,9 +1666,12 @@ EXPORT_SYMBOL_GPL(add_memory);
  *
  * The resource_name (visible via /proc/iomem) has to have the format
  * "System RAM ($DRIVER)".
+ *
+ * Return: 0 on success, negative error code on failure.
  */
-int add_memory_driver_managed(int nid, u64 start, u64 size,
-			      const char *resource_name, mhp_t mhp_flags)
+int __add_memory_driver_managed(int nid, u64 start, u64 size,
+				const char *resource_name, mhp_t mhp_flags,
+				enum mmop online_type)
 {
 	struct resource *res;
 	int rc;
@@ -1663,6 +1681,9 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
 	    resource_name[strlen(resource_name) - 1] != ')')
 		return -EINVAL;
 
+	if (online_type < MMOP_OFFLINE || online_type > MMOP_ONLINE_MOVABLE)
+		return -EINVAL;
+
 	lock_device_hotplug();
 
 	res = register_memory_resource(start, size, resource_name);
@@ -1671,7 +1692,7 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
 		goto out_unlock;
 	}
 
-	rc = add_memory_resource(nid, res, mhp_flags);
+	rc = __add_memory_resource(nid, res, mhp_flags, online_type);
 	if (rc < 0)
 		release_memory_resource(res);
 
@@ -1679,6 +1700,30 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
 	unlock_device_hotplug();
 	return rc;
 }
+EXPORT_SYMBOL_FOR_MODULES(__add_memory_driver_managed, "kmem");
+
+/**
+ * add_memory_driver_managed - add driver-managed memory
+ * @nid: NUMA node ID where the memory will be added
+ * @start: Start physical address of the memory range
+ * @size: Size of the memory range in bytes
+ * @resource_name: Resource name in format "System RAM ($DRIVER)"
+ * @mhp_flags: Memory hotplug flags
+ *
+ * Add driver-managed memory with the system default online type set by
+ * build config or kernel boot parameter.
+ *
+ * See __add_memory_driver_managed for more details.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int add_memory_driver_managed(int nid, u64 start, u64 size,
+			      const char *resource_name, mhp_t mhp_flags)
+{
+	return __add_memory_driver_managed(nid, start, size, resource_name,
+					   mhp_flags,
+					   mhp_get_default_online_type());
+}
 EXPORT_SYMBOL_GPL(add_memory_driver_managed);
 
 /*
-- 
2.54.0

