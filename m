Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F01D220F2A
	for <linux-cxl@vger.kernel.org>; Wed,  3 Dec 2025 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796631; cv=none; b=FKCilUd2Z6FnXbTGUxkjqdssIOnioKykBpkdsIWDRD6MniLpLi/17CIo6rE3vTEXGI8i3msZtzOMHiSQjWoQ5WLHZVbe4KJ7AnmrNwU6w1mqQwlP9BEYQpvVoDrftwCj39dzgll6/ueDyn3HvhpNJnkVafJMMkn6CCrSR5SSIQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796631; c=relaxed/simple;
	bh=cktRyj9tMLx3jLUZqEGcTGrR9L/+ooUDEi2oLoYAqSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFSpb15dWcA3Rq5MWzcjFMGQRx9sku4WkYt/cgfaqGHzyMsbSjSU3254rexACkoPgFq595iOdCYXXcxSxCoHF1KA7XaqtnO+ygIIbJJJijXeLV6FuloFTBHxfULc0Jm6hJULV44ZrVqtLnT6i6r2SRnkl1CNTPJM36nlA6IRewQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHYImUn+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHYImUn+"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-297e264528aso2260655ad.2
        for <linux-cxl@vger.kernel.org>; Wed, 03 Dec 2025 13:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764796628; x=1765401428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyqYiViGBmBBqqjCF8CTtBvGJuq6aa1LlSKueu/0iz8=;
        b=LHYImUn+UXodIoZzr6LuKRxK8N07DFg2S7CWFpTd8IZfdH+9sS9YPvCLev6b+eqwwe
         nSKGwl7LHN9hMpilnkGWw+agR5YYPhL1SGyQapa4D5/46Obl59PYIIc1ezofMOPA+ppK
         0XAy8ObzNJhHAhDnjhEAzX9ezmjWXAACHnlyKc6DTNclzFi7hX4BeV+WhjuMYJvgSC8f
         Au8kxqEJtumB4w2T8Yj4Yr0EX3DF7Ojaz6+ykfTzpjXN0XHpK7W1BhL96EvS0bCnFk1q
         NUx9MktYK/ONDbnQsUhY4UHMk9BcbWyV7veCr9YKP0Ef8vAsk5CV63ElMBrZWCnOPpqy
         j2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764796628; x=1765401428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HyqYiViGBmBBqqjCF8CTtBvGJuq6aa1LlSKueu/0iz8=;
        b=PWBf5VK4D8LtCU8Rdp9fVeIqtGhPnTdvJjtWsRGJHO3SlXEpRZSPWkQhb+8KQ1JN/d
         BKGHghh+GGJ7SmCBH/PZQoo0koPEVmsZTbgEB+kkjvFGc8vV6GlzyPs6XYIBh6mnm3BT
         FsWQt//XDM3ecT3pBarq18nznpcHyjLW5+qxys8TItM+SIz0IMRKnyoRh6JVlAr1NTaA
         SWNg81qEaDwvEMkwR8U+HDcLB0ReW5QUcrtv+PeHjkn4W9t2HWAXMXRMR+k53Gv46AsY
         qddEZ46tKmEyejoPUmRmcFHK5JKeB+4eH3OhZQo+rYy+yTtOO1Jzs41cigqZX41jgFKo
         KCqA==
X-Gm-Message-State: AOJu0YzegtMPqjb1tNLCZI8Ss4CvW9r6cKxDOYGVcsNS0ShkpDneQblH
	acoCqdNeHKed4Ha+gPqay3S4ZQIICXkzIrhdPBnJOUgXYeaJANU7MZurzrqvkA==
X-Gm-Gg: ASbGnctcI75cXeVDTOZec9ZypbAPlWNRce3rLa75nJB5jRd7Nwb3AolEjUZfttWCyKQ
	0x1NkRkVCzDUBqGsGNfy6EHrhMsKbtdEwGjQVExbV2bTJhobW73K63PIMIZwEzMnHo4NzDk1w0m
	x760VyhXp6wGAE/JtJPIkjKJuRL/Vhef6UjYP85BDCztWQqu6Frw5Wm4E13/MwHBSLJYKRfljAZ
	+L9jJPjO/7qYc8FxUDBWW6FLh0ePhRQU1vK00uT5CbCEpke99GcY1noZso7gi4gL61BtSqwWrBf
	ss5kz4DkHfQ+jpZiO07pTYzb+NmvDHfGXPXHVsWJntBNPBhL+pJUHmzpLLwxLMJf9lfDq/k+qqH
	pL9tCV6o5kS6UmwOKKtOSj7gYuKFWBbT1FIaf/9KSkOMsgYdMPSVduHgw24/180OkXYmJmgCAzM
	JyoPlfJM6T2S2/bvF8Q0WlCoyv+/sa76vF
X-Google-Smtp-Source: AGHT+IH/Q07TnR2UTwUpHLPBRVsoOtl8uxpQiLzDGgjqV9pZVT4O0Dn6sWvsyfd56QKOy/V+I7StCw==
X-Received: by 2002:a05:7300:6429:b0:2a4:3592:c5f3 with SMTP id 5a478bee46e88-2aba4233affmr590055eec.4.1764796628076;
        Wed, 03 Dec 2025 13:17:08 -0800 (PST)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a9653ca11esm67419981eec.0.2025.12.03.13.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 13:17:07 -0800 (PST)
From: anisa.su887@gmail.com
To: linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com,
	nifan.cxl@gmail.com,
	dongjoo.seo1@samsung.com,
	dave@stgolabs.net,
	Anisa Su <anisa.su@samsung.com>
Subject: [RFC NDCTL PATCH 2/2] cxl: extend DCD related features to support up to 8 regions
Date: Wed,  3 Dec 2025 21:15:25 +0000
Message-ID: <20251203211642.1104918-3-anisa.su887@gmail.com>
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

Signed-off-by: Fan Ni <nifan.cxl@gmail.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Tested-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
---
 Documentation/cxl/lib/libcxl.txt |  7 +++
 cxl/json.c                       | 46 +++++++++++------
 cxl/lib/libcxl.c                 | 84 +++++++++++++++++++++-----------
 cxl/lib/libcxl.sym               |  9 ++--
 cxl/lib/private.h                |  6 +--
 cxl/libcxl.h                     | 40 +++++++++++++--
 cxl/memdev.c                     |  3 +-
 cxl/region.c                     | 25 ++++++----
 8 files changed, 154 insertions(+), 66 deletions(-)

diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
index 0fd857f..1b84bfa 100644
--- a/Documentation/cxl/lib/libcxl.txt
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -424,6 +424,13 @@ enum cxl_decoder_mode {
 	CXL_DECODER_MODE_PMEM,
 	CXL_DECODER_MODE_RAM,
 	CXL_DECODER_MODE_DYNAMIC_RAM_0,
+	CXL_DECODER_MODE_DYNAMIC_RAM_1,
+	CXL_DECODER_MODE_DYNAMIC_RAM_2,
+	CXL_DECODER_MODE_DYNAMIC_RAM_3,
+	CXL_DECODER_MODE_DYNAMIC_RAM_4,
+	CXL_DECODER_MODE_DYNAMIC_RAM_5,
+	CXL_DECODER_MODE_DYNAMIC_RAM_6,
+	CXL_DECODER_MODE_DYNAMIC_RAM_7,
 };
 enum cxl_decoder_mode cxl_decoder_get_mode(struct cxl_decoder *decoder);
 int cxl_decoder_set_mode(struct cxl_decoder *decoder, enum cxl_decoder_mode mode);
diff --git a/cxl/json.c b/cxl/json.c
index 512572d..a8098ba 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -800,17 +800,26 @@ struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
 		}
 	}
 
-	size = cxl_memdev_get_dynamic_ram_0_size(memdev);
-	if (size) {
-		jobj = util_json_object_size(size, flags);
-		if (jobj)
-			json_object_object_add(jdev, "dynamic_ram_0_size", jobj);
+	for (int i = 0; i < 8; i++) {
+		size = cxl_memdev_get_dynamic_ram_size(memdev, i);
+		if (size) {
+			char name[32];
 
-		qos_class = cxl_memdev_get_dynamic_ram_0_qos_class(memdev);
-		if (qos_class != CXL_QOS_CLASS_NONE) {
-			jobj = json_object_new_int(qos_class);
-			if (jobj)
-				json_object_object_add(jdev, "dynamic_ram_0_qos_class", jobj);
+			memset(name, 0, 32);
+			jobj = util_json_object_size(size, flags);
+			if (jobj) {
+				sprintf(name, "%s_size", cxl_decoder_mode_name(CXL_DECODER_MODE_DYNAMIC_RAM_0 + i));
+				json_object_object_add(jdev, name, jobj);
+			}
+
+			qos_class = cxl_memdev_get_dynamic_ram_qos_class(memdev, i);
+			if (qos_class != CXL_QOS_CLASS_NONE) {
+				jobj = json_object_new_int(qos_class);
+				if (jobj) {
+					sprintf(name, "%s_qos_class", cxl_decoder_mode_name(CXL_DECODER_MODE_DYNAMIC_RAM_0 + i));
+					json_object_object_add(jdev, name, jobj);
+				}
+			}
 		}
 	}
 
@@ -1073,11 +1082,18 @@ struct json_object *util_cxl_decoder_to_json(struct cxl_decoder *decoder,
 				json_object_object_add(
 					jdecoder, "volatile_capable", jobj);
 		}
-		if (cxl_decoder_is_dynamic_ram_0_capable(decoder)) {
-			jobj = json_object_new_boolean(true);
-			if (jobj)
-				json_object_object_add(
-					jdecoder, "dynamic_ram_0_capable", jobj);
+		for (int i = 0; i < 8; i++) {
+			if (cxl_decoder_is_dynamic_ram_capable(decoder, i)) {
+				char name[32];
+				jobj = json_object_new_boolean(true);
+				if (jobj) {
+					memset(name, 0, 32);
+					sprintf(name, "%s_capable",
+	     cxl_decoder_mode_name(CXL_DECODER_MODE_DYNAMIC_RAM_0 + i));
+					json_object_object_add(
+						jdecoder, name, jobj);
+				}
+			}
 		}
 	}
 
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 59a349b..a5e5e6d 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -414,6 +414,12 @@ CXL_EXPORT int cxl_region_is_enabled(struct cxl_region *region)
 	return is_enabled(path);
 }
 
+CXL_EXPORT bool cxl_decoder_is_dc_mode(enum cxl_decoder_mode mode)
+{
+	return CXL_DECODER_MODE_DYNAMIC_RAM_0 <= mode &&
+	mode <= CXL_DECODER_MODE_DYNAMIC_RAM_7;
+}
+
 CXL_EXPORT bool cxl_region_qos_class_mismatch(struct cxl_region *region)
 {
 	struct cxl_decoder *root_decoder = cxl_region_get_decoder(region);
@@ -437,8 +443,8 @@ CXL_EXPORT bool cxl_region_qos_class_mismatch(struct cxl_region *region)
 		} else if (region->mode == CXL_DECODER_MODE_PMEM) {
 			if (root_decoder->qos_class != memdev->pmem_qos_class)
 				return true;
-		} else if (region->mode == CXL_DECODER_MODE_DYNAMIC_RAM_0) {
-			if (root_decoder->qos_class != memdev->dynamic_ram_0_qos_class)
+		} else if (cxl_decoder_is_dc_mode(region->mode)) {
+			if (root_decoder->qos_class != memdev->dynamic_ram_qos_classes[region->mode - CXL_DECODER_MODE_DYNAMIC_RAM_0])
 				return true;
 		}
 	}
@@ -1492,9 +1498,12 @@ static void *add_cxl_memdev(void *parent, int id, const char *cxlmem_base)
 	if (sysfs_read_attr(ctx, path, buf) == 0)
 		memdev->ram_size = strtoull(buf, NULL, 0);
 
-	sprintf(path, "%s/dynamic_ram_0/size", cxlmem_base);
-	if (sysfs_read_attr(ctx, path, buf) == 0)
-		memdev->dynamic_ram_0_size = strtoull(buf, NULL, 0);
+	for (int i = 0; i < 8; i++) {
+		const char *name = cxl_decoder_mode_name(CXL_DECODER_MODE_DYNAMIC_RAM_0 + i);
+		sprintf(path, "%s/%s/size", cxlmem_base, name);
+		if (sysfs_read_attr(ctx, path, buf) == 0)
+			memdev->dynamic_ram_sizes[i] = strtoull(buf, NULL, 0);
+	}
 
 	sprintf(path, "%s/pmem/qos_class", cxlmem_base);
 	if (sysfs_read_attr(ctx, path, buf) < 0)
@@ -1508,11 +1517,14 @@ static void *add_cxl_memdev(void *parent, int id, const char *cxlmem_base)
 	else
 		memdev->ram_qos_class = atoi(buf);
 
-	sprintf(path, "%s/dynamic_ram_0/qos_class", cxlmem_base);
-	if (sysfs_read_attr(ctx, path, buf) < 0)
-		memdev->dynamic_ram_0_qos_class = CXL_QOS_CLASS_NONE;
-	else
-		memdev->dynamic_ram_0_qos_class = atoi(buf);
+	for (int i = 0; i < 8; i++) {
+		const char *name = cxl_decoder_mode_name(CXL_DECODER_MODE_DYNAMIC_RAM_0 + i);
+		sprintf(path, "%s/%s/qos_class", cxlmem_base, name);
+		if (sysfs_read_attr(ctx, path, buf) < 0)
+			memdev->dynamic_ram_qos_classes[i] = CXL_QOS_CLASS_NONE;
+		else
+			memdev->dynamic_ram_qos_classes[i] = atoi(buf);
+	}
 
 	sprintf(path, "%s/payload_max", cxlmem_base);
 	if (sysfs_read_attr(ctx, path, buf) == 0) {
@@ -1750,9 +1762,10 @@ CXL_EXPORT unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev)
 	return memdev->ram_size;
 }
 
-CXL_EXPORT unsigned long long cxl_memdev_get_dynamic_ram_0_size(struct cxl_memdev *memdev)
+CXL_EXPORT unsigned long long cxl_memdev_get_dynamic_ram_size(struct cxl_memdev *memdev,
+								int n)
 {
-	return memdev->dynamic_ram_0_size;
+	return memdev->dynamic_ram_sizes[n];
 }
 
 CXL_EXPORT int cxl_memdev_get_pmem_qos_class(struct cxl_memdev *memdev)
@@ -1765,9 +1778,9 @@ CXL_EXPORT int cxl_memdev_get_ram_qos_class(struct cxl_memdev *memdev)
 	return memdev->ram_qos_class;
 }
 
-CXL_EXPORT int cxl_memdev_get_dynamic_ram_0_qos_class(struct cxl_memdev *memdev)
+CXL_EXPORT int cxl_memdev_get_dynamic_ram_qos_class(struct cxl_memdev *memdev, int n)
 {
-	return memdev->dynamic_ram_0_qos_class;
+	return memdev->dynamic_ram_qos_classes[n];
 }
 
 CXL_EXPORT const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev)
@@ -2509,10 +2522,11 @@ static void *add_cxl_decoder(void *parent, int id, const char *cxldecoder_base)
 			decoder->mode = CXL_DECODER_MODE_MIXED;
 		else if (strcmp(buf, "none") == 0)
 			decoder->mode = CXL_DECODER_MODE_NONE;
-		else if (strcmp(buf, "dynamic_ram_0") == 0)
-			decoder->mode = CXL_DECODER_MODE_DYNAMIC_RAM_0;
-		else
-			decoder->mode = CXL_DECODER_MODE_MIXED;
+		else {
+			decoder->mode = cxl_decoder_mode_from_ident(buf);
+			if (decoder->mode == CXL_DECODER_MODE_NONE)
+				decoder->mode = CXL_DECODER_MODE_MIXED;
+		}
 	} else
 		decoder->mode = CXL_DECODER_MODE_NONE;
 
@@ -2550,7 +2564,8 @@ static void *add_cxl_decoder(void *parent, int id, const char *cxldecoder_base)
 	case CXL_PORT_SWITCH:
 		decoder->pmem_capable = true;
 		decoder->volatile_capable = true;
-		decoder->dynamic_ram_0_capable = true;
+		for (i = 0; i < 8; i++)
+			decoder->dynamic_ram_capable[i] = true;
 		decoder->mem_capable = true;
 		decoder->accelmem_capable = true;
 		sprintf(path, "%s/locked", cxldecoder_base);
@@ -2575,7 +2590,14 @@ static void *add_cxl_decoder(void *parent, int id, const char *cxldecoder_base)
 			{ "cap_type3", &decoder->mem_capable },
 			{ "cap_ram", &decoder->volatile_capable },
 			{ "cap_pmem", &decoder->pmem_capable },
-			{ "cap_dynamic_ram_0", &decoder->dynamic_ram_0_capable },
+			{ "cap_dynamic_ram_0", &decoder->dynamic_ram_capable[0] },
+			{ "cap_dynamic_ram_1", &decoder->dynamic_ram_capable[1] },
+			{ "cap_dynamic_ram_2", &decoder->dynamic_ram_capable[2] },
+			{ "cap_dynamic_ram_3", &decoder->dynamic_ram_capable[3] },
+			{ "cap_dynamic_ram_4", &decoder->dynamic_ram_capable[4] },
+			{ "cap_dynamic_ram_5", &decoder->dynamic_ram_capable[5] },
+			{ "cap_dynamic_ram_6", &decoder->dynamic_ram_capable[6] },
+			{ "cap_dynamic_ram_7", &decoder->dynamic_ram_capable[7] },
 			{ "locked", &decoder->locked },
 		};
 
@@ -2826,8 +2848,8 @@ CXL_EXPORT int cxl_decoder_set_mode(struct cxl_decoder *decoder,
 	case CXL_DECODER_MODE_RAM:
 		sprintf(buf, "ram");
 		break;
-	case CXL_DECODER_MODE_DYNAMIC_RAM_0:
-		sprintf(buf, "dynamic_ram_0");
+	case CXL_DECODER_MODE_DYNAMIC_RAM_0...CXL_DECODER_MODE_DYNAMIC_RAM_7:
+		sprintf(buf, "%s", cxl_decoder_mode_name(mode));
 		break;
 	default:
 		err(ctx, "%s: unsupported mode: %d\n",
@@ -2880,9 +2902,14 @@ CXL_EXPORT bool cxl_decoder_is_volatile_capable(struct cxl_decoder *decoder)
 	return decoder->volatile_capable;
 }
 
-CXL_EXPORT bool cxl_decoder_is_dynamic_ram_0_capable(struct cxl_decoder *decoder)
+CXL_EXPORT bool cxl_decoder_is_dynamic_ram_capable(struct cxl_decoder *decoder, int n)
 {
-	return decoder->dynamic_ram_0_capable;
+	switch (n) {
+	case 0 ... 7:
+		return decoder->dynamic_ram_capable[n];
+	default:
+		return false;
+	}
 }
 
 CXL_EXPORT bool cxl_decoder_is_mem_capable(struct cxl_decoder *decoder)
@@ -2959,8 +2986,9 @@ static struct cxl_region *cxl_decoder_create_region(struct cxl_decoder *decoder,
 		sprintf(path, "%s/create_pmem_region", decoder->dev_path);
 	else if (mode == CXL_DECODER_MODE_RAM)
 		sprintf(path, "%s/create_ram_region", decoder->dev_path);
-	else if (mode == CXL_DECODER_MODE_DYNAMIC_RAM_0)
-		sprintf(path, "%s/create_dynamic_ram_0_region", decoder->dev_path);
+	else if (cxl_decoder_is_dc_mode(mode))
+		sprintf(path, "%s/create_dynamic_ram_%d_region", decoder->dev_path,
+		mode - CXL_DECODER_MODE_DYNAMIC_RAM_0);
 
 	rc = sysfs_read_attr(ctx, path, buf);
 	if (rc < 0) {
@@ -3013,9 +3041,9 @@ cxl_decoder_create_ram_region(struct cxl_decoder *decoder)
 }
 
 CXL_EXPORT struct cxl_region *
-cxl_decoder_create_dynamic_ram_0_region(struct cxl_decoder *decoder)
+cxl_decoder_create_dynamic_ram_region(struct cxl_decoder *decoder, enum cxl_decoder_mode mode)
 {
-	return cxl_decoder_create_region(decoder, CXL_DECODER_MODE_DYNAMIC_RAM_0);
+	return cxl_decoder_create_region(decoder, mode);
 }
 
 CXL_EXPORT int cxl_decoder_get_nr_targets(struct cxl_decoder *decoder)
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 2fc9961..2af680a 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -293,10 +293,11 @@ global:
 	cxl_bus_get_by_provider;
 	cxl_memdev_get_fwctl_major;
 	cxl_memdev_get_fwctl_minor;
-	cxl_memdev_get_dynamic_ram_0_size;
-	cxl_memdev_get_dynamic_ram_0_qos_class;
-	cxl_decoder_is_dynamic_ram_0_capable;
-	cxl_decoder_create_dynamic_ram_0_region;
+	cxl_memdev_get_dynamic_ram_size;
+	cxl_memdev_get_dynamic_ram_qos_class;
+	cxl_decoder_is_dynamic_ram_capable;
+	cxl_decoder_create_dynamic_ram_region;
+	cxl_decoder_is_dc_mode;
 	cxl_extent_get_first;
 	cxl_extent_get_next;
 	cxl_extent_get_offset;
diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index 436dbcc..9675ed4 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -48,10 +48,10 @@ struct cxl_memdev {
 	struct list_node list;
 	unsigned long long pmem_size;
 	unsigned long long ram_size;
-	unsigned long long dynamic_ram_0_size;
+	unsigned long long dynamic_ram_sizes[8];
 	int ram_qos_class;
 	int pmem_qos_class;
-	int dynamic_ram_0_qos_class;
+	int dynamic_ram_qos_classes[8];
 	int payload_max;
 	size_t lsa_size;
 	struct kmod_module *module;
@@ -142,7 +142,7 @@ struct cxl_decoder {
 	unsigned int interleave_granularity;
 	bool pmem_capable;
 	bool volatile_capable;
-	bool dynamic_ram_0_capable;
+	bool dynamic_ram_capable[8];
 	bool mem_capable;
 	bool accelmem_capable;
 	bool locked;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index feb36d2..a38a943 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -74,10 +74,10 @@ int cxl_memdev_get_fwctl_minor(struct cxl_memdev *memdev);
 struct cxl_ctx *cxl_memdev_get_ctx(struct cxl_memdev *memdev);
 unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memdev);
 unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev);
-unsigned long long cxl_memdev_get_dynamic_ram_0_size(struct cxl_memdev *memdev);
+unsigned long long cxl_memdev_get_dynamic_ram_size(struct cxl_memdev *memdev, int n);
 int cxl_memdev_get_pmem_qos_class(struct cxl_memdev *memdev);
 int cxl_memdev_get_ram_qos_class(struct cxl_memdev *memdev);
-int cxl_memdev_get_dynamic_ram_0_qos_class(struct cxl_memdev *memdev);
+int cxl_memdev_get_dynamic_ram_qos_class(struct cxl_memdev *memdev, int n);
 const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev);
 bool cxl_memdev_fw_update_in_progress(struct cxl_memdev *memdev);
 size_t cxl_memdev_fw_update_get_remaining(struct cxl_memdev *memdev);
@@ -203,6 +203,13 @@ enum cxl_decoder_mode {
 	CXL_DECODER_MODE_PMEM,
 	CXL_DECODER_MODE_RAM,
 	CXL_DECODER_MODE_DYNAMIC_RAM_0,
+	CXL_DECODER_MODE_DYNAMIC_RAM_1,
+	CXL_DECODER_MODE_DYNAMIC_RAM_2,
+	CXL_DECODER_MODE_DYNAMIC_RAM_3,
+	CXL_DECODER_MODE_DYNAMIC_RAM_4,
+	CXL_DECODER_MODE_DYNAMIC_RAM_5,
+	CXL_DECODER_MODE_DYNAMIC_RAM_6,
+	CXL_DECODER_MODE_DYNAMIC_RAM_7,
 };
 
 static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
@@ -213,9 +220,16 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
 		[CXL_DECODER_MODE_PMEM] = "pmem",
 		[CXL_DECODER_MODE_RAM] = "ram",
 		[CXL_DECODER_MODE_DYNAMIC_RAM_0] = "dynamic_ram_0",
+		[CXL_DECODER_MODE_DYNAMIC_RAM_1] = "dynamic_ram_1",
+		[CXL_DECODER_MODE_DYNAMIC_RAM_2] = "dynamic_ram_2",
+		[CXL_DECODER_MODE_DYNAMIC_RAM_3] = "dynamic_ram_3",
+		[CXL_DECODER_MODE_DYNAMIC_RAM_4] = "dynamic_ram_4",
+		[CXL_DECODER_MODE_DYNAMIC_RAM_5] = "dynamic_ram_5",
+		[CXL_DECODER_MODE_DYNAMIC_RAM_6] = "dynamic_ram_6",
+		[CXL_DECODER_MODE_DYNAMIC_RAM_7] = "dynamic_ram_7",
 	};
 
-	if (mode < CXL_DECODER_MODE_NONE || mode > CXL_DECODER_MODE_DYNAMIC_RAM_0)
+	if (mode < CXL_DECODER_MODE_NONE || mode > CXL_DECODER_MODE_DYNAMIC_RAM_7)
 		mode = CXL_DECODER_MODE_NONE;
 	return names[mode];
 }
@@ -231,6 +245,20 @@ cxl_decoder_mode_from_ident(const char *ident)
 		return CXL_DECODER_MODE_PMEM;
 	else if (strcmp(ident, "dynamic_ram_0") == 0)
 		return CXL_DECODER_MODE_DYNAMIC_RAM_0;
+	else if (strcmp(ident, "dynamic_ram_1") == 0)
+		return CXL_DECODER_MODE_DYNAMIC_RAM_1;
+	else if (strcmp(ident, "dynamic_ram_2") == 0)
+		return CXL_DECODER_MODE_DYNAMIC_RAM_2;
+	else if (strcmp(ident, "dynamic_ram_3") == 0)
+		return CXL_DECODER_MODE_DYNAMIC_RAM_3;
+	else if (strcmp(ident, "dynamic_ram_4") == 0)
+		return CXL_DECODER_MODE_DYNAMIC_RAM_4;
+	else if (strcmp(ident, "dynamic_ram_5") == 0)
+		return CXL_DECODER_MODE_DYNAMIC_RAM_5;
+	else if (strcmp(ident, "dynamic_ram_6") == 0)
+		return CXL_DECODER_MODE_DYNAMIC_RAM_6;
+	else if (strcmp(ident, "dynamic_ram_7") == 0)
+		return CXL_DECODER_MODE_DYNAMIC_RAM_7;
 	return CXL_DECODER_MODE_NONE;
 }
 
@@ -260,7 +288,7 @@ cxl_decoder_get_target_type(struct cxl_decoder *decoder);
 bool cxl_decoder_is_pmem_capable(struct cxl_decoder *decoder);
 bool cxl_decoder_is_volatile_capable(struct cxl_decoder *decoder);
 bool cxl_decoder_is_mem_capable(struct cxl_decoder *decoder);
-bool cxl_decoder_is_dynamic_ram_0_capable(struct cxl_decoder *decoder);
+bool cxl_decoder_is_dynamic_ram_capable(struct cxl_decoder *decoder, int n);
 bool cxl_decoder_is_accelmem_capable(struct cxl_decoder *decoder);
 bool cxl_decoder_is_locked(struct cxl_decoder *decoder);
 unsigned int
@@ -269,7 +297,8 @@ unsigned int cxl_decoder_get_interleave_ways(struct cxl_decoder *decoder);
 struct cxl_region *cxl_decoder_get_region(struct cxl_decoder *decoder);
 struct cxl_region *cxl_decoder_create_pmem_region(struct cxl_decoder *decoder);
 struct cxl_region *cxl_decoder_create_ram_region(struct cxl_decoder *decoder);
-struct cxl_region *cxl_decoder_create_dynamic_ram_0_region(struct cxl_decoder *decoder);
+struct cxl_region *cxl_decoder_create_dynamic_ram_region(struct cxl_decoder *decoder,
+							   enum cxl_decoder_mode mode);
 struct cxl_decoder *cxl_decoder_get_by_name(struct cxl_ctx *ctx,
 					    const char *ident);
 struct cxl_memdev *cxl_decoder_get_memdev(struct cxl_decoder *decoder);
@@ -349,6 +378,7 @@ int cxl_region_clear_all_targets(struct cxl_region *region);
 int cxl_region_decode_commit(struct cxl_region *region);
 int cxl_region_decode_reset(struct cxl_region *region);
 bool cxl_region_qos_class_mismatch(struct cxl_region *region);
+bool cxl_decoder_is_dc_mode(enum cxl_decoder_mode mode);
 
 #define cxl_region_foreach(decoder, region)                                    \
 	for (region = cxl_region_get_first(decoder); region != NULL;           \
diff --git a/cxl/memdev.c b/cxl/memdev.c
index 33e2bf9..cac6af3 100644
--- a/cxl/memdev.c
+++ b/cxl/memdev.c
@@ -272,7 +272,8 @@ static int __reserve_dpa(struct cxl_memdev *memdev,
 	else if (mode == CXL_DECODER_MODE_PMEM)
 		avail_dpa = cxl_memdev_get_pmem_size(memdev);
 	else
-		avail_dpa = cxl_memdev_get_dynamic_ram_0_size(memdev);
+		avail_dpa = cxl_memdev_get_dynamic_ram_size(memdev,
+						mode - CXL_DECODER_MODE_DYNAMIC_RAM_0);
 
 	cxl_decoder_foreach(port, decoder) {
 		size = cxl_decoder_get_dpa_size(decoder);
diff --git a/cxl/region.c b/cxl/region.c
index 005aca4..e9889db 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -304,7 +304,7 @@ static int parse_create_options(struct cxl_ctx *ctx, int count,
 	if (param.type) {
 		p->mode = cxl_decoder_mode_from_ident(param.type);
 		if ((p->mode == CXL_DECODER_MODE_RAM ||
-		     p->mode == CXL_DECODER_MODE_DYNAMIC_RAM_0) && param.uuid) {
+		     cxl_decoder_is_dc_mode(p->mode)) && param.uuid) {
 			log_err(&rl,
 				"can't set UUID for ram / volatile regions");
 			goto err;
@@ -419,7 +419,8 @@ static void collect_minsize(struct cxl_ctx *ctx, struct parsed_params *p)
 			size = cxl_memdev_get_pmem_size(memdev);
 			break;
 		case CXL_DECODER_MODE_DYNAMIC_RAM_0:
-			size = cxl_memdev_get_dynamic_ram_0_size(memdev);
+			size = cxl_memdev_get_dynamic_ram_size(memdev,
+					    p->mode - CXL_DECODER_MODE_DYNAMIC_RAM_0);
 			break;
 		default:
 			/* Shouldn't ever get here */ ;
@@ -455,7 +456,8 @@ static int create_region_validate_qos_class(struct parsed_params *p)
 		else if (p->mode == CXL_DECODER_MODE_PMEM)
 			qos_class = cxl_memdev_get_pmem_qos_class(memdev);
 		else
-			qos_class = cxl_memdev_get_dynamic_ram_0_qos_class(memdev);
+			qos_class = cxl_memdev_get_dynamic_ram_qos_class(memdev,
+						    p->mode - CXL_DECODER_MODE_DYNAMIC_RAM_0);
 
 		/* No qos_class entries. Possibly no kernel support */
 		if (qos_class == CXL_QOS_CLASS_NONE)
@@ -494,9 +496,10 @@ static int validate_decoder(struct cxl_decoder *decoder,
 			return -EINVAL;
 		}
 		break;
-	case CXL_DECODER_MODE_DYNAMIC_RAM_0:
-		if (!cxl_decoder_is_dynamic_ram_0_capable(decoder)) {
-			log_err(&rl, "%s is not dynamic_ram_0 capable\n", devname);
+	case CXL_DECODER_MODE_DYNAMIC_RAM_0...CXL_DECODER_MODE_DYNAMIC_RAM_7:
+		if (!cxl_decoder_is_dynamic_ram_capable(decoder, p->mode - CXL_DECODER_MODE_DYNAMIC_RAM_0)) {
+			log_err(&rl, "%s is not dynamic_ram_%d capable\n",
+	   devname, p->mode - CXL_DECODER_MODE_DYNAMIC_RAM_0);
 			return -EINVAL;
 		}
 		break;
@@ -524,8 +527,10 @@ static void set_type_from_decoder(struct cxl_ctx *ctx, struct parsed_params *p)
 	 * default to pmem if all types are set, otherwise the single
 	 * capability dominates.
 	 */
-	if (cxl_decoder_is_dynamic_ram_0_capable(p->root_decoder))
-		p->mode = CXL_DECODER_MODE_DYNAMIC_RAM_0;
+	for (int i = 0; i < 8; i++) {
+		if (cxl_decoder_is_dynamic_ram_capable(p->root_decoder, i))
+			p->mode = CXL_DECODER_MODE_DYNAMIC_RAM_0 + i;
+		}
 	if (cxl_decoder_is_volatile_capable(p->root_decoder))
 		p->mode = CXL_DECODER_MODE_RAM;
 	if (cxl_decoder_is_pmem_capable(p->root_decoder))
@@ -713,8 +718,8 @@ static int create_region(struct cxl_ctx *ctx, int *count,
 				param.root_decoder);
 			return -ENXIO;
 		}
-	} else if (p->mode == CXL_DECODER_MODE_DYNAMIC_RAM_0) {
-		region = cxl_decoder_create_dynamic_ram_0_region(p->root_decoder);
+	} else if (cxl_decoder_is_dc_mode(p->mode)) {
+		region = cxl_decoder_create_dynamic_ram_region(p->root_decoder, p->mode);
 		if (!region) {
 			log_err(&rl, "failed to create region under %s\n",
 				param.root_decoder);
-- 
2.51.0

