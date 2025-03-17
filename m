Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CB31A2545
	for <linux-cxl@vger.kernel.org>; Mon, 17 Mar 2025 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229842; cv=none; b=fWA8sIBnaemeMz/eaqgKr83YTT9/FzJf3jxCxXqiyDhK9dFKpqdxXmei9pt1eEFbB8OUcQJY7TwAHVFvo+V9SgnYhOsfaY6wM11u41jD2UeIt2a1x76+K0ULXLtIIkcwLLnjNuQmWUJ2IOsrfnksdrkQLofm13MC6X959+6UpDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229842; c=relaxed/simple;
	bh=zn+q4gUpIvaBfymmzZyx8LSOaUM5MO69E6uLNvEcPl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CcRvO/IBV5mseAlvexkHSZ0WZEj1Mxk3qFww6qctw6RW08n9hh/Dx7H1F6WgnodkslLDH/55uTjJYoEczKADJFIQL4le8kfWJDIY+FHAcYHWJuSigdpD5k7oIlWhcGiE/w2c7zglPbZ+ccusCurT2fryTCCurxqvQ0UdGeI4kCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBtFIqlu; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBtFIqlu"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-225a28a511eso76955615ad.1
        for <linux-cxl@vger.kernel.org>; Mon, 17 Mar 2025 09:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742229840; x=1742834640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuObOv7hVkPzGs/EkWPUQYYcsZbgB99BokPUyC+2nNg=;
        b=RBtFIqlu/p8GC8y5wt1yAhF2NVuwlREjTurkUUcWBFKIjAbK7E80bbWSKst2YvRySy
         BSZpzTYA+NddFVhjeJkOY4iCwoeGVrXD0moGwGJYbNQ8JBRBwH5omjvkA1h0idGDDZ7f
         kdalIdpxId0J1gt69DxjmVRmVQuZA8UF5HlNNLYii/stsU2xunzm1OFjxSqUmoD2glEM
         q6TOENZH6dPxr+TlsFxrMfj7mti+bBmQpjqetsWWPLkSDXZD5zjsA7YJkYvR/9TFm5Zt
         UGdeFGrDJj6w6dxYH8rIB5bzxVA6fpLjECnsi/G2VgXD/d1nonfVZTKympqZDARvfmnU
         52LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742229840; x=1742834640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuObOv7hVkPzGs/EkWPUQYYcsZbgB99BokPUyC+2nNg=;
        b=X9gsIhEU08dV1hDY/ZIoO8SbBN3zlO2T58anizegRIKjGWPDpai+swA+LFdas0ZFw6
         EricKggaAmF5UwuGc/r0zzZJbTyHaPxEh6KOfFtSbmgwdgxYEo/YNeSeIjt0blIrrEBG
         8YETYPK+pl2Og1ZQdQE0v/2RQrEC8hgi1QBm4GJfKC84RLU2mMezj5yuS62pwmeytLtN
         okgMiBsJIUHoJp7SRO8Dmrj7q6176neVCidIbLMKhcsZ4PWRlrcydl52TnnC6o9Q/g9L
         f2jqbn+S1X2bgaFiJbuzjPfSHhvKWOimaKzohx3JzinJ2HsPNx1eZfyIUbGXRi2CoIHg
         n6yg==
X-Forwarded-Encrypted: i=1; AJvYcCUvV6cx6jWkXxvcvH5xfvA1Do2S7L/XqACpapEH33nIEG/woITJYqP/DYGO1AijYA2e7NPXrZxpaEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy60k9I/L6XRwYhtot1zfYcWAkg/EvkIHWnCjVK/28zOtqUZmAE
	D0f/bM142gD83N1YkdIp3HIrUn3YW14k9Szuxsj5z5p9crP/VC6u
X-Gm-Gg: ASbGncuSUIyMQvBZhq7NyPW86JNfb6VTbkHIUTVdAvO5SUVlMLfbGfsmBZiT54QUEZr
	Y5d2TaMFr5JE5emhisKdoAg2Pfc7EU42MLnbw9hh1s2OkS6xQul93I9Lwkhnrjz9kG0so8Lp9IG
	iUMuvpQLibMH1GcUfrMLfxZerxHKsihsWxvTMD1ge/RKu4g2f7AaMAw0E/RvUNvxRAmGBhPyiyH
	kcftizzNTCwYydrHhbAbZvaJt1qjWOmwFf+5A9uwW2CAnfgVa2z4TEJORXdQ97jqyalCS4rZWA2
	CjH5oqyWTyRbTIEuruNk54zyqZXtaoRvTSqdRsB3+zLDDml6wTzEUmmyFfzfmlxnVw==
X-Google-Smtp-Source: AGHT+IE9pdhC//ePNgMp9s0EvG5nIUDk60Qus2o8mI6ZGm9DAyJpfV1qoZWjtv30LUTlH7bL6Ce93A==
X-Received: by 2002:a17:902:ea06:b0:223:6657:5001 with SMTP id d9443c01a7336-225e0afb86cmr170861585ad.40.1742229839789;
        Mon, 17 Mar 2025 09:43:59 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6888461sm77810085ad.23.2025.03.17.09.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 09:43:59 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH 5/9] cxl_events.h: move definition for dynamic_capacity_uuid and enum for DC event types
Date: Mon, 17 Mar 2025 16:31:32 +0000
Message-ID: <20250317164204.2299371-6-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317164204.2299371-1-anisa.su887@gmail.com>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anisa Su <anisa.su@samsung.com>

move definition for dynamic_capacity_uuid and enum for DC event types to
cxl_events.h from cxl_type3.c for shared use in next patch

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/mem/cxl_type3.c          | 15 ---------------
 include/hw/cxl/cxl_events.h | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 452a0c101a..ac74e62875 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1977,21 +1977,6 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
     }
 }
 
-/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
-static const QemuUUID dynamic_capacity_uuid = {
-    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
-                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
-};
-
-typedef enum CXLDCEventType {
-    DC_EVENT_ADD_CAPACITY = 0x0,
-    DC_EVENT_RELEASE_CAPACITY = 0x1,
-    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
-    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
-    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
-    DC_EVENT_CAPACITY_RELEASED = 0x5,
-} CXLDCEventType;
-
 /*
  * Check whether the range [dpa, dpa + len - 1] has overlaps with extents in
  * the list.
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 38cadaa0f3..758b075a64 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -184,4 +184,19 @@ typedef struct CXLEventDynamicCapacity {
     uint32_t tags_avail;
 } QEMU_PACKED CXLEventDynamicCapacity;
 
+/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
+static const QemuUUID dynamic_capacity_uuid = {
+    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
+                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
+};
+
+typedef enum CXLDCEventType {
+    DC_EVENT_ADD_CAPACITY = 0x0,
+    DC_EVENT_RELEASE_CAPACITY = 0x1,
+    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
+    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
+    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
+    DC_EVENT_CAPACITY_RELEASED = 0x5,
+} CXLDCEventType;
+
 #endif /* CXL_EVENTS_H */
-- 
2.47.2

