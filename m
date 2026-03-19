Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C58176ADE;
	Thu, 19 Mar 2026 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773906382; cv=none; b=mpiwZrvq37lfTgwtKzOf9V8QPzPzgqKsATX2WeVEagPTHZyEr6gKjfkk+vQ2883U3ZcKR4rfwWEy1u65L4B9trfp/PYaVUbahQI1WJ39LH4x33D0vFAS9GNaJKBmFi65sGfB+oEyI4Oq+qRgzW1m6ThyaCGyCCquAONmSbVEPfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773906382; c=relaxed/simple;
	bh=XqZSHpYYzipB1IHthha7vgG8dy5nZmZVM+wKVycO9gg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LW2CkMu43+18cbGozu0PEfZ0WZWfUorzqIe7ta7FkTypCuZaR9iB1ifwy4Q/MzuwAZoKE61FwuHxWdztjhHaENsCAX1RafujSGUL9s/FgWrN3QfUS+E6ZWzI3PzhCPRDMNPYSUwOGOmQmuCW3TIbdoryF3LDHe+sYAviqc374y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCHaGCtqbtpcuRGCA--.108S2;
	Thu, 19 Mar 2026 15:45:49 +0800 (CST)
Received: from localhost.localdomain (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAf8DwwZKgqbtpLLECAA--.6495S2;
	Thu, 19 Mar 2026 15:45:36 +0800 (CST)
From: Cui Chao <cuichao1753@phytium.com.cn>
To: Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Yinfeng <wangyinfeng@phytium.com.cn>
Subject: [PATCH] cxl: Adjust the startup priority of cxl_pmem to be higher than that of cxl_acpi
Date: Thu, 19 Mar 2026 15:45:35 +0800
Message-Id: <20260319074535.1709250-1-cuichao1753@phytium.com.cn>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DwwZKgqbtpLLECAA--.6495S2
X-CM-SenderInfo: pfxlux1drrlkut6sx5pwlxzhxfrphubq/1tbiAQATAGm6+-cDZgAAso
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=cuichao175
	3@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7tr4DZw17uF4kXr4fZF1UKFg_yoW8Wry5pF
	Z7WFyYvrykK3y7Aa12qayDuF909ayxZFW8Ca4DJwnI9r15JFyDZrW3ta40va4UXrWkXa1a
	y34Yyr95uw4DZFDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

During the cxl_acpi probe process, it checks whether the cxl_nvb device
and driver have been attached. Currently, the startup priority of the
cxl_pmem driver is lower than that of the cxl_acpi driver. At this point,
the cxl_nvb driver has not yet been registered on the cxl_bus, causing
the attachment check to fail. This results in a failure to add the root
nvdimm bridge, leading to a cxl_acpi probe failure and ultimately
affecting the subsequent loading of cxl drivers. As a consequence, only
one mem device object exists on the cxl_bus, while the cxl_port device
objects and decoder device objects are missing.

The solution is to raise the startup priority of cxl_pmem to be higher
than that of cxl_acpi, ensuring that the cxl_pmem driver is registered
before the aforementioned attachment check occurs.

Co-developed-by: Wang Yinfeng <wangyinfeng@phytium.com.cn>
Signed-off-by: Wang Yinfeng <wangyinfeng@phytium.com.cn>
Signed-off-by: Cui Chao <cuichao1753@phytium.com.cn>
---
 drivers/cxl/pmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 082ec0f1c3a0..261dff7ced9f 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -554,7 +554,7 @@ static __exit void cxl_pmem_exit(void)
 
 MODULE_DESCRIPTION("CXL PMEM: Persistent Memory Support");
 MODULE_LICENSE("GPL v2");
-module_init(cxl_pmem_init);
+subsys_initcall(cxl_pmem_init);
 module_exit(cxl_pmem_exit);
 MODULE_IMPORT_NS("CXL");
 MODULE_ALIAS_CXL(CXL_DEVICE_NVDIMM_BRIDGE);
-- 
2.33.0

