Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FA71AF697
	for <linux-cxl@vger.kernel.org>; Thu, 20 Jun 2024 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899532; cv=none; b=TsJXqbgcG0qcA2sL52UVCn8IywRD+XWxZEUVLKBHIaJ86rtLyCBPdBRw54SNALgsReJABZSROk5oF2HEb3xcw+iVNgg75LwVTmvuDWt3XWG3w/grd5pGsdAjQprK3b2ca1heu4tLOQPPG5x7OId82zznP11T7f9wpbyy6srIt8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899532; c=relaxed/simple;
	bh=XQ5UcKJH29k2XFxMA7K9vo7lUp4m7pdxYabwJgRIGnc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDykQCXqQubc4bCs0YqMh8RUP/O091o0LXSaKZuLt+sBr26KGtwLoBkAgbN3hOdfBV6+W7Lubt7adrci8BqCfFUlcDFnzsyg+wDIvjovojykT5GnZYFTOiFDqYOmQL9wPNhEc+8oLU+I6+vSEyQsWcquFYkVGqSsKSFVsiDfsFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W4lgh4NFPz6K6X0;
	Fri, 21 Jun 2024 00:05:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C20681400D7;
	Fri, 21 Jun 2024 00:05:28 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 17:05:28 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>,
	<marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
	<richard.henderson@linaro.org>
CC: <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
	<michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v3 04/11] hw/acpi: Rename build_all_acpi_generic_initiators() to build_acpi_generic_initiator()
Date: Thu, 20 Jun 2024 17:03:12 +0100
Message-ID: <20240620160324.109058-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Igor noted that this function only builds one instance, so was rather
misleadingly named. Fix that.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v3: New patch
---
 hw/acpi/acpi_generic_initiator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
index 7665b16107..73bafaaaea 100644
--- a/hw/acpi/acpi_generic_initiator.c
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -74,7 +74,7 @@ static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
         acpi_generic_initiator_set_node, NULL, NULL);
 }
 
-static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
+static int build_acpi_generic_initiator(Object *obj, void *opaque)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     AcpiGenericInitiator *gi;
@@ -111,6 +111,6 @@ static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
 void build_srat_generic_pci_initiator(GArray *table_data)
 {
     object_child_foreach_recursive(object_get_root(),
-                                   build_all_acpi_generic_initiators,
+                                   build_acpi_generic_initiator,
                                    table_data);
 }
-- 
2.43.0

