Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8175183CCE
	for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708541701; cv=none; b=iVRxMkKP1bIR4saNabBa863woIN4k60gHZyWe1ufoyIrf1m+zmKrtPujphagB1CKdCUHkd9N3EOkAEL+mgPJejuW2cQw7RhWn2KEK8TGgl6D+eUSMk468uflDkRmeyREYqtT1lpLvjxXgLEwwrwCYv12BUZQX8PUpTgqU71T/5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708541701; c=relaxed/simple;
	bh=uXaYpJu+qgfjIiifaISsGlsWe5yFAnLJ7UhaWBUDbi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=obkmtxWZ7guC4FjdIs8072mCQh+K1SiX0ajMP0JD4qrcSQbePnOmIi36JMvBbOon4JEA5NjHkf77MSe4YefrdjbDIDcqH4o5RczagxLern9W6ukGpuH9i7g7vpBGRfldQPukDMUftgh42XQoJHAxKyu6Cxl1m0c9jUurbe42Bww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNuss8ee; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNuss8ee"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dc3b4b9b62so762195ad.1
        for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 10:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708541699; x=1709146499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mdlWEtI5Vo8QjSOvRxAX8c9GZTRWD5Fjvx9DwxqT0Xw=;
        b=eNuss8ee5LRd5NwmEs7CWyAUbLIM5B1WDThmncXkSdOkpVOT3PWH1427z2ALUbPRqB
         q0JrvHaYJqxWkYGpEGIuLHelgMn++Lv1MGFoCG49JY/xduO2V6yuYuYncA40NjfLfihQ
         qllxBxOO6IDdmUTwB0RdDjE0VOWyxKZ8AvW0rBvdhh012ng9YhXcm9+B52tX86nhPBUh
         5agO/1nc3SPkixkPHtS80iKhYUbZFjK7SkqWS+QJ30OK7teJb/6Pzues69CnVu60hZrU
         26f1Ok8hf/ZhO9kqSC4o3Ls8282jhqzaahFN+/toRckk7+f2k8xC0/FqjjCVVlMsfn9T
         FOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708541699; x=1709146499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdlWEtI5Vo8QjSOvRxAX8c9GZTRWD5Fjvx9DwxqT0Xw=;
        b=HnD48OZ87cTcZEYfUgeM4y66PGJqrr/FI7PizUfM2OEWsvszu2Ki2dQX18X/2G0Pym
         WpvAjhY1pRJKvTESv+3mM0wIrmH8AApUfkcYd1Q/TaJqTe10y+9o+JBia2nVBmJEGAkm
         qyrFZZJyQDfCnnMY/4hn0Tm3WfalPbKeJqem5n+2zluLbSo2exGLPZuaukpNsetRPVWX
         7a29OKX7QVyEUzf+3oXsBur78tv55VExi32WtajcsU9by47bb7VWd+7+Rjma8vVAr2gr
         D5CVvLbOWf6YTafD8gFrFMEa/RgDxrUI1m+NGoXrUgAHENnZsL/OGI3EtN/H8eHhtpAa
         fBPw==
X-Forwarded-Encrypted: i=1; AJvYcCUe4O8/iv3wGBgBzdTD5hUojmPTZZph1aIlcR3HapMPfOHJ5zWZFmMm7u5JEIxVkT+Iz+EYrNfsNZMSRMoOEM6EgsP+WOMkUcgg
X-Gm-Message-State: AOJu0YyH5vuErKHTb9jRAC1MwXEVJZDSjIahMeiZ0eI3jHVc5+aMAifZ
	mBnG/fJYGJjIi1MBJvHIh+XHsfg7Spz7COJ/t9IjmDpME0zz8Z56TqyrOkbb
X-Google-Smtp-Source: AGHT+IE4uqkW4IzNcbVuOJMPESHpvT1GgDJD3hZbePuXMQUvw4Z988HiVxBxNo6qFAZnG3PW7zJ3qw==
X-Received: by 2002:a17:902:c40b:b0:1d9:5563:431 with SMTP id k11-20020a170902c40b00b001d955630431mr518335plk.7.1708541698755;
        Wed, 21 Feb 2024 10:54:58 -0800 (PST)
Received: from localhost.localdomain ([2601:641:300:14de:5692:7e41:13a2:69a])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902d50f00b001db4b3769f6sm8330277plg.280.2024.02.21.10.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 10:54:58 -0800 (PST)
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
Subject: [PATCH] hw/cxl/cxl-mailbox-utils: remove unneeded mailbox output payload space zeroing
Date: Wed, 21 Feb 2024 10:53:44 -0800
Message-ID: <20240221185425.1088766-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

The whole mailbox output payload space is already zeroed after copying
out the input payload, which happens before processing the specific mailbox
command:
https://elixir.bootlin.com/qemu/latest/source/hw/cxl/cxl-device-utils.c#L204

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index e5eb97cb91..fda88470a3 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -226,7 +226,6 @@ static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
     log_type = payload_in[0];
 
     pl = (CXLGetEventPayload *)payload_out;
-    memset(pl, 0, sizeof(*pl));
 
     max_recs = (cxlds->payload_size - CXL_EVENT_PAYLOAD_HDR_SIZE) /
                 CXL_EVENT_RECORD_SIZE;
@@ -264,7 +263,6 @@ static CXLRetCode cmd_events_get_interrupt_policy(const struct cxl_cmd *cmd,
     CXLEventLog *log;
 
     policy = (CXLEventInterruptPolicy *)payload_out;
-    memset(policy, 0, sizeof(*policy));
 
     log = &cxlds->event_logs[CXL_EVENT_TYPE_INFO];
     if (log->irq_enabled) {
@@ -363,7 +361,6 @@ static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
     QEMU_BUILD_BUG_ON(sizeof(*is_identify) != 18);
 
     is_identify = (void *)payload_out;
-    memset(is_identify, 0, sizeof(*is_identify));
     is_identify->pcie_vid = class->vendor_id;
     is_identify->pcie_did = class->device_id;
     if (object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_USP)) {
@@ -597,7 +594,6 @@ static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
     QEMU_BUILD_BUG_ON(sizeof(*bg_op_status) != 8);
 
     bg_op_status = (void *)payload_out;
-    memset(bg_op_status, 0, sizeof(*bg_op_status));
     bg_op_status->status = cci->bg.complete_pct << 1;
     if (cci->bg.runtime > 0) {
         bg_op_status->status |= 1U << 0;
@@ -636,7 +632,6 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
     }
 
     fw_info = (void *)payload_out;
-    memset(fw_info, 0, sizeof(*fw_info));
 
     fw_info->slots_supported = 2;
     fw_info->slot_info = BIT(0) | BIT(3);
@@ -792,7 +787,6 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
     }
 
     id = (void *)payload_out;
-    memset(id, 0, sizeof(*id));
 
     snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
 
@@ -1079,7 +1073,6 @@ static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
     out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
     assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
 
-    memset(out, 0, out_pl_len);
     QLIST_FOREACH(ent, poison_list, node) {
         uint64_t start, stop;
 
-- 
2.43.0

