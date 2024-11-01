Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0589168DA
	for <linux-cxl@vger.kernel.org>; Fri,  1 Nov 2024 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468517; cv=none; b=ZyhqW+qQdr1xSzdXXlvZEGY+NfjJb+y1NJyAlVXjgirgAxbzraJTgL0EWoGZzldPlKnvnG9mKPQkOKT6CYDBR9jX/viJ+Lcad02hHGfXmf5Ts5H4FNhfownAyphCJRYhXN/1YoFjLtT4QJW01Cyp/bPwO0vVzsjA247dGIMdmZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468517; c=relaxed/simple;
	bh=Dc3M2obbHv85NiZpVN8c30jCYN+nOU3Htsg4O1ZRECk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRVf0o/F21ISQZzNT9/Mzl5E09F2jdr9VV3bWIIjg5xzFAmKvdoSLuYpic8xZV1Tu53SMO5C8HCmWyniaiWX7AQ6SUReZSbcIbIPdoHB4b1FCWkLydhUtzd5QuJw4WF2FLEJ5jRjBrkKrfzTZ/oFE6LTLiNMy0OU7fVSJOBllAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xg25j72BYz6K661;
	Fri,  1 Nov 2024 21:39:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8696E1404FC;
	Fri,  1 Nov 2024 21:41:53 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 14:41:53 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>,
	Esifiel <esifiel@gmail.com>
CC: Fan Ni <fan.ni@samsung.com>, <linuxarm@huawei.com>
Subject: [PATCH qemu 05/10] hw/cxl: Check the length of data requested fits in get_log()
Date: Fri, 1 Nov 2024 13:39:12 +0000
Message-ID: <20241101133917.27634-6-Jonathan.Cameron@huawei.com>
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

Checking offset + length is of no relevance when verifying the CEL
data will fit in the mailbox payload. Only the length is is relevant.

Note that this removes a potential overflow.

Reported-by: Esifiel <esifiel@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 27fadc4fa8..2aa7ffed84 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -947,7 +947,7 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
      * the only possible failure would be if the mailbox itself isn't big
      * enough.
      */
-    if (get_log->offset + get_log->length > cci->payload_max) {
+    if (get_log->length > cci->payload_max) {
         return CXL_MBOX_INVALID_INPUT;
     }
 
-- 
2.43.0

