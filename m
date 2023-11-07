Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076E3358A0
	for <linux-cxl@vger.kernel.org>; Tue,  7 Nov 2023 18:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSlWdHVf"
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9265D120
	for <linux-cxl@vger.kernel.org>; Tue,  7 Nov 2023 10:10:22 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6c115026985so6102311b3a.1
        for <linux-cxl@vger.kernel.org>; Tue, 07 Nov 2023 10:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699380622; x=1699985422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUVbPa2RXh5sULa717dlwLdK6nK0VOlZVO7MX7gSRww=;
        b=HSlWdHVfzNkfsusr9OG+tSqD1+N4uckCxZ7l8BXFCaClFJjDsg9JWuQR9bpVola7v1
         AN0D5Po/aG6reg6UPYiF0i7XtccU+sLqKAvpYMXiSULMEmrtvbY4jg7WHdoWaJ0gIZMm
         kyqTbF9zFOUF/gOgg6mpPF2xHb9r3hZKLt3xM7FnxGVnZKKWGC7z9xZzk1IdprHEsh7n
         yv13RVtvK+GykSnqbzQsXR2qbIXxVluo8xEW4x9/Eb2z6pG7AXrcm3LNwlS6ZJItJE4R
         hJlrDExNFYrVx/Nzz8LBzS6oiRczDwyG+nQQ69yWHUey9bCEW4wjpwHPIAfdmidQ0auh
         yIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699380622; x=1699985422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUVbPa2RXh5sULa717dlwLdK6nK0VOlZVO7MX7gSRww=;
        b=hViS8kqFTSkZGyMKnKd9CIyGYiI2mtGbvh34o0HZFe+bxtlRbpD9dvH/Pv5rIUX456
         CYXI4O+Uyw4EFHjRTOOQmf9txbcmWXvm+WCakNDooayS+WyuJ9OcnnrVkA3P/i3DBYbt
         kxHWDeOwbDd+hMJ2qkmoR8LcOaB6Xok/oa7YTpe54bMUgENehd2xLFWh0IuORvleQpAE
         7UsqR9lab/thKc5GHVTAi60ZNDGr0ELvsJb+1qQnG80uEgnKM0cL1kRWdWPzlrAKZr4v
         lhPHwV1SnmhilxyFSMVljN4eMFxfjBiLCuy43mWpis4Nisx0yjHqiD3qBh5L2AWHaw8M
         cVhQ==
X-Gm-Message-State: AOJu0YxX8cxfVo0eSlTpdPsHCVSYrI4OfyqR0BAbPrNpjAlQa/+czhBy
	EOsj1tYnSVHcl1fOYK6Y40o=
X-Google-Smtp-Source: AGHT+IHbIav+SSkCelT+QQDr+/PZe04ppInU4J8uSOtgCzMCmlf2Dg5sNGz15p4xGCJORRfIXBtO/A==
X-Received: by 2002:a05:6a20:3d82:b0:16b:9886:7eda with SMTP id s2-20020a056a203d8200b0016b98867edamr38574558pzi.35.1699380622013;
        Tue, 07 Nov 2023 10:10:22 -0800 (PST)
Received: from DT.local (c-71-202-158-162.hsd1.ca.comcast.net. [71.202.158.162])
        by smtp.gmail.com with ESMTPSA id az10-20020a170902a58a00b001cc615e6850sm131924plb.90.2023.11.07.10.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:10:21 -0800 (PST)
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
Subject: [PATCH v3 6/9] hw/mem/cxl_type3: Add DC extent list representative and get DC extent list mailbox support
Date: Tue,  7 Nov 2023 10:07:10 -0800
Message-ID: <20231107180907.553451-7-nifan.cxl@gmail.com>
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

Add dynamic capacity extent list representative to the definition of
CXLType3Dev and add get DC extent list mailbox command per
CXL.spec.3.0:.8.2.9.8.9.2.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 73 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  1 +
 include/hw/cxl/cxl_device.h | 23 ++++++++++++
 3 files changed, 97 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 1f512b3e6b..56f4aa237a 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -82,6 +82,7 @@ enum {
         #define CLEAR_POISON           0x2
     DCD_CONFIG  = 0x48,
         #define GET_DC_CONFIG          0x0
+        #define GET_DYN_CAP_EXT_LIST   0x1
     PHYSICAL_SWITCH = 0x51,
         #define IDENTIFY_SWITCH_DEVICE      0x0
         #define GET_PHYSICAL_PORT_STATE     0x1
@@ -1286,6 +1287,75 @@ static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * CXL r3.0 section 8.2.9.8.9.2:
+ * Get Dynamic Capacity Extent List (Opcode 4810h)
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
+    CXLDCDExtentList *extent_list = &ct3d->dc.extents;
+    CXLDCDExtent *ent;
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
+    /* May need more processing here in the future */
+    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+
+    memset(out, 0, out_pl_len);
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
@@ -1333,6 +1403,9 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
 static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
     [DCD_CONFIG][GET_DC_CONFIG] = { "DCD_GET_DC_CONFIG",
         cmd_dcd_get_dyn_cap_config, 2, 0 },
+    [DCD_CONFIG][GET_DYN_CAP_EXT_LIST] = {
+        "DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_list,
+        8, 0 },
 };
 
 static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 152a51306d..c9d792a725 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -811,6 +811,7 @@ static int cxl_create_dc_regions(CXLType3Dev *ct3d)
 
         region_base += region->len;
     }
+    QTAILQ_INIT(&ct3d->dc.extents);
 
     return 0;
 }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 3dc6928bc5..5738c6f434 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -420,6 +420,25 @@ typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
 
 #define DCD_MAX_REGION_NUM 8
 
+typedef struct CXLDCDExtentRaw {
+    uint64_t start_dpa;
+    uint64_t len;
+    uint8_t tag[0x10];
+    uint16_t shared_seq;
+    uint8_t rsvd[0x6];
+} QEMU_PACKED CXLDCExtentRaw;
+
+typedef struct CXLDCDExtent {
+    uint64_t start_dpa;
+    uint64_t len;
+    uint8_t tag[0x10];
+    uint16_t shared_seq;
+    uint8_t rsvd[0x6];
+
+    QTAILQ_ENTRY(CXLDCDExtent) node;
+} CXLDCDExtent;
+typedef QTAILQ_HEAD(, CXLDCDExtent) CXLDCDExtentList;
+
 typedef struct CXLDCDRegion {
     uint64_t base;
     uint64_t decode_len; /* aligned to 256*MiB */
@@ -470,6 +489,10 @@ struct CXLType3Dev {
         HostMemoryBackend *host_dc;
         AddressSpace host_dc_as;
         uint64_t total_capacity; /* 256M aligned */
+        CXLDCDExtentList extents;
+
+        uint32_t total_extent_count;
+        uint32_t ext_list_gen_seq;
 
         uint8_t num_regions; /* 0-8 regions */
         CXLDCDRegion regions[DCD_MAX_REGION_NUM];
-- 
2.42.0

