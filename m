Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFDE1386A8
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140325; cv=none; b=M9u4nLbK3H4cfyb1UqHRyeiyucHv6sj2ZdcNAd1wX5oRYYc8uhicC+QqdZb6i27p6/99OjNx4BYSaA7amo6iWeIGAw4iRnVJGymSVHcH3D+cMyYF0HhlE2PP1KeSP87EWzjVUJviOtCr5ezrd/crhpUTtf+t4sjO9DawfMKv6bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140325; c=relaxed/simple;
	bh=te6Ox41ORLwQJRAWVuCVTnBV5gUQ2thKqQsLSWxv1Xs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BCECL1JP8ii/qGH2Rb4z4HYHkQlZK8+6vs9cuGBizsjBYuzdkHm0XS76IQie053HakzKn+KXP+QG4iA0k5N6P0nFR+RpAbrZK9bPYIXVys0Ntsl9x8ssRqP17LdHONN3HL0iC11zq7Np1pPzcDROMKn1d98sD1Mxk/3oWcfMMrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V8gxs2pFRz6J9nb;
	Wed,  3 Apr 2024 18:30:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 70EC2140A36;
	Wed,  3 Apr 2024 18:32:00 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 11:31:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>,
	<mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Dave Jiang <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>, <eduardo@habkost.net>,
	<imammedo@redhat.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
	Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
	Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 5/6] bios-tables-test: Add complex SRAT / HMAT test for GI GP
Date: Wed, 3 Apr 2024 11:29:26 +0100
Message-ID: <20240403102927.31263-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403102927.31263-1-Jonathan.Cameron@huawei.com>
References: <20240403102927.31263-1-Jonathan.Cameron@huawei.com>
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

Add a test with 6 nodes to exercise most interesting corner cases
of SRAT and HMAT generation including the new Generic Initiator
and Generic Port Affinity structures.  More details of the
set up in the following patch adding the table data.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tests/qtest/bios-tables-test.c | 92 ++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index d1ff4db7a2..1651d06b7b 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1862,6 +1862,96 @@ static void test_acpi_q35_tcg_acpi_hmat_noinitiator(void)
     free_test_data(&data);
 }
 
+/* Test intended to hit corner cases of SRAT and HMAT */
+static void test_acpi_q35_tcg_acpi_hmat_generic_x(void)
+{
+    test_data data = {};
+
+    data.machine = MACHINE_Q35;
+    data.variant = ".acpihmat-generic-x";
+    test_acpi_one(" -machine hmat=on,cxl=on"
+                  " -smp 3,sockets=3"
+                  " -m 128M,maxmem=384M,slots=2"
+                  " -device virtio-rng-pci,id=gidev"
+                  " -device pxb-cxl,bus_nr=64,bus=pcie.0,id=cxl.1"
+                  " -object memory-backend-ram,size=64M,id=ram0"
+                  " -object memory-backend-ram,size=64M,id=ram1"
+                  " -numa node,nodeid=0,cpus=0,memdev=ram0"
+                  " -numa node,nodeid=1"
+                  " -object acpi-generic-initiator,id=gi0,pci-dev=gidev,node=1"
+                  " -numa node,nodeid=2"
+                  " -object acpi-generic-port,id=gp0,pci-bus=cxl.1,node=2"
+                  " -numa node,nodeid=3,cpus=1"
+                  " -numa node,nodeid=4,memdev=ram1"
+                  " -numa node,nodeid=5,cpus=2"
+                  " -numa hmat-lb,initiator=0,target=0,hierarchy=memory,"
+                  "data-type=access-latency,latency=10"
+                  " -numa hmat-lb,initiator=0,target=0,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=800M"
+                  " -numa hmat-lb,initiator=0,target=2,hierarchy=memory,"
+                  "data-type=access-latency,latency=100"
+                  " -numa hmat-lb,initiator=0,target=2,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=200M"
+                  " -numa hmat-lb,initiator=0,target=4,hierarchy=memory,"
+                  "data-type=access-latency,latency=100"
+                  " -numa hmat-lb,initiator=0,target=4,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=200M"
+                  " -numa hmat-lb,initiator=0,target=5,hierarchy=memory,"
+                  "data-type=access-latency,latency=200"
+                  " -numa hmat-lb,initiator=0,target=5,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=400M"
+                  " -numa hmat-lb,initiator=1,target=0,hierarchy=memory,"
+                  "data-type=access-latency,latency=500"
+                  " -numa hmat-lb,initiator=1,target=0,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=100M"
+                  " -numa hmat-lb,initiator=1,target=2,hierarchy=memory,"
+                  "data-type=access-latency,latency=50"
+                  " -numa hmat-lb,initiator=1,target=2,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=400M"
+                  " -numa hmat-lb,initiator=1,target=4,hierarchy=memory,"
+                  "data-type=access-latency,latency=50"
+                  " -numa hmat-lb,initiator=1,target=4,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=800M"
+                  " -numa hmat-lb,initiator=1,target=5,hierarchy=memory,"
+                  "data-type=access-latency,latency=500"
+                  " -numa hmat-lb,initiator=1,target=5,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=100M"
+                  " -numa hmat-lb,initiator=3,target=0,hierarchy=memory,"
+                  "data-type=access-latency,latency=20"
+                  " -numa hmat-lb,initiator=3,target=0,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=400M"
+                  " -numa hmat-lb,initiator=3,target=2,hierarchy=memory,"
+                  "data-type=access-latency,latency=80"
+                  " -numa hmat-lb,initiator=3,target=2,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=200M"
+                  " -numa hmat-lb,initiator=3,target=4,hierarchy=memory,"
+                  "data-type=access-latency,latency=80"
+                  " -numa hmat-lb,initiator=3,target=4,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=200M"
+                  " -numa hmat-lb,initiator=3,target=5,hierarchy=memory,"
+                  "data-type=access-latency,latency=20"
+                  " -numa hmat-lb,initiator=3,target=5,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=400M"
+                  " -numa hmat-lb,initiator=5,target=0,hierarchy=memory,"
+                  "data-type=access-latency,latency=20"
+                  " -numa hmat-lb,initiator=5,target=0,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=400M"
+                  " -numa hmat-lb,initiator=5,target=2,hierarchy=memory,"
+                  "data-type=access-latency,latency=80"
+                  " -numa hmat-lb,initiator=5,target=4,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=200M"
+                  " -numa hmat-lb,initiator=5,target=4,hierarchy=memory,"
+                  "data-type=access-latency,latency=80"
+                  " -numa hmat-lb,initiator=5,target=2,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=200M"
+                  " -numa hmat-lb,initiator=5,target=5,hierarchy=memory,"
+                  "data-type=access-latency,latency=10"
+                  " -numa hmat-lb,initiator=5,target=5,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=800M",
+                  &data);
+    free_test_data(&data);
+}
+
 #ifdef CONFIG_POSIX
 static void test_acpi_erst(const char *machine)
 {
@@ -2304,6 +2394,8 @@ int main(int argc, char *argv[])
             qtest_add_func("acpi/q35/nohpet", test_acpi_q35_tcg_nohpet);
             qtest_add_func("acpi/q35/acpihmat-noinitiator",
                            test_acpi_q35_tcg_acpi_hmat_noinitiator);
+            qtest_add_func("acpi/q35/acpihmat-genericx",
+                           test_acpi_q35_tcg_acpi_hmat_generic_x);
 
             /* i386 does not support memory hotplug */
             if (strcmp(arch, "i386")) {
-- 
2.39.2

