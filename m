Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C6F26772D
	for <linux-cxl@vger.kernel.org>; Thu, 26 Jun 2025 22:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750976914; cv=none; b=eaHPQGSy9c/fELrS0d1XtX4OghZJVVBJoXAlJEeDI8U3Rtan5Ca/X1S3H5hPl+PUNbnX114onf/JOlbgWXC1Cs5pce6E8dd+II3OvTPZyKE1/3r1ynvZXXId386kskvhRUJL8P0S5YnAalFzEm8LkOzTftYRBCG9mMA3aSZKRCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750976914; c=relaxed/simple;
	bh=cL5LAgDW6YFqBuuzbxdP6RWywkgqZLNAKqFSY2Cpv5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoU58mPLFmguR21auOrbgpfDrXaSiOcQJFxYZNz/X06I+oU0wp5fR/a5E8tpi1eI07qzbIU8UXujlVfs67HFG7ynrh5FYQ7b6EqSG+Da3pFUGB2D+MdjViAQeSNLRDRZN6JvHBkf1HVgL7BV1kFbix5KkKZdXKbNOvdRBNCdfeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAMahT6x; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAMahT6x"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2350fc2591dso15861455ad.1
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jun 2025 15:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750976911; x=1751581711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7glFkwmiYhht2UqiHenwImRsN9dIKZyhfzkSZpDnTys=;
        b=KAMahT6xSRz+VDSiFd8XXQu7a3Qp9Lt2ej7pIif/p3Lh0cYYVwtQQ+Z2t3Td74o1CP
         tYUs6zhRaxmIF4s3yFkpzyilY785yaDgn+TwqLppuCCOJksbXcPsfki+Pu4+dB8co5z6
         G85aL03ZxuY25MpYQjHF1qF3uY5nAoj6UM3N9ZkRxb1uJTji9lKnuazxMaC+EkoaFGey
         H0nrOiDfxAld9v/3WJwI8ofait9vjQgE3/amrQHKW2arBTvErG63OISUyFK9ig6F2fTn
         93PNuh8XqJHdOKEtxip+/2IRN25NorvgSEPNnzwZaJKUMlXh+klDKGzGjf7skaPpf8SG
         /Zeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750976911; x=1751581711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7glFkwmiYhht2UqiHenwImRsN9dIKZyhfzkSZpDnTys=;
        b=g+CKBLplLdHdnBGI++D6gblw0ZeAb2Ii9lK5NP2zz04Z/49JguUVRA9eMstsfZY5FU
         rv0SDrlNhSt/4Ry9L3c2a7IWlF2HZb8Td+bWAoZr5wuM3CE2Q+Or4pWIw4tn+l98qi3Q
         WL+1yleDbq9XHSwLTkvBlJorwhqjYD/H7YBocv2HfarlMTh5oynIiSx02zeJ06W51fVE
         gM8AxZUOQ8ytKx0fH+hWggzW3nhIerwau3pgKx0B4VRHLuG8F4bcJuWOikr+gXBR6of+
         8cfurgqC1tZPih+RIW76CQDVktbKN1l3fgk1cN0TcReB6+5YyxLztI6EzETEVS9uLA+y
         JGKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmVpa4VYQJVERSYfyTF7dvQcp9ke10Ea0l+a2hjI5Yqi9y0IKp3IuwdR3QgKa7VK+JDf2C5m72mh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVbSOfudA+uJBhPnOT1aBoD5vtAiLrcjrOJlbuh0ccV2gkJPf1
	479TVTFdhnFG2+TH2e3S94dzaQhh6ia/ZdakxIKnsNOQXrbJDHjr0DtX
X-Gm-Gg: ASbGncsqLiZR3hKMQJdZUAxfY1nKaH8q5XlXdAjoL0qWFTDD2eGh1h0lcTTDeeB+FUF
	zSTEMOxwok4ktjyzajsTCqoGjw86cZJyRFFMAY7kyudv6AQhA1RDc7jXE1h0rgPe87YVGtj2uZX
	nQT3uYF4tHqsfj1Pvhj2/ApATsPWdBQB7bLqv+HZZD9DNsok+Nm4ifX61QS/NguPxMKN3wUgoBU
	t6xL7T4bpumtQGzE7nqG1Z4nNwvJpNUEXXNDzn8VHMxUNkx3n0kcAXSWzeCkdc7BX+VG6jJsTub
	Xu5eEI7Mz5rFZvJNpakcY0Ksq8jZiWUDYBFcEx0en4jsWHopO+SSXQpVx6TgP2aOPozlPP5spxl
	VD3+ehoVgs0cPhxGROQ==
X-Google-Smtp-Source: AGHT+IERKAxuYglZ602YznoXS5WYzlxGHsy6vL5DHQrNlWRyuMa8i4Cr/x9YgZZ+r9vALe46nBLCtQ==
X-Received: by 2002:a17:903:110d:b0:215:6c5f:d142 with SMTP id d9443c01a7336-23ac61842d1mr8904825ad.20.1750976910978;
        Thu, 26 Jun 2025 15:28:30 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3c4b23sm870365ad.214.2025.06.26.15.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 15:28:30 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	alok.a.tiwari@oracle.com,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [QEMU PATCH v4 10/10] cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC Release
Date: Thu, 26 Jun 2025 22:23:33 +0000
Message-ID: <20250626222743.1766404-11-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250626222743.1766404-1-anisa.su887@gmail.com>
References: <20250626222743.1766404-1-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anisa Su <anisa.su@samsung.com>

FM DCD Management command 0x5605 implemented per CXL r3.2 Spec Section 7.6.7.6.6

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 79 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 787eeaa7b9..87f9535d46 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -123,6 +123,7 @@ enum {
         #define SET_DC_REGION_CONFIG        0x2
         #define GET_DC_REGION_EXTENT_LIST   0x3
         #define INITIATE_DC_ADD             0x4
+        #define INITIATE_DC_RELEASE         0x5
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3638,6 +3639,77 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
     }
 }
 
+#define CXL_EXTENT_REMOVAL_POLICY_MASK 0x0F
+#define CXL_FORCED_REMOVAL_MASK (1 << 4)
+/* CXL r3.2 Section 7.6.7.6.6 Initiate Dynamic Capacity Release (Opcode 5605h) */
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
+    int i, rc;
+
+    switch (in->flags & CXL_EXTENT_REMOVAL_POLICY_MASK) {
+        case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE: {
+            CXLDCExtentList updated_list;
+            uint32_t updated_list_size;
+            g_autofree CXLUpdateDCExtentListInPl *list =
+                g_malloc0(sizeof(*list) +
+                    in->ext_count * sizeof(*list->updated_entries));
+
+            convert_raw_extents(in->extents, list, in->ext_count);
+            rc = cxl_detect_malformed_extent_list(ct3d, list);
+            if (rc) {
+                return rc;
+            }
+
+            /* Fail with Invalid PA if an extent is pending and Forced Removal
+             * flag not set
+             */
+            if (!(in->flags & CXL_FORCED_REMOVAL_MASK)) {
+                for (i = 0; i < in->ext_count; i++) {
+                    CXLDCExtentRaw ext = in->extents[i];
+                    /* Check requested extents don't overlap with pending extents. */
+                    if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
+                                                             ext.start_dpa, ext.len)) {
+                        return CXL_MBOX_INVALID_PA;
+                    }
+                }
+            }
+
+            rc = cxl_dc_extent_release_dry_run(ct3d,
+                                               list,
+                                               &updated_list,
+                                               &updated_list_size);
+            if (rc) {
+                return rc;
+            }
+            cxl_create_dc_event_records_for_extents(ct3d,
+                                                    DC_EVENT_RELEASE_CAPACITY,
+                                                    in->extents,
+                                                    in->ext_count);
+            return CXL_MBOX_SUCCESS;
+        }
+        default: {
+            qemu_log_mask(LOG_UNIMP,
+                "CXL extent removal policy not supported.\n");
+            return CXL_MBOX_INVALID_INPUT;
+        }
+    }
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3772,6 +3844,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
+    [FMAPI_DCD_MGMT][INITIATE_DC_RELEASE] = { "INIT_DC_RELEASE",
+        cmd_fm_initiate_dc_release, ~0,
+        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
+         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
+         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
+         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
+         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
 };
 
 /*
-- 
2.47.2

