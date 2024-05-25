Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A45A47
	for <linux-cxl@vger.kernel.org>; Sat, 25 May 2024 00:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716598432; cv=none; b=cOMly437FMtHF8fARgzo+DVydSQun7C5/MyQV0jV7A70Ndp7/treNzQLBdL8QNHaokzIaDhm04uOrfTb9ABbL6xr43PFwaQ3Jb2vzAwj4aKgNfK8Bv8KKlYkOb7IndWV+l7gJKAGHNpk18Amf//8YivyzEo8gWJoimNbKOUyWLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716598432; c=relaxed/simple;
	bh=fnqeagiYyz17Fu2OLCiHyQligLLpO5tD3ZKLoGPsRVI=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=Dcs4oxTfpC8xT1hrtpa0AgrPR/JzllaQUb6x1CzaA5p69KfC9rOylu5WAr4WKtswPAJthNkzm6UIKXyTtqXDqzcwTWB5nNnjSeMYPOOCQyK55TJ8VzkIDXCmupp/qFWWiQuZfRqQIyqlalfSuoEpEV2py7qrFlHZquB3mLcgt3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jWv1XF4d; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jWv1XF4d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716598431; x=1748134431;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fnqeagiYyz17Fu2OLCiHyQligLLpO5tD3ZKLoGPsRVI=;
  b=jWv1XF4dB3M3QkVSxuHNNpv5VRDmAupUWffT0HFYvudpwjt/Eg4t5BUN
   UORgQxtSP0qje+f/PMUk6QUQdXFs7osvDONiajQnASFEmaWnNQkMN2dcI
   ABIbY6BNkctKEh93dnPx7DCtURRkug37GA1asZG1h9yCl5Bs7Fbhtrh5r
   GvED4RuBmCdIqk/znFKKPSZG3YsLG4dhJmO4OVA/LlytUtuPIFYUf2XDQ
   iO36PzxBugo2iescVpMdNX6NC6bWg1OwYS83uZHKfq/mPdCkI5jzd+I19
   5dXQuoPLnDOal7giKfFz90H6StgBJULNkHUpBUDkNrOLJh9rsaENaEbXx
   A==;
X-CSE-ConnectionGUID: qDAePAMmRvKt4t4u8mgMZA==
X-CSE-MsgGUID: /wEVRVDZThKn2fLNPygjGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="12928772"
X-IronPort-AV: E=Sophos;i="6.08,187,1712646000"; 
   d="scan'208";a="12928772"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 17:53:50 -0700
X-CSE-ConnectionGUID: JyoDZa9XRsak4eFUFvCgOQ==
X-CSE-MsgGUID: KeksFPpiQNqirENr75YJaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,187,1712646000"; 
   d="scan'208";a="34685060"
Received: from mdhassa1-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.164.6])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 17:53:50 -0700
Subject: [PATCH] Documentation: CXL Maturity Map
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave.jiang@intel.com, Jonathan.Cameron@huawei.com, .manzanares@samsung.com
Date: Fri, 24 May 2024 17:53:49 -0700
Message-ID: <171659842954.843002.8140957498380360424.stgit@dwillia2-xfh.jf.intel.com>
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

Help wanted / welcome to expand on the "Details" section.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/driver-api/cxl/index.rst        |    2 
 Documentation/driver-api/cxl/maturity-map.rst |  173 +++++++++++++++++++++++++
 MAINTAINERS                                   |    1 
 3 files changed, 176 insertions(+)
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
index 000000000000..9c5bff6484dd
--- /dev/null
+++ b/Documentation/driver-api/cxl/maturity-map.rst
@@ -0,0 +1,173 @@
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
+  implement.  If the specification has a feature that does even have a '0'
+  score in this document, there is a good chance that no one in the
+  linux-cxl@vger.kernel.org community has started to look at it.
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
+2 Performance enumeration
+
+  * [3] Endpoint CDAT
+  * [3] Switch CDAT
+  * [1] CDAT to Core-mm integration
+  * [1] Shared link
+
+* [2] Hotplug
+  (see CXL Window Enumeration)
+
+  * [0] Handle Soft Reserved conflicts
+
+* [0] :ref:`RCH link status <rch-link-status>`
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
+
+Mailbox commands
+----------------
+
+* [3] Firmware update
+* [3] Health / Alerts
+* [1] :ref:`Background commands <background-commands>`
+* [3] Santization
+* [3] Security commands
+* [3] RAW Command Debug Passthrough
+* [0] CEL-only-validtion Passthrough
+* [0] Switch CCI
+* [3] Timestamp
+* [1] PMU
+* [1] PMEM labels
+* [0] PMEM GPF / Dirty Shutdown
+
+Security
+--------
+
+* [X] CXL Trusted Execution Environment Security Protocol (TSP)
+* [X] CXL IDE (subsumed by TSP)
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
index e533476081ba..d092b2ae5f25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5331,6 +5331,7 @@ M:	Ira Weiny <ira.weiny@intel.com>
 M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-cxl@vger.kernel.org
 S:	Maintained
+F:	Documentation/driver-api/cxl
 F:	drivers/cxl/
 F:	include/linux/einj-cxl.h
 F:	include/linux/cxl-event.h

