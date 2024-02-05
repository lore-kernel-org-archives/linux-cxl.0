Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DA7208CF
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142872; cv=none; b=VwdNZSxw+B0xN/cs9qsPVOXeeDkh5IVs51u+LE7ZUnGxC12hx13AdldGlPYHz8cXqMtRgs1nwQWen1vTclCJ7CON0k/3er1x9R+5942k60FnE6xtcrMHxMnZDx5qugYxLvaVHMhYaus/cknToUEevzjJQPuJUojhEK7tRW2HfWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142872; c=relaxed/simple;
	bh=0CBoay392lAE9uAiGCIKNjyR1+iBnJ7nHYGlDxsVJWQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MaGdVQKXsZFht/zTkw+8ES5EjqT6WaxvizshKCnWOCcAEXkAhIBrlOKCaVgu42gt9fHV6Aeqm99NaZMHVhnxU+I66FRrjdHcvpf9Q1EbruyX7rZS89fFCYDKdS6zNm7t5sjkfNY9XXGGR5HdkQQYvO1Cue1r2vlFnof9PR0czzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TT7kr0Ddtz6J66x;
	Mon,  5 Feb 2024 22:17:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 4FAC1140A87;
	Mon,  5 Feb 2024 22:21:08 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 14:21:07 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
CC: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Dongjiu Geng
	<gengdongjiu1@gmail.com>, <linuxarm@huawei.com>, "Michael S . Tsirkin"
	<mst@redhat.com>, Ira Weiny <ira.weiny@intel.com>, Peter Maydell
	<peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>, Marcel Apfelbaum
	<marcel.apfelbaum@gmail.com>
Subject: [RFC PATCH 03/11] arm/virt: Add fw-first-ras property.
Date: Mon, 5 Feb 2024 14:19:32 +0000
Message-ID: <20240205141940.31111-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240205141940.31111-1-Jonathan.Cameron@huawei.com>
References: <20240205141940.31111-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Provide a machine parameter to request firmware first RAS handling
and no hand over to the OS via _OSC.

Includes a bug fix as register access is not in CDW5 but only
in CXW4 (OS support field).

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/arm/virt.h    |  1 +
 hw/acpi/cxl.c            |  3 ---
 hw/arm/virt-acpi-build.c |  1 +
 hw/arm/virt.c            | 20 ++++++++++++++++++++
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 0a14551f19..84323ccb32 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -153,6 +153,7 @@ struct VirtMachineState {
     bool tcg_its;
     bool virt;
     bool ras;
+    bool fw_first_ras;
     bool mte;
     bool dtb_randomness;
     OnOffAuto acpi;
diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index 526cfe961a..1d6dadbddd 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -316,9 +316,6 @@ static Aml *__build_cxl_osc_method(bool fw_first)
     aml_append(if_cxl, aml_store(aml_name("CDW4"), aml_name("SUPC")));
     aml_append(if_cxl, aml_store(aml_name("CDW5"), aml_name("CTRC")));
 
-    /* CXL 2.0 Port/Device Register access */
-    aml_append(if_cxl,
-               aml_or(aml_name("CDW5"), aml_int(0x1), aml_name("CDW5")));
     aml_append(if_uuid, if_cxl);
 
     aml_append(if_uuid, aml_return(aml_arg(3)));
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index e5f6996111..cdc0bca729 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -208,6 +208,7 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
         .ecam   = memmap[ecam_id],
         .irq    = irq,
         .bus    = vms->bus,
+        .fw_first_ras = vms->fw_first_ras,
     };
 
     if (vms->highmem_mmio) {
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 14d3b66657..c1c8a514d7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2864,6 +2864,20 @@ static void virt_set_ras(Object *obj, bool value, Error **errp)
     vms->ras = value;
 }
 
+static bool virt_get_fw_first_ras(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    return vms->fw_first_ras;
+}
+
+static void virt_set_fw_first_ras(Object *obj, bool value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    vms->fw_first_ras = value;
+}
+
 static bool virt_get_mte(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
@@ -3400,6 +3414,12 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
                                           "Set on/off to enable/disable reporting host memory errors "
                                           "to a KVM guest using ACPI and guest external abort exceptions");
 
+    object_class_property_add_bool(oc, "fw-first-ras", virt_get_fw_first_ras,
+                                   virt_set_fw_first_ras);
+    object_class_property_set_description(oc, "fw-first-ras",
+                                          "Set on/off to control PCI/CXL _OSC allow the guest to"
+                                          "obtain permission to do native handling of AER and CXL errors");
+
     object_class_property_add_bool(oc, "mte", virt_get_mte, virt_set_mte);
     object_class_property_set_description(oc, "mte",
                                           "Set on/off to enable/disable emulating a "
-- 
2.39.2

