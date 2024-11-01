Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDAD4594D
	for <linux-cxl@vger.kernel.org>; Fri,  1 Nov 2024 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467276; cv=none; b=N1KaYGKHHkzGDYGzIf4PprnQLnWfLIvVOWPm7NzzK6IhkR6og1vcphTUOeVetphl+TlV9tRZG1rM+JcRxcSepFgz7KHomqx6EA1PsTI34Jso0WuuKBh2FXPXBKFU4HbJtoS3NUd605MpuJf5B6gMjGxE35iky7Pv/pTkrEtV1Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467276; c=relaxed/simple;
	bh=Hv7zLa2srclv494LQO9ZWOgWFODV9mew6g2AU3hfx6M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N4seY7J58MK5NvE1yB2HSpLxJ2pWCOFH6FMJn4FYNzkRtoXW6lIeQKRfVS9h8qZLyDop4onAN1fxBOG/Ykl5M6mun67niRTVrh4ZxoUzBVkd5Yw82ZW1Nzozrv3P/+vIOLg40B3V7VicIHqRmH6S6L3IuEE6yUBHT8+qzR0EBhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xg1dn4G4Mz6K6H9;
	Fri,  1 Nov 2024 21:18:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 14373140453;
	Fri,  1 Nov 2024 21:21:09 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 14:21:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Fan Ni <fan.ni@samsung.com>, <linuxarm@huawei.com>
Subject: [PATCH qemu 2/2] hw/cxl/cxl-mailbox-util: Fix output buffer index update when retrieving DC extents
Date: Fri, 1 Nov 2024 13:20:05 +0000
Message-ID: <20241101132005.26633-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101132005.26633-1-Jonathan.Cameron@huawei.com>
References: <20241101132005.26633-1-Jonathan.Cameron@huawei.com>
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

From: Fan Ni <fan.ni@samsung.com>

In the function of retrieving DC extents (cmd_dcd_get_dyn_cap_ext_list),
the output buffer index was not correctly updated while iterating the
extent list on the device, leaving the extents returned incorrect except for
the first one.

Fixes: 1c9221f19e62 ("hw/mem/cxl_type3: Add DC extent list representative and get DC extent list mailbox support")
Signed-off-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 8bb0d2dd29..97cb8bbcec 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2227,6 +2227,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
             stw_le_p(&out_rec->shared_seq, ent->shared_seq);
 
             record_done++;
+            out_rec++;
             if (record_done == record_count) {
                 break;
             }
-- 
2.43.0

