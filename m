Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24DB168DA
	for <linux-cxl@vger.kernel.org>; Fri,  1 Nov 2024 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468455; cv=none; b=r8ph2wZmArLleVLu+lriDC6dWpTLvlhfWbDUCjTgyvQvM51C5wuXsQurFmMfANG/lVYthpbBvx5gmJPKehqsbnHUQOTizwmi416O0FYgTCqh4J7LWIgV5Y6m3PMqsJkhScnrXVinkfJp3H1GYYZQZ0ro/z5Wx2KhosIXbjGPilc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468455; c=relaxed/simple;
	bh=kPeNdMlueIq7wDr/vvje1b/dnnQ/5XSp7oRZZlMj4u4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SjSHj5WfgC0+nlbL0KO27zegTa7RI7MWdW7IbcI9GTPEkTldlKJv7e9ASgxbPh8LOLWKeRKDolsBS37AvfsXvTML8ne9DrxI7iBAY/W0zoKDh+avuCkA7BnG7jD0Nf9/N1ck8lmfOCKbb7mrrhMLlUGa3WAuQ0iroFVP0rEpVs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xg24X1TS2z6K6j8;
	Fri,  1 Nov 2024 21:38:20 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BC873140445;
	Fri,  1 Nov 2024 21:40:51 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 14:40:51 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>,
	Esifiel <esifiel@gmail.com>
CC: Fan Ni <fan.ni@samsung.com>, <linuxarm@huawei.com>
Subject: [PATCH qemu 03/10] hw/cxl: Check input length is large enough in cmd_events_clear_records()
Date: Fri, 1 Nov 2024 13:39:10 +0000
Message-ID: <20241101133917.27634-4-Jonathan.Cameron@huawei.com>
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

Buggy software might write a message that is too short for
either the header, or the header + the event data that is specified
in the header.  This may result in accesses beyond the range of the
message allocated as a duplicate of the incoming message buffer.

Reported-by: Esifiel <esifiel@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index e63140aefe..3cb499a24f 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -266,6 +266,12 @@ static CXLRetCode cmd_events_clear_records(const struct cxl_cmd *cmd,
     CXLClearEventPayload *pl;
 
     pl = (CXLClearEventPayload *)payload_in;
+
+    if (len_in < sizeof(*pl) ||
+        len_in < sizeof(*pl) + sizeof(*pl->handle) * pl->nr_recs) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
     *len_out = 0;
     return cxl_event_clear_records(cxlds, pl);
 }
-- 
2.43.0

