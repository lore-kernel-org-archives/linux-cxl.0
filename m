Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3286168DA
	for <linux-cxl@vger.kernel.org>; Fri,  1 Nov 2024 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468486; cv=none; b=gID6LVi+5xIui8V+ZllSkmlk9KVnCusN4x7/z8+1R7OYzMcky/O8eilvmZfTccOLG/KVNFTOIsnta99M697kFysUuc004mcGwG0axp4O5IZIiYNnUPm7Ug5dCiay+zMj54vLDshGSWp4/3g9YQBOwn86uDUKRjb33WGS8bqxLFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468486; c=relaxed/simple;
	bh=L8p1HLi2NeIlaJNELXPlgJ9ysMi9o1KKq/lhstbxfBI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qg8mnpaBnTfuKJ3xCiv1oIOL6owze0vUsl/2Au6Mqr8hKdma7RSel1g23kC2W9BCzA8axUWjrRD+qCIUJXk/UW60b6tmKPPaWe7cDooWfmPW8LslXgFGmGAGHcm0geiULSpf7puScPWuadmb6KC40b8R0CrF8LyrFEfxEsQIqJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xg2570j4Zz6K6W4;
	Fri,  1 Nov 2024 21:38:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A19A4140A9C;
	Fri,  1 Nov 2024 21:41:22 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 14:41:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>,
	Esifiel <esifiel@gmail.com>
CC: Fan Ni <fan.ni@samsung.com>, <linuxarm@huawei.com>
Subject: [PATCH qemu 04/10] hw/cxl: Check enough data in cmd_firmware_update_transfer()
Date: Fri, 1 Nov 2024 13:39:11 +0000
Message-ID: <20241101133917.27634-5-Jonathan.Cameron@huawei.com>
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

Buggy guest can write a message that advertises more data that
is provided. As QEMU internally duplicates the reported message
size, this may result in an out of bounds access.
Add sanity checks on the size to avoid this.

Reported-by: Esifiel <esifiel@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 3cb499a24f..27fadc4fa8 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -705,6 +705,10 @@ static CXLRetCode cmd_firmware_update_transfer(const struct cxl_cmd *cmd,
     } QEMU_PACKED *fw_transfer = (void *)payload_in;
     size_t offset, length;
 
+    if (len < sizeof(*fw_transfer)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
     if (fw_transfer->action == CXL_FW_XFER_ACTION_ABORT) {
         /*
          * At this point there aren't any on-going transfers
-- 
2.43.0

