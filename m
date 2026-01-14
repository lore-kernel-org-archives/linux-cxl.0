Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB2137C102
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 08:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380772; cv=none; b=faK+wRJaVnoG9Y9jqPF5/PV/oBz6r89rKzNcM+0DcdzG3c3iaX2oSmjDlowhY8L7QKkFqOMGbaSxK4zQMCqZKRW8b7gNadiqetuz+K6vFxufoQudkPZGanYGzOikQfim20yvnnUi0R3bBtCt45QD5i2rqvDYmxz9B0eb+erDHXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380772; c=relaxed/simple;
	bh=O3e7cGKk0H8FcpihdwgdFuRgPI92sucbbxtSDb5wt50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTTNuKL2zwXs7KduMsgQay1llSyXU1J291hEvSMhbL+8rDUauVR3m5w56PSfp+Picdabuxxaf7mKk22c2reNVW66jxrZGlQ2qlTDYvVngdaIBeyKJK5f6xuy1JAuT87y1XZDTB2aSp8/gtI7M4+kI2zw5K7mckKPt3QvlqlfujM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=EV6yAp4t; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="EV6yAp4t"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ffc5f35b54so72484331cf.0
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 00:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768380758; x=1768985558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lttic/N6u5GXxgBUHet1PhNEmYleRIF6n16Y0kYNwPY=;
        b=EV6yAp4tPLszW6BeG0IP94Rgvc9YeL2log3bgHj7JbeJCnIvj/a1ouZuvdWAqtwuvC
         e6Olkq2/nu4A2O3kVXdVi/23jbs9E/XWitEhod0IxHjFpV+Uoh4gv2CM9yOZPCfGzOe9
         GSQtqMEsHiVOBeN7xgO7Ig4kTbNMxbiK2D4yXycqzlH/dKxl0YwEpjaL7bl+pYx1axQg
         I2PtIQIMP//s74m9k0w//oFCqObP1sUyODr6P0vce4fEJCdj33t7Ct/R/mETar1R+geI
         aSzy9oSOwya4URAsmOlSY2YHIhLuUpB4zDvn4fvXiyNCuGg0CszkfDkBCZeTVFu8MNyT
         YnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768380758; x=1768985558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lttic/N6u5GXxgBUHet1PhNEmYleRIF6n16Y0kYNwPY=;
        b=fB1QUtbdi8llZDdCNT2OkwkyuGi5Ypl2Kz42J5dfJK42gIIdU10cDR60K9WQSJLgXs
         AhIENnMWsocP6ypkJ7xdrOVZpgXKddA5wyP+AO8YeKxe5RqV0RTyaXnRaRNErcCC0ir5
         bB3wyVZBGjqzExNfCIp7YePIRVdRX/osU8pRO/OC8aRtc5WvVhQl3sGd+DBPp+lnbLaW
         LIq1gk+I1YN0BGDZ7hz179/orLtfKDfdM1V+e1vdtP5h3rv/UzfQzQXFdrs43JokE84c
         FNFS2o5/r/PrTXtk5hLXojBoB/aa4jdKuxk4OX4BAMitrKMZ6dMQlUHo+sqBrxdKMAaZ
         JHHQ==
X-Gm-Message-State: AOJu0YzHJYGT1JJSLLJmQy+gejnVEfPaJGCyrdX/RAgD40KB1cKti6D5
	HVf5esjJ8dGjooc2mDOtmVReCp6e4TEYilzrMufYm7gk8Z3PshG4REpYUTC1Jew4e88=
X-Gm-Gg: AY/fxX4eVMVpBHvT4/DpT9JYrfpN1agK6b4RFjSIg8+A6fqzb922RaTW8H0ycPXjrzU
	ThaaTn8cbweYUgfkN1wmt1ONRdC7YoHk0VBfYuNgP43ma5EdolsBuYG90E7GtB7q/kW4UrpPqjW
	I+fBBnObdlYY39iB46nmiJNz5HO+iNHFC4RBwR/+BRWfCx5rBizgw2OGRkSGtQBlzQb9IcSLGdW
	ENYD0l6H9OXHWy8qp+QnDclaRlnNXyFFk8L0vthuLGaaplGboWL5mrjvi88ITmiu17PBWCRf/Db
	L5tRwE9KvkbvMdXFwGoAt7oiXa3VLD/9DUkxPKeilqzs+D+6H4/m1Jyl4CEmsRCGTQ7T8coEcP6
	dz83Ykx5x0/VZwejI+Ro9JQ3EljVFy6gaVlKnYasOBdHRzMgRCDpBD1KgNkByvbs0r/+Oh/8GJ5
	A/g7X/ZzTyyzMYAqD7TnNw7NNBtTzgVe125R6pqSFbT7364MFL/DxukAMPM+7Kym1eyuAuGYs9/
	nk=
X-Received: by 2002:ac8:5701:0:b0:4ee:1727:10bd with SMTP id d75a77b69052e-501484c531emr22881881cf.66.1768380757853;
        Wed, 14 Jan 2026 00:52:37 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148df8759sm10131931cf.10.2026.01.14.00.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 00:52:37 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	kernel-team@meta.com,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	david@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	osalvador@suse.de,
	akpm@linux-foundation.org
Subject: [PATCH 2/8] mm/memory_hotplug: extract __add_memory_resource() and __offline_memory()
Date: Wed, 14 Jan 2026 03:51:54 -0500
Message-ID: <20260114085201.3222597-3-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114085201.3222597-1-gourry@gourry.net>
References: <20260114085201.3222597-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract internal helper functions with explicit parameters to prepare
for adding new APIs that allow explicit online type control:

  - __add_memory_resource(): accepts an explicit online_type parameter.
    Add MMOP_SYSTEM_DEFAULT as a new value that instructs the function
    to use mhp_get_default_online_type() for the actual online type.
    The existing add_memory_resource() becomes a thin wrapper that
    passes MMOP_SYSTEM_DEFAULT to preserve existing behavior.

  - __offline_memory(): extracted from offline_and_remove_memory() to
    handle the offline operation with rollback support. The caller
    now handles locking and the remove step separately.

This refactoring enables future callers to specify explicit online
types (MMOP_OFFLINE, MMOP_ONLINE, MMOP_ONLINE_MOVABLE) or use
MMOP_SYSTEM_DEFAULT for the system default policy. The offline logic
can also be used independently of the remove step.

Mild functional change: if try_remove_memory() failed after successfully
offlining, we would re-online the memory.  We no longer do this, and in
practice removal doesn't fail if offline succeeds.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/memory_hotplug.h |  2 +
 mm/memory_hotplug.c            | 69 ++++++++++++++++++++++------------
 2 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index f2f16cdd73ee..d5407264d72a 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -29,6 +29,8 @@ enum {
 	MMOP_ONLINE_KERNEL,
 	/* Online the memory to ZONE_MOVABLE. */
 	MMOP_ONLINE_MOVABLE,
+	/* Use system default online type from mhp_get_default_online_type(). */
+	MMOP_SYSTEM_DEFAULT,
 };
 
 /* Flags for add_memory() and friends to specify memory hotplug details. */
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 5718556121f0..ab73c8fcc0f1 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1490,7 +1490,8 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
  *
  * we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLUG
  */
-int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
+static int __add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags,
+				 int online_type)
 {
 	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
 	enum memblock_flags memblock_flags = MEMBLOCK_NONE;
@@ -1499,6 +1500,10 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	bool new_node = false;
 	int ret;
 
+	/* Convert system default to actual online type */
+	if (online_type == MMOP_SYSTEM_DEFAULT)
+		online_type = mhp_get_default_online_type();
+
 	start = res->start;
 	size = resource_size(res);
 
@@ -1580,12 +1585,9 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 		merge_system_ram_resource(res);
 
 	/* online pages if requested */
-	if (mhp_get_default_online_type() != MMOP_OFFLINE) {
-		int online_type = mhp_get_default_online_type();
-
+	if (online_type != MMOP_OFFLINE)
 		walk_memory_blocks(start, size, &online_type,
 				   online_memory_block);
-	}
 
 	return ret;
 error:
@@ -1601,7 +1603,12 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	return ret;
 }
 
-/* requires device_hotplug_lock, see add_memory_resource() */
+int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
+{
+	return __add_memory_resource(nid, res, mhp_flags, MMOP_SYSTEM_DEFAULT);
+}
+
+/* requires device_hotplug_lock, see __add_memory_resource() */
 int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags)
 {
 	struct resource *res;
@@ -2357,12 +2364,12 @@ static int try_reonline_memory_block(struct memory_block *mem, void *arg)
 }
 
 /*
- * Try to offline and remove memory. Might take a long time to finish in case
- * memory is still in use. Primarily useful for memory devices that logically
- * unplugged all memory (so it's no longer in use) and want to offline + remove
- * that memory.
+ * Offline a memory range. In case of failure, already offlined memory blocks
+ * will be re-onlined.
+ *
+ * Caller must hold device hotplug lock.
  */
-int offline_and_remove_memory(u64 start, u64 size)
+static int __offline_memory(u64 start, u64 size)
 {
 	const unsigned long mb_count = size / memory_block_size_bytes();
 	uint8_t *online_types, *tmp;
@@ -2388,11 +2395,37 @@ int offline_and_remove_memory(u64 start, u64 size)
 	 */
 	memset(online_types, MMOP_OFFLINE, mb_count);
 
-	lock_device_hotplug();
-
 	tmp = online_types;
 	rc = walk_memory_blocks(start, size, &tmp, try_offline_memory_block);
 
+	/*
+	 * Rollback what we did. While memory onlining might theoretically fail
+	 * (nacked by a notifier), it barely ever happens.
+	 */
+	if (rc) {
+		tmp = online_types;
+		walk_memory_blocks(start, size, &tmp,
+				   try_reonline_memory_block);
+	}
+
+	kfree(online_types);
+	return rc;
+}
+
+/*
+ * Try to offline and remove memory. Might take a long time to finish in case
+ * memory is still in use. Primarily useful for memory devices that logically
+ * unplugged all memory (so it's no longer in use) and want to offline + remove
+ * that memory.
+ */
+int offline_and_remove_memory(u64 start, u64 size)
+{
+	int rc;
+
+	lock_device_hotplug();
+
+	rc = __offline_memory(start, size);
+
 	/*
 	 * In case we succeeded to offline all memory, remove it.
 	 * This cannot fail as it cannot get onlined in the meantime.
@@ -2403,18 +2436,8 @@ int offline_and_remove_memory(u64 start, u64 size)
 			pr_err("%s: Failed to remove memory: %d", __func__, rc);
 	}
 
-	/*
-	 * Rollback what we did. While memory onlining might theoretically fail
-	 * (nacked by a notifier), it barely ever happens.
-	 */
-	if (rc) {
-		tmp = online_types;
-		walk_memory_blocks(start, size, &tmp,
-				   try_reonline_memory_block);
-	}
 	unlock_device_hotplug();
 
-	kfree(online_types);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(offline_and_remove_memory);
-- 
2.52.0

