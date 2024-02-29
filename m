Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38B216065A
	for <linux-cxl@vger.kernel.org>; Thu, 29 Feb 2024 16:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709224012; cv=none; b=qQSvY35lEf1BbWkZXheKQ/HqJPOPvxXCcMtAL1KT8FM5zIVDPp9YQ1PWtTTqJPM2DYxxz61fYtBb7uziUB9TmbYhBHONZ7/mmTBbs7Z3ll+eo7EiBqGN6mJNgj74ukImtHquZaHTm6fIZcL3lAGqzgo0L8fbCm42LGRA3wSD7Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709224012; c=relaxed/simple;
	bh=IW9sedWW8fEpkkhXK0w2OPsB7dGWEuw8AjP+u+mDkOw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHdkY/ISRLJz6Vv6hu0Zqhl8tpLTA0LvOeOH8HdNerEXSffExlJ5UYQuuqbw7q+9YPGru5+OUlVEg8mUVRsHZZQ32ejU0lAxnRQ5pQk6fjwmRe3ZRBcucV/lrqaG0nWitswbjYT7TrDe7+SD3E0uGz4R8gXKWfAUnbDy6eI0Gbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TlxM03yggz6JB0V;
	Fri,  1 Mar 2024 00:22:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 36FE114134C;
	Fri,  1 Mar 2024 00:26:47 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 16:26:46 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Liu Jingqi <jingqi.liu@intel.com>, <qemu-devel@nongnu.org>,
	<ankita@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov
	<imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
CC: <linuxarm@huawei.com>, Markus Armbruster <armbru@redhat.com>, Daniel Black
	<daniel@linux.ibm.com>, <linux-cxl@vger.kernel.org>
Subject: [PATCH 2/2] hmat acpi: Fix out of bounds access due to missing use of indirection
Date: Thu, 29 Feb 2024 16:25:45 +0000
Message-ID: <20240229162545.7887-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240229162545.7887-1-Jonathan.Cameron@huawei.com>
References: <20240229162545.7887-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

With a numa set up such as

-numa nodeid=0,cpus=0 \
-numa nodeid=1,memdev=mem \
-numa nodeid=2,cpus=1

and appropriate hmat_lb entries the initiator list is correctly
computed and writen to HMAT as 0,2 but then the LB data is accessed
using the node id (here 2), landing outside the entry_list array.

Stash the reverse lookup when writing the initiator list and use
it to get the correct array index index.

Fixes: 4586a2cb83 ("hmat acpi: Build System Locality Latency and Bandwidth Information Structure(s)")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/acpi/hmat.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index 723ae28d32..b933ae3c06 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -78,6 +78,7 @@ static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
                           uint32_t *initiator_list)
 {
     int i, index;
+    uint32_t initiator_to_index[MAX_NODES] = {};
     HMAT_LB_Data *lb_data;
     uint16_t *entry_list;
     uint32_t base;
@@ -121,6 +122,8 @@ static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
     /* Initiator Proximity Domain List */
     for (i = 0; i < num_initiator; i++) {
         build_append_int_noprefix(table_data, initiator_list[i], 4);
+        /* Reverse mapping for array possitions */
+        initiator_to_index[initiator_list[i]] = i;
     }
 
     /* Target Proximity Domain List */
@@ -132,7 +135,8 @@ static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
     entry_list = g_new0(uint16_t, num_initiator * num_target);
     for (i = 0; i < hmat_lb->list->len; i++) {
         lb_data = &g_array_index(hmat_lb->list, HMAT_LB_Data, i);
-        index = lb_data->initiator * num_target + lb_data->target;
+        index = initiator_to_index[lb_data->initiator] * num_target +
+            lb_data->target;
 
         entry_list[index] = (uint16_t)(lb_data->data / hmat_lb->base);
     }
-- 
2.39.2

