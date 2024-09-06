Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC64345957;
	Fri,  6 Sep 2024 03:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725592167; cv=none; b=f2mgQO+95IV/XL3sG9GrEdY155O8ngzS3eFDPFSBFkyGGrBMD62/ql2ta5yazc88DNSHt8BDufIqdev1au39itkBDYkhq/oFlNSUjG/kIdOYu3RhICiNf7A40UpFyzESlgYut1BW8OjuL+YBFYEKiUQ1gjUtvrtkBeJcKLsrkL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725592167; c=relaxed/simple;
	bh=3Ij6u3xpNnYxJGL++yR1zK7P57z01gPw8JrpH/RINL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NJzZBOZqlp5TqwUUAlXs74S1Ptfytn7xPHH5dlHTcPwoT4P3Q0kDfDYL6vKaAn8SqPdYCXrZm5qmJ6PnBrUODRmKAK1HadXgjj0xlVRM57CjNHXDGlyzu5NCrKx2wkHqwpPe9bKO7KpULUlkKKOvMmMhkfeo8CWUgQXn3VqXLOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=boJXC0yS; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="boJXC0yS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725592165; x=1757128165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Ij6u3xpNnYxJGL++yR1zK7P57z01gPw8JrpH/RINL8=;
  b=boJXC0ySR5dQfLlAql7X0bbIqxISK0OVSopNGjdYiP9uQ1MzCtXX6aG8
   fu0HPlVl7Lpy43wEXzJ3REZB+qr368mEHPzZfvQQXmqHpKjD2WOAhi8XU
   G8NLW7Hl6A/YKW0VhXnc5kLjTZKJBvwBC+WLHqkSfs3gryDfonDGRAVZG
   iWOKFKvtnuKN8gSARy+1Uh8m6gglktKwVGkkjtHm9e5fpf7ZOLUKRWg4H
   OxGFRUo+17PAiBDTaiB9sDd0CoacW20Sd/JVDHQtgPTCNIfElihoJv16g
   dZMqqxpcVYU8sVJ4MeGb89tyXPihoM97arbuZMRiDMnW5Jb6Gd/afzS1j
   A==;
X-CSE-ConnectionGUID: Jn3NNWS7RMSEsIg+dmqf0g==
X-CSE-MsgGUID: to4xBDYzQTqV6Ob92BLf1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="28089473"
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="28089473"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 20:09:25 -0700
X-CSE-ConnectionGUID: nKPr5kD7TPSkUShYudxjNw==
X-CSE-MsgGUID: zSY50cl/Tb2/KgutidFYzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="66364396"
Received: from unknown (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.245.242.189])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 20:09:22 -0700
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
Subject: [PATCH -v3 2/3] resource: Make alloc_free_mem_region() works for iomem_resource
Date: Fri,  6 Sep 2024 11:07:12 +0800
Message-Id: <20240906030713.204292-3-ying.huang@intel.com>
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

During developing a kunit test case for region_intersects(), some fake
resources need to be inserted into iomem_resource.  To do that, a
resource hole needs to be found first in iomem_resource.

However, alloc_free_mem_region() cannot work for iomem_resource now.
Because the start address to check cannot be 0 to detect address
wrapping 0 in gfr_continue(), while iomem_resource.start == 0.  To
make alloc_free_mem_region() works for iomem_resource, gfr_start() is
changed to avoid to return 0 even if base->start == 0.  We don't need
to check 0 as start address.

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
 kernel/resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 235dc77f8add..035ef16c1a66 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1873,7 +1873,7 @@ static resource_size_t gfr_start(struct resource *base, resource_size_t size,
 		return end - size + 1;
 	}
 
-	return ALIGN(base->start, align);
+	return ALIGN(max(base->start, align), align);
 }
 
 static bool gfr_continue(struct resource *base, resource_size_t addr,
-- 
2.39.2

