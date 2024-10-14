Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C72215B554
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 12:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908380; cv=none; b=J//Ezr0J5IiVg/q5Rz/Ghhr674owT+V8tqW1LO+6CBnfTHkSBkjgFQYeWBncN4CJT1rO8zRHJWBuEPvzdfZZMmbdJG3ga+SbpKiuUCtiS0rOnepuqLh5ozRLxAi7iXa2yDN1L8Geimw12V6yh2zukQ+sTEPaBS1xBmPfg5ilFZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908380; c=relaxed/simple;
	bh=/1Vdd50o4OcaMlq9UxLwRu5gF8ggALVNs6J+nfHf0tc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OWxSdddQvRekaCWZ15yGaHmVNhJl/olM+woqjtk/Iyw2OpWLJ2puaNGqTl4+sk9CwfriLQvDfMLXgCCd18nkD6wgNlw0AVin0yoqjIrmcz4DUGb0ZmUOd8FBD+4YIHjll51S4+rKS7eX1kAIuPejjprezal8XY+2aqYnavyBV5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XRx4q5d8vz6LDTQ;
	Mon, 14 Oct 2024 20:15:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E127F140C72;
	Mon, 14 Oct 2024 20:19:34 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 14:19:34 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Dmitry Frolov <frolov@swemel.ru>, Ajay Joshi <ajay.opensrc@micron.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Fan Ni <fan.ni@samsung.com>, Shiju Jose
	<shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu 1/7] hw/cxl: Fix uint32 overflow cxl-mailbox-utils.c
Date: Mon, 14 Oct 2024 13:18:56 +0100
Message-ID: <20241014121902.2146424-2-Jonathan.Cameron@huawei.com>
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

From: Dmitry Frolov <frolov@swemel.ru>

The sum offset + length may overflow uint32. Since this sum is
compared with uint64_t return value of get_lsa_size(), it makes
sense to choose uint64_t type for offset and length.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 3ebe676a3463 ("hw/cxl/device: Implement get/set Label Storage Area (LSA)")
Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
Link: https://lore.kernel.org/r/20240917080925.270597-2-frolov@swemel.ru
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 9258e48f95..9f794e4655 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1445,7 +1445,7 @@ static CXLRetCode cmd_ccls_get_lsa(const struct cxl_cmd *cmd,
     } QEMU_PACKED *get_lsa;
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
-    uint32_t offset, length;
+    uint64_t offset, length;
 
     get_lsa = (void *)payload_in;
     offset = get_lsa->offset;
-- 
2.43.0

