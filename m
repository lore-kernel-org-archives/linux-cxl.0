Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC6D1F1304
	for <linux-cxl@vger.kernel.org>; Sat,  4 Apr 2026 01:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775266492; cv=none; b=nfQxfhwOuielpOJMLQ+UzK1MguQBhne2A/Mi2zuIWWQK2mot0eqIKKNq6wPwu2iUrU7NQuxLbKfAozA29A/q61zS7qFRbotzyPn3al6TxfyH5LTqJMf0axpPfeqJNBcIc1gOs6CF77+UBRUr483CBI4Q5xK7ARC+CsdY178HW6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775266492; c=relaxed/simple;
	bh=AV1+oxpmkinSQydB2GIrzZVXZNne72Z+pOQxnEkD5zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsaVapxfTDJ8dTBzn68CC9yTpuRo65QPkfePaIbAqQPT43amVgMXsKEoVmsZ/N2oZcCOLWNInTtGwT4W2ZqDygXTHVTTTogOZJMZ1JsR7rH8FTEMtp9YJe68LZ8YAyxemSCQYPOspoxlFX5udWjZhlA6Ta3SfYGnO2ZYc/mYh1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=adCAevb1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="adCAevb1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775266490; x=1806802490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AV1+oxpmkinSQydB2GIrzZVXZNne72Z+pOQxnEkD5zc=;
  b=adCAevb1f63+AJWBxWQPu5P4zd52X31gy/vyHCGXmaOfTx3O3ixfGG94
   4QpquKr3xRulJftGbWb34fOssWrFFsHO4Uozc0QFkXGoacf7th+chiyNn
   Cnvzc+sgeWqa56veETiw7AKyXycFHvw245lidHFn2K9+WozBWFwArukPu
   JmFe2j4YBB+z1cqt1b9DK1K27phyZPb1/aw5K42QKA+GQ9jhaBhuo7U2f
   O0OTtwxk4jXIqdrfcPhVvHgbfUr3uiUj3/vH/TlDAOh+T9+9FA5lIa7K4
   9c23JGLE/4EzciaIlCVJ0HWmioxJcBbfOOEgNGd4h/Zr7gjJk9lfogqkI
   A==;
X-CSE-ConnectionGUID: u1e8Rr7gQ7mSK00gmSLqag==
X-CSE-MsgGUID: eb0EJAOQSdO/SQdRm/9Lzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="76218259"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="76218259"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 18:34:48 -0700
X-CSE-ConnectionGUID: Nqcirm13T3+FpHCBJ4hZCQ==
X-CSE-MsgGUID: mozuRCC/Tv22r6/2IX4QIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="257856891"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.12])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 18:34:49 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>
Subject: [ndctl PATCH 3/3] test/cxl-destroy-region.sh: test out-of-order destroy-region handling
Date: Fri,  3 Apr 2026 18:34:41 -0700
Message-ID: <5d924ca777e265a2faaf21d67a1649c3c0d44277.1775265383.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <c2eccb9b0e596820940bfc7ec839ff807f3ac613.1775265383.git.alison.schofield@intel.com>
References: <c2eccb9b0e596820940bfc7ec839ff807f3ac613.1775265383.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent change to 'cxl destroy-region' implementation ensures that
an out of order destroy failure leaves the region intact.

Test an out-of-order destroy attempt followed by in-order destroy
success.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 test/cxl-destroy-region.sh | 79 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/test/cxl-destroy-region.sh b/test/cxl-destroy-region.sh
index f03aa67e8b0d..5c3395e530b0 100644
--- a/test/cxl-destroy-region.sh
+++ b/test/cxl-destroy-region.sh
@@ -32,6 +32,29 @@ destroy_regions()
 	fi
 }
 
+create_region()
+{
+	local decoder="$1"
+	local memdev="$2"
+	local size="$3"
+	local region
+
+	if [[ -n "$size" ]]; then
+		region=$("$CXL" create-region -d "$decoder" -m "$memdev" -s "$size" |
+			 jq -r ".region")
+	else
+		region=$("$CXL" create-region -d "$decoder" -m "$memdev" |
+			 jq -r ".region")
+	fi
+
+	if [[ -z "$region" || "$region" == "null" ]]; then
+		echo "create-region failed for decoder=$decoder memdev=$memdev"
+		err "$LINENO"
+	fi
+
+	echo "$region"
+}
+
 check_destroy_ram()
 {
 	mem=$1
@@ -67,6 +90,51 @@ check_destroy_devdax()
 	"$CXL" destroy-region "$region"
 }
 
+find_pmem_decoder()
+{
+	local mem="$1"
+	local slice="$2"
+	local decoder
+
+	decoder=$($CXL list -b cxl_test -D -d root -m "$mem" |
+		jq -r ".[] |
+		select(.pmem_capable == true) |
+		select(.nr_targets == 1) |
+		select(.max_available_extent >= $(( slice * 2 ))) |
+		.decoder" | head -n1)
+
+	[[ -z $decoder || $decoder == "null" ]] && return 1
+	echo "$decoder"
+}
+
+check_destroy_subregion_order()
+{
+	local mem="$1"
+	local slice=$((256 << 20))
+	local decoder
+	local region0=""
+	local region1=""
+
+	decoder=$(find_pmem_decoder "$mem" "$slice") || return 1
+
+	region0=$(create_region "$decoder" "$mem" "$slice")
+	region1=$(create_region "$decoder" "$mem" "$slice")
+
+	# wrong destroy order should fail
+	destroy_regions "$region0" && err "$LINENO"
+
+	# region0 should still be enabled
+	"$CXL" list -r "$region0" | jq -e 'length > 0' > /dev/null || err "$LINENO"
+
+	# regions should tear down cleanly in correct order
+	destroy_regions "$region1" || err "$LINENO"
+	"$CXL" list -r "$region1" | jq -e 'length == 0' > /dev/null || err "$LINENO"
+	destroy_regions "$region0" || err "$LINENO"
+	"$CXL" list -r "$region0" | jq -e 'length == 0' > /dev/null || err "$LINENO"
+
+	return 0
+}
+
 # Get clean slate, including auto region resources
 destroy_regions
 assert_no_regions
@@ -96,6 +164,17 @@ for mem in "${mems[@]}"; do
 done
 [[ $found -eq 1 ]] || err "$LINENO"
 
+# test wrong-order destroy on back-to-back pmem regions
+destroy_regions
+found=0
+for mem in "${mems[@]}"; do
+	if check_destroy_subregion_order "$mem"; then
+		found=1
+		break
+	fi
+done
+[[ $found -eq 1 ]] || err "$LINENO"
+
 check_dmesg "$LINENO"
 
 modprobe -r cxl_test
-- 
2.37.3

