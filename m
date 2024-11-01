Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C897168DA
	for <linux-cxl@vger.kernel.org>; Fri,  1 Nov 2024 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468579; cv=none; b=d8DDxvBSrTYrofRuelvI93OgWBVHFSWdsnwIvwX/C0WQVN9RNIMZ5G0+oPbt2p4bpmxMdJK7CgJa0NkN5HjJD/0DHkVXUeeppDwy2feoIU6qoiPUuaKbD3EsYVRkLJxBv0bgS9SNqaQq1kcj4K8BVlgteUAHuPNY96aQDOlMyKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468579; c=relaxed/simple;
	bh=78nLqkRHRLA9Kgre9+3rlodQa8FHw0kHenFzS9Uzb0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AdPtukMzkASWZklQjbrvaX58BQD6EnqZdJXVUUp8VweaEmAlRNP9vwRJJHJ47AG7L1hCEuolDq19ayDtUyqt4w1rPJEFE1eMg8RsyJ+PPKUBBGO8dNpN5sjb05075AdrS3ghNkbby6xuXtaqWqbcQPsmfNuiJvRwkXNfA8+gpbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xg2493JS6z6LD4f;
	Fri,  1 Nov 2024 21:38:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8DF2B1400D3;
	Fri,  1 Nov 2024 21:42:55 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 14:42:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>,
	Esifiel <esifiel@gmail.com>
CC: Fan Ni <fan.ni@samsung.com>, <linuxarm@huawei.com>
Subject: [PATCH qemu 07/10] hw/cxl: Ensuring enough data to read parameters in cmd_tunnel_management_cmd()
Date: Fri, 1 Nov 2024 13:39:14 +0000
Message-ID: <20241101133917.27634-8-Jonathan.Cameron@huawei.com>
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

If len_in is less than the minimum spec allowed value, then return
CXL_MBOX_INVALID_PAYLOAD_LENGTH

Reported-by: Esifiel <esifiel@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 5e571955b6..a40d81219c 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -151,6 +151,9 @@ static CXLRetCode cmd_tunnel_management_cmd(const struct cxl_cmd *cmd,
     in = (void *)payload_in;
     out = (void *)payload_out;
 
+    if (len_in < sizeof(*in)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
     /* Enough room for minimum sized message - no payload */
     if (in->size < sizeof(in->ccimessage)) {
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
-- 
2.43.0

