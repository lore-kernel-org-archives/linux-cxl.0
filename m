Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24C12F56
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jul 2024 00:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720053504; cv=none; b=pFlhyYZeneqG21W4a8tleOH7fszATCLG6f3guxrRy5e1GBnPHzAICk6yyGh1P7nvXaY0CCufviR/JOLUDTMWpxh1rDgXs4bNKrpaaiDyD8KA4phZwHpRTsYEGkrpFRxT+jh8AH3bRU1Gc3ZMt6h54jVNYKAtQ7hbAqZKEVJwWQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720053504; c=relaxed/simple;
	bh=e64QBq5OzoHHp+LN3bWU9sbsBhCOr02TG4abOUaGwXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZCmOCmVu5YinzlixgYQYOBQ9P7SABFjFtCQ/AgCu2JkFvmMCsg8baRgvh5ynsZbdvTkyMO/AL6hUOaeT7EJ/GqqMdgtzdAIxhpKb6TSIvd/CVKu8t1x3oCmgzDS2/q9kcv+erk4CXw+Z8BzBPST8kC8W1blyphUZJ3UU0GhtFkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OPVwifIa; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPVwifIa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720053503; x=1751589503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e64QBq5OzoHHp+LN3bWU9sbsBhCOr02TG4abOUaGwXA=;
  b=OPVwifIaT8WU+QRpeQZ82Qbm+RRTR3HHRfJaTvUUHLMAMkF2LT0e/CN6
   iQ1dWyMtBDAdho1rEVtOm6SIhA4fywXas7y5LbpldHEcKrafPwR5OEQgw
   OzwwYdjj5Z3qMS/RylP/qBf5n/Tttx5sRq6V4g3Byu0J0Virw51tzhsYM
   3r6JVi1SIp7mftr8EuRLybVzh+Je9olOCanzvgsNUy+8ugik/7SzPvHjT
   VXVszm+nW8UwlKXPAOIZSHnueMT8nrp8zwWDjJtu0HOWHWhu0/tBV04EC
   cdOtZiMxV7TucO7fdqkq3vouMcuyYq6FRvOsL7L3yTc1txlgLDN1AvHKq
   A==;
X-CSE-ConnectionGUID: K0lDAtSVRDe3+yB5AcOcjw==
X-CSE-MsgGUID: e0Or8Qm/S6q5u2IWFIU0gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17178756"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17178756"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 17:38:22 -0700
X-CSE-ConnectionGUID: VrOB0JJuTiKdpVpnY78hYg==
X-CSE-MsgGUID: UGt/h9aZThqmG2Xi8lxE6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="77579919"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.55.113])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 17:38:21 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 1/2] cxl/memdev: Replace ENXIO with EBUSY for inject poison limit reached
Date: Wed,  3 Jul 2024 17:38:16 -0700
Message-Id: <3d37cb23115a99dbf38913360c65e360038ad6a1.1720052137.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1720052137.git.alison.schofield@intel.com>
References: <cover.1720052137.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

The CXL driver provides a debugfs interface offering users the
ability to inject and clear poison to a memdev. Once a user has
injected up to the devices limit further injection requests fail
with ENXIO until a clear poison is issued.

Users may not have device specs in hand or may want to intentionally
hit the limit and then clear. Replace the usual ENXIO return status
with EBUSY so users can recognize this failure.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 Documentation/ABI/testing/debugfs-cxl | 7 ++++---
 drivers/cxl/cxlmem.h                  | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
index c61f9b813973..12488c14be64 100644
--- a/Documentation/ABI/testing/debugfs-cxl
+++ b/Documentation/ABI/testing/debugfs-cxl
@@ -14,9 +14,10 @@ Description:
 		event to its internal Informational Event log, updates the
 		Event Status register, and if configured, interrupts the host.
 		It is not an error to inject poison into an address that
-		already has poison present and no error is returned. The
-		inject_poison attribute is only visible for devices supporting
-		the capability.
+		already has poison present and no error is returned. If the
+		device returns 'Inject Poison Limit Reached' an -EBUSY error
+		is returned to the user. The inject_poison attribute is only
+		visible for devices supporting the capability.
 
 
 What:		/sys/kernel/debug/memX/clear_poison
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 19aba81cdf13..942063c09459 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -161,7 +161,7 @@ struct cxl_mbox_cmd {
 	C(FWRESET, -ENXIO, "FW failed to activate, needs cold reset"),		\
 	C(HANDLE, -ENXIO, "one or more Event Record Handles were invalid"),     \
 	C(PADDR, -EFAULT, "physical address specified is invalid"),		\
-	C(POISONLMT, -ENXIO, "poison injection limit has been reached"),        \
+	C(POISONLMT, -EBUSY, "poison injection limit has been reached"),        \
 	C(MEDIAFAILURE, -ENXIO, "permanent issue with the media"),		\
 	C(ABORT, -ENXIO, "background cmd was aborted by device"),               \
 	C(SECURITY, -ENXIO, "not valid in the current security state"),         \
-- 
2.37.3

