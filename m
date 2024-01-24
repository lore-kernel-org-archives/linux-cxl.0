Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE6177F1A
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706104189; cv=none; b=OjBMYkbYqCJPvZZziVnimqMm/SfmnopczsgQn7Iv5sWB/z69QHh16tDuzQRB0gUoYuk8gAQlgzSEE0cZU0xRvrdRoWfsFbniHJi8iYfMQFYCVTyCEaL4U4OltUztsLxnyVuAtlmcoMvzyf7vfTAHHmhhDS+68/KY5zx3NLjiiK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706104189; c=relaxed/simple;
	bh=RuCtAV8ry72ooxHsctiGFnXOKrWtIKlT6a8lYc1I094=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BAxpCu2/TL2PwYt8hjo5++NlljVRjJXE7hot9ZBDEp7rMcFF2uOVkkPt3SKfk+BJz0ir+If4IT59N7DhfuN5gUjnx+nk0dHOxM9G4956rgI+jkuIt+KfdClNZnSfvKo8CrwwYyfiBUcPQrPM3JA2PpZd4jdmcLmi/3iwK9x96X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TKlcS02F2z6K93k;
	Wed, 24 Jan 2024 21:46:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id AE367140B63;
	Wed, 24 Jan 2024 21:49:44 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 13:49:44 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Fan Ni
	<fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, <linuxarm@huawei.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/5] hw/cxl: Update RAS Capability Definitions for version 3.
Date: Wed, 24 Jan 2024 13:48:12 +0000
Message-ID: <20240124134814.8717-4-Jonathan.Cameron@huawei.com>
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

Part of bringing all of CXL emulation inline with CXL r3.1.
No functional changes.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_component.h | 5 ++++-
 hw/cxl/cxl-component-utils.c   | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 2c7631bd1e..b5da72b789 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -60,8 +60,9 @@ CXLx_CAPABILITY_HEADER(SNOOP, 0x14)
  * implements. Some of these are specific to certain types of components, but
  * this implementation leaves enough space regardless.
  */
-/* 8.2.5.9 - CXL RAS Capability Structure */
 
+/* CXL r3.1 Section 8.2.4.17: CXL RAS Capability Structure */
+#define CXL_RAS_CAPABILITY_VERSION 3
 /* Give ample space for caps before this */
 #define CXL_RAS_REGISTERS_OFFSET 0x80
 #define CXL_RAS_REGISTERS_SIZE   0x58
@@ -95,6 +96,8 @@ REG32(CXL_RAS_COR_ERR_STATUS, CXL_RAS_REGISTERS_OFFSET + 0xc)
 REG32(CXL_RAS_COR_ERR_MASK, CXL_RAS_REGISTERS_OFFSET + 0x10)
 REG32(CXL_RAS_ERR_CAP_CTRL, CXL_RAS_REGISTERS_OFFSET + 0x14)
     FIELD(CXL_RAS_ERR_CAP_CTRL, FIRST_ERROR_POINTER, 0, 6)
+    FIELD(CXL_RAS_ERR_CAP_CTRL, MULTIPLE_HEADER_RECORDING_CAP, 9, 1)
+    FIELD(CXL_RAS_ERR_POISON_ENABLED, POISON_ENABLED, 13, 1)
 REG32(CXL_RAS_ERR_HEADER0, CXL_RAS_REGISTERS_OFFSET + 0x18)
 #define CXL_RAS_ERR_HEADER_NUM 32
 /* Offset 0x18 - 0x58 reserved for RAS logs */
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index a55cf5a036..848bfa20f1 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -325,7 +325,7 @@ void cxl_component_register_init_common(uint32_t *reg_state,
                        CXL_##reg##_REGISTERS_OFFSET);                         \
     } while (0)
 
-    init_cap_reg(RAS, 2, 2);
+    init_cap_reg(RAS, 2, CXL_RAS_CAPABILITY_VERSION);
     ras_init_common(reg_state, write_msk);
 
     init_cap_reg(LINK, 4, 2);
-- 
2.39.2

