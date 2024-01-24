Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B72A1AAD7
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100402; cv=none; b=psXuvgJ5anqRixsPRsgZQRvUpDXubjrxpVmrCCmhUoLmyY/Xheu9qosQor37+qAqd9/6x2mEiVMMYmc0kgO80R4rgFca7V8doV4hfU00w7smHfZVrxmjGDeACGxV9ze+QZiN9g44pJ+uVQXla1YS+V3/G1Tsj8S1ore5NdhwrZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100402; c=relaxed/simple;
	bh=J6bB1XGVfGL4OvHjGaeklVaOb2sPtyU3XCyhO6IE2I0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+X3nULvFVnWMhJ8TmJRhcMJmDc3a8ThJN19MK9iRbZupAaLRlKJw1tZbLphE2twlNwRl9cVHFT0TxMathK+r97ZZvgelHJsmPEz0HIOt/qKctf2Sz9hgYTb7SPAsNGrP578tYKBIm3YFr61ZQkulp7VnaRvwd+/tO6fXkfKnDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TKkCd43zyz6K9N9;
	Wed, 24 Jan 2024 20:43:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 32B84140390;
	Wed, 24 Jan 2024 20:46:38 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 12:46:37 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Fan Ni
	<fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>
CC: Ira Weiny <ira.weiny@intel.com>, Huai-Cheng Kuo
	<hchkuo@avery-design.com.tw>, Dave Jiang <dave.jiang@intel.com>, Peter
 Maydell <peter.maydell@linaro.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>,
	Stefan Hajnoczi <stefanha@gmail.com>, <linuxarm@huawei.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 11/12] hw/i386: Fix _STA return value for ACPI0017
Date: Wed, 24 Jan 2024 12:40:59 +0000
Message-ID: <20240124124100.8218-12-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124124100.8218-1-Jonathan.Cameron@huawei.com>
References: <20240124124100.8218-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Found whilst testing a series for the linux kernel that actually
bothers to check if enabled is set. 0xB is the option used
for vast majority of DSDT entries in QEMU.
It is a little odd for a device that doesn't really exist and
is simply a hook to tell the OS there is a CEDT table but 0xB
seems a reasonable choice and avoids need to special case
this device in the OS.

Means:
* Device present.
* Device enabled and decoding it's resources.
* Not shown in UI
* Functioning properly
* No battery (on this device!)

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/i386/acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index edc979379c..e3e9afd376 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1415,7 +1415,7 @@ static void build_acpi0017(Aml *table)
     aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0017")));
 
     method = aml_method("_STA", 0, AML_NOTSERIALIZED);
-    aml_append(method, aml_return(aml_int(0x01)));
+    aml_append(method, aml_return(aml_int(0x0B)));
     aml_append(dev, method);
     build_cxl_dsm_method(dev);
 
-- 
2.39.2

