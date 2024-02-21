Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAFC8527A
	for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 18:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539676; cv=none; b=ODnE9IXvPWraKKsgGjZUznJCXCoRBn0IeDIu9fJZwq4rGp2U33c9H2JQ40H5klFr6ssSuhjOR7Q4uSOF6AsOVew+aDCQVeOqrH9mFJ/LOSPyLBGN9OoirMKEztAVpEe9FMTbLtJ18bmU5SRv9hoA/slxT0gcogj0Uz2H15vmXsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539676; c=relaxed/simple;
	bh=AZ2NQgPZiDbodG5N8nCybOdRqZa4Yfmcx3M295mbScY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdzuafO3D7JzzjyzQIISFdfQqYeCiAvfIdOsAfw/xAqLBswDlz/qz0njwqAJGh02FzTrBCP9otFRmmiZeaRdZt+mY/32QzFJXYBy9MMuRtM9ipD+ex6S8/yIrLAFkGgVteA7JCqGN9BqbTeeWvCRxxsPCBJVhlkwB+rWe18dKYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iU2+xLo4; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iU2+xLo4"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d8b276979aso5388076a12.2
        for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 10:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708539674; x=1709144474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnjf2LLXHCSGzRVtlUxFuz40qj2WpBzq7LFxL5kuDZQ=;
        b=iU2+xLo4BTlk0/mVk0tTGsrnmZOybVOJZ4HPj/Z3l9GnUy/HnsKF6entVVmIjRgMQC
         yJBV1aB6yDyk/YdhTaxcrvAgaTb/vxMTgZe77gkykQcxTY0Y2OqAR/C7s78+vGafrGjA
         wW2I4Lcd5LmoPaHKt8vttv/e6VRX2Fb4+s5WlKnI7SVFdZ4Z5+ekJ9qXBouQq1yCL/r4
         K/Zd6BXfi9PyssQc0fuiqNU6st2dU6IU7qOuYM6eUh99+fYK1cPFQeDvD49sdxOcMq8p
         uimCzFue2+VvZAfR5bFKaqhgKaAk3tzy/rWamY66dpBr3UAnhetjh2HHdEGGT7L/TdaC
         Zzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708539674; x=1709144474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnjf2LLXHCSGzRVtlUxFuz40qj2WpBzq7LFxL5kuDZQ=;
        b=qSz+YmLl/YrgIAKnWYN/YCLsAG22bjyi/+ga6q6TplY1josmJT16TugMd6Rza1jK/a
         iwGykk1WeL+XadZS/A2GMuSoWkieq/gyZuavayCLXlBdBl9hIQS2h5V+0rMjLByVmCxe
         Z2Z5rbfGoPj7Qtgt95JAGKGPcf4p65nd9s5BYtvMhkt8oqgdRzHTxc46j6UuFTFs5ZtQ
         48VLpk8KMtD37guXkeV6ErgVGqTpC25LbIqmUgmjoU2dGFtlQiTRwmfYap32R1W6E92x
         TyqcZ8UjbRL8eqOyRNxivR1mmm3IL6jmNdUjHptTuCVRuWnCD71Ksob1TP/MbF+GIkd6
         OrEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ7dvjgvt33VGySERoDkCcnhLRSGYjiZOl6BvjCg4GKawxDf7T+RzVE+QSBX15/Z3N/uoWYYYwGk+zZB5fYbahy4A9Bg2h8pzz
X-Gm-Message-State: AOJu0YzfVX8pwdXNrdFeN6MUodjpkkoRVmgXGji0lrZ/NoENaF1BB3er
	EGI68UUm4ZovJGwzZtF8uuU7+bKgp5po4Q3Pfn1Vnf+A8XkMpfLv
X-Google-Smtp-Source: AGHT+IHROlOq4gqtw0lnNWWoRjKU1S6sa8+quFg1tqY8CpOuHQhfr0DhIXnQnZ4RDbnFAreDF8H/lA==
X-Received: by 2002:a17:90a:ae0d:b0:299:c344:2b5 with SMTP id t13-20020a17090aae0d00b00299c34402b5mr6298324pjq.40.1708539674434;
        Wed, 21 Feb 2024 10:21:14 -0800 (PST)
Received: from localhost.localdomain ([2601:641:300:14de:5692:7e41:13a2:69a])
        by smtp.gmail.com with ESMTPSA id cs16-20020a17090af51000b002992f49922csm9979009pjb.25.2024.02.21.10.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 10:21:14 -0800 (PST)
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
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v4 03/10] include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for type3 memory devices
Date: Wed, 21 Feb 2024 10:15:56 -0800
Message-ID: <20240221182020.1086096-4-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221182020.1086096-1-nifan.cxl@gmail.com>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
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
index 88e3b733e3..7d2b74c9c5 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -802,7 +802,7 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
     snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
 
     stq_le_p(&id->total_capacity,
-             cxl_dstate->mem_size / CXL_CAPACITY_MULTIPLIER);
+             cxl_dstate->static_mem_size / CXL_CAPACITY_MULTIPLIER);
     stq_le_p(&id->persistent_capacity,
              cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
     stq_le_p(&id->volatile_capacity,
@@ -1178,7 +1178,7 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
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
index 6df7fecdf1..80188db670 100644
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

