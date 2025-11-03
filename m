Received: from fossa.ash.relay.mailchannels.net (fossa.ash.relay.mailchannels.net [23.83.222.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D7229D293
	for <linux-cxl@vger.kernel.org>; Mon,  3 Nov 2025 19:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762199604; cv=pass; b=Gie+VL+QE6xkUVDF703bzuKjvCZ9yNMDHqrJ/hqZqvhH1mOrctwA22L8wqpHI1jS1/2BYkRAdYvGbI+gl9uVW4tEUYvQC8ImiZt7vKYTDNRhEOFRByKW6K2/MgHK5bQk0KDYKCLR8t+gbSsYb0BB8tQ93JQWEJivhogGa4wUFHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762199604; c=relaxed/simple;
	bh=OtN8b+ZR7RlPAxDoRPwbe+BUJ3st+I1FDVCWzrjEHn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OlgqPUaASbUQuop4zNNm3OuQr0QtxRsF7EHfg7+1gy9HWdilswjtequsTP5lx4P7tqgsrZW3WP0KYgI/b7NfwLaWeQuLUwt4KTuOq4JwnK42YCMmJbMHX26souN3EgvHcQ+9FwqJUj5lJWQrdSrN4HA1CM7OEFonzs2RLHvZ++Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=ieZRFOj3; arc=pass smtp.client-ip=23.83.222.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="ieZRFOj3"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 36125922004;
	Mon, 03 Nov 2025 19:53:15 +0000 (UTC)
Received: from pdx1-sub0-mail-a475.dreamhost.com (100-123-83-250.trex-nlb.outbound.svc.cluster.local [100.123.83.250])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id CA89D921CF5;
	Mon, 03 Nov 2025 19:53:14 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1762199594; a=rsa-sha256;
	cv=none;
	b=riZlj1mZmrTIZqR1VaSpoSlclU7ng9I1cz51O3Cc88o9m0FE6fwHlMO3TTyRTpATsxff+7
	0e4W1qBKhoSs9PX5EWmwjffGgzaRsQ0w/0AK1r4HmxPmxsDV7jUP2xqFR+oWhLTbHgx5va
	aDgmu8tJ/olrCfraYqAYQCaGUnedW22SBWS5fUgL6Nyo47in7NOYFPLf7fX2VrDqdEubLY
	F+FKH5sr76duFuy6z+ruKJKr/gRtcqnr7oI7vrO9CsWAlvUxuAz8CzcBC7qy9oOc20Fw/O
	fIBel2Vk58IYtuNbmybHqnaQQ9od5qoCGX/vJ/CBoXb64Ad+XjSPnj7xXJAdhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1762199594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=jatlogUs8iGl5JgYc1mTqRweb/2D60opMqZNCIazvV0=;
	b=GsADgjs3y8TdnhXHo/hY7NVVN4J6CdikWFBotWPPkdzEaqUH/g+HGWuIB4BcStqRKwwEea
	buFgf83oiG2oflfkJTUhrl/9NdmHHMtAoHtJVS+KjVEaQA65EeiqYcIOGmVWDqjAOAfoeQ
	FD3ip0MEHgyr0ewFjYEAaAR74C7M+jzOaRK76vYqLrolUCeZH2dq6WRlRQkR8Dvlx22Kvk
	ZuqXN0MHTqCqAZQkn55tLzYivmPbGzZjOg7Ze0A2q7cx1FZ/jM6MErSnx0McH47Ice4Ca/
	4/X36w2aesfyI9syU6yqhwFn7X6pgUbNa+O0X/BdCNGIBTerQblfy8lF+Br6+w==
ARC-Authentication-Results: i=1;
	rspamd-768b565cdb-ldg28;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Hook-Cure: 7407d59a05b696d4_1762199595116_4211469106
X-MC-Loop-Signature: 1762199595116:2378479632
X-MC-Ingress-Time: 1762199595115
Received: from pdx1-sub0-mail-a475.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.123.83.250 (trex/7.1.3);
	Mon, 03 Nov 2025 19:53:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1762199594;
	bh=jatlogUs8iGl5JgYc1mTqRweb/2D60opMqZNCIazvV0=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=ieZRFOj3zEGcdGHfh2xJuixZG32MCRmFWBjgWY0ZPkUGrMLi+9wry6DzZmgEwsoPp
	 jgVH54eHWcSEfhyVJ3bieIk/1azBiuOAya3E9tAx6HzwvlF9iDm3e0z8dPLkxvowh8
	 RKoUlpd0na+sKEVUE2aFX1dEtbRK0arqVwH1VbCuoH6xnNHGK2gNVTcqnE05KlqmeL
	 wtNRHpnqEv8AfsTjIgi5k3GJ6Keu3F4LRDgXnLACelB5P+1BAT0JAULfn2tZK0M39t
	 nAy8KfcXV+OB/XxIbNhp0Nebtur8P+Ug98l5uAo2Ltp8qDyFznPuRpV+VvmCbwtpLB
	 RXdM20BjPDA8Q==
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a475.dreamhost.com (Postfix) with ESMTPSA id 4d0j1j48Knz1wdx;
	Mon,  3 Nov 2025 11:53:13 -0800 (PST)
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com,
	alucerop@amd.com,
	a.manzanares@samsung.com,
	dongjoo.seo1@samsung.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com,
	armbru@redhat.com,
	linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	dave@stgolabs.net
Subject: [PATCH 2/5] hw/cxl: Refactor component register initialization
Date: Mon,  3 Nov 2025 11:52:06 -0800
Message-Id: <20251103195209.1319917-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251103195209.1319917-1-dave@stgolabs.net>
References: <20251103195209.1319917-1-dave@stgolabs.net>
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
Tested-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
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

