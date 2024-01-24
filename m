Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616D28F72
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706104129; cv=none; b=pyJKe4mnrDZOkesQlqz9QD46bmcd07iFy78bjIwpqAio/xJtGhx9KAw3nQTTHN85h/A8uK8UfSFtI3ifNlInO1TpsT66DDsjQj36GvUBnG0wUrPpKLWs2IuAxGpmLyX/n253Gjdn+YNTr24OcS8AJNM/MxUVaauEt8awxLCdwiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706104129; c=relaxed/simple;
	bh=XRkBC5TovE0f7hpDDGPKUNv8ld6M/BCwApwIYlopfEk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HfgZjJ6gNmRempteu+Cp6R+LQ7zNf02dHxISfqefhY4/n9Pmot+y0GrPn3hNDw/v7RrvSM+PPoQwSu4zgo3BemGYbSIdTEYXJXl1eDvERsL9xYs9k69oW546GuuS1a0n16GK2bYoKpt8s/QnF2BWx9klz6KO7sb0UP/JViRhFd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TKlbF1bdVz6JB58;
	Wed, 24 Jan 2024 21:45:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 48CD0140A70;
	Wed, 24 Jan 2024 21:48:45 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 13:48:43 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Fan Ni
	<fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, <linuxarm@huawei.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/5] hw/cxl: Update HDM Decoder capability to version 3
Date: Wed, 24 Jan 2024 13:48:10 +0000
Message-ID: <20240124134814.8717-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124134814.8717-1-Jonathan.Cameron@huawei.com>
References: <20240124134814.8717-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Part of standardizing the QEMU code on CXL r3.1.
No fuctional changes as everything added is optional and
it is set as not implemented.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_component.h | 16 ++++++++++++++--
 hw/cxl/cxl-component-utils.c   | 10 +++++++++-
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 5227a8e833..7d3edef1bf 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -109,8 +109,9 @@ REG32(CXL_RAS_ERR_HEADER0, CXL_RAS_REGISTERS_OFFSET + 0x18)
     (CXL_SEC_REGISTERS_OFFSET + CXL_SEC_REGISTERS_SIZE)
 #define CXL_LINK_REGISTERS_SIZE   0x38
 
-/* 8.2.5.12 - CXL HDM Decoder Capability Structure */
-#define HDM_DECODE_MAX 10 /* 8.2.5.12.1 */
+/* CXL r3.1 Section 8.2.4.20: CXL HDM Decoder Capability Structure */
+#define HDM_DECODE_MAX 10 /* Maximum decoders for Devices */
+#define CXL_HDM_CAPABILITY_VERSION 3
 #define CXL_HDM_REGISTERS_OFFSET \
     (CXL_LINK_REGISTERS_OFFSET + CXL_LINK_REGISTERS_SIZE)
 #define CXL_HDM_REGISTERS_SIZE (0x10 + 0x20 * HDM_DECODE_MAX)
@@ -133,6 +134,11 @@ REG32(CXL_RAS_ERR_HEADER0, CXL_RAS_REGISTERS_OFFSET + 0x18)
             FIELD(CXL_HDM_DECODER##n##_CTRL, COMMITTED, 10, 1)                 \
             FIELD(CXL_HDM_DECODER##n##_CTRL, ERR, 11, 1)                       \
             FIELD(CXL_HDM_DECODER##n##_CTRL, TYPE, 12, 1)                      \
+            FIELD(CXL_HDM_DECODER##n##_CTRL, BI, 13, 1)                        \
+            FIELD(CXL_HDM_DECODER##n##_CTRL, UIO, 14, 1)                       \
+            FIELD(CXL_HDM_DECODER##n##_CTRL, UIG, 16, 4)                       \
+            FIELD(CXL_HDM_DECODER##n##_CTRL, UIW, 20, 4)                       \
+            FIELD(CXL_HDM_DECODER##n##_CTRL, ISP, 24, 4)                       \
   REG32(CXL_HDM_DECODER##n##_TARGET_LIST_LO,                                   \
         CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x24)                          \
   REG32(CXL_HDM_DECODER##n##_TARGET_LIST_HI,                                   \
@@ -148,6 +154,12 @@ REG32(CXL_HDM_DECODER_CAPABILITY, CXL_HDM_REGISTERS_OFFSET)
     FIELD(CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_256B, 8, 1)
     FIELD(CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_4K, 9, 1)
     FIELD(CXL_HDM_DECODER_CAPABILITY, POISON_ON_ERR_CAP, 10, 1)
+    FIELD(CXL_HDM_DECODER_CAPABILITY, 3_6_12_WAY, 11, 1)
+    FIELD(CXL_HDM_DECODER_CAPABILITY, 16_WAY, 12, 1)
+    FIELD(CXL_HDM_DECODER_CAPABILITY, UIO, 13, 1)
+    FIELD(CXL_HDM_DECODER_CAPABILITY, UIO_DECODER_COUNT, 16, 4)
+    FIELD(CXL_HDM_DECODER_CAPABILITY, MEMDATA_NXM_CAP, 20, 1)
+    FIELD(CXL_HDM_DECODER_CAPABILITY, SUPPORTED_COHERENCY_MODEL, 21, 2)
 REG32(CXL_HDM_DECODER_GLOBAL_CONTROL, CXL_HDM_REGISTERS_OFFSET + 4)
     FIELD(CXL_HDM_DECODER_GLOBAL_CONTROL, POISON_ON_ERR_EN, 0, 1)
     FIELD(CXL_HDM_DECODER_GLOBAL_CONTROL, HDM_DECODER_ENABLE, 1, 1)
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 5ddd47ed8d..a55cf5a036 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -243,6 +243,14 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_4K, 1);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
                      POISON_ON_ERR_CAP, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 3_6_12_WAY, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 16_WAY, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, UIO, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
+                     UIO_DECODER_COUNT, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, MEMDATA_NXM_CAP, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
+                     SUPPORTED_COHERENCY_MODEL, 0); /* Unknown */
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_GLOBAL_CONTROL,
                      HDM_DECODER_ENABLE, 0);
     write_msk[R_CXL_HDM_DECODER_GLOBAL_CONTROL] = 0x3;
@@ -326,7 +334,7 @@ void cxl_component_register_init_common(uint32_t *reg_state,
         return;
     }
 
-    init_cap_reg(HDM, 5, 1);
+    init_cap_reg(HDM, 5, CXL_HDM_CAPABILITY_VERSION);
     hdm_init_common(reg_state, write_msk, type);
 
     if (caps < 5) {
-- 
2.39.2

