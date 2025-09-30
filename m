Received: from rusty.tulip.relay.mailchannels.net (rusty.tulip.relay.mailchannels.net [23.83.218.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E93C2940D
	for <linux-cxl@vger.kernel.org>; Tue, 30 Sep 2025 03:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.252
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759202568; cv=pass; b=LPfDp+PQER4POohNSYkZYmWNz8i/8HVUsVgdI6AQBi3/Idj5oe8XiT80D1gB3QMPrd8Gzoj3311lfYXyiZMGjUnvo2WqNjpPE5eWoFL1cMbXkKX8rn1gFdFqMrvFyYbNmhxp0wtJ4YEJeS/UuvcLP6F7HnzTPt+L14w37tXSXhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759202568; c=relaxed/simple;
	bh=iI7ED7Ui/d0fFOOSnrP5vidMJCyj0ag0tYz2BZ0CHWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cVBJx+hDC0yeCmDz9pO8APtwBVe2205H+DmcqOjAdB30W1B6kV3vi/3BhPwlKrqNklh/7IKVoGa5T6ZjEJPe2r2r0WjrlPz+6/H6uLwpnt+DofxpBGCg564g9Ppc4CPL7b948wf8gVNhGo2XmHnn3+6B4GFYczeaO8saLH9NpsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=gwaPenKe; arc=pass smtp.client-ip=23.83.218.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="gwaPenKe"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9E44A9010B6;
	Tue, 30 Sep 2025 03:22:40 +0000 (UTC)
Received: from pdx1-sub0-mail-a315.dreamhost.com (trex-blue-7.trex.outbound.svc.cluster.local [100.110.156.241])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4154B900F72;
	Tue, 30 Sep 2025 03:22:39 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1759202560; a=rsa-sha256;
	cv=none;
	b=gL9srsfmjFTdYjpt6IcvPNGqpO1lQnhE0zKxDrFcCKojmrR5A7rDEO8qRoM5Aq5wtQRSev
	sZu37glmYHuKjZGN1rqTN6csj0v3t7OyJ9gPKa0czE+3hTLP7Dy2bt/s3AAe6c9iPpQkzm
	pxFwDtPcDilP6NUXjRnEwiFudTuGJkHuQEY7Gq5ELTVsfB2DXOWRzeroVpaoczcWs7W2oc
	sihz5xFn2n70J1FDWjVRZ19VuLK9aoG7dDiupijMD8mCJYIv33u+jf7D1zQMjMcMptIW9v
	9igr28XNUkoALhZUs1DBrdOettVNiv34FmA1A9GIpVzz0gRuym6rGwJ8Rkowlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1759202560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=m3zmudrbJi3rUAWruVPmWJ/JHGSWiiguedxKVAHxwYo=;
	b=wHV+M53NKkujkPAAYU7GsCqN2YhpYcsol4f46/lnD8+bwprqTPafP957ylPSZnwkS7K9wz
	WgWQeZ9sFP4wVF1mwPFwNPVaXfo0teiILYnVkKZk2Yyq74p+Vcglnj8VPI7rMYqfM56Rxl
	ZIjIrOXhH7/Z3O1g+N5NeSmtDIdc5UE1ZLzzrBVLYkzx9WdEumwhNxrvz9mPuyOOyF4OqC
	oFFfJ5JCQLXWSDqe4UUKfmp3Qo9qcHGMKE2BLt0MTW8QG7uq3wjxS9jnA+gt5BCA3c37iM
	O9mVXUlsttAMmnkOTPPNXwDfsuzopYKetHq7qUfm7urfFQHA8iX+QCSY/IQ1nQ==
ARC-Authentication-Results: i=1;
	rspamd-9695c5dfc-dglzn;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whimsical-Reaction: 532bb41370affa87_1759202560531_1060827618
X-MC-Loop-Signature: 1759202560531:1422808747
X-MC-Ingress-Time: 1759202560531
Received: from pdx1-sub0-mail-a315.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.110.156.241 (trex/7.1.3);
	Tue, 30 Sep 2025 03:22:40 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a315.dreamhost.com (Postfix) with ESMTPSA id 4cbNfK3dVjzR3;
	Mon, 29 Sep 2025 20:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1759202554;
	bh=m3zmudrbJi3rUAWruVPmWJ/JHGSWiiguedxKVAHxwYo=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=gwaPenKeVtrY/l7ROcCQnGoFnBlGUVfh9CZJ6GcBok1sI6AUrI8hZERJcqyVhZnHL
	 /N99G4Z0xYBy8KuZlC1iXjnF6sBiRlqP78Sgir2elgS7ObY+imMUnozqceQQfNADsj
	 fm5sqbkddNrz04kuGhE1iOQz1GIBcBBAouSBwhMtzknDvKQttRSgzFn5SdVAQzU/lG
	 ROyO3JEzeYyXOlr8yPSSvSuceFc5cZj+Sn3T4aQ11P+sNTCBJWshM8zMhdAz92qkXv
	 Y4o2HLI8QS4CFE48JiyyoaUvJ3mwUelIKKicRkIHD/RWcpOpBl3cJnpMQxiYhzPRBw
	 mj1yv/kaiw27A==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com,
	lucerop@amd.com,
	a.manzanares@samsung.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com,
	armbru@redhat.com,
	linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	dave@stgolabs.net
Subject: [PATCH 2/5] hw/cxl: Refactor component register initialization
Date: Mon, 29 Sep 2025 20:21:50 -0700
Message-Id: <20250930032153.1127773-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250930032153.1127773-1-dave@stgolabs.net>
References: <20250930032153.1127773-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <ira.weiny@intel.com>

CXL 3.2 8.2.4 Table 8-22 defines which capabilities are mandatory, not
permitted, or optional for each type of device.

cxl_component_register_init_common() uses a rather odd 'fall through'
mechanism to define each component register set.  This assumes that any
device or capability being added builds on the previous devices
capabilities.  This is not true as there are mutually exclusive
capabilities defined.  For example, downstream ports can not have snoop
but it can have Back Invalidate capable decoders.

Refactor this code to make it easier to add individual capabilities as
defined by a device type.  Any capability which is not specified by the
type is left NULL'ed out which complies with the packed nature of the
register array.

Update all spec references to 3.2.

No functional changes should be seen with this patch.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
[rebased, no RAS for HBs, r3.2 references]
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-component-utils.c   | 75 +++++++++++-----------------------
 include/hw/cxl/cxl_component.h | 33 ++++++++++-----
 2 files changed, 46 insertions(+), 62 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index ce42fa4a2946..a43d227336ca 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -289,32 +289,6 @@ void cxl_component_register_init_common(uint32_t *reg_state,
 {
     int caps = 0;
 
-    /*
-     * In CXL 2.0 the capabilities required for each CXL component are such
-     * that, with the ordering chosen here, a single number can be used to
-     * define which capabilities should be provided.
-     */
-    switch (type) {
-    case CXL2_DOWNSTREAM_PORT:
-    case CXL2_DEVICE:
-        /* RAS, Link */
-        caps = 2;
-        break;
-    case CXL2_UPSTREAM_PORT:
-    case CXL2_TYPE3_DEVICE:
-    case CXL2_LOGICAL_DEVICE:
-        /* + HDM */
-        caps = 3;
-        break;
-    case CXL2_ROOT_PORT:
-    case CXL2_RC:
-        /* + Extended Security, + Snoop */
-        caps = 5;
-        break;
-    default:
-        abort();
-    }
-
     memset(reg_state, 0, CXL2_COMPONENT_CM_REGION_SIZE);
 
     /* CXL Capability Header Register */
@@ -322,11 +296,12 @@ void cxl_component_register_init_common(uint32_t *reg_state,
     ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, VERSION,
         CXL_CAPABILITY_VERSION);
     ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, CACHE_MEM_VERSION, 1);
-    ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ARRAY_SIZE, caps);
 
 #define init_cap_reg(reg, id, version)                                        \
     do {                                                                      \
-        int which = R_CXL_##reg##_CAPABILITY_HEADER;                          \
+        int which = CXL_##reg##_CAP_HDR_IDX;                                  \
+        if (CXL_##reg##_CAP_HDR_IDX > caps)                                   \
+            caps = CXL_##reg##_CAP_HDR_IDX;                                   \
         reg_state[which] = FIELD_DP32(reg_state[which],                       \
                                       CXL_##reg##_CAPABILITY_HEADER, ID, id); \
         reg_state[which] =                                                    \
@@ -337,37 +312,35 @@ void cxl_component_register_init_common(uint32_t *reg_state,
                        CXL_##reg##_REGISTERS_OFFSET);                         \
     } while (0)
 
+    /* CXL r3.2 8.2.4 Table 8-22 */
     switch (type) {
-    case CXL2_DEVICE:
-    case CXL2_TYPE3_DEVICE:
-    case CXL2_LOGICAL_DEVICE:
     case CXL2_ROOT_PORT:
+    case CXL2_RC:
+        /* + Extended Security, + Snoop */
+        init_cap_reg(EXTSEC, 6, 1);
+        init_cap_reg(SNOOP, 8, 1);
+        /* fallthrough */
     case CXL2_UPSTREAM_PORT:
+    case CXL2_TYPE3_DEVICE:
+    case CXL2_LOGICAL_DEVICE:
+        /* + HDM */
+        init_cap_reg(HDM, 5, 1);
+        hdm_init_common(reg_state, write_msk, type);
+        /* fallthrough */
     case CXL2_DOWNSTREAM_PORT:
-    init_cap_reg(RAS, 2, CXL_RAS_CAPABILITY_VERSION);
-        ras_init_common(reg_state, write_msk);
+    case CXL2_DEVICE:
+        /* RAS, Link */
+        if (type != CXL2_RC) {
+            init_cap_reg(RAS, 2, 2);
+            ras_init_common(reg_state, write_msk);
+        }
+        init_cap_reg(LINK, 4, 2);
         break;
     default:
-        break;
-    }
-
-    init_cap_reg(LINK, 4, CXL_LINK_CAPABILITY_VERSION);
-
-    if (caps < 3) {
-        return;
-    }
-
-    if (type != CXL2_ROOT_PORT) {
-        init_cap_reg(HDM, 5, CXL_HDM_CAPABILITY_VERSION);
-        hdm_init_common(reg_state, write_msk, type);
-    }
-    if (caps < 5) {
-        return;
+        abort();
     }
 
-    init_cap_reg(EXTSEC, 6, CXL_EXTSEC_CAP_VERSION);
-    init_cap_reg(SNOOP, 8, CXL_SNOOP_CAP_VERSION);
-
+    ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ARRAY_SIZE, caps);
 #undef init_cap_reg
 }
 
diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index b721333cb7aa..cd92cb02532a 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -32,10 +32,20 @@ enum reg_type {
 };
 
 /*
- * Capability registers are defined at the top of the CXL.cache/mem region and
- * are packed. For our purposes we will always define the caps in the same
- * order.
- * CXL r3.1 Table 8-22: CXL_CAPABILITY_ID Assignment for details.
+ * CXL r3.2 - 8.2.4 Table 8-22 and 8-23
+ *
+ * Capability registers are defined at the top of the CXL.cache/mem region.
+ * They are defined to be packed and at variable offsets.  However, NULL
+ * capabilities can be added to the packed array.  To facilitate easier access
+ * within the QEMU code, define these at specified offsets.  Then NULL out any
+ * capabilities for devices which don't (or can't) have a particular capability
+ * (see cxl_component_register_init_common).  NULL capabilities are to be
+ * ignored by software.
+ *
+ * 'offsets' are based on index's which can then be used to report the array
+ * size in CXL Capability Header Register (index/offset 0).
+ *
+ * See CXL r3.2 Table 8-25 for an example of allowing a 'NULL' header.
  */
 
 /* CXL r3.1 Section 8.2.4.1: CXL Capability Header Register */
@@ -46,16 +56,17 @@ REG32(CXL_CAPABILITY_HEADER, 0)
     FIELD(CXL_CAPABILITY_HEADER, CACHE_MEM_VERSION, 20, 4)
     FIELD(CXL_CAPABILITY_HEADER, ARRAY_SIZE, 24, 8)
 
-#define CXLx_CAPABILITY_HEADER(type, offset)                  \
-    REG32(CXL_##type##_CAPABILITY_HEADER, offset)             \
+#define CXLx_CAPABILITY_HEADER(type, idx)                     \
+    enum { CXL_##type##_CAP_HDR_IDX = idx };                  \
+    REG32(CXL_##type##_CAPABILITY_HEADER, (idx * 0x4))        \
         FIELD(CXL_##type##_CAPABILITY_HEADER, ID, 0, 16)      \
         FIELD(CXL_##type##_CAPABILITY_HEADER, VERSION, 16, 4) \
         FIELD(CXL_##type##_CAPABILITY_HEADER, PTR, 20, 12)
-CXLx_CAPABILITY_HEADER(RAS, 0x4)
-CXLx_CAPABILITY_HEADER(LINK, 0x8)
-CXLx_CAPABILITY_HEADER(HDM, 0xc)
-CXLx_CAPABILITY_HEADER(EXTSEC, 0x10)
-CXLx_CAPABILITY_HEADER(SNOOP, 0x14)
+CXLx_CAPABILITY_HEADER(RAS, 1)
+CXLx_CAPABILITY_HEADER(LINK, 2)
+CXLx_CAPABILITY_HEADER(HDM, 3)
+CXLx_CAPABILITY_HEADER(EXTSEC, 4)
+CXLx_CAPABILITY_HEADER(SNOOP, 5)
 
 /*
  * Capability structures contain the actual registers that the CXL component
-- 
2.39.5

