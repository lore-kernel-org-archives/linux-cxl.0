Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521C8225A7
	for <linux-cxl@vger.kernel.org>; Tue, 31 Oct 2023 20:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="heh5B4iZ"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D0EF3
	for <linux-cxl@vger.kernel.org>; Tue, 31 Oct 2023 13:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698784397; x=1730320397;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iGOD233LiLWii4Y6lQtbupupqS+vQ66obIL5vP9bmTE=;
  b=heh5B4iZSxiuoAR5U8WvfpTTuJIJBesiRKLtedV4Z9Q5xGkNocZ7amLV
   UvLdh9mI2vWEzSxau0CI/HEHQX0mMT4Wqw8l+zv7wglPNBk0T/jpPiGMH
   gcB4Mjtqy1FxmKbnH68fLbnLQq0Ce+CVQdruQx3Ei1x9xGsAD0zxOVgvg
   dHAotEYudXjoBRJkx9cycvfRZvdzU+o95zlGxAh1wRF8bKcjFA2wm4mU0
   ObA+3V5ydX05BR/a25//+m0rh1twTibWinKnZALP02IQiibEvAbFJoUcz
   BUtgSJNYrqkzsSp2alTzmti75XeW9ZgSOuN71jkIfdQ9GybaG0vZMIMHo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="373420062"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="373420062"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 13:33:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="754242919"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="754242919"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.179.50])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 13:33:16 -0700
Subject: [NDCTL PATCH] cxl: Augment documentation on cxl operational behavior
From: Dave Jiang <dave.jiang@intel.com>
To: vishal.l.verma@intel.com
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Date: Tue, 31 Oct 2023 13:33:15 -0700
Message-ID: <169878439580.80025.16527732447076656149.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

If a cxl operation is executed resulting in no-op, the tool will still
emit the number of targets the operation has succeeded on. For example, if
disable-region is issued and the region is already disabled, the tool will
still report 1 region disabled. Add verbiage to man pages to document the
behavior.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/cxl/cxl-disable-bus.txt    |    2 ++
 Documentation/cxl/cxl-disable-memdev.txt |    1 +
 Documentation/cxl/cxl-disable-port.txt   |    2 ++
 Documentation/cxl/cxl-disable-region.txt |    2 ++
 Documentation/cxl/cxl-enable-memdev.txt  |    2 ++
 Documentation/cxl/cxl-enable-port.txt    |    2 ++
 Documentation/cxl/cxl-enable-region.txt  |    2 ++
 Documentation/cxl/meson.build            |    1 +
 Documentation/cxl/operations.txt         |   17 +++++++++++++++++
 9 files changed, 31 insertions(+)
 create mode 100644 Documentation/cxl/operations.txt

diff --git a/Documentation/cxl/cxl-disable-bus.txt b/Documentation/cxl/cxl-disable-bus.txt
index 65f695cd06c8..992a25ec8506 100644
--- a/Documentation/cxl/cxl-disable-bus.txt
+++ b/Documentation/cxl/cxl-disable-bus.txt
@@ -15,6 +15,8 @@ SYNOPSIS
 For test and debug scenarios, disable a CXL bus and any associated
 memory devices from CXL.mem operations.
 
+include::operations.txt[]
+
 OPTIONS
 -------
 -f::
diff --git a/Documentation/cxl/cxl-disable-memdev.txt b/Documentation/cxl/cxl-disable-memdev.txt
index d39780250939..fc7eeee61c3e 100644
--- a/Documentation/cxl/cxl-disable-memdev.txt
+++ b/Documentation/cxl/cxl-disable-memdev.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 [verse]
 'cxl disable-memdev' <mem0> [<mem1>..<memN>] [<options>]
 
+include::operations.txt[]
 
 OPTIONS
 -------
diff --git a/Documentation/cxl/cxl-disable-port.txt b/Documentation/cxl/cxl-disable-port.txt
index 7a22efc3b821..451aa01fefdd 100644
--- a/Documentation/cxl/cxl-disable-port.txt
+++ b/Documentation/cxl/cxl-disable-port.txt
@@ -15,6 +15,8 @@ SYNOPSIS
 For test and debug scenarios, disable a CXL port and any memory devices
 dependent on this port being active for CXL.mem operation.
 
+include::operations.txt[]
+
 OPTIONS
 -------
 -e::
diff --git a/Documentation/cxl/cxl-disable-region.txt b/Documentation/cxl/cxl-disable-region.txt
index 6a39aee6ea69..4b0625e40bf6 100644
--- a/Documentation/cxl/cxl-disable-region.txt
+++ b/Documentation/cxl/cxl-disable-region.txt
@@ -21,6 +21,8 @@ EXAMPLE
 disabled 2 regions
 ----
 
+include::operations.txt[]
+
 OPTIONS
 -------
 include::bus-option.txt[]
diff --git a/Documentation/cxl/cxl-enable-memdev.txt b/Documentation/cxl/cxl-enable-memdev.txt
index 5b5ed66eadc5..436f063e5517 100644
--- a/Documentation/cxl/cxl-enable-memdev.txt
+++ b/Documentation/cxl/cxl-enable-memdev.txt
@@ -18,6 +18,8 @@ it again. This involves detecting the state of the HDM (Host Managed
 Device Memory) Decoders and validating that CXL.mem is enabled for each
 port in the device's hierarchy.
 
+include::operations.txt[]
+
 OPTIONS
 -------
 <memory device(s)>::
diff --git a/Documentation/cxl/cxl-enable-port.txt b/Documentation/cxl/cxl-enable-port.txt
index 50b53d1f48d1..8b51023d2e16 100644
--- a/Documentation/cxl/cxl-enable-port.txt
+++ b/Documentation/cxl/cxl-enable-port.txt
@@ -18,6 +18,8 @@ again. This involves detecting the state of the HDM (Host Managed Device
 Memory) Decoders and validating that CXL.mem is enabled for each port in
 the device's hierarchy.
 
+include::operations.txt[]
+
 OPTIONS
 -------
 -e::
diff --git a/Documentation/cxl/cxl-enable-region.txt b/Documentation/cxl/cxl-enable-region.txt
index f6ef00fb945d..f3d3d9db1674 100644
--- a/Documentation/cxl/cxl-enable-region.txt
+++ b/Documentation/cxl/cxl-enable-region.txt
@@ -21,6 +21,8 @@ EXAMPLE
 enabled 2 regions
 ----
 
+include::operations.txt[]
+
 OPTIONS
 -------
 include::bus-option.txt[]
diff --git a/Documentation/cxl/meson.build b/Documentation/cxl/meson.build
index c5533572ef75..7c70956c3b53 100644
--- a/Documentation/cxl/meson.build
+++ b/Documentation/cxl/meson.build
@@ -25,6 +25,7 @@ filedeps = [
   'debug-option.txt',
   'region-description.txt',
   'decoder-option.txt',
+  'operations.txt',
 ]
 
 cxl_manpages = [
diff --git a/Documentation/cxl/operations.txt b/Documentation/cxl/operations.txt
new file mode 100644
index 000000000000..046e2bc19532
--- /dev/null
+++ b/Documentation/cxl/operations.txt
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: gpl-2.0
+
+Given any en/disabling operation, if the operation is a no-op due to the
+current state of a target, it is still considered successful when executed
+even if no actual operation is performed. The target applies to a bus,
+decoder, memdev, or region.
+
+For example:
+If a CXL region is already disabled and the cxl disable-region is called:
+
+----
+# cxl disable-region region0
+disabled 1 regions
+----
+
+The operation will still succeed with the number of regions operated on
+reported, even if the operation is a non-action.


