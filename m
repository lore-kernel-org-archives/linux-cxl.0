Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864E828E31
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143055; cv=none; b=aGPuYXTB1vFRrMjGQxV3gyL0JIbdwBGu7nW3x1+JGz6t2XOWuIj53NH3gIDhBHgd8VaoA+e4RpxOEmDk/NIHylfr5rAG9eCprK15X17yoiyPj6i3QylAqv5lOAondQE2TaBTd3Npa4F30YKWTsfr+Wyb1KObSbEDvqPH9oHUZxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143055; c=relaxed/simple;
	bh=S8XvIHTD3nYa8NvXZNSZ2nprFOwzyl78JOd7j5aNAmQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XfcMOPVNHYF++9vesz03TCj4KzxJ5a/Hjbu37im/wlbawhOw3LE8Vzj1sWUoJ7Pn0WIdv87UrzUJ7rP3p2zINCnoIEEXO8upf4FUnH4Jt8YYoaKJi3C0wf1p9fvBgc2+C68Q7ron7Gz0tYRDrDa8D4bhW4K8zBV1IZaRoXsBi6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TT7nx2FVLz6JB89;
	Mon,  5 Feb 2024 22:20:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 80801140A87;
	Mon,  5 Feb 2024 22:24:11 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 14:24:10 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
CC: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Dongjiu Geng
	<gengdongjiu1@gmail.com>, <linuxarm@huawei.com>, "Michael S . Tsirkin"
	<mst@redhat.com>, Ira Weiny <ira.weiny@intel.com>, Peter Maydell
	<peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>, Marcel Apfelbaum
	<marcel.apfelbaum@gmail.com>
Subject: [RFC PATCH 09/11] cxl/ras: Set registers to sensible state for FW first ras
Date: Mon, 5 Feb 2024 14:19:38 +0000
Message-ID: <20240205141940.31111-10-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240205141940.31111-1-Jonathan.Cameron@huawei.com>
References: <20240205141940.31111-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Even if we are doing native RAS, until the point where the OS
requests it via an _OSC the firmware may well be handling any
errors from CXL devices.  As such configure them as if a firmware
has been doing so.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-component-utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index a0ff7d4396..e869c482a7 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -217,13 +217,13 @@ static void ras_init_common(uint32_t *reg_state, uint32_t *write_msk)
     stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_STATUS, 0);
     stl_le_p(write_msk + R_CXL_RAS_UNC_ERR_STATUS, 0x1cfff);
     /* Bits 12-13 and 17-31 reserved in CXL 2.0 */
-    stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_MASK, 0x1cfff);
+    stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_MASK, 0/*0x1cfff*/);
     stl_le_p(write_msk + R_CXL_RAS_UNC_ERR_MASK, 0x1cfff);
     stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_SEVERITY, 0x1cfff);
     stl_le_p(write_msk + R_CXL_RAS_UNC_ERR_SEVERITY, 0x1cfff);
     stl_le_p(reg_state + R_CXL_RAS_COR_ERR_STATUS, 0);
     stl_le_p(write_msk + R_CXL_RAS_COR_ERR_STATUS, 0x7f);
-    stl_le_p(reg_state + R_CXL_RAS_COR_ERR_MASK, 0x7f);
+    stl_le_p(reg_state + R_CXL_RAS_COR_ERR_MASK, 0/*0x7f*/);
     stl_le_p(write_msk + R_CXL_RAS_COR_ERR_MASK, 0x7f);
     /* CXL switches and devices must set */
     stl_le_p(reg_state + R_CXL_RAS_ERR_CAP_CTRL, 0x200);
-- 
2.39.2

