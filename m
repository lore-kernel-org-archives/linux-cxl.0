Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E94378D74;
	Mon, 28 Sep 2026 07:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581110; cv=none; b=nx5Ew41UrY5CofM2aGIUQxaRqsMr+rH/629Xi7OUG7txp+K+Cyo7cSXpMRDruzBPxCqItt+KKZoLyvqNiyXcsQTdykfPoL9NfQ9BxIJyDI5B5KR/dXEmQeRjj3lsj79Obx771oNHD/vC0VumNtA+9HdEE8fJ3AzVSRstEsDrYOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581110; c=relaxed/simple;
	bh=jVcqCKU5zTUvfsIKAoJvhNJYA6QeuaFWc7N0JkdGGVc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cSm9ka7151qvS7AMbWQSn+Z3EJu+AX3NnSxjjszOWKBelg6W1GJ+mmimXIoPG37yjbKnxi2AiaFTVt/efc0UkcESj5tjx8VkXOrvjXN9mOZFk1TBDZ8iDfDE52hY++mdwx5A/jNDJTSDdTqH4+uzLM0jL8e5eTLqj5w5Y5rNgCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=TjGYINvJ; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="TjGYINvJ"
X-MD-Sfrom: zhangyili01@baidu.com
X-MD-SrcIP: 172.31.51.15
From: Yili Zhang <zhangyili01@baidu.com>
To: <linux-cxl@vger.kernel.org>
CC: Dan Williams <djbw@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Dave
 Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan
 Cameron <jic23@kernel.org>, Shiju Jose <shiju.jose@huawei.com>,
	<linux-kernel@vger.kernel.org>, Yili Zhang <zhangyili01@baidu.com>
Subject: [PATCH] cxl/edac: Bounds-check ECS threshold index from device
Date: Mon, 28 Sep 2026 15:35:53 +0800
Message-ID: <20260928073553.85669-1-zhangyili01@baidu.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc7.internal.baidu.com (172.31.50.51) To
 BJKJY-Exc19.internal.baidu.com (172.31.51.15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1790580971;
	bh=Zl4E/aYn1t375C3H+aryoKKOOtUTLLMUaeolh52NgaA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=TjGYINvJdRFg2HyhWcDLFak8QaYn4O9M3higQisG4UgEJ01/6RI2iZ9SGkhr8jA2G
	 115ZsOrDpiFEj+w32X2+drpl2xYdJkPjN57NW2GHrVDiCzH+86Qo2ntxxlcPOQKCsg
	 Lu8+dRKSG0a545VTwlc6AbHJE1r8GqJLZWUjUAo7+eSHHOfkykUk+Mg38nH3jSEn68
	 8+rMgkQHX2B2oUpqgCy00Efz4FeRwFHNAtgw7Kvw11oif65njyZVBJsgE3XC8ee6Yn
	 kh1Ycvom6COsK78dYDYnFlTwTxFKMTTXvvFcBeyiSs9WHqeMtbEfSxQdyIIgAgN9vZ
	 BQH2bM+IPpkSQ==

cxl_get_ecs_threshold() extracts a 3-bit index (0-7) from the
device-supplied ECS config word and uses it to
index ecs_supp_threshold[], which only has 6 elements. A device reporting
index 6 or 7 causes an out-of-bounds read of adjacent .rodata, whose
value is then returned to userspace via the EDAC 'threshold' sysfs
attribute (small info leak and wrong reported threshold).

Return 0 for indices outside the table.

Fixes: 85fb6a16ad14 ("cxl/edac: Add CXL memory device ECS control feature")
Signed-off-by: Yili Zhang <zhangyili01@baidu.com>
---
 drivers/cxl/core/edac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index b321971fef58..73335b980b11 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -633,6 +633,9 @@ static u16 cxl_get_ecs_threshold(u8 log_cap, u16 config)
 {
 	u8 index = FIELD_GET(CXL_ECS_THRESHOLD_COUNT_MASK, config);
 
+	if (index >= ARRAY_SIZE(ecs_supp_threshold))
+		return 0;
+
 	return ecs_supp_threshold[index];
 }
 
-- 
2.27.0

