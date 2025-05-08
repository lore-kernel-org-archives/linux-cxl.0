Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2330F3207
	for <linux-cxl@vger.kernel.org>; Thu,  8 May 2025 00:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746663537; cv=none; b=K9v039G+P9MQAgMKHezPvs6XkPQGk7jOx1ubEhSdqNaZw2jy3kPh3sLep0XrxachMCyR/xYAGzrNHeoKfWKiA941C0jESaHUrsrlNsf4gXlxe+gwyJ+k1LMAuhyqhMfei2RQUm8bfG+2iRCRMlInihcR5F4djgGRSmBihnLl3N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746663537; c=relaxed/simple;
	bh=0f2VriXAmHMUvqOhtpotoAp+fjm73QW/sfbL/dTRSIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbR6CxyMG+doWWM0m/BJkytdGj4PnEebseNw+NBxpPQb63ehg5wjIelcFaNF0NKbjwFF2UWWT8gAApKimtxXlr6uQ8VQnX8XFN/GZvFm9fHZfZjOc1na9LhlHQTUs2e1eqftCTKm71ifJa/p4njUTGc5kVHQW9P5DzgwdEZK3wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3A0wcAe; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3A0wcAe"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736c062b1f5so535020b3a.0
        for <linux-cxl@vger.kernel.org>; Wed, 07 May 2025 17:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746663535; x=1747268335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoNEXMDldpkF71Yld0esCBvC3wY+eEKFQ2RXqToFtnc=;
        b=l3A0wcAeioZAUUlVDZ3XYoWabF8NKqy5lXPiXvFW54V6BnL4D8hiFhlOu5V/dDQ/sI
         KRByzz/Cs5w2cP2gDvnwaGY1HHCvqWpXSUanJ6aonxKPa+Ab5xwthHnlXAT7N4oG/Ysf
         KB5kEcqDcEbq2c4FPAiO7DWz9NDSgDe8RHxix8/+uhMsPn7cIgn5sKByyzk0ik5Nuz0a
         Yl3FZzoZrv0QiwUs0vEYFO8fX1/PCbYhl0ueu9kMlMvCcgrh2aqJ99o1fuy038gqtbHo
         /XnIhyzjrBG0wU75J7XWLKpZUtJgDY8vJ9vkEXRfazB4BHkJzcdxPTAyoFPgwzVwGGUa
         LBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746663535; x=1747268335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoNEXMDldpkF71Yld0esCBvC3wY+eEKFQ2RXqToFtnc=;
        b=cKDjDyw8amGkKWdXXUYeDujs00cxZ11Wj1+m8Qvy2bks0nODsv03/8yzLmy0l4Ac0D
         cSogPLxC1U+AWG+zXyy5LNzV8rMbDgceEGyDtMXByvg65UoI8P8y7Cc7SlFqfm5FrID5
         CvV7311KEiaRuRizdkHLFccghJcpfnaDvmL58jQfodnLHMbpolayEfgjbwYP8tfg2x9Q
         AWDmpouapuiYxZtw0OfHuT/cmlirPIICNC+HF9NZI/NXiMgHRP6gaVRBJ+ukkVpqzgnc
         wRwu814Wov1lpen/iI4zpLLjVUplRPxd5fgpPiv1I5X8I00JdabUARBKiA8TC2KXcFJw
         BC1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2jHtQX0wsrAN4kF5IznBVMS5Eg76BfE56Od1kRNyiQLeuSmguO4PlubGfLvRPBV3FRyoW94MZsCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAc53xtS9KQchAjtegJsAPersW1iqvPGgdg0hF740Pm6hMcyu8
	bK2BKhXKoEyy065TIHrrSTR1EPwDuyhcBIIc7arBgojft9zg7tUU
X-Gm-Gg: ASbGncvVezy5hEEuzSbxCcxVoPLO6/NHRZtzwj2cUmnvqgzgoynWEHmAN5yD2rKI8qx
	KNNyEW6jL34rCG9mhtZt+YV6XhuQEE8+dDjKB5K0xpRfPpdU7v6xjJjd25Q9pnFxlVK72w9lnAz
	4LQ1fCgTgE9Cy3tT98mNryGqstLLRAyFq2X0FVKVLBnVNnFWS8AhOEReuvZtu98y66URAPeDCM0
	+5awgoAs9jb5uz293hOdp/LCaqkVlD7huSYmCDG5sZNfrMjq4C/ytZUXWyySocI3Xwdpr/MC9rl
	80gceLeIOYgly7Hs2bMi1TbVvLPweCoVyFIbGyY32KG888jduZJQdcxytif4UC5IhvVYLGE0
X-Google-Smtp-Source: AGHT+IFTYn/CQgyZzBOVhEQ/fxJc7ir1WqKkKSaJV9DJzJBUeo1khH9iM7ucvxHOFfJ5tzh85C60sg==
X-Received: by 2002:a05:6a00:3385:b0:740:6f80:88d1 with SMTP id d2e1a72fcca58-740a999336amr1838461b3a.9.1746663535285;
        Wed, 07 May 2025 17:18:55 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405902167csm12378724b3a.98.2025.05.07.17.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 17:18:55 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v2 08/10] cxl-mailbox-utils: 0x5603 - FMAPI Get DC Region Extent Lists
Date: Thu,  8 May 2025 00:01:04 +0000
Message-ID: <20250508001754.122180-9-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250508001754.122180-1-anisa.su887@gmail.com>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anisa Su <anisa.su@samsung.com>

FM DCD Management command 0x5603 implemented per CXL r3.2 Spec Section 7.6.7.6.4
Very similar to previously implemented command 0x4801.

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c   | 75 ++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_opcodes.h |  1 +
 2 files changed, 76 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index fe38a13f71..a897a34ef9 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -3516,6 +3516,79 @@ static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.2 section 7.6.7.6.4 Get DC Region Extent Lists (Opcode 5603h) */
+static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
+                                                   uint8_t *payload_in,
+                                                   size_t len_in,
+                                                   uint8_t *payload_out,
+                                                   size_t *len_out,
+                                                   CXLCCI *cci)
+{
+    struct {
+        uint16_t host_id;
+        uint8_t rsvd[2];
+        uint32_t extent_cnt;
+        uint32_t start_extent_id;
+    } QEMU_PACKED *in = (void *)payload_in;
+    struct {
+        uint16_t host_id;
+        uint8_t rsvd[2];
+        uint32_t start_extent_id;
+        uint32_t extents_returned;
+        uint32_t total_extents;
+        uint32_t list_generation_num;
+        uint8_t rsvd2[4];
+        CXLDCExtentRaw records[];
+    } QEMU_PACKED *out = (void *)payload_out;
+    QEMU_BUILD_BUG_ON(sizeof(*in) != 0xc);
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDCExtent *ent;
+    CXLDCExtentRaw *out_rec;
+    uint16_t record_count = 0, record_done = 0, i = 0;
+    uint16_t out_pl_len, max_size;
+
+    if (in->host_id != 0) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    if (in->start_extent_id > ct3d->dc.total_extent_count) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    record_count = MIN(in->extent_cnt,
+                       ct3d->dc.total_extent_count - in->start_extent_id);
+    max_size = CXL_MAILBOX_MAX_PAYLOAD_SIZE - sizeof(*out);
+    record_count = MIN(record_count, max_size / sizeof(out->records[0]));
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+
+    stw_le_p(&out->host_id, in->host_id);
+    stl_le_p(&out->start_extent_id, in->start_extent_id);
+    stl_le_p(&out->extents_returned, record_count);
+    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
+    stl_le_p(&out->list_generation_num, ct3d->dc.ext_list_gen_seq);
+
+    if (record_count > 0) {
+        QTAILQ_FOREACH(ent, &ct3d->dc.extents, node) {
+            if (i++ < in->start_extent_id) {
+                continue;
+            }
+            out_rec = &out->records[record_done];
+            stq_le_p(&out_rec->start_dpa, ent->start_dpa);
+            stq_le_p(&out_rec->len, ent->len);
+            memcpy(&out_rec->tag, ent->tag, 0x10);
+            stw_le_p(&out_rec->shared_seq, ent->shared_seq);
+
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
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3649,6 +3722,8 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
          CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
          CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
          CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
+    [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
+        cmd_fm_get_dc_region_extent_list, 12, 0 },
 };
 
 /*
diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
index ed4be23b75..ad4e614daa 100644
--- a/include/hw/cxl/cxl_opcodes.h
+++ b/include/hw/cxl/cxl_opcodes.h
@@ -65,5 +65,6 @@ enum {
         #define GET_DCD_INFO 0x0
         #define GET_HOST_DC_REGION_CONFIG 0x1
         #define SET_DC_REGION_CONFIG 0x2
+        #define GET_DC_REGION_EXTENT_LIST 0x3
     GLOBAL_MEMORY_ACCESS_EP_MGMT = 0X59
 };
-- 
2.47.2

