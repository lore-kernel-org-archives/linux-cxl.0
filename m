Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8F22586EF
	for <linux-cxl@vger.kernel.org>; Mon, 14 Jul 2025 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752515300; cv=none; b=dKBc7/JFonzEmFaC5CTKgzWvqixZ+t/xUIPCjUQhxmDmANBUkVRxAXCMz6GNOW5dQoOFMvWi2eRx2Sd0LmPurfqHXUBuKWtE8t6bKIIXp9E0yPwNjr0C6TiSlmGwOWnV2eHwVXlDCFoOrRGEj5L8GTYsQzlAISn5FsLIO54vcd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752515300; c=relaxed/simple;
	bh=HIQ/CRo5Wh6Uj3H3a8rmBHmrHqIKljRljIkY1eItPes=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CuHOFoGlNSYbLeTXvFFBgQA9zG7MFwtEv1lXdg5uxvFYVYWmf2Q7NhpXx7LN5DN1n0p+TUvkmn/+/XGwCjoZUrJ+qVm4AajsQlHOkaFZ5KjMH7DGCnEb/YgH+A0la0zL8dberw/J7OFvmNZmODy9x34TGhqZJQFVzqW/JvGejrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bgqWq3vddz6M4K7;
	Tue, 15 Jul 2025 01:47:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E6C11402ED;
	Tue, 15 Jul 2025 01:48:16 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Jul 2025 19:48:15 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
	<fan.ni@samsung.com>, Anisa Su <anisa.su@samsung.com>, Anisa Su
	<anisa.su887@gmail.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu v2 06/11] hw/mem: cxl_type3: Add DC Region bitmap lock
Date: Mon, 14 Jul 2025 18:45:02 +0100
Message-ID: <20250714174509.1984430-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714174509.1984430-1-Jonathan.Cameron@huawei.com>
References: <20250714174509.1984430-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

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
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h | 1 +
 hw/mem/cxl_type3.c          | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 7e0a66906f..42ae5b7479 100644
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
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 52d3910ed9..a7a1857a0c 100644
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
 
-- 
2.48.1

