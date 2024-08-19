Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D29F15ADB3;
	Mon, 19 Aug 2024 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068350; cv=none; b=L9879P3qC/v7OvMrLeB00A5TXck1w7d2wFb0p0SCHC4huqpbgoSfp2LJD3oYJtAuwxmtII4PfNs+ZA8bUacAle4sgM7+U4YMNx9fAscaAOxaYJs1IuuI+gS45jtKswGfwk32cmcEI5rkQnBixd9TCy9JqEe+WXU/oeesJVc0lnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068350; c=relaxed/simple;
	bh=hVOqUFy1+dB9W06IrQ+w2ZsS/38uCKMXft1cGUTuNOA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FACZ8Q9G6v3a+hgjEpL2rssby9Pz10ZeuOCiqGm2sXdJyUpvgHruKU8PzU5C4DzKEZrnwM9AEK1Z29Qoc2YwFLLulYyiNn0+UKNKo1M3GRhozbsAY/r9oA6NzoOH0NRDfRlZq63JKe2yiT+IrADPIGd0ZDr7U8u/fwTloDJN4Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WnW8p5XRgz1HGm9;
	Mon, 19 Aug 2024 19:49:14 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id A94DB1401F2;
	Mon, 19 Aug 2024 19:52:24 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 Aug
 2024 19:52:24 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 1/8] dax/bus.c: Make dax_region_rwsem and dax_dev_rwsem static
Date: Mon, 19 Aug 2024 19:59:44 +0800
Message-ID: <20240819115944.3884827-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)

The sparse tool complains as follows:

drivers/dax/bus.c:19:1: warning:
	symbol 'dax_region_rwsem' was not declared. Should it be static?

drivers/dax/bus.c:25:1: warning:
	symbol 'dax_dev_rwsem' was not declared. Should it be static?

These symbols are not used outside bus.c, so marks them static.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/dax/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index fde29e0ad68b..e783e14a99b2 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -16,13 +16,13 @@ static DEFINE_MUTEX(dax_bus_lock);
  * All changes to the dax region configuration occur with this lock held
  * for write.
  */
-DECLARE_RWSEM(dax_region_rwsem);
+static DECLARE_RWSEM(dax_region_rwsem);
 
 /*
  * All changes to the dax device configuration occur with this lock held
  * for write.
  */
-DECLARE_RWSEM(dax_dev_rwsem);
+static DECLARE_RWSEM(dax_dev_rwsem);
 
 #define DAX_NAME_LEN 30
 struct dax_id {
-- 
2.34.1

