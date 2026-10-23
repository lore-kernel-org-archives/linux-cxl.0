Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792718017;
	b=vbaCbTA7nLHD5z204uIoeFFKdxl0+APD1TOB83EQYFDj6gqEibHqHof9AftflLsb3QQJ
	 eWHZKnZOJiIZtCWUqC+k8J85XAoWshFS63p23J1l6L3psmHPi7i15cpO9HJTJ/oBHkCwh
	 BOOGVfL08qmgiph69znji25PRRjPlIEdVx1assgHQn7xMuclAVym8+e9u5vBIFglKfxNk
	 XPI+pQBDzwDgX2O3Jo5kZIEuAyqM5ZZE6jlkT6p9pTQWa5UQpgzUQeqk9ag5/eRlLJCUh
	 yQzZK5yzTK3V2C3r950rVBQVqopgPkMmh8OeO39N4ABRHKHWe9eJjAATcgVmosesAig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792718017;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=QoKFEBA4K8oBYh2Jeop9c8wTpH9mJnf2zlarsAMrB90=;
	b=3PaBhwv4N4sUpi0lYKXOwxFTOdhxhmK8Bgt5VyV1M2ElV7hMc58fQ6oiFS58Ga2o6X6b
	 EOcbg5HDfA1n8/df27s//EnKSgirey32/LHcfmbAQbjQ3dTMUSEdkoQcCC4sTxSYaCKQW
	 /e2yxO3VOUzCkOodscG3sJd2O28l28jvKvRjZVYvmltqqj4CziPDAyRGLqSsb0tkuOevS
	 us3L4+Bft2oWePFMyWikbndx2jXjHbEu3CGBSajMS+L9lRZDZxncWq3SSiu+cqRO4PXrW
	 aS9dRuAHd/xhnmc2MY8eIW91Jr8G4tfd62h6I/aAOhHBKkBvqNtFP/J62yFExG/lztQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ayWL35qR;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352E9606A319
	for <linux-cxl@vger.kernel.org>; Fri, 23 Oct 2026 01:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 352E9606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ayWL35qR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792718017; x=1824254017;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mNdF50t5QjFib2eqHwHOz6t64iEoMeJBc0zOVgh4+Ro=;
  b=ayWL35qR6U2kkW+KQ7ri7ga1bjkLWgkzdhq3QsAF/P2efNKPJVHSzXx4
   ZBZUJb7V0fQBzWttJhG9ZB6wWW7eeJAyp304CMDOlXCkcEcNPOsHPW+Fo
   VzIdhP/ZwJEt43BAIBhitSR0MNhVw1bKRTKHw9sEAtkEpX0iOc1jeJydx
   uGDZqH962O+ZlYFrXFBuQ7QcCDHTRy2gXqMnnzKdFuFZTOKZmMIlz8MV/
   0f+Gkx18CoAbAfoFV74L6U9l7q8SNawJL3SXt4Y6XeNbZpZIDD3oUjSF2
   wNIU02HILVASXyIYkbUGoFLOnd2HyBXLyeP0tfnq3l6ZHCjylPLHZr+yb
   w==;
X-CSE-ConnectionGUID: 3s0H6vfCTGiduITrOQvExQ==
X-CSE-MsgGUID: p3Lm8XtPQTKigI6aWRAjWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1365000"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1365000"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 18:13:35 -0700
X-CSE-ConnectionGUID: p20tMUUsQWOXFeIKFkClCg==
X-CSE-MsgGUID: PibckpNjSouzwFhfUNSuMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3384942"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.111.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 18:13:34 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: nvdimm@lists.linux.dev,
	Ben Cheatham <Benjamin.Cheatham@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	linux-cxl@vger.kernel.org
Subject: [ndctl PATCH] cxl/list: handle missing debugfs when reporting protocol injection
Date: Thu, 22 Oct 2026 18:13:32 -0700
Message-ID: <20261023011333.522080-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When debugfs is not mounted or CONFIG_DEBUG_FS is disabled, 'cxl list -v'
crashes while generating the protocol_injectable attribute for downstream
ports.

The crash occurs because cxl_dport_get_einj_path() passes a NULL debugfs
path to strlen().

Return NULL from cxl_dport_get_einj_path() when debugfs is unavailable,
and omit protocol_injectable from the JSON output, consistent with other
debugfs-dependent attributes. Update the documentation to match.

Thanks to Christopher Kim who reported and provided the fixup.

Originally-by: Christopher Kim
Fixes: 5d596866f8c5 ("cxl/list: add injectable errors in output")
Closes: https://github.com/pmem/ndctl/issues/300
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 Documentation/cxl/cxl-inject-protocol-error.txt |  5 ++---
 cxl/json.c                                      | 15 +++++++++------
 cxl/lib/libcxl.c                                |  3 +++
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/Documentation/cxl/cxl-inject-protocol-error.txt b/Documentation/cxl/cxl-inject-protocol-error.txt
index 196b6f6af7e3..179066ff7111 100644
--- a/Documentation/cxl/cxl-inject-protocol-error.txt
+++ b/Documentation/cxl/cxl-inject-protocol-error.txt
@@ -81,9 +81,8 @@ must be enabled. For more information, view the Linux kernel documentation on EI
 
 This command depends on the CXL debug filesystem (normally mounted at
 "/sys/kernel/debug/cxl") to inject protocol errors. If the CXL debugfs is not
-accessible the "protocol_injectable" attribute of dports will always be
-set to false, and the "injectable_protocol_errors" attribute of CXL busses
-will always be empty.
+accessible, the "protocol_injectable" attribute of dports and the
+"injectable_protocol_errors" attribute of CXL buses are omitted.
 
 OPTIONS
 -------
diff --git a/cxl/json.c b/cxl/json.c
index a92548828582..0caa3a87b61d 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -746,12 +746,15 @@ void util_cxl_dports_append_json(struct json_object *jport,
 		if (jobj)
 			json_object_object_add(jdport, "id", jobj);
 
-		einj_path = cxl_dport_get_einj_path(dport);
-		jobj = json_object_new_boolean(einj_path != NULL);
-		if (jobj)
-			json_object_object_add(jdport, "protocol_injectable",
-					       jobj);
-		free(einj_path);
+		if (cxl_debugfs_exists(cxl_port_get_ctx(port))) {
+			einj_path = cxl_dport_get_einj_path(dport);
+			jobj = json_object_new_boolean(einj_path != NULL);
+			if (jobj)
+				json_object_object_add(jdport,
+						       "protocol_injectable",
+						       jobj);
+			free(einj_path);
+		}
 
 		json_object_array_add(jdports, jdport);
 		json_object_set_userdata(jdport, dport, NULL);
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index e55a7b41d77a..16348783e3de 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -3589,6 +3589,9 @@ CXL_EXPORT char *cxl_dport_get_einj_path(struct cxl_dport *dport)
 	char *path;
 	int rc;
 
+	if (!ctx->cxl_debugfs)
+		return NULL;
+
 	path_len = strlen(ctx->cxl_debugfs) + 100;
 	path = calloc(path_len, sizeof(char));
 	if (!path)
-- 
2.37.3

