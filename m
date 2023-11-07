Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01277358A8
	for <linux-cxl@vger.kernel.org>; Tue,  7 Nov 2023 18:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiPDYEGY"
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0D08F
	for <linux-cxl@vger.kernel.org>; Tue,  7 Nov 2023 10:10:19 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc4f777ab9so42936745ad.0
        for <linux-cxl@vger.kernel.org>; Tue, 07 Nov 2023 10:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699380619; x=1699985419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lerGkvWs+2MRxdzE0DMBKiSOqV9ui2+nfnjyOq/W8aE=;
        b=AiPDYEGYYamOo8G4T/N/l2ccB6vDkF7IOnkxx0vy1i+14lil101g+v7O4zu8m9R12o
         wB5xYZ7MUFx/EV7Yi7h0VBZKv3SD458z5EMglO7kcY/6a8AB5ki3V1+RiGlwCmhsRSMf
         4TiMr4VkdctjN9EaIz5HSZ6gf/RCL7kcaaR0Jb+TDNBAlbXC8ldf3iGmhPvfASeJRcF9
         RO22CHnEg0hlGYfnj6eajouYjiYhOS8J9V/gIvLeYSCCLClfCUBrqdIDN1O8FKHnckti
         ctNvWNcsM49PAmmgWeT2kEztG9uSf9mGqY4DA0ThBhvct6osYv8WAleq2xmBFf5/LGBb
         vEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699380619; x=1699985419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lerGkvWs+2MRxdzE0DMBKiSOqV9ui2+nfnjyOq/W8aE=;
        b=W8bJFTes9brdNjKjE1heWjSt7u1ZddNOPyU1MYk5ftHxWV9Ci9fYJXUSUl1c1k2ZGS
         7zcoigf4QS0XpQf3/37BojEBepX64JKXDl3/yzvT2TIYDZ4nkaCjJseu5xOoaWQEABCx
         7fqiBO3mT2S0sqJ5qxHpJjPTdzgYpLyEa7gGNQ9gYW+cLoDLRx5meDqeR7YANRBEaB/H
         lfEiZjN6CHCCyFktruxxIhFyffXf2j7XWSc40kNwkzgdZMEb/4tpEhSPZ81b8HAu+fdX
         qnVzknrm6AnGzY2PZuOPMmDLFybU/HJYp5DSItNAii/sDVKC3TSIHS/GaG39xHF5q85c
         DjIA==
X-Gm-Message-State: AOJu0YxwaM+rn1dDn1mHmYkwZWTM2eVXVqsvAd8YkV8WFq8XLaUnPrxQ
	Cw1mz0IPWts+iS2mMNtru/M=
X-Google-Smtp-Source: AGHT+IE9CVDa0uPYwQ3dK4HiagUY1Wab+0CtaMHuuj9jitAwMCnxS1Hx84mPVFs+ql161c+jSgZwkA==
X-Received: by 2002:a17:903:245:b0:1c5:d8a3:8789 with SMTP id j5-20020a170903024500b001c5d8a38789mr32291748plh.4.1699380618992;
        Tue, 07 Nov 2023 10:10:18 -0800 (PST)
Received: from DT.local (c-71-202-158-162.hsd1.ca.comcast.net. [71.202.158.162])
        by smtp.gmail.com with ESMTPSA id az10-20020a170902a58a00b001cc615e6850sm131924plb.90.2023.11.07.10.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:10:18 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	nmtadam.samsung@gmail.com,
	nifan@outlook.com,
	jim.harris@samsung.com,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v3 3/9] include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for type3 memory devices
Date: Tue,  7 Nov 2023 10:07:07 -0800
Message-ID: <20231107180907.553451-4-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107180907.553451-1-nifan.cxl@gmail.com>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
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
index f80dd6474f..707fd9fe7f 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -774,7 +774,7 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
     snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
 
     stq_le_p(&id->total_capacity,
-             cxl_dstate->mem_size / CXL_CAPACITY_MULTIPLIER);
+            cxl_dstate->static_mem_size / CXL_CAPACITY_MULTIPLIER);
     stq_le_p(&id->persistent_capacity,
              cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
     stq_le_p(&id->volatile_capacity,
@@ -1149,7 +1149,7 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
     struct clear_poison_pl *in = (void *)payload_in;
 
     dpa = ldq_le_p(&in->dpa);
-    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->mem_size) {
+    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->static_mem_size) {
         return CXL_MBOX_INVALID_PA;
     }
 
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 6c1ccda159..754c885cd1 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -762,7 +762,7 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         }
         address_space_init(&ct3d->hostvmem_as, vmr, v_name);
         ct3d->cxl_dstate.vmem_size = memory_region_size(vmr);
-        ct3d->cxl_dstate.mem_size += memory_region_size(vmr);
+        ct3d->cxl_dstate.static_mem_size += memory_region_size(vmr);
         g_free(v_name);
     }
 
@@ -785,7 +785,7 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         }
         address_space_init(&ct3d->hostpmem_as, pmr, p_name);
         ct3d->cxl_dstate.pmem_size = memory_region_size(pmr);
-        ct3d->cxl_dstate.mem_size += memory_region_size(pmr);
+        ct3d->cxl_dstate.static_mem_size += memory_region_size(pmr);
         g_free(p_name);
     }
 
@@ -1008,7 +1008,7 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
         return -EINVAL;
     }
 
-    if (*dpa_offset > ct3d->cxl_dstate.mem_size) {
+    if (*dpa_offset > ct3d->cxl_dstate.static_mem_size) {
         return -EINVAL;
     }
 
@@ -1188,7 +1188,7 @@ static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
         return false;
     }
 
-    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.mem_size) {
+    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.static_mem_size) {
         return false;
     }
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 334c51fddb..de6469eef7 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -232,7 +232,7 @@ typedef struct cxl_device_state {
     } timestamp;
 
     /* memory region size, HDM */
-    uint64_t mem_size;
+    uint64_t static_mem_size;
     uint64_t pmem_size;
     uint64_t vmem_size;
     bool is_dcd;
-- 
2.42.0

