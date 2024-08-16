Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A55A1BE228;
	Fri, 16 Aug 2024 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817306; cv=none; b=DE6Lxz45CUdnFilanO9q7weKhP5RsB3NwgqQpv8JQxllpqTNrXjs95ijgzaDU/yll0i4OZyUms1pJ4sAah2LWaGFMWXof8YtMlET1KoCVfvV8rIECcx9MopmX+xg+Vqtqxwi5p9GBAN6Cgu+HVeMzFvquvJXiWkub+SzEd5QSsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817306; c=relaxed/simple;
	bh=Yxs6rOhOAnILUvfuNu1XjV+CZeVOQEQlcDsNNQlt028=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ijcHa71g89SQ/sNgvSoQXKUrOoTJ7kXTRgTTR7llRvY/vKL6Fe+t2py9tI5h6Lrk7Rcx0tPY92dPj7dlSxQRx3k2wYHOQWuKS1Eq0d77KflyUe5MQcD9xwZNvFeCz1HsSETR/l6QCnuGvpDBCCxgliQzns5jQi1C6VJy/lNxrOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P7v5HVfl; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P7v5HVfl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723817305; x=1755353305;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Yxs6rOhOAnILUvfuNu1XjV+CZeVOQEQlcDsNNQlt028=;
  b=P7v5HVflJ4tC0KT7QrwOu4kijV4psB3Ci0IQIdnrqVu4rHyYyVXjMi22
   G6hj5LdMSbvQ5YPAWFZt9xWT5k3gj79ZcNCyBInygb3sOCLWGsgooFJHP
   Jt/U6NHxGHlMpTlfwD5l7EDdAkGCeePUjHObI1LrCDmAw6RwfUOYZUvDP
   6RJ4FSF534G2fBxTvNZdV81zQF8OI56G66F5NPF7wHN4qr8lF1hKT+aKr
   1hq2/vprwvvboayaw1KmjXWmbcNNxHyBlXndXFgnl89/BJUEa2TkvrIuv
   gELHBlPFK0p1x0+HczIAVMtC0RjSu64JUE4fJ3Grz7f0wtkk3TwH7pa5A
   Q==;
X-CSE-ConnectionGUID: 25qrmMi4Su2EOG/XyEWhxA==
X-CSE-MsgGUID: Sd7HzWM9Tm+AqOo3ftQBrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22260930"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22260930"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:08:23 -0700
X-CSE-ConnectionGUID: vWz7P9ObQTaT5PUT6g1GPA==
X-CSE-MsgGUID: /pAqIhuTRSGFMrI1WEY0AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="59847803"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:08:22 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 16 Aug 2024 09:08:10 -0500
Subject: [PATCH RESEND v2 05/18] cxl/port: Add Dynamic Capacity mode
 support to endpoint decoders
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v2-5-b4044aadf2bd@intel.com>
References: <20240816-dcd-type2-upstream-v2-0-b4044aadf2bd@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v2-0-b4044aadf2bd@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Navneet Singh <navneet.singh@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723817288; l=4798;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=Yxs6rOhOAnILUvfuNu1XjV+CZeVOQEQlcDsNNQlt028=;
 b=3l33tFCLllnU9JCsTSrD8Rz1f5ZGrxCYpYrXf/hp15HGMgmdBhThaAT2l73OzcbzivpCsD0u5
 O+HLo7tpiM1AZzcRo/ny1kWbBUkf7b14q0VWthrh5gqXhUJ6svjT0cr
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

Endpoint decoders used to map Dynamic Capacity must be configured to
point to the correct Dynamic Capacity (DC) Region.  The decoder mode
currently represents the partition the decoder points to such as ram or
pmem.

Expand the mode to include DC Regions.

Co-developed-by: Navneet Singh <navneet.singh@intel.com>
Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v2:
[iweiny: split from region creation patch]
---
 Documentation/ABI/testing/sysfs-bus-cxl | 19 ++++++++++---------
 drivers/cxl/core/hdm.c                  | 24 ++++++++++++++++++++++++
 drivers/cxl/core/port.c                 | 16 ++++++++++++++++
 3 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 6350dd82b9a9..2268ffcdb604 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -257,22 +257,23 @@ Description:
 
 What:		/sys/bus/cxl/devices/decoderX.Y/mode
 Date:		May, 2022
-KernelVersion:	v6.0
+KernelVersion:	v6.0, v6.6 (dcY)
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
 		translates from a host physical address range, to a device local
 		address range. Device-local address ranges are further split
-		into a 'ram' (volatile memory) range and 'pmem' (persistent
-		memory) range. The 'mode' attribute emits one of 'ram', 'pmem',
-		'mixed', or 'none'. The 'mixed' indication is for error cases
-		when a decoder straddles the volatile/persistent partition
-		boundary, and 'none' indicates the decoder is not actively
-		decoding, or no DPA allocation policy has been set.
+		into a 'ram' (volatile memory) range, 'pmem' (persistent
+		memory) range, or Dynamic Capacity (DC) range. The 'mode'
+		attribute emits one of 'ram', 'pmem', 'dcY', 'mixed', or
+		'none'. The 'mixed' indication is for error cases when a
+		decoder straddles the volatile/persistent partition boundary,
+		and 'none' indicates the decoder is not actively decoding, or
+		no DPA allocation policy has been set.
 
 		'mode' can be written, when the decoder is in the 'disabled'
-		state, with either 'ram' or 'pmem' to set the boundaries for the
-		next allocation.
+		state, with 'ram', 'pmem', or 'dcY' to set the boundaries for
+		the next allocation.
 
 
 What:		/sys/bus/cxl/devices/decoderX.Y/dpa_resource
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index a254f79dd4e8..3f4af1f5fac8 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -267,6 +267,19 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 	__cxl_dpa_release(cxled);
 }
 
+static int dc_mode_to_region_index(enum cxl_decoder_mode mode)
+{
+	int index = 0;
+
+	for (int i = CXL_DECODER_DC0; i <= CXL_DECODER_DC7; i++) {
+		if (mode == i)
+			return index;
+		index++;
+	}
+
+	return -EINVAL;
+}
+
 static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			     resource_size_t base, resource_size_t len,
 			     resource_size_t skipped)
@@ -429,6 +442,7 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 	switch (mode) {
 	case CXL_DECODER_RAM:
 	case CXL_DECODER_PMEM:
+	case CXL_DECODER_DC0 ... CXL_DECODER_DC7:
 		break;
 	default:
 		dev_dbg(dev, "unsupported mode: %d\n", mode);
@@ -456,6 +470,16 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 		goto out;
 	}
 
+	for (int i = CXL_DECODER_DC0; i <= CXL_DECODER_DC7; i++) {
+		int index = dc_mode_to_region_index(i);
+
+		if (mode == i && !resource_size(&cxlds->dc_res[index])) {
+			dev_dbg(dev, "no available dynamic capacity\n");
+			rc = -ENXIO;
+			goto out;
+		}
+	}
+
 	cxled->mode = mode;
 	rc = 0;
 out:
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index f58cf01f8d2c..ce4a66865db3 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -197,6 +197,22 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
 		mode = CXL_DECODER_PMEM;
 	else if (sysfs_streq(buf, "ram"))
 		mode = CXL_DECODER_RAM;
+	else if (sysfs_streq(buf, "dc0"))
+		mode = CXL_DECODER_DC0;
+	else if (sysfs_streq(buf, "dc1"))
+		mode = CXL_DECODER_DC1;
+	else if (sysfs_streq(buf, "dc2"))
+		mode = CXL_DECODER_DC2;
+	else if (sysfs_streq(buf, "dc3"))
+		mode = CXL_DECODER_DC3;
+	else if (sysfs_streq(buf, "dc4"))
+		mode = CXL_DECODER_DC4;
+	else if (sysfs_streq(buf, "dc5"))
+		mode = CXL_DECODER_DC5;
+	else if (sysfs_streq(buf, "dc6"))
+		mode = CXL_DECODER_DC6;
+	else if (sysfs_streq(buf, "dc7"))
+		mode = CXL_DECODER_DC7;
 	else
 		return -EINVAL;
 

-- 
2.45.2

