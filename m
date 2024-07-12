Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386E4433C7
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jul 2024 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720782644; cv=none; b=NjqFxwU5Eo27pNzsHpVRSx8DA+mqbRiizkV6TkO2bIxbstJX1YwgQCXKR6T4jiW/7oB2wNMYPGjzX2o9um7wGyON7r++9I4irLYirpvazUE/kd1oO+SmRi313JYnXFck05CniVrzeFYSAR2xd1FiGqYYIc6Uc+APamWrUVQlL7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720782644; c=relaxed/simple;
	bh=s6UNhHX6yrNSittUzaN5LPLu/x6nCP4V5qakY7/DTPg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ray0WSNqVuYW4C+/wlCYc181teNEh0C4HbH/0aqIXT0+yM3az8kqtxANgK5+ZSHDnAyKBSXyDbrSGhLdNfrWq8PibId3ZK/4wKM2fmHqcVmUwacymz4qM0ibGEQ43rfzGeoI4UInJ2jEWUo+c0itNqRNXPmW+hNA1DL36TBYEtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WL83P5Brlz6K92L;
	Fri, 12 Jul 2024 19:08:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 80DDD140B2A;
	Fri, 12 Jul 2024 19:10:40 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 12:10:40 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
	<marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
	<richard.henderson@linaro.org>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>, Ani Sinha
	<anisinha@redhat.com>
Subject: [PATCH v5 04/13] hw/acpi: Rename build_all_acpi_generic_initiators() to build_acpi_generic_initiator()
Date: Fri, 12 Jul 2024 12:08:08 +0100
Message-ID: <20240712110837.1439736-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712110837.1439736-1-Jonathan.Cameron@huawei.com>
References: <20240712110837.1439736-1-Jonathan.Cameron@huawei.com>
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

Igor noted that this function only builds one instance, so was rather
misleadingly named. Fix that.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v5: No change
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

