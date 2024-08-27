Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDFF1CC150
	for <linux-cxl@vger.kernel.org>; Tue, 27 Aug 2024 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777015; cv=none; b=iCzhZcfOyBuA7MtEwDVUdhHrMadZBftN4yyo+RWQAxC1oVfgiGvlHcpNs6sPjoM+hSFvv+w3AlD2rqBnmj5bMQS5OsBqz0SzJYwsb05/v9rbaqcK95wbPRmJkdfPLCmAIuuSnjiIdnBujGZH+/Hjt4RK+CCqVoc48YlsN2QM4jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777015; c=relaxed/simple;
	bh=TkAwUaYm2HlZJFTp3TCFMVqd+I6I/A74EVoeR0phMhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVoWNrm2LInv9uFbfIfOi+Eu/O3Dpbel1p5pITeUNHMHxD/cLkegGFEimAoAiLKa8hkMSCif8tScHSvaL0sCJUpZNnpicmnNrbSFLMAjLBCYHY2dPovmtCEeDI9wGOer6JjwXM12GStgJ/qV6yGHryAJ4twdq4yCyW5js5Z0PIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNTuFKhL; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNTuFKhL"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6b59a67ba12so52340077b3.1
        for <linux-cxl@vger.kernel.org>; Tue, 27 Aug 2024 09:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724777013; x=1725381813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEDmyzzxPb/PUKZBhsRmkSdCWD04Zj/XpJE2z0YZDVM=;
        b=MNTuFKhLRXTzUrMhe94/I8HB3o+h9JdPBG1oTBzG2nK0JTAPb0mmRt3xtyZKSl7Kh6
         DS1EHtpZ5Ey11hpHVi3R+CUn9h4tcFu1lovl7qXiYAaBo0E2G80yZh58NaCR7lnqpNEd
         Ad+IE3JVVUjMRmyPD/3TnyjONNp3a2/Wgn2DHC73/rEnFn6NqWJ9a97Wu40PhFcE/f/W
         UUwhPtMDD8oQdeP6eluH5TS6v5trlNj8f7kY5fia0JOCZTEE7hMh8cKYUmKYDbQMvS6J
         Ax7l3udNQNwolngTGEEDICcX8b1CnT728MeiONxzfpP3+06wExhAFqG6PPTHGDpFROpt
         g+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724777013; x=1725381813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEDmyzzxPb/PUKZBhsRmkSdCWD04Zj/XpJE2z0YZDVM=;
        b=B1O0Fp5LuEyqnMrGegSouXJeLKePS4FLyO+0mcWrLOGjydJ4oi0f1QmUqI785n1blr
         2np67JNyTyoIG/7KCRO3pqjNuzjY5HiAGEPN/yf3DvNN7382D5Ix8XJ85R9NkEFLvMq2
         BFP8frzcl4t54JLyPkUt658rq5KIcqX4X0QNPTUxL07bG0yKdUcLkhChx+2YprGVuWrI
         BxKwvDpOc3rpU5HzvKGExi1nWGcGjDCgVwUEPReExxwdLMlHvK/icB4wX2gOj2pQOX68
         y+8zlTwLRsx4any6pjxsrk0yeRCd8N871ZlVdroqC2MDuzTyHMegLhr38KbZD9Bb65+l
         /DEA==
X-Forwarded-Encrypted: i=1; AJvYcCXI7Pp9F0xXUXzDIM9OlJ8QEYlRGJKSx8rgPMXzaLVvIJ73mfXpbHSoR1MOA299OHLqIbP7fVjX/Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLLC+I9fRTYgoU+1ZdAQ1cemXXQYKi+NP1qJwnNbcSE3CKcIBQ
	VMAaagXjeYxURrQkQM1Ach3YdTLwZ2n2oU4wglQHKegI2l++xUtG
X-Google-Smtp-Source: AGHT+IE59fdXqmAKT5SobODemnTv9LGfPiVyfZ/eERHVawp27GQyG7XsRqmn6J6DUFuJLAws4UCzQQ==
X-Received: by 2002:a05:690c:7005:b0:64a:5493:e0bd with SMTP id 00721157ae682-6cfbc1a8a0emr40365047b3.40.1724777012771;
        Tue, 27 Aug 2024 09:43:32 -0700 (PDT)
Received: from fan.. ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39a753427sm19658677b3.53.2024.08.27.09.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 09:43:32 -0700 (PDT)
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
Subject: [PATCH 2/2] hw/cxl/cxl_event: Fix interrupt triggering for dynamic capacity events grouped via More flag
Date: Tue, 27 Aug 2024 09:40:05 -0700
Message-ID: <20240827164304.88876-3-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827164304.88876-1-nifan.cxl@gmail.com>
References: <20240827164304.88876-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

When inserting multiple dynamic capacity event records grouped via More flag,
we should only trigger interrupt after the last record is inserted into the
event log. Achieving the goal by letting cxl_event_insert return true only
for the insertion of the last dynamic capacity event record in the sequence.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-events.c         | 8 ++++++++
 include/hw/cxl/cxl_events.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index 12dee2e467..90536c0e68 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -135,6 +135,14 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
     QSIMPLEQ_INSERT_TAIL(&log->events, entry, node);
     cxl_event_set_status(cxlds, log_type, true);
 
+    /*
+     * For dynamic capacity event records grouped via More flag,
+     * Only raise interrupt after inserting the last record in the log.
+     */
+    if (log_type == CXL_EVENT_TYPE_DYNAMIC_CAP) {
+        CXLEventDynamicCapacity *dCap = (CXLEventDynamicCapacity *)event;
+        return (dCap->flags & MORE_FLAG) ? false : true;
+    }
     /* Count went from 0 to 1 */
     return cxl_event_count(log) == 1;
 }
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 38cadaa0f3..b0e5cc89c0 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -170,6 +170,7 @@ typedef struct CXLEventMemoryModule {
  * CXL r3.1 section Table 8-50: Dynamic Capacity Event Record
  * All fields little endian.
  */
+#define MORE_FLAG BIT_MASK(0)
 typedef struct CXLEventDynamicCapacity {
     CXLEventRecordHdr hdr;
     uint8_t type;
-- 
2.43.0

