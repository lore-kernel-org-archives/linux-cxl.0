Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA713DDAA
	for <linux-cxl@vger.kernel.org>; Wed,  5 Jun 2024 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610700; cv=none; b=HZc7oTLPcWpxcSzpjvT839vXiZ/N8i1xhSxuWbpqtmmPxSoJyP7wvAzh5AA7Re9N2OEnPeigyThQaI3dItgmx1nPN2xm5Xmky9pfjY1cTcZFoN4vBIBAzbLhEGwYQm58zQzHfMaq5DjeZQhzscEgKFqWSxW1YwFv6qRZRHVtv2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610700; c=relaxed/simple;
	bh=ehX4dM3BSlnLhkOj9iI2+cSUmgxh9GvPyo0WKyYWhMc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p3nLKjOZm4zfM46UGWcSFKg4tp7LAbIjyyZcBz3nsWf9+CCAJvcsHi62/+o3Ri00IsYkGkfqs62Y4k0CwZW+153fo9JPF0prr8wfwvheGkwT4b5Xlhy7LgCYYkcso6e9bWKPRIlfEjwiaxhDrDrWE13XPeolxBiL7xTlTff+c40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VvZxZ31tTz6K7CW;
	Thu,  6 Jun 2024 02:00:18 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 98ABA1400D9;
	Thu,  6 Jun 2024 02:04:55 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 19:04:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	<qemu-devel@nongnu.org>, <ankita@nvidia.com>, <philmd@linaro.org>, Richard
 Henderson <richard.henderson@linaro.org>
CC: Dave Jiang <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>, <eduardo@habkost.net>,
	<imammedo@redhat.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
	Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH qemu ] hw/acpi: Fix big endian host creation of Generic Port Affinity Structures
Date: Wed, 5 Jun 2024 19:04:55 +0100
Message-ID: <20240605180455.18193-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Treating the HID as an integer caused it to get bit reversed
on big endian hosts running little endian guests.  Treat it
as a character array instead.

Fixes hw/acpi: Generic Port Affinity Structure Support
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
Richard ran the version posted in the thread on an s390 instance.
Thanks for the help!

Difference from version in thread:
- Instantiate i in the for loop.

Sending out now so Michael can decide whether to fold this in, or
drop the GP series for now from his pull request (in which case
I'll do an updated version with this and Markus' docs feedback
folded in.)

---
 include/hw/acpi/acpi_generic_initiator.h | 2 +-
 hw/acpi/acpi_generic_initiator.c         | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
index 1a899af30f..5baefda33a 100644
--- a/include/hw/acpi/acpi_generic_initiator.h
+++ b/include/hw/acpi/acpi_generic_initiator.h
@@ -61,7 +61,7 @@ typedef struct PCIDeviceHandle {
             uint16_t bdf;
         };
         struct {
-            uint64_t hid;
+            char hid[8];
             uint32_t uid;
         };
     };
diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
index 78b80dcf08..f064753b67 100644
--- a/hw/acpi/acpi_generic_initiator.c
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -151,7 +151,9 @@ build_srat_generic_node_affinity(GArray *table_data, int node,
         build_append_int_noprefix(table_data, 0, 12);
     } else {
         /* Device Handle - ACPI */
-        build_append_int_noprefix(table_data, handle->hid, 8);
+        for (int i = 0; i < sizeof(handle->hid); i++) {
+            build_append_int_noprefix(table_data, handle->hid[i], 1);
+        }
         build_append_int_noprefix(table_data, handle->uid, 4);
         build_append_int_noprefix(table_data, 0, 4);
     }
-- 
2.39.2

