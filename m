Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC8775808
	for <linux-cxl@vger.kernel.org>; Thu, 29 Feb 2024 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223982; cv=none; b=X0nrFjC1R7onWAiM/n/ULZOcSQ93SfquwZzRoY9K1oeywFk69WwLjCf5ElF9JFppObiTz+wVPTNHfI543BEUpZ/iMBrviiWOu1w29buFiFKaI3QyQBhWZ9vku8nK0iia6fQ52g3jX2K9g5thOegw+9z49WT8LCMcna67mPPOus4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223982; c=relaxed/simple;
	bh=0MYvJpoywLaR3WT1YKaGu1I6tv2YFYmFoJ06qKVkv1Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CaRd+KXaax9+BdEahg2qr5H1YRSU40N+klcKE3Mh15qmPFsPOvSArHUNptIkEIeLws/59dWGYTf64g6YErxEFV22U6CcHxvj3Jmk3HhPGfSLccwdMEZnKOkXuLiwV9Ejf5RsCrS0FC5FyPJshy1JUdScLJpHJa1Cu5rEGhz4cwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TlxMS6PsKz6K8sx;
	Fri,  1 Mar 2024 00:22:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A4880140B63;
	Fri,  1 Mar 2024 00:26:16 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 16:26:16 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Liu Jingqi <jingqi.liu@intel.com>, <qemu-devel@nongnu.org>,
	<ankita@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov
	<imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
CC: <linuxarm@huawei.com>, Markus Armbruster <armbru@redhat.com>, Daniel Black
	<daniel@linux.ibm.com>, <linux-cxl@vger.kernel.org>
Subject: [PATCH 1/2] hmat acpi: Do not add Memory Proximity Domain Attributes Structure targetting non existent memory.
Date: Thu, 29 Feb 2024 16:25:44 +0000
Message-ID: <20240229162545.7887-2-Jonathan.Cameron@huawei.com>
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

If qemu is started with a proximity node containing CPUs alone,
it will provide one of these structures to say memory in this
node is directly connected to itself.

This description is arguably pointless even if there is memory
in the node.  If there is no memory present, and hence no SRAT
entry it breaks Linux HMAT passing and the table is rejected.

https://elixir.bootlin.com/linux/latest/source/drivers/acpi/numa/hmat.c#L444

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/acpi/hmat.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index 3042d223c8..723ae28d32 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -204,6 +204,13 @@ static void hmat_build_table_structs(GArray *table_data, NumaState *numa_state)
     build_append_int_noprefix(table_data, 0, 4); /* Reserved */
 
     for (i = 0; i < numa_state->num_nodes; i++) {
+        /*
+         * Linux rejects whole HMAT table if a node with no memory
+         * has one of these structures listing it as a target.
+         */
+        if (!numa_state->nodes[i].node_mem) {
+            continue;
+        }
         flags = 0;
 
         if (numa_state->nodes[i].initiator < MAX_NODES) {
-- 
2.39.2

