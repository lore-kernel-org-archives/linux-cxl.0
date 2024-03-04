Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA5E7994A
	for <linux-cxl@vger.kernel.org>; Mon,  4 Mar 2024 19:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709581454; cv=none; b=A/t1wr1paxMayRZCEYAWb8a3She/W1caMfXRiayczVGK6xLconxACb/Q6ZSt6AFSJhSaptbs2hXULTIBqTBO3cXTEFSm1RHVT087ohfAY9CQPgKIu/nM48BUCTdkJZQZ3efo+O4g6l2llqcVu3u8yC6eM2opA+BryOlK+EUhDrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709581454; c=relaxed/simple;
	bh=+RjIdzXfin30Va7NvOuSi1ob0+wL6GMLo+/DcgnOx1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNX6B8XF3x+vsthvZxetltfzRja+wSVqPj9c68yrR9jkhk3mg2qVSRrMgcYtCQL5o6GcqbEFg4UuzuUD/r+IZVS/4LJqJpxefmhkC5zdeNvaXhOqOCrEHqsxLkaV7j5ufYWFh9DSbIJnOxLPxfWusoIcuTCQe56o5lYtrULVwc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHGcagtG; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHGcagtG"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so5184511276.1
        for <linux-cxl@vger.kernel.org>; Mon, 04 Mar 2024 11:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709581451; x=1710186251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2InpeJRt+f0kCa8qliojbJhzR8/UO/mLPd8lEue23eI=;
        b=DHGcagtG287NJJguAKiW5KsUGB7HxGExXHHm+lhpAiLeUaBIQqtI/zFdiGyBN07eTE
         mKF4h3amrXkGVbVB3/NuJFfp8rc0NAVsDRNkedncPeBkekC2TrvuGrauwXE51oWTpYme
         fr7stmpMKPj/jCrxY1rK8QhRvGL9kpPvWb0fPhp4+utTG1dWqfbWPlX3sTWZB90Z/4cC
         51LQzfJavm0ftfJirQyWoQZIG/IhUz/TBf4XwUMOHYYoB0H1OEyL7044aJVoUizZXV/3
         gc488l0D7zHz3/OuGiu4jKYQ+VwtlPWEtxOnEhztDfjrcN9pVuuj29T8RFCI7PFoQ8k9
         tXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709581451; x=1710186251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2InpeJRt+f0kCa8qliojbJhzR8/UO/mLPd8lEue23eI=;
        b=ubvpKtk+fAhD8jyfW625kFVVlec26z5hDPnG9Ws+UEpybWq53hJV6uMqCB7d1MW3JP
         C1Onthi480SY6UR3+weCp2j5tiDQk9ENB2zPc1LJZFSRQtZZE3sJhpQAWdaK9XIRxiSI
         gQ+ounWrYp9Dhzs2j1ySlxSZbXUktZdTpFR3+OI2mHiYlz9GJ3+UUToMLTfPKV0a63vJ
         FqRWTAZuyGFxXLveUCjLNuxLupPqtnnewgPHlcMf1wUsYiA8QsZATcI34/VoGNqSb2zr
         T+WiZ0Y5HTukY421rsmnW8O7Bs7A6zGAY9BPSeMOuoa93zxXPE+Jzhld/AfcNic646jK
         t9uw==
X-Forwarded-Encrypted: i=1; AJvYcCVZzngzHC5OC2nLgNAm9zdxubgXvl/2FJMjerYgHTISqY2XIeW8vOf/tibgU9RC28UBoY1Kjy/MiiD6u78SZig9hQ/n3SN3qg11
X-Gm-Message-State: AOJu0YzlghZAx5GdHFSmZnRWgXkVukel6exFCJkSY97IVP3UAvrI7bRs
	Eu3qFx7RtIhI24diltWjRicEYapLNZ/5zkTBdfBW4k7W/xVk0X/5
X-Google-Smtp-Source: AGHT+IEklaIYAzLXknCQyGLMTYvknIhiLaansPxR45rNdr+9VPvP4NwG4q+IH2RxW6udFYT1qcQEPQ==
X-Received: by 2002:a25:aa8b:0:b0:dc2:2b0d:613e with SMTP id t11-20020a25aa8b000000b00dc22b0d613emr7102455ybi.10.1709581450845;
        Mon, 04 Mar 2024 11:44:10 -0800 (PST)
Received: from localhost.localdomain ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id h1-20020a255f41000000b00dc62edd58dasm2282646ybm.40.2024.03.04.11.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:44:10 -0800 (PST)
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
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v5 03/13] include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for type3 memory devices
Date: Mon,  4 Mar 2024 11:33:58 -0800
Message-ID: <20240304194331.1586191-4-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304194331.1586191-1-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
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

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 4 ++--
 hw/mem/cxl_type3.c          | 8 ++++----
 include/hw/cxl/cxl_device.h | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 5792010c12..853dadba39 100644
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
index e8801805b9..244d2b5fd5 100644
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
index 93ce047b28..f82d018422 100644
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

