Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A184555E73
	for <linux-cxl@vger.kernel.org>; Fri, 24 May 2024 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545235; cv=none; b=uCIhKhHTsQl0dwJJEKsMjgMlVrKuLE9EYI5w4DDjqRFf6xmSXB6VmvwgIxvrWQFdLNT9OXSfpu94q23OpA+4MCHmK7fAz0fEnUY2cfRmfnqU7JjFig6neuOXM8rxjvbPRq5c279IicNCYHpnkbsmAZM9QFLElG7xbgTDSIdEEgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545235; c=relaxed/simple;
	bh=4hvwa4oHxailkrgF/XwV9MOP/DX+7hKrCEtdc/0Y6k4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YmtBc50d6mTfBuxpUvLt/k+l6Ny7pUayMFL+2r49BKfozmzh08IuNJAGs5Adryt+47ZHf9nrOiUIG6XQDj9Pb8kq4EA8hnXfUVIq+9u3F48Y55iDRJ6JMG5B04c5OJa/ooJ5E0J1fmE9XHlh8lRZd4OnVs64V6XjVIcVCPv2jWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vm0wd5YTXz6K5sF;
	Fri, 24 May 2024 18:03:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 55F4D1400C9;
	Fri, 24 May 2024 18:07:11 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 11:07:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	<qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
	<philmd@linaro.org>
CC: Dave Jiang <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>, <eduardo@habkost.net>,
	<imammedo@redhat.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
	Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 4/6] bios-tables-test: Allow for new acpihmat-generic-x test data.
Date: Fri, 24 May 2024 11:05:05 +0100
Message-ID: <20240524100507.32106-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240524100507.32106-1-Jonathan.Cameron@huawei.com>
References: <20240524100507.32106-1-Jonathan.Cameron@huawei.com>
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

The test to be added exercises many corners of the SRAT and HMAT
table generation.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 5 +++++
 tests/data/acpi/q35/APIC.acpihmat-generic-x | 0
 tests/data/acpi/q35/CEDT.acpihmat-generic-x | 0
 tests/data/acpi/q35/DSDT.acpihmat-generic-x | 0
 tests/data/acpi/q35/HMAT.acpihmat-generic-x | 0
 tests/data/acpi/q35/SRAT.acpihmat-generic-x | 0
 6 files changed, 5 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..a5aa801c99 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,6 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/APIC.acpihmat-generic-x",
+"tests/data/acpi/q35/CEDT.acpihmat-generic-x",
+"tests/data/acpi/q35/DSDT.acpihmat-generic-x",
+"tests/data/acpi/q35/HMAT.acpihmat-generic-x",
+"tests/data/acpi/q35/SRAT.acpihmat-generic-x",
diff --git a/tests/data/acpi/q35/APIC.acpihmat-generic-x b/tests/data/acpi/q35/APIC.acpihmat-generic-x
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/CEDT.acpihmat-generic-x b/tests/data/acpi/q35/CEDT.acpihmat-generic-x
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/DSDT.acpihmat-generic-x b/tests/data/acpi/q35/DSDT.acpihmat-generic-x
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/HMAT.acpihmat-generic-x b/tests/data/acpi/q35/HMAT.acpihmat-generic-x
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/SRAT.acpihmat-generic-x b/tests/data/acpi/q35/SRAT.acpihmat-generic-x
new file mode 100644
index 0000000000..e69de29bb2
-- 
2.39.2

