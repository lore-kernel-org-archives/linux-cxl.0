Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68199168DA
	for <linux-cxl@vger.kernel.org>; Fri,  1 Nov 2024 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468426; cv=none; b=iL76F7+k/7PMY3+LAwJA3NJ8Y3thiPhL9/h50goon4CObChTB9zWdx3UKinA+VK+OuiIBtGQHg5E+lmA2RpTMKqRxPTkStp2Dzwdcd3HkaqEplc/nCO0LO+vcD0uJ94xTl5VndGoVAmM5WvEyq9rXr6reyOkeYaU0tUg8qYN3/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468426; c=relaxed/simple;
	bh=lqAH22jJLVaCuYrg9qfBFPgPQD/EWHCt6Ng7RdYPQ3w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7eLqsIWVHLKdMaAw+lGoLbiUBTMYu0DTG5vy7PnUjhmKy5gSP8EQkOYeiGBljp/GYq1x2VB+4nun7xpVOVx+0Csd5vf1xwBKKomvmyb5TroeS6mlp7rTu3yN3FLOBrMVtSaDsEaqZBClhhRW+8oYZH6NHuDzGy2EC5kbc9A0QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xg25D69gwz6JB7S;
	Fri,  1 Nov 2024 21:38:56 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C30AE140A9C;
	Fri,  1 Nov 2024 21:40:20 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 14:40:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>,
	Esifiel <esifiel@gmail.com>
CC: Fan Ni <fan.ni@samsung.com>, <linuxarm@huawei.com>
Subject: [PATCH qemu 02/10] hw/cxl: Check input includes at least the header in cmd_features_set_feature()
Date: Fri, 1 Nov 2024 13:39:09 +0000
Message-ID: <20241101133917.27634-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

A buggy guest might write an insufficiently large message.
Check the header is present. Whilst zero data after the header is very
odd it will just result in failure to copy any data.

Reported-by: Esifiel <esifiel@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 17924410dd..e63140aefe 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1238,6 +1238,9 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
     CXLType3Dev *ct3d;
     uint16_t count;
 
+    if (len_in < sizeof(*hdr)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
 
     if (!object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_TYPE3)) {
         return CXL_MBOX_UNSUPPORTED;
-- 
2.43.0

