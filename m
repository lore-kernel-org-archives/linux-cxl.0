Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98D910A11
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jul 2024 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721892658; cv=none; b=jZFOdMz+o4dkj6h1FfkyOPALVBg101CjYCMeKX+39E4mngIbnD5Fi1cmyVsAAydsXtWbveF11XhhPMP82G458dbK21Z5/TF8U9Vrja+1Y7bNbQniIpxahCnoQ024vUu9GDlcVSQEJjn2Rtz7uF2jgL93bLOpHWN/u0fFNxpgVAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721892658; c=relaxed/simple;
	bh=qckxtpb7dCvylzPVCAw6dJ1nqWX6KkCdp90cDUjTlio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O3nTqV2o2dHdHJm6dUpFntKCiyAuO/D37vw+MWVEjXqhpf6hENJNaHOhw8rAju9Jo0kgFNvvz+TEo588AK9fc5aIUcjUo2RLL9/UYZnShdm13ff0i4+xvjw8kqSESqPE7jN7M06ozl6fn/aSGdRQRxa71VGOloITTyQTGGyHUsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZnuM8Phl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZnuM8Phl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721892656; x=1753428656;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qckxtpb7dCvylzPVCAw6dJ1nqWX6KkCdp90cDUjTlio=;
  b=ZnuM8PhlYCbTgQUfwhcKUvqVI0Js7NWlTCjRIKk4D90P42n9OaDSkJZF
   IXnkCiZMz7bTFOIyQ8SGhsOB6BsqTD9wLzPVkzzqHRgIpQN86AgxPiKFp
   lsqKFrtv6n2Qc22ZASH+FiviZkpHwTxM6n4IGT1XmN2VBvsA6jY+wDHvz
   F6ieQ2mtKAp4+Tu9TJyEJ7fywluV2IZvn1e6UUCPOuZYlP+Ln0yPiHgV2
   bAQKTFRFO6OE+KSsteuH+B6HouufqjTa4oneqmNQ8gd4gkBbHCc/leanz
   oOFwWbN9MHM3YmyonVIAmI3N6JbpbxysAr+ro/tCav/ZVP9CwsE4WLdeM
   w==;
X-CSE-ConnectionGUID: duudzVv+R+iXM5qstpMr6Q==
X-CSE-MsgGUID: zy/CYsBaTA24t91xp8Q2XQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="23419353"
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="23419353"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 00:30:55 -0700
X-CSE-ConnectionGUID: EarcGu0rRLuw3O44nrdcgg==
X-CSE-MsgGUID: Nr5omtWkS1WOoTzl49PL/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="83850581"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.57.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 00:30:53 -0700
From: alison.schofield@intel.com
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [ndctl PATCH] cxl/list: add firmware_version to default memdev listing
Date: Thu, 25 Jul 2024 00:30:50 -0700
Message-Id: <20240725073050.219952-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

cxl list users may discover the firmware revision of a memory
device by using the -F option to cxl list. That option uses
the CXL GET_FW_INFO command and emits this json:

"firmware":{
      "num_slots":2,
      "active_slot":1,
      "staged_slot":1,
      "online_activate_capable":false,
      "slot_1_version":"BWFW VERSION 0",
      "fw_update_in_progress":false
    }

Since device support for GET_FW_INFO is optional, the above method
is not guaranteed. However, the IDENTIFY command is mandatory and
provides the current firmware revision.

Accessors already exist for retrieval from sysfs so simply add
the new json member to the default memdev listing.

This means users of the -F option will get the same info twice if
GET_FW_INFO is supported.

[
  {
    "memdev":"mem9",
    "pmem_size":268435456,
    "serial":0,
    "host":"0000:c0:00.0"
    "firmware_version":"BWFW VERSION 00",
  }
]

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 cxl/json.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/cxl/json.c b/cxl/json.c
index 0c27abaea0bd..0b0b186a2594 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -577,6 +577,7 @@ struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
 	const char *devname = cxl_memdev_get_devname(memdev);
 	struct json_object *jdev, *jobj;
 	unsigned long long serial, size;
+	const char *fw_version;
 	int numa_node;
 	int qos_class;
 
@@ -646,6 +647,13 @@ struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
 	if (jobj)
 		json_object_object_add(jdev, "host", jobj);
 
+	fw_version = cxl_memdev_get_firmware_version(memdev);
+	if (fw_version) {
+		jobj = json_object_new_string(fw_version);
+		if (jobj)
+			json_object_object_add(jdev, "firmware_version", jobj);
+	}
+
 	if (!cxl_memdev_is_enabled(memdev)) {
 		jobj = json_object_new_string("disabled");
 		if (jobj)
-- 
2.37.3

