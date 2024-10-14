Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE21433991
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 12:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908471; cv=none; b=MDaTYahLy4FqHu6jHgEDztd/ys9u/gpISzPBUKnSjL75zxNE4E6eCoJN2ORppD7PFVfI2RFtOU6XozdypXibsy+He9zMOEqH87WQd2XzMSftTW0LD9XH62GgvEHldr8xOhRanfMjSxn9ltPBkszhsPE1CUNt4Nfspadgbv87Goc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908471; c=relaxed/simple;
	bh=EC5rSxPlos+0X/cuDbZQGU3HPbW6lRp/1qTdBSRk39A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KIibROeKbY+1tm9qD4OnHOPpJqunUzN2UpOeyKlV/GMov7xiS1nK8edJlcUd/xaa/AX/cN2xAjZwz2PinrS10SvRe3mqRHLd8SRZ3wzP+GEiZRolKEM9ZIQFdykoanDHt78Px1Q3uXSDDhH9wmJ0Em3KTRx7vJK7GxE0FeChEVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XRx9x56WZz6GC1H;
	Mon, 14 Oct 2024 20:19:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 28A081401F4;
	Mon, 14 Oct 2024 20:21:08 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 14:21:07 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Dmitry Frolov <frolov@swemel.ru>, Ajay Joshi <ajay.opensrc@micron.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Fan Ni <fan.ni@samsung.com>, Shiju Jose
	<shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu 4/7] hw/mem/cxl_type3: Fix More flag setting for dynamic capacity event records
Date: Mon, 14 Oct 2024 13:18:59 +0100
Message-ID: <20241014121902.2146424-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014121902.2146424-1-Jonathan.Cameron@huawei.com>
References: <20241014121902.2146424-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

From: Fan Ni <fan.ni@samsung.com>

Per cxl spec r3.1, for multiple dynamic capacity event records grouped via
the More flag, the last record in the sequence should clear the More flag.

Before the change, the More flag of the event record is cleared before
the loop of inserting records into the event log, which will leave the flag
always set once it is set in the loop.

Fixes: d0b9b28a5b9f ("hw/cxl/events: Add qmp interfaces to add/release dynamic capacity extents")
Signed-off-by: Fan Ni <fan.ni@samsung.com>
Link: https://lore.kernel.org/r/20240827164304.88876-2-nifan.cxl@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/mem/cxl_type3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 16c60b9b0d..6911d13fe6 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2064,11 +2064,11 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
     stw_le_p(&dCap.host_id, hid);
     /* only valid for DC_REGION_CONFIG_UPDATED event */
     dCap.updated_region_id = 0;
-    dCap.flags = 0;
     for (i = 0; i < num_extents; i++) {
         memcpy(&dCap.dynamic_capacity_extent, &extents[i],
                sizeof(CXLDCExtentRaw));
 
+        dCap.flags = 0;
         if (i < num_extents - 1) {
             /* Set "More" flag */
             dCap.flags |= BIT(0);
-- 
2.43.0

