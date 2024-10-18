Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14CF1EE028
	for <linux-cxl@vger.kernel.org>; Fri, 18 Oct 2024 16:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267996; cv=none; b=ChuOfjfbqUH3OQ+WtxdCBP0NyneFiJn5AQ64RA7gd+ehEvOx7L+m6PyytNdvW9lMFHYhCVjUss6+o7uBvslXEvdYMTYQlXFrpOc68vDX6IUIJTW8ZAp+RlFstZ6DR8NjMb+BpI+2hLp6ZUrNbHtwcgORg/yK9J6WmB5BTqgTVLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267996; c=relaxed/simple;
	bh=msy/cQXb5Dfs2fmJlRUaV26iIsCtXdQF3yh60DCKWvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hgv/wXxgzlS5rhG1IYOO6h3jinwlErGd7TgfM82rbXZlSAcgzmkasJNT6VMf+5YjZQ3BeGiMeWA8CFSLMQ00yi6J92B1aNvvtMmc9pz/2/EqTTcG1mQ1IaQe1TooOvoA39h7jq/nDISGGJd12Cz/kn5cMRJEhkgYGLoi+4ZWvSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Pge3digz; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Pge3digz"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b13ff3141aso159810485a.1
        for <linux-cxl@vger.kernel.org>; Fri, 18 Oct 2024 09:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729267993; x=1729872793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/0cRfb4YBF8cPInnUDV/L7Jp4pgWglmeJbCtRCfJPQ=;
        b=Pge3digz48bIggkBFgh5YHhZVBgabYfhiKGb0NSDx/m+8EEp4A9LNPfm8WZc5CBMxR
         5UTxpkIpCYwt/aaPyWwtqobIWhzZt9KeivJtWezy3gKSJDjR+1t9L0l1OboFonhpkbcI
         y+zDi18dL/waBrxI0D9iz6H5PzHBF0RfZjdlaF03NT7JD4TzKbUgYrY+5H7bPkBgRbSY
         z1Xg7gW55RR0OZvWvYiE6BWQr1an99c79TzMt08qZ7Rcq6rLiBdwE7EyKnfLTw5n4Krb
         6YgxcKnuFWNI09eulgo6ryg7STzv2aBtPC7/UsvhHa4yM+nruosk68hQaWjBvXJLNX6G
         XzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729267993; x=1729872793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/0cRfb4YBF8cPInnUDV/L7Jp4pgWglmeJbCtRCfJPQ=;
        b=D6bf2FowJEuu9RQBUG+cjbbp7RAwbyUy1ruD1OEnU0ny9CasLkWBwAWrX2NDCtyGBB
         AUyDSWU0jNQmdItD8ZN/YlZoKc00NNSeXX40kFrOnvcYq0A5QpTJOZ4a9rEKrsvm1/fR
         uEPCtGYx6CcgkXThxiCoIRBH3SZ8dXWpIVGa7HtwobLY4UIUUth7ZCAEeU+5yVogGb2s
         YppJ+ckJvkYmQ5plv67uIRUIk3g1hfo1SIz2lPMRo01I9TTO7NukBEk8uEJnOWLbE96T
         +4TGdAghSv2cuJzUMmngRVOZ6LZ8y4OQbvbAz6uEC7ve7nu88sRUZD3WuAPsZxqene/r
         lc/w==
X-Gm-Message-State: AOJu0Yxts4k/ixGQCioVtsZcWNYDFs3zgFk3KFQBpX1vh4ddScj053PB
	eyGI2CTv+NtJXJJUX5hENLZV9FS42jxleK2t2ZSLpimZWcahfryT7aG8WWevR4d9iXo1N1Lm45q
	O
X-Google-Smtp-Source: AGHT+IHgiNaZWimN4akiargJriy+PnqMz0dQ4VKMrO8LERPUv3AnoxXaArowIO1TsiS2YWVAiX8YXQ==
X-Received: by 2002:a05:620a:2402:b0:7b1:4948:109f with SMTP id af79cd13be357-7b157bf13camr287097685a.57.1729267993256;
        Fri, 18 Oct 2024 09:13:13 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b156fa55cfsm81677385a.67.2024.10.18.09.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 09:13:12 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: qemu-devel@nongnu.org,
	svetly.todorov@memverge.com,
	jonathan.cameron@huawei.com,
	nifan.cxl@gmail.com
Subject: [PATCH RFC v3 1/3] cxl-mailbox-utils: move CXLUpdateDCExtentListInPl into header
Date: Fri, 18 Oct 2024 12:12:50 -0400
Message-ID: <20241018161252.8896-2-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241018161252.8896-1-gourry@gourry.net>
References: <20241018161252.8896-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Svetly Todorov <svetly.todorov@memverge.com>

Allows other CXL devices to access host DCD-add-response payload.

Signed-off-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Svetly Todorov <svetly.todorov@memverge.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 16 ----------------
 include/hw/cxl/cxl_device.h | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 72c03d85cf..10de26605c 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2446,22 +2446,6 @@ void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list)
     g_free(group);
 }
 
-/*
- * CXL r3.1 Table 8-168: Add Dynamic Capacity Response Input Payload
- * CXL r3.1 Table 8-170: Release Dynamic Capacity Input Payload
- */
-typedef struct CXLUpdateDCExtentListInPl {
-    uint32_t num_entries_updated;
-    uint8_t flags;
-    uint8_t rsvd[3];
-    /* CXL r3.1 Table 8-169: Updated Extent */
-    struct {
-        uint64_t start_dpa;
-        uint64_t len;
-        uint8_t rsvd[8];
-    } QEMU_PACKED updated_entries[];
-} QEMU_PACKED CXLUpdateDCExtentListInPl;
-
 /*
  * For the extents in the extent list to operate, check whether they are valid
  * 1. The extent should be in the range of a valid DC region;
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index c3e93b876a..b2dc7fb769 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -552,6 +552,22 @@ typedef struct CXLDCExtentGroup {
 } CXLDCExtentGroup;
 typedef QTAILQ_HEAD(, CXLDCExtentGroup) CXLDCExtentGroupList;
 
+/*
+ * CXL r3.1 Table 8-168: Add Dynamic Capacity Response Input Payload
+ * CXL r3.1 Table 8-170: Release Dynamic Capacity Input Payload
+ */
+typedef struct CXLUpdateDCExtentListInPl {
+    uint32_t num_entries_updated;
+    uint8_t flags;
+    uint8_t rsvd[3];
+    /* CXL r3.1 Table 8-169: Updated Extent */
+    struct {
+        uint64_t start_dpa;
+        uint64_t len;
+        uint8_t rsvd[8];
+    } QEMU_PACKED updated_entries[];
+} QEMU_PACKED CXLUpdateDCExtentListInPl;
+
 typedef struct CXLDCRegion {
     uint64_t base;       /* aligned to 256*MiB */
     uint64_t decode_len; /* aligned to 256*MiB */
-- 
2.43.0

