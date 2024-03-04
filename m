Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CBB7994A
	for <linux-cxl@vger.kernel.org>; Mon,  4 Mar 2024 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709581449; cv=none; b=D64aKw94XP4VvYBBU34QJECNxJ3EfLbGxhX+qSkZlvMK2CUx1+yRMDx948yw3VczWYJUxc5E5kvgQ96MljK2hS7XA8yCBwJSVVR/E3VVo3AEiZSCxsRN84wJ5oXyYFn829A9ZAIbeAcEAZfNk1bjhY9kk9aiyIjFNQ/SY0QOitg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709581449; c=relaxed/simple;
	bh=gkUBdmYA71Hv10Hl86RlZ3WRrrRHuAjCA/UFYnu1kv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDkS4dNegcS98xG5EAsa02V9sF9B4L3/PgpUA/y2aWRtPYDMYzdWcE37p2ufLS0RAXPoW05HdJjiJRQNuwbYFM9Q6UMLg08n++UZw/PV4REKj+bSiuL4KuTOE+DqTRE5TMwASCjoRIsC0Y8LASrclrIaiww4mOn06SBHjsfa0n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1jHr44S; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1jHr44S"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dbed0710c74so4372311276.1
        for <linux-cxl@vger.kernel.org>; Mon, 04 Mar 2024 11:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709581446; x=1710186246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkPmI8FuszQzNKc/W7C7bH++18bz1caF1vBxyxTADMI=;
        b=N1jHr44S33fMwvuJJjgQMLNpGwxr6DUzG6z/DeZ9NHINMtpCHvvqfCwF2wLUHmoeg6
         /g5H9ZgyuymUE9JcO6yOUksK7JmeIZ3gnxqGsj6iN+IGRCN8yjZsf6afxGy/cNh30/Bs
         JNcLMhLZIXl6y4EaGNdBn6hvW5pA8ZyTvvyNE4ORpjJZkQ5DEPKdZl2HXnapyRbNyRik
         jA5HPGCzzzAf0E6NyCCuiTNJHuF8KzuGKdsjmhbkrYucqs6r/QjwfMVfeRTjLuEUxGIx
         748A3x3HPjjmA5UDEzL5tux5vRDSufC/F5NWdFgNr5hZgQSWRH63+1V7a/jIsqJaL+DG
         w+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709581446; x=1710186246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkPmI8FuszQzNKc/W7C7bH++18bz1caF1vBxyxTADMI=;
        b=nhtWIFHmj2rnWlScOQzKmf5y2AFo5fdWh7eNlXBPdX3w8TNsxU30/ycuRPKCP1CQ1q
         lAnKu5f3XTr2kAXztr9T+O7Rkv5hlfNiciUdSNSdH4iloi+mIhqrFlLI2PTPm5V30Vo7
         ITeDUPbadQE7d9T/FdjC3VZn6dZZ1PaKpBfY02av1/9Tn3Xidxk2IkBvQ1V4Eq85YBbR
         zLHGo0N7eti/IMR8TgcdY+/PmkQa5b2O6cfGB+gg5KZ/06AQ+68UMxaxitQFL9LGhXyX
         NmVFZC3q009/2SwtrF20JuZVq4GW8rCewVfWNclmgf7xuMTM/prtEqugFGL9vsESeGtz
         8dGA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ9ukyZJRVJM8aDfVVSe8K4nEWrqQApCnEbXRj4OU4TH93MPx7vKXabdlvl1HQiPoJx+kNuWCdDcA5yBYo0gUNhZ+kPLJfwKgb
X-Gm-Message-State: AOJu0Yzr0u3rumSJT3aQs5tiKA6smGq8kfTZtjP6GiWjngceRRoLujPD
	5hpENW6lWKND976NnO5eT/WDzJMJDnIRdRrXsGrLxEztXQFICWuN
X-Google-Smtp-Source: AGHT+IF8Ycb0Ig4cvVD+KZC7NiE7FpVTQX5T1d6xPH2bLLUEk6Pr5KEZbkD4FKZ2xmlpNCQuOqLiug==
X-Received: by 2002:a25:b109:0:b0:dcc:6112:f90d with SMTP id g9-20020a25b109000000b00dcc6112f90dmr7174783ybj.62.1709581446482;
        Mon, 04 Mar 2024 11:44:06 -0800 (PST)
Received: from localhost.localdomain ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id h1-20020a255f41000000b00dc62edd58dasm2282646ybm.40.2024.03.04.11.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:44:06 -0800 (PST)
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
	Jorgen.Hansen@wdc.com,
	wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v5 01/13] hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output payload of identify memory device command
Date: Mon,  4 Mar 2024 11:33:56 -0800
Message-ID: <20240304194331.1586191-2-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304194331.1586191-1-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

Based on CXL spec r3.1 Table 8-127 (Identify Memory Device Output
Payload), dynamic capacity event log size should be part of
output of the Identify command.
Add dc_event_log_size to the output payload for the host to get the info.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 4bcd727f4c..ba1d9901df 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -21,6 +21,7 @@
 #include "sysemu/hostmem.h"
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
+#define CXL_DC_EVENT_LOG_SIZE 8
 
 /*
  * How to add a new command, example. The command set FOO, with cmd BAR.
@@ -780,8 +781,9 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
         uint16_t inject_poison_limit;
         uint8_t poison_caps;
         uint8_t qos_telemetry_caps;
+        uint16_t dc_event_log_size;
     } QEMU_PACKED *id;
-    QEMU_BUILD_BUG_ON(sizeof(*id) != 0x43);
+    QEMU_BUILD_BUG_ON(sizeof(*id) != 0x45);
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
@@ -807,6 +809,7 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
     st24_le_p(id->poison_list_max_mer, 256);
     /* No limit - so limited by main poison record limit */
     stw_le_p(&id->inject_poison_limit, 0);
+    stw_le_p(&id->dc_event_log_size, CXL_DC_EVENT_LOG_SIZE);
 
     *len_out = sizeof(*id);
     return CXL_MBOX_SUCCESS;
-- 
2.43.0

