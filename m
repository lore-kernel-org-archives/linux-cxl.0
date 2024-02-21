Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E4185276
	for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539681; cv=none; b=s4xWdQ5MOjPi7UGmF93uoGXWLQD9SNG+RpWXYyIr2UT0Ms2wRNBInCixIxOQn22qIdWjkY7v6pfd5yVjC3WfHvqfOHrvsQd+Xf63Ax2MNOWf9TGdOp9Ai5tv5lOxYJ6eU8l56JCpEU+ypDCDQMsLSh2UDMfHSjq9q6iIaunOvRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539681; c=relaxed/simple;
	bh=OUt0GphFQTMnW+jE+Iwc7K36cOd6hhjWqrRpfji621E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGvo+6GE2YAXot2hq7rbGWDAzco2IBivY2kW05sQBibfLbVrtm9WJzGZhdRzNZ/Q/eJiMAtdCvRx/1DIwMp9AI/JUXojt2XadJNgLPerrDna4n2MTmPULEAInXTWJwOr5CKvZj5Zv/iXV9cWjMoJXhkKQGltqp8ai8QyPclSGWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bP1gE29/; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bP1gE29/"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29951f5c2e7so2508527a91.1
        for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 10:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708539679; x=1709144479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMsgYchrz+Nvp+KunIns7+nQr9EgC+4zBQ7CzSVSfR4=;
        b=bP1gE29/bcJk0MCF7g2jr8lhPpscFN8DzUDYjgWApK1uSUYKbcMN8mETxk8rF+4uOH
         /1njRdG1qo1hzF9ToHjJpebzYpvmTjnjIANR8yysSeLy3273Kaaf9LL6hqP/BQ7l3M6J
         cVRsbT32R32vg1Crorzh4+b0isQ90DsXJPNuaCqe765Xik+grJX372lW42uyTD1P/ivz
         zZ6Hhp73oFGBUZ1L39xGZ6MD32v0CY7UBfcri1R4Iu4C4dZVkr/dKFhIE1pjXLpF80FF
         Mq6tZm93y2PCFeCCo4O6xPDyQq+Aido9iF6Tu0x2jOuYgFSVO6Jjyx5DIZKdM2rxziVB
         AVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708539679; x=1709144479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMsgYchrz+Nvp+KunIns7+nQr9EgC+4zBQ7CzSVSfR4=;
        b=W0poPttQ2QNKMlnXmLUSM2RT60mXwND+zTxd2SgTRkEg3mWgi9AoByFSDfmx6MSwrn
         mnsnRPUNASTGI1c6aedW8IQ3kSeQz3hqFUhx/jwWaZ6MgEnxMwxLKkl9+mF5zulU2XB+
         crZ/E4QGP/UwCMVrXZqikMUUQbvUN1HHx8PdSZMOAgjC6ou0SZ7YCpXuAUtIWB+IT2Zo
         ZDRiKxlKKnidW0OS+MY8Z3CxWSIp/lg8kpyimloV8y0vTbE9byqxSLZGPU4doB4gft8i
         6aPSQxoLLstHdb8fEX2cpONOfk+aM1UzD3UQNJs9ElrWlEYUFUemCADByWqFI81mqc9/
         LjiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4UasE7FhQUZeW9jGU/9g4rHkwOMUKHNRslhnMPCh00+yc/HxLjz1cRQMprKNOLvfKF6GMMaryXhzN4Av5075/Y+XbRebkdx63
X-Gm-Message-State: AOJu0YxthI6kp5sSisSDedxRx69xaILoxNQ29K4MPTLLVhYfwKfN7jQC
	yyRdPJTbIRCP19Tcul4SX8lLJztRmg9tKTn1W3oMhv6ylaCRwpI/
X-Google-Smtp-Source: AGHT+IE55Txhzt5qTIZN0Q8RXv9M2omyIKe/vPoOqMifiqePhZSO9K1zIAHiHrBjclNSMl0HCCDkNQ==
X-Received: by 2002:a17:90b:4b4c:b0:299:73b3:cf15 with SMTP id mi12-20020a17090b4b4c00b0029973b3cf15mr8589636pjb.12.1708539679129;
        Wed, 21 Feb 2024 10:21:19 -0800 (PST)
Received: from localhost.localdomain ([2601:641:300:14de:5692:7e41:13a2:69a])
        by smtp.gmail.com with ESMTPSA id cs16-20020a17090af51000b002992f49922csm9979009pjb.25.2024.02.21.10.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 10:21:18 -0800 (PST)
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
Subject: [PATCH v4 07/10] hw/mem/cxl_type3: Add DC extent list representative and get DC extent list mailbox support
Date: Wed, 21 Feb 2024 10:16:00 -0800
Message-ID: <20240221182020.1086096-8-nifan.cxl@gmail.com>
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

Add dynamic capacity extent list representative to the definition of
CXLType3Dev and add get DC extent list mailbox command per
CXL.spec.3.1:.8.2.9.9.9.2.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 71 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  1 +
 include/hw/cxl/cxl_device.h | 23 ++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index f95e417683..dae7fe00ed 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -83,6 +83,7 @@ enum {
         #define CLEAR_POISON           0x2
     DCD_CONFIG  = 0x48,
         #define GET_DC_CONFIG          0x0
+        #define GET_DYN_CAP_EXT_LIST   0x1
     PHYSICAL_SWITCH = 0x51,
         #define IDENTIFY_SWITCH_DEVICE      0x0
         #define GET_PHYSICAL_PORT_STATE     0x1
@@ -1344,6 +1345,73 @@ static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * CXL r3.1 section 8.2.9.9.9.2:
+ * Get Dynamic Capacity Extent List (Opcode 4801h)
+ */
+static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
+                                               uint8_t *payload_in,
+                                               size_t len_in,
+                                               uint8_t *payload_out,
+                                               size_t *len_out,
+                                               CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    struct get_dyn_cap_ext_list_in_pl {
+        uint32_t extent_cnt;
+        uint32_t start_extent_id;
+    } QEMU_PACKED;
+
+    struct get_dyn_cap_ext_list_out_pl {
+        uint32_t count;
+        uint32_t total_extents;
+        uint32_t generation_num;
+        uint8_t rsvd[4];
+        CXLDCExtentRaw records[];
+    } QEMU_PACKED;
+
+    struct get_dyn_cap_ext_list_in_pl *in = (void *)payload_in;
+    struct get_dyn_cap_ext_list_out_pl *out = (void *)payload_out;
+    uint16_t record_count = 0, i = 0, record_done = 0;
+    CXLDCExtentList *extent_list = &ct3d->dc.extents;
+    CXLDCExtent *ent;
+    uint16_t out_pl_len;
+    uint32_t start_extent_id = in->start_extent_id;
+
+    if (start_extent_id > ct3d->dc.total_extent_count) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    record_count = MIN(in->extent_cnt,
+                       ct3d->dc.total_extent_count - start_extent_id);
+
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+
+    stl_le_p(&out->count, record_count);
+    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
+    stl_le_p(&out->generation_num, ct3d->dc.ext_list_gen_seq);
+
+    if (record_count > 0) {
+        QTAILQ_FOREACH(ent, extent_list, node) {
+            if (i++ < start_extent_id) {
+                continue;
+            }
+            stq_le_p(&out->records[record_done].start_dpa, ent->start_dpa);
+            stq_le_p(&out->records[record_done].len, ent->len);
+            memcpy(&out->records[record_done].tag, ent->tag, 0x10);
+            stw_le_p(&out->records[record_done].shared_seq, ent->shared_seq);
+            record_done++;
+            if (record_done == record_count) {
+                break;
+            }
+        }
+    }
+
+    *len_out = out_pl_len;
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -1391,6 +1459,9 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
 static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
     [DCD_CONFIG][GET_DC_CONFIG] = { "DCD_GET_DC_CONFIG",
         cmd_dcd_get_dyn_cap_config, 2, 0 },
+    [DCD_CONFIG][GET_DYN_CAP_EXT_LIST] = {
+        "DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_list,
+        8, 0 },
 };
 
 static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b966fa4f10..f4edada303 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -661,6 +661,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
         region_base += region->len;
         ct3d->dc.total_capacity += region->len;
     }
+    QTAILQ_INIT(&ct3d->dc.extents);
 
     return true;
 }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 2f244da9a1..12a6fb47a9 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -424,6 +424,25 @@ typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
 
 #define DCD_MAX_REGION_NUM 8
 
+typedef struct CXLDCExtentRaw {
+    uint64_t start_dpa;
+    uint64_t len;
+    uint8_t tag[0x10];
+    uint16_t shared_seq;
+    uint8_t rsvd[0x6];
+} QEMU_PACKED CXLDCExtentRaw;
+
+typedef struct CXLDCExtent {
+    uint64_t start_dpa;
+    uint64_t len;
+    uint8_t tag[0x10];
+    uint16_t shared_seq;
+    uint8_t rsvd[0x6];
+
+    QTAILQ_ENTRY(CXLDCExtent) node;
+} CXLDCExtent;
+typedef QTAILQ_HEAD(, CXLDCExtent) CXLDCExtentList;
+
 typedef struct CXLDCDRegion {
     uint64_t base;
     uint64_t decode_len; /* aligned to 256*MiB */
@@ -470,6 +489,10 @@ struct CXLType3Dev {
         HostMemoryBackend *host_dc;
         AddressSpace host_dc_as;
         uint64_t total_capacity; /* 256M aligned */
+        CXLDCExtentList extents;
+
+        uint32_t total_extent_count;
+        uint32_t ext_list_gen_seq;
 
         uint8_t num_regions; /* 0-8 regions */
         CXLDCDRegion regions[DCD_MAX_REGION_NUM];
-- 
2.43.0

