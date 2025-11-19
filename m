Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E82337105
	for <linux-cxl@vger.kernel.org>; Wed, 19 Nov 2025 22:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592178; cv=none; b=Z+PO/Z5RvIWrxLzu2Doo+16ASYftj0gj++5B2ydeiHJ7HVgf2d/xHd4VgPRNXKSJhiM8vPWT5wCjCgDJ/cirdoB8RRm/sozu8tRpcDaBMvohQojFVQcP7m0bZGcClLo27bjzsnO90X9Xf4ANb2B+maaMcCRsVB10wtaSZHMBUz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592178; c=relaxed/simple;
	bh=Dmi/gNc2WqTmoiCwsXtE9B4qvf+07Fr77NPdal7Sw7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ONrzKDopdLCi8v9qXdQ/d5gq4eY8kj1GIKe92zoWgRBvqgp9O/OBYQ3N+kkqEospKgUegMMsEU72Ads8GVbfLRK6ZmW/RwSDKBTtf8w8O0G8/rE63bn3iAPmlKawxGCmIaXYyV/F/dkeFGYMnxXasL+ohPqG4SHqFFWe+Ml7XxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=yfvISeaD; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="yfvISeaD"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqt3-006kyF-9D; Wed, 19 Nov 2025 23:42:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=5MEknnuAKfJCHXLhDStxABn6W3caLDFPqFcUl+Xl1Hg=; b=yfvISeaDRfFAovzyue1CSfQ/GP
	cC7NAjRKGJ9qBaGGYP2GJlLbnGgp2/HRubwEQtx9qp0226/4WYXuCk3P465hHpwvpcpiu+U2sgD7Q
	m0HarcgKN7MYOMq91S5tpj6nCgsxh3CU56Bfni1xExo1F/QQalViyDWqzwl4QCM8l+HkZc2GyJRN3
	354LvGa1FdtnzdWMm35F+8gJWqkRYevxbQswY1AWZIuT4HUqDL5bYaOG5euQ+mZ1vn01nyYu9wA2/
	s0oFJnRK5SapWrFBFOl2KBiOCSXFgFvdoPksWpmYB0p1t6/SBTkgQc/o9dJwDUtw+wgKqmvuXKwwP
	gT967xGw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqt2-00086j-Vg; Wed, 19 Nov 2025 23:42:53 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vLqsc-00Fos6-L4; Wed, 19 Nov 2025 23:42:26 +0100
From: david.laight.linux@gmail.com
To: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 17/44] drivers/cxl: use min() instead of min_t()
Date: Wed, 19 Nov 2025 22:41:13 +0000
Message-Id: <20251119224140.8616-18-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned long'
and so cannot discard significant bits.

In this case the 'unsigned long' value is small enough that the result
is ok.

Detected by an extra check added to min_t().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 drivers/cxl/core/mbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index fa6dd0c94656..17aec916e8cd 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -663,7 +663,7 @@ static int cxl_xfer_log(struct cxl_memdev_state *mds, uuid_t *uuid,
 	u32 offset = 0;
 
 	while (remaining) {
-		u32 xfer_size = min_t(u32, remaining, cxl_mbox->payload_size);
+		u32 xfer_size = min(remaining, cxl_mbox->payload_size);
 		struct cxl_mbox_cmd mbox_cmd;
 		struct cxl_mbox_get_log log;
 		int rc;
-- 
2.39.5

