Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5462C37143
	for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486527; cv=none; b=D1OKuh8IAyAm8Jr3OaQG2ALO6UmdIcdyGx0emfIXPbN+f3X2S2zS4NWxcJ1Vl8zRFaUNLu74R9AVjMfzVy40SODXfXqeiw1mSQ2PLwP3ZjH3qVXT0QHWFnaz/Sp7SkVl7w05rX/bL/YP7zPFA7Ca313O/mmnao/dP3rvJA4HgwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486527; c=relaxed/simple;
	bh=13Vx5SNatYntqkzNxUcMeGtlUfbxWCaOqAEmRo1kUHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3qyDqtgGLc5VESLTch142/FfXNqqSJ9sCfLntnxn26sqbfJarGG3FWW+YW4sZr+93QDHOHp2W00JKDxgIavNIYX6fsdOd6W481Oy5GTORESWWIUL99WTtyDZlCWWmrecQD6RIwKOxIHehCbCzpjsFIIoRLck9D9rDb6gHX2dX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/Z0wSWM; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/Z0wSWM"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f32a3b9491so15561505ad.0
        for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 10:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486526; x=1717091326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7w7R6UVzX6+WHico1aXCCyhaIVNu2naBa1UA0NOMrYo=;
        b=R/Z0wSWMHTCX+8m2b5Fb7DULbI9wpIhnHK5NT7PwumHaPHGIl/mHK38lpz/ngrKvc0
         YaNVu9hoV+kAPWcqgWavyjChQlwH6vFEY4nPFFuONkMEmJgSeZcvY3XhtYg3pV2YL9+I
         GD/722luIWPcscGZoRf764LljykzH6aysYKznnImB0gJ2F63dPYqfX+PiAsssozgKbt1
         aM0MoYKP++JTD/15MDzdEacAwkyGuERxfemtMV694tPc001Kfha7cqelhCBN6HOuxImg
         prqxbrfL31cxMEBam+wX62UsgNaxVCYk2w9TV1vnpgoWK9nx8mz5rEmL/7nk4ldkpOiZ
         S34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486526; x=1717091326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7w7R6UVzX6+WHico1aXCCyhaIVNu2naBa1UA0NOMrYo=;
        b=m0c05TJ/ok1JuML//F+KIY8YHW0JFVDKMDQkewk3tI158y/CTvl762zhx4B0m7gmcT
         jlZuqKeHmV5jzLvd4Xdl7O106+xN3GHXqCoDcX29cdofmrfzwkl72EB5SZ6JjKBtW6wW
         vs0OrUnYmC+fP6VaBa9vKSMwLefqSWR/vVJJ599GDLuoHuoEjBYPnqCF521kcueiwQWA
         klJ98YrwmdernK6P1jC7p+aa6QFjRhLZR9NdDlnC+9dFHxGtBYazpScYXluDUkIzxvot
         51Fjvmb+9y4v//O0mSBhokmPilH49uZpInYNzo320sYkHNnqzphgeVVevdJWY13187sf
         CKPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEs1A2ut4VLSlumNV8WjXfXSV0zlvECCneBrllz7PviX+Oa9Vwo2Nw/rCbItzALbh7CXFjHgIhFuqgWLowT1kG8ZCK6fZrn8KB
X-Gm-Message-State: AOJu0YzHTExfOaK3Z7ijXiLIzDkrFUvPEX75c6+pZiaUCa7nZNFvW6WV
	uu8KmpvVV5V4PsUYF09vzuD2MgSBf6b9TBpStaNLkYL+kFfoRmaV
X-Google-Smtp-Source: AGHT+IFHNTxQXFigHYpoI3dZOa8JygDT29EI1nALPQKjXb7XuMb9TVVlXj+AJkeRalDhpehak1Dwow==
X-Received: by 2002:a17:903:2451:b0:1f3:50b5:65bd with SMTP id d9443c01a7336-1f44873c138mr460315ad.33.1716486525777;
        Thu, 23 May 2024 10:48:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:4f9e:216e:ed5a:642d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c137e7esm253436265ad.257.2024.05.23.10.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:48:45 -0700 (PDT)
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
	armbru@redhat.com,
	mst@redhat.com,
	Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v8 05/14] include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for type3 memory devices
Date: Thu, 23 May 2024 10:44:45 -0700
Message-ID: <20240523174651.1089554-6-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523174651.1089554-1-nifan.cxl@gmail.com>
References: <20240523174651.1089554-1-nifan.cxl@gmail.com>
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

Reviewed-by: Gregory Price <gregory.price@memverge.com>
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
index 3e42490b6c..7194c8f902 100644
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

