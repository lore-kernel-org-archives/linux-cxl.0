Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F342D233D99
	for <linux-cxl@vger.kernel.org>; Fri,  8 Nov 2024 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088700; cv=none; b=HvCz8n94atD0hcm2CE9Nxutx2I/OD/+aoH9BTI9oOFhcvLmQ6rWRBoOg1Mp730KPzhttQQo0p7djwkv/g/C4FnRX6pCqSApXBBdsKFJQyGCVY/PI5iJqsQNa1sWcARAcRNpDaz71XDh//bHHdvzozFClHLC91C4fLLm+ufXxe5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088700; c=relaxed/simple;
	bh=qrwP+dOq+r0M4jUw7/g0+9+21Gd6scXxTjr26mWMMfs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XBBBLIbZIyxC5GMZBVx/36c+UCb7CqixP+WhsVO2/whTaPk3k8jvmEibw7YLEcrGFweHUF5w/f3vZ2THQNs98zzCxTLL1QZo8uTiiyZJWz2pD+/zkPHZyc7/aAkR01XNMyylw7kNzuhH46JgBx8ftaRvKYkvs335yXytG1RKLsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XlRRs15SZz6K6K9;
	Sat,  9 Nov 2024 01:55:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7915B140A77;
	Sat,  9 Nov 2024 01:58:15 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 8 Nov 2024 18:58:15 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
	<linux-cxl@vger.kernel.org>, Peter Maydell <peter.maydell@linaro.org>,
	<shiju.jose@huwei.com>, <qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>
Subject: [PATCH qemu] hw/cxl: Check for zero length features in cmd_features_set_feature()
Date: Fri, 8 Nov 2024 17:58:14 +0000
Message-ID: <20241108175814.1248278-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

Zero length data for features doesn't make any sense so exclude that case
early. This fixes the undefined behavior reported by coverity for a zero
length memcpy().

Resolves CID 1564900 and 1564901

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2d4d62c454..ce9aa18364 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1288,6 +1288,10 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
     set_feat_info->data_offset = hdr->offset;
     bytes_to_copy = len_in - sizeof(CXLSetFeatureInHeader);
 
+    if (bytes_to_copy == 0) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
     if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
         if (hdr->version != CXL_MEMDEV_PS_SET_FEATURE_VERSION) {
             return CXL_MBOX_UNSUPPORTED;
-- 
2.43.0

