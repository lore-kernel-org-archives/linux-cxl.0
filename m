Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29119218E96
	for <linux-cxl@vger.kernel.org>; Thu,  5 Jun 2025 23:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749166962; cv=none; b=bWp1qopo0jditiyV/mTRQoL7UP8TAhGfDmC11ddgDLa03wCQV0ecSV6MHFBZdzpJj+E08bRdJF8KD7112d8RTKc2VQk3VDIUQmQ/NrzguzCwsMN8a2+okbl1Fge8BviTJaYHCizGXGvqb7Liz5yl1Hrh75IybxA9AQBgQCJixfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749166962; c=relaxed/simple;
	bh=r4aLRpb6ohaPlZc7TMyE5GDmFPSXCb9bkU/GLTi6/k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0eESuiphE83QdNn0b4v/9oLINgxgm+UVU82agOuXet55GN5966LZ7b33nAk0Xv0wG1QfocFYJDpIi/ZFgNyfYpS5XGj4JLMjy0ddb2SHgXhIH4VwdyIbnkdt6yAAk/6NLEkMGcgd5POoTcK+dApekhveutVvI909Y76g79lV+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lP5DVnRP; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lP5DVnRP"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-74264d1832eso1871899b3a.0
        for <linux-cxl@vger.kernel.org>; Thu, 05 Jun 2025 16:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749166960; x=1749771760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlJ/ihmtY/Bs+6QNasQQE5ci8/VnkGAsX6ch1ZEqQ/Y=;
        b=lP5DVnRPVLP6eYWJYxrn63SgZ91NZ6TxdZCmV6dx/oIAnhx1qEnHIOIBWcG1RLo9Bh
         uU8WLS0JkGNx+BuSk2cOWF/uBOsUBbCaraQC2hiKiVfIhVd2K9dL82Gd2pKXML/UPN3Q
         4mkMD41mGU00cZFk44PJxCusbeg0Os6S+14yOkgoA5DlM757z/SPVDksb+zjoKHoZ1BO
         eF9Gpaw8B4FtxaAc7vlWwHtlUpsZbrdgOOqsrzyfwDNMm8/T4XuUMEoX7Rbo1bj2dsTS
         3k2RG6ZoJIrkxYzKF6XDinks9xtqCOG/0+jsRh18BfuLxaucHjdvvYmVaxI0GrGqIWFr
         UF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749166960; x=1749771760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlJ/ihmtY/Bs+6QNasQQE5ci8/VnkGAsX6ch1ZEqQ/Y=;
        b=rBQyWnMRq9tPMMHNDAW9QoKuJN3XV2XVc7Kb1spzEdex9aUBi6mf46zx2QbxSbMeXl
         mZDlbrr/B1A0mFyxsVByIrKE6LsKQ5gXf9J+yTdezD5cY8g0j9x682ogs1iEFnS8gCbT
         9z/SC7JWpHavsEU8lUYXmkvYOwDfcL9BQMNZPtHuDZZrkEXXbUKa+uToIHjx9gA3YWSc
         2jZN8dqONFHGApq6HQ+13A/qvYL8vsdx1c2/eBhtPZzv05Ux/LoCSIDEiiEW43jhntq7
         tz3AI8S5WZMZ5+sJv0+HFXHKnRc1AbEgku0u9nnnj9zn+pMN6ngHpkbN0lsqtDV/FK5u
         Fk2w==
X-Forwarded-Encrypted: i=1; AJvYcCU+GSegKIt6n0iVw/vGNfoDO/5Ls8eOTWl4XLhit4p6E2tdv83PZFoAX3QmmHB4FUW38Zp1/LiN1pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxacpWrnf3kj2aJCfsghqfsA8/sqvDsan4rbmWregcfjVpp1X5X
	zzhvvy/sH/z4uJXf2URjZbTu50Oiftvg4jxsUB9NdLW8QA1bwmM3QIe/
X-Gm-Gg: ASbGnctr80gMh2h8YkvBqMMKDLaFtFPI6HQlQZUg/p6G/zlTEfiDxbD0vEPWQm1uok1
	MQKZAoCnS6lGWITLxYCpthncxSD65Jnnjb6aHcF2WSvnELT57unJGb5+dKNRqnB+gkPewOjIJDR
	rTaIjleTPljekHE9968560YawMP/vX7YvciyBta+VUHQ0utv4jI+JkQoPnvLcjs66NezadcXnmy
	9snBg3Yvt1LRCNweFaH51oNJAbQFIppLSV5QQtyRaHDGf+QvMJ6r8DzCYsdGR7v/J3yzXyzbxKX
	l6z3gDg3JHhM8Y3e0FIxtTuesMW6gWpqanw3T9UoDWqZ5bTJ7b2tPkC2jHIowKWcTwDvPX0k9NA
	tlJ3ZwGU=
X-Google-Smtp-Source: AGHT+IFyjKedcs1IVdYVe/iobdhpu7k14FKeOftOEpSx+HSKmjoGcM6e9GvPLeuTgwROj4K4xaTPug==
X-Received: by 2002:a05:6a00:b85:b0:742:da7c:3f30 with SMTP id d2e1a72fcca58-74827f10920mr2042558b3a.19.1749166960438;
        Thu, 05 Jun 2025 16:42:40 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0847b9sm213916b3a.104.2025.06.05.16.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 16:42:40 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: [QEMU PATCH v3 4/9] cxl_events.h: Move definition for dynamic_capacity_uuid and enum for DC event types
Date: Thu,  5 Jun 2025 23:42:18 +0000
Message-ID: <20250605234227.970187-5-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605234227.970187-1-anisa.su887@gmail.com>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anisa Su <anisa.su@samsung.com>

Move definition/enum to cxl_events.h for shared use in next patch

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/mem/cxl_type3.c          | 15 ---------------
 include/hw/cxl/cxl_events.h | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 0fccd22800..cdd60079c4 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1876,21 +1876,6 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
     }
 }
 
-/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
-static const QemuUUID dynamic_capacity_uuid = {
-    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
-                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
-};
-
-typedef enum CXLDCEventType {
-    DC_EVENT_ADD_CAPACITY = 0x0,
-    DC_EVENT_RELEASE_CAPACITY = 0x1,
-    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
-    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
-    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
-    DC_EVENT_CAPACITY_RELEASED = 0x5,
-} CXLDCEventType;
-
 /*
  * Check whether the range [dpa, dpa + len - 1] has overlaps with extents in
  * the list.
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 38cadaa0f3..758b075a64 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -184,4 +184,19 @@ typedef struct CXLEventDynamicCapacity {
     uint32_t tags_avail;
 } QEMU_PACKED CXLEventDynamicCapacity;
 
+/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
+static const QemuUUID dynamic_capacity_uuid = {
+    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
+                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
+};
+
+typedef enum CXLDCEventType {
+    DC_EVENT_ADD_CAPACITY = 0x0,
+    DC_EVENT_RELEASE_CAPACITY = 0x1,
+    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
+    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
+    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
+    DC_EVENT_CAPACITY_RELEASED = 0x5,
+} CXLDCEventType;
+
 #endif /* CXL_EVENTS_H */
-- 
2.47.2

