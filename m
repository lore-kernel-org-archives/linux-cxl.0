Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A94D272
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jan 2024 12:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706270830; cv=none; b=DBBG7mE6l9JNM88AZ+xq6tCbtq4se2IBhR8BoAxAiQNuLKJx6wiJkc0CW030e/SH2SUiw5qjvLxqNGUgI0I9W0dKtaOHlSW58YFCg1SbBPiGL/BU6QAstp6TvDOREyIXmwiyti+S1kVfCPHVqegJkFzi47t0jKaq1bSqeLHwof0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706270830; c=relaxed/simple;
	bh=J6bB1XGVfGL4OvHjGaeklVaOb2sPtyU3XCyhO6IE2I0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oKXz+Mz1jsH/Oj68ZKFVtvrszE0rnmH81Jf3cWFXBXN/2R5dLoYUa/C1FQ3A+zSwfKcesD7IDS5vgkPxAKkMz5SGfGhTos63rx3OW063CV0eLxOB+oKuo7iN0RvcItvrxVUEIyLlEu0uJrYy+SRh8xXKsbz45kcoh5duAbRHPDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TLxF30X7hz67LSb;
	Fri, 26 Jan 2024 20:04:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BC031400E7;
	Fri, 26 Jan 2024 20:07:06 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 12:07:06 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Fan Ni
	<fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>
CC: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	<peter.maydell@linaro.org>, Davidlohr Bueso <dave@stgolabs.net>, Hyeonggon
 Yoo <42.hyeyoo@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, Stefan
 Hajnoczi <stefanha@gmail.com>, <linuxarm@huawei.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 11/12] hw/i386: Fix _STA return value for ACPI0017
Date: Fri, 26 Jan 2024 12:01:31 +0000
Message-ID: <20240126120132.24248-12-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240126120132.24248-1-Jonathan.Cameron@huawei.com>
References: <20240126120132.24248-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

