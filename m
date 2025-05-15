Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3688281E
	for <linux-cxl@vger.kernel.org>; Thu, 15 May 2025 00:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747267789; cv=none; b=FjM5ut9gEKslNrvo4HY9Uz/Q72quozYo7wuQUGG6YcqbW3OYJnXj4bkLlf+aOFdDNmY0O/pQzNodfsvIjVN1UOioKeLqc0/EmsJpAJ3nlxt2ehyu3LisSIgczlOwTCL7stoA1AEdfsi7NS8Hii7AdvcvjX/W7g43lJEbhLQTNVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747267789; c=relaxed/simple;
	bh=vNI9k3dzSOO420rVabuYKR1HI4r3B6h9qiGulloMJ+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3dxXzdnWikMFzU3qTOsQwjNcnDVIkQKF6rCn2Zs3jEbkiIRgC1ddpFWq+TyFE1t8q9IWK8WN52YHcDPzIPqgTRF8zsOCjEn3njVBPD3rUv71D+ru0l8DmExhXGXNhP4A2DCB1smvH71j/2ks4PITa4fL3qqXzByTI6wAsECdgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F952C4CEE3;
	Thu, 15 May 2025 00:09:48 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	gourry@gourry.net
Subject: [PATCH v2 3/3] cxl: doc/linux/access-coordinates Update access coordinates calculation methods
Date: Wed, 14 May 2025 17:09:23 -0700
Message-ID: <20250515000923.2590820-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515000923.2590820-1-dave.jiang@intel.com>
References: <20250515000923.2590820-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation on how to calculate the access coordinates for a given
CXL region in detail.

Reviewed-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Clarification of language. (Gregory)
---
 .../cxl/linux/access-coordinates.rst          | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/Documentation/driver-api/cxl/linux/access-coordinates.rst b/Documentation/driver-api/cxl/linux/access-coordinates.rst
index 71024fa0f561..341a7c682043 100644
--- a/Documentation/driver-api/cxl/linux/access-coordinates.rst
+++ b/Documentation/driver-api/cxl/linux/access-coordinates.rst
@@ -5,6 +5,83 @@
 CXL Access Coordinates Computation
 ==================================
 
+Latency and Bandwidth Calculation
+=================================
+A memory region performance coordinates (latency and bandwidth) are typically
+provided via ACPI tables :doc:`SRAT <../platform/acpi/srat>` and
+:doc:`HMAT <../platform/acpi/hmat>`. However, the platform firmware (BIOS) is
+not able to annotate those for CXL devices that are hot-plugged since they do
+not exist during platform firmware initialization. The CXL driver can compute
+the performance coordinates by retrieving data from several components.
+
+The :doc:`SRAT <../platform/acpi/srat>` provides a Generic Port Affinity
+subtable that ties a proximity domain to a device handle, which in this case
+would be the CXL hostbridge. Using this association, the performance
+coordinates for the Generic Port can be retrieved from the
+:doc:`HMAT <../platform/acpi/hmat>` subtable. This piece represents the
+performance coordinates between a CPU and a Generic Port (CXL hostbridge).
+
+The :doc:`CDAT <../platform/cdat>` provides the performance coordinates for
+the CXL device itself. That is the bandwidth and latency to access that device's
+memory region. The DSMAS subtable provides a DSMADHandle that is tied to a
+Device Physical Address (DPA) range. The DSLBIS subtable provides the
+performance coordinates that's tied to a DSMADhandle and this ties the two
+table entries together to provide the performance coordinates for each DPA
+region. For example, if a device exports a DRAM region and a PMEM region,
+then there would be different performance characteristsics for each of those
+regions.
+
+If there's a CXL switch in the topology, then the performance coordinates for the
+switch is provided by SSLBIS subtable. This provides the bandwidth and latency
+for traversing the switch between the switch upstream port and the switch
+downstream port that points to the endpoint device.
+
+Simple topology example::
+
+ GP0/HB0/ACPI0016-0
+        RP0
+         |
+         | L0
+         |
+     SW 0 / USP0
+     SW 0 / DSP0
+         |
+         | L1
+         |
+        EP0
+
+In this example, there is a CXL switch between an endpoint and a root port.
+Latency in this example is calculated as such:
+L(EP0) - Latency from EP0 CDAT DSMAS+DSLBIS
+L(L1) - Link latency between EP0 and SW0DSP0
+L(SW0) - Latency for the switch from SW0 CDAT SSLBIS.
+L(L0) - Link latency between SW0 and RP0
+L(RP0) - Latency from root port to CPU via SRAT and HMAT (Generic Port).
+Total read and write latencies are the sum of all these parts.
+
+Bandwidth in this example is calculated as such:
+B(EP0) - Bandwidth from EP0 CDAT DSMAS+DSLBIS
+B(L1) - Link bandwidth between EP0 and SW0DSP0
+B(SW0) - Bandwidth for the switch from SW0 CDAT SSLBIS.
+B(L0) - Link bandwidth between SW0 and RP0
+B(RP0) - Bandwidth from root port to CPU via SRAT and HMAT (Generic Port).
+The total read and write bandwidth is the min() of all these parts.
+
+To calculate the link bandwidth:
+LinkOperatingFrequency (GT/s) is the current negotiated link speed.
+DataRatePerLink (MB/s) = LinkOperatingFrequency / 8
+Bandwidth (MB/s) = PCIeCurrentLinkWidth * DataRatePerLink
+Where PCIeCurrentLinkWidth is the number of lanes in the link.
+
+To calculate the link latency:
+LinkLatency (picoseconds) = FlitSize / LinkBandwidth (MB/s)
+
+See `CXL Memory Device SW Guide r1.0 <https://www.intel.com/content/www/us/en/content-details/643805/cxl-memory-device-software-guide.html>`_,
+section 2.11.3 and 2.11.4 for details.
+
+In the end, the access coordinates for a constructed memory region is calculated from one
+or more memory partitions from each of the CXL device(s).
+
 Shared Upstream Link Calculation
 ================================
 For certain CXL region construction with endpoints behind CXL switches (SW) or
@@ -90,3 +167,12 @@ under the same ACPI0017 device to form a new xarray.
 Finally, the cxl_region_update_bandwidth() is called and the aggregated
 bandwidth from all the members of the last xarray is updated for the
 access coordinates residing in the cxl region (cxlr) context.
+
+QTG ID
+======
+Each :doc:`CEDT <../platform/acpi/cedt>` has a QTG ID field. This field provides
+the ID that associates with a QoS Throttling Group (QTG) for the CFMWS window.
+Once the access coordinates are calculated, an ACPI Device Specific Method can
+be issued to the ACPI0016 device to retrieve the QTG ID depends on the access
+coordinates provided. The QTG ID for the device can be used as guidance to match
+to the CFMWS to setup the best Linux root decoder for the device performance.
-- 
2.49.0

