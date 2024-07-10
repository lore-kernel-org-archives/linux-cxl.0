Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F133A14A0AD
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jul 2024 22:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720650445; cv=none; b=QzJ+nTsYegzR2IBG/fWjhRDffMeoOZvhS2J8GFlJ6vK6iniNCegMobau1ku7cmnWUjtQy9GWmSUZXMOGwPos85zO8YNBbqd+suXIqrL+AhOzYz3LU8QCCrxWKOFAgbSoqQP5feI5r7XBveJA0H/yFYCxaehG02GClEPwM0Ai5og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720650445; c=relaxed/simple;
	bh=B8yVMsgJ4rq5Ul9Q+POUhiZQ7k8ygqb4d0dKQgElu/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxmiKobMfVC5t/Oxy4WjMm+GA7qLXC+83Kep0iNWLRB9jKY+C3tVDjIzi720HMlbr3UAWFu9V+FelRyMAYuAUTKwB22AfxGHcUi8uTDV4COIkj9lanIS1r9yIOS5Pa0nakloANKurFhmi1ZWjr8iqf131GwbTpJuR5pZij/tTgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60421C4AF09;
	Wed, 10 Jul 2024 22:27:24 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v7 3/3] cxl: Add documentation to explain the shared link bandwidth calculation
Date: Wed, 10 Jul 2024 15:24:02 -0700
Message-ID: <20240710222716.797267-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710222716.797267-1-dave.jiang@intel.com>
References: <20240710222716.797267-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a kernel documentation to describe how the CXL shared upstream
link bandwidth is calculated.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 .../driver-api/cxl/access-coordinates.rst     | 90 +++++++++++++++++++
 Documentation/driver-api/cxl/index.rst        |  1 +
 MAINTAINERS                                   |  1 +
 3 files changed, 92 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/access-coordinates.rst

diff --git a/Documentation/driver-api/cxl/access-coordinates.rst b/Documentation/driver-api/cxl/access-coordinates.rst
new file mode 100644
index 000000000000..973e63872f06
--- /dev/null
+++ b/Documentation/driver-api/cxl/access-coordinates.rst
@@ -0,0 +1,90 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+==================================
+CXL Access Coordinates Computation
+==================================
+
+Shared Upstream Link Calculation
+================================
+For certain CXL region construction with endpoints behind CXL switches (SW) or
+Root Ports (RP), there is the possibility of the total bandwdith for all
+the endpoints behind a switch being more than the switch upstream link.
+The CXL driver performs an additional pass after all the targets have
+arrived for a region in order to recalculate the bandwidths with possible
+upstream link being a limiting factor in mind.
+
+The algorithm assumes the configuration is a symmetric topology as that
+maximizes performance. When asymmetric topology is detected, the calculation
+is aborted when such topology is detected. An asymmetric topology is detected
+during topology walk where the number of RPs detected as a grandparent is not
+equal to the number of devices iterated in the same iteration loop.
+
+There can be multiple switches under a RP. There can be multiple RPs under
+a CXL Host Bridge (HB). There can be multiple HBs under a CXL Fixed Memory
+Window Structure (CFMWS).
+
+An example hierarchy:
+
+                CFMWS 0
+                  |
+         _________|_________
+        |                   |
+    ACPI0017-0          ACPI0017-1
+ GP0/HB0/ACPI0016-0   GP1/HB1/ACPI0016-1
+    |          |        |           |
+   RP0        RP1      RP2         RP3
+    |          |        |           |
+  SW 0       SW 1     SW 2        SW 3
+  |   |      |   |    |   |       |   |
+ EP0 EP1    EP2 EP3  EP4  EP5    EP6 EP7
+
+Computation for the example hierarchy:
+
+Min (GP0 to CPU BW,
+     Min(SW 0 Upstream Link to RP0 BW,
+         Min(SW0SSLBIS for SW0DSP0 (EP0), EP0 DSLBIS, EP0 Upstream Link) +
+         Min(SW0SSLBIS for SW0DSP1 (EP1), EP1 DSLBIS, EP1 Upstream link)) +
+     Min(SW 1 Upstream Link to RP1 BW,
+         Min(SW1SSLBIS for SW1DSP0 (EP2), EP2 DSLBIS, EP2 Upstream Link) +
+         Min(SW1SSLBIS for SW1DSP1 (EP3), EP3 DSLBIS, EP3 Upstream link))) +
+Min (GP1 to CPU BW,
+     Min(SW 2 Upstream Link to RP2 BW,
+         Min(SW2SSLBIS for SW2DSP0 (EP4), EP4 DSLBIS, EP4 Upstream Link) +
+         Min(SW2SSLBIS for SW2DSP1 (EP5), EP5 DSLBIS, EP5 Upstream link)) +
+     Min(SW 3 Upstream Link to RP3 BW,
+         Min(SW3SSLBIS for SW3DSP0 (EP6), EP6 DSLBIS, EP6 Upstream Link) +
+         Min(SW3SSLBIS for SW3DSP1 (EP7), EP7 DSLBIS, EP7 Upstream link))))
+
+
+The calculation starts at cxl_region_shared_upstream_perf_update(). A xarray
+is created to collect all the endpoint bandwidths via the
+cxl_endpoint_gather_bandwidth() function. The min() of bandwidth from the
+endpoint CDAT and the upstream link bandwidth is calculated. If the endpoint
+has a CXL switch as a parent, then min() of calculated bandwidth and the
+bandwidth from the SSLBIS for the switch downstream port that is associated
+with the endpoint is calculated. The final bandwidth is stored in a
+'struct cxl_perf_ctx' in the xarray indexed by a device pointer. If the
+endpoint is direct attached to a root port (RP), the device pointer would be a
+RP device. If the endpoint is behind a switch, the device pointer would be the
+upstream device of the parent switch.
+
+At the next stage, the code attempts to walk through one or more switches if
+they exist in the topology. For endpoints directly attached to RPs, this
+step is skipped. If there is another switch upstream, the code takes the min()
+of the current gathered bandwidth and the upstream link bandwidth. If there's
+a switch upstream, then the SSLBIS of the upstream switch.
+
+Once the topology walk reaches the RP, whether it's direct attached endpoints
+or walking through the switch(es), cxl_rp_gather_bandwidth() is called. At
+this point all the bandwidths are aggregated per each host bridge, which is
+also the index for the resulting xarray.
+
+The next step is to take the min() of the per host bridge bandwidth and the
+bandwidth from the Generic Port (GP). The bandwidths for the GP is retrieved
+via ACPI tables SRAT/HMAT. The min bandwidth are aggregated under the same
+ACPI0017 device to form a new xarray.
+
+Finally, the cxl_region_update_bandwidth() is called and the aggregated
+bandwidth from all the members of the last xarray is updated for the
+access coordinates residing in the cxl region (cxlr) context.
diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index 036e49553542..9b0e82a31d89 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -8,5 +8,6 @@ Compute Express Link
    :maxdepth: 1
 
    memory-devices
+   access-coordinates
 
 .. only::  subproject and html
diff --git a/MAINTAINERS b/MAINTAINERS
index 2ca8f35dfe03..2b3bfc114140 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5484,6 +5484,7 @@ M:	Ira Weiny <ira.weiny@intel.com>
 M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-cxl@vger.kernel.org
 S:	Maintained
+F:	Documentation/driver-api/cxl/
 F:	drivers/cxl/
 F:	include/linux/einj-cxl.h
 F:	include/linux/cxl-event.h
-- 
2.45.2

