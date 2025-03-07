Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E7918DB32
	for <linux-cxl@vger.kernel.org>; Fri,  7 Mar 2025 18:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741371142; cv=none; b=bxSoymi5fBHN1MzQGnWSmgkYfnC5rl/0iLfZGV3q7ioy0soCcJbXJAix1wIsxl6eXOTl+cv34DbKHflEuZTXtITz2DnoOO1ImcVv7d5Dyr72TIqMopslie4QAILYvAj/cHrn9l3qu56WRlAVhG502akn0GvvxHmBftwsJHGAZms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741371142; c=relaxed/simple;
	bh=lmpT2KLULqG7FkNeXsNTXPH4a3cSJ6tQLNPVWjqQTMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VdvQADEXwbrXXwgS2QXJzEGkJtjq5SW2GdBk7G6mUrbgny6K19T2resviPZ4QAt6sIWTBgzAg/VKFLult0/a463AgeGniDGkkrx76ha4EPmKWkbnkaDIVzL03jMBGZhYsgPBRvCAEOd1BFPLV4fCbiH578BorvXo1Q93EV5tLmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hbazAONf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hbazAONf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741371140; x=1772907140;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lmpT2KLULqG7FkNeXsNTXPH4a3cSJ6tQLNPVWjqQTMY=;
  b=hbazAONffeyrOpcSwaFTtHcB3HccDZxszjd/mNxLp7EaKJcga+Y0SCn2
   uReIbKwtnjtPukOPtBu3m/gqXPhReHTAo/r5sWMnFaQk6Y8phIjJp6B0Y
   04+TCLeL3J4jaaXSkOFeMscDP1ovkKcof5ci0Eu8XERtABX6JSrc+kg/t
   Rz7AEu9fZL41vl6e5pDuRaFfayWFglZgTSL/v08Skgk/hP+HNHAQ7hCnq
   xCds1owozeeH6V2tY2Z9bu+1ba8eUA7gw3C8hOCN4RYbEJSiEYtF6KvkY
   HHT+W7JFaQ4vls3rOcVZ7o7kI2eKV2LZtrbApDxhRBUPLLb6jgC9/9TBQ
   Q==;
X-CSE-ConnectionGUID: dxRJIEcXQGaw/I2iWDYfzw==
X-CSE-MsgGUID: mLuVuwiURjKE1YXr23XZLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="64869089"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="64869089"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 10:12:20 -0800
X-CSE-ConnectionGUID: Lqb6MsUtSt6jfCNdMZKNzQ==
X-CSE-MsgGUID: vlM9z5XlTkK426krbTvnTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="150188608"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.159])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 10:12:20 -0800
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] cxl: Restore opcode order in enum cxl_opcode
Date: Fri,  7 Mar 2025 10:12:10 -0800
Message-ID: <20250307181214.2624147-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

The opcodes recently drifted out of order. Restore for readability.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

This just went out of order in cxl/next w FEATURES. I only noticed
while reviewing Shiju's PERFORM_MAINTENANCE patch, where 0x0600 is
being inserting in the middle. Let's keep this orderly.


 drivers/cxl/cxlmem.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 3ec6b906371b..f60d96f97500 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -524,9 +524,6 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_LOG_CAPS	= 0x0402,
 	CXL_MBOX_OP_CLEAR_LOG           = 0x0403,
 	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
-	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
-	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
-	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
@@ -551,6 +548,9 @@ enum cxl_opcode {
 	CXL_MBOX_OP_UNLOCK		= 0x4503,
 	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
 	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
+	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
+	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
+	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
 	CXL_MBOX_OP_MAX			= 0x10000
 };
 

base-commit: 0a14566be090ca51a32ebdd8a8e21678062dac08
-- 
2.37.3

