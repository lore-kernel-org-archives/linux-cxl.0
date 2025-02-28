Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A823F23CB
	for <linux-cxl@vger.kernel.org>; Fri, 28 Feb 2025 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740775663; cv=none; b=kvtAO5z0Q9X1v8YtjyDJOILzm8GQGd3PMllYtrSzDwcQCxFuIf2wyhgIy5Zb2nS2PM8wXjNZw24i6lMVpsaoVVwjiHrnvIAiOuSYl/pEzEF0IoRftrqx63sccadsZ7bgsqmd/oe0Y53Z29YVz7jK8wIol1kvHMHBnuSylh05F/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740775663; c=relaxed/simple;
	bh=PekWR8VzuF0hDSZaNM4rdCxMbgj2z1M+tWdu1+jU5Io=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QHCQ+QP0R1ncm7zdPIrNSf9aw0UEsKahBBLDAX0tpMZXeiEZKBP+9yGND1+txyVpgEg6gdWDZNtRtG8eXY6pHwxT/djjje3ENghkRKT8ZUd8JY+P61kj4iI1wPZubhHIJ/kdoS87OqLGmuDpjTKqWShmiLEPXXxSbVFad9D2SNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B78C4CED6;
	Fri, 28 Feb 2025 20:47:42 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>
Subject: [PATCH vv2] cxl: Fix warning from emitting resource_size_t as long long int on 32bit systems
Date: Fri, 28 Feb 2025 13:47:39 -0700
Message-ID: <20250228204739.3849309-1-dave.jiang@intel.com>
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

On a 32bit system, resource_size_t is defined as 32bit long vs on a 64bit
system it is defined as 64bit long. Use %pa format to deal with resource_size_t.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503010252.mIDhZ5kY-lkp@intel.com/
Fixes: 0ec9849b6333 ("acpi/hmat / cxl: Add extended linear cache support for CXL")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Fix commit log spelling errors. (Alison)
- Use %pa to deal with type resource_size_t. (Alison)
---
 drivers/cxl/core/region.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a83301f24fa2..8537b6a9ca18 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3251,8 +3251,8 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 
 	if (size != cache_size) {
 		dev_warn(&cxlr->dev,
-			 "Extended Linear Cache size %lld != CXL size %lld. No Support!",
-			 cache_size, size);
+			 "Extended Linear Cache size %pa != CXL size %pa. No Support!",
+			 &cache_size, &size);
 		return -EOPNOTSUPP;
 	}
 
-- 
2.48.1

