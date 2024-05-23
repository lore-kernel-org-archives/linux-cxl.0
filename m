Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875E728366
	for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 17:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486523; cv=none; b=QVWn3KmL+i/BxMn0veEbFlIYPk0EGNoXxhup3Ob5aYrRK56ONxnSDXYfVsLg8t5cZB4J0ML5L4oZpPbuu2ZxgpPiGpP/zgFiTsIoi0PefVq39XfNvAlIoHn3IzyQA03ojEVpcuNTXFD8/SKNc7BrNK38dMQCDhv6s29bGvDA4V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486523; c=relaxed/simple;
	bh=UXhoMJFb9Wuvh42x6Hj2fHeZzj4GoOr+zzed6oFENQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+p7J3xKPX1r6h2TDbme7RJuRN0bJEeljRIlxxI1MQ84UrPFx6i5PACzFLPfRZdlJoFkZKBoXCUNjF9mYCj/+62uH7/K7zskH9WfHHiLZ61LTxFFqzE4bBLvtnPgy7CXdmye5U2vO6i0pj2Bv1fD/0ox/HjL9T80sdQqd4YbmLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rwbr6Qd7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rwbr6Qd7"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ec92e355bfso26300775ad.3
        for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 10:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486521; x=1717091321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwLDZR/KWKZ72BeL4YQ5O0fvqFWZ5B2YkSZHDV4y31s=;
        b=Rwbr6Qd7W0011KFCOSSZx0l33ikejipVL6Plf7Mc5VX/hWzsBNHyptj2JRJFp0IZP0
         ap7xdij4iNWh+yW1ZVCBCBQt6h9ou1/95BtsuAKy/LssWI9e5IoDQK5GsFKozitXrd05
         cExcqT/doIyP50yxiunjRW7521ppWRRaa6fHR6ZRSdoICvrLuR+LX5g2pxy7Syzy9PqF
         vuKJTk+e2IWU98NtWvWS2t5WcG3f1pi6h2xCGnlDez/x1NUDCBwFMBzU+H4mu2QB/xgg
         9fLN7+ojNxdkldGryLlW2yViudsZI+MetLMmGU3d5OEOsyFX5Lk2eCYAVSeAAd/dKczI
         rAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486521; x=1717091321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OwLDZR/KWKZ72BeL4YQ5O0fvqFWZ5B2YkSZHDV4y31s=;
        b=KJ8qSc8GMuJ5d1l084Gtynjqhxpq1u1BAWjGZWdDVwwt/6ns3m5P9ZdhfLKE4yPu6f
         Kh7oHkDn2/DXy6kVHSmqhLHR33VC00g3PXfkIWWo+kpXa4npzCKnfU6jbAfhVCKfUpjV
         av/oj23G1X+5qhf+6+oCAdjxx1Se7jaa+iE+ev1Wsa6Ia8moFm3nG5eO9LBST++vNIm7
         qbruedZT6W1jU0Nsdy4Rg2mIQoEP4rO5HSA9sCzYwlekpDgSyuUBfutiFae8rucrwAKR
         VukQDLa1v6i03LjAvsIq3BO3E2Ah79biRhjbywEtEWG01ieHL4VIGaOGUVBZzyXA1Wkp
         m6jA==
X-Forwarded-Encrypted: i=1; AJvYcCVAyLNzG4a0TPuF6I1e5Wwf+tjBX8re7FmkdGKGSgw9H2qL9tG9qQYZoQH+dqZhE7dF8TxWqBWaBoNymS77XI05qSGgeZT9/VzN
X-Gm-Message-State: AOJu0YyM/mFHWwpt7yEQWzOSJpoArxzVgAIJuAplCNrocoQxVAfquaYZ
	JZ3GptsmmEiSi+6BuJKS+hsxv5cSrYZTg0s5/CGOqB/+DiTID3Cr
X-Google-Smtp-Source: AGHT+IGMzDozcFp7jk5pIqT2r+oB433amL8mIwl7y+Q6sXnIRKqq4W15tY3TetnNKZWNSELBHrLsYQ==
X-Received: by 2002:a17:903:1c8:b0:1f3:61c:30a2 with SMTP id d9443c01a7336-1f4486d4ffamr418345ad.2.1716486520814;
        Thu, 23 May 2024 10:48:40 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:4f9e:216e:ed5a:642d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c137e7esm253436265ad.257.2024.05.23.10.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:48:40 -0700 (PDT)
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
	Gregory Price <gourry.memverge@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v8 02/14] hw/cxl/mailbox: interface to add CCI commands to an existing CCI
Date: Thu, 23 May 2024 10:44:42 -0700
Message-ID: <20240523174651.1089554-3-nifan.cxl@gmail.com>
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

From: Gregory Price <gourry.memverge@gmail.com>

This enables wrapper devices to customize the base device's CCI
(for example, with custom commands outside the specification)
without the need to change the base device.

The also enabled the base device to dispatch those commands without
requiring additional driver support.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>

--
Heavily edited by Jonathan Cameron to increase code reuse
---
 hw/cxl/cxl-mailbox-utils.c  | 19 +++++++++++++++++--
 include/hw/cxl/cxl_device.h |  2 ++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2c9f50f0f9..4bcd727f4c 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1424,9 +1424,9 @@ static void bg_timercb(void *opaque)
     }
 }
 
-void cxl_init_cci(CXLCCI *cci, size_t payload_max)
+static void cxl_rebuild_cel(CXLCCI *cci)
 {
-    cci->payload_max = payload_max;
+    cci->cel_size = 0; /* Reset for a fresh build */
     for (int set = 0; set < 256; set++) {
         for (int cmd = 0; cmd < 256; cmd++) {
             if (cci->cxl_cmd_set[set][cmd].handler) {
@@ -1440,6 +1440,13 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
             }
         }
     }
+}
+
+void cxl_init_cci(CXLCCI *cci, size_t payload_max)
+{
+    cci->payload_max = payload_max;
+    cxl_rebuild_cel(cci);
+
     cci->bg.complete_pct = 0;
     cci->bg.starttime = 0;
     cci->bg.runtime = 0;
@@ -1458,6 +1465,14 @@ static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmds)[
     }
 }
 
+void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256],
+                                 size_t payload_max)
+{
+    cci->payload_max = payload_max > cci->payload_max ? payload_max : cci->payload_max;
+    cxl_copy_cci_commands(cci, cxl_cmd_set);
+    cxl_rebuild_cel(cci);
+}
+
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
                                   DeviceState *d, size_t payload_max)
 {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ccc4611875..a5f8e25020 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -301,6 +301,8 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max);
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
                                   DeviceState *d, size_t payload_max);
 void cxl_init_cci(CXLCCI *cci, size_t payload_max);
+void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256],
+                          size_t payload_max);
 int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
                             size_t len_in, uint8_t *pl_in,
                             size_t *len_out, uint8_t *pl_out,
-- 
2.43.0

