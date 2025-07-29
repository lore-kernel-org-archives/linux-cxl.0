Received: from camel.aspen.relay.mailchannels.net (camel.aspen.relay.mailchannels.net [23.83.221.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DE6149C4D
	for <linux-cxl@vger.kernel.org>; Tue, 29 Jul 2025 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.221.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753808641; cv=pass; b=LhTmKwN9SqFWpcKHx4oEUIS20z4WlchRC3CwVKiMYUBNfHiivmvxM0xQSmQWyf/6QHG4hk0YPM8lp94cVHjGD/k6NjYTX77+KTAwgQ/oatryzXIlxtDwp1ZsPAT4gereIoiuEteeBvuB2Fe6ixP1b9OC3lrMNssNDrYORfyuWZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753808641; c=relaxed/simple;
	bh=iI7ED7Ui/d0fFOOSnrP5vidMJCyj0ag0tYz2BZ0CHWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oEMN3R07tF1r189OEHMJ/BXUyKDm2gB7gTzRMX7Fx+XLLbPf2tGhzXj0cByk5wqRMlOYw9y8rXZP+k4dVz2rvEK/tlopbheq+fiA7wlKgveRmd8Z5IZ5V4wu8ovQOVZmFm2DZviCCBpTF04zM81JRYfbkZJfswJjv+R486cUHmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=iUerdZrI; arc=pass smtp.client-ip=23.83.221.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="iUerdZrI"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 687F18A3E58;
	Tue, 29 Jul 2025 16:54:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a208.dreamhost.com (trex-blue-4.trex.outbound.svc.cluster.local [100.126.137.26])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id BCCDE8A36F9;
	Tue, 29 Jul 2025 16:54:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1753808098; a=rsa-sha256;
	cv=none;
	b=lsBv49TCAGMBaDC9TPz1ykJc5u5Uhs02Wmbg5NlVlKy6jh1UMN73AGF+IMelxmjHxtV/T8
	aVR++Toijt6SlM5MPYzm/ohkLYs2IEhIEUSQsEzbG+zLSZI8Ibs1oOapkcuZXwDVFhzc7r
	StrAay8KO8EdTY57UZGGVxjRNA6y15j5LIFqh7q1zEuwx8q7DGTjvOHoSJvo/rTx3Uv/I0
	RPJ8higPIoL1kJ9jM/f7ZgpUICh6/CWCjQ/4Iup1FoeqrXRz34sjBFGWFAzpqD27Njnm/z
	tTzioIX+0/CVRgz/YRDQ/mvKk2Lu2+lvhu9nXW4ATPhYKMNROZlHj/7sHOKtPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1753808098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=m3zmudrbJi3rUAWruVPmWJ/JHGSWiiguedxKVAHxwYo=;
	b=5es03teX/DKlrRhWGb/iHFTlx7GZFqQWZScBeSuL/FmWGx3WudLcMaY3R2vv8BySBTS+ca
	K3MqsKuZfgqbQdziDP52QF2u8ZZ/OlewmowFslyYqMLN4784bCSHxFMXqrBNUL5b7GlGhV
	RW3awTyYRr/o+Z5PAP0YrZSfuV0FC+iK65NyEyYyLpFhXGF2xNjJPa3/0dTLQGc2rqKRmv
	6vO0gAC8ZPuuBn+nGZa8fAOhhdx0et2XqnwApU86/lX/BPsP4YWzu9ay4o+7xDkFhqO8tZ
	+EYN45Gm0u4FrFpPTTW37ejZoOGIUvPs7zU4392tDotdi1JgMLZQA138C0oe6Q==
ARC-Authentication-Results: i=1;
	rspamd-696f8998d-ps5xn;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Bad
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Thoughtful-Trail: 58e523057b06f1b2_1753808099062_3055446933
X-MC-Loop-Signature: 1753808099062:1942783069
X-MC-Ingress-Time: 1753808099062
Received: from pdx1-sub0-mail-a208.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.126.137.26 (trex/7.1.3);
	Tue, 29 Jul 2025 16:54:59 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a208.dreamhost.com (Postfix) with ESMTPSA id 4bs1fp19SKzJl;
	Tue, 29 Jul 2025 09:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1753808098;
	bh=m3zmudrbJi3rUAWruVPmWJ/JHGSWiiguedxKVAHxwYo=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=iUerdZrID4hh9DkAxqdSFTvoaS2hdUskmlvYbPH4IzPa5Ohc+k/NBZAoUJtbPV6pk
	 Hyx9Pqkic1lukPDELa8kAbtyngh8VzopCdh74iDeASXid6CGEAwlF9jyUBEmU21HfW
	 t5IZxyNzp5UgGcGpzw2Su+GeJW/2l2Vhu58o/+uuW3T9NwVdQZ8hLlcGRiuuGr9w2Y
	 CB6UOHFeV+Lr98DHIrCaQ46h0oJDhzW+5hFlNkwEEGIHT3bq2KvQ9B7n980d0ETEbt
	 Zo89h65tX70cp+IMJSpHgXTTy9tY4Mc2Eh9qnNu9LCf4d43ZLyJ0TO6rcvggx/IiOd
	 kAV2q6sc92MFA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com,
	alucerop@amd.com,
	a.manzanares@samsung.com,
	linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 1/2] hw/cxl: Refactor component register initialization
Date: Tue, 29 Jul 2025 09:54:40 -0700
Message-Id: <20250729165441.1898150-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250729165441.1898150-1-dave@stgolabs.net>
References: <20250729165441.1898150-1-dave@stgolabs.net>
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

