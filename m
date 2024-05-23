Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36892628D
	for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486524; cv=none; b=kZ3VSvG5eZNIb7jMBC+3vRycJxXuHWuQR7Mxhph/i4ts2pUYIDuGvfK+l/pbs6pjzZhz9ll6M3FRt+r63ttLgN0OChHw2H4lYnfLvAkwhON5Tq31k12rOvXvvgR//a4IfMVyHniAUMq2UCHfgi0AEY9/6QK2yOmAL9mfZwPjFGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486524; c=relaxed/simple;
	bh=/risDllfhBlMLVboc+LuYX1Q2LSBfZmLHCnCciIAFSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgZYdbaCTRhvlF3JmFFAqFKhudGUQw2ze+eWd5Xc+Ne2a88eksUzkewITRGEU6GpYAZgmroGiP4gIfdTfVMM8dNLaliq31ypU+pGP5sofFBVbTRBjb+CgV0jtefwZvWS0CNcuzWAKdvp8MyJFJ7vnZVxupxS8UVvgxtkfB/WfXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGoQfRqp; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGoQfRqp"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ee5235f5c9so122444305ad.2
        for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 10:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486522; x=1717091322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clywKlwl+RTvBV7mwlXItxpVpcuULIu2xU0NldTj1A8=;
        b=jGoQfRqpx+qRyoGEX7ifJYwdWFeYGAtXgzB7yoLKU5Tv4NsRKgg1gMQ29OcVcSf3+o
         qz3MWz0U0XKoJazHHHHmHPh+T+OWIkNtQxIrUXM8vC/m0r3sVllCrpCuMHc0UYiMKHGp
         VrKTRql3Sk+TMntUIkdwNGhPkTnqskClWgOgP/yl8+Fxwe0DTmzygyetCmCV0gjTlLcd
         uws1G658PM4EfybEU947TiTV1AKXrFCFDwYJA+urYnxS4OnPKOMyPyG7eLCSDrkFydZe
         OjMa94tB0ZVSDvzjcWOGVWR8QIzGwJ4+M152DqWGPvM2lv2kco1yFFmZQPQOnB/5MmvC
         rpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486522; x=1717091322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clywKlwl+RTvBV7mwlXItxpVpcuULIu2xU0NldTj1A8=;
        b=SDlp7uoyjoQwoGRLrkrf9Uwabu4p136TobIQn6zv9j8nHg7wslqLFu+ngDXvRzDGnM
         dqCZEAOklsPr9gbA23fI9N8gwqhOQDBiIdcQSvfWoEqNU1A+L5xHhF2f02zEnLtDs+E8
         DA0DgX940ndickTnXPk98qNgi8OjnNKc8U9yws/Dkj7kJ3cwV6+YjzEeqUJjnHLA71oc
         EUJCQUnGzPZrqAFLuOqE68DteD0i3TUyHhDIgmtYoGd72dYJDUfakTOHUx0F+zBQKx3P
         m4cPV0c08EQXcXwIyuEhNMuh7sdKyNb180lxCuMLYMskFAuoHukq0BPFKDTDoMAfG2jO
         nb5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLLjiY1qCrXmFst9VfA6mW+NjoUA8CsRddIMGzOAVuiP5Nk3S8bq4jZ5XaYzQyWI6XZ8Qu/KYZ6/4nzWCZHbTyFya2+1tcw2le
X-Gm-Message-State: AOJu0YzLF25kNMqnVEh5spnXS+nGF8DTbLDPkJyhAJ8JMo5texM98XBD
	Cq2aG0ZqkbzBGshUltCo9DL57WVyEzlLsTIkvs+kDj1UJuOhwViw
X-Google-Smtp-Source: AGHT+IF1+uz93o85wiyhvEHCSjso2zhI95Lq8pWaJRgvaUUckzRdrRduv7BscqUJRGL8LOFeTTZY6w==
X-Received: by 2002:a17:902:e80f:b0:1f3:3102:1609 with SMTP id d9443c01a7336-1f4497e588amr367845ad.50.1716486522306;
        Thu, 23 May 2024 10:48:42 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:4f9e:216e:ed5a:642d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c137e7esm253436265ad.257.2024.05.23.10.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:48:42 -0700 (PDT)
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
	armbru@redhat.com,
	mst@redhat.com,
	Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v8 03/14] hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output payload of identify memory device command
Date: Thu, 23 May 2024 10:44:43 -0700
Message-ID: <20240523174651.1089554-4-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523174651.1089554-1-nifan.cxl@gmail.com>
References: <20240523174651.1089554-1-nifan.cxl@gmail.com>
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

Reviewed-by: Gregory Price <gregory.price@memverge.com>
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

