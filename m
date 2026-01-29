Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E4235C18E
	for <linux-cxl@vger.kernel.org>; Thu, 29 Jan 2026 21:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769720696; cv=none; b=oRh+xKQR/BAFGwtmuVfxVmNhQMcZYBHPIm9BvIvlvpyrz69X341fIHGG+qrtdSgyKZBUlUjV+UXFNZR79MY5vjNlKVpMe7X9PCdTJBOjMbbd8jUKAMXZ2o7u+raSkgCQpAOz1Ca9b+cYLuGLiZlAhft/LvG0RAvu6V11UcCm2Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769720696; c=relaxed/simple;
	bh=VOKzczjoSR9IzZunD6EwkPNtZXVw3ooO/qAH8uc28p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpqIjfL5IF8Jaz/HVqw9lGn/ulHY+jk/kI2+GkBr/75bTkMikAV2mGfU/xNRaba/IafTorrOXDcHFyJ/Xy7CLvY1fNfnmQ6dl0H5ah7ZZyUPWlvmjpCFBwUc6HvjwEuGoK2XIayWDFGzo+xQoZOKheJOV6iOVtqwziJiBx2nfiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=K3maD3fP; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="K3maD3fP"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c6af798a83so171052885a.0
        for <linux-cxl@vger.kernel.org>; Thu, 29 Jan 2026 13:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769720693; x=1770325493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Szb3YY2E1e7FJPUVmrsEdEEkJjq+khES1iOhgbFItPA=;
        b=K3maD3fPWKjqycB32xVyDJpUSYwMM3Vjmb4iYAYEaZHxJdFCNfxSrBbO7su67plOb1
         OMQvwZRq1ygO+ak2+eXOq1Fo6KoKUo0ALOMHMpnoD+zbSz/y8qVi8oYfm74qgORuwUdV
         TvTsn7xicNcJvd88UdzSOVLRSjRgRTnKLh6/M5XzOEVmWYHHkoCBMXewPEA2uArYE29m
         zzpYu2n3HAcXk40xWGCyPJnjTZtiBbrjIJoucOwe37HEhthpMUFLvC9cadsyq8BLyPBU
         8rMPV7rto8slekx4cdkDFg9SSmuH/qDp3UIq/7knhkSDma7om1ArfEVeGEp0COoSBoXi
         SBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769720693; x=1770325493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Szb3YY2E1e7FJPUVmrsEdEEkJjq+khES1iOhgbFItPA=;
        b=lYnzR/z+EXEM7LZKE8x6vJZgrhbaSVOqZ4Trg3ULIFQNikRhGl5zTyNJFS8Rixow32
         uuTw0XilnSQSelasPyrhl2688j6VI83tDYkXDwIgXnnzWF2oLTZpy8dLDChV3sKKESgq
         z1OTFJVRSrIlPEfYSOKqPsrefAU5De/foEpB8Psetx6qz7I7SIJ98Esix2cOIW3C91c/
         oH6ZWfLhmUCWxaQ2WU0aN1sIxoAct/7RGUTzvf7N0+KipksptKA6JKYFWDAhbhhpDX83
         yRvmnFTAvXGY8Uuuu51PnirKukO4d0BFY7XvivJrmPPb//9HCvJ01bRvF6gTa1/+Y0yT
         yVlw==
X-Gm-Message-State: AOJu0YzzJhdGGFVdpWCkFpDBql10Fd38yeGb79S2ECJhnkic80667ahJ
	y6J842jTaTePjJX6wdSRdJ0nVKyZj3E5jg2VW+L3j34PiEmHM71L5kMRGPzvpwzwXnU=
X-Gm-Gg: AZuq6aJJWloGbibg7nPlDj6A3ALeBsgPUV5hWYoe98TlLPJ7TAkpmiUoJt1/W+dXgUQ
	IyKLX01oUnpy+sdrrVsGC+xaCZn65Ztf4chdKyvoGRpY5kcS2+aQWykKVehbPDOZvUa9iHFYyYw
	Zdpsge8LX+3bSB/NwxFi9e6R2FRRJ38x6FGbyylR7dGTFnoIJ34dL9vT/TpzZ/ad6ZofT/ojMNq
	JcDL5/SLsPZ1bgS4m+frejLAvZe9iC/bWJOcum/rOY2BBBLPQLg/z9MPDjzivJpIKfga2XhTPfX
	N/xWlUjURLE+C7OzWUnJIooECoWZL6yq9QaXcSIAvvwWhlW8yNpGIlTeyhe1uXAx23GPjubUUHs
	6YNjH5aPHlblAcsne1bzXVEie1GgLvb+A5gas1sTjJZ+TuKwkkoQJblSdH0XSdCH13Nx9UigXog
	A7n6rfZni/09m6bSwzc4JGdaGDFsV6eFGXIx4uFet2NF44JITrW7qU+DNbdFi2zaQFuFiqDy5pM
	ImHk0JxpHhVLg==
X-Received: by 2002:a05:620a:690d:b0:8c9:ea1c:f21c with SMTP id af79cd13be357-8c9eb2fd583mr157489485a.63.1769720693221;
        Thu, 29 Jan 2026 13:04:53 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c71b859eaesm282041685a.46.2026.01.29.13.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 13:04:52 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	willy@infradead.org,
	jack@suse.cz,
	terry.bowman@amd.com,
	john@jagalactic.com,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/9] mm/memory_hotplug: add __add_memory_driver_managed() with online_type arg
Date: Thu, 29 Jan 2026 16:04:35 -0500
Message-ID: <20260129210442.3951412-3-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129210442.3951412-1-gourry@gourry.net>
References: <20260129210442.3951412-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable dax kmem driver to select how to online the memory rather than
implicitly depending on the system default.  This will allow users of
dax to plumb through a preferred auto-online policy for their region.

Refactor and new interface:
Add __add_memory_driver_managed() which accepts an explicit online_type
and export mhp_get_default_online_type() so callers can pass it when
they want the default behavior.

Refactor:
Extract __add_memory_resource() to take an explicit online_type parameter,
and update add_memory_resource() to pass the system default.

No functional change for existing users.

Cc: David Hildenbrand <david@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/memory_hotplug.h |  3 ++
 mm/memory_hotplug.c            | 91 ++++++++++++++++++++++++----------
 2 files changed, 67 insertions(+), 27 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index f2f16cdd73ee..1eb63d1a247d 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -293,6 +293,9 @@ extern int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
 extern int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
 extern int add_memory_resource(int nid, struct resource *resource,
 			       mhp_t mhp_flags);
+int __add_memory_driver_managed(int nid, u64 start, u64 size,
+				const char *resource_name, mhp_t mhp_flags,
+				int online_type);
 extern int add_memory_driver_managed(int nid, u64 start, u64 size,
 				     const char *resource_name,
 				     mhp_t mhp_flags);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 87796b617d9e..d3ca95b872bd 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -239,6 +239,7 @@ int mhp_get_default_online_type(void)
 
 	return mhp_default_online_type;
 }
+EXPORT_SYMBOL_GPL(mhp_get_default_online_type);
 
 void mhp_set_default_online_type(int online_type)
 {
@@ -1490,7 +1491,8 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
  *
  * we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLUG
  */
-int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
+static int __add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags,
+				 int online_type)
 {
 	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
 	enum memblock_flags memblock_flags = MEMBLOCK_NONE;
@@ -1580,12 +1582,9 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
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
@@ -1601,7 +1600,13 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
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
@@ -1629,29 +1634,24 @@ int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags)
 }
 EXPORT_SYMBOL_GPL(add_memory);
 
-/*
- * Add special, driver-managed memory to the system as system RAM. Such
- * memory is not exposed via the raw firmware-provided memmap as system
- * RAM, instead, it is detected and added by a driver - during cold boot,
- * after a reboot, and after kexec.
- *
- * Reasons why this memory should not be used for the initial memmap of a
- * kexec kernel or for placing kexec images:
- * - The booting kernel is in charge of determining how this memory will be
- *   used (e.g., use persistent memory as system RAM)
- * - Coordination with a hypervisor is required before this memory
- *   can be used (e.g., inaccessible parts).
+/**
+ * __add_memory_driver_managed - add driver-managed memory with explicit online_type
+ * @nid: NUMA node ID where the memory will be added
+ * @start: Start physical address of the memory range
+ * @size: Size of the memory range in bytes
+ * @resource_name: Resource name in format "System RAM ($DRIVER)"
+ * @mhp_flags: Memory hotplug flags
+ * @online_type: Online behavior (MMOP_ONLINE, MMOP_ONLINE_KERNEL,
+ *               MMOP_ONLINE_MOVABLE, or MMOP_OFFLINE)
  *
- * For this memory, no entries in /sys/firmware/memmap ("raw firmware-provided
- * memory map") are created. Also, the created memory resource is flagged
- * with IORESOURCE_SYSRAM_DRIVER_MANAGED, so in-kernel users can special-case
- * this memory as well (esp., not place kexec images onto it).
+ * Add driver-managed memory with explicit online_type specification.
+ * The resource_name must have the format "System RAM ($DRIVER)".
  *
- * The resource_name (visible via /proc/iomem) has to have the format
- * "System RAM ($DRIVER)".
+ * Return: 0 on success, negative error code on failure.
  */
-int add_memory_driver_managed(int nid, u64 start, u64 size,
-			      const char *resource_name, mhp_t mhp_flags)
+int __add_memory_driver_managed(int nid, u64 start, u64 size,
+				const char *resource_name, mhp_t mhp_flags,
+				int online_type)
 {
 	struct resource *res;
 	int rc;
@@ -1661,6 +1661,9 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
 	    resource_name[strlen(resource_name) - 1] != ')')
 		return -EINVAL;
 
+	if (online_type < 0 || online_type > MMOP_ONLINE_MOVABLE)
+		return -EINVAL;
+
 	lock_device_hotplug();
 
 	res = register_memory_resource(start, size, resource_name);
@@ -1669,7 +1672,7 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
 		goto out_unlock;
 	}
 
-	rc = add_memory_resource(nid, res, mhp_flags);
+	rc = __add_memory_resource(nid, res, mhp_flags, online_type);
 	if (rc < 0)
 		release_memory_resource(res);
 
@@ -1677,6 +1680,40 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
 	unlock_device_hotplug();
 	return rc;
 }
+EXPORT_SYMBOL_FOR_MODULES(__add_memory_driver_managed, "kmem");
+
+/*
+ * Add special, driver-managed memory to the system as system RAM. Such
+ * memory is not exposed via the raw firmware-provided memmap as system
+ * RAM, instead, it is detected and added by a driver - during cold boot,
+ * after a reboot, and after kexec.
+ *
+ * Reasons why this memory should not be used for the initial memmap of a
+ * kexec kernel or for placing kexec images:
+ * - The booting kernel is in charge of determining how this memory will be
+ *   used (e.g., use persistent memory as system RAM)
+ * - Coordination with a hypervisor is required before this memory
+ *   can be used (e.g., inaccessible parts).
+ *
+ * For this memory, no entries in /sys/firmware/memmap ("raw firmware-provided
+ * memory map") are created. Also, the created memory resource is flagged
+ * with IORESOURCE_SYSRAM_DRIVER_MANAGED, so in-kernel users can special-case
+ * this memory as well (esp., not place kexec images onto it).
+ *
+ * The resource_name (visible via /proc/iomem) has to have the format
+ * "System RAM ($DRIVER)".
+ *
+ * Memory will be onlined using the system default online type.
+ *
+ * Returns 0 on success, negative error code on failure.
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
2.52.0

