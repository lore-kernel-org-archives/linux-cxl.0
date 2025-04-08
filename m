Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E328235973
	for <linux-cxl@vger.kernel.org>; Tue,  8 Apr 2025 04:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744086727; cv=none; b=tmW6TfH0lnPxjglBJgodHj9IPA/8YStECAb/zHsNAN4rAJvI5fIQje69ySFUwyApBH6Hc9qsWhoLkkNeZiDeucVERRGhc9/CN7O82p/OLehxL2gv76sIRoe7XwgB/8fQVeBk6cPh7SgYVpWt4aIaMQR8QJMvP3OqxjztoLtZEJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744086727; c=relaxed/simple;
	bh=Ma1da+F+szXmGLUohZFjhyyM60SH4fZUD4WIOrMt+8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y07amC74kOPUKa1TDw7IuhY9yomLWt1/ikT4r95CGo37Js57z2jFPMQgfEVJOFKilg1kYek/EvE40pXDWDDcN8DnWKcZ10uc3k/ec/VgApFrBU1UaRf1ciztpc6XIXPP6ntRQOPbx/ZrKyu/IDrIjxlG2aqzyHQNySn62xKXjag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hisiGt7e; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hisiGt7e"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-af51596da56so4188263a12.0
        for <linux-cxl@vger.kernel.org>; Mon, 07 Apr 2025 21:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744086725; x=1744691525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIf6KRZsta6SFyUZqr4u0W6SgvBvMAQeL+UZ3/HECqo=;
        b=hisiGt7eCxFiBqNyHPXZ6w2XHhTXSdUUSsrPXYcyMMJm7EreXheRJx3gp5KIq+IzkJ
         OXaSoLPpWzM/Fp/MilDvzoPNWFtr5rha8Jw0DF5mqtbeeWAA5x24W6smnK36PBkzpkCF
         mV/jPjAturVy7X7M0zU5bFetHNpnMLgGTw3qE6we0t9qW/NBgtjWwOOgV7LnuD+XZVmB
         PD+wEctXuy/mPrfM2S+s3//HuACrLiF+o8oxMcaQ/qBH+/qX6fRn5VtESzTG+repOcsJ
         Ta23m6BNplis7QaXY1aub4zOXgnmPuwOR3LKU5D3pb6tSkf+FfxP5q4pEApxATI1qLLc
         /2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744086725; x=1744691525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIf6KRZsta6SFyUZqr4u0W6SgvBvMAQeL+UZ3/HECqo=;
        b=lFI19l8LEmKF/QfixoqDEp8P6soR/NDHNwP8YaKDWqVJHzyVfa2BB4HMMGgJjw6ebr
         MflE4lqDZDDdrFlu4zHTV9oZgedqERtHOdZijH7OK8qHl/HAyKeQ/+8RO8sfcOxakmHg
         4Pen1oHDKMbFHuvIayUpfhrCDrv7bI5D7L22RVCxb5xKuKlqk1XL9RcQKQTswzjn5zQD
         YyHQuUkmNwNgMPBSY4wS+KWr/1BEiXOFuVF+ihXthxfOjLpa4JQP7XdcP/1JNIiHWRK+
         BD5jev/U50Yl0tXTbyvz0bqlINYhUF/Webter0r3B61/mrdlCB4hSNZBCzms208FjvpP
         yjpw==
X-Gm-Message-State: AOJu0YwTiM82+p6/OqyU+z8YMhCKuklehwAp8tQV0dwdm+6yRPHaPOrk
	qjr9LA+naW4ScVcHERJOvwq3YXzK0Xnx+uxZvPzz15ZqBn3iQ4px
X-Gm-Gg: ASbGnctV9uuhkyfqBjkoqle4+WFhlwFBY+zp5fFwTVlBXt4+myCEyuogDfYMDlq13Dh
	0gjk2NVnLwGM7cKKHvUNrWvJRlKiO8tgOBJXe6wMUfcOakOWOIdYJMkL2blJi7LiV6EtKTWASUk
	69l4RMgz9FVu+J5cPXMt03UvWeYoX56P9E2wXDG1UHo0Bwr2ODShmx3VUav8cnm1ysbnV6iYlol
	Ut2DNImA3s7uP6Lb/F/Q21XUohpGmE1EonKRP7MRkC38Pe7iiz5mAol8Srgzhr9HTYB58ybqMXn
	4jduXaAHA4Wvbw1Hy1LO0FMkqkVp4gMkdAprq08XLXMkUjSVX6MSNjXYysp6fp9M9Lty9DL6
X-Google-Smtp-Source: AGHT+IG95Srqv4+u+FHkRMxez0pgopseFoWm6fSASwQ6yjOyz+N/XBQF4kWBCIkYShUTM1WzudKcbQ==
X-Received: by 2002:a17:903:2352:b0:224:c46:d162 with SMTP id d9443c01a7336-22a8a865a9cmr187371765ad.20.1744086725038;
        Mon, 07 Apr 2025 21:32:05 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:5e33:e006:dcd5:852d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297865e0a9sm90055385ad.149.2025.04.07.21.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 21:32:04 -0700 (PDT)
From: nifan.cxl@gmail.com
To: jonathan.cameron@huawei.com,
	qemu-devel@nongnu.org
Cc: linux-cxl@vger.kernel.org,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	nmtadam.samsung@gmail.com,
	nifan.cxl@gmail.com,
	anisa.su887@gmail.com,
	gourry@gourry.net,
	Fan Ni <fan.ni@samsung.com>
Subject: [RFC 2/3] cxl_type3: Add qmp_cxl_process_mctp_message qmp interface
Date: Mon,  7 Apr 2025 21:20:29 -0700
Message-ID: <20250408043051.430340-3-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250408043051.430340-1-nifan.cxl@gmail.com>
References: <20250408043051.430340-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

Add a new QAPI "qmp-cxl-process-mctp-message" to process the MCTP
request cached in the shared buffer from FM VM.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c       | 41 ++++++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c |  5 +++++
 qapi/cxl.json            | 18 ++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 7f85616ca1..f7ac8e8da7 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1614,6 +1614,47 @@ void cxl_clear_poison_list_overflowed(CXLType3Dev *ct3d)
     ct3d->poison_list_overflow_ts = 0;
 }
 
+void qmp_cxl_process_mctp_message(const char *cci_name, Error **errp)
+{
+    int i;
+    struct CXLCCINamePtrMap *map;
+    struct CXLMCTPCommandBuf *buf;
+    CXLCCI *cci = NULL;
+    CXLType3Dev *ct3d;
+
+    if (!cci_map_buf) {
+        error_setg(errp, "CCI name mapping buffer not setup");
+        return;
+    }
+
+    for (i = 0; i < cci_map_buf->num_mappings; i++) {
+        map = &cci_map_buf->maps[i];
+        if (!strcmp(map->cci_name, cci_name)) {
+            cci = (CXLCCI *) map->cci_pointer;
+            break;
+        }
+    }
+    if (!cci) {
+        error_setg(errp, "CCI instance is not found with name: %s", cci_name);
+        return;
+    }
+    ct3d = CXL_TYPE3(OBJECT(cci->d));
+    if (!ct3d) {
+        error_setg(errp, "No Type3 device associated with the cci");
+        return;
+    }
+    if (ct3d->mctp_shared_buffer->status != 1) {
+        error_setg(errp, "MCTP buffer status is not set to 1, skip");
+        return;
+    }
+    buf = &ct3d->mctp_shared_buffer->command_buf;
+    buf->ret_val = cxl_process_cci_message(cci, buf->command_set, buf->command,
+                                           buf->len_in, buf->payload,
+                                           &buf->len_out, buf->payload_out,
+                                           &buf->bg_started);
+    ct3d->mctp_shared_buffer->status = 0;
+}
+
 void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
                            Error **errp)
 {
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index c1a5e4a7c1..dbf18f2af2 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -92,3 +92,8 @@ void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t host_id,
 {
     error_setg(errp, "CXL Type 3 support is not compiled in");
 }
+
+void qmp_cxl_process_mctp_message(const char *cci_name, Error **errp)
+{
+    error_setg(errp, "CXL Type 3 support is not compiled in");
+}
diff --git a/qapi/cxl.json b/qapi/cxl.json
index dd947d3bbc..fcb1e0b3fd 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -553,3 +553,21 @@
            },
   'features': [ 'unstable' ]
 }
+
+##
+# @cxl-process-mctp-message:
+#
+# Command to process a MCTP command sent from another VM.
+#
+# @cci-name: name of the CCI to process the command;
+#
+# Features:
+#
+# @unstable: For now this command is subject to change.
+#
+# Since: 9.1
+##
+{'command': 'cxl-process-mctp-message',
+ 'data': {'cci-name': 'str'},
+  'features': [ 'unstable' ]
+ }
-- 
2.47.2

