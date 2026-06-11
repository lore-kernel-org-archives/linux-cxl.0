Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D1217A2E8
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 00:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781137171; cv=none; b=YLeIwmtwmEn44z/QENc+b2voJvjkW70wMgIqwpVKRUWvxltB/eS9LhQGgf3iwWLMDG+8wQ1anuYk+KXWdj4ciUlGcBCWMW1AtyNBLCrBn1Rd6nsk1leXLARqP0hxFMBxUGPMa1B0eP6taLMsLUAbPtqzrd2fe8eWjV2zm2WiI1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781137171; c=relaxed/simple;
	bh=5NfHHB1XexcAuvs06yfjoDisyrtOqg5KcGCXrerRxYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2J59oMSnlO35kwvrxru3JeWItmWVwEZ0+h7BdW+g0tarspTgyhQ7YZFsPmMnlRvI/Wi9JDm2JfWxoJljCs0GjRkPQ/Kt2PcpTzLJsdKS+NJffg2mVXVEfzKcbWdzVYYNZasGABJ17gaGl08ibjzJ7M5QqjckCKDPvwk1Kd3Q3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O59tzlrV; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O59tzlrV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781137169; x=1812673169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5NfHHB1XexcAuvs06yfjoDisyrtOqg5KcGCXrerRxYQ=;
  b=O59tzlrVlMd8V4vL+0tmmn7j0ObFJzA095BDyLTrfBQqpuwe9ioMIBKr
   63JqFXjVw/4UfLhs/74P79oLaZqhSv+f6/f0e0LigeX+vQkpf9iBYYreE
   jXi6DmmBNKuKLwdtiQ+mXWx8QSgrmhd2Hl5yD1i4DLNcOZki9GEx48A+T
   InauVMqM4ZdMWr7fQF9fBkZaxf9qRp54ec38yyn62GA73DhIW1UUPbsYQ
   wKPvLmmmvobwepBVCRR4JBhzP82NKQ4p8dxpldDKnrWvEqym6448qqSrq
   tcQi1Wdi5u7ja2Ll1B1rdWW393+VBI+xXUgHduoXEm+EWYW/cVjZXBkMm
   g==;
X-CSE-ConnectionGUID: C023SMMuTWuMCStgJzDx3Q==
X-CSE-MsgGUID: MXAqJR3ETO+pe0KG+dUCOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82054169"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="82054169"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 17:19:29 -0700
X-CSE-ConnectionGUID: fGIvWrbrRX6+7KvRVHi7OA==
X-CSE-MsgGUID: u6jQSadmQjWWMNYPINxjMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="242181822"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.46])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 17:19:29 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>
Subject: [ndctl PATCH 2/3] test/cxl-create-region.sh: deduplicate decoder and memdev lookups
Date: Wed, 10 Jun 2026 17:19:20 -0700
Message-ID: <89bdbb621375f9dffb648b455d3d872ea7fc8f98.1781136221.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1781136221.git.alison.schofield@intel.com>
References: <cover.1781136221.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several region setup helpers open-code the same decoder and memdev
lookups.

Factor the common queries into shared helpers. This reduces duplicate
logic and simplifies adding new region configuration tests.

No functional change.

Assisted-by: Claude:Opus-4-8
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 test/cxl-create-region.sh | 73 ++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 40 deletions(-)

diff --git a/test/cxl-create-region.sh b/test/cxl-create-region.sh
index d7a6840fed1a..5941e18f338d 100644
--- a/test/cxl-create-region.sh
+++ b/test/cxl-create-region.sh
@@ -25,17 +25,21 @@ destroy_regions()
 	fi
 }
 
+# Find the pmem capable single-target root decoder for a memdev
+find_x1_decoder()
+{
+	$CXL list -b cxl_test -D -d root -m "$1" |
+		  jq -r ".[] |
+		  select(.pmem_capable == true) |
+		  select(.nr_targets == 1) |
+		  .decoder"
+}
+
 create_x1_region()
 {
 	mem="$1"
 
-	# find a pmem capable root decoder for this mem
-	decoder=$($CXL list -b cxl_test -D -d root -m "$mem" |
-		  jq -r ".[] |
-		  select(.pmem_capable == true) |
-		  select(.nr_targets == 1) |
-		  .decoder")
-
+	decoder=$(find_x1_decoder "$mem")
 	if [[ ! $decoder ]]; then
 		echo "no suitable decoder found for $mem, skipping"
 		return
@@ -69,13 +73,7 @@ create_subregions()
 	slice=$((256 << 20))
 	mem="$1"
 
-	# find a pmem capable root decoder for this mem
-	decoder=$($CXL list -b cxl_test -D -d root -m "$mem" |
-		  jq -r ".[] |
-		  select(.pmem_capable == true) |
-		  select(.nr_targets == 1) |
-		  .decoder")
-
+	decoder=$(find_x1_decoder "$mem")
 	if [[ ! $decoder ]]; then
 		echo "no suitable decoder found for $mem, skipping"
 		return
@@ -133,6 +131,17 @@ create_single()
 	destroy_regions "$region"
 }
 
+# Find the index'th memdev behind the decoder's target at position
+find_memdev()
+{
+	local decoder="$1" position="$2" index="$3"
+	local port_dev
+
+	port_dev=$($CXL list -T -d "$decoder" | jq -r ".[] |
+		.targets | .[] | select(.position == $position) | .target")
+	$CXL list -M -p "$port_dev" | jq -r ".[$index].memdev"
+}
+
 create_and_destroy_region()
 {
 	region=$($CXL create-region -d "$decoder" -m "$memdevs" |
@@ -155,9 +164,7 @@ setup_x1()
 		.decoder")
 
 	# Find a memdev for this host-bridge
-	port_dev0=$($CXL list -T -d "$decoder" | jq -r ".[] |
-		.targets | .[] | select(.position == 0) | .target")
-	mem0=$($CXL list -M -p "$port_dev0" | jq -r ".[0].memdev")
+	mem0=$(find_memdev "$decoder" 0 0)
 	memdevs="$mem0"
 }
 
@@ -170,12 +177,8 @@ setup_x2()
 		.decoder")
 
 	# Find a memdev for each host-bridge interleave position
-	port_dev0=$($CXL list -T -d "$decoder" | jq -r ".[] |
-		.targets | .[] | select(.position == 0) | .target")
-	port_dev1=$($CXL list -T -d "$decoder" | jq -r ".[] |
-		.targets | .[] | select(.position == 1) | .target")
-	mem0=$($CXL list -M -p "$port_dev0" | jq -r ".[0].memdev")
-	mem1=$($CXL list -M -p "$port_dev1" | jq -r ".[0].memdev")
+	mem0=$(find_memdev "$decoder" 0 0)
+	mem1=$(find_memdev "$decoder" 1 0)
 	memdevs="$mem0 $mem1"
 }
 
@@ -188,14 +191,10 @@ setup_x4()
 		.decoder")
 
 	# Find a memdev for each host-bridge interleave position
-	port_dev0=$($CXL list -T -d "$decoder" | jq -r ".[] |
-		.targets | .[] | select(.position == 0) | .target")
-	port_dev1=$($CXL list -T -d "$decoder" | jq -r ".[] |
-		.targets | .[] | select(.position == 1) | .target")
-	mem0=$($CXL list -M -p "$port_dev0" | jq -r ".[0].memdev")
-	mem1=$($CXL list -M -p "$port_dev1" | jq -r ".[0].memdev")
-	mem2=$($CXL list -M -p "$port_dev0" | jq -r ".[1].memdev")
-	mem3=$($CXL list -M -p "$port_dev1" | jq -r ".[1].memdev")
+	mem0=$(find_memdev "$decoder" 0 0)
+	mem1=$(find_memdev "$decoder" 1 0)
+	mem2=$(find_memdev "$decoder" 0 1)
+	mem3=$(find_memdev "$decoder" 1 1)
 	memdevs="$mem0 $mem1 $mem2 $mem3"
 }
 
@@ -213,15 +212,9 @@ setup_x3()
 	fi
 
 	# Find a memdev for each host-bridge interleave position
-	port_dev0=$($CXL list -T -d "$decoder" | jq -r ".[] |
-		.targets | .[] | select(.position == 0) | .target")
-	port_dev1=$($CXL list -T -d "$decoder" | jq -r ".[] |
-		.targets | .[] | select(.position == 1) | .target")
-	port_dev2=$($CXL list -T -d "$decoder" | jq -r ".[] |
-		.targets | .[] | select(.position == 2) | .target")
-	mem0=$($CXL list -M -p "$port_dev0" | jq -r ".[0].memdev")
-	mem1=$($CXL list -M -p "$port_dev1" | jq -r ".[0].memdev")
-	mem2=$($CXL list -M -p "$port_dev2" | jq -r ".[0].memdev")
+	mem0=$(find_memdev "$decoder" 0 0)
+	mem1=$(find_memdev "$decoder" 1 0)
+	mem2=$(find_memdev "$decoder" 2 0)
 	memdevs="$mem0 $mem1 $mem2"
 }
 
-- 
2.37.3

