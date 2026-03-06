Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5904366DCB
	for <linux-cxl@vger.kernel.org>; Fri,  6 Mar 2026 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792097; cv=none; b=iQYPqMBMvADMRGYnq6411txBMNxYC/5o09VPVsDPQPwgXkIPlKBpOGAVUDaYAKX7gpaQI60w5raIZi2hkedi4wEa96+H2fbKNENo9DmSftJDC0vvKUseAMb9uEkTt67x8QoqtyEUP5Aq5wn4w0qM0bvXEvFhUKqQTXM+7g9mtfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792097; c=relaxed/simple;
	bh=Fegtbb6h2xSRS+BP09jNSC6KPEzIaYl5m1WxQeGGT2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vp10RjQ9OttLAymYh9X03LIrMjq5WbS0VvL8wYcJ6VWxbeuLw16SJdDW1WoeIs03OCqXiDG+gcL3C6n9y4PXiefkIq2vi4ljL4SjVgRGkxUIeftgBUlyNsVJpKQG5Bw++rW2IkcmHwhtnUFEsB4zIVATSM5oFl7g4C8iHu2nhz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fS2Lw3ztJzJ46nP;
	Fri,  6 Mar 2026 18:14:16 +0800 (CST)
Received: from dubpeml500008.china.huawei.com (unknown [7.214.146.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 5FD0240570;
	Fri,  6 Mar 2026 18:14:54 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.246.67) by
 dubpeml500008.china.huawei.com (7.214.146.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Mar 2026 10:14:53 +0000
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <mst@redhat.com>,
	<peter.maydell@linaro.org>, <jonathan.cameron@huawei.com>,
	<dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 2/3] hw/cxl: Add fixes in Post Package Repair (PPR)
Date: Fri, 6 Mar 2026 10:14:21 +0000
Message-ID: <20260306101423.986-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20260306101423.986-1-shiju.jose@huawei.com>
References: <20260306101423.986-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500008.china.huawei.com (7.214.146.94)

From: Shiju Jose <shiju.jose@huawei.com>

Add following fixes to the commit: hw/cxl: Add support for Maintenance
command and Post Package Repair (PPR).

In cxl_perform_ppr(), remove and free the maintenance entry from QLIST
if match is found and PPR operation is performed.

Fixes: 5e5a86bab830("hw/cxl: Add support for Maintenance command and Post Package Repair (PPR)")
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 9c99422cd4..66a58396ee 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2068,6 +2068,8 @@ static void cxl_perform_ppr(CXLType3Dev *ct3d, uint64_t dpa)
                                 CXL_MEMDEV_MAINT_SUBCLASS_CACHELINE_SPARING,
                                 ent, NULL);
             }
+            QLIST_REMOVE(ent, node);
+            g_free(ent);
             break;
         }
     }
-- 
2.43.0

