Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1F016A959
	for <linux-cxl@vger.kernel.org>; Fri,  1 Nov 2024 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468610; cv=none; b=MgC2pPUyub5ikUBIjWFTsH6/mnVnljWCkvjkOkzp8915dOxC1f29xD9mlVZt7PLrgHKvlRPX5CDtgWyVGb0+O18qJ5EOtc4sP8+MVRzMJ03d33u22c2yELcMM3zr05KtJo6i2vlmrHx8lrktlPjMI31aG1cmb848dsUbzQ9xloo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468610; c=relaxed/simple;
	bh=MYtFmoZAjAtf9ddCGzGGnciY3H5F4tp6TxWKnuSjAIw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bwxNrwvmf3sT6LB4+tcTf5MfcOyU6DgnthIK7xZlJgLLonT0ifm8e8zSwXzrTG+CWCGKeJOaOJKvECWr0Dxt1a0l2FjG6vVG18QNGve3YHDZQnAO+j7IILeARntCkz4IxDRLODAegPITvfXodrY9RS11B6nJJSzdhKaVXW01OC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xg27V6VWZz6K6l8;
	Fri,  1 Nov 2024 21:40:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 75F8A1400D3;
	Fri,  1 Nov 2024 21:43:26 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 14:43:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>,
	Esifiel <esifiel@gmail.com>
CC: Fan Ni <fan.ni@samsung.com>, <linuxarm@huawei.com>
Subject: [PATCH qemu 08/10] hw/cxl: Check that writes do not go beyond end of target attributes
Date: Fri, 1 Nov 2024 13:39:15 +0000
Message-ID: <20241101133917.27634-9-Jonathan.Cameron@huawei.com>
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

In cmd_features_set_feature() the an offset + data size schemed
is used to allow for large features.  Ensure this does not write
beyond the end fo the buffers used to accumulate the full feature
attribute set.

Reported-by: Esifiel <esifiel@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index a40d81219c..078782e8b9 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1292,6 +1292,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
 
         ps_set_feature = (void *)payload_in;
         ps_write_attrs = &ps_set_feature->feat_data;
+
+        if ((uint32_t)hdr->offset + bytes_to_copy >
+            sizeof(ct3d->patrol_scrub_wr_attrs)) {
+            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+        }
         memcpy((uint8_t *)&ct3d->patrol_scrub_wr_attrs + hdr->offset,
                ps_write_attrs,
                bytes_to_copy);
@@ -1314,6 +1319,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
 
         ecs_set_feature = (void *)payload_in;
         ecs_write_attrs = ecs_set_feature->feat_data;
+
+        if ((uint32_t)hdr->offset + bytes_to_copy >
+            sizeof(ct3d->ecs_wr_attrs)) {
+            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+        }
         memcpy((uint8_t *)&ct3d->ecs_wr_attrs + hdr->offset,
                ecs_write_attrs,
                bytes_to_copy);
-- 
2.43.0

