Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB863589F
	for <linux-cxl@vger.kernel.org>; Tue,  7 Nov 2023 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dby5+OKq"
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD340C0
	for <linux-cxl@vger.kernel.org>; Tue,  7 Nov 2023 10:10:17 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-280109daaaaso4484159a91.3
        for <linux-cxl@vger.kernel.org>; Tue, 07 Nov 2023 10:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699380617; x=1699985417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogYJbqlkzS2Yd8saws9Occt0F7m6RWm2l0bkCCgcR3U=;
        b=Dby5+OKqbdP4/F+fUIUKuRbqmIU7v6wykdJ/aO7ZZPijzpqGUTu/ofkOLlZBDaJk/z
         2d+cGT36B9NwmxR2gAEaUz0XeLjsnUtxuF6U8FlJSTYhla+YJCgOW5RhSyGR0vfbZoqO
         lmX/w7bU+k85ah00eXUuPnIdtFC6DqnNuztOck+tXe77i+6u6Gba2SDDofNOM8a1iAIH
         t5u6DyJnMnjRkFPCTuDPIRktRMJWpDFHRJwb2dtS+jOC0jtpp9C4i29MnRJBYRy4cVpB
         TsXmxkFqYsmW/9btMgP0FSLgQF6d9/z4GuDNYSaPr4DUizR3S5S3ltRTgN8SRV1J8aCS
         XITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699380617; x=1699985417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogYJbqlkzS2Yd8saws9Occt0F7m6RWm2l0bkCCgcR3U=;
        b=Nxm4aVD1E0KeJDBVinBqSb2hn8k5JOEbpqdU3Geyz6YGBDKkG9t9U+63hGrVgjZ1Pq
         dza1A/rGjnWn37yDmsO2lv5XF5BG4tkqrDwXBe/MWodTVTgKun9Y+FpDoGgWVNQcKyyB
         /NcMZqyBIn4yg3c5HqqMsuVE6y0BVRSSIfC2IXbnxCB5cbgvx82c3z2uw29kK9Gt/2gI
         pNZQ4CHlIYxjVRvuNk613QqjleRbb7rArfkwxaktZuwtGlOGrH0L0MT2FPV1GMjEVQjN
         NCQwBYeKeWJgEBppGbWzamJR21jiDz2voXgym+wx3mCzWS1LIaJCSb3peuv6Ix6X0RKw
         veyw==
X-Gm-Message-State: AOJu0YzMb+Zc3SWIQqyOQ1navxwg7SkcI3xAQGRzNgsb41my2Jaj8WOp
	KqMaa2+v9r576RxG+XUhbLGQIIl7upA=
X-Google-Smtp-Source: AGHT+IFWm9kgjVGfWor3OqA8aZVUBtUhbkrx5BtmA6zSu7sqrwDUHquMPZD7UdUq5z+wxXKrUcUVUg==
X-Received: by 2002:a17:90b:4acb:b0:280:3650:382a with SMTP id mh11-20020a17090b4acb00b002803650382amr22482838pjb.16.1699380617158;
        Tue, 07 Nov 2023 10:10:17 -0800 (PST)
Received: from DT.local (c-71-202-158-162.hsd1.ca.comcast.net. [71.202.158.162])
        by smtp.gmail.com with ESMTPSA id az10-20020a170902a58a00b001cc615e6850sm131924plb.90.2023.11.07.10.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:10:16 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	nmtadam.samsung@gmail.com,
	nifan@outlook.com,
	jim.harris@samsung.com,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v3 1/9] hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output payload of identify memory device command
Date: Tue,  7 Nov 2023 10:07:05 -0800
Message-ID: <20231107180907.553451-2-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107180907.553451-1-nifan.cxl@gmail.com>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

Based on CXL spec 3.0 Table 8-94 (Identify Memory Device Output
Payload), dynamic capacity event log size should be part of
output of the Identify command.
Add dc_event_log_size to the output payload for the host to get the info.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index f1145e9671..8eceedfa87 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -21,6 +21,7 @@
 #include "sysemu/hostmem.h"
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
+#define CXL_DC_EVENT_LOG_SIZE 8
 
 /*
  * How to add a new command, example. The command set FOO, with cmd BAR.
@@ -753,8 +754,9 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
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
@@ -780,6 +782,7 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
     st24_le_p(id->poison_list_max_mer, 256);
     /* No limit - so limited by main poison record limit */
     stw_le_p(&id->inject_poison_limit, 0);
+    stw_le_p(&id->dc_event_log_size, CXL_DC_EVENT_LOG_SIZE);
 
     *len_out = sizeof(*id);
     return CXL_MBOX_SUCCESS;
-- 
2.42.0

