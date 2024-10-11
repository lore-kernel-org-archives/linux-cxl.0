Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480C01D174E
	for <linux-cxl@vger.kernel.org>; Fri, 11 Oct 2024 20:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728678638; cv=none; b=lKfV5uzZyv/phw/iqFTsygcmcW5lHgyu427xZdWo6VLoJEKUIHk4cRzUFa1Xs0xFyrzo+feH0J5vFbyvB0w9fm/tt/iR/fbNxtm7+XpyE1PBpjnbGPg281W0pVp3Ey2L+Rb7RFeV9WxkacuKU+EfoV36OAK4eJdf/PXOW4FUmf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728678638; c=relaxed/simple;
	bh=gwak/BM/7yhC0LQSRhiPFMmcelgiV9ISVlbjiUJUXp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=egVnpLeeAaeuWgCNC+a+Csk2Ov8dRUxaiZXlLJgREaYXWs5aygdIFFb1qcCVHcrbqPCHva1JSXwH/czVNAwM3/3Ddse7v3x9pX3j4zfQQo3sLLYaCa0rXvAjSMS71niOrulswGTewfVE2a6N6ZapEXeJNsfahbcrNYFVzPw4jt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3i1vpPH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3i1vpPH"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20bb39d97d1so22778105ad.2
        for <linux-cxl@vger.kernel.org>; Fri, 11 Oct 2024 13:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728678636; x=1729283436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rz6vGoXtQ8OGPE036yHF1biqczt6VgPMUWgroJxMWJ8=;
        b=V3i1vpPHiB8MbtxsZuQEbsCS4KTvMa0EQ4+FzrT32faHNb1ghQBr4z0w7/y5b1+Avx
         5BHJlEDio30RoS7DBjLaVDXka01t7fSfYXHQR6AVWTcbtibKLnClh2WGgPc3ilH2yQ/G
         pVFr2N76+WthSHT19RsXzYL+yw1KLeDOU3OvHrOl6if+xPfh0a7zX1cZwfZqIS2rMyY8
         cx0qqc50BGIyrKCMsY+3yzSNR8xccWZi5FCy2vODhdKVMr1MId7jA2grTYippuJoIXVz
         vunYfbbLA65LFdU9qUfHA7CsiVULrbrc+U58iXrHd3EOVlu81ffsCy+SOKiuyh+Aqa4m
         eflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728678636; x=1729283436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rz6vGoXtQ8OGPE036yHF1biqczt6VgPMUWgroJxMWJ8=;
        b=RSTViGvN7qz9LQ4ZSgCvdr1tLhragA6XOWma8itljUu2FugN7i1W3iO8fXdn3cRALw
         QSIM4geDctYiqoqD/8hzYUaXlH0HkCRgVEgHSmHItq3DSfnCeUBfb78jWNx+7I+/WoR4
         KBm331hv/B3rtKIbnbtcTLgFFNk8xbZTb9twI2/r7FkEpr5xIoHe9d4DmySS3PGv1GN8
         l56g9BErDzIByWx//0OCa/6Ob4c5D24SJs5sbOfg2vuWZ9+jr8AFZOPwab2JO10DaFK0
         eCWsvPT7tDG0G9cZV54NILonEbqGanFtO9Hmt3tzTbT3jsXFx8wPF4x7orzzmejvZuPI
         HLRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8mPV+BCCEfIFYfoP6votQzNOBoSV4QM7IIwUh9P0iaBG0wAzuL2K9jxT3oIXWEnqvDyETIT+PtBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcVKE1vForzmx5T+nL4YBWXO2xJg2xF0XbDhfjjuG1Ua7GMCQL
	5SxOJFG1kq4nkatVM3nhx34W++CT58ZcoLP/adiAit2KdYBixhNA
X-Google-Smtp-Source: AGHT+IFuAwHAP0t7894mcawPGcyqy5qcL9EKa1mT3PbzMHJnT9sHJW+BxDiletBdOS9DigBb/ji5eQ==
X-Received: by 2002:a17:902:e74b:b0:20c:8daf:8530 with SMTP id d9443c01a7336-20ca144a5femr60890855ad.7.1728678636358;
        Fri, 11 Oct 2024 13:30:36 -0700 (PDT)
Received: from fan.. ([2601:646:8f03:9fee:fa84:fdda:e412:45e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c312f49sm27345205ad.233.2024.10.11.13.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 13:30:35 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	nmtadam.samsung@gmail.com,
	nifan.cxl@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: [QEMU RFC] hw/mem/cxl_type3: add guard to avoid event log overflow during a DC extent add/release request
Date: Fri, 11 Oct 2024 13:24:50 -0700
Message-ID: <20241011202929.11611-2-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

One DC extent add/release request can take multiple DC extents.
For each extent in the request, one DC event record will be generated and
isnerted into the event log. All the event records for the request will be
grouped with the More flag (see CXL spec r3.1, Table 8-168 and 8-170).
If an overflow happens during the process, the yet-to-insert records will
get lost, leaving the device in a situation where it notifies the host
only part of the extents involved, and the host never surfacing the
extents received and waiting for the remaining extents.

Add a check in qmp_cxl_process_dynamic_capacity_prescriptive and ensure
the event log does not overflow during the process.

Currently we check the number of extents involved with the event
overflow threshold, do we need to tight the check and compare with
the remaining spot available in the event log?

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-events.c         | 2 --
 hw/mem/cxl_type3.c          | 7 +++++++
 include/hw/cxl/cxl_events.h | 3 +++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index 12dee2e467..05d8aae627 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -16,8 +16,6 @@
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_events.h"
 
-/* Artificial limit on the number of events a log can hold */
-#define CXL_TEST_EVENT_OVERFLOW 8
 
 static void reset_overflow(CXLEventLog *log)
 {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 3d7289fa84..32668df365 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2015,6 +2015,13 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
         num_extents++;
     }
 
+    if (num_extents > CXL_TEST_EVENT_OVERFLOW) {
+        error_setg(errp,
+                   "at most %d extents allowed in one add/release request",
+                   CXL_TEST_EVENT_OVERFLOW);
+       return;
+    }
+
     /* Create extent list for event being passed to host */
     i = 0;
     list = records;
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 38cadaa0f3..2a6b57e3e6 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -12,6 +12,9 @@
 
 #include "qemu/uuid.h"
 
+/* Artificial limit on the number of events a log can hold */
+#define CXL_TEST_EVENT_OVERFLOW 8
+
 /*
  * CXL r3.1 section 8.2.9.2.2: Get Event Records (Opcode 0100h); Table 8-52
  *
-- 
2.43.0

