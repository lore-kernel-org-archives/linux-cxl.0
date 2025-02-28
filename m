Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C091C175A
	for <linux-cxl@vger.kernel.org>; Fri, 28 Feb 2025 19:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740771882; cv=none; b=mcfFApSQwSf1leWRS7XlgZwYNff7vVwjHOJwhsaa1eESlfiqizlmozpuCYyjMcQLZY9lklJcyx2UrRfKj9b8ADIILJJVy4G7BO/gahFjUo2k+JTQbD+6e1iw69bhYiwRwTY7+HE6z5V+HLtZh3wz36TTSRRqCkYjTDnQJBuCeak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740771882; c=relaxed/simple;
	bh=a7a8a4IOwu2lm7+5T5E1TtpzPHmUOfrFfIfNO5gZC7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LtQzXojFiEFgkjPyPJ8jptP7xYCxNMitsQQQM9/vhei1wUIDnHpIZkD6Ida6zZ/V72z/++v2VCGW8oxyqHdNq8p9I/XObA5rl4OUdikWQb5PdSJ3/gqceCOZyQcc0+Ka+9Mrg+wirz/ylrQe7CIaLQ+NNA1I80CV5Uc8GRrzktg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0778AC4CED6;
	Fri, 28 Feb 2025 19:44:41 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>
Subject: [PATCH] cxl: Fix warning from emitting resoruce_size_t as long long int on 32bit systems
Date: Fri, 28 Feb 2025 12:44:02 -0700
Message-ID: <20250228194402.3745766-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported by kernel test bot from an ARM build:
drivers/cxl/core/region.c:3263:26: warning: format '%lld' expects argument of type 'long long int', but argument 3 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]

On a 32bit system, resoruce_size_t is defined as 32bit long vs on a 64bit
system it is defined as 64bit long. Define the variables as u64 instead to
make the size same across all archs.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503010252.mIDhZ5kY-lkp@intel.com/
Fixes: 0ec9849b6333 ("acpi/hmat / cxl: Add extended linear cache support for CXL")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a83301f24fa2..958c15842b1e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3235,14 +3235,15 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_region_params *p = &cxlr->params;
 	int nid = phys_to_target_node(res->start);
-	resource_size_t size, cache_size, start;
+	u64 size, cache_size, start;
 	int rc;
 
 	size = resource_size(res);
 	if (!size)
 		return -EINVAL;
 
-	rc = cxl_acpi_get_extended_linear_cache_size(res, nid, &cache_size);
+	rc = cxl_acpi_get_extended_linear_cache_size(res, nid,
+						     (resource_size_t *)&cache_size);
 	if (rc)
 		return rc;
 
-- 
2.48.1

