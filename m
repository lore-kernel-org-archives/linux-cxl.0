Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2D14AEF2;
	Fri,  6 Sep 2024 03:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725592172; cv=none; b=DX5slylc62vNLNmnGRCti0Or0IkOSEs5Kg8ah0FLt/II5DRu6XufTb/TaeQxohog9nhh0m/YLZA/6soiW1S2ZGIvG4WUa60cPcesWOpl6cNNBdXYAo5+szetfTtkumCTscU9EB+qgxuACY34woTY7jRt1Q7eR+Fu4TwXkhQ9/N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725592172; c=relaxed/simple;
	bh=PSFihkZgLasjDkyToU3y/y2OCLAaD/A4Hx/YphgS1CM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LAmd65w1nKqSAKXTVCuK9FOLO9cfP14ICozVaEVncU1QUyU+fZPDf6mZCtnmEU/lXL3aVdF1D42lbpF1m0/Pi4/HTi6QH+OejKoQC+/hBxb629JhPCUh82n80xHyXW0bKnyUJ/WWFEhZm5eMr9a/LDAW0b2ra1IjXDh4JJOupUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AEEnVWIM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AEEnVWIM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725592170; x=1757128170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PSFihkZgLasjDkyToU3y/y2OCLAaD/A4Hx/YphgS1CM=;
  b=AEEnVWIMPpnKFei5Scmnq1d3zHfG3iUZ2AMO92t0DOy5CDhZtLspIJ4S
   XOPF3y3yRzK67PvEaMRm3vyhsK3wCXDG9zXJKcYR7Um/JF6uZduK8F/MD
   4/gz/JQZzk9/9KBFd2hT7oohUlG/yezRTfxTp3udBlfAOevsLV6a9tJv5
   3jwu+Qf4+Ym3HHgMX4zmlsvoKkQ6tKSP2cX3T0D0viEP01kx1rXEPqCES
   gLVW/iuan3S4cEceZqMiyV3we39eGD1TpSuuqm1AGWbsAjw23KiOZw3e7
   9dLdubMmhzxJZTGMPUk+D5UaxGNBHGxt2IDLf0OsANrz6Se/MfdBd8Lkm
   g==;
X-CSE-ConnectionGUID: 22hlmmOcQ0S216mX6K0/Tw==
X-CSE-MsgGUID: anYqW03fRPyanAXJZiIrtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="28089487"
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="28089487"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 20:09:30 -0700
X-CSE-ConnectionGUID: x+ooRBcEQECl/064bwq7yg==
X-CSE-MsgGUID: 64nkZDu+REefnITy+IXeiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="66364412"
Received: from unknown (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.245.242.189])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 20:09:26 -0700
From: Huang Ying <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH -v3 3/3] resource, kunit: Add test case for region_intersects()
Date: Fri,  6 Sep 2024 11:07:13 +0800
Message-Id: <20240906030713.204292-4-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240906030713.204292-1-ying.huang@intel.com>
References: <20240906030713.204292-1-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

region_intersects() is important because it's used for /dev/mem
permission checking.  To avoid possible bug of region_intersects() in
the future, a kunit test case for region_intersects() is added.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Baoquan He <bhe@redhat.com>
---
 kernel/resource.c       |  20 ++++--
 kernel/resource_kunit.c | 143 ++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug       |   1 +
 3 files changed, 158 insertions(+), 6 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 035ef16c1a66..e6d222fb0f84 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1860,7 +1860,17 @@ EXPORT_SYMBOL(resource_list_free);
 #ifdef CONFIG_GET_FREE_REGION
 #define GFR_DESCENDING		(1UL << 0)
 #define GFR_REQUEST_REGION	(1UL << 1)
-#define GFR_DEFAULT_ALIGN (1UL << PA_SECTION_SHIFT)
+#ifdef PA_SECTION_SHIFT
+#define GFR_DEFAULT_ALIGN	(1UL << PA_SECTION_SHIFT)
+#else
+#define GFR_DEFAULT_ALIGN	PAGE_SIZE
+#endif
+
+#ifdef MAX_PHYSMEM_BITS
+#define MAX_PHYS_ADDR		((1ULL << MAX_PHYSMEM_BITS) - 1)
+#else
+#define MAX_PHYS_ADDR		(-1ULL)
+#endif
 
 static resource_size_t gfr_start(struct resource *base, resource_size_t size,
 				 resource_size_t align, unsigned long flags)
@@ -1868,8 +1878,7 @@ static resource_size_t gfr_start(struct resource *base, resource_size_t size,
 	if (flags & GFR_DESCENDING) {
 		resource_size_t end;
 
-		end = min_t(resource_size_t, base->end,
-			    (1ULL << MAX_PHYSMEM_BITS) - 1);
+		end = min_t(resource_size_t, base->end, MAX_PHYS_ADDR);
 		return end - size + 1;
 	}
 
@@ -1886,8 +1895,7 @@ static bool gfr_continue(struct resource *base, resource_size_t addr,
 	 * @size did not wrap 0.
 	 */
 	return addr > addr - size &&
-	       addr <= min_t(resource_size_t, base->end,
-			     (1ULL << MAX_PHYSMEM_BITS) - 1);
+		addr <= min_t(resource_size_t, base->end, MAX_PHYS_ADDR);
 }
 
 static resource_size_t gfr_next(resource_size_t addr, resource_size_t size,
@@ -2048,7 +2056,7 @@ struct resource *alloc_free_mem_region(struct resource *base,
 	return get_free_mem_region(NULL, base, size, align, name,
 				   IORES_DESC_NONE, flags);
 }
-EXPORT_SYMBOL_NS_GPL(alloc_free_mem_region, CXL);
+EXPORT_SYMBOL_GPL(alloc_free_mem_region);
 #endif /* CONFIG_GET_FREE_REGION */
 
 static int __init strict_iomem(char *str)
diff --git a/kernel/resource_kunit.c b/kernel/resource_kunit.c
index 0e509985a44a..42d2d8d20f5d 100644
--- a/kernel/resource_kunit.c
+++ b/kernel/resource_kunit.c
@@ -7,6 +7,8 @@
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <linux/sizes.h>
+#include <linux/mm.h>
 
 #define R0_START	0x0000
 #define R0_END		0xffff
@@ -137,9 +139,150 @@ static void resource_test_intersection(struct kunit *test)
 	} while (++i < ARRAY_SIZE(results_for_intersection));
 }
 
+/*
+ * The test resource tree for region_intersects() test:
+ *
+ * BASE-BASE+1M-1 : Test System RAM 0
+ *		  # hole 0 (BASE+1M-BASE+2M)
+ * BASE+2M-BASE+3M-1 : Test CXL Window 0
+ * BASE+3M-BASE+4M-1 : Test System RAM 1
+ * BASE+4M-BASE+7M-1 : Test CXL Window 1
+ *   BASE+4M-BASE+5M-1 : Test System RAM 2
+ *     BASE+4M+128K-BASE+4M+256K-1: Test Code
+ *   BASE+5M-BASE+6M-1 : Test System RAM 3
+ */
+#define RES_TEST_RAM0_OFFSET	0
+#define RES_TEST_RAM0_SIZE	SZ_1M
+#define RES_TEST_HOLE0_OFFSET	(RES_TEST_RAM0_OFFSET + RES_TEST_RAM0_SIZE)
+#define RES_TEST_HOLE0_SIZE	SZ_1M
+#define RES_TEST_WIN0_OFFSET	(RES_TEST_HOLE0_OFFSET + RES_TEST_HOLE0_SIZE)
+#define RES_TEST_WIN0_SIZE	SZ_1M
+#define RES_TEST_RAM1_OFFSET	(RES_TEST_WIN0_OFFSET + RES_TEST_WIN0_SIZE)
+#define RES_TEST_RAM1_SIZE	SZ_1M
+#define RES_TEST_WIN1_OFFSET	(RES_TEST_RAM1_OFFSET + RES_TEST_RAM1_SIZE)
+#define RES_TEST_WIN1_SIZE	(SZ_1M * 3)
+#define RES_TEST_RAM2_OFFSET	RES_TEST_WIN1_OFFSET
+#define RES_TEST_RAM2_SIZE	SZ_1M
+#define RES_TEST_CODE_OFFSET	(RES_TEST_RAM2_OFFSET + SZ_128K)
+#define RES_TEST_CODE_SIZE	SZ_128K
+#define RES_TEST_RAM3_OFFSET	(RES_TEST_RAM2_OFFSET + RES_TEST_RAM2_SIZE)
+#define RES_TEST_RAM3_SIZE	SZ_1M
+#define RES_TEST_TOTAL_SIZE	((RES_TEST_WIN1_OFFSET + RES_TEST_WIN1_SIZE))
+
+static void remove_free_resource(void *ctx)
+{
+	struct resource *res = (struct resource *)ctx;
+
+	remove_resource(res);
+	kfree(res);
+}
+
+static void resource_test_request_region(struct kunit *test, struct resource *parent,
+					 resource_size_t start, resource_size_t size,
+					 const char *name, unsigned long flags)
+{
+	struct resource *res;
+
+	res = __request_region(parent, start, size, name, flags);
+	KUNIT_ASSERT_NOT_NULL(test, res);
+	kunit_add_action_or_reset(test, remove_free_resource, res);
+}
+
+static void resource_test_insert_resource(struct kunit *test, struct resource *parent,
+					  resource_size_t start, resource_size_t size,
+					  const char *name, unsigned long flags)
+{
+	struct resource *res;
+
+	res = kzalloc(sizeof(*res), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, res);
+
+	res->name = name;
+	res->start = start;
+	res->end = start + size - 1;
+	res->flags = flags;
+	if (insert_resource(parent, res)) {
+		kfree(res);
+		KUNIT_FAIL_AND_ABORT(test, "Fail to insert resource %pR\n", res);
+	}
+
+	kunit_add_action_or_reset(test, remove_free_resource, res);
+}
+
+static void resource_test_region_intersects(struct kunit *test)
+{
+	unsigned long flags =  IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+	struct resource *parent;
+	resource_size_t start;
+
+	/* Find an iomem_resource hole to hold test resources */
+	parent = alloc_free_mem_region(&iomem_resource, RES_TEST_TOTAL_SIZE, SZ_1M,
+				       "test resources");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
+	start = parent->start;
+	kunit_add_action_or_reset(test, remove_free_resource, parent);
+
+	resource_test_request_region(test, parent, start + RES_TEST_RAM0_OFFSET,
+				     RES_TEST_RAM0_SIZE, "Test System RAM 0", flags);
+	resource_test_insert_resource(test, parent, start + RES_TEST_WIN0_OFFSET,
+				      RES_TEST_WIN0_SIZE, "Test CXL Window 0",
+				      IORESOURCE_MEM);
+	resource_test_request_region(test, parent, start + RES_TEST_RAM1_OFFSET,
+				     RES_TEST_RAM1_SIZE, "Test System RAM 1", flags);
+	resource_test_insert_resource(test, parent, start + RES_TEST_WIN1_OFFSET,
+				      RES_TEST_WIN1_SIZE, "Test CXL Window 1",
+				      IORESOURCE_MEM);
+	resource_test_request_region(test, parent, start + RES_TEST_RAM2_OFFSET,
+				     RES_TEST_RAM2_SIZE, "Test System RAM 2", flags);
+	resource_test_insert_resource(test, parent, start + RES_TEST_CODE_OFFSET,
+				      RES_TEST_CODE_SIZE, "Test Code", flags);
+	resource_test_request_region(test, parent, start + RES_TEST_RAM3_OFFSET,
+				     RES_TEST_RAM3_SIZE, "Test System RAM 3", flags);
+	kunit_release_action(test, remove_free_resource, parent);
+
+	KUNIT_EXPECT_EQ(test, REGION_INTERSECTS,
+			region_intersects(start + RES_TEST_RAM0_OFFSET, PAGE_SIZE,
+					  IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE));
+	KUNIT_EXPECT_EQ(test, REGION_INTERSECTS,
+			region_intersects(start + RES_TEST_RAM0_OFFSET +
+					  RES_TEST_RAM0_SIZE - PAGE_SIZE, 2 * PAGE_SIZE,
+					  IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE));
+	KUNIT_EXPECT_EQ(test, REGION_DISJOINT,
+			region_intersects(start + RES_TEST_HOLE0_OFFSET, PAGE_SIZE,
+					  IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE));
+	KUNIT_EXPECT_EQ(test, REGION_DISJOINT,
+			region_intersects(start + RES_TEST_HOLE0_OFFSET +
+					  RES_TEST_HOLE0_SIZE - PAGE_SIZE, 2 * PAGE_SIZE,
+					  IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE));
+	KUNIT_EXPECT_EQ(test, REGION_MIXED,
+			region_intersects(start + RES_TEST_WIN0_OFFSET +
+					  RES_TEST_WIN0_SIZE - PAGE_SIZE, 2 * PAGE_SIZE,
+					  IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE));
+	KUNIT_EXPECT_EQ(test, REGION_INTERSECTS,
+			region_intersects(start + RES_TEST_RAM1_OFFSET +
+					  RES_TEST_RAM1_SIZE - PAGE_SIZE, 2 * PAGE_SIZE,
+					  IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE));
+	KUNIT_EXPECT_EQ(test, REGION_INTERSECTS,
+			region_intersects(start + RES_TEST_RAM2_OFFSET +
+					  RES_TEST_RAM2_SIZE - PAGE_SIZE, 2 * PAGE_SIZE,
+					  IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE));
+	KUNIT_EXPECT_EQ(test, REGION_INTERSECTS,
+			region_intersects(start + RES_TEST_CODE_OFFSET, PAGE_SIZE,
+					  IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE));
+	KUNIT_EXPECT_EQ(test, REGION_INTERSECTS,
+			region_intersects(start + RES_TEST_RAM2_OFFSET,
+					  RES_TEST_RAM2_SIZE + PAGE_SIZE,
+					  IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE));
+	KUNIT_EXPECT_EQ(test, REGION_MIXED,
+			region_intersects(start + RES_TEST_RAM3_OFFSET,
+					  RES_TEST_RAM3_SIZE + PAGE_SIZE,
+					  IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE));
+}
+
 static struct kunit_case resource_test_cases[] = {
 	KUNIT_CASE(resource_test_union),
 	KUNIT_CASE(resource_test_intersection),
+	KUNIT_CASE(resource_test_region_intersects),
 	{}
 };
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a30c03a66172..383453cbf4af 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2616,6 +2616,7 @@ config RESOURCE_KUNIT_TEST
 	tristate "KUnit test for resource API" if !KUNIT_ALL_TESTS
 	depends on KUNIT
 	default KUNIT_ALL_TESTS
+	select GET_FREE_REGION
 	help
 	  This builds the resource API unit test.
 	  Tests the logic of API provided by resource.c and ioport.h.
-- 
2.39.2

