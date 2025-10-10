Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EEF256C91
	for <linux-cxl@vger.kernel.org>; Fri, 10 Oct 2025 20:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129881; cv=none; b=nsQAfwdjwL+tMqtlu19XA6QVVWEuVYKcI3N9G8FPOO+M3tH9ELF6LxawdtDs+lPr6pX12EBSRoj2w1pSnS68x1Gbf5Jw1MR7h2LLH1HkWebP6CXGMkkXh1gsi9z/t/asM8GwsNKG/5FapCXQg88cfkON8xDOMUebufIObcttoC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129881; c=relaxed/simple;
	bh=OjduU6G27f1Irs46h2CsF/lwXRcJ+ECVaWgr13WvfxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJ8Ti6seuQcV7sMT/m3R8GgsN6T9j+Mva5aAFJanZLxn1TXiFybzZb61yM3fcJrPEoQNyATFXcK4+0Y4F4hhuVMK4LpV+OFnCBuVNLRscT15/TbmSY7AjqaUBaM+lO7nTA/66GHYGWOUxUIbsKRPlSScWbw0SLqHoFLm5VeNuvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96BFC4CEF1;
	Fri, 10 Oct 2025 20:58:00 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	stable@kernel.org
Subject: [PATCH 1/3] cxl/acpi: Fix setup of memory resource in cxl_acpi_set_cache_size()
Date: Fri, 10 Oct 2025 13:57:53 -0700
Message-ID: <20251010205755.205280-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010205755.205280-1-dave.jiang@intel.com>
References: <20251010205755.205280-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to compare the resource against the HMAT memory target,
the resource needs to be memory type. Change the DEFINE_RES()
macro to DEFINE_RES_MEM() in order to set the correct resource type.
This causes a regression for platforms with the extended linear cache
enabled as the comparison always fails and the cache size is not set.
User visible impact is that when 'cxl list' is issued, a CXL region
with extended linear cache support will only report half the size
of the actual size. And this also breaks MCE reporting of the memory
region due to incorrect offset calculation for the memory.

Fixes: 12b3d697c812 ("cxl: Remove core/acpi.c and cxl core dependency on ACPI")
Cc: stable@kernel.org
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index cb92efbd5914..abd2475b3493 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -345,7 +345,7 @@ static int cxl_acpi_set_cache_size(struct cxl_root_decoder *cxlrd)
 	struct resource res;
 	int nid, rc;
 
-	res = DEFINE_RES(start, size, 0);
+	res = DEFINE_RES_MEM(start, size);
 	nid = phys_to_target_node(start);
 
 	rc = hmat_get_extended_linear_cache_size(&res, nid, &cache_size);
-- 
2.51.0

