Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545DA79DE
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jan 2024 12:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706270586; cv=none; b=G5cpyTYv8oaZiWRGKM3ObjwC4uRgwf7bv8l65o1vypZYTLQyWncfRhVZnngeeN8ug49i4m132er+Sg5WUkOHwziwXdSQ5/Um/K7Aw2Gh9IpOqg9nibRESI5LdgiojjqQa9/2A2puWv6b+6X+uYGDq0zKFCijKhvXbZu7fx3FIck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706270586; c=relaxed/simple;
	bh=zsBAX6RRWxqBzZsLOje3TTWd+VYmRxcVZx0Oc7VAWwg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pAYhkigSPKtOnZonoUjA90ngWKHKS+tSPb1rtjnm0fMCxMRgZZbP8RYC/qpsH6ob7BHnak1QgqRPHuxC5brAlj5oo4WDPhfyZNYOv+R6gY5YWPFoSx5+TGmEmgP19Swzb+vdUAg4K4B2iKkmPKJdomIq8pLJvxqti5e4/Cjt4VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TLx8j5Bs1z6FGYD;
	Fri, 26 Jan 2024 20:00:21 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 18B39140CF4;
	Fri, 26 Jan 2024 20:03:02 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 12:03:01 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Fan Ni
	<fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>
CC: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	<peter.maydell@linaro.org>, Davidlohr Bueso <dave@stgolabs.net>, Hyeonggon
 Yoo <42.hyeyoo@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, Stefan
 Hajnoczi <stefanha@gmail.com>, <linuxarm@huawei.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 03/12] hw/pci-bridge/cxl_upstream: Drop g_malloc() failure handling
Date: Fri, 26 Jan 2024 12:01:23 +0000
Message-ID: <20240126120132.24248-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240126120132.24248-1-Jonathan.Cameron@huawei.com>
References: <20240126120132.24248-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

As a failure of g_malloc() will result in QEMU exiting, it
won't return a NULL to check.  As such, drop the incorrect handling
of such NULL returns in the cdat table building code.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/pci-bridge/cxl_upstream.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index 36737189c6..d5341b530f 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -228,9 +228,6 @@ static int build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
 
     sslbis_size = sizeof(CDATSslbis) + sizeof(*sslbis_latency->sslbe) * count;
     sslbis_latency = g_malloc(sslbis_size);
-    if (!sslbis_latency) {
-        return -ENOMEM;
-    }
     *sslbis_latency = (CDATSslbis) {
         .sslbis_header = {
             .header = {
@@ -251,9 +248,6 @@ static int build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     }
 
     sslbis_bandwidth = g_malloc(sslbis_size);
-    if (!sslbis_bandwidth) {
-        return 0;
-    }
     *sslbis_bandwidth = (CDATSslbis) {
         .sslbis_header = {
             .header = {
-- 
2.39.2

