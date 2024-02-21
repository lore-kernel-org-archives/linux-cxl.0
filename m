Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C374A1D
	for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 22:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708553922; cv=none; b=qhTQSZHb6HaBPU4F4+anNdLBCJ8hvY+ym0JjZXNMUGWWJL8/Q2qbA5TLKHpSV+YxPrzlBrdDnF/Oo97fPEHeZMP8pHjwnGJgHwatFFbTpfwGhMUGuWCpoloSP3zVUEyF+xeeq8uxTdGSNYu+ywPHWaAAOwiqLojbW4RB3s7tHA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708553922; c=relaxed/simple;
	bh=P4W3eF4tuBmXG01lFdWCEbfmf9WfJHUhALJBd77UQmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UNLDmhmmbP/YxLWxMel6s+n6M5N9vfmMD2PTr6I39CH688wSB29CscmLOWX3iINYhV9j0alj3+HAeCUrn/O0ZSQyLikplF9PTV0k0abuh73OLOC7Bb9nGVUIVD+XdPaOFd9+en/9J/+rdCeOLjOi79eRZaZUk2oBM+2G5A64x44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBBK2ho/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBBK2ho/"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e4c359e48aso488837b3a.1
        for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 14:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708553920; x=1709158720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3eOoPoBtiVXDT6AV5oY9oRUy6gnV0e2NQmiQBMRCPgQ=;
        b=FBBK2ho/aYIefuJMDimHTcbZNSTdunZZJGXhX744EHTR//p5qiHc8ViLn8IlU+uHT4
         snL8Zj8FJK5fg2xGnkktAWALl9zedDdaK5nd987VUl0wDPjzSzf51LkRuZ3XH2L4J6Jz
         acfoTmm///Q8UptS9F0ZTgecVL7qnJm/LEyUXCG1yZ9YXonnw4AekpBWtSOkqEaWqdl1
         mBU4B/mHlLtxONKNgYAn1w6iy2GRsmdwY5ZHc0lY5VWmTVzQ1ToMaKkFp2pKxmjLs/tc
         zipgAKuyaGPnQqLzBZjH+SVcj7mDg0K1Jmtzz5aqoNtwTYpDysG/0mOlnodHFwvCTUg+
         Y9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708553920; x=1709158720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3eOoPoBtiVXDT6AV5oY9oRUy6gnV0e2NQmiQBMRCPgQ=;
        b=YRdJm4kvW7ZrBKaZtnoNyxDcrcftA5QYRi5Y8ylrRGSoP8sD6WR8VHoJdMpj6mvU0D
         /iHfYNz1xvkby4hiM6NjrBgbkyL94OmhKAb7vMdCNvt0KK2YTBQ7xA3/AZUC/p3HKIr0
         g1/VUdqPi44b59+DL8JFuQW9eyKZBYiAjTxA7iTN+avbq9kT2XR6LtlYc8jue8/muRVC
         ky2aGuhqi9mg3K3BtlYQFP6Q1vRR/0Xvq71bMMxucRIIqqUqgP6r2VaE++hEq2OmO66F
         p59AvUkXTQW4NNLEbsyormRCtHFL3x5mU7EFA7u9BED8h1/gb5R+JozL+rkzVwXNqu9r
         T+Tw==
X-Forwarded-Encrypted: i=1; AJvYcCX2JwuoPqgk0DvNA0OSHfk5ga/x135B9TmGF/b0FJ/T3tixkiGfc8Zxi4zIs2hZ++RvpIiYlBKsQyaiUDa75yv3UXLK/Fno8Xy8
X-Gm-Message-State: AOJu0YzKhH+zYLvI9z4tG2gLuatSzX+N6D3daglPQwaLAZrLvAKEVzWw
	yzuD63BqM1JfZ+Agu7cngaEEt5WcCPXLksJV84Hkmsu5424rmBbH
X-Google-Smtp-Source: AGHT+IFsr8K1nO/2YAfQgcGS4KCkKl0rtcFgGDEJYzvTIO3VbMJ8KMSGzsH6Rz4SfpK0xt8N3ycTIg==
X-Received: by 2002:a05:6a20:55a1:b0:19e:9966:228d with SMTP id kk33-20020a056a2055a100b0019e9966228dmr16525661pzb.20.1708553919772;
        Wed, 21 Feb 2024 14:18:39 -0800 (PST)
Received: from localhost.localdomain ([2601:641:300:14de:11c8:8961:5acd:73dd])
        by smtp.gmail.com with ESMTPSA id x22-20020a056a000bd600b006e47664b05dsm4635952pfu.212.2024.02.21.14.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 14:18:39 -0800 (PST)
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
Subject: [PATCH v2] hw/cxl/cxl-mailbox-utils: remove unneeded mailbox output payload space zeroing
Date: Wed, 21 Feb 2024 14:18:11 -0800
Message-ID: <20240221221824.1092966-1-nifan.cxl@gmail.com>
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
https://elixir.bootlin.com/qemu/v8.2.1/source/hw/cxl/cxl-device-utils.c#L204

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

