Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DD285268
	for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539674; cv=none; b=JshtV3wYqkW+t68Xeh+u+BBwKUMxDOwYzuXy+UL0SdzpZV97ItA0AhepI+TVtJAi0NZ5prOpYcHqXQoj6thmHk14xHnhI/fm3tysSDNaUjucna6eH4ASnIhYk8TXk/Qa2iv2rwflau7LeeeGmbS1jlbZMUKumoGB3uvOj2xDbug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539674; c=relaxed/simple;
	bh=gkUBdmYA71Hv10Hl86RlZ3WRrrRHuAjCA/UFYnu1kv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TO1/DRNZeRIo9r3nJgaS+UKVfQHTK83mO6r2vF/x8/7IW4IV6hyIxEKSViuwlJ57eSlsKsPa3SMLGZUDtkJUIFREVT46KzlL234cF6I4g5WmnyWLF1oHVMtuw2ki7sa0dqba4ueXyMqvaysjR4QMMVMgdDosl9q2udrMZkIgbcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4ytpgIE; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4ytpgIE"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29996cc6382so2688455a91.3
        for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 10:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708539672; x=1709144472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkPmI8FuszQzNKc/W7C7bH++18bz1caF1vBxyxTADMI=;
        b=Y4ytpgIEUI+pHinWO2xyAzdKFtNkVOdq5kDp6yeAqK5FbibSY+OmM3Vkpm74PiZfqf
         NrwCs7kZov+EI8IavimBIYmRavuH75DIEXv9U9BCBC/0FTmD6R979p/7xpn9e3ILLRFT
         ZwFj8T8yldyGBPtsKvsjC6TAb6CbyZhDPrqUFIrxMlsAb2NsFvvASp3grwW+NTjb9TI3
         99ikZlJpS3fV/dYyp6NJD+IuiR1lVJo2hHoyS6sWfOWYF3YHz8fzZmEWHp2Y8A7xGJ3c
         RM3lrr+l8woC07ZZG5F9vVlEtSmueVV2ssa8277jJTP4Qmx2nay2KweTDRQbDCet2gQR
         /AUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708539672; x=1709144472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkPmI8FuszQzNKc/W7C7bH++18bz1caF1vBxyxTADMI=;
        b=jZwQfKEk9mx9qYeiXjWwjUDwGbiDNfUyw6Fyfc/+ZJuZlmJTAP7T7Po1Jy+VehIpEk
         YkX2A7mUIoZSemkTe9eCATeE8ZHMqoDP2RDSsZ0IfMzbyxJtaWwUE+adVusIrZ4AilIo
         II/mqE4zItKSvMH1HB2CkyZiyxIDS5EWlBUId4HTM6Rrv9nn94hnXqm6sdUxoCf7lqlr
         yT6PiAoA3Hi6zr8K9fFaFwkCPp/TWol4RwpMYU3Mb6akp68eNBR2DdlIU4BEhMkqp6r1
         FFbS/KpCe9tH7Bz9xS4FBhhs+MpKWw/BNp/ThI0tfjisZZK9S9BQYa8MXHlMRtm84Te1
         pwbw==
X-Forwarded-Encrypted: i=1; AJvYcCXo3xffJnNj/fVaeSOvbtURMLNYXrNu2MjYldbKXSVRt4EIeoxXHVS1kLC7UJ4Vgk2SfgvWyD/geQb5248B5WZs/qVBfO/LcbIy
X-Gm-Message-State: AOJu0Yw7E1lGXwuIUwUn5gR9y2V6bS0NJ4Uk08TRd83N7YO/0EG5clA5
	pTQNbOwvMRllXxG172QC3U0WEwj36VelyGvmxy+OoRd8siPN1vqO
X-Google-Smtp-Source: AGHT+IFMcnQh5f80Wkda3K0vH+ueICO5TJY8WkNFGkF0tVy5RzTaPhNg7QC/g2xsj8usX4PLltMs+Q==
X-Received: by 2002:a17:90b:1e47:b0:299:2241:820b with SMTP id pi7-20020a17090b1e4700b002992241820bmr14945559pjb.37.1708539672173;
        Wed, 21 Feb 2024 10:21:12 -0800 (PST)
Received: from localhost.localdomain ([2601:641:300:14de:5692:7e41:13a2:69a])
        by smtp.gmail.com with ESMTPSA id cs16-20020a17090af51000b002992f49922csm9979009pjb.25.2024.02.21.10.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 10:21:11 -0800 (PST)
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
Subject: [PATCH v4 01/10] hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output payload of identify memory device command
Date: Wed, 21 Feb 2024 10:15:54 -0800
Message-ID: <20240221182020.1086096-2-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221182020.1086096-1-nifan.cxl@gmail.com>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
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

