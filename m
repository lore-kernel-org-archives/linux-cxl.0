Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7CC1BC9EB;
	Fri, 16 Aug 2024 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817301; cv=none; b=bs37pMr937VBrSX4t3hxWLHeOXqWNgz0owgBW+5YAQe4EcCcqHwPgyHg26dWaPd3M8gNLnT/T6oygptFQh2ylpCDHZPJLFvjuILNx18xjJFARtMv12RY0G3M+dEfipuSxRIc98N2eJ1+sPN5ki7d/3OQEf2p3Zw9XQAs3w1/x90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817301; c=relaxed/simple;
	bh=ER61a1N0JVP79hKUHmI91kDMkAKxu8opPjqQ1EyBvjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iu/cGcaEm359nXBEYuficIekH6pBNnOl/GuMZirVFkXj7ydQAhMfL/I5B6qOmFRhHrFhpJcG0QyFiDQH13Rh7j6aokLnDcCExXMf0IXbJsQr7n8bI+f39wBVRbABjZPANjbnnnEmJawdqVB6CExYykkDBLW0pu766HXyXM2pm8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nKb8lb16; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nKb8lb16"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723817300; x=1755353300;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ER61a1N0JVP79hKUHmI91kDMkAKxu8opPjqQ1EyBvjY=;
  b=nKb8lb16vBvvZ7HMBsjEGDFyHIfeey5ZDYl/38dS8vMNP4bHcHX+IEN7
   IGcjrIoUJiJB2bv3/mtsmmtX98nl6G+IvAveV8vIR7K+tWBRVNVkUu9m+
   qDPjp0Q38rod8uSHggwsHrGuhWXsJeK/8S9DQII8FuY2jEfCrAPrQ+S1k
   mZhiMr0dmTcyVfMxD73xCrur+/tiwHEX18QphjUXYpVSZ/YS3JOM6ES9x
   z3oM4aTkRf/yf/yZ0pCt/3dW0K7oNvAP3nE5hPZNzGqJvFW0MKbr/ajEb
   pEMeP7ibRFeG217gIcu6U5d5uO0FQndoj6OiMRHvbjE+srYNj9u3q94zL
   Q==;
X-CSE-ConnectionGUID: 5Xc71UkMR0yuithxw/2W4w==
X-CSE-MsgGUID: 4PstT6VSTkeAuMTM2imnig==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22260884"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22260884"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:08:16 -0700
X-CSE-ConnectionGUID: hMhDEQpmRU+aXNk6rrIqGg==
X-CSE-MsgGUID: dlg93kTUTCqPU3gmBDKg6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="59847777"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:08:15 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 16 Aug 2024 09:08:07 -0500
Subject: [PATCH RESEND v2 02/18] cxl/mbox: Flag support for Dynamic
 Capacity Devices (DCD)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v2-2-b4044aadf2bd@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723817288; l=4400;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=ER61a1N0JVP79hKUHmI91kDMkAKxu8opPjqQ1EyBvjY=;
 b=q1WQqgbWEWf2ihXKsodQiNiQ0C6zpL/0Gofq+U12XeK3dmBSJuGcyzAdBR2pP9AVgxn2vXHbZ
 tk6NxzqkMRdAoukeOisY9sTP/AAee6jyF/Bvcv7ymEaNTRFTSroYhdq
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

Per the CXL 3.0 specification software must check the Command Effects
Log (CEL) to know if a device supports DC.  If the device does support
DC the specifics of the DC Regions (0-7) are read through the mailbox.

Flag DC Device (DCD) commands in a device if they are supported.
Subsequent patches will key off these bits to configure a DCD.

Co-developed-by: Navneet Singh <navneet.singh@intel.com>
Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v2
[iweiny: new patch]
---
 drivers/cxl/core/mbox.c | 38 +++++++++++++++++++++++++++++++++++---
 drivers/cxl/cxlmem.h    | 15 +++++++++++++++
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f052d5f174ee..554ec97a7c39 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -111,6 +111,34 @@ static u8 security_command_sets[] = {
 	0x46, /* Security Passthrough */
 };
 
+static bool cxl_is_dcd_command(u16 opcode)
+{
+#define CXL_MBOX_OP_DCD_CMDS 0x48
+
+	return (opcode >> 8) == CXL_MBOX_OP_DCD_CMDS;
+}
+
+static void cxl_set_dcd_cmd_enabled(struct cxl_memdev_state *mds,
+					u16 opcode)
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
 static bool cxl_is_security_command(u16 opcode)
 {
 	int i;
@@ -677,9 +705,10 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
 		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
 
-		if (!cmd && !cxl_is_poison_command(opcode)) {
-			dev_dbg(dev,
-				"Opcode 0x%04x unsupported by driver\n", opcode);
+		if (!cmd && !cxl_is_poison_command(opcode) &&
+		    !cxl_is_dcd_command(opcode)) {
+			dev_dbg(dev, "Opcode 0x%04x unsupported by driver\n",
+				opcode);
 			continue;
 		}
 
@@ -689,6 +718,9 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 		if (cxl_is_poison_command(opcode))
 			cxl_set_poison_cmd_enabled(&mds->poison, opcode);
 
+		if (cxl_is_dcd_command(opcode))
+			cxl_set_dcd_cmd_enabled(mds, opcode);
+
 		dev_dbg(dev, "Opcode 0x%04x enabled\n", opcode);
 	}
 }
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index adfba72445fc..5f2e65204bf9 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -247,6 +247,15 @@ struct cxl_event_state {
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
@@ -436,6 +445,7 @@ struct cxl_dev_state {
  *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
  * @mbox_mutex: Mutex to synchronize mailbox access.
  * @firmware_version: Firmware version for the memory device.
+ * @dcd_cmds: List of DCD commands implemented by memory device
  * @enabled_cmds: Hardware commands found enabled in CEL.
  * @exclusive_cmds: Commands that are kernel-internal only
  * @total_bytes: sum of all possible capacities
@@ -460,6 +470,7 @@ struct cxl_memdev_state {
 	size_t lsa_size;
 	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
 	char firmware_version[0x10];
+	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX);
 	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
 	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
 	u64 total_bytes;
@@ -525,6 +536,10 @@ enum cxl_opcode {
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
2.45.2

