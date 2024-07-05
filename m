Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCA1146A96
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jul 2024 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179633; cv=none; b=gnLqeAF04mfKoe23s/wQn6fjKTVawJn0HmyCAbwhvSj39rXKgJGsMaLe5F4fbEkfGbsa+oexXwOVHCifnknWPXc9qFPQ3RVBdvu93mtfWG6JuDv/dUCB6PI3Fpg+fqyPd/Yp8Boixsok5zGQLO3l/D3o274XRNP/LEJB41kdCP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179633; c=relaxed/simple;
	bh=D5L0XreID7lO9XFtEGZBiFGZz/tbBZpKAoEjN44xON4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7+agr0iQfk0Zb9eef+S64HLKQN3+txB82bHufqqqMT0oFDKm96YwyeQvTxVPh3OJmQ3GAn0bPrkfweQOq62nDLY2piauv6sbD8NleLI3U9WQngZHQgum5XzXZX0CwDuUQXin/J9aYrlY2R3EwnA4RCq3vxcq0/uXsJ3O08s/MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFs4b4R1nz6JBWG;
	Fri,  5 Jul 2024 19:39:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BDBF81400D1;
	Fri,  5 Jul 2024 19:40:27 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 12:40:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: <linux-cxl@vger.kernel.org>, Markus Armbruster <armbru@redhat.com>, Li
 Zhijian <lizhijian@fujitsu.com>, <linuxarm@huawei.com>, Zhao Liu
	<zhao1.liu@linux.intel.com>, Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v2 1/3] hw/cxl/cxl-host: Fix segmentation fault when getting cxl-fmw property
Date: Fri, 5 Jul 2024 12:39:54 +0100
Message-ID: <20240705113956.941732-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240705113956.941732-1-Jonathan.Cameron@huawei.com>
References: <20240705113956.941732-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

From: Zhao Liu <zhao1.liu@intel.com>

QEMU crashes (Segmentation fault) when getting cxl-fmw property via
qmp:

(QEMU) qom-get path=machine property=cxl-fmw

This issue is caused by accessing wrong callback (opaque) type in
machine_get_cfmw().

cxl_machine_init() sets the callback as `CXLState *` type but
machine_get_cfmw() treats the callback as
`CXLFixedMemoryWindowOptionsList **`.

Fix this error by casting opaque to `CXLState *` type in
machine_get_cfmw().

Fixes: 03b39fcf64bc ("hw/cxl: Make the CXL fixed memory window setup a machine parameter.")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
Link: https://lore.kernel.org/r/20240704093404.1848132-1-zhao1.liu@linux.intel.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-host.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index c5f5fcfd64..e9f2543c43 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -315,7 +315,8 @@ static void machine_set_cxl(Object *obj, Visitor *v, const char *name,
 static void machine_get_cfmw(Object *obj, Visitor *v, const char *name,
                              void *opaque, Error **errp)
 {
-    CXLFixedMemoryWindowOptionsList **list = opaque;
+    CXLState *state = opaque;
+    CXLFixedMemoryWindowOptionsList **list = &state->cfmw_list;
 
     visit_type_CXLFixedMemoryWindowOptionsList(v, name, list, errp);
 }
-- 
2.43.0

