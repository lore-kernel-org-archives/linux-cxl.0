Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801C97E574
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908534; cv=none; b=FLSAax09try/rpkRRUY4MSKzOQbzVYBvREEZThD/67/ZmOLd2WxmC6XMrNbuVkcxI8vCOD1M7NOO3lzU/6OAl6bqqcGMgIgK1KawqRZrdPSeCQSv1SxpvNH//OqVGZFjQnxLdosf/Rr0p7ersu0gZAT9u/g50pQGKBJdtkOU6PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908534; c=relaxed/simple;
	bh=cGiH/Yq4H/yekfay3wq5nf8R5di+jCsddr+/grpx4yk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqJ3gC2kWGovkVW6nV+I/WFN3QCqQG2PvR0h91n6inEUnzw1+kd3yZPZUupaYC5vWo7DzJ/Nw5SC5k0x2xzC1V0Ex4stA2G1sooMCLEFStPAa712h0Ce2XnBGLrboHXtUTnny+CJZl4aCtylpgGYHigtwnAwKoQqqxKBIgqw4dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XRxDL37N8z6K9MG;
	Mon, 14 Oct 2024 20:21:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 216D9140A77;
	Mon, 14 Oct 2024 20:22:10 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 14:22:09 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Dmitry Frolov <frolov@swemel.ru>, Ajay Joshi <ajay.opensrc@micron.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Fan Ni <fan.ni@samsung.com>, Shiju Jose
	<shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu 6/7] hw/cxl: Fix indent of structure member
Date: Mon, 14 Oct 2024 13:19:01 +0100
Message-ID: <20241014121902.2146424-7-Jonathan.Cameron@huawei.com>
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

Add missing 4 spaces of indent to structure element.

Reported-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 67041f45d3..5f63099724 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -374,7 +374,7 @@ static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
         uint16_t pcie_subsys_vid;
         uint16_t pcie_subsys_id;
         uint64_t sn;
-    uint8_t max_message_size;
+        uint8_t max_message_size;
         uint8_t component_type;
     } QEMU_PACKED *is_identify;
     QEMU_BUILD_BUG_ON(sizeof(*is_identify) != 18);
-- 
2.43.0

