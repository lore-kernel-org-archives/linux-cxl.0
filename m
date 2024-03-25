Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC694C83
	for <linux-cxl@vger.kernel.org>; Mon, 25 Mar 2024 19:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393470; cv=none; b=m7DjymuKUWq7lZ7Pa8bhtHWWLPT7G7SHfffh9O5yqw/MH3h1kGCszVQVf330PIJ7KnJIy8kVBPMyRr+hsXEixa9yftQqsD6rcmT0pdpb9tUr8Od6lvU+V8KfEer+5zseBC0Rsvc2S4WKXgQbP+u8JDKsFYlibjKXqYLNJm7Be4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393470; c=relaxed/simple;
	bh=FF+CLj7/4Ta1TG8dvkj7Od8+/8dXAIYu1QK2sou+H0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbVnM1NulqMQ2w6W4emeHYbv88yVw0zdZbSjlFwetENNrsoile1XispbgXZIrrmLDzAlsnMeds3DjV+tfXZd3OJISC5zEzhkDnXsMKLCX9hTQGmHWz7BSju/xXwNKde5XLQa7dpaG0yUX1tlj2fP8Ng9QD4NAqBIqoOgQnSgG4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beXBXM10; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beXBXM10"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3689a0abfd2so2309955ab.2
        for <linux-cxl@vger.kernel.org>; Mon, 25 Mar 2024 12:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711393468; x=1711998268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsEOxMlU55nR+s6pTI/E0qn/RMJMO6SWzoYHx0Prrb0=;
        b=beXBXM10g2LZJ9l9CxLErSM7HB0AKkuShIw9i83GGe3bCqGx2gpcl7KVQTUlhNS2Uu
         UA6vG7gJrtF20aT/uE1TjsiyUqGkQ0N07cyirOqtbu5K0V39T9HpebnEAx1j1HuSEWzd
         BjYBEH3kT4YV5F2ZeGnBb81Q8a/cSIz1pIg2wiy7xLG6piSfpguxbhCeDKRALSq1CYXh
         wUNqWB0le5JXi2H7m13arC6wcUzH5gFN2WR/5X2LnpLLu6l1Inx+Xexwn+dF16iymwKB
         hCoC6a7t/cthgc18OztJ4Jsnh0EjBcn8d1ZMLhdYfcsUzeXlX86vcGkvgs2PUAJR2nBJ
         zaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711393468; x=1711998268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsEOxMlU55nR+s6pTI/E0qn/RMJMO6SWzoYHx0Prrb0=;
        b=naRrNeNUgBWhYXWdwe2j2ntbg5XHY+Wll1dbvzwODGpRed5oy73R2MRGgtiUovhSEW
         +Hg2S4uVgnA+lt00FN/wp4ZA6riuUGjDfXPuAVL/Ee2g3kUNnrwU7v72BYPuw+1JAmG9
         k2SRDFjxIbBnLBsJUV4kb5EC1OcSKqa9mOWHpHcb2o5Uoa9u3aFC628/ow9mdOuCQPKZ
         RFMhpE5bKTMYOkNsFiCBZffca5iPOncU5XlkDyXeWDD8Viri9TuY/HhBocGkOrKmLnpG
         ZUATDhI14CMLS70thYkueEeMFgcqQ9Gq78m03fVAgLEqYkdrl+PNzfZMOYvOnQn4IydN
         sPCw==
X-Forwarded-Encrypted: i=1; AJvYcCWxqeXrlt4/bnAfGYAy5xpZVX16y3yfRhIOyB97Wi6hzmNLLpn8anhSlVFt6IscERpBA3ibxUniGTWxvCxVEFcuWx0A2v7PcYPq
X-Gm-Message-State: AOJu0Yx26t8tVbqtU0xumwW7LeOBWxtwxfrWjOWTmCDbWsdaI6z3yNDU
	gyUglVJ5rrhG8ZG4iylaX0SGGIYdnj50T3tk+RRhfn0fJjd++J92
X-Google-Smtp-Source: AGHT+IGYRH/8bP9YC5VIIvc2uxzSieEgYRFC4mMjmWSJpGhRy1N8jHG8LqK2CC2nQfYyQSb+6MMuow==
X-Received: by 2002:a92:903:0:b0:366:a93c:66c9 with SMTP id y3-20020a920903000000b00366a93c66c9mr596709ilg.4.1711393468227;
        Mon, 25 Mar 2024 12:04:28 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:7bed:2ef:bead:18b])
        by smtp.gmail.com with ESMTPSA id z7-20020a634c07000000b005f05c9ee8d3sm1722663pga.93.2024.03.25.12.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:04:27 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	gregory.price@memverge.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	nmtadam.samsung@gmail.com,
	nifan.cxl@gmail.com,
	jim.harris@samsung.com,
	Jorgen.Hansen@wdc.com,
	wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 03/12] include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for type3 memory devices
Date: Mon, 25 Mar 2024 12:02:21 -0700
Message-ID: <20240325190339.696686-4-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325190339.696686-1-nifan.cxl@gmail.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

Rename mem_size as static_mem_size for type3 memdev to cover static RAM and
pmem capacity, preparing for the introduction of dynamic capacity to support
dynamic capacity devices.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 4 ++--
 hw/mem/cxl_type3.c          | 8 ++++----
 include/hw/cxl/cxl_device.h | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 49c7944d93..0f2ad58a14 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -803,7 +803,7 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
     snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
 
     stq_le_p(&id->total_capacity,
-             cxl_dstate->mem_size / CXL_CAPACITY_MULTIPLIER);
+             cxl_dstate->static_mem_size / CXL_CAPACITY_MULTIPLIER);
     stq_le_p(&id->persistent_capacity,
              cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
     stq_le_p(&id->volatile_capacity,
@@ -1179,7 +1179,7 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
     struct clear_poison_pl *in = (void *)payload_in;
 
     dpa = ldq_le_p(&in->dpa);
-    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->mem_size) {
+    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->static_mem_size) {
         return CXL_MBOX_INVALID_PA;
     }
 
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b679dfae1c..0836e9135b 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -608,7 +608,7 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         }
         address_space_init(&ct3d->hostvmem_as, vmr, v_name);
         ct3d->cxl_dstate.vmem_size = memory_region_size(vmr);
-        ct3d->cxl_dstate.mem_size += memory_region_size(vmr);
+        ct3d->cxl_dstate.static_mem_size += memory_region_size(vmr);
         g_free(v_name);
     }
 
@@ -631,7 +631,7 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         }
         address_space_init(&ct3d->hostpmem_as, pmr, p_name);
         ct3d->cxl_dstate.pmem_size = memory_region_size(pmr);
-        ct3d->cxl_dstate.mem_size += memory_region_size(pmr);
+        ct3d->cxl_dstate.static_mem_size += memory_region_size(pmr);
         g_free(p_name);
     }
 
@@ -837,7 +837,7 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
         return -EINVAL;
     }
 
-    if (*dpa_offset > ct3d->cxl_dstate.mem_size) {
+    if (*dpa_offset > ct3d->cxl_dstate.static_mem_size) {
         return -EINVAL;
     }
 
@@ -1010,7 +1010,7 @@ static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
         return false;
     }
 
-    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.mem_size) {
+    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.static_mem_size) {
         return false;
     }
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index e839370266..f7f56b44e3 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -234,7 +234,7 @@ typedef struct cxl_device_state {
     } timestamp;
 
     /* memory region size, HDM */
-    uint64_t mem_size;
+    uint64_t static_mem_size;
     uint64_t pmem_size;
     uint64_t vmem_size;
 
-- 
2.43.0

