Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBE31DA53
	for <linux-cxl@vger.kernel.org>; Fri,  4 Apr 2025 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743785662; cv=none; b=rhxKZTZwSzequi+x9eytnQfKslWxnUDkpFKBuCIMHSlaHkQ8X+LJSvr2OX5g0HbW0zWVfrTXXphgmomkSjIxBq/vsylpzmij0oRJDHU5+KJwpfMsVV78/wUSMtvaR6+dqQNrFmdtFdGWc/q6AXxBVnW1h6pHxORTVv3a8UiRLRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743785662; c=relaxed/simple;
	bh=ll0oyC7NUhmzETnpxNx26YAmDLUgEBLKFBuGVdQiuEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VwTKLwyb5eZV2+OovHMZsjII0h0H+mH5Vat9besuxC1AHUj0+J8At4ZYiFUvSDTxOY0ZI5vFKxupoQjFQ2Xyk5OiVkzZBTZguOsn+nPhBMqGVNHetGGhc3SFmwQDLwg9Djt3dkmmfTR7V8sl0sHzTwAP4z8/uYJwy0ry8eoRX3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFCBC4CEDD;
	Fri,  4 Apr 2025 16:54:21 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: jonathan.cameron@huawei.com,
	dave@stgolabs.net,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	danj.williams@intel.com,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] cxl: Remove always true condition for cxlctl_validate_hw_command()
Date: Fri,  4 Apr 2025 09:54:18 -0700
Message-ID: <20250404165418.3032414-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smatch warnings:
drivers/cxl/core/features.c:441 cxlctl_validate_hw_command() warn: always true condition '(scope >= 0) => (0-u32max >= 0)'

Remove the check entirely as it has no effect. Expectation is both of these
operations should be allowed for all check levels. They are read only and
have no change effects.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202504041033.2HBboAZR-lkp@intel.com/
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/features.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index caf92e9cea21..594f290042e9 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -614,11 +614,7 @@ static bool cxlctl_validate_hw_command(struct cxl_features_state *cxlfs,
 	switch (opcode) {
 	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
 	case CXL_MBOX_OP_GET_FEATURE:
-		if (cxl_mbox->feat_cap < CXL_FEATURES_RO)
-			return false;
-		if (scope >= FWCTL_RPC_CONFIGURATION)
-			return true;
-		return false;
+		return cxl_mbox->feat_cap >= CXL_FEATURES_RO;
 	case CXL_MBOX_OP_SET_FEATURE:
 		if (cxl_mbox->feat_cap < CXL_FEATURES_RW)
 			return false;
-- 
2.49.0

