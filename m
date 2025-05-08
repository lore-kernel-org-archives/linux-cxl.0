Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5EE6F2F2
	for <linux-cxl@vger.kernel.org>; Thu,  8 May 2025 00:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746663529; cv=none; b=PAMP41Bm6ul7idqrYLGR0aMUVvX2cD6ZaHlj3TCl2xRpggTvj1F4XSCNEgahWhHxdr2eHFH4yAxGx9ThH1RQTczS48xwEqC7S43KJvcbdgDi8Ka+TU+XGSzCAKWMw5FzobCCml1FVR398jB7HiHG1Iaxv3M3AQybk9CF+EBEIa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746663529; c=relaxed/simple;
	bh=x+ndyTagtAai+1IoUWFFOHzaqjA94A8NPH361YUDtL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=paRpax14ZWzGRXdfJ4GdcjXi2R7dH8FoLb0RU7lWTlySoNxvu9IeVPC7vyOofeDD6X4VK4xGG8MXas/ViJp3SDWUDAQIiJ8ewaC6hRxT3VmR1hts0UJO4Oih6yqaw2It+rSa3aZM6bZlPHx3vth2rEco7ptFMs08pyCFMYY1610=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhtr41Ir; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhtr41Ir"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7396f13b750so535689b3a.1
        for <linux-cxl@vger.kernel.org>; Wed, 07 May 2025 17:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746663527; x=1747268327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhgvxGbjckjA2uvUuUKgLB6cM0wWCDZ0qCaH290UVI8=;
        b=nhtr41IrRjvg/FxC/R7dPmZAVrZBxCJru+VHwXOhr6Tmkog6Px4uyyMISuaAmq8ZjD
         lmVKgw4BRLk7XzaqNqNOoScTcwfZ3HnfXtpc0MxmVtMRR/KBM7ms1Bsa1uVrCMaRWiGX
         FLP5oE+R+7MDMY3svc6kEIQqI/u5RwZFL7KUIivQkGD0ZN7wCsobmEuOXgqWy1PPFWED
         4xgXWp0VQQZXuTV3je8RMvenoM5UU5z3P6aohqSYH1wgQ8sJkhObYE0KP8yRk7S+LyM3
         zdFkoQcsISfjhtYpI5OdfaItC9RkADTqXXJVyYPrYXfY9gdR0z+4w0Ajn/+fa4/cfXHa
         mDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746663527; x=1747268327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhgvxGbjckjA2uvUuUKgLB6cM0wWCDZ0qCaH290UVI8=;
        b=tnnq0y2nEvSL5Qix+bZ56lS7K9EhjJRNRDycA9NyUHIPTCnMbjoPr5ZUNllHh5e7da
         cb07fx80n9Xn7FHF+e69YmURbA6dBhvMU09ZsIzLzwZ3mNZ87SqRblv2pDpzQ8sGswLM
         qFFYsoRhyYBBgGEUQDjQyo/sKQ/jP8QOBfyhgBt8oNK9qt1p3OXXrfu+4o1DDOQ/rGRH
         Is88Crieze6ZuGQhhDDwCfZuXy1p6cA0b3OmymjeTpNeyq3itZi+1/cV4ZJecuSSS/cX
         hNVgHkOAxtdo0EB+o/Ie4J2yJqr+WGxFIY6e1bnmnIVBhV8fn9n98UgGB1KKPLXeTOm4
         gWUw==
X-Forwarded-Encrypted: i=1; AJvYcCVD/h0bEScUONAXmCRnLjJZseaLjDg9bCdQw8ro13+wUe5MmA+wME8qT9IXh51YiNIWE/Sa0nZWsyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpkKiEGzx5YOXRe/fPTHf5Zt346ncYuxM++a4F0Nw+XDI+qbOd
	LG6P12ZMCLZqZz/3ilCcX4JOtyIcxo11YTIkTkRlbkqtWu/RXJvV
X-Gm-Gg: ASbGncs1XRC/wCwA7gfOryFicLspZhoJImLHTOF6JlHNPMbWYM5l+8ps4h/fq0eb2yp
	wngJeeev2/QpqzCAFsqdpGAKR0lrAuj3Oxn7ilCTZmjRpIrhADrSMVUbqokwIdAPCv5DJRt0Xr2
	TmvE6gdBlFPREubKf3vKwH6eJHnd868E8Z+DpSSy28qk+AD19NyfY+5gyDLWqchLKj/UG0lZfzW
	SsEg3VqfhnAMe88XP6M9e9ODcckTosVJBcX+B95LD6BPs4Q4//IuBMq4ZReDv/RMxezWrqI/6cH
	mvclMidM29FYvaf2+uHWZQNf2E0t6LrG30/d8LmA5F7ZtlP3pBiX9ITcq7IVsQ==
X-Google-Smtp-Source: AGHT+IEvKsYyiIeKhSCEqxAOZsTuLrWmoiPq+q7QjDiIKJsyTc7wpK5BxhX2/hHParmAJT0q9QxjIw==
X-Received: by 2002:a05:6a00:35c9:b0:73c:c11:b42e with SMTP id d2e1a72fcca58-7409cfd5addmr7438760b3a.20.1746663526867;
        Wed, 07 May 2025 17:18:46 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405902167csm12378724b3a.98.2025.05.07.17.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 17:18:46 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v2 06/10] hw/cxl_type3: Add DC Region bitmap lock
Date: Thu,  8 May 2025 00:01:02 +0000
Message-ID: <20250508001754.122180-7-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250508001754.122180-1-anisa.su887@gmail.com>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anisa Su <anisa.su@samsung.com>

Add a lock on the bitmap of each CXLDCRegion in preparation for the next
patch which implements FMAPI Set DC Region Configuration. This command
can modify the block size, which means the region's bitmap must be updated
accordingly.

The lock becomes necessary when commands that add/release extents
(meaning they update the bitmap too) are enabled on a different CCI than
the CCI on which the FMAPI commands are enabled. 

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/mem/cxl_type3.c          | 4 ++++
 include/hw/cxl/cxl_device.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 6ad48f55ce..b5b3df5edf 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -824,6 +824,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
         };
         ct3d->dc.total_capacity += region->len;
         region->blk_bitmap = bitmap_new(region->len / region->block_size);
+        qemu_mutex_init(&region->bitmap_lock);
     }
     QTAILQ_INIT(&ct3d->dc.extents);
     QTAILQ_INIT(&ct3d->dc.extents_pending);
@@ -1176,6 +1177,7 @@ void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
         return;
     }
 
+    QEMU_LOCK_GUARD(&region->bitmap_lock);
     bitmap_set(region->blk_bitmap, (dpa - region->base) / region->block_size,
                len / region->block_size);
 }
@@ -1202,6 +1204,7 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
      * if bits between [dpa, dpa + len) are all 1s, meaning the DPA range is
      * backed with DC extents, return true; else return false.
      */
+    QEMU_LOCK_GUARD(&region->bitmap_lock);
     return find_next_zero_bit(region->blk_bitmap, nr + nbits, nr) == nr + nbits;
 }
 
@@ -1223,6 +1226,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
 
     nr = (dpa - region->base) / region->block_size;
     nbits = len / region->block_size;
+    QEMU_LOCK_GUARD(&region->bitmap_lock);
     bitmap_clear(region->blk_bitmap, nr, nbits);
 }
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index cbcc1bc9f5..9cfd9c5a9f 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -618,6 +618,7 @@ typedef struct CXLDCRegion {
     uint8_t flags;
     unsigned long *blk_bitmap;
     uint64_t supported_blk_size_bitmask;
+    QemuMutex bitmap_lock;
     /* Following bools make up dsmas flags, as defined in the CDAT */
     bool nonvolatile;
     bool sharable;
-- 
2.47.2

