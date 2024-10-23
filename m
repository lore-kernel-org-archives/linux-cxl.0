Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894AF1AA7BA;
	Wed, 23 Oct 2024 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729681638; cv=none; b=j4gZGQKBX+Q8GnRp5voadAZeih0AcmNyv5mY8xHH7xH7W1LEZB8qjnPzhK5NDdzrcxchxU5Wj6wZGMAtytgzG7v2k7jf5YNTtqBOHJDG06DXB/nDJWNgStmnr5kvxWE2CiqbrOECrMhNcR/+lTQ7SoLUwA67Y50M5UgkwPnyT1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729681638; c=relaxed/simple;
	bh=mi70kcDphTiQwmKh0IHHItVf19ur31jfbMVASfM3TMg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WqZYqZFuHRiGcgcjmAbf+oilx91dIvYpZk/+VZflIYORec7MFxOpMUPy8cGJKjAGi9VzAtmWwjGr47mtqe+4SB2ysg+DiEKlo2ZbE1v6sXktVH7nYa78FGOS+Qw+C9RMwKxSRfJsLH7tzs727VcsUNSTWhEZs4poSiBmzKPg4ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XYR6f5ksNz1SDFP;
	Wed, 23 Oct 2024 19:05:46 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E9C518002B;
	Wed, 23 Oct 2024 19:07:10 +0800 (CST)
Received: from huawei.com (10.67.175.84) by kwepemd200012.china.huawei.com
 (7.221.188.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Wed, 23 Oct
 2024 19:07:09 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>, <quzicheng@huawei.com>
Subject: [PATCH] cxl: core-pmu: Fix the usage of uninitialized variable
Date: Wed, 23 Oct 2024 10:56:10 +0000
Message-ID: <20241023105610.668964-1-quzicheng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200012.china.huawei.com (7.221.188.145)

In the devm_cxl_pmu_add() function, the variable rc might be
uninitialized before its first use 'if (rc) goto err', leading
to undefined behavior since its value depends on the compiler.
Currently, the switch statement is limited to the CXL_PMU_MEMDEV type.
If additional types are introduced, it could lead to similar concerns.
If the type range remains unchanged, using a switch case is unnecessary.
To enhance code extensibility and stability, it is recommended to
address this potential aspect.

Cc: stable@vger.kernel.org # v6.6+
Fixes: 1ad3f701c399 ("cxl/pci: Find and register CXL PMU devices")
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
---
 drivers/cxl/core/pmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/core/pmu.c b/drivers/cxl/core/pmu.c
index 5d8e06b0ba6e..2d12887c9915 100644
--- a/drivers/cxl/core/pmu.c
+++ b/drivers/cxl/core/pmu.c
@@ -51,6 +51,9 @@ int devm_cxl_pmu_add(struct device *parent, struct cxl_pmu_regs *regs,
 	case CXL_PMU_MEMDEV:
 		rc = dev_set_name(dev, "pmu_mem%d.%d", assoc_id, index);
 		break;
+	default:
+		rc = -EINVAL;
+		break;
 	}
 	if (rc)
 		goto err;
-- 
2.34.1

