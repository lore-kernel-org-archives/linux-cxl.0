Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76823218E96
	for <linux-cxl@vger.kernel.org>; Thu,  5 Jun 2025 23:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749166966; cv=none; b=o/8L6eUVtGdGw0i/PmBI9zaQZdWsv608eiN82dMF54qTIEKyRUK2q1W4vxj1+WGsCwBkvGeUxTAMLwVyN28ufhTA99sLmhpZmlfqzNMNmEujLsv/CxYzpTOAu7Z/q/MZZSaKfgjKnddJXbWoOtxhZsFx1KIufEy9FrI8YenkpmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749166966; c=relaxed/simple;
	bh=FvGIOXcCOR55g4Y9NqU+eCrZwEtPgVArlcIGHcGg8zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDh07cFpjMf2DL0IP3BlArzpKk2lyXnMcWD+DiZglHeT7JA/RwGp1qAGOEfhgs8RUkVC1G21MSK1gX//mL9NVDhZhValby/4IMBsiH6OLkunh/FNf7hkvzTYLYd8nnp7KzPv7AdJE7FS8QfTCFcukr9uvho6b6ej8/Dxagk4Cc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tcgzl6Sy; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tcgzl6Sy"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-747fba9f962so1405968b3a.0
        for <linux-cxl@vger.kernel.org>; Thu, 05 Jun 2025 16:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749166965; x=1749771765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIr/2qSPqm5D7ejDBEP4TNOxs/6xpDxN+a3iMpOZeX8=;
        b=Tcgzl6SyHs4joPUfOF11uKcJeMezfW0qWK3LaoKLKaD34q5MSBNd3NtpOHm5yGJ7V3
         2reNRXJPlR7MoTgNIXoMgITO4q9nocimTTPTA80qUIYmOX8ecwBEdrd5X2WfgrwOLKXl
         vs+v3OYEzx4XKUpAD3I23iS/nmFyD/96s8fdNUP7isIEhBWlN8BkaODxf50ncu7jbupb
         E2491PsbbpTpmsufeLKxAmVEufCLpQF9CupEQQx08oaoUfXAj603zfDqney983ABF//s
         rXVVZMHl/4nyPowdfbpNJ9pJxWYPaM2wt2qsc320m1PHNHSWMYaImRoRY4MWCpiQVO/y
         FBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749166965; x=1749771765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIr/2qSPqm5D7ejDBEP4TNOxs/6xpDxN+a3iMpOZeX8=;
        b=buSAjFJKkg7AkP3mr2nct4RrE9VQ5hFFiAkFsIdJBELSir8FY83qyqqQOzH3dDgWFF
         A/yVqaRf+YaUzo4OT7y3X37Cyuw7Q4zw4CK3JfcrbdNwgJhg9QYgZgPaLvMfcaqyQLmP
         TTXTBin9SwIjif5BUdMNsqLpTUFvsaYtdROIxbeLd1EMDGzS7Mo7Zw1QzfkTyNvMceIv
         ZrYd5P9Av2BHlxqXMRffA/tH/xE4V2Tw56TKB8msLNV63M7XjQp56HRwfT+QIfWGuRit
         v/Tn25YO/NUVDZil6VrkAvrPbmQtUMPwxFdoG0Xa3vjmDwIhY/EUn8aB9KFujOV6HjAV
         DG8A==
X-Forwarded-Encrypted: i=1; AJvYcCXiO2/uYonC0tGjcKerBnqko5OaiGhTKZQedk6qoHcg9Fbn6TAU3lOcb5yPqKevKtuNHuwH1gDVvRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbYV2I98EPUHySfzuMcT9aGzowtVZdXkYeHUK3lTWAhlGGyWaS
	bcLEIS/oKPyMUahrYwIyYC+u+NstMdlkewGECf5P3zyhmSeZ6Z5g44mQ
X-Gm-Gg: ASbGncs0d/2xzZ3pZUARGa+Y0nbbWmgUHMZP+4W14qOZf2paXo2qDzOB+A6d97qIBIp
	GsGQPFMYXRCtYOW5WFrFssH0EVWf2DibvpmW+zaXTsf4ubDiZRidpp9eu54WjlGesSR3Em/8Mxg
	8hrhfQ+P4HZWfbSNXRR19AuRQTxtC93vWE6bO5N7lhepOTf+OZOtLNl1szE/1RqwHbW1Jk8aMse
	dFYC5VROQGgHNZKRxyg0iRO5x124hvjRUr8zDdMeUTUYwi56nnn5jx2Y1dpWK+10GgO+9wFeVaC
	KSZb+AhX1vlpLYZjvLpG/x7dSU1s1I+p8+6Pl2b3brSe5QAKE8MacgUs2ML7FsO5v6z6TfIa
X-Google-Smtp-Source: AGHT+IFXzk+l4XDIkFhBEz/32lu2jSG/mj1KBR4DKloZp5r7ELS19AopKD8TKtCQirz8ZNZ6zStR4Q==
X-Received: by 2002:a05:6a00:840e:b0:746:1d29:5892 with SMTP id d2e1a72fcca58-7482c25fe78mr437109b3a.4.1749166964994;
        Thu, 05 Jun 2025 16:42:44 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0847b9sm213916b3a.104.2025.06.05.16.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 16:42:44 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [QEMU PATCH v3 9/9] cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC Release
Date: Thu,  5 Jun 2025 23:42:23 +0000
Message-ID: <20250605234227.970187-10-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605234227.970187-1-anisa.su887@gmail.com>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
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
 hw/cxl/cxl-mailbox-utils.c | 62 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 7ee5be00bc..6c57e0deac 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -124,6 +124,7 @@ enum {
         #define SET_DC_REGION_CONFIG        0x2
         #define GET_DC_REGION_EXTENT_LIST   0x3
         #define INITIATE_DC_ADD             0x4
+        #define INITIATE_DC_RELEASE         0x5
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3685,6 +3686,60 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+#define CXL_EXTENT_REMOVAL_POLICY_MASK 0x7
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
+    CXLUpdateDCExtentListInPl *list;
+    CXLDCExtentList updated_list;
+    uint32_t updated_list_size;
+    int rc;
+
+    switch (in->flags & CXL_EXTENT_REMOVAL_POLICY_MASK) {
+    case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE:
+        list = calloc(1, (sizeof(*list) +
+                          in->ext_count * sizeof(*list->updated_entries)));
+        convert_raw_extents(in->extents, list, in->ext_count);
+        rc = cxl_detect_malformed_extent_list(ct3d, list);
+        if (rc) {
+            return rc;
+        }
+        rc = cxl_dc_extent_release_dry_run(ct3d,
+                                           list,
+                                           &updated_list,
+                                           &updated_list_size);
+        if (rc) {
+            return rc;
+        }
+        cxl_mbox_create_dc_event_records_for_extents(ct3d,
+                                                     DC_EVENT_RELEASE_CAPACITY,
+                                                     in->extents,
+                                                     in->ext_count);
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
@@ -3819,6 +3874,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
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

