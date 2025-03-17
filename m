Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C58A1A2846
	for <linux-cxl@vger.kernel.org>; Mon, 17 Mar 2025 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229820; cv=none; b=QDZwfTNGiutA9bt+/BhGCEh8KhiZYEdFgz4DIY510igI6XmOHIjxO4h5Z/LcaCiEzpXQMLvgIB99UUvMiHI9h1kX2AXSvXDpDYBSia+UxGcEHLPMCD777EQlw/u2kTP96pQx0pEANDayC/qgmL+TNLbUvGmYDtNAFT93zc41KBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229820; c=relaxed/simple;
	bh=DXpHVI/JnQ4eadf/XpMZZMCMbNEKFAedD7ipTBkYxDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxSl4xzMnu+roAeN2dGOaraVqPrIVyqr12XDTxP5g5VUURWx+Y6v6G9/3Cx8rR+ph8grbkmADSWCIywsK3pCNXlTUd0Gw9cv8R1BO/lUck9Dfai4NMwEQh0W/VH/Re1WwIWTMXX18cWomaqNPWrU7Yr/knt3wUwaRSgeTpDX/OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GF1teVNv; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GF1teVNv"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-225d66a4839so56114635ad.1
        for <linux-cxl@vger.kernel.org>; Mon, 17 Mar 2025 09:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742229818; x=1742834618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFCl+PuL71rwLfqWjVxR8UqDMsn9wX/Wj1FpBaxlxKs=;
        b=GF1teVNv/IpoRNC8i0M9EX8MMBmrOs0Bu+VC4R6AVZ5iftOXpl2ifr4p6SoXnKIL6/
         tpc7mM6bfD8xMSDCUfn6XT8DCD30ucpNL+Q9GqaHH0Kp2RaPCxbJXn3fj5/yl/nfJOOX
         0opDm1nCU6a5GVPb63PuFJ/7oeteh5I4JsI/7wjPP1MDEEqz6r/gFmJ7+L5dXobvsN8k
         qCBeqNNe0tSWlQ2k2VXb/8TN+/aQF/FxiBpEzbVMRA7Dh46jasZfRMK7DNWAIHN+VvR3
         NGJeUZJUtntxnHCmIF5sYuzAmS7w1lpAfNSivEvUcWaOvRkV5YLrErla65isJqNQ0me8
         W8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742229818; x=1742834618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFCl+PuL71rwLfqWjVxR8UqDMsn9wX/Wj1FpBaxlxKs=;
        b=rX4xzOpyeT4Vny9qbNLV5SDlz0X+Dza+ocvZiHICPQ3NoU9vSbXGDIoxB2zgXkLAs4
         /oH2PSkirvJDGiL+kdg5mrE0vAddj+wpoGPLtM/JEoR5A2y2zTRWmy5Eiw9+yjqyAf7/
         sH/YHicWxbYua4qYHLWiNRZk9sbEjo6hpuNXK8n7NpBY0AsopjLWv1XdFJSmPuLxdV3y
         aVH3cG38QZz0y5D2NzzYiFgCqdD8Xd5wibjY8a37bQUipVND6GuZbJudGoTb9RiViVVE
         EoHsMNOPDpps3XgCUXrEIAJxnDMSCqmIoS0hdRqCobKv2cN2SUevTvR2kj5kwUg8GMmO
         RY8A==
X-Forwarded-Encrypted: i=1; AJvYcCXRsvxMpwSvTK/27loFFi+/iswwyca5JIbxOztlfX8GwvNsT4tEgX7W5XxbOdQ4omHMMojfVARUIa0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt7i8Xi8N+5p5YgrQwLz9VS2hckah4+FRnxnYaNkTtg3n3mrba
	siQ8B4mgZtpEHh5uTCpxLt1sq/vCQdX0CkxfZWCfUjmJBy/mITZd
X-Gm-Gg: ASbGncvHA+OfC8zrRhwtfQbwhnUcJGl8iIESs4ERRiO1Nb0w52lcN+jFHiYmDI5uSkF
	Cpay3qcMRHcbMNTGiVFJ7orpHAbGxOJA7+/dRXybWzbo10EvX1yT+e/sZ98Izg879QmTPINcRpm
	43krnfvBQ0YegePCuer97fiReB51vUQQEUkoD4joEPoMUP9uROf08/9YLCIDoOme+P+mAObDEKc
	PNubRvvFOn4sX6hBmeLenZc/fYJjKj8x2vtOS4OfYp4mHIq2L2tO9nCZ1o5YQbSMF4H3OfIYpv9
	0BQLlFpu4fqc4DmXqm03+HrHXW1zAzOB4RaVue9qCuYY//fBxzJuDtkUHLUOiPl2mg==
X-Google-Smtp-Source: AGHT+IEyirkL/BekZ2sWuYBKXsGbAnndgmUTBSB4qasF2yNHne2DfTlFWrpxNJXBQMHxhsjOyLsxtA==
X-Received: by 2002:a17:903:228c:b0:226:194f:48ef with SMTP id d9443c01a7336-2262c9d26d4mr1856565ad.13.1742229818322;
        Mon, 17 Mar 2025 09:43:38 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6888461sm77810085ad.23.2025.03.17.09.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 09:43:38 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH 2/9] cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
Date: Mon, 17 Mar 2025 16:31:29 +0000
Message-ID: <20250317164204.2299371-3-anisa.su887@gmail.com>
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

FM DCD Management command 0x5600 implemented per CXL 3.2 Spec Section 7.6.7.6.1

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 67 ++++++++++++++++++++++++++++++++++++++
 hw/cxl/i2c_mctp_cxl.c      |  6 +++-
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 1b62d36101..e9991fd1a7 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -122,6 +122,8 @@ enum {
         #define MANAGEMENT_COMMAND     0x0
     MHD = 0x55,
         #define GET_MHD_INFO 0x0
+    FMAPI_DCD_MGMT = 0x56,
+        #define GET_DCD_INFO 0x0
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3341,6 +3343,62 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * CXL r3.2 section 7.6.7.6.1: Get DCD Info (Opcode 5600h)
+ */
+static CXLRetCode cmd_fm_get_dcd_info(const struct cxl_cmd *cmd,
+                                      uint8_t *payload_in,
+                                      size_t len_in,
+                                      uint8_t *payload_out,
+                                      size_t *len_out,
+                                      CXLCCI *cci)
+{
+    struct {
+        uint8_t num_hosts;
+        uint8_t num_regions_supported;
+        uint8_t rsvd1[2];
+        uint16_t add_select_policy_bitmask;
+        uint8_t rsvd2[2];
+        uint16_t release_select_policy_bitmask;
+        uint8_t sanitize_on_release_bitmask;
+        uint8_t rsvd3;
+        uint64_t total_dynamic_capacity;
+        uint64_t region_blk_size_bitmasks[8];
+    } QEMU_PACKED *out;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDCRegion region;
+    int i;
+
+    if (ct3d->dc.num_regions == 0) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    out = (void *)payload_out;
+
+    /* TODO: num hosts set to 1 for now */
+    out->num_hosts = 1;
+    out->num_regions_supported = ct3d->dc.num_regions;
+    /* TODO: only prescriptive supported for now */
+    stw_le_p(&out->add_select_policy_bitmask,
+             CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE);
+    stw_le_p(&out->release_select_policy_bitmask,
+             CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE);
+    /* TODO: sanitize on release bitmask cleared for now */
+    out->sanitize_on_release_bitmask = 0;
+
+    stq_le_p(&out->total_dynamic_capacity,
+             ct3d->dc.total_capacity / CXL_CAPACITY_MULTIPLIER);
+
+    for (i = 0; i < ct3d->dc.num_regions; i++) {
+        region = ct3d->dc.regions[i];
+        memcpy(&out->region_blk_size_bitmasks[i],
+                &region.supported_blk_size_bitmask, 8);
+    }
+
+    *len_out = sizeof(*out);
+    return CXL_MBOX_SUCCESS;
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3462,6 +3520,11 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
                                      cmd_tunnel_management_cmd, ~0, 0 },
 };
 
+static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
+    [FMAPI_DCD_MGMT][GET_DCD_INFO] = { "GET_DCD_INFO",
+        cmd_fm_get_dcd_info, 0, 0},
+};
+
 /*
  * While the command is executing in the background, the device should
  * update the percentage complete in the Background Command Status Register
@@ -3764,7 +3827,11 @@ void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
                                            DeviceState *intf,
                                            size_t payload_max)
 {
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
     cxl_copy_cci_commands(cci, cxl_cmd_set_t3_fm_owned_ld_mctp);
+    if (ct3d->dc.num_regions) {
+        cxl_copy_cci_commands(cci, cxl_cmd_set_fm_dcd);
+    }
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
diff --git a/hw/cxl/i2c_mctp_cxl.c b/hw/cxl/i2c_mctp_cxl.c
index 7d2cbc3b75..df95182925 100644
--- a/hw/cxl/i2c_mctp_cxl.c
+++ b/hw/cxl/i2c_mctp_cxl.c
@@ -46,6 +46,9 @@
 /* Implementation choice - may make this configurable */
 #define MCTP_CXL_MAILBOX_BYTES 512
 
+/* Supported FMAPI Cmds */
+#define FMAPI_CMD_MAX_OPCODE 0x57
+
 typedef struct CXLMCTPMessage {
     /*
      * DSP0236 (MCTP Base) Integrity Check + Message Type
@@ -200,7 +203,8 @@ static void i2c_mctp_cxl_handle_message(MCTPI2CEndpoint *mctp)
         if (!(msg->message_type == MCTP_MT_CXL_TYPE3 &&
               msg->command_set < 0x51) &&
             !(msg->message_type == MCTP_MT_CXL_FMAPI &&
-              msg->command_set >= 0x51 && msg->command_set < 0x56)) {
+              msg->command_set >= 0x51 &&
+              msg->command_set < FMAPI_CMD_MAX_OPCODE)) {
             buf->rc = CXL_MBOX_UNSUPPORTED;
             st24_le_p(buf->pl_length, len_out);
             s->len = s->pos;
-- 
2.47.2

