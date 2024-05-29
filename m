Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB77D27E
	for <linux-cxl@vger.kernel.org>; Wed, 29 May 2024 17:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002975; cv=none; b=sZ2xdHtWLudWSCQoWvgmc5IIvDNNlnAGZtHwW1xR7K2RXOi8HzVpBZkRdqLpSFgP8doB+DuT6hKCCSN7wLwypG0ViFsro6Jc2KhSJw2+CE/0VgfHGiRp5vDgf2njZpERz4O0y8fHcS/DEusbhCTV84hj4gVBYTONHdLCCWcol8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002975; c=relaxed/simple;
	bh=K03T0Q9x2ykCvP4DRMZCiFiPTWvLisb0BzZPz0JDC20=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B82awVrMyL+GptIBsXezEzHC5lqqqpJLm4yhWBNGZtEQIR4bs8gCOtRrzZNtLA4CAFkh+yStf+nUPfBjQRPAGIA3h+VlQPImmbevD9ujE/AAJDeybhP7QThVEYYgohesGOkC4teK8QD1iQMEml09xMOkv/K7OH+E9P5r64PRZ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VqGGl2clRz67l0C;
	Thu, 30 May 2024 01:15:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 4EFAF140447;
	Thu, 30 May 2024 01:16:12 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 18:16:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Sudeep Holla <sudeep.holla@arm.com>
CC: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@redhat.com>, Will Deacon <will@kernel.org>, Jia He
	<justin.he@arm.com>, Mike Rapoport <rppt@linux.ibm.com>,
	<linuxarm@huawei.com>, <catalin.marinas@arm.com>,
	<Anshuman.Khandual@arm.com>, Yuquan Wang <wangyuquan1236@phytium.com.cn>,
	Oscar Salvador <osalvador@suse.de>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, James Morse <james.morse@arm.com>
Subject: [RFC PATCH 7/8] acpi: srat: cxl: Skip zero length CXL fixed memory windows.
Date: Wed, 29 May 2024 18:12:35 +0100
Message-ID: <20240529171236.32002-8-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529171236.32002-1-Jonathan.Cameron@huawei.com>
References: <20240529171236.32002-1-Jonathan.Cameron@huawei.com>
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

One reported platform uses this nonsensical entry to represent
a disable CFWMS. The acpi_cxl driver already correctly errors
out on seeing this, but that leaves an additional confusing node
in /sys/devices/system/nodes/possible plus wastes some space.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/acpi/numa/srat.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index e3f26e71637a..28c963d5c51f 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -329,6 +329,11 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 	int node;
 
 	cfmws = (struct acpi_cedt_cfmws *)header;
+
+	/* At least one firmware reports disabled entries with size 0 */
+	if (cfmws->window_size == 0)
+		return 0;
+
 	start = cfmws->base_hpa;
 	end = cfmws->base_hpa + cfmws->window_size;
 
-- 
2.39.2

