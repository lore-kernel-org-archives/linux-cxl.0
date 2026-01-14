Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B559C37F729
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 08:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380771; cv=none; b=o5/rhrYtAbpRhCvsFaBoEsM6fDOiAxIdq/xRXxFhXK1sT+oNvnPuep63AyCp5QUqHLZw3MDXWUACFxkUQ4gT8M8xnK8iYeJD8ur7ucER6KVt/LrG+gLf4KP9BVzrxqkyZomm7S69ZhSZgmg9QJF0PIFO3n+kkC3R+q3R1Ggid5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380771; c=relaxed/simple;
	bh=WuxU623lbbMTdGzzm+5bCzIY7yeXdH6a4+PbwDkCxIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MjmBgCgsATm6cwmx2P7WGJgk31GD9/6GLSN1Hd8Q7FpgxyYy+FvyWIxiD8k4qt5U4+gjxoHxgPhNs6SoYloJfaoCbN5XUUn6oGmMPEXMB6IwRsJlibWtieDoAceMq3sFAGSqRA7hGKp43hL1h5sY9DXmIQgdgbC1h9st9MP5bnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ZIZ5iOb4; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ZIZ5iOb4"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50143fe869fso12462871cf.1
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 00:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768380761; x=1768985561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHib3jWzP7kVcnP0SE1eJQabXI1WWwo6ABSGI/iwYvU=;
        b=ZIZ5iOb4rMsUs1UX8j+1JHIC4h47DqjyJrDIkI3nNU024JWtqV3x09yU5Fppc/Z8FF
         j0D5zHkM6/zIzEq3mx4Rdj0j0r93rooVx9lfp2bf5c2pOeIcDtqi7gq22+pXOlShDQ/J
         rZf1YX02w0sDK+vzzsnyB45VARdWLadzQwW9V4X4eFC8oK/WnOIXSfyz1QrFzSR/wxYq
         R4iI1fFpuNBBIFmDvVideJqcbsac+FByujCm5PSkAXXWex/nYp9LGwBhySKLZm7eIM3G
         wdBE1wP2Bn54wNsPNRVzT4h7KkXqmGayZv2bmIQYHdF4gf3AQcu3iWFe0BtpBQpH439i
         fptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768380761; x=1768985561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AHib3jWzP7kVcnP0SE1eJQabXI1WWwo6ABSGI/iwYvU=;
        b=Bi6HJoXQwuHWD/GCStFivv+Uist6P3Nr5/MgvSrwKnGhtkAvUdefr99SUuyrcwVwbW
         W9JL80Ai4zHFa4KOBhsnGaxZdzBPfNZ4sx8UthSx4YG++3WWDf1jgOfzo4OLagj1LXrl
         SRS51msFbZx3DwnoQaw6BtQdUoIJkqstpOPIiY6foEywWHl8RvTXUSEEapJ50681lt/g
         Z3BkbM+/8W6IpId8EHCK0h0EgzOpuFh5ILjdBzogqKwknOpJOJO5ZB8fHchd7uXNJLZv
         Kh77QRHWbSwDpi1kUphRtIOTAtnhbNCsmIo51o8vMFPp3FAR7xayRe2EoVFVhidWtxoB
         IXpA==
X-Gm-Message-State: AOJu0YxKI7cGWjOWr3pq3O6JkR/zopMPASgetJMfLxIQSfq88FOzm7Ab
	hsOv8BSGrjilPf8VB7CB+ocyadvlA+GUwyUf/ekZCOwm67+n2wC2s/KQfY1C9Kd4MoE=
X-Gm-Gg: AY/fxX4Y8V9QivGPt1/Si4o7dPQDFKJx2+xsUJKKlFyXUE61l9t4aCAcRDhkyFSXzj9
	06hJ57RK9Bis6zqDuWqjP6+Lrx5ZgPF/E9MPgvpAOY8uJzGRZnn5+6wtLyXPZ9hP9sr7xKIMGwC
	dv4vWFGMb+HcDD9B0OrdO+0lQRgxXq6+mKW/4/ucujY2mvGDMTYlwcDQJELs5r5GOCnXcUocT+c
	v57PcZa0J+yOQI5pgYxk5lqkKjXMchfPzfBVU4lbLgcxyGRbHJDL0DtSx3ylUR+Ntdnjgjsuad6
	txDSeEGv8grf0M7Ihx3Bt+jk2dr9BXVI/nhi+SpZea3DcD7zMEh3EC/q7Zr7Bou1OR0corkOHNM
	A49HkmAESELAykh/NBWa1stwkuDIUMLlZPhqPRptVlwIp/FhchwisY3xv4sn3k7B5X/cDzEFyP+
	jQE7rOgdfErIaM/Wm+osYZwydsWSPcODWRuGU5A4uhYPfR/jQrtgZ1DcqS0EKrFIF9wh08sSOtV
	Sg=
X-Received: by 2002:ac8:7f0a:0:b0:4ee:228d:d6b8 with SMTP id d75a77b69052e-50148482933mr21948301cf.70.1768380761194;
        Wed, 14 Jan 2026 00:52:41 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148df8759sm10131931cf.10.2026.01.14.00.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 00:52:40 -0800 (PST)
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
Subject: [PATCH 4/8] mm/memory_hotplug: return online type from add_memory_driver_managed()
Date: Wed, 14 Jan 2026 03:51:56 -0500
Message-ID: <20260114085201.3222597-5-gourry@gourry.net>
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

Change add_memory_driver_managed() to return the online type (MMOP_*)
on success instead of 0. This allows callers to determine the actual
online state of the memory after addition, which is important when
MMOP_SYSTEM_DEFAULT is used and the actual online type depends on the
system default policy.

Update virtio_mem to handle the new return value semantics by checking
for rc < 0 to detect errors.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/kmem.c          | 2 +-
 drivers/virtio/virtio_mem.c | 5 +++--
 mm/memory_hotplug.c         | 4 +++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 5e0cf94a9620..d0dd36c536a0 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -178,7 +178,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 				range_len(&range), kmem_name, mhp_flags,
 				MMOP_SYSTEM_DEFAULT);
 
-		if (rc) {
+		if (rc < 0) {
 			dev_warn(dev, "mapping%d: %#llx-%#llx memory add failed\n",
 					i, range.start, range.end);
 			remove_resource(res);
diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index b1ec8f2b9e31..4decb44f5a43 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -656,15 +656,16 @@ static int virtio_mem_add_memory(struct virtio_mem *vm, uint64_t addr,
 	rc = add_memory_driver_managed(vm->mgid, addr, size, vm->resource_name,
 				       MHP_MERGE_RESOURCE | MHP_NID_IS_MGID,
 				       MMOP_SYSTEM_DEFAULT);
-	if (rc) {
+	if (rc < 0) {
 		atomic64_sub(size, &vm->offline_size);
 		dev_warn(&vm->vdev->dev, "adding memory failed: %d\n", rc);
 		/*
 		 * TODO: Linux MM does not properly clean up yet in all cases
 		 * where adding of memory failed - especially on -ENOMEM.
 		 */
+		return rc;
 	}
-	return rc;
+	return 0;
 }
 
 /*
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 515ff9d18039..41974a1ccb91 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1689,7 +1689,7 @@ EXPORT_SYMBOL_GPL(add_memory);
  * MMOP_ONLINE_MOVABLE to online with that type, MMOP_OFFLINE to leave offline,
  * or MMOP_SYSTEM_DEFAULT to use the system default policy.
  *
- * Returns 0 on success, negative error code on failure.
+ * Returns the online type (MMOP_*) on success, negative error code on failure.
  */
 int add_memory_driver_managed(int nid, u64 start, u64 size,
 			      const char *resource_name, mhp_t mhp_flags,
@@ -1721,6 +1721,8 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
 	rc = __add_memory_resource(nid, res, mhp_flags, online_type);
 	if (rc < 0)
 		release_memory_resource(res);
+	else
+		rc = online_type;
 
 out_unlock:
 	unlock_device_hotplug();
-- 
2.52.0

