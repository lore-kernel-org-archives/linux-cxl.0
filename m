Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C54C37B415
	for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476516; cv=none; b=FvrUfGkPZam1ejmQccCvBtZKsb3b7IzolamqT4WW6e9E6D4A+wH/ZhG+w7zUs8/JGnk9LY4lvztU/VByw9e5hzOUEnmG6ns14dlpKNz4l9uuEDqciKMf30kGBM0+6QIET02I/QBVfVkmN+YSMwSnlp9zRtvmHofoY4zNwZZj/00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476516; c=relaxed/simple;
	bh=5IIqfE/oH34ikHRgQ9GUDX9BP0Tb+it4MTbip49XTaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N8XzZzkLGjgQ/5+bTRqqBKRbq3pk/cJt8JJOgM3zkCOGLWB+VHK51n0FU9waCsX1wH3/7N5rgnZSYrpxRvDjVtBAWWP1nZAOB7vKaeuFzTckgE2l74uUHHjTxseoYu/QcJjJ4mm1hdr+1dlgXUUtoGIZCPPOAcHt9QKA99BglZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eP5fKj1h; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eP5fKj1h"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2adbfab4501so59553615ad.2
        for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 08:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777476514; x=1778081314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oaj7TdntV4BbKlicNCDnibmbfLlIXWSzMFxlbQXRV0=;
        b=eP5fKj1hYykfT+0iBQ7mqioT/oy35i4cGenv/Fqi+yep1vgRbnV2RvEBIwRS9YHVaO
         HAFL0+seJEheacbbFeYHNarwXrF23jr2HRrA8lbtz+EMKbfa1BOBjhDUhYNmyjg3m3le
         dBA/ylXduPRBiwytIxizx3u5Fo4SCCYb7m38MPTfux0C/qU8EZkDiz4mulEOorT/vzS7
         W4Nvkvn/Oup8GcTXeqnXQY+mOOwPp+zg8i2AH6SrvWccmx45GVMCl+cYMKz0ga9G62NR
         i4SFuxfw7AM9M18WmFk1Ro0EWIJg72rh+/QeJCiVj9qgDWF3VfWNY8n116u92p1EMqxK
         hLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777476514; x=1778081314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/oaj7TdntV4BbKlicNCDnibmbfLlIXWSzMFxlbQXRV0=;
        b=YrNoFzJcNLmxXUQ4CNNDGApRWNOPj0XRYl6+w01g5bykYcvo1DtpH6rJutsmqvq2w9
         kDBUrLVvcGqXmGfHrMdIpSMja207MIg8AjmcqnBDc77Z5M+XpAQkk6ihMC8ncsyUvDZ9
         efc4QRLpAf52skvZ3IhG2BZKD0RsfD6bjFEIrNZYXFPLJl+6sPj3gTOQUIfBErkmDDCW
         smQEMHjD2fJqo++VMlQPOCMmzhHNzJMs/bvydlfX7VOnrq922bGBD/jx0F9SS0t5gX1e
         O9hwC9XfUCydb2PUhW7Zl62vPZoiCQAQVHYkKTf0rjYZfpPYv+ez1l4yCrKyCKycZXdf
         5SlA==
X-Forwarded-Encrypted: i=1; AFNElJ+0xvLIGygDyiTgmX5r1D0HJZQpHdbrBbMVtY8upoG2qyK9qRvLtFkTxMwRWUfmTJuz5qtRZurVLjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj+4ADAegJGvwl9L1jvvhimoVA5BGSOhHBDrYkKV+ioVv/OLc1
	FyFtGnVRrWcaYVZr59Ax/v2gzhyQSSKORQ2EauOnwN94PqRqtwqV0ulP
X-Gm-Gg: AeBDiesHX8VS7ceIjVdPPKbmHbfJIi5KieOAiTuv7Oc3h9FKtKX1XA97QBsMgw7PjdV
	GEqFw/XIunP2TndLhNircixaRDBKeNRnOPPvqUk7tb8lLSn8d63mXIp/7eV6rCcHvjUpPqGdDtt
	XtZF15T1IszCf6HIpYVXbYz7ovW01Pt/5g5+dRchReyXiNk21Tt8wcH9UTnalEkKVwCeG+mK/gR
	d02+x403Rw9/dkX9yUvIUKq5m5OWlp1H//f2TL2aIGt1YyJWxjeGPrur1Y7ydAfRSfmT5LS+OU3
	DJRLrFCfWt+Oqofbs1BDCmKvdY9IeMKokKsTZGyW0bVoLZx2hl3r5EJ/hoeXRYWDECAQIpMi/8O
	cfnAFH38w2W5nIcdEhx368ap2u5d5L/D9+dIHjfitITBLvYjo+oa4Gf7kNa0bJRtKh/Zfm+vd11
	gBPJ+u0OVtuMCCjcfZy7EnzEjJhsf8wjJ9GSaxwkfB1CR3km/6/NV/4HPqQIDY9g==
X-Received: by 2002:a17:903:90b:b0:2b2:dca5:101b with SMTP id d9443c01a7336-2b97c4061b1mr86423935ad.12.1777476513488;
        Wed, 29 Apr 2026 08:28:33 -0700 (PDT)
Received: from localhost.localdomain ([114.249.134.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b988990e4csm26106465ad.83.2026.04.29.08.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:28:33 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	farosas@suse.de,
	lvivier@redhat.com,
	pbonzini@redhat.com
Subject: [PATCH v2] hw/cxl: bound Set Feature writes
Date: Wed, 29 Apr 2026 23:27:50 +0800
Message-Id: <20260429152750.2409174-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAFEAcA_DnrvSCVY3f2q=3OnXt0+708BcwSJ=KhMn1t3sbbXQbg@mail.gmail.com>
References: <CAFEAcA_DnrvSCVY3f2q=3OnXt0+708BcwSJ=KhMn1t3sbbXQbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c1c4d6b38b13 added offset + length checks for the
patrol_scrub and ecs Set Feature branches, but the remaining
branches still copy mailbox payload data into fixed-size
write-attribute objects without the same validation.

A full mailbox payload can still reach rank_sparing and overrun
CXLMemSparingWriteAttrs on current master. With an ASan build
this aborts the host process with:

  ERROR: AddressSanitizer: heap-buffer-overflow
  WRITE of size 2016
      #0 __interceptor_memcpy
      #1 cmd_features_set_feature ../hw/cxl/cxl-mailbox-utils.c:1908
      #2 cxl_process_cci_message ../hw/cxl/cxl-mailbox-utils.c:4622
      #3 mailbox_reg_write ../hw/cxl/cxl-device-utils.c:209

Fold the bounds checking into a small helper and use it for
all Set Feature write-attribute branches, so oversized
requests fail with CXL_MBOX_INVALID_PAYLOAD_LENGTH instead
of overflowing the target buffers.

Add a qtest covering the rank_sparing path.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3458
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
Hi Peter,

Thanks, that makes sense.

I've folded the repeated bounds checking into a small helper and respun
the patch as v2.

Thanks

v2:
- fold the repeated Set Feature bounds checks into a helper
- use the helper for all Set Feature write-attribute branches

 hw/cxl/cxl-mailbox-utils.c | 94 ++++++++++++++++++++++++------
 tests/qtest/cxl-test.c     | 99 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 169 insertions(+), 24 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index d8ba7e8625..4c7a083e4c 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1702,6 +1702,21 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static CXLRetCode cxl_set_feature_copy(void *write_attrs,
+                                       size_t write_attrs_size,
+                                       uint16_t offset,
+                                       const void *payload,
+                                       uint16_t bytes_to_copy)
+{
+    if ((uint32_t)offset + bytes_to_copy > write_attrs_size) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
+    memcpy((uint8_t *)write_attrs + offset, payload, bytes_to_copy);
+
+    return CXL_MBOX_SUCCESS;
+}
+
 /* CXL r3.1 section 8.2.9.6.3: Set Feature (Opcode 0502h) */
 static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
                                            uint8_t *payload_in,
@@ -1713,6 +1728,7 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
     CXLSetFeatureInHeader *hdr = (void *)payload_in;
     CXLSetFeatureInfo *set_feat_info;
     uint16_t bytes_to_copy = 0;
+    CXLRetCode ret;
     uint8_t data_transfer_flag;
     CXLType3Dev *ct3d;
     uint16_t count;
@@ -1760,13 +1776,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        if ((uint32_t)hdr->offset + bytes_to_copy >
-            sizeof(ct3d->patrol_scrub_wr_attrs)) {
-            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
-        }
-        memcpy((uint8_t *)&ct3d->patrol_scrub_wr_attrs + hdr->offset,
-               ps_write_attrs,
-               bytes_to_copy);
+        ret = cxl_set_feature_copy(&ct3d->patrol_scrub_wr_attrs,
+                                   sizeof(ct3d->patrol_scrub_wr_attrs),
+                                   hdr->offset, ps_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
+        }
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
@@ -1787,13 +1803,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        if ((uint32_t)hdr->offset + bytes_to_copy >
-            sizeof(ct3d->ecs_wr_attrs)) {
-            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
-        }
-        memcpy((uint8_t *)&ct3d->ecs_wr_attrs + hdr->offset,
-               ecs_write_attrs,
-               bytes_to_copy);
+        ret = cxl_set_feature_copy(&ct3d->ecs_wr_attrs,
+                                   sizeof(ct3d->ecs_wr_attrs),
+                                   hdr->offset, ecs_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
+        }
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
@@ -1813,8 +1829,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        memcpy((uint8_t *)&ct3d->soft_ppr_wr_attrs + hdr->offset,
-               sppr_write_attrs, bytes_to_copy);
+        ret = cxl_set_feature_copy(&ct3d->soft_ppr_wr_attrs,
+                                   sizeof(ct3d->soft_ppr_wr_attrs),
+                                   hdr->offset, sppr_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
+        }
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
@@ -1832,8 +1853,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        memcpy((uint8_t *)&ct3d->hard_ppr_wr_attrs + hdr->offset,
-               hppr_write_attrs, bytes_to_copy);
+        ret = cxl_set_feature_copy(&ct3d->hard_ppr_wr_attrs,
+                                   sizeof(ct3d->hard_ppr_wr_attrs),
+                                   hdr->offset, hppr_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
+        }
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
@@ -1851,8 +1877,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        memcpy((uint8_t *)&ct3d->cacheline_sparing_wr_attrs + hdr->offset,
-               mem_sparing_write_attrs, bytes_to_copy);
+        ret = cxl_set_feature_copy(&ct3d->cacheline_sparing_wr_attrs,
+                                   sizeof(ct3d->cacheline_sparing_wr_attrs),
+                                   hdr->offset, mem_sparing_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
+        }
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
@@ -1869,8 +1900,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        memcpy((uint8_t *)&ct3d->row_sparing_wr_attrs + hdr->offset,
-               mem_sparing_write_attrs, bytes_to_copy);
+        ret = cxl_set_feature_copy(&ct3d->row_sparing_wr_attrs,
+                                   sizeof(ct3d->row_sparing_wr_attrs),
+                                   hdr->offset, mem_sparing_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
+        }
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
@@ -1887,8 +1923,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        memcpy((uint8_t *)&ct3d->bank_sparing_wr_attrs + hdr->offset,
-               mem_sparing_write_attrs, bytes_to_copy);
+        ret = cxl_set_feature_copy(&ct3d->bank_sparing_wr_attrs,
+                                   sizeof(ct3d->bank_sparing_wr_attrs),
+                                   hdr->offset, mem_sparing_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
+        }
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
@@ -1905,8 +1946,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        memcpy((uint8_t *)&ct3d->rank_sparing_wr_attrs + hdr->offset,
-               mem_sparing_write_attrs, bytes_to_copy);
+        ret = cxl_set_feature_copy(&ct3d->rank_sparing_wr_attrs,
+                                   sizeof(ct3d->rank_sparing_wr_attrs),
+                                   hdr->offset, mem_sparing_write_attrs,
+                                   bytes_to_copy);
+        if (ret) {
+            return ret;
+        }
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
             data_transfer_flag == CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
index 8fb7e58d4f..a9fcd98736 100644
--- a/tests/qtest/cxl-test.c
+++ b/tests/qtest/cxl-test.c
@@ -7,6 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest-single.h"
+#include "hw/cxl/cxl_device.h"
 
 #define QEMU_PXB_CMD \
     "-machine q35,cxl=on " \
@@ -59,6 +60,12 @@
     "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
     "-device cxl-type3,bus=rp0,volatile-memdev=cxl-mem0,lsa=lsa0,id=mem0 "
 
+#define QEMU_T3D_DIRECT_PMEM \
+    "-machine q35,cxl=on -nodefaults " \
+    "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
+    "-object memory-backend-file,id=lsa0,mem-path=%s,size=1M " \
+    "-device cxl-type3,bus=pcie.0,persistent-memdev=cxl-mem0,lsa=lsa0,id=pmem0 "
+
 #define QEMU_2T3D \
     "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
     "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
@@ -81,6 +88,17 @@
     "-object memory-backend-file,id=lsa3,mem-path=%s,size=256M " \
     "-device cxl-type3,bus=rp3,persistent-memdev=cxl-mem3,lsa=lsa3,id=pmem3 "
 
+#define CXL_T3D_DEVFN 0x08
+#define CXL_T3D_BAR2_ADDR 0x10000000ULL
+
+typedef struct QEMU_PACKED CXLSetFeatureInHeaderTest {
+    uint8_t uuid[16];
+    uint32_t flags;
+    uint16_t offset;
+    uint8_t version;
+    uint8_t rsvd[9];
+} CXLSetFeatureInHeaderTest;
+
 static void cxl_basic_hb(void)
 {
     qtest_start("-machine q35,cxl=on");
@@ -118,6 +136,85 @@ static void cxl_2root_port(void)
 }
 
 #ifdef CONFIG_POSIX
+static uint32_t cxl_test_pci_config_addr(uint8_t devfn, uint8_t offset)
+{
+    return 0x80000000U | (devfn << 8) | offset;
+}
+
+static void cxl_test_t3d_enable_bar2(void)
+{
+    outl(0xcf8, cxl_test_pci_config_addr(CXL_T3D_DEVFN, 0x18));
+    outl(0xcfc, CXL_T3D_BAR2_ADDR);
+    outl(0xcf8, cxl_test_pci_config_addr(CXL_T3D_DEVFN, 0x1c));
+    outl(0xcfc, 0);
+    outl(0xcf8, cxl_test_pci_config_addr(CXL_T3D_DEVFN, 0x04));
+    outl(0xcfc, 0x2);
+}
+
+static uint64_t cxl_test_t3d_mailbox_base(void)
+{
+    return CXL_T3D_BAR2_ADDR + CXL_MAILBOX_REGISTERS_OFFSET;
+}
+
+static uint64_t cxl_test_t3d_payload_base(void)
+{
+    return cxl_test_t3d_mailbox_base() + A_CXL_DEV_CMD_PAYLOAD;
+}
+
+static void cxl_test_t3d_submit_set_feature(const void *payload, size_t len)
+{
+    memwrite(cxl_test_t3d_payload_base(), payload, len);
+    writeq(cxl_test_t3d_mailbox_base() + A_CXL_DEV_MAILBOX_CMD,
+           ((uint64_t)len << 16) | (0x05 << 8) | 0x02);
+    writel(cxl_test_t3d_mailbox_base() + A_CXL_DEV_MAILBOX_CTRL, 1);
+}
+
+static uint16_t cxl_test_t3d_mailbox_errno(void)
+{
+    return (readq(cxl_test_t3d_mailbox_base() + A_CXL_DEV_MAILBOX_STS) >>
+            32) & 0xffff;
+}
+
+static void cxl_test_fill_set_feature_header(CXLSetFeatureInHeaderTest *hdr,
+                                             const uint8_t uuid[16],
+                                             uint16_t offset,
+                                             uint8_t version)
+{
+    memset(hdr, 0, sizeof(*hdr));
+    memcpy(hdr->uuid, uuid, 16);
+    hdr->offset = cpu_to_le16(offset);
+    hdr->version = version;
+}
+
+static void cxl_t3d_set_feature_rejects_oversized_rank_sparing(void)
+{
+    static const uint8_t rank_sparing_uuid[16] = {
+        0x34, 0xdb, 0xaf, 0xf5, 0x05, 0x52, 0x42, 0x81,
+        0x8f, 0x76, 0xda, 0x0b, 0x5e, 0x7a, 0x76, 0xa7,
+    };
+    g_autoptr(GString) cmdline = g_string_new(NULL);
+    g_autofree const char *tmpfs = NULL;
+    uint8_t payload[CXL_MAILBOX_MAX_PAYLOAD_SIZE] = { 0 };
+    CXLSetFeatureInHeaderTest *hdr = (void *)payload;
+
+    tmpfs = g_dir_make_tmp("cxl-test-XXXXXX", NULL);
+    g_string_printf(cmdline, QEMU_T3D_DIRECT_PMEM, tmpfs, tmpfs);
+
+    qtest_start(cmdline->str);
+    cxl_test_t3d_enable_bar2();
+
+    cxl_test_fill_set_feature_header(hdr, rank_sparing_uuid, 0,
+                                     CXL_MEMDEV_SPARING_SET_FEATURE_VERSION);
+    memset(payload + sizeof(*hdr), 0x41,
+           sizeof(payload) - sizeof(*hdr));
+    cxl_test_t3d_submit_set_feature(payload, sizeof(payload));
+    g_assert_cmphex(cxl_test_t3d_mailbox_errno(), ==,
+                    CXL_MBOX_INVALID_PAYLOAD_LENGTH);
+
+    qtest_end();
+    rmdir(tmpfs);
+}
+
 static void cxl_t3d_deprecated(void)
 {
     g_autoptr(GString) cmdline = g_string_new(NULL);
@@ -238,6 +335,8 @@ int main(int argc, char **argv)
         qtest_add_func("/pci/cxl/type3_device_pmem", cxl_t3d_persistent);
         qtest_add_func("/pci/cxl/type3_device_vmem", cxl_t3d_volatile);
         qtest_add_func("/pci/cxl/type3_device_vmem_lsa", cxl_t3d_volatile_lsa);
+        qtest_add_func("/pci/cxl/type3_device_set_feature_rank_sparing_bounds",
+                       cxl_t3d_set_feature_rejects_oversized_rank_sparing);
         qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
         qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4",
                        cxl_2pxb_4rp_4t3d);
-- 
2.34.1
