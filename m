Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCAD1B78F3
	for <linux-cxl@vger.kernel.org>; Mon, 17 Mar 2025 16:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229853; cv=none; b=u8Rbl2HhcHyOaP3T2v8uAcz4DFeU7z9lqml6EZsUtihMrV8hfGHJwBfBGAE6fSSWvKqQRYOGsvZwsBchKS5McUnr7+40YXsela57bFOM1jLCBa0OkgDo399luyWCXb/0fpx4iDLfe/u2oklp9H65CFpWPtlwRMSnR+orVXf90ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229853; c=relaxed/simple;
	bh=AML86UDeaUeQvw2pvgsXlV9rulxNzdKUbVukgor2R7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2qnFVd9rWyEEU01odKQ84ZhSoV2fPwWeprE3bdr8YLaodGp/9Pv76ahKG4vSaD+g4m7lZypWCaPi88S39EcBObw3SzyM469MIT91OEgfVl44HMZfodIsO6HqbVB/b+PkL6yCx8/PfPGPOvJh7Yi08UJLsDgNjDGar2kqFuYGwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1/17XAS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1/17XAS"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22359001f1aso38660405ad.3
        for <linux-cxl@vger.kernel.org>; Mon, 17 Mar 2025 09:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742229850; x=1742834650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qX31zqHeedLuC0moymwx118I/OYgCdYe/VclY70qVzc=;
        b=S1/17XASXTk0s0qXWba8NOhQKZlkwfjv5pWtY0kzl1Dm44XWqVRxK30b0s9UJktp9Z
         zGQ2mFl426WXNcslOPepvhI85GJzd9NtIkhtrOHhqJ+vtWjRo0acomnts8J5TiUSFZOn
         fPmd50kLZAkKXMnyvfP7DWceg8bLPeogXRgM3cdYZmXZTwKKdjInfhndqN3WTsOHScyz
         SffwvG0g9IDQgwuDibV1jKJvlycFSUzSTXMJ/dTU0SjYsAj/i3ttN+vujlyg/aPNnkuH
         c5yrrIYt8Hw/ZpdQAxko5T7RLNFxyuO4CQgJtEmz5A1qylnJT+ebIsR4JE2iAEkZQQKi
         Xkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742229850; x=1742834650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qX31zqHeedLuC0moymwx118I/OYgCdYe/VclY70qVzc=;
        b=u2rZp84oulvHupPK3drZoHxZqBPy9MhZdikCWKWWiDVWFWaw+dp4Kz9snDCvikwLao
         b/OBAxG+UZuW8HvNJNwHoDzGPuck0uG0iZXmue+uzzrpdiyvZL4g+nuFx47MuUqs0ihb
         q92z9GQvFghBE2A0aE9v+yfAVBpGfhvR0ejzPQROWSSFqVFeMBJeNu87ZwnrZ9ckTF7c
         a6YZLNKhaboFBhoiWz03Ncc7Bnsa3sB69HZeRX3An667uzonz0SUhoFUilagI1lFgSRT
         i9jvbH+CNcGMdMomBpWPjaPwxvg7QKQrGpTSmQXE51pdURdShGR+XK70Zz813FsUnYvI
         ZHLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuoNOH6Yo22/Fw85sfmwUfoGhTTlhD3xnPsz3pH5J7wQoWBFeF2xg4w5Hs6khRaBj0l2LQj0EKutw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5VEZDcaf6FCfUkya0tcdp7XnQezGQUVauaN0anqFDbFt8IDp1
	HmqWPiQfJMU6AykmdbTuzRK6AzH8q+sW3OKjP451MphddongqGqm
X-Gm-Gg: ASbGnctX/jh7RZOH6Y62SjFBNVqpXNOoEecJyXcv6fD7sak17RXOqJbNIwPEelaOm59
	B1/N21TWd1eHNrNm4+xl0yqc3B6Ax+rbwHQU7+bsw1ySw5nmVF86sphRiXEK4db5iM6nr9Xz6RO
	IG4cHAhHkpNhudzUYMuAhO7h4vVw3YtH8CFomvukJeZDqiiYnWF2qGVIme5JTO46tquAi5TuPjL
	WA1CFqYxro7OxLODqSQSDpRQWdpD9Y0+PiYzwzoVLXGfWe/ZHu2i1XRQgnCPoHRqS+L6xJ0UZ5l
	UZCmtDWo1DQ7ko5U8BgJF6LNgaMesoIxdk+VpSeEdPY/6gH3C5BpEf1cqH3ZraIEIw==
X-Google-Smtp-Source: AGHT+IHTebDERZjGklDFMKmEuc+upsuhOSlF8scUGuGJDUpkpQHIzWWc0tRIDXwvlj9dgAvfbHTwPA==
X-Received: by 2002:a17:902:f708:b0:223:90ec:80f0 with SMTP id d9443c01a7336-2262c55fcafmr2783855ad.22.1742229849743;
        Mon, 17 Mar 2025 09:44:09 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6888461sm77810085ad.23.2025.03.17.09.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 09:44:09 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH 9/9] cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC Release
Date: Mon, 17 Mar 2025 16:31:36 +0000
Message-ID: <20250317164204.2299371-10-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317164204.2299371-1-anisa.su887@gmail.com>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anisa Su <anisa.su@samsung.com>

FM DCD Managment command 0x5605 implemented per CXL r3.2 Spec Section 7.6.7.6.6

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 94 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 5bcbd434b7..37810d892f 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -128,6 +128,7 @@ enum {
         #define SET_DC_REGION_CONFIG 0x2
         #define GET_DC_REGION_EXTENT_LIST 0x3
         #define INITIATE_DC_ADD           0x4
+        #define INITIATE_DC_RELEASE       0x5
 
 };
 
@@ -3722,6 +3723,10 @@ static CXLRetCode cxl_mbox_dc_prescriptive_sanity_check(CXLType3Dev *dcd,
                                                ext.start_dpa, ext.len)) {
                 return CXL_MBOX_INVALID_EXTENT_LIST;
             }
+        } else if (type == DC_EVENT_RELEASE_CAPACITY) {
+            if (!ct3_test_region_block_backed(dcd, ext.start_dpa, ext.len)) {
+                return CXL_MBOX_INVALID_PA;
+            }
         }
     }
 
@@ -3835,6 +3840,88 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * CXL r3.2 Section 7.6.7.6.6 Initiate Dynamic Capacity Release (Opcode 5605h)
+ */
+static CXLRetCode cmd_fm_initiate_dc_release(const struct cxl_cmd *cmd,
+                                             uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out,
+                                             CXLCCI *cci)
+{
+    struct {
+        uint16_t host_id;
+        uint8_t flags;
+        uint8_t reg_num;
+        uint64_t length;
+        uint8_t tag[0x10];
+        uint32_t ext_count;
+        CXLDCExtentRaw extents[];
+    } QEMU_PACKED *in = (void *)payload_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    g_autofree CXLDCExtentRaw *event_rec_exts = NULL;
+    CXLEventDynamicCapacity event_rec = {};
+    CXLDCExtentRaw ext;
+    int i, rc = 0;
+
+    switch (in->flags & 0x7) {
+    case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE:
+        rc = cxl_mbox_dc_prescriptive_sanity_check(ct3d,
+                                                   in->host_id,
+                                                   in->ext_count,
+                                                   in->extents,
+                                                   DC_EVENT_RELEASE_CAPACITY);
+        if (rc) {
+            return rc;
+        }
+
+        /* Create extents for Event Record */
+        event_rec_exts = g_new0(CXLDCExtentRaw, in->ext_count);
+        for (i = 0; i < in->ext_count; i++) {
+            ext = in->extents[i];
+            event_rec_exts[i].start_dpa = ext.start_dpa;
+            event_rec_exts[i].len = ext.len;
+            memset(event_rec_exts[i].tag, 0, 0x10);
+            event_rec_exts[i].shared_seq = 0;
+        }
+
+        /* Create event record and insert to event log */
+        cxl_mbox_dc_event_create_record_hdr(ct3d, &event_rec.hdr);
+        event_rec.type = DC_EVENT_RELEASE_CAPACITY;
+        /* FIXME: for now, validity flag is cleared */
+        event_rec.validity_flags = 0;
+        /* FIXME: Currently only support 1 host */
+        event_rec.host_id = 0;
+        /* updated_region_id only valid for DC_EVENT_REGION_CONFIG_UPDATED */
+        event_rec.updated_region_id = 0;
+        for (i = 0; i < in->ext_count; i++) {
+            memcpy(&event_rec.dynamic_capacity_extent,
+                   &event_rec_exts[i],
+                   sizeof(CXLDCExtentRaw));
+
+            event_rec.flags = 0;
+            if (i < in->ext_count - 1) {
+                /* Set "More" flag */
+                event_rec.flags |= BIT(0);
+            }
+
+            if (cxl_event_insert(&ct3d->cxl_dstate,
+                                 CXL_EVENT_TYPE_DYNAMIC_CAP,
+                                 (CXLEventRecordRaw *)&event_rec)) {
+                cxl_event_irq_assert(ct3d);
+            }
+        }
+        return CXL_MBOX_SUCCESS;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+            "CXL extent selection policy not supported.\n");
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3977,6 +4064,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
         CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
+    [FMAPI_DCD_MGMT][INITIATE_DC_RELEASE] = { "INIT_DC_RELEASE",
+        cmd_fm_initiate_dc_release, ~0,
+        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
+         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
+         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
+         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
+         CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
 };
 
 /*
-- 
2.47.2

