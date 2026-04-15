Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6BD22097
	for <linux-cxl@vger.kernel.org>; Wed, 15 Apr 2026 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776263446; cv=none; b=nrgtVLGhBBrBUhN+Ej1r/eHP7Fx4iyeJPNbFwvfKtPM8PRNH6BsdfrsT6IpZZQQe++mSLap7qw/GxN8l7Gxu8vg6h+Czth0Z9Jem4kAtYipQM1bNV2Kud/m2SkPSIHsAgP2b4n+W9DHAtefgho7oPk7jjRp+ti1GBmpws6CEJIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776263446; c=relaxed/simple;
	bh=cINymxpPg0eMeegUxtexMn/wkSDk/zEQ+vkD22k3IYw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dm1vY0Q8uk2zAdRkwnLsqfK9vSwzlOUFWPaKGu7g6o/GNchAbiYPrYTFc71ySlDGw4wiNyk43BQZIUAuuc7sC9r8MCm+i5/ZP/CteefgV+4O1FLG/L8+Wh4gmTiiCANayrbeVbanY9WiNO2uaYIFecCDvfwzDFLtfBdcaygra9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fwk7V0srbzJ46BV;
	Wed, 15 Apr 2026 22:29:58 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F5114056B;
	Wed, 15 Apr 2026 22:30:41 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.123.51.176) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Apr 2026 15:30:40 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>, <mst@redhat.com>,
	Fan Ni <nifan.cxl@gmail.com>
CC: <linuxarm@huawei.com>, <venkataravis@micron.com>
Subject: [PATCH] MAINTAINERS: Update CXL maintainers entry including adding linux-cxl list
Date: Wed, 15 Apr 2026 15:30:39 +0100
Message-ID: <20260415143040.22223-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)

The CXL maintainers entry needs an update.
For a while convention has been to +CC linux-cxl@vger.kernel.org to get
better coverage for CXL aspects so formalize that with an L entry.

Drop Fan as he has not been at Samsung for a while now.
Switch my email address over to my kernel.org one.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---

I'll look to add some more reviewer / maintainers in the coming months as
I'm not keen on being the sole person for this one given fairly high level
of activity. Note the email address change doesn't mean I'll be less active
on this!

---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ad215eced84d..1fb25f8637eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3190,8 +3190,8 @@ F: tests/qtest/migration/cpr*
 F: docs/devel/migration/CPR.rst
 
 Compute Express Link
-M: Jonathan Cameron <jonathan.cameron@huawei.com>
-R: Fan Ni <fan.ni@samsung.com>
+M: Jonathan Cameron <jic23@kernel.org>
+L: linux-cxl@vger.kernel.org
 S: Supported
 F: hw/cxl/
 F: hw/mem/cxl_type3.c
-- 
2.51.0

