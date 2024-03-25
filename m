Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9781F1C02
	for <linux-cxl@vger.kernel.org>; Mon, 25 Mar 2024 19:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393463; cv=none; b=nAmHxKae7GowcCSwP7ZVwKrM5qlMuaq8DxB8mNwOcrBh7BYyZo4VLovlRT7qYacnygKMi3FrK4jFDz9r8axz/0ui4Sn+s7NICSMdam0ZpKzhANBGNxcDzumZlTUyi9JMICa4gYcOoGPkCRNO5Z583CDFIXazfE8GYbgvXA4sJb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393463; c=relaxed/simple;
	bh=wy6mbTMBMsYfurZCiVtXv16F+h19N9tY2TYxi6DUmjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sADvpDD3HKZsCJ9+58Ayn9IKejhcqJSU9Vj6VlTj1kzj9e+Uc727PRKYLaBo3Lvc3AKb+M9BsfgBU9Z/ZCaNOkLqfX7bxPGbvrs2YT7mL7Cj4CBTyBoY0xPt9r8838uh3hohJEYA827ZZsoH00TB1zrA4Gz+vION80FoVS7jKv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESJiMrVW; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESJiMrVW"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e04ac200a6so32868965ad.1
        for <linux-cxl@vger.kernel.org>; Mon, 25 Mar 2024 12:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711393461; x=1711998261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xakP/WAiR69d8B5B18gJ85sFdqfiQ0c6HHa8yXwoSyo=;
        b=ESJiMrVWFVbFu1ktzZzbv0BwovYRSmnrivUlTuNPwwg17eyiNS/TT28TWANlaMYkQg
         o8xlcS6yPM9+akOFtGMqhf8jz73PM0TOlMKIgGxKmisONpNuzqR6Mnvvmj48wmTsdMrY
         bgqfMPDWlmFhCqsYJbffzVlux8AKfUFXhGBVuDCH3tzvII1GVQo7XJIEC7taS3epNoKD
         +vDXr2u42sQgr4Evzg0Z3I/N5VCjqrtdcallllVKcYe1kVOcIvr8EmmOR9GkwOlVeinO
         +xim99sLacix+02jILRlfq9qYaICiEPQ/SgRbJZqZ6EwSBKazlkz3QqZf9+ZeB+wCWIV
         sRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711393461; x=1711998261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xakP/WAiR69d8B5B18gJ85sFdqfiQ0c6HHa8yXwoSyo=;
        b=DPcMeI3Y3/Jbg14vJgr2H2nrxvwgTzltutw5VQoXLvvQtOn6wWci+OhSyBqERQlhPv
         Lufdh5ix83ZhMjGTo7vdj4S+DrAX7RxknbTotTwQ9vIiEzIKNkNk8DI5JTyZ1gTuODP0
         mMhVCLxcYSo6hIIjiR/xoRWYO5ZZ8NqEDIoyd4oRbbuNTemhvkKXaFN2wteMvdPv5mll
         v9MPt6ng4BIy75ZhkxCfaGE03/5v2emDOcAy/mbMfVJKLK7I2FaeHm+L1pJJVQHRAf6V
         barsMf3fC7Z8APiK7GIzLd9hzUhCE6OcdWgGmvGDRptCe2ej3/4VDykVuhoobk9HUBBa
         mfmw==
X-Forwarded-Encrypted: i=1; AJvYcCV1qCUD7eGoq1lAK+Yek3IRU9NkmkDMiKM7kLMZaf8qu20+gXT+BMOXKbQqEfhOvUzQFaM4ZercmHg0jx31yBvpyNeAXce4PrNe
X-Gm-Message-State: AOJu0YyD7a/h0o3KCQr8+qBXcaaZtwZyjcf3ci64yG3GA+l1i9oKfTaN
	awpzLwBF8vNsO3cUc+adhthoycJ+FSxHvSSFrueYveIWtyCIMgN6
X-Google-Smtp-Source: AGHT+IHIlRLO0pl+CVLunHEPlD8oj7IDD/ym0H18wHpotJXetvT29Z/tMxVqVBK/ih6+S4JVauRffQ==
X-Received: by 2002:a17:903:22c4:b0:1e0:c070:b082 with SMTP id y4-20020a17090322c400b001e0c070b082mr5039024plg.14.1711393460732;
        Mon, 25 Mar 2024 12:04:20 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:7bed:2ef:bead:18b])
        by smtp.gmail.com with ESMTPSA id z7-20020a634c07000000b005f05c9ee8d3sm1722663pga.93.2024.03.25.12.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:04:20 -0700 (PDT)
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
	Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 01/12] hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output payload of identify memory device command
Date: Mon, 25 Mar 2024 12:02:19 -0700
Message-ID: <20240325190339.696686-2-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325190339.696686-1-nifan.cxl@gmail.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

