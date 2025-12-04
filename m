Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A4A1684B4;
	Thu,  4 Dec 2025 09:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764841964; cv=none; b=T8mznTipov2VnbTW1UvAwGd2/W7lAD1pjWf2nwLUOu38gQgTgW4vYDppdv52IqjdAZnb1Zo1Cj2Owszyf18R4voCD0V5ObX/r3GBDUT+O8KkxPhX4x1fA0KGxfETK+D4RiQAJKirKCy4i+WhNIbKMpZsrZTa+Eba6U1TmY4ul4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764841964; c=relaxed/simple;
	bh=Rk9mdF2ymMauXgR/2ePzRrPEWQA679iAeGy+k5dg7Wg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R9av+BfmbLrM6Rgqdc47hWVuffejAtl2l9HMHff/Wwf2c3IjoqQHbIPTzOyxFKAiurIlllo08z4/CMxaB5EKC+K+jIOnjZU+EANaTezD2Ivf/PGsRl3NdsXJw1A5zsRU1DMQX9okofvRcBbjA5CECMGM9dj3omq102R+C76LFpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvkFRlHu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvkFRlHu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7952BC4CEFB;
	Thu,  4 Dec 2025 09:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764841964;
	bh=Rk9mdF2ymMauXgR/2ePzRrPEWQA679iAeGy+k5dg7Wg=;
	h=From:To:Cc:Subject:Date:From;
	b=PvkFRlHuhakrUvDquNY0SrKrwPUYIQlk2oQTihRg8in+++le3XgDzcmgD12esFdKO
	 4GcnHKfU3KZy9B+md3wqiau2PFKfJ/s4umqMyaMy89ksS/Y56ptEUjjs/FNJ3ysP/G
	 +E42o7lexUlx4IdA4Cs/rvuSQSrUG+0F/I8P1y8QSwfh3ilrI1MgDhHikLx8FLz212
	 Vgo6dUjU6V/O658UVdoqyQtsgvjmLSDgBerCAGl7XIZfbZwvqkM/W0B+RGOV2hdDZC
	 8VOkNH3vCR0In2FMKFLaCzQ0B/3DiJ1Y8ZgqvQNX3pghck50f5XPyGzBOW8b0M5Rce
	 5KhgEIM4BEgpA==
From: Arnd Bergmann <arnd@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Gregory Price <gourry@gourry.net>,
	Robert Richter <rrichter@amd.com>,
	Li Ming <ming.li@zohomail.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cxl/region: fix format string for resource_size_t
Date: Thu,  4 Dec 2025 10:52:26 +0100
Message-Id: <20251204095237.1032528-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The size of this type is architecture specific, and the recommended
way to print it portably is through the custom %pap format string.

Fixes: d6602e25819d ("cxl/region: Add support to indicate region has extended linear cache")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cxl/core/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ae899f68551f..fc36a5413d3f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -759,7 +759,7 @@ static ssize_t extended_linear_cache_size_show(struct device *dev,
 	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
 	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
 		return rc;
-	return sysfs_emit(buf, "%#llx\n", p->cache_size);
+	return sysfs_emit(buf, "%pap\n", &p->cache_size);
 }
 static DEVICE_ATTR_RO(extended_linear_cache_size);
 
-- 
2.39.5

