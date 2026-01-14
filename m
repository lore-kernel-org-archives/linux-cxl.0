Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37220337111
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768434668; cv=none; b=C28JZFFj6/jAQPuUJ5s4lGdJAQD9R5si5+Y3OtFgxkB7jlLbf5ZJVhy2JsF2YBAshOtT3Dc/eWEUcbsfzIGz7sk21K/IdKDEVLAGGJSSQGDqoSPDVbybgVWmpkObqMao6rr+8h3ucX0N/PUVBCubBSVIYwm8D2+d7VhKX+NeH1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768434668; c=relaxed/simple;
	bh=Ts4OR3TE6GFvXvPkLNSwvDxigmljGOw1xgooqw3bmMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CThLsBHF7j5200Y+92dTF0WDsFBs14FLD8WDZzhIiEB9TmmB85yI5cXyPJzi9SF1qkXMJKQ+ktabPs7qAp+cr9M69mloweIo7et2qgjcqq6hF25LaSzpt6GoHN2RuvLWLWWuu1ufrIVnhkvRIb/Q3Tu/hGyPLaUgc1BBXbkkSko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ihE+/VXX; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ihE+/VXX"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88a2fe9e200so2695326d6.0
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 15:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768434662; x=1769039462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXtSnfgPBjwiSCGU9CrPH4hnxnqEFEy6STkxK/VjbLc=;
        b=ihE+/VXXhtldTRYErCRvdjpADw9wHTRvRCANVMEwJLJU23Ij5Z9lPJzw0O8RFJiLvq
         4Kf16raRuBv2HCgnDWrWD4k25rVmfx6KCqX7E5U7TLoqExEl+r7sa8wW1iry4SHxyHL7
         r/TLHsjXmrEWBLGEna/gVarCXSCE37Pz8d1BDSvRg09FpKXoBc3v19rGvK1u2/WBeuY8
         BDoVzYSZVIf7gFS6ZcktXhHXz6X4bgsevWdAJTcaVNOphlKRnELrOoR+dlXAdQ2gKfGF
         w3RdFFp8STz/h9LFfZfSQf8+PurKhUD7fkjW5MAZKKFjXJRfl0iIdtNI/fiduAM6Wxt5
         j9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768434662; x=1769039462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cXtSnfgPBjwiSCGU9CrPH4hnxnqEFEy6STkxK/VjbLc=;
        b=UgRAAzbu1JLDOQhRBy1k9lValdmAM5K20PUTwxq0oOoEzeDMmU8Z4dtI7NMXds3cFn
         7X8w42vQvwr3HBxyc2VTpO0nXufknKGHPwx3Q81by6YKFGmt5wo3GnisdVlwQqYadkkR
         gzsAldvaQHW6WspLm1kEQjN2DWfZMzCi7OVWtdrtOLtUzZ7/JP9/dSHR/uVRC5kIGYs+
         DNEcNgDeS7IE3gImmfPf7+T++qWf335xn1q88r6zl9Gc0sefSvtVmhZti9f06wrnA2gF
         S5WubyCPo89m2sieVv2shWXBzvhUMTkk3xP+fs30aoeXRbFVWAFYac/j3xT1kHwKFGgf
         CKZg==
X-Gm-Message-State: AOJu0YzG4d8DZHAufKKjz3X+/S3NZb3RWVr6TIEF/xgc+Zp5O7eIGjQN
	oRh+8nN7cB8O2g5Lcy9e5iFZ0aX9FqMfVSZSGmGgOWB/0ekqOiTutiUb6vx/sThLtcBRzlGSWD0
	u1aTzRw0=
X-Gm-Gg: AY/fxX7l1P0WVIUasW5I8DSOayJIICcUKOJYQ+prw/pfR+3BFXyAi2L3rk/Nm83ycUu
	skrVWKVBJzAcTCgXFQ5XDu+HtB7qoqdVd+rGUj1MyZb0Hgg0qGy0WORT0+QeKSN6s99PDUnza46
	3SnmBDVDt+JzC0g0RuK0qrEwc8mA9C6mEBOCCWEUm4OAF0JeYPjNHjDMn4lKphsOP5WsAV9b+OR
	ffNHnUYRfyTCPek8gRoScSZv3DJgg4leTDhYTdUYxpXlMgtiGmmkrt0iJgQJkLKHE1+A4hcZmXp
	RE2wRDH6wCRewuVxAkXV7qwIzqVkdgiAbRD9zq5vv/LfGkJ1CmMnxtnqOVCi05RN9y26tU0TqQk
	r4Bb7tDZphVfhyg5BP+D+NHPBpA3f+o7eT1CLTLzBO7kWy63iO1JCvLwMaX99EGBkM4sgWwKpda
	6apXZ9TKs+CNECV9FF4+NSl8qgOdVlp7fXg8Q1SSykn9XSN11OMMDugsZlG19DE41rjE8lx+TRd
	ME=
X-Received: by 2002:a05:6214:246c:b0:88a:2f46:8224 with SMTP id 6a1803df08f44-89275c89a31mr55155636d6.68.1768434662147;
        Wed, 14 Jan 2026 15:51:02 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890772346f8sm188449106d6.35.2026.01.14.15.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 15:51:01 -0800 (PST)
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
Subject: [PATCH v2 2/5] mm/memory_hotplug: add 'online_type' argument to add_memory_driver_managed
Date: Wed, 14 Jan 2026 18:50:18 -0500
Message-ID: <20260114235022.3437787-3-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114235022.3437787-1-gourry@gourry.net>
References: <20260114235022.3437787-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable external callers to select how to online the memory rather than
implicitly depending on the system defauilt.

Refactor: Extract __add_memory_resource to take an explicit online type,
and update add_memory_resource to pass the system default.

Export mhp_get_default_online_type() and update existing callers of
add_memory_driver_managed to use it explicitly to make it clear what the
behavior of the function is.

dax_kmem and virtio_mem drivers were updated.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/kmem.c             |  3 ++-
 drivers/virtio/virtio_mem.c    |  3 ++-
 include/linux/memory_hotplug.h |  2 +-
 mm/memory_hotplug.c            | 31 +++++++++++++++++++++++--------
 4 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index c036e4d0b610..bb13d9ced2e9 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -175,7 +175,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		 * this as RAM automatically.
 		 */
 		rc = add_memory_driver_managed(data->mgid, range.start,
-				range_len(&range), kmem_name, mhp_flags);
+				range_len(&range), kmem_name, mhp_flags,
+				mhp_get_default_online_type());
 
 		if (rc) {
 			dev_warn(dev, "mapping%d: %#llx-%#llx memory add failed\n",
diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 1688ecd69a04..63c0b2b235ab 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -654,7 +654,8 @@ static int virtio_mem_add_memory(struct virtio_mem *vm, uint64_t addr,
 	/* Memory might get onlined immediately. */
 	atomic64_add(size, &vm->offline_size);
 	rc = add_memory_driver_managed(vm->mgid, addr, size, vm->resource_name,
-				       MHP_MERGE_RESOURCE | MHP_NID_IS_MGID);
+				       MHP_MERGE_RESOURCE | MHP_NID_IS_MGID,
+				       mhp_get_default_online_type());
 	if (rc) {
 		atomic64_sub(size, &vm->offline_size);
 		dev_warn(&vm->vdev->dev, "adding memory failed: %d\n", rc);
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index f2f16cdd73ee..b68bc410db67 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -295,7 +295,7 @@ extern int add_memory_resource(int nid, struct resource *resource,
 			       mhp_t mhp_flags);
 extern int add_memory_driver_managed(int nid, u64 start, u64 size,
 				     const char *resource_name,
-				     mhp_t mhp_flags);
+				     mhp_t mhp_flags, int online_type);
 extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 				   unsigned long nr_pages,
 				   struct vmem_altmap *altmap, int migratetype,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 5718556121f0..2b4e31161fc1 100644
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
@@ -1649,9 +1654,16 @@ EXPORT_SYMBOL_GPL(add_memory);
  *
  * The resource_name (visible via /proc/iomem) has to have the format
  * "System RAM ($DRIVER)".
+ *
+ * @online_type specifies the online behavior: MMOP_ONLINE, MMOP_ONLINE_KERNEL,
+ * MMOP_ONLINE_MOVABLE to online with that type, MMOP_OFFLINE to leave offline.
+ * Users that want the system default should call mhp_get_default_online_type().
+ *
+ * Returns 0 on success, negative error code on failure.
  */
 int add_memory_driver_managed(int nid, u64 start, u64 size,
-			      const char *resource_name, mhp_t mhp_flags)
+			      const char *resource_name, mhp_t mhp_flags,
+			      int online_type)
 {
 	struct resource *res;
 	int rc;
@@ -1661,6 +1673,9 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
 	    resource_name[strlen(resource_name) - 1] != ')')
 		return -EINVAL;
 
+	if (online_type < 0 || online_type > MMOP_ONLINE_MOVABLE)
+		return -EINVAL;
+
 	lock_device_hotplug();
 
 	res = register_memory_resource(start, size, resource_name);
@@ -1669,7 +1684,7 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
 		goto out_unlock;
 	}
 
-	rc = add_memory_resource(nid, res, mhp_flags);
+	rc = __add_memory_resource(nid, res, mhp_flags, online_type);
 	if (rc < 0)
 		release_memory_resource(res);
 
-- 
2.52.0

