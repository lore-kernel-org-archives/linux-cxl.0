Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590A228E2B
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143025; cv=none; b=bUHFYjKe/YtJuS9XZhPyRyprrDlPdRuDRXHMl6CyjS1RM7e5yVKNkeGtwMLGfVFlEdBFv84yukk5mN1c79EPk2ypjO1RY+uBVhpD9pN+wgvr08bYBploPoKdj6F7nc7LoCqyA8LbIMzNIqysaUtvPrdnT4bTo6mCciG6N30jdyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143025; c=relaxed/simple;
	bh=JGK80ZBR5xuhxe9SCfpzEH4CsieFiPbOUjP27q10zbY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kkcwthbFS47Q1dQUTAu3Zox6YAL/5Fr4fOWaUDWgvD8/aVWTFHMa97UkWgJANbYns5jGIO1QWBWD7h7EsOjUIeHtnsnKFJhejgZo7kH0yfetgPEyEdhAmO+7VIkhIaofmCs/BX3GY+gul7/ZgTlS+LRAWcggcvHgWyuXdCi58u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TT7nL5t8bz6JB1b;
	Mon,  5 Feb 2024 22:20:06 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 084581404F5;
	Mon,  5 Feb 2024 22:23:41 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 14:23:40 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
CC: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Dongjiu Geng
	<gengdongjiu1@gmail.com>, <linuxarm@huawei.com>, "Michael S . Tsirkin"
	<mst@redhat.com>, Ira Weiny <ira.weiny@intel.com>, Peter Maydell
	<peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>, Marcel Apfelbaum
	<marcel.apfelbaum@gmail.com>
Subject: [RFC PATCH 08/11] hw/pci/aer: Default to error handling on.
Date: Mon, 5 Feb 2024 14:19:37 +0000
Message-ID: <20240205141940.31111-9-Jonathan.Cameron@huawei.com>
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

This should be dependent on the platform supporting FW first.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/pci/pcie.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 9f1ca718b5..4f04a1702a 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -304,6 +304,12 @@ void pcie_cap_deverr_init(PCIDevice *dev)
     uint32_t pos = dev->exp.exp_cap;
     pci_long_test_and_set_mask(dev->config + pos + PCI_EXP_DEVCAP,
                                PCI_EXP_DEVCAP_RBER);
+
+    /* HACK - FW first settings - how to do this cleanly? */
+    pci_long_test_and_set_mask(dev->config + pos + PCI_EXP_DEVCTL,
+                               PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE |
+                               PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE);
+
     pci_long_test_and_set_mask(dev->wmask + pos + PCI_EXP_DEVCTL,
                                PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE |
                                PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE);
-- 
2.39.2

