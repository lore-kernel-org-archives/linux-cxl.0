Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463583557F8;
	Fri,  9 Jan 2026 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949009; cv=none; b=EEefaf+T+SnB1p771ZJ6smYNXBWvhnIrgCzw8h5VSa5cjjUP/Usbl33c7m6wSZ2fPFBH/22Fsb3MIh1aEQC8EGo24JEPfRXcMv8PDQn0XroBPvcwVqVBtB9Vi1MNGC1zTgolfWvKYFEyiynaS0slaPT+c/9yz3xNignbZS5XJNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949009; c=relaxed/simple;
	bh=+bY4ZztaByWJWs4ekFGdX8CVHginuxJnHVOLvFyJ01s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDqvQr45K8ESvenFTF6h4VaQoV9DAK0JdiVmtq6Mkzyr7ykXF8427LadrCE+8YiX9y9cv0Ya5qeSZPdf5xHginUHDI1XeBVsGMujjSQ/doerpBrvzEhm0H8s27LDgGkj6VuK36T6I4ct2eSUW60YVxHU0phPcETZ2xCovyvtn6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UrnxmG2t; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UrnxmG2t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767949004; x=1799485004;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+bY4ZztaByWJWs4ekFGdX8CVHginuxJnHVOLvFyJ01s=;
  b=UrnxmG2t5oCXqvyM0xeLoT9Tim97wYgB68sTNquFNQ1tMRNpodheSjTm
   aU/tvWKZzfExLm5z8ZSbWl2gE6QRXK9ahML9WyCMDn89OJXWrdcUd0GsS
   ck54Ya7PSPpjEfdyXKBOAdvKWic5LL4IWBED2ET47mqtH55qOI+gh0jps
   KHkz1C9D42EWQ1v1cj72nSBzXpafu7N8rWS6STROqldNIBNC42bABwRZ7
   cc3fzKyh0O2oOwD9+R3DxcHiyJdZBJl/xzHZOuzJODkzaagJxOoC5gavt
   CFZfLNmN6W04sFQj9zB5Lr9+VnX/enr9vVSiZtCHPXBVdVchbSzOFDdEq
   A==;
X-CSE-ConnectionGUID: /n+9SDBAQ72NN90JnFSGag==
X-CSE-MsgGUID: Nj9ivLqrTUa3gG/OMC1Gvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="79625991"
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="79625991"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 00:56:40 -0800
X-CSE-ConnectionGUID: TtOuG+osTcigg4WByXtJdg==
X-CSE-MsgGUID: TjMjEjtYQduqVaWBqtq6vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="202538619"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO fdugast-desk.intel.com) ([10.245.244.83])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 00:56:38 -0800
From: Francois Dugast <francois.dugast@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Matthew Brost <matthew.brost@intel.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francois Dugast <francois.dugast@intel.com>
Subject: [PATCH v3 3/7] mm: Split device-private and coherent folios before freeing
Date: Fri,  9 Jan 2026 09:54:23 +0100
Message-ID: <20260109085605.443316-4-francois.dugast@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109085605.443316-1-francois.dugast@intel.com>
References: <20260109085605.443316-1-francois.dugast@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

Split device-private and coherent folios into individual pages before
freeing so that any order folio can be formed upon the next use of the
pages.

Cc: Balbir Singh <balbirs@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Francois Dugast <francois.dugast@intel.com>
---
 mm/memremap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memremap.c b/mm/memremap.c
index 63c6ab4fdf08..7289cdd6862f 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -453,6 +453,8 @@ void free_zone_device_folio(struct folio *folio)
 	case MEMORY_DEVICE_COHERENT:
 		if (WARN_ON_ONCE(!pgmap->ops || !pgmap->ops->folio_free))
 			break;
+
+		folio_split_unref(folio);
 		pgmap->ops->folio_free(folio);
 		percpu_ref_put_many(&folio->pgmap->ref, nr);
 		break;
-- 
2.43.0

