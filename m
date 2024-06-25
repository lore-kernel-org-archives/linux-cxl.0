Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901A211185
	for <linux-cxl@vger.kernel.org>; Tue, 25 Jun 2024 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719335352; cv=none; b=EKnQ3FHmqUPQ+QTWoecfR/aw5BIZKzElB+OUzaqjqyHSQQjVJz4feZm1c6Q/FQEuMbc8f9Usd5Tf4/czLbAdIn/mfoTRg8XmBihx4m2b+yzihdiH8K68oCgMD4g3idZNbkoSgS7z3W+Jx5/ycmlFHkuvtGEuXsPZdiWyzidodtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719335352; c=relaxed/simple;
	bh=Oq+IyPHKChXecMe5aPri/gV2QfRxHOTya7iijvQbjPY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uk6TaQJlaO4axvPQD/FkUjBJ1E2DWOELIr7BWfsVgNoZT8joQ6jeDEE2EcCGp6yHYlrAyoQXvLxKLTuCacfbZEr6c13eUSx/3WELl8/K0tYj4UpQlhZAAK71ovaoAXb1jJrw0KtoF/KmDZgOKxfdJNWlFPwfeU5A+zaC9Y6C8oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W7rrX07rDz6K6Z2;
	Wed, 26 Jun 2024 01:08:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 51F4F140B67;
	Wed, 26 Jun 2024 01:09:07 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 18:09:06 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>,
	<linux-cxl@vger.kernel.org>, <mst@redhat.com>, <armbru@redhat.com>
CC: <linuxarm@huawei.com>
Subject: [PATCH 2/2] hw/cxl/events: Mark cxl-add-dynamic-capacity and cxl-release-dynamic-capcity unstable
Date: Tue, 25 Jun 2024 18:08:05 +0100
Message-ID: <20240625170805.359278-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625170805.359278-1-Jonathan.Cameron@huawei.com>
References: <20240625170805.359278-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Markus suggested that we make the unstable. I don't expect these
interfaces to change because of their tight coupling to the Compute
Express Link (CXL) Specification, Revision 3.1 Fabric Management API
definitions which can only be extended in backwards compatible way.
However, there seems little disadvantage in taking a cautious path
for now and marking them as unstable interfaces.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 qapi/cxl.json | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index a38622a0d1..bdfac67c47 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -453,6 +453,10 @@
 # @extents: The "Extent List" field as defined in Compute Express Link
 #     (CXL) Specification, Revision 3.1, Table 7-70.
 #
+# Features:
+#
+# @unstable: For now this command is subject to change.
+#
 # Since : 9.1
 ##
 { 'command': 'cxl-add-dynamic-capacity',
@@ -462,7 +466,8 @@
             'region': 'uint8',
             '*tag': 'str',
             'extents': [ 'CxlDynamicCapacityExtent' ]
-           }
+           },
+  'features': [ 'unstable' ]
 }
 
 ##
@@ -527,6 +532,10 @@
 # @extents: The "Extent List" field as defined in Compute Express
 #     Link (CXL) Specification, Revision 3.1, Table 7-71.
 #
+# Features:
+#
+# @unstable: For now this command is subject to change.
+#
 # Since : 9.1
 ##
 { 'command': 'cxl-release-dynamic-capacity',
@@ -538,5 +547,6 @@
             'region': 'uint8',
             '*tag': 'str',
             'extents': [ 'CxlDynamicCapacityExtent' ]
-           }
+           },
+  'features': [ 'unstable' ]
 }
-- 
2.43.0

