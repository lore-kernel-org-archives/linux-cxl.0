Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523591AED5C
	for <linux-cxl@vger.kernel.org>; Mon, 17 Mar 2025 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229823; cv=none; b=Yfm0axOE+xe21vlbaef2+HS3s7jIh004e/4T0F1VfjJ3iw6YtYQw/EYgG/ziDXHPSRX2F8oMHn8RTvg/hQkmPIcslJbAFsPyLRkjiL6rDPJewhHJu4Khc50K3ZlDJ+XqCiXpQIw56JIwaLdgeEdJKeoMn+QqGr4rOENZo7OG7NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229823; c=relaxed/simple;
	bh=SYfm9yPHMYXWaCGEbnaKskamtBl2Yiy8sTKxW+2ECZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyJ0HOMDYOK5/GZ/wxFDC80UVeSwhNR7mKSmdRblCcqHohwrHy0YJTzRZIdvI4ll2e8GKZoO7IAqjjKSm5K7uRBeYkPYM05h65zsVbjav1ZjrHpAfiXpjPDI+QINNdnJaKBdASfIPiOP0+z0Gf3JaQnwhVPKUM/VtWkwpqYE4No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewFhec25; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewFhec25"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22401f4d35aso86762415ad.2
        for <linux-cxl@vger.kernel.org>; Mon, 17 Mar 2025 09:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742229821; x=1742834621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rk6IJKvkiGFyR1sJ6s9cHj4os4KvgEvO+mrUOM2U7lM=;
        b=ewFhec2581lmu+UyRpLHkYuERO6ydwmnqnvq570iGMM0rneqVSI0MaqIQcev0s4749
         wq4qk9gMYZ09EFGHttvwH+nNDibTeZRVRa79CfmlTr90dvD+H9ZKYRWnEYEtO8BBummX
         gYmVBIGcWkMZFK7XJ7l0Vxu9FKnx4Dj8w71NGoofPjZC6NkFdnpcDau+zxADGiD80l1S
         QVXmgmLAsZyiUuNfQUSYFNPeaBmKYlKdV8sTLAECXzB7AokrWjovfY+aw5eMRI1+kEXu
         4bhppI9/YxtffxNzdG9HnbpE2a2o0TXDhj0fkWBNPI0PBA9kUIXKbnJVLKhmLGMu2AWT
         Q1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742229821; x=1742834621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rk6IJKvkiGFyR1sJ6s9cHj4os4KvgEvO+mrUOM2U7lM=;
        b=W52z93dMQY76RYRKctjeEWKL7jCAtanEaT7nRG6w9RyppOv2oIQ3XetaWoxTSfiPdf
         HrzUl2yFg6oDTNwWPFCSU3tjAObQA248PBJr+Rvdc1uh3fVr2u/W8GnjBF9iZ7p5ucGV
         Xjm9diLBkq9c2aN4WRtpob66hXa7W6E8vzRLDHtsNi6BySjpytQm767CCACaI4KGMbJo
         GUiu10S/vxRRacjBT+QdqmyI2/ONFOo+E0SoVGkV7GCAqL/ODIsSs5/jep6ULzDOOAUb
         +a3WlIZbq87EaQvsYyhrav4QydD8EOpWQ4j3VF5aVPGazmNLY0PQca032j+5j3QXFTPu
         ZFQA==
X-Forwarded-Encrypted: i=1; AJvYcCWwKOYzTc0moYyOxfBAeC/9uvPiAq+ZU2EntQE85wD0GuBDc9YT/8GA68MNrBndcRhI37UtbpXsEE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8xAJJj42l5aQHh0RWIKUS5t/LUSqeYClmacFArLC9uAUvAhne
	XuGE5TjnJkDxb9Eg0azJUFi+ZQ52VkTCvI92MfSA2EjpSfTIFJHe
X-Gm-Gg: ASbGncvtwNY7+PhmNs5bEoE/zG44zRWmaHXij8njuQ7E2VupqJFtAHUfo7+PuJKgT12
	S0HaGmwDQehnehAPiurEMTlmLx07akXyviqm/FEnNic7B4UNYpecZ9pa9xXscfPH7AP6/UUkBAC
	HUDIZY3R9ek9k1z3s9lpAYbLJ+zRBR+FWdeSKpdl9d3fy/zg1f1M1hnDQ2khXNsK6XZvWHnxZ7R
	3IfLwBz5gWtjBO4+zeoATJjf7hwRV7X3Vu8c/3UmV7quLj9MnldnijPiNu2hNV/MDel+wtIqnkL
	2yUmwQb5vWx1nSKkFQmxDjPZuIStta82gOuiE05wfS/whLtM/ZN5SxwfDlkaJ+k9ew==
X-Google-Smtp-Source: AGHT+IHJF7qFLM+Pmkm+5K3dO4fVWd4hfqjmxUtHCW9DjeicaQbB8loeNTkjtv4HsY3E1p8uNG/mgg==
X-Received: by 2002:a17:903:19cf:b0:223:3396:15e8 with SMTP id d9443c01a7336-2262c562623mr3466815ad.22.1742229821467;
        Mon, 17 Mar 2025 09:43:41 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6888461sm77810085ad.23.2025.03.17.09.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 09:43:41 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH 3/9] cxl/type3: Add dsmas_flags to CXLDCRegion struct
Date: Mon, 17 Mar 2025 16:31:30 +0000
Message-ID: <20250317164204.2299371-4-anisa.su887@gmail.com>
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

Add dsmas_flags field to DC Region struct in preparation for next
command, which returns the dsmas flags in the response.

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/mem/cxl_type3.c          | 2 ++
 include/hw/cxl/cxl_device.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 731497ebda..452a0c101a 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -237,6 +237,8 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
                                           ct3d->dc.regions[i].len,
                                           false, true, region_base);
             ct3d->dc.regions[i].dsmadhandle = dsmad_handle - 1;
+            CDATDsmas *dsmas = (CDATDsmas *) table[cur_ent + CT3_CDAT_DSMAS];
+            ct3d->dc.regions[i].dsmas_flags = dsmas->flags;
 
             cur_ent += CT3_CDAT_NUM_ENTRIES;
             region_base += ct3d->dc.regions[i].len;
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index bebed04085..81b826f570 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -609,6 +609,7 @@ typedef struct CXLDCRegion {
     uint8_t flags;
     unsigned long *blk_bitmap;
     uint64_t supported_blk_size_bitmask;
+    uint8_t dsmas_flags;
 } CXLDCRegion;
 
 typedef struct CXLSetFeatureInfo {
-- 
2.47.2

