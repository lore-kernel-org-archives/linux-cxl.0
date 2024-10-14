Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBE0158548
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 12:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908440; cv=none; b=DW5Dcg7hB9hP8z+RgUwSueBK+rEG9oHHCMKW6HRTuz3Igr8dbMQ593Cq1D2rWfJ61Am9pa6ynW/Bs52esLuiDyCzXnGYx1Qi88KjicYLPozi2m0gcHk1iNIMIeiZOrJu5z+ZKq7baerQjC2uAIujW9jd0q4u+d52H5AlvAE2msQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908440; c=relaxed/simple;
	bh=nyXRXxqDjm/Xef7qm5nBEYO2Wonn6B8WZaoJ98cpWxs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JnWpGAsEuCUSGFB6GhPg8F0i29nmVLIT9EhFjsNn+OivIuAbOAEAkwIrpvCGJkIF6PcpIt6IfPGR/7zNCQ+eB4OuBJHrxczBOVOE6PYUz6uhaeZ9PpcLiE6qgQmQJDw/Gwl1hpfS0mpy4seQ4Swqu1YhN32J29lWE5eAL8qZXA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XRx9L4mVMz6GC3y;
	Mon, 14 Oct 2024 20:19:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 196DA140C98;
	Mon, 14 Oct 2024 20:20:37 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 14:20:36 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Dmitry Frolov <frolov@swemel.ru>, Ajay Joshi <ajay.opensrc@micron.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Fan Ni <fan.ni@samsung.com>, Shiju Jose
	<shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu 3/7] mem/cxl_type3: Fix overlapping region validation error
Date: Mon, 14 Oct 2024 13:18:58 +0100
Message-ID: <20241014121902.2146424-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014121902.2146424-1-Jonathan.Cameron@huawei.com>
References: <20241014121902.2146424-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

From: Yao Xingtao <yaoxt.fnst@fujitsu.com>

When injecting a new poisoned region through qmp_cxl_inject_poison(),
the newly injected region should not overlap with existing poisoned
regions.

The current validation method does not consider the following
overlapping region:
┌───┬───────┬───┐
│a  │  b(a) │a  │
└───┴───────┴───┘
(a is a newly added region, b is an existing region, and b is a
 subregion of a)

Fixes: 9547754f40ee ("hw/cxl: QMP based poison injection support")
Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/mem/cxl_type3.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 44d491d8f6..16c60b9b0d 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1381,9 +1381,7 @@ void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
     ct3d = CXL_TYPE3(obj);
 
     QLIST_FOREACH(p, &ct3d->poison_list, node) {
-        if (((start >= p->start) && (start < p->start + p->length)) ||
-            ((start + length > p->start) &&
-             (start + length <= p->start + p->length))) {
+        if ((start < p->start + p->length) && (start + length > p->start)) {
             error_setg(errp,
                        "Overlap with existing poisoned region not supported");
             return;
-- 
2.43.0

