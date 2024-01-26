Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A3413FE4
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jan 2024 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706270860; cv=none; b=Kc41bJFaRziZnnSwoEzW3zpLs/RfVAMiKzgNGk/OJxmuEBn+vXAGTrTd5F178TrtmT9D4DFuotpq/DderlVOY32PxuhkrDXrxSdhqy/5cRus/UHEUfuQxGY+z1bo7HMq7OZNJCu6QTeItLdBHmvV2H/3h987UI6GNI+rfi9Rvdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706270860; c=relaxed/simple;
	bh=gKTn8xCvuFHq9BRasJt+Y+xgtJSN7rIDvsWQlFv7Okk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqS/Js0QyL7sqOi9UDoDNTGT398AGoVNV8LKDMlcbGhchEXm8uC70LKbZ212j/DawHIRFXMg7cntSb3pyb4CsrPHorQVM6J9vqSZo5jF3Pc2eZ78JgKWH4KvG4tBEOq5Q6cKvP/mkz7Bp2vSiDGxK60fjiwi6zzlF5IwSGlKrXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TLxFW5GtTz67pJF;
	Fri, 26 Jan 2024 20:04:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 46374140A1B;
	Fri, 26 Jan 2024 20:07:37 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 12:07:36 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Fan Ni
	<fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>
CC: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	<peter.maydell@linaro.org>, Davidlohr Bueso <dave@stgolabs.net>, Hyeonggon
 Yoo <42.hyeyoo@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, Stefan
 Hajnoczi <stefanha@gmail.com>, <linuxarm@huawei.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 12/12] tests/acpi: Update DSDT.cxl to reflect change _STA return value.
Date: Fri, 26 Jan 2024 12:01:32 +0000
Message-ID: <20240126120132.24248-13-Jonathan.Cameron@huawei.com>
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

_STA will now return 0xB (in common with most other devices)
rather than not setting the bits to indicate this fake device
has not been enabled, and self tests haven't passed.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 tests/data/acpi/q35/DSDT.cxl                | Bin 9713 -> 9714 bytes
 2 files changed, 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 9ce0f596cc..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/q35/DSDT.cxl",
diff --git a/tests/data/acpi/q35/DSDT.cxl b/tests/data/acpi/q35/DSDT.cxl
index 145301c52af9a17242bb306c210f8a7e0f01b827..afcdc0d0ba8e41bb70ac20a78dcc8562ca0cb74b 100644
GIT binary patch
delta 64
zcmez9{mGllCD<k8lPUuP<Nb|X6BX6{S>uD9;-j0~S)C(%d^zGhJY9GlodY}#3=GW~
UL^$JvLmU~FaB*)wsA#|f0Fwq1RsaA1

delta 63
zcmez5{n4AtCD<k8qbdUf<M)kR6BX6`SmT48;-j0~Se+w$d^zGhJY9GlodY}#3=GW~
TL^$GuLmU~FFm67iXutvhh3yhn

-- 
2.39.2

