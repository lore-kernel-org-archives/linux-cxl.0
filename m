Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FD721A6F9;
	Thu,  7 Nov 2024 20:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013127; cv=none; b=qNXzFort4cYQWsaNZIqlvPu90KXthNqTqI+fVbxJzvyx99hGruufDSa0iLP3FTX0g2fDIvANkDiLmJqybBN8MO6uACnoPtjrXMeYkdbH3ESm7PA+fAIekT2F1nzybzZ9yVqfsSRgYXjHWRemNftSR31Y1zSZFLClC+5J3wj5SGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013127; c=relaxed/simple;
	bh=JoHlfcxAJftVbYk8BRgv0BTrjQVm0Kl9TKT0u5ElTVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V+CuFmS8GTp/5vp6jWXNQ8LbBmg/cR5BniX5vREcB3nMX9wAMoHbyB7uIDFISwiB5+zGqe9AjLu87yQkSX1DGvgypr5zaHv1S96lbhLxIxZF+u2tORWTjmnES83ZLsrwjtFjgB/MXpfOV9QsGFZ2vqPJdb0KdMXa/B6LlvWu5+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QTiRVtuM; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QTiRVtuM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731013126; x=1762549126;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=JoHlfcxAJftVbYk8BRgv0BTrjQVm0Kl9TKT0u5ElTVo=;
  b=QTiRVtuMz6TCmOvLBVCHbm8BzjTdoXKXDTLWmkEH5m0phnMatlGUHl9S
   1H9TrJktKBjo3QPZtGOLeMpzw8RCcDTPt73qN2m+KElY+eDnFeast/PVR
   5BTYZDCG1YSTSVny9B+hXjhLxKtm1AS9jdeCsNFSpTzN22mf5QwkggNKE
   /YA572Wkm6m4+bbiXvWWKRPXVyy2nfVeR+TAYqHttsyP5DdC6IVK98Tc+
   meyXenWQCKuvq4uTSgcjdQh908JIDRvjrXCZYtU4i8gA8f1pvvKdC+KhW
   UEmVW34VvRuwfasVD9HW0pFfr2NjfMXAwD3iRMVuNzYHimmSWJKX8eP2R
   w==;
X-CSE-ConnectionGUID: YddP1uXJT2meADML/Ed9cw==
X-CSE-MsgGUID: 8CjWeP/JQ/iWtY1f6W2yrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="30300364"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="30300364"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 12:58:45 -0800
X-CSE-ConnectionGUID: 3cQTqJh7Q+CV3uW7kPWVfA==
X-CSE-MsgGUID: 4csBbNrEQsi4L0y6YWeZig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="90093622"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.195])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 12:58:44 -0800
From: ira.weiny@intel.com
Date: Thu, 07 Nov 2024 14:58:25 -0600
Subject: [PATCH v7 07/27] cxl/mbox: Flag support for Dynamic Capacity
 Devices (DCD)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-dcd-type2-upstream-v7-7-56a84e66bc36@intel.com>
References: <20241107-dcd-type2-upstream-v7-0-56a84e66bc36@intel.com>
In-Reply-To: <20241107-dcd-type2-upstream-v7-0-56a84e66bc36@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Navneet Singh <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, 
 nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Li Ming <ming4.li@intel.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731013104; l=4110;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=aSCfDRIC6e3FEZwRSJpd4dHA/NNKjjYvtAtyGCqpz4Y=;
 b=+cSLJ1JTCHwg7GPXrWwpL0lvk1zfEhTfnuntf+uZC63PlkCFTkJWbz+wl8gEy18GwIdAEBP9h
 bb07X0/T/dPCspdnS8UOePeKhgVSHrO+arkLKlT7AOtGUw1pp5EHrOu
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

From: Navneet Singh <navneet.singh@intel.com>

Per the CXL 3.1 specification software must check the Command Effects
Log (CEL) for dynamic capacity command support.

Detect support for the DCD commands while reading the CEL, including:

	Get DC Config
	Get DC Extent List
	Add DC Response
	Release DC

Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Li Ming <ming4.li@intel.com>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/mbox.c | 33 +++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    | 15 +++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 5175138c4fb7382426145640d7d04967b02b22dc..aac3bfc0d2c3f916dd870b9f8288b24d90fc9974 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -164,6 +164,34 @@ static void cxl_set_security_cmd_enabled(struct cxl_security_state *security,
 	}
 }
 
+static bool cxl_is_dcd_command(u16 opcode)
+{
+#define CXL_MBOX_OP_DCD_CMDS 0x48
+
+	return (opcode >> 8) == CXL_MBOX_OP_DCD_CMDS;
+}
+
+static void cxl_set_dcd_cmd_enabled(struct cxl_memdev_state *mds,
+				    u16 opcode)
+{
+	switch (opcode) {
+	case CXL_MBOX_OP_GET_DC_CONFIG:
+		set_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds);
+		break;
+	case CXL_MBOX_OP_GET_DC_EXTENT_LIST:
+		set_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds);
+		break;
+	case CXL_MBOX_OP_ADD_DC_RESPONSE:
+		set_bit(CXL_DCD_ENABLED_ADD_RESPONSE, mds->dcd_cmds);
+		break;
+	case CXL_MBOX_OP_RELEASE_DC:
+		set_bit(CXL_DCD_ENABLED_RELEASE, mds->dcd_cmds);
+		break;
+	default:
+		break;
+	}
+}
+
 static bool cxl_is_poison_command(u16 opcode)
 {
 #define CXL_MBOX_OP_POISON_CMDS 0x43
@@ -751,6 +779,11 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 			enabled++;
 		}
 
+		if (cxl_is_dcd_command(opcode)) {
+			cxl_set_dcd_cmd_enabled(mds, opcode);
+			enabled++;
+		}
+
 		dev_dbg(dev, "Opcode 0x%04x %s\n", opcode,
 			enabled ? "enabled" : "unsupported by driver");
 	}
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 2a25d1957ddb9772b8d4dca92534ba76a909f8b3..e8907c403edbd83c8a36b8d013c6bc3391207ee6 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -239,6 +239,15 @@ struct cxl_event_state {
 	struct mutex log_lock;
 };
 
+/* Device enabled DCD commands */
+enum dcd_cmd_enabled_bits {
+	CXL_DCD_ENABLED_GET_CONFIG,
+	CXL_DCD_ENABLED_GET_EXTENT_LIST,
+	CXL_DCD_ENABLED_ADD_RESPONSE,
+	CXL_DCD_ENABLED_RELEASE,
+	CXL_DCD_ENABLED_MAX
+};
+
 /* Device enabled poison commands */
 enum poison_cmd_enabled_bits {
 	CXL_POISON_ENABLED_LIST,
@@ -461,6 +470,7 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
  * @lsa_size: Size of Label Storage Area
  *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
  * @firmware_version: Firmware version for the memory device.
+ * @dcd_cmds: List of DCD commands implemented by memory device
  * @enabled_cmds: Hardware commands found enabled in CEL.
  * @exclusive_cmds: Commands that are kernel-internal only
  * @total_bytes: sum of all possible capacities
@@ -485,6 +495,7 @@ struct cxl_memdev_state {
 	struct cxl_dev_state cxlds;
 	size_t lsa_size;
 	char firmware_version[0x10];
+	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX);
 	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
 	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
 	u64 total_bytes;
@@ -554,6 +565,10 @@ enum cxl_opcode {
 	CXL_MBOX_OP_UNLOCK		= 0x4503,
 	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
 	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
+	CXL_MBOX_OP_GET_DC_CONFIG	= 0x4800,
+	CXL_MBOX_OP_GET_DC_EXTENT_LIST	= 0x4801,
+	CXL_MBOX_OP_ADD_DC_RESPONSE	= 0x4802,
+	CXL_MBOX_OP_RELEASE_DC		= 0x4803,
 	CXL_MBOX_OP_MAX			= 0x10000
 };
 

-- 
2.47.0

