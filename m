Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3501E0E0B;
	Mon, 21 Apr 2025 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745261154; cv=none; b=CBvL3FnaW1FabUgaiQjSweh4e41dBUj5RGTfxQkEqw0Z3H0j7+4O9CcUArRuelL1Pu2DuGa2D3em1iXMgUB/jxJYhyCrtCssjzawPGGbFyMQ7fusbJ6HiKVco0mkuxT+cg7DnZn43V8DozHtT1sBs6kuws20tGJo/RQQJaPruNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745261154; c=relaxed/simple;
	bh=GdhxNSslAWbZve6BQuhMyCtNZV9UQf1F5okxGwMVpDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bs+yT+4rxJRrB+7JBcO47+YGZKTCo+k89m9vbsojYqBqpNn4AZvjSUHe5MOtHNRnCidnyMLqximuDLPGX9DI+aSrha9vpPo0XdXigZOurWoOXDRvy5o56/QpsRJ8ioWBmRElLymJU8kqDM4XxNG7p0nDY1GhvL/dV3yfsS0gs74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlS5z7LM; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlS5z7LM"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7376e311086so5860980b3a.3;
        Mon, 21 Apr 2025 11:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745261152; x=1745865952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F3h1HyEnps9Et/hOgMbvgkw2q8Ek4tCtDu6hGMHWzbw=;
        b=HlS5z7LM7s3zc0mDaS65g1mlc8cIWwBgmDUA/Wi7QzbOafshHrNJ/8yzCueszJKKoq
         QEsT4m1oKBBprX6X6C7ttJ3TLscT6EMKxIq0WbIhZeg7OQT3KCJuuN247wimI06bWF0X
         iaBaw3OAltBi/qELAOuR+JYsv0A7d20TqU4eIT/uQc4dCEGy7XXaokycTUzyOeHug3Za
         THFzuD95OHXC17j/oUW4KDQgcfgqs/5/PlYY59w31ALFoITXAanGqjh8CqF+shFoL51F
         ltrB7Y2vIellM3NYk6FfA0/4W9keYFyTr+hcwdOYM7r4Usvm3TU2fnOB4uP2f71v1Q6z
         at8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745261152; x=1745865952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3h1HyEnps9Et/hOgMbvgkw2q8Ek4tCtDu6hGMHWzbw=;
        b=mxOUa5+3GrY7NVsROdi0MsgxeWV9sXw7WRNxhAdDNbcJhVrhVZJ784Qkpmo4GNDeTa
         NQnZBNu3oNVXdtVRhSt+l3y04dDIC1LCNRDPRAD8gIwXFtWoRVXim12o88qn/MmOE+Ze
         qSqvpfmXipCT8D6NQpY+US5b8D8pqxoxf2OTCcuU2Abe4pXopNDBj0cTPpd5kji067iW
         JIfdyiuCzbdm9jlgr7tUQXAYEreZGclSoV+9lT609TEiydy6B0RnM7xA4BU0H1PG0rx/
         jfHm2sQ+nXiEOkx8f1EArRyg/OwK6pHTeNxsvnP4/25+2SIexvoOrVUtC8moUG74JVzP
         XOyw==
X-Forwarded-Encrypted: i=1; AJvYcCU5A5uwfwFNeLIqAiwquv3sRl+ZdLrzjCxYyfAhibPobpni2QewakdfOEtKBOVpRiDbKzxQsXqGtV6vvWP2@vger.kernel.org, AJvYcCW0gwrcyHMpgyAcwdJF/yysM3y2X6J3Hbau1IhpJ45p+1W41NhXi85PJB3hM4d+gGjfYk5FVgPH2eM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx77hd0mi9J9ekBWe2t1Gq4P8e5SK+guByJXv9dVMWeJbujX8ZE
	sQX2hf9X5SF/2M9JqZ6CbYnSa59bWjE/y7DyTy69OCjBLpnWMmIz
X-Gm-Gg: ASbGncs+OzaUBAiBMU6/QKiPvEs6oe4YJl5E55WmZxgVqa3gmBZyu5ndJ+yhVT+gjpn
	7dLdxQv360x4VSozTG1qfr7XnBlgjYvfsD4hnKyXQ9jpiJyBBbLFmBV+of+16zldC+S62sSwgLh
	haPEI857f2auL+V1JHc8FQJvByUErx9LRMB/EaYepsxvIPAw984PqMlDsUg3d7i2EaM4NqQEvE6
	7D+9D/xxHnhka8r4CjOD0V8Mr0q+7AbGFnfRvukVkxEZEQLVzKgcrVga61Oih97gzveCWc4sspj
	0gLRLGAnFlcXtM4ZOwpuVGNqNlbNZZkXAKadj4jqY0kNj720QTwH0Lw9TQ==
X-Google-Smtp-Source: AGHT+IESLA+LfVU0NI/zaGGaTQL5mIYThUhrhCPlnIQSDEpy56AcHp2m/FdK1x4VcUfJ7r4SjCqtpA==
X-Received: by 2002:a05:6a21:c8d:b0:1f3:486c:8509 with SMTP id adf61e73a8af0-203cbc76934mr19232992637.25.1745261152537;
        Mon, 21 Apr 2025 11:45:52 -0700 (PDT)
Received: from acer-Nitro-ANV15-41.. ([61.83.230.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db13c5f8bsm5937487a12.35.2025.04.21.11.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 11:45:52 -0700 (PDT)
From: "shaikh.kamal" <shaikhkamal2012@gmail.com>
To: dan.j.williams@intel.com
Cc: "shaikh.kamal" <shaikhkamal2012@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [PATCH] cxl: trace: Fix macro safety in CXL_EVT_TP_fast_assign
Date: Tue, 22 Apr 2025 00:15:17 +0530
Message-ID: <20250421184520.154714-1-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix checkpatch.pl detected error
The CXL_EVT_TP_fast_assign macro assigns multiple fields, but does not
wrap the body in a `do { ... } while (0)` block. This can lead to
unexpected behavior when used in conditional branches.

Add checks to ensure cxlmd is valid before accessing its fields.

Signed-off-by: shaikh.kamal <shaikhkamal2012@gmail.com>
---
 drivers/cxl/core/trace.h | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 25ebfbc1616c..a1a1014ee1fe 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -249,18 +249,24 @@ TRACE_EVENT(cxl_overflow,
 	__field(u8, hdr_maint_op_class)				\
 	__field(u8, hdr_maint_op_sub_class)
 
-#define CXL_EVT_TP_fast_assign(cxlmd, l, hdr)					\
-	__assign_str(memdev);				\
-	__assign_str(host);			\
-	__entry->log = (l);							\
-	__entry->serial = (cxlmd)->cxlds->serial;				\
-	__entry->hdr_length = (hdr).length;					\
-	__entry->hdr_flags = get_unaligned_le24((hdr).flags);			\
-	__entry->hdr_handle = le16_to_cpu((hdr).handle);			\
-	__entry->hdr_related_handle = le16_to_cpu((hdr).related_handle);	\
-	__entry->hdr_timestamp = le64_to_cpu((hdr).timestamp);			\
-	__entry->hdr_maint_op_class = (hdr).maint_op_class;			\
-	__entry->hdr_maint_op_sub_class = (hdr).maint_op_sub_class
+#define CXL_EVT_TP_fast_assign(cxlmd, l, hdr) \
+	do { \
+		if (!(cxlmd)) { \
+			pr_err("Invalid arguments to CXL_EVT_TP_fast_assign\n"); \
+			break; \
+		} \
+		__assign_str(memdev); \
+		__assign_str(host); \
+		__entry->log = (l); \
+		__entry->serial = (cxlmd)->cxlds->serial; \
+		__entry->hdr_length = (hdr).length; \
+		__entry->hdr_flags = get_unaligned_le24((hdr).flags); \
+		__entry->hdr_handle = le16_to_cpu((hdr).handle); \
+		__entry->hdr_related_handle = le16_to_cpu((hdr).related_handle); \
+		__entry->hdr_timestamp = le64_to_cpu((hdr).timestamp); \
+		__entry->hdr_maint_op_class = (hdr).maint_op_class; \
+		__entry->hdr_maint_op_sub_class = (hdr).maint_op_sub_class; \
+	} while (0)
 
 #define CXL_EVT_TP_printk(fmt, ...) \
 	TP_printk("memdev=%s host=%s serial=%lld log=%s : time=%llu uuid=%pUb "	\
-- 
2.43.0

