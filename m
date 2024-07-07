Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF8CEDC
	for <linux-cxl@vger.kernel.org>; Sun,  7 Jul 2024 01:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720317232; cv=none; b=prM8V3L8xN2qLy8WYoVnv4qYSgxcsgy9YkZpK955piDCxMBw6CKACXR9Y3fKlzspvqmTtPveoABnehWlhB5Fh+4ONez6mpI6WETeBAj0vfmvSGZJ1biRuS20HLfEEFYUPsGhJYYSTjDv8wDx9/IrcN4s07mnaGXv32bKoYdUB38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720317232; c=relaxed/simple;
	bh=QO1QfZmFH3nb7jOEf1BOZgRTSR0pQimUermeoLT/Udc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ipt26q87FfZ0aaxpeSekvXnHDx9fhNOroD+PxESJH8KJN7wk4aBEUzyipE0GHVK3RT5fU4iux/ZFdI+fwpZClwTs6Xqds/2fvBty0V5kOuoBvqmQCdTsMIIOk2yZVy1nwmlhcHbvmTKYr7otR/fPDoqeSQdpVLkSKUsXEUz1qoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Icw52A9S; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Icw52A9S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720317230; x=1751853230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QO1QfZmFH3nb7jOEf1BOZgRTSR0pQimUermeoLT/Udc=;
  b=Icw52A9SRbZGx/IQlz+GkV9dOZGSvrwImOwPRO/fz5Tsii1w4hHVM8Y8
   SHBFom/oThc64y+hlwQb7e6Zdj1HYD/Q3JAeBHHoMr0gV0NrWlA0ju6/e
   GGqRlXYUCcjuqQzcUMyQZ18XVHu5qMg86sUpWAyDww225B1E+M1u18M6/
   newE+ApeEewkHoSMxNbQ2I3z0Ej3cSG4mJR2xi4N+rXfauTNipIOhln4A
   fjRIU1HM/0jP3EsZXeu2F7fCuK1/g8jw4FgSdLuD0ECCo+vu7Wyn44j2z
   TZBV7gBncDFpfpdffLtFx52uHpb18QE+EkhCWCc9IOjMvZKnjY4QcqSIt
   A==;
X-CSE-ConnectionGUID: QM1mFvE/Toyia977LR1XTg==
X-CSE-MsgGUID: a4cUnvkXSeqy6IXgWD3X7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11125"; a="17680732"
X-IronPort-AV: E=Sophos;i="6.09,189,1716274800"; 
   d="scan'208";a="17680732"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 18:53:49 -0700
X-CSE-ConnectionGUID: GY9wTxHVRdyNMPcNzjQ/4Q==
X-CSE-MsgGUID: AUzRMtsgRlGyEtiJ2sH3ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,189,1716274800"; 
   d="scan'208";a="46948298"
Received: from pgarg3-mobl.amr.corp.intel.com (HELO localhost) ([10.209.105.130])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 18:53:48 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v2 1/2] cxl/memdev: Replace ENXIO with EBUSY for inject poison limit reached
Date: Sat,  6 Jul 2024 18:53:43 -0700
Message-Id: <825bd4c67fb55a4373c4182d999ad49d4e6b4fe7.1720316188.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1720316188.git.alison.schofield@intel.com>
References: <cover.1720316188.git.alison.schofield@intel.com>
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
Tested-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
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

