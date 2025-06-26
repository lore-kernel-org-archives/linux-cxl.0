Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D126C26772D
	for <linux-cxl@vger.kernel.org>; Thu, 26 Jun 2025 22:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750976908; cv=none; b=RoBMsbYkOUuGxEWIWksMGbVIQieJu8b24uStMQzeY9uuyGGXHmB0vi7W7gZdcMVyoSfLcgmc73P2pJ9uhj5AaLu1RtnQZzlbQ2myzDZVHbZmG/N7tBB7KUdAuUokIwDlVbgTARCchCgv3nRsLkSCDbgFXaWPAamcoNny795eDGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750976908; c=relaxed/simple;
	bh=7Uu7m86oTbgBns8kIx/1lR7//+SxTAIIHutQQ/ATtmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tW57H3K9Kckopr7TmdqjOxSOBtk3v+388UGL/I+Cv/s0rui2qiP/4j2Owi/czmyWp//ogFRY9vprm7b1L0w7YcfLW+hWBiGW/st9mv3G9eqBGhmIT4Szw1mIcN2BoKIJUVqhPWG2jTcztwcLACKdNEgGOXXQiZoGEo9qRW5F1jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYMbtRui; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYMbtRui"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23508d30142so23909835ad.0
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jun 2025 15:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750976906; x=1751581706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBps1tm/E0rqCasT+u+6aJlRaXwKKIUQT/6/1t5YR3A=;
        b=KYMbtRuif82Wr7j3XY2OlCKx+f3jqAvwC/PbIFgDrhm78bUiWBNvbrcGQSCs6z8C0J
         NuaarjXXXHGWQHrpQMGSj2mCwTcCY55P2Pa8/oI6W3lvcbH2L6vb1xHEkfnyzyeKJ9CP
         9SLz5STz7L8rxo/xFKRzkfckm7/0ftaV6ESBM63ORP84Ly7d604G6xPcJ4ydJpzy2tTe
         G+gNrRfi4nK+RP1qNq2n/WBNeArxfysLFdNh/GjaV4UJBwKRVJQcM/aZCvabRPmFtC8O
         hT1RRzA6bTxPB4BzKf9pGVaWNA9RD3VrtAcTRgcYd7rGNlw2Bn/P3sKxVNcd00YQ/B5/
         lkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750976906; x=1751581706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBps1tm/E0rqCasT+u+6aJlRaXwKKIUQT/6/1t5YR3A=;
        b=UJibCDWqJvissDtyLBh6RBxcrjNqRHeQbxbRwBnvV5Zu+eD1FAONy1lNYRGyzZUoYa
         cFYb9tZpOlgxDm6p+CDh1VRjgX2XdLH/Et2NNRIuKIIV5P84JAOIzbc0eKrdzKuyppZN
         XuN6e8nY8mXiBOK38noHQun7JZ537lwwl5DJA6AJGVhc5EKyKDXIkaY6aSF5syH4G8wo
         7oDJKZbLx5LkfTURFGHGOeIWsi8cjw+XTRzLyLIscm9er+bbRdDrUBIuEja1MrPOtZNQ
         N90hlmOQgGdrCJcX+ppyOOkDiv1XU0ET/oTG1zFG6xBflPzD6JbORh3KtWvofjW4EWyB
         SazQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDIoM6Ff2H03RzcVCBgt6Np+1tg9nJnxChCTqmbpmXeZoska0P+GsFJk9PbY04pRBvTcVHJl3VeXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXzu2rdgEp17qJoPgfggmqfyIPfZKvCF6Otg+v1+Er2v5kQR4Z
	TrOIS15RZNh+LIa6K6BgSSdEBN93wKpLUB7g2PUsTXvUZrWof71iMwe3
X-Gm-Gg: ASbGncvHlM8IKHVLzOtc/Sdi9bBK20gkSyDpN3iCeyOcF2/RQOhn2Fw9LTC1ai+M+Ww
	rSMWL//EcBnKNsl7EpHIfYaEha0hVvaM/jRkgSYG3nd7djNY97/mRFFN5ubyHpmsXRI4CnWOCwD
	1JrB5hQX5oCjp7f8/5AknS14wRTOU3HOteT7kb+L8+gaJXQSi1ys5jOfQey0ujizs+MLmuVK1Ar
	Y40K3pgRcVLRrCv4s34dDUjwpwmkyXWWMQ834E1j5PVn8vshY7M/NSGARxN34glRbeZVYyO7D9V
	/tzGzse5DikONhlo+JMWbNnC0abUtSbW5KhiGKHwQkF9+HEEYPn4RfwtK7b4w00YkNUD4waEOj2
	mFf0r6dMrAzq8rjWZZg==
X-Google-Smtp-Source: AGHT+IE0vEXNHth7oaL4diMn3sE9UxFbYJIMXP4uA3k28cRYItq0xgl7K501CLHx1FPhTKL//pIV7w==
X-Received: by 2002:a17:902:f548:b0:237:e3a0:9d63 with SMTP id d9443c01a7336-23ac46344aemr14497665ad.43.1750976906080;
        Thu, 26 Jun 2025 15:28:26 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3c4b23sm870365ad.214.2025.06.26.15.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 15:28:25 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	alok.a.tiwari@oracle.com,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: [QEMU PATCH v4 05/10] hw/cxl_type3: Add DC Region bitmap lock
Date: Thu, 26 Jun 2025 22:23:28 +0000
Message-ID: <20250626222743.1766404-6-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250626222743.1766404-1-anisa.su887@gmail.com>
References: <20250626222743.1766404-1-anisa.su887@gmail.com>
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
index 397edcff4c..6a5025200c 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -547,6 +547,7 @@ typedef struct CXLDCRegion {
     uint8_t flags;
     unsigned long *blk_bitmap;
     uint64_t supported_blk_size_bitmask;
+    QemuMutex bitmap_lock;
     /* Following bools make up dsmas flags, as defined in the CDAT */
     bool nonvolatile;
     bool sharable;
-- 
2.47.2

