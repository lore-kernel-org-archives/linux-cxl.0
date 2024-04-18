Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D2C2AF0F
	for <linux-cxl@vger.kernel.org>; Thu, 18 Apr 2024 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713483010; cv=none; b=EJwkixr1Bbft0iAufZ8KN5UAYVCsEjxNGhvYu8fAssn0q0rNFpNPdtZmZ9MP41T1Is3rC82Dl0bkxbePX3r4xq0vQpqTXjJZZ4yyLGf3WBnr3m7nP+CH/2n7xVhRirwCY2RrTDTIT10Vyc9hCozN/I0NXW32y/iNfjjmXj25f70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713483010; c=relaxed/simple;
	bh=pA0UZ5S09ZRfYx5zbrKTB2Eppma02dLoAJjpBiJ6/zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXtvNVrWXGUe7BUahqTzkIXu0Zip1VT63Xi+0LuyDsV6cAhEkRYv5b2tB58PbDn0EbpSDaOA2iGIilUAUVx3otRUoIO0ENq0AGCXVTb4TiJEZ4/PLRgCZ5LSdw9XFvxASUxsU6FJ9ur0wkyz2ZrmbqxRpBtZ+Ge4dqle7mbCG9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bo70e4Gq; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bo70e4Gq"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d8b519e438so1114920a12.1
        for <linux-cxl@vger.kernel.org>; Thu, 18 Apr 2024 16:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713483008; x=1714087808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcorWsBRN7cgnG7Jkx2nUqtNQI6bccmxCNztfvmiAis=;
        b=bo70e4Gq0gYxaRMmjUOx++Hvlni6hdYJbddHS0iXv5/1neT5jBAfJwDiONUgnl7keC
         IWnU3444zVmB7y58dai5NXou7dQ3llLv78HBLMihRqflpkzBMscj16tKenFcA6tqy686
         kQvTh13P392MvN+TnL8w1gJGR2LbomcdNY5TL/EMwVrB5m5PLPjAApxAoGziNEZHx3Ie
         yVSmUjS0KSEmw4XXZmsoSkgoj7LHSQuJdTKFR/yTQqof9owWORgoIsovsIidc8r7yqzN
         moXUMWNAzxpLztwHd72bzR7y6La9dQutQ6KBZWsxyjOurFDfTA9QGaul5oIT58p7iqv7
         iRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713483008; x=1714087808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcorWsBRN7cgnG7Jkx2nUqtNQI6bccmxCNztfvmiAis=;
        b=nKusod5FapnRYmjr7o2+CLDUMMPFAZab+IfU/0xBZrJtkgVcF5Zb60d5BHYE7fj4Lv
         gtBHv98kEmpampcVypdJLcGpeZ4WaIgqDuy8AuzkcWJMk3IacRu+8wRwr24SWsBzYJ6R
         cixrvxIQNUKDNzZsLqTLUvJa+JFvth0b1jMzh6QlpFVl6dx8kkWEdamnPI1T/lP3O2HZ
         hnTbWA42YN4MA2FKgfaNHO7h1efrHQ7hOun0mLcgKbyfMPvhlGyZER6Y2AUFNa29xnGJ
         zJWh3/QnO2P7e50zKKaYMaDpwMjUId4L3WE98wiEUoPfJG72I//XSEv3pJRUGImJMluO
         2e5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBESF/isQeeNt/iSZAdNq3W4GN8toPwGdnCXWv9/Hu0dhOkZKB8mUr0gZKg7uEHwTLMe4WhDNZfHnRlBg3od3tFpoirJ27jQ8z
X-Gm-Message-State: AOJu0Yxie7dkPEubH4U0dOU+A+pX9Dt98/F0+mLMcAJenaTl94ya8tl0
	z6z2jwfh5noaP//EMZIl3nxJLRrSsElo3lh4aPPx62tN5XP6+r21apfvIg==
X-Google-Smtp-Source: AGHT+IEe2oQ/rY1RuB2G5jd9JSOk0Pj/3msZn0RnPw2T1zzw3M+jGX51KaWwSuwKTz3hTUuooSlAUg==
X-Received: by 2002:a05:6a21:3482:b0:1a7:a2f2:c71a with SMTP id yo2-20020a056a21348200b001a7a2f2c71amr963853pzb.0.1713483008094;
        Thu, 18 Apr 2024 16:30:08 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:ed8b:f40f:7543:e9ea])
        by smtp.gmail.com with ESMTPSA id h3-20020a056a00230300b006e6be006637sm2040783pfh.135.2024.04.18.16.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 16:30:07 -0700 (PDT)
From: nifan.cxl@gmail.com
X-Google-Original-From: fan.ni@samsung.com
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
Subject: [PATCH v7 03/12] include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for type3 memory devices
Date: Thu, 18 Apr 2024 16:10:54 -0700
Message-ID: <20240418232902.583744-4-fan.ni@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418232902.583744-1-fan.ni@samsung.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
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
index b0a7e9f11b..5d6d3ab87d 100644
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
 
@@ -838,7 +838,7 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
         return -EINVAL;
     }
 
-    if (*dpa_offset > ct3d->cxl_dstate.mem_size) {
+    if (*dpa_offset > ct3d->cxl_dstate.static_mem_size) {
         return -EINVAL;
     }
 
@@ -1011,7 +1011,7 @@ static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
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

