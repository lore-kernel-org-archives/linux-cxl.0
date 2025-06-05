Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296C327FB38
	for <linux-cxl@vger.kernel.org>; Thu,  5 Jun 2025 23:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749166963; cv=none; b=KG2XL/Fl5up5Vg7qLdy7ZwKIkxVSv3Rpur4uk1b26+B+2HtpatGrcVpfLXDDjBdw/v10Na7qkmU8V+KiC473XLWa3l70yD881gHhMAsQBN0ViBWMOq8tAvmIhoMi5zjGgpgdLetMsvFHrMeatWe2k7hjMSEuaCLnaISg0PgScXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749166963; c=relaxed/simple;
	bh=WMwZY5HFIs8pPcY30u04VneJFzZzp/WnKO9saEKhkFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9RWiT6c+ROcFJcaL8Yr9vuftYEbC3v9Zdbluec/df7CJQnXhpGLuYTi2TYbJrA/AcuLIqeKoDHicBL/xT4QrrKLUl3r+VDSfkWpQFRJdE3Z3V6c+DAwO7h9fPsniLTffedVK2x5CuCbavVlWJabowddAi5Ih9nWO/kXczLq5iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzFYESAi; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzFYESAi"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-742c5eb7d1cso1860459b3a.3
        for <linux-cxl@vger.kernel.org>; Thu, 05 Jun 2025 16:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749166961; x=1749771761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hytI++/+HSDgI++r4n2jaUjYPS9mkzDh6jOOmYEmI78=;
        b=MzFYESAixKGmITG9lRAt9kPsPzN0TmKtJjBl3LyUJ3yMV286Ydr0z7IcXVlayoYFh8
         /DK377yUSyY7rQDhjRKUea5bm7YSXNoYmDmQuwb5mibsQQcS1kSm6q8avtweVuXaY8sh
         CIlVLHFm9Zr73V24BcPf92NA2JZLeBtAdF0qxkG73utl5Vx2yXCpQ+JWZsOTJtgd7o+d
         yDs5OJhPXxoPBgHWiM5/1o/mjSmIeuNA69PshNwx/HvtoZ+buMIC/t7ZOLs28rPrxbtn
         GKsrQTp/I+Xa2UoKl/eFv/7gXGnKTSAzHDg7VC10TnEDB2Jycjewuitw1++EwEqJBoO2
         zO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749166961; x=1749771761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hytI++/+HSDgI++r4n2jaUjYPS9mkzDh6jOOmYEmI78=;
        b=oZNCyVtlnSU8RwHzHcz+83zvbFYZgDZ5XXCXNgmgVioeZln0pNpQDkXgjSTlCB8GII
         r2X0g2GdAHfz6JMF05T6ceUVjQHNSn/sbFwtWUhJD14F4EIyYLbfwyDMBuHAfQgDgUBI
         lochnLLpZBPxLQ8lQpmM72aePI+LSf4oyYzkNxF2R4v8KC8Yl/hMVAXi6sZLVKfluTqF
         SR+dSY8zt3sdxq+4mGRRUl/BhVpvgXdonCTWMuzoBYkz8lxOh0EnmrqELxw98IZlJy+1
         iu+ygGpJ5Qa3fvbBMYqqnFINY8x4pG3FSJ4v78tqHBGmRDtvlu3DlzYXn/C/0HK/RkL2
         hOKA==
X-Forwarded-Encrypted: i=1; AJvYcCXBcS4vvo+GOPFqiQfbgLgIiHdPTlIbfktZqdwOpw6TR1zndhBGbimWJiumhfTYVcwcNlXQXnnkRj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAEVhbdLPoj6/hExj+uH8zXnKGsG7P/5r0rDSWfm2j7d9EZ/Pl
	X2fshZ81OYehgeoi+8NByMVqhLoZTDGcWYiB67phPIN1MbAfnjpkumDf
X-Gm-Gg: ASbGncuD3xeaYVHqBgPJWkvRiE3KYLCJFFLw4ExGbdnpBW61jQGUxCCNyQwY/XWrNqE
	vrOQ8227p28CGPW5n0CYRmBCUs7F4yjt4x9JvC1gtFKgk697N4Q4zRlLox6Vznjs1pdlKIrGAyv
	JY5hZxizQzOZV/Vxf3ROYX/kIdShz/e7UdOh6nW3PDlIvq845KCRH0EmTYo0WQRNhooDH+TT4ys
	yPx/yBQQ5hYnX8jWK6KFDfo5pWuzgQOuDjaIv50815zUrU5/RtDiqnVE8b/Kgv3IQ8DPuwDTsbm
	UuyJpl3ktq8LSEG9SIMdyslmjOAre48txnUvHbPMRYben46+6G3khvtKFXP4IqPhXqQ7eEXC
X-Google-Smtp-Source: AGHT+IHNuAyFweuLK9aaXJLo6BNCBOfhLTEWK7H8Z091sLd+658pFI0O4X5K7RxgYf3/1M7Ogu0ITg==
X-Received: by 2002:a05:6a20:6a28:b0:1f5:8b9b:ab54 with SMTP id adf61e73a8af0-21ee2555757mr1282408637.23.1749166961344;
        Thu, 05 Jun 2025 16:42:41 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0847b9sm213916b3a.104.2025.06.05.16.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 16:42:41 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: [QEMU PATCH v3 5/9] hw/cxl_type3: Add DC Region bitmap lock
Date: Thu,  5 Jun 2025 23:42:19 +0000
Message-ID: <20250605234227.970187-6-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605234227.970187-1-anisa.su887@gmail.com>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
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

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/mem/cxl_type3.c          | 4 ++++
 include/hw/cxl/cxl_device.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index cdd60079c4..b872a26173 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -692,6 +692,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
         };
         ct3d->dc.total_capacity += region->len;
         region->blk_bitmap = bitmap_new(region->len / region->block_size);
+        qemu_mutex_init(&region->bitmap_lock);
     }
     QTAILQ_INIT(&ct3d->dc.extents);
     QTAILQ_INIT(&ct3d->dc.extents_pending);
@@ -1020,6 +1021,7 @@ void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
         return;
     }
 
+    QEMU_LOCK_GUARD(&region->bitmap_lock);
     bitmap_set(region->blk_bitmap, (dpa - region->base) / region->block_size,
                len / region->block_size);
 }
@@ -1046,6 +1048,7 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
      * if bits between [dpa, dpa + len) are all 1s, meaning the DPA range is
      * backed with DC extents, return true; else return false.
      */
+    QEMU_LOCK_GUARD(&region->bitmap_lock);
     return find_next_zero_bit(region->blk_bitmap, nr + nbits, nr) == nr + nbits;
 }
 
@@ -1067,6 +1070,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
 
     nr = (dpa - region->base) / region->block_size;
     nbits = len / region->block_size;
+    QEMU_LOCK_GUARD(&region->bitmap_lock);
     bitmap_clear(region->blk_bitmap, nr, nbits);
 }
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 469e5d872a..96ef9be444 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -540,6 +540,7 @@ typedef struct CXLDCRegion {
     uint8_t flags;
     unsigned long *blk_bitmap;
     uint64_t supported_blk_size_bitmask;
+    QemuMutex bitmap_lock;
     /* Following bools make up dsmas flags, as defined in the CDAT */
     bool nonvolatile;
     bool sharable;
-- 
2.47.2

