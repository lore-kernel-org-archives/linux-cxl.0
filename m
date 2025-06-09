Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F05321B182
	for <linux-cxl@vger.kernel.org>; Mon,  9 Jun 2025 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486944; cv=none; b=A8qCgd1O7cGuyiOuKSIceYyru56WG0q+f31m/FnrAS+jz+Uc0no5aSaN5z+5/xFX9bd22wXZ8t83CLtIASDpoB50V7sM3TNGwyFGHuRhksUIcTwccEYbnSemAcGYtIsG44e/Nnaw+FI8w7U/MRm4YMSprVSP9WZI2KU0Cy/bVC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486944; c=relaxed/simple;
	bh=aNzMneRIo4zt5J8y6blBWr8Xq5FEcQagrs3lsUVHxwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8ATZCJ2Ij0CyTDclHAfgMaazWlMgSSeFO99sCBBw98FMsN6amlnisos7GsConLIfWtz38nI0TKeASiUyjOD4s4ao0MgNd0bewVd9BDm82sYxymp9/nO6iHLBJVs5mxgOjfj4YQtW3s+MdU5sjnWywuLD6V/P9WIOEuiMKLW9+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bGHVl688pz6L5LT;
	Tue, 10 Jun 2025 00:31:27 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5559F1400D3;
	Tue, 10 Jun 2025 00:35:40 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Jun 2025 18:35:39 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Klaus Jensen <k.jensen@samsung.com>, <cminyard@mvista.com>, Fan Ni
	<fan.ni@samsung.com>, Anisa Su <anisa.su@samsung.com>,
	<qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <mst@redhat.com>
CC: <linuxarm@huawei.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
	<philmd@linaro.org>
Subject: [RFC PATCH qemu 4/5] docs: cxl: Add example commandline for MCTP CXL CCIs
Date: Mon, 9 Jun 2025 17:33:32 +0100
Message-ID: <20250609163334.922346-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250609163334.922346-1-Jonathan.Cameron@huawei.com>
References: <20250609163334.922346-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

Add initial documentation for the MCTP over I2C management device. At
current time this can only be used with the Aspeed I2C controller which
is only available in aspeed SoCs, though can be added to other
emulated boards.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 docs/system/devices/cxl.rst | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index e307caf3f8..523f99f205 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -406,6 +406,33 @@ OS management of CXL memory devices as described here.
 * CONFIG_CXL_PORT
 * CONFIG_CXL_REGION
 
+
+CCI access via MCTP over I2C
+----------------------------
+
+In order to make use of this device, an I2C controller that supports MCTP
+is required.  The aspeed-i2c controller is an example of such a controller.
+
+Both CXL switches and CXL Type 3 devices support configuration via
+MCTP access to Component Command Interfaces (CCIs) on the devices.
+
+Example configuration:
+
+ -device cxl-upstream,port=33,bus=root_port0,id=us0,multifunction=on,addr=0.0,sn=12345678 \
+ -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
+ -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
+ -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
+ -device cxl-type3,bus=swport0,persistent-memdev=cxl-mem1,id=cxl-pmem0,lsa=cxl-lsa1,sn=3 \
+ -device cxl-type3,bus=swport1,persistent-memdev=cxl-mem2,id=cxl-pmem1,lsa=cxl-lsa2,sn=4 \
+ -device cxl-type3,bus=swport2,persistent-memdev=cxl-mem3,id=cxl-pmem2,lsa=cxl-lsa3,sn=5 \
+ -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=4,target=us0 \
+ -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=5,target=cxl-pmem0 \
+ -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=6,target=cxl-pmem1 \
+ -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=7,target=cxl-pmem2
+
+Guest OS communication with the MCTP CCI can then be established using standard
+MCTP configuration tools.
+
 References
 ----------
 
-- 
2.48.1

