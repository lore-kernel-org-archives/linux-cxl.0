Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA682F32
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jul 2024 01:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720054983; cv=none; b=OZwIEBijaguJBW6XMhxiFeIK973CEqqPJvz3QKUOtm8fEFlkSqP/KgG5wyqJmXiT7CA3TgmkYv0coz9LH0ihraRlHnT+GUtkR2vzSNdZSlRkiyXPkFAZD+8CJPTap0tVWNNVn6GuUmPmYnoMQT2sWpdBO09t3E9E4vHWDn61C3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720054983; c=relaxed/simple;
	bh=2ggi9rU13mE+4ncBcAw6CnTjbXBlGVnylHl9JXkzMaY=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=eiOWP0e1GDirhkWXjI7ehhWMyFmGZ/Yb/15y9992oPVl6WokzRs5pls5oIxiIsj/s2GDXwuzJyOdppzLgYFlenJQNEiuaoJqsZHTRF4kMCX1WP6blbdQXvm6fEAq00ASLMj7oYzxiGKUA8x2sfbRT655F9qRMUPI6rucPi589os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZ0KEfqP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZ0KEfqP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720054981; x=1751590981;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2ggi9rU13mE+4ncBcAw6CnTjbXBlGVnylHl9JXkzMaY=;
  b=WZ0KEfqPhs1V8ikzNBt9+a2EgxdbSLbTaEi+fUNjaiONETZ/25v19i2w
   2nsfiqzfrJIveX0AFdqzc3bB3fH/jD56pxNnRjP6lIDiAfI/wz6BN+EwH
   1drCjRYu/09CDqO8kcJLm18kN5Q30kG6nNdxYUwtQeC9tJ+sxdPmt/wwZ
   ZOVBwkpv5A5itFfvxz4AqZ0Pc5oE1Ux+va4fjLRROlKY1aYxy8ry25wAU
   4HFmsKnZlNd/HvXq3RageguVp/yFFP8Zzeugm3qeHrzxLAu4hrjBZ6LIE
   jW61jBh7EX04pfJRupZKkLdZFMsjGrbSH/pyeNiCZKeYRKt+dqx+u7DVu
   w==;
X-CSE-ConnectionGUID: o+g8TO0CTQKQNa4Vb3uF4g==
X-CSE-MsgGUID: duiqplqrT2+l7lbI9HTqSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17449031"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17449031"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 18:03:00 -0700
X-CSE-ConnectionGUID: 5Jd8X60AR0SbKfuKhfA3KQ==
X-CSE-MsgGUID: dRYl8QjjRwOkm/Sg00gFOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="50751742"
Received: from cdpresto-mobl2.amr.corp.intel.com.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.111.244])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 18:03:00 -0700
Subject: [PATCH v2] Documentation: CXL Maturity Map
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Adam Manzanares <a.manzanares@samsung.com>, dave.jiang@intel.com,
 Jonathan.Cameron@huawei.com, alison.schofield@intel.com, ira.weiny@intel.com
Date: Wed, 03 Jul 2024 18:01:35 -0700
Message-ID: <172005486862.2048248.6668794717827294862.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Provide a survey of the work-in-progress maturity (implementation
status) of various aspects of the CXL subsystem.

Clarify that in addition to ongoing upkeep relative to specification
updates, there are some long running themes in the driver that respond
to the discovery of new corner cases (bugs) and new use cases (feature
extensions).

The primary audience is distribution maintainers, but it also serves as
a guide for kernel developers to understand what aspects of the CXL
subsystem need more help. It is a landing page to document ongoing
progress, and a guide to discern exposure to work-in-progress features.

Reviewed-by: Adam Manzanares <a.manzanares@samsung.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v1 [1]:
* Add Scan Media (Alison)
* Add Fabrics (Jonathan)
* Add CPU arch dependencies for performance enumeration (Jonathan)
* Update status of "Shared Link" performance enumeration (Jonathan)
* Add PPR. Sparing, BiST (Jonathan)
* Add PMU (Jonathan)
* Clarify pooling vs sharing (Jonathan)
* Grammar fixups (Adam)

[1]: http://lore.kernel.org/171659842954.843002.8140957498380360424.stgit@dwillia2-xfh.jf.intel.com

 Documentation/driver-api/cxl/index.rst        |    2 
 Documentation/driver-api/cxl/maturity-map.rst |  202 +++++++++++++++++++++++++
 MAINTAINERS                                   |    1 
 3 files changed, 205 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/maturity-map.rst

diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index 036e49553542..12b82725d322 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -9,4 +9,6 @@ Compute Express Link
 
    memory-devices
 
+   maturity-map
+
 .. only::  subproject and html
diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
new file mode 100644
index 000000000000..df8e2ac2a320
--- /dev/null
+++ b/Documentation/driver-api/cxl/maturity-map.rst
@@ -0,0 +1,202 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+===========================================
+Compute Express Link Subsystem Maturity Map
+===========================================
+
+The Linux CXL subsystem tracks the dynamic `CXL specification
+<https://computeexpresslink.org/cxl-specification-landing-page>`_ that
+continues to respond to new use cases with new features, capability
+updates and fixes. At any given point some aspects of the subsystem are
+more mature than others. While the periodic pull requests summarize the
+`work being incorporated each merge window
+<https://lore.kernel.org/linux-cxl/?q=s%3APULL+s%3ACXL+tc%3Atorvalds+NOT+s%3ARe>`_,
+those do not always convey progress relative to a starting point and a
+future end goal.
+
+What follows is a coarse breakdown of the subsystem's major
+responsibilities along with a maturity score. The expectation is that
+the change-history of this document provides an overview summary of the
+subsystem maturation over time.
+
+The maturity scores are:
+
+- [3] Mature: Work in this area is complete and no changes on the horizon.
+  Note that this score can regress from one kernel release to the next
+  based on new test results or end user reports.
+
+- [2] Stabilizing: Major functionality operational, common cases are
+  mature, but known corner cases are still a work in progress.
+
+- [1] Initial: Capability that has exited the Proof of Concept phase, but
+  may still have significant gaps to close and fixes to apply as real
+  world testing occurs.
+
+- [0] Known gap: Feature is on a medium to long term horizon to
+  implement.  If the specification has a feature that does not even have
+  a '0' score in this document, there is a good chance that no one in
+  the linux-cxl@vger.kernel.org community has started to look at it.
+
+- X: Out of scope for kernel enabling, or kernel enabling not required
+
+Feature and Capabilities
+========================
+
+Enumeration / Provisioning
+--------------------------
+All of the fundamental enumeration an object model of the subsystem is
+in place, but there are several corner cases that are pending closure.
+
+
+* [2] CXL Window Enumeration
+
+  * [0] :ref:`Extended-linear memory-side cache <extended-linear>`
+  * [0] Low Memory-hole
+  * [0] Hetero-interleave
+
+* [2] Switch Enumeration
+
+  * [0] CXL register enumeration link-up dependency
+
+* [2] HDM Decoder Configuration
+
+  * [0] Decoder target and granularity constraints
+
+* [2] Performance enumeration
+
+  * [3] Endpoint CDAT
+  * [3] Switch CDAT
+  * [1] CDAT to Core-mm integration
+
+    * [1] x86
+    * [0] Arm64
+    * [0] All other arch.
+
+  * [0] Shared link
+
+* [2] Hotplug
+  (see CXL Window Enumeration)
+
+  * [0] Handle Soft Reserved conflicts
+
+* [0] :ref:`RCH link status <rch-link-status>`
+* [0] Fabrics / G-FAM (chapter 7)
+* [0] Global Access Endpoint
+
+
+RAS
+---
+In many ways CXL can be seen as a standardization of what would normally
+be handled by custom EDAC drivers. The open development here is
+mainly caused by the enumeration corner cases above.
+
+* [3] Component events (OS)
+* [2] Component events (FFM)
+* [1] Endpoint protocol errors (OS)
+* [1] Endpoint protocol errors (FFM)
+* [0] Switch protocol errors (OS)
+* [1] Switch protocol errors (FFM)
+* [2] DPA->HPA Address translation
+
+    * [1] XOR Interleave translation
+      (see CXL Window Enumeration)
+
+* [1] Memory Failure coordination
+* [0] Scrub control
+* [2] ACPI error injection EINJ
+
+  * [0] EINJ v2
+  * [X] Compliance DOE
+
+* [2] Native error injection
+* [3] RCH error handling
+* [1] VH error handling
+* [0] PPR
+* [0] Sparing
+* [0] Device built in test
+
+
+Mailbox commands
+----------------
+
+* [3] Firmware update
+* [3] Health / Alerts
+* [1] :ref:`Background commands <background-commands>`
+* [3] Sanitization
+* [3] Security commands
+* [3] RAW Command Debug Passthrough
+* [0] CEL-only-validation Passthrough
+* [0] Switch CCI
+* [3] Timestamp
+* [1] PMEM labels
+* [0] PMEM GPF / Dirty Shutdown
+* [0] Scan Media
+
+PMU
+---
+* [1] Type 3 PMU
+* [0] Switch USP/ DSP, Root Port
+
+Security
+--------
+
+* [X] CXL Trusted Execution Environment Security Protocol (TSP)
+* [X] CXL IDE (subsumed by TSP)
+
+Memory-pooling
+--------------
+
+* [1] Hotplug of LDs (via PCI hotplug)
+* [0] Dynamic Capacity Device (DCD) Support
+
+Multi-host sharing
+------------------
+
+* [0] Hardware coherent shared memory
+* [0] Software managed coherency shared memory
+
+Multi-host memory
+-----------------
+
+* [0] Dynamic Capacity Device Support
+* [0] Sharing
+
+Accelerator
+-----------
+
+* [0] Accelerator memory enumeration HDM-D (CXL 1.1/2.0 Type-2)
+* [0] Accelerator memory enumeration HDM-DB (CXL 3.0 Type-2)
+* [0] CXL.cache 68b (CXL 2.0)
+* [0] CXL.cache 256b Cache IDs (CXL 3.0)
+
+User Flow Support
+-----------------
+
+* [0] HPA->DPA Address translation (need xormaps export solution)
+
+Details
+=======
+
+.. _extended-linear:
+
+* **Extended-linear memory-side cache**: An HMAT proposal to enumerate the presence of a
+  memory-side cache where the cache capacity extends the SRAT address
+  range capacity. `See the ECN
+  <https://lore.kernel.org/linux-cxl/6650e4f835a0e_195e294a8@dwillia2-mobl3.amr.corp.intel.com.notmuch/>`_
+  for more details:
+
+.. _rch-link-status:
+
+* **RCH Link Status**: RCH (Restricted CXL Host) topologies, end up
+  hiding some standard registers like PCIe Link Status / Capabilities in
+  the CXL RCRB (Root Complex Register Block).
+
+.. _background-commands:
+
+* **Background commands**: The CXL background command mechanism is
+  awkward as the single slot is monopolized potentially indefinitely by
+  various commands. A `cancel on conflict
+  <http://lore.kernel.org/r/66035c2e8ba17_770232948b@dwillia2-xfh.jf.intel.com.notmuch>`_
+  facility is needed to make sure the kernel can ensure forward progress
+  of priority commands.
diff --git a/MAINTAINERS b/MAINTAINERS
index 2ca8f35dfe03..cebb492a4b85 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5484,6 +5484,7 @@ M:	Ira Weiny <ira.weiny@intel.com>
 M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-cxl@vger.kernel.org
 S:	Maintained
+F:	Documentation/driver-api/cxl
 F:	drivers/cxl/
 F:	include/linux/einj-cxl.h
 F:	include/linux/cxl-event.h

