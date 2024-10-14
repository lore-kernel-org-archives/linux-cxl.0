Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6527319F13F
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908411; cv=none; b=bNHp/PJTuA/2BomMEv35FUU8NrQscErUS2anTdTg10LPLUXBeQ2WU+mnOdknN0ccLiZHFwGh+e5jhwB2FqgT2d8iQ0gBRTRhxxl452CvCE+RCCcC5hDhIkogYnaVyqflysBe+yHJPTRTqQDxgSpYHBt3cTyNRp0af8AzeMA3KAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908411; c=relaxed/simple;
	bh=0G3jhTO+sj6ikD5lrYQQYIQ+St9Vm/YWj4OVVdRpXSM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKgXgGWX9giNQVUYHEThRYD3CiGcMdestiHIIP+YhxKsS5J/buV3clN1tomd78KwKHSevG2/DeAYCY4MO7BwKmGq5yph/V0I5pMrEAjJffiWxaaRp2bDpfVSFCcS9Q20KYCa4ERiLmbre5K4s/AGvifSTYGjUZBsmT/9Ifra2fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XRx8l4qtgz6GC16;
	Mon, 14 Oct 2024 20:18:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1DE0B1401F4;
	Mon, 14 Oct 2024 20:20:06 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 14:20:05 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Dmitry Frolov <frolov@swemel.ru>, Ajay Joshi <ajay.opensrc@micron.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Fan Ni <fan.ni@samsung.com>, Shiju Jose
	<shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu 2/7] hw/cxl: Fix background completion percentage calculation
Date: Mon, 14 Oct 2024 13:18:57 +0100
Message-ID: <20241014121902.2146424-3-Jonathan.Cameron@huawei.com>
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

From: Ajay Joshi <ajayjoshi@micron.com>

The current completion percentage calculation does not account for the
relative time since the start of the background activity, this leads to
showing incorrect start percentage vs what has actually been completed.

This patch calculates the percentage based on the actual elapsed time since
the start of the operation.

Fixes: 221d2cfbdb53 ("hw/cxl/mbox: Add support for background operations")
Signed-off-by: Ajay Joshi <ajay.opensrc@micron.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Link: https://lore.kernel.org/r/20240729102338.22337-1-ajay.opensrc@micron.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 9f794e4655..3a93966e77 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2879,7 +2879,8 @@ static void bg_timercb(void *opaque)
         }
     } else {
         /* estimate only */
-        cci->bg.complete_pct = 100 * now / total_time;
+        cci->bg.complete_pct =
+            100 * (now - cci->bg.starttime) / cci->bg.runtime;
         timer_mod(cci->bg.timer, now + CXL_MBOX_BG_UPDATE_FREQ);
     }
 
-- 
2.43.0

