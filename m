Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A0E158535
	for <linux-cxl@vger.kernel.org>; Wed,  3 Dec 2025 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796630; cv=none; b=PM+WlVkj3gPDN1Jv42dWhk8JlNTFGKuOJFmUZRwqgPNeRa7f2LxAfe7e89/xntSsuTn6xI8qE83Gcu9pJnfN95ugsgjHGmtNjMvBHNysnDfC9rz3SeIC1MH6fRdlDifIpaafmoQKTpfgUX3auGnPbFFpcHxBQVHgObp7s+md/Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796630; c=relaxed/simple;
	bh=KC4iVFGwrXyB7RMq6Kq8SShG+piQmbAtZMruneLhO3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAecmGkR8U12pw3/S8BR4IKGZHpaz373szMqEyelTQeMRVZ7d0awyZbQGLiIfUGyB8wQT5Cw8RzMR35YJPQ72mYNSHpFLIjLWRZsLpSYG68+4Xp1qD9P57DFtonvbhmK11BWdEyG8FFwLy3Tje3m9caAx+gnnBU8BWe9jEoatIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czOc8p/N; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czOc8p/N"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-bde0f62464cso147288a12.2
        for <linux-cxl@vger.kernel.org>; Wed, 03 Dec 2025 13:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764796627; x=1765401427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfIVZYuIfz6Mgmz739dIq+8hxZWrvbeQsz6ZqMuQmFc=;
        b=czOc8p/Nd578G6m/zswJFAVvz2A5+9aU/akpK+ooOQd4IySB1q2+1FEoNYdn3z83dR
         oEl/J8DMbSL3j2tU+ddWJcq1dXpkgC3+Wb38B/y/jkcFh9hRiNAAa9VWK6Lo8el3Fgpq
         IAZJeV6nE7rBr7a0OoRelw4/dQhxt/jL7reWSEy8APzWi5st6Fik/IIjje/VBqPXnU9e
         tT48XHINRDICRQLGYCk1czDSXKy17qX4JZlh7M3vknHbSRqI7wQuTo/mbgOCLcNTiLp7
         G/+5fkgAkh2x7N7cV3SU8Q+UCpI8i3XY/hU2iHQHyEbEcqEQ65APVZTYrJ/hy2HYXajC
         ML2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764796627; x=1765401427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YfIVZYuIfz6Mgmz739dIq+8hxZWrvbeQsz6ZqMuQmFc=;
        b=UqQcTezE4zSU/4Q+5K8zUWmIWLr1SZzuhVQQgxKRc7b0AtvI8G8MB+zxYX82wwvbKN
         0MkrnGYhWpkSVi7I+35KbnGhdMRbSkW2o9SeoxM/UMnO+cr4L7O+39b7omdkp9F3SxLH
         Z0kPCN/4kdYax4XbOx8qHNTNvTEnagUwLlell849BWgL7qSiWAunRFxr97GPPUtYumIU
         pliUrGZCPfsCzt2/uyfU48uUD9QMMb9/1N8ZF3vZf297tieJUIMfhc998aPKUgYHkWoR
         i3rgQqJQCG2O0j9qK8ZCYHzihrKdCk5d77TQU5MFUibZ/wgDQ++Bl583XcdRNL053mnE
         yl5Q==
X-Gm-Message-State: AOJu0YztZ+fTDDLoad48cWdh46Gl4Tg6yQ94fRKMHzW3+QY4vb+KVSOG
	V7o3Ozjn5Wsk1Iz7YoLxKBdCmKNwblxd0RiYim6gqZNamiJJZCQcW5rrh1TqWA==
X-Gm-Gg: ASbGncuqTg++fPwHIbyEmaKcu9nvubdYUeMkDzwePC5v2NCJajQWppuVTtUrUuS8fSy
	8eixQRty4ii5KZdpuRSAa9RxuBNVzdjEnYBHjt5K01jgNIgbnz2TIC6FOK9C9eMoTT1zIqOCYD4
	9gI1PnTj28j4mUcOctVWntIB3f0q7CpGtq+/Accf1bgAQkSC3/GAqUJ/yh0o7WKuqSDnE0cZN1B
	zS8jAzV2A0qu+MeBFqNsa7WbnLsTFwGzhReVv4mljKgolhmbC2+xEiUaViNF0cXKlUYsv9tqqiV
	5JYL0k2z+lWtsuWI/5gmGhtAHAzXkgtnADrDQ7dbDIE4j7uf3mhNeCijCcjah6yDcr4Kilr4Sp0
	saOVjPkp45X6GdoBH1kHbsaIm0NVKbHT8tZp7GJw07TawpHD37KlpMmVut7jJWug18Q==
X-Google-Smtp-Source: AGHT+IEpBOIbXCvHai9peLEBkrj17HOinxOwH+OC9fo/v+a7bUGgBbObdKlSuYw/hK6gHWExOo6vzw==
X-Received: by 2002:a05:7300:8192:b0:2a4:3594:d545 with SMTP id 5a478bee46e88-2ab92e3b27emr2738827eec.18.1764796625760;
        Wed, 03 Dec 2025 13:17:05 -0800 (PST)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a9653ca11esm67419981eec.0.2025.12.03.13.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 13:17:05 -0800 (PST)
From: anisa.su887@gmail.com
To: linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com,
	nifan.cxl@gmail.com,
	dongjoo.seo1@samsung.com,
	dave@stgolabs.net,
	Anisa Su <anisa.su@samsung.com>
Subject: [RFC NDCTL PATCH 1/2] rename RAM_A to RAM_0
Date: Wed,  3 Dec 2025 21:15:24 +0000
Message-ID: <20251203211642.1104918-2-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251203211642.1104918-1-anisa.su887@gmail.com>
References: <20251203211642.1104918-1-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <nifan.cxl@gmail.com>

In preparation for the next patch to enable modes RAM_0-7, rename RAM_A
to RAM_0.

Signed-off-by: Fan Ni <nifan.cxl@gmail.com>
Tested-by: Anisa Su <anisa.su@samsung.com>
Tested-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
---
 Documentation/cxl/lib/libcxl.txt |  6 ++---
 cxl/json.c                       | 12 ++++-----
 cxl/lib/libcxl.c                 | 46 ++++++++++++++++----------------
 cxl/lib/libcxl.sym               |  8 +++---
 cxl/lib/private.h                |  6 ++---
 cxl/libcxl.h                     | 18 ++++++-------
 cxl/memdev.c                     |  2 +-
 cxl/region.c                     | 22 +++++++--------
 test/cxl-dcd.sh                  |  4 +--
 9 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
index 84f39d2..0fd857f 100644
--- a/Documentation/cxl/lib/libcxl.txt
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -68,7 +68,7 @@ int cxl_memdev_get_major(struct cxl_memdev *memdev);
 int cxl_memdev_get_minor(struct cxl_memdev *memdev);
 unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memdev);
 unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev);
-unsigned long long cxl_memdev_get_dynamic_ram_a_size(struct cxl_memdev *memdev);
+unsigned long long cxl_memdev_get_dynamic_ram_0_size(struct cxl_memdev *memdev);
 const char *cxl_memdev_get_firmware_version(struct cxl_memdev *memdev);
 size_t cxl_memdev_get_label_size(struct cxl_memdev *memdev);
 int cxl_memdev_nvdimm_bridge_active(struct cxl_memdev *memdev);
@@ -88,7 +88,7 @@ The character device node for command submission can be found by default
 at /dev/cxl/mem%d, or created with a major / minor returned from
 cxl_memdev_get_{major,minor}().
 
-The 'pmem_size', 'ram_size', and 'dynamic_ram_a_size' attributes return the
+The 'pmem_size', 'ram_size', and 'dynamic_ram_0_size' attributes return the
 current provisioning of DPA (Device Physical Address / local capacity) in the
 device.
 
@@ -423,7 +423,7 @@ enum cxl_decoder_mode {
 	CXL_DECODER_MODE_MIXED,
 	CXL_DECODER_MODE_PMEM,
 	CXL_DECODER_MODE_RAM,
-	CXL_DECODER_MODE_DYNAMIC_RAM_A,
+	CXL_DECODER_MODE_DYNAMIC_RAM_0,
 };
 enum cxl_decoder_mode cxl_decoder_get_mode(struct cxl_decoder *decoder);
 int cxl_decoder_set_mode(struct cxl_decoder *decoder, enum cxl_decoder_mode mode);
diff --git a/cxl/json.c b/cxl/json.c
index 0c47550..512572d 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -800,17 +800,17 @@ struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
 		}
 	}
 
-	size = cxl_memdev_get_dynamic_ram_a_size(memdev);
+	size = cxl_memdev_get_dynamic_ram_0_size(memdev);
 	if (size) {
 		jobj = util_json_object_size(size, flags);
 		if (jobj)
-			json_object_object_add(jdev, "dynamic_ram_a_size", jobj);
+			json_object_object_add(jdev, "dynamic_ram_0_size", jobj);
 
-		qos_class = cxl_memdev_get_dynamic_ram_a_qos_class(memdev);
+		qos_class = cxl_memdev_get_dynamic_ram_0_qos_class(memdev);
 		if (qos_class != CXL_QOS_CLASS_NONE) {
 			jobj = json_object_new_int(qos_class);
 			if (jobj)
-				json_object_object_add(jdev, "dynamic_ram_a_qos_class", jobj);
+				json_object_object_add(jdev, "dynamic_ram_0_qos_class", jobj);
 		}
 	}
 
@@ -1073,11 +1073,11 @@ struct json_object *util_cxl_decoder_to_json(struct cxl_decoder *decoder,
 				json_object_object_add(
 					jdecoder, "volatile_capable", jobj);
 		}
-		if (cxl_decoder_is_dynamic_ram_a_capable(decoder)) {
+		if (cxl_decoder_is_dynamic_ram_0_capable(decoder)) {
 			jobj = json_object_new_boolean(true);
 			if (jobj)
 				json_object_object_add(
-					jdecoder, "dynamic_ram_a_capable", jobj);
+					jdecoder, "dynamic_ram_0_capable", jobj);
 		}
 	}
 
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 306a466..59a349b 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -437,8 +437,8 @@ CXL_EXPORT bool cxl_region_qos_class_mismatch(struct cxl_region *region)
 		} else if (region->mode == CXL_DECODER_MODE_PMEM) {
 			if (root_decoder->qos_class != memdev->pmem_qos_class)
 				return true;
-		} else if (region->mode == CXL_DECODER_MODE_DYNAMIC_RAM_A) {
-			if (root_decoder->qos_class != memdev->dynamic_ram_a_qos_class)
+		} else if (region->mode == CXL_DECODER_MODE_DYNAMIC_RAM_0) {
+			if (root_decoder->qos_class != memdev->dynamic_ram_0_qos_class)
 				return true;
 		}
 	}
@@ -1492,9 +1492,9 @@ static void *add_cxl_memdev(void *parent, int id, const char *cxlmem_base)
 	if (sysfs_read_attr(ctx, path, buf) == 0)
 		memdev->ram_size = strtoull(buf, NULL, 0);
 
-	sprintf(path, "%s/dynamic_ram_a/size", cxlmem_base);
+	sprintf(path, "%s/dynamic_ram_0/size", cxlmem_base);
 	if (sysfs_read_attr(ctx, path, buf) == 0)
-		memdev->dynamic_ram_a_size = strtoull(buf, NULL, 0);
+		memdev->dynamic_ram_0_size = strtoull(buf, NULL, 0);
 
 	sprintf(path, "%s/pmem/qos_class", cxlmem_base);
 	if (sysfs_read_attr(ctx, path, buf) < 0)
@@ -1508,11 +1508,11 @@ static void *add_cxl_memdev(void *parent, int id, const char *cxlmem_base)
 	else
 		memdev->ram_qos_class = atoi(buf);
 
-	sprintf(path, "%s/dynamic_ram_a/qos_class", cxlmem_base);
+	sprintf(path, "%s/dynamic_ram_0/qos_class", cxlmem_base);
 	if (sysfs_read_attr(ctx, path, buf) < 0)
-		memdev->dynamic_ram_a_qos_class = CXL_QOS_CLASS_NONE;
+		memdev->dynamic_ram_0_qos_class = CXL_QOS_CLASS_NONE;
 	else
-		memdev->dynamic_ram_a_qos_class = atoi(buf);
+		memdev->dynamic_ram_0_qos_class = atoi(buf);
 
 	sprintf(path, "%s/payload_max", cxlmem_base);
 	if (sysfs_read_attr(ctx, path, buf) == 0) {
@@ -1750,9 +1750,9 @@ CXL_EXPORT unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev)
 	return memdev->ram_size;
 }
 
-CXL_EXPORT unsigned long long cxl_memdev_get_dynamic_ram_a_size(struct cxl_memdev *memdev)
+CXL_EXPORT unsigned long long cxl_memdev_get_dynamic_ram_0_size(struct cxl_memdev *memdev)
 {
-	return memdev->dynamic_ram_a_size;
+	return memdev->dynamic_ram_0_size;
 }
 
 CXL_EXPORT int cxl_memdev_get_pmem_qos_class(struct cxl_memdev *memdev)
@@ -1765,9 +1765,9 @@ CXL_EXPORT int cxl_memdev_get_ram_qos_class(struct cxl_memdev *memdev)
 	return memdev->ram_qos_class;
 }
 
-CXL_EXPORT int cxl_memdev_get_dynamic_ram_a_qos_class(struct cxl_memdev *memdev)
+CXL_EXPORT int cxl_memdev_get_dynamic_ram_0_qos_class(struct cxl_memdev *memdev)
 {
-	return memdev->dynamic_ram_a_qos_class;
+	return memdev->dynamic_ram_0_qos_class;
 }
 
 CXL_EXPORT const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev)
@@ -2509,8 +2509,8 @@ static void *add_cxl_decoder(void *parent, int id, const char *cxldecoder_base)
 			decoder->mode = CXL_DECODER_MODE_MIXED;
 		else if (strcmp(buf, "none") == 0)
 			decoder->mode = CXL_DECODER_MODE_NONE;
-		else if (strcmp(buf, "dynamic_ram_a") == 0)
-			decoder->mode = CXL_DECODER_MODE_DYNAMIC_RAM_A;
+		else if (strcmp(buf, "dynamic_ram_0") == 0)
+			decoder->mode = CXL_DECODER_MODE_DYNAMIC_RAM_0;
 		else
 			decoder->mode = CXL_DECODER_MODE_MIXED;
 	} else
@@ -2550,7 +2550,7 @@ static void *add_cxl_decoder(void *parent, int id, const char *cxldecoder_base)
 	case CXL_PORT_SWITCH:
 		decoder->pmem_capable = true;
 		decoder->volatile_capable = true;
-		decoder->dynamic_ram_a_capable = true;
+		decoder->dynamic_ram_0_capable = true;
 		decoder->mem_capable = true;
 		decoder->accelmem_capable = true;
 		sprintf(path, "%s/locked", cxldecoder_base);
@@ -2575,7 +2575,7 @@ static void *add_cxl_decoder(void *parent, int id, const char *cxldecoder_base)
 			{ "cap_type3", &decoder->mem_capable },
 			{ "cap_ram", &decoder->volatile_capable },
 			{ "cap_pmem", &decoder->pmem_capable },
-			{ "cap_dynamic_ram_a", &decoder->dynamic_ram_a_capable },
+			{ "cap_dynamic_ram_0", &decoder->dynamic_ram_0_capable },
 			{ "locked", &decoder->locked },
 		};
 
@@ -2826,8 +2826,8 @@ CXL_EXPORT int cxl_decoder_set_mode(struct cxl_decoder *decoder,
 	case CXL_DECODER_MODE_RAM:
 		sprintf(buf, "ram");
 		break;
-	case CXL_DECODER_MODE_DYNAMIC_RAM_A:
-		sprintf(buf, "dynamic_ram_a");
+	case CXL_DECODER_MODE_DYNAMIC_RAM_0:
+		sprintf(buf, "dynamic_ram_0");
 		break;
 	default:
 		err(ctx, "%s: unsupported mode: %d\n",
@@ -2880,9 +2880,9 @@ CXL_EXPORT bool cxl_decoder_is_volatile_capable(struct cxl_decoder *decoder)
 	return decoder->volatile_capable;
 }
 
-CXL_EXPORT bool cxl_decoder_is_dynamic_ram_a_capable(struct cxl_decoder *decoder)
+CXL_EXPORT bool cxl_decoder_is_dynamic_ram_0_capable(struct cxl_decoder *decoder)
 {
-	return decoder->dynamic_ram_a_capable;
+	return decoder->dynamic_ram_0_capable;
 }
 
 CXL_EXPORT bool cxl_decoder_is_mem_capable(struct cxl_decoder *decoder)
@@ -2959,8 +2959,8 @@ static struct cxl_region *cxl_decoder_create_region(struct cxl_decoder *decoder,
 		sprintf(path, "%s/create_pmem_region", decoder->dev_path);
 	else if (mode == CXL_DECODER_MODE_RAM)
 		sprintf(path, "%s/create_ram_region", decoder->dev_path);
-	else if (mode == CXL_DECODER_MODE_DYNAMIC_RAM_A)
-		sprintf(path, "%s/create_dynamic_ram_a_region", decoder->dev_path);
+	else if (mode == CXL_DECODER_MODE_DYNAMIC_RAM_0)
+		sprintf(path, "%s/create_dynamic_ram_0_region", decoder->dev_path);
 
 	rc = sysfs_read_attr(ctx, path, buf);
 	if (rc < 0) {
@@ -3013,9 +3013,9 @@ cxl_decoder_create_ram_region(struct cxl_decoder *decoder)
 }
 
 CXL_EXPORT struct cxl_region *
-cxl_decoder_create_dynamic_ram_a_region(struct cxl_decoder *decoder)
+cxl_decoder_create_dynamic_ram_0_region(struct cxl_decoder *decoder)
 {
-	return cxl_decoder_create_region(decoder, CXL_DECODER_MODE_DYNAMIC_RAM_A);
+	return cxl_decoder_create_region(decoder, CXL_DECODER_MODE_DYNAMIC_RAM_0);
 }
 
 CXL_EXPORT int cxl_decoder_get_nr_targets(struct cxl_decoder *decoder)
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index b9d99ec..2fc9961 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -293,10 +293,10 @@ global:
 	cxl_bus_get_by_provider;
 	cxl_memdev_get_fwctl_major;
 	cxl_memdev_get_fwctl_minor;
-	cxl_memdev_get_dynamic_ram_a_size;
-	cxl_memdev_get_dynamic_ram_a_qos_class;
-	cxl_decoder_is_dynamic_ram_a_capable;
-	cxl_decoder_create_dynamic_ram_a_region;
+	cxl_memdev_get_dynamic_ram_0_size;
+	cxl_memdev_get_dynamic_ram_0_qos_class;
+	cxl_decoder_is_dynamic_ram_0_capable;
+	cxl_decoder_create_dynamic_ram_0_region;
 	cxl_extent_get_first;
 	cxl_extent_get_next;
 	cxl_extent_get_offset;
diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index d5e0c05..436dbcc 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -48,10 +48,10 @@ struct cxl_memdev {
 	struct list_node list;
 	unsigned long long pmem_size;
 	unsigned long long ram_size;
-	unsigned long long dynamic_ram_a_size;
+	unsigned long long dynamic_ram_0_size;
 	int ram_qos_class;
 	int pmem_qos_class;
-	int dynamic_ram_a_qos_class;
+	int dynamic_ram_0_qos_class;
 	int payload_max;
 	size_t lsa_size;
 	struct kmod_module *module;
@@ -142,7 +142,7 @@ struct cxl_decoder {
 	unsigned int interleave_granularity;
 	bool pmem_capable;
 	bool volatile_capable;
-	bool dynamic_ram_a_capable;
+	bool dynamic_ram_0_capable;
 	bool mem_capable;
 	bool accelmem_capable;
 	bool locked;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 3b3f6ae..feb36d2 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -74,10 +74,10 @@ int cxl_memdev_get_fwctl_minor(struct cxl_memdev *memdev);
 struct cxl_ctx *cxl_memdev_get_ctx(struct cxl_memdev *memdev);
 unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memdev);
 unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev);
-unsigned long long cxl_memdev_get_dynamic_ram_a_size(struct cxl_memdev *memdev);
+unsigned long long cxl_memdev_get_dynamic_ram_0_size(struct cxl_memdev *memdev);
 int cxl_memdev_get_pmem_qos_class(struct cxl_memdev *memdev);
 int cxl_memdev_get_ram_qos_class(struct cxl_memdev *memdev);
-int cxl_memdev_get_dynamic_ram_a_qos_class(struct cxl_memdev *memdev);
+int cxl_memdev_get_dynamic_ram_0_qos_class(struct cxl_memdev *memdev);
 const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev);
 bool cxl_memdev_fw_update_in_progress(struct cxl_memdev *memdev);
 size_t cxl_memdev_fw_update_get_remaining(struct cxl_memdev *memdev);
@@ -202,7 +202,7 @@ enum cxl_decoder_mode {
 	CXL_DECODER_MODE_MIXED,
 	CXL_DECODER_MODE_PMEM,
 	CXL_DECODER_MODE_RAM,
-	CXL_DECODER_MODE_DYNAMIC_RAM_A,
+	CXL_DECODER_MODE_DYNAMIC_RAM_0,
 };
 
 static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
@@ -212,10 +212,10 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
 		[CXL_DECODER_MODE_MIXED] = "mixed",
 		[CXL_DECODER_MODE_PMEM] = "pmem",
 		[CXL_DECODER_MODE_RAM] = "ram",
-		[CXL_DECODER_MODE_DYNAMIC_RAM_A] = "dynamic_ram_a",
+		[CXL_DECODER_MODE_DYNAMIC_RAM_0] = "dynamic_ram_0",
 	};
 
-	if (mode < CXL_DECODER_MODE_NONE || mode > CXL_DECODER_MODE_DYNAMIC_RAM_A)
+	if (mode < CXL_DECODER_MODE_NONE || mode > CXL_DECODER_MODE_DYNAMIC_RAM_0)
 		mode = CXL_DECODER_MODE_NONE;
 	return names[mode];
 }
@@ -229,8 +229,8 @@ cxl_decoder_mode_from_ident(const char *ident)
 		return CXL_DECODER_MODE_RAM;
 	else if (strcmp(ident, "pmem") == 0)
 		return CXL_DECODER_MODE_PMEM;
-	else if (strcmp(ident, "dynamic_ram_a") == 0)
-		return CXL_DECODER_MODE_DYNAMIC_RAM_A;
+	else if (strcmp(ident, "dynamic_ram_0") == 0)
+		return CXL_DECODER_MODE_DYNAMIC_RAM_0;
 	return CXL_DECODER_MODE_NONE;
 }
 
@@ -260,7 +260,7 @@ cxl_decoder_get_target_type(struct cxl_decoder *decoder);
 bool cxl_decoder_is_pmem_capable(struct cxl_decoder *decoder);
 bool cxl_decoder_is_volatile_capable(struct cxl_decoder *decoder);
 bool cxl_decoder_is_mem_capable(struct cxl_decoder *decoder);
-bool cxl_decoder_is_dynamic_ram_a_capable(struct cxl_decoder *decoder);
+bool cxl_decoder_is_dynamic_ram_0_capable(struct cxl_decoder *decoder);
 bool cxl_decoder_is_accelmem_capable(struct cxl_decoder *decoder);
 bool cxl_decoder_is_locked(struct cxl_decoder *decoder);
 unsigned int
@@ -269,7 +269,7 @@ unsigned int cxl_decoder_get_interleave_ways(struct cxl_decoder *decoder);
 struct cxl_region *cxl_decoder_get_region(struct cxl_decoder *decoder);
 struct cxl_region *cxl_decoder_create_pmem_region(struct cxl_decoder *decoder);
 struct cxl_region *cxl_decoder_create_ram_region(struct cxl_decoder *decoder);
-struct cxl_region *cxl_decoder_create_dynamic_ram_a_region(struct cxl_decoder *decoder);
+struct cxl_region *cxl_decoder_create_dynamic_ram_0_region(struct cxl_decoder *decoder);
 struct cxl_decoder *cxl_decoder_get_by_name(struct cxl_ctx *ctx,
 					    const char *ident);
 struct cxl_memdev *cxl_decoder_get_memdev(struct cxl_decoder *decoder);
diff --git a/cxl/memdev.c b/cxl/memdev.c
index bdcb008..33e2bf9 100644
--- a/cxl/memdev.c
+++ b/cxl/memdev.c
@@ -272,7 +272,7 @@ static int __reserve_dpa(struct cxl_memdev *memdev,
 	else if (mode == CXL_DECODER_MODE_PMEM)
 		avail_dpa = cxl_memdev_get_pmem_size(memdev);
 	else
-		avail_dpa = cxl_memdev_get_dynamic_ram_a_size(memdev);
+		avail_dpa = cxl_memdev_get_dynamic_ram_0_size(memdev);
 
 	cxl_decoder_foreach(port, decoder) {
 		size = cxl_decoder_get_dpa_size(decoder);
diff --git a/cxl/region.c b/cxl/region.c
index 824274e..005aca4 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -304,7 +304,7 @@ static int parse_create_options(struct cxl_ctx *ctx, int count,
 	if (param.type) {
 		p->mode = cxl_decoder_mode_from_ident(param.type);
 		if ((p->mode == CXL_DECODER_MODE_RAM ||
-		     p->mode == CXL_DECODER_MODE_DYNAMIC_RAM_A) && param.uuid) {
+		     p->mode == CXL_DECODER_MODE_DYNAMIC_RAM_0) && param.uuid) {
 			log_err(&rl,
 				"can't set UUID for ram / volatile regions");
 			goto err;
@@ -418,8 +418,8 @@ static void collect_minsize(struct cxl_ctx *ctx, struct parsed_params *p)
 		case CXL_DECODER_MODE_PMEM:
 			size = cxl_memdev_get_pmem_size(memdev);
 			break;
-		case CXL_DECODER_MODE_DYNAMIC_RAM_A:
-			size = cxl_memdev_get_dynamic_ram_a_size(memdev);
+		case CXL_DECODER_MODE_DYNAMIC_RAM_0:
+			size = cxl_memdev_get_dynamic_ram_0_size(memdev);
 			break;
 		default:
 			/* Shouldn't ever get here */ ;
@@ -455,7 +455,7 @@ static int create_region_validate_qos_class(struct parsed_params *p)
 		else if (p->mode == CXL_DECODER_MODE_PMEM)
 			qos_class = cxl_memdev_get_pmem_qos_class(memdev);
 		else
-			qos_class = cxl_memdev_get_dynamic_ram_a_qos_class(memdev);
+			qos_class = cxl_memdev_get_dynamic_ram_0_qos_class(memdev);
 
 		/* No qos_class entries. Possibly no kernel support */
 		if (qos_class == CXL_QOS_CLASS_NONE)
@@ -494,9 +494,9 @@ static int validate_decoder(struct cxl_decoder *decoder,
 			return -EINVAL;
 		}
 		break;
-	case CXL_DECODER_MODE_DYNAMIC_RAM_A:
-		if (!cxl_decoder_is_dynamic_ram_a_capable(decoder)) {
-			log_err(&rl, "%s is not dynamic_ram_a capable\n", devname);
+	case CXL_DECODER_MODE_DYNAMIC_RAM_0:
+		if (!cxl_decoder_is_dynamic_ram_0_capable(decoder)) {
+			log_err(&rl, "%s is not dynamic_ram_0 capable\n", devname);
 			return -EINVAL;
 		}
 		break;
@@ -524,8 +524,8 @@ static void set_type_from_decoder(struct cxl_ctx *ctx, struct parsed_params *p)
 	 * default to pmem if all types are set, otherwise the single
 	 * capability dominates.
 	 */
-	if (cxl_decoder_is_dynamic_ram_a_capable(p->root_decoder))
-		p->mode = CXL_DECODER_MODE_DYNAMIC_RAM_A;
+	if (cxl_decoder_is_dynamic_ram_0_capable(p->root_decoder))
+		p->mode = CXL_DECODER_MODE_DYNAMIC_RAM_0;
 	if (cxl_decoder_is_volatile_capable(p->root_decoder))
 		p->mode = CXL_DECODER_MODE_RAM;
 	if (cxl_decoder_is_pmem_capable(p->root_decoder))
@@ -713,8 +713,8 @@ static int create_region(struct cxl_ctx *ctx, int *count,
 				param.root_decoder);
 			return -ENXIO;
 		}
-	} else if (p->mode == CXL_DECODER_MODE_DYNAMIC_RAM_A) {
-		region = cxl_decoder_create_dynamic_ram_a_region(p->root_decoder);
+	} else if (p->mode == CXL_DECODER_MODE_DYNAMIC_RAM_0) {
+		region = cxl_decoder_create_dynamic_ram_0_region(p->root_decoder);
 		if (!region) {
 			log_err(&rl, "failed to create region under %s\n",
 				param.root_decoder);
diff --git a/test/cxl-dcd.sh b/test/cxl-dcd.sh
index c83d5e4..8557ff9 100644
--- a/test/cxl-dcd.sh
+++ b/test/cxl-dcd.sh
@@ -74,7 +74,7 @@ create_dcd_region()
 	fi
 
 	# create region
-	rc=$($CXL create-region -t dynamic_ram_a -d "$decoder" -m "$mem" ${reg_size_string} | jq -r ".region")
+	rc=$($CXL create-region -t dynamic_ram_0 -d "$decoder" -m "$mem" ${reg_size_string} | jq -r ".region")
 
 	if [[ ! $rc ]]; then
 		echo "create-region failed for $decoder / $mem"
@@ -815,7 +815,7 @@ modprobe cxl_test
 readarray -t memdevs < <("$CXL" list -b cxl_test -Mi | jq -r '.[].memdev')
 
 for mem in ${memdevs[@]}; do
-	dra_size=$($CXL list -m $mem | jq -r '.[].dynamic_ram_a_size')
+	dra_size=$($CXL list -m $mem | jq -r '.[].dynamic_ram_0_size')
 	if [ "$dra_size" == "null" ]; then
 		continue
 	fi
-- 
2.51.0

