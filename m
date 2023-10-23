Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D261A583
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 14:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF87C2
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 07:04:45 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SDcM02B1vz6K6Wb;
	Mon, 23 Oct 2023 22:02:04 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 23 Oct 2023 15:04:42 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
	<mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
CC: <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 5/5] hw/cxl: Fix a QEMU_BUILD_BUG_ON() in switch statement scope issue.
Date: Mon, 23 Oct 2023 15:02:10 +0100
Message-ID: <20231023140210.3089-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231023140210.3089-1-Jonathan.Cameron@huawei.com>
References: <20231023140210.3089-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected

As _Static_assert is a declaration, it can't follow a label until C23.
Some older versions of GCC trip up on this one.

This check has no obvious purpose so just remove it.

Reported-by: Jeongtae Park <jtp.park@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-component-utils.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 5ebd81daf3..d0245cc55d 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -305,7 +305,6 @@ void cxl_component_register_init_common(uint32_t *reg_state,
     ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ARRAY_SIZE, caps);
 
 #define init_cap_reg(reg, id, version)                                        \
-    QEMU_BUILD_BUG_ON(CXL_##reg##_REGISTERS_OFFSET == 0);                     \
     do {                                                                      \
         int which = R_CXL_##reg##_CAPABILITY_HEADER;                          \
         reg_state[which] = FIELD_DP32(reg_state[which],                       \
-- 
2.39.2

