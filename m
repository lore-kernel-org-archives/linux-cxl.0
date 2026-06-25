Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE903D9DC1
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 12:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389598; cv=none; b=YGTiwT++4aNq/hvOU0ys20iDxZ0R/XILLffsDkUaMHiJaR6wY52sGbzP63uY3+mKaq9aiNnFeNy4a8LZJ0nM0WyQ5a/TZbxJ/E0Gkp+8NBWEbHmoJMOuoCWSUD1RwPDXK4nAtZNvIUW1BFVL0y0u6WLK76pKT50kCM1tFIg2Sh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389598; c=relaxed/simple;
	bh=xJ/ICNkWheqKSMaG5TDZjQwBthEvf+tjk2YxwbB3SGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVLzHyA+89ugr367iwH0oT7GvVoHexbcACsjFr+luel1cuCg7G2K2X8AD94XYuVzwAFCgZ7kFduAHPYPclGvVxUWXDN6IcEfdu3nUqvX8jS01LIabD4TW0oEXPDbTaeFVAfhzH8nCLSQED7Ov6axTZlzo/4WBk390LVyWhKX2bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qUIjSdpo; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qUIjSdpo"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30c713f37c2so776440eec.0
        for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 05:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782389595; x=1782994395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G18zehfJH2C51qiLFUBVCY46IetjGTIchA+W2VJTLjM=;
        b=qUIjSdpob75k6Af5AXRACsPY6XYT+WFcQIKY/3JkceAjtlFNn45Pr6x/lSiByNpvJy
         66nFKv2ghxPexRpK9Mf2JcyHpKowFyrl08y3U4FmPgPYgV6Ah9eH0dDj44Kh/4QQOHiU
         Kl04pYX/X+dvoP8D2rUXg9bKuotHWJJ5HguoLZG4jz06Y7sUxnkYlSUcYK9atvQlRtce
         d4haeV19Rwtp/eAERLCHCtNyuPojQSWh7YY9D/j+19Hpt193Te6SiAtTKfOdm4JkMSCU
         f2DH9nOQ8WXD6q4vYpv8Fo5nS7pf7ZqqBte4XCTNhEC3TKXFNqwwDxlJKUB4s5XfZ6nV
         l7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782389595; x=1782994395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G18zehfJH2C51qiLFUBVCY46IetjGTIchA+W2VJTLjM=;
        b=cgbjZsTfEK2RPW7ozeTsbBHCqjjGue2qR2p8x7d24Qvta10IDXeCgR6qkPXdwJN8KC
         bW01WLQEw6yVLnsHD0Z40UvZ1jOy+NOqEIsT2NeeX0WkIvJ9mQI6W/pxjf3s5Hv04yHR
         fYw2TQh65GV7nuOilf1PNu3s+qi9Tox+6Vq1DyLBqWEdDzfsdwmVGEL0jpQy8dcbAssj
         K86nszQ9IAJ/vOjZa+VlGtKBI9JrbiIfs2R7+sRDxFHmttz378k0Skw6fXaePCGQmGL4
         5OwxWE0cG6RPQNHqsLjwoqIxuDDuwldj0vAHIB2EO4gBe7GTNDpyac0h72JnJCR9dZRu
         I46A==
X-Gm-Message-State: AOJu0Yz4EPqjPWbn1kQIVSmliSJLT8ORsRcJdvkJ/o/18ROHWm98YAKz
	dUnJSBopF9M1qGvYqzIzCMb9FwgWeSiPnZrGicYeRfvKUvdh4Zv3NX53WiGOhw==
X-Gm-Gg: AfdE7cmFP7PNXLARr/Iri+egmPp47vNcdfH0rFZkjIMo60P7KwEW8ONYrqNVDuoqtgE
	/NYFoJlIjz/jj32dm0oY/gYCbN5o8ELMgHV/4o499W2U7+G9+ocq8lG+6Css0N78RSpTxUbjDKd
	NuygJsCWUQ2q4kx0MZpEw7B7sYlE/bQ0LPNcw7EHdeaPlK6d83SaVm1OmgZxUwH0kzSGwM0lOHi
	q75/iMbtAQAc9VsMUzjiHIbvMkdx4eUwKpO3isUoNrN3eYXOEWkCJvoFrQPwcnSPo/yY6ousa1e
	H9po71K62DBmHp+Tbymu3dcRot6k9mxg0LJ0DwgOgwySnSCGMNZC0L0v74aZ0a9yQEGhP/LLdRo
	bOwr2L/q94JdXfQQ7+ZpFLEuyuLv07lairnqRbiHJq9NLgQVmT9E2PtuiT3yj0R/7Dl6hrc7/oE
	3sAhalcd5XyAqxPaDTip9iqW8KMtJWhFQradIiZ+9xp9HtjHU8XXQZowmyby6olVrSxCD/Ag0Hr
	iUeA5k=
X-Received: by 2002:a05:7022:f112:b0:135:e781:74af with SMTP id a92af1059eb24-139db9f5507mr2036970c88.18.1782389594744;
        Thu, 25 Jun 2026 05:13:14 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d8f77602sm7422206c88.8.2026.06.25.05.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 05:13:14 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@Groves.net>,
	Gregory Price <gourry@gourry.net>,
	Anisa Su <anisa.su@samsung.com>
Subject: [NDCTL PATCH v7 2/5] libcxl: Add extent functionality to DC regions
Date: Thu, 25 Jun 2026 05:09:36 -0700
Message-ID: <20260625121242.603807-3-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625121242.603807-1-anisa.su@samsung.com>
References: <20260625121242.603807-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <iweiny@kernel.org>

DCD regions have 0 or more extents.  The ability to list those and their
properties is useful to end users.

Add extent scanning and reporting functionality to libcxl.

Signed-off-by: Ira Weiny <iweiny@kernel.org>
Signed-off-by: Anisa Su <anisa.su@samsung.com>

---
Changes:
1. s/tag/uuid/ for extents
---
 Documentation/cxl/lib/libcxl.txt |  27 ++++++
 cxl/lib/libcxl.c                 | 143 +++++++++++++++++++++++++++++++
 cxl/lib/libcxl.sym               |   5 ++
 cxl/lib/private.h                |  10 +++
 cxl/libcxl.h                     |  11 +++
 5 files changed, 196 insertions(+)

diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
index 59163e4..7eca5eb 100644
--- a/Documentation/cxl/lib/libcxl.txt
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -635,6 +635,33 @@ where its properties can be interrogated by daxctl. The helper
 cxl_region_get_daxctl_region() returns an 'struct daxctl_region *' that
 can be used with other libdaxctl APIs.
 
+EXTENTS
+-------
+
+=== EXTENT: Enumeration
+----
+struct cxl_region_extent;
+struct cxl_region_extent *cxl_extent_get_first(struct cxl_region *region);
+struct cxl_region_extent *cxl_extent_get_next(struct cxl_region_extent *extent);
+#define cxl_extent_foreach(region, extent) \
+        for (extent = cxl_extent_get_first(region); \
+             extent != NULL; \
+             extent = cxl_extent_get_next(extent))
+
+----
+
+=== EXTENT: Attributes
+----
+unsigned long long cxl_extent_get_offset(struct cxl_region_extent *extent);
+unsigned long long cxl_extent_get_length(struct cxl_region_extent *extent);
+void cxl_extent_get_uuid(struct cxl_region_extent *extent, uuid_t uuid);
+----
+
+Extents represent available memory within a dynamic capacity region.  Extent
+objects are available for informational purposes to aid in allocation of
+memory.
+
+
 include::../../copyright.txt[]
 
 SEE ALSO
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 240ed75..c211687 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -110,11 +110,16 @@ static void free_target(struct cxl_target *target, struct list_head *head)
 static void free_region(struct cxl_region *region, struct list_head *head)
 {
 	struct cxl_memdev_mapping *mapping, *_m;
+	struct cxl_region_extent *extent, *_e;
 
 	list_for_each_safe(&region->mappings, mapping, _m, list) {
 		list_del_from(&region->mappings, &mapping->list);
 		free(mapping);
 	}
+	list_for_each_safe(&region->extents, extent, _e, list) {
+		list_del_from(&region->extents, &extent->list);
+		free(extent);
+	}
 	if (head)
 		list_del_from(head, &region->list);
 	kmod_module_unref(region->module);
@@ -635,6 +640,7 @@ static void *add_cxl_region(void *parent, int id, const char *cxlregion_base)
 	region->ctx = ctx;
 	region->decoder = decoder;
 	list_head_init(&region->mappings);
+	list_head_init(&region->extents);
 
 	region->dev_path = strdup(cxlregion_base);
 	if (!region->dev_path)
@@ -1257,6 +1263,143 @@ cxl_mapping_get_next(struct cxl_memdev_mapping *mapping)
 	return list_next(&region->mappings, mapping, list);
 }
 
+static void cxl_extents_init(struct cxl_region *region)
+{
+	const char *devname = cxl_region_get_devname(region);
+	struct cxl_ctx *ctx = cxl_region_get_ctx(region);
+	char *extent_path, *dax_region_path;
+	struct dirent *de;
+	DIR *dir = NULL;
+
+	if (region->extents_init)
+		return;
+	region->extents_init = 1;
+
+	dax_region_path = calloc(1, strlen(region->dev_path) + 64);
+	if (!dax_region_path) {
+		err(ctx, "%s: allocation failure\n", devname);
+		return;
+	}
+
+	extent_path = calloc(1, strlen(region->dev_path) + 100);
+	if (!extent_path) {
+		err(ctx, "%s: allocation failure\n", devname);
+		free(dax_region_path);
+		return;
+	}
+
+	sprintf(dax_region_path, "%s/dax_region%d",
+		region->dev_path, region->id);
+	dir = opendir(dax_region_path);
+	if (!dir) {
+		err(ctx, "no extents found (%s): %s\n",
+			strerror(errno), dax_region_path);
+		free(extent_path);
+		free(dax_region_path);
+		return;
+	}
+
+	while ((de = readdir(dir)) != NULL) {
+		struct cxl_region_extent *extent;
+		char buf[SYSFS_ATTR_SIZE];
+		u64 offset, length;
+		int id, region_id;
+
+		if (sscanf(de->d_name, "extent%d.%d", &region_id, &id) != 2)
+			continue;
+
+		sprintf(extent_path, "%s/extent%d.%d/offset",
+			dax_region_path, region_id, id);
+		if (sysfs_read_attr(ctx, extent_path, buf) < 0) {
+			err(ctx, "%s: failed to read extent%d.%d/offset\n",
+				devname, region_id, id);
+			continue;
+		}
+
+		offset = strtoull(buf, NULL, 0);
+		if (offset == ULLONG_MAX) {
+			err(ctx, "%s extent%d.%d: failed to read offset\n",
+				devname, region_id, id);
+			continue;
+		}
+
+		sprintf(extent_path, "%s/extent%d.%d/length",
+			dax_region_path, region_id, id);
+		if (sysfs_read_attr(ctx, extent_path, buf) < 0) {
+			err(ctx, "%s: failed to read extent%d.%d/length\n",
+				devname, region_id, id);
+			continue;
+		}
+
+		length = strtoull(buf, NULL, 0);
+		if (length == ULLONG_MAX) {
+			err(ctx, "%s extent%d.%d: failed to read length\n",
+				devname, region_id, id);
+			continue;
+		}
+
+		sprintf(extent_path, "%s/extent%d.%d/uuid",
+			dax_region_path, region_id, id);
+		buf[0] = '\0';
+		if (sysfs_read_attr(ctx, extent_path, buf) != 0)
+			dbg(ctx, "%s extent%d.%d: failed to read uuid\n",
+				devname, region_id, id);
+
+		extent = calloc(1, sizeof(*extent));
+		if (!extent) {
+			err(ctx, "%s extent%d.%d: allocation failure\n",
+				devname, region_id, id);
+			continue;
+		}
+		if (strlen(buf) && uuid_parse(buf, extent->uuid) < 0)
+			err(ctx, "%s:%s\n", extent_path, buf);
+		extent->region = region;
+		extent->offset = offset;
+		extent->length = length;
+
+		list_node_init(&extent->list);
+		list_add(&region->extents, &extent->list);
+		dbg(ctx, "%s added extent%d.%d\n", devname, region_id, id);
+	}
+	free(dax_region_path);
+	free(extent_path);
+	closedir(dir);
+}
+
+CXL_EXPORT struct cxl_region_extent *
+cxl_extent_get_first(struct cxl_region *region)
+{
+	cxl_extents_init(region);
+
+	return list_top(&region->extents, struct cxl_region_extent, list);
+}
+
+CXL_EXPORT struct cxl_region_extent *
+cxl_extent_get_next(struct cxl_region_extent *extent)
+{
+	struct cxl_region *region = extent->region;
+
+	return list_next(&region->extents, extent, list);
+}
+
+CXL_EXPORT unsigned long long
+cxl_extent_get_offset(struct cxl_region_extent *extent)
+{
+	return extent->offset;
+}
+
+CXL_EXPORT unsigned long long
+cxl_extent_get_length(struct cxl_region_extent *extent)
+{
+	return extent->length;
+}
+
+CXL_EXPORT void
+cxl_extent_get_uuid(struct cxl_region_extent *extent, uuid_t uuid)
+{
+	memcpy(uuid, extent->uuid, sizeof(uuid_t));
+}
+
 CXL_EXPORT struct cxl_decoder *
 cxl_mapping_get_decoder(struct cxl_memdev_mapping *mapping)
 {
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 4a8443c..4d7da17 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -327,4 +327,9 @@ global:
 	cxl_memdev_get_dynamic_ram_1_qos_class;
 	cxl_decoder_is_dynamic_ram_1_capable;
 	cxl_decoder_create_dynamic_ram_1_region;
+	cxl_extent_get_first;
+	cxl_extent_get_next;
+	cxl_extent_get_offset;
+	cxl_extent_get_length;
+	cxl_extent_get_uuid;
 } LIBCXL_12;
diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index fb45e15..cac0cd1 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -183,6 +183,7 @@ struct cxl_region {
 	struct cxl_decoder *decoder;
 	struct list_node list;
 	int mappings_init;
+	int extents_init;
 	struct cxl_ctx *ctx;
 	void *dev_buf;
 	size_t buf_len;
@@ -200,6 +201,7 @@ struct cxl_region {
 	struct daxctl_region *dax_region;
 	struct kmod_module *module;
 	struct list_head mappings;
+	struct list_head extents;
 };
 
 struct cxl_memdev_mapping {
@@ -209,6 +211,14 @@ struct cxl_memdev_mapping {
 	struct list_node list;
 };
 
+struct cxl_region_extent {
+	struct cxl_region *region;
+	u64 offset;
+	u64 length;
+	uuid_t uuid;
+	struct list_node list;
+};
+
 enum cxl_cmd_query_status {
 	CXL_CMD_QUERY_NOT_RUN = 0,
 	CXL_CMD_QUERY_OK,
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 8ee6937..d18a18b 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -394,6 +394,17 @@ unsigned int cxl_mapping_get_position(struct cxl_memdev_mapping *mapping);
              mapping != NULL; \
              mapping = cxl_mapping_get_next(mapping))
 
+struct cxl_region_extent;
+struct cxl_region_extent *cxl_extent_get_first(struct cxl_region *region);
+struct cxl_region_extent *cxl_extent_get_next(struct cxl_region_extent *extent);
+#define cxl_extent_foreach(region, extent) \
+        for (extent = cxl_extent_get_first(region); \
+             extent != NULL; \
+             extent = cxl_extent_get_next(extent))
+unsigned long long cxl_extent_get_offset(struct cxl_region_extent *extent);
+unsigned long long cxl_extent_get_length(struct cxl_region_extent *extent);
+void cxl_extent_get_uuid(struct cxl_region_extent *extent, uuid_t uuid);
+
 struct cxl_cmd;
 const char *cxl_cmd_get_devname(struct cxl_cmd *cmd);
 struct cxl_cmd *cxl_cmd_new_raw(struct cxl_memdev *memdev, int opcode);
-- 
2.43.0

