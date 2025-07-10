Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2347E17A300;
	Thu, 10 Jul 2025 06:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752130703; cv=pass; b=fRokXYmdyNNhBz+AKexPCSQoBoFHbBhZYq/ZPutI1Nj/TS1ayUnsLiNBKqA9qMzCAPXdPpi5YWJHCGQBS//q17oZQuYTgBLNbokYem5UvBcAZpHswe7neGkRvf9Mlgo95f9xFFLXAqeu13rhICgZeRVdvDTBh+ridNIb7AXocMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752130703; c=relaxed/simple;
	bh=J6M9ZQjj6f3/XYNYnmF3MA0DC2/s/6r73ad/KcRhwj0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XWqT4rRcqmZjTWQZ+NmypXfnHC3rNy59RWWNDr2k2Q/TPFYOFGb8MGIPvWHvAn04/XIrM721D2y+R0J/oG54VkyUWVsvPLYvsXw1mcfxIjByEV6VWf0NjuueW/aV2bn7bxAD+oZSJ8zPyAr3e21KvFKzqvvs2Cp1Rz+sCNT246Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=DseOOtU1; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="DseOOtU1"
ARC-Seal: i=1; a=rsa-sha256; t=1752130684; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZvE4Uw6E0e3h+2PdI39xvcWl6LEPk4wB99xofuHU5wp/ZqK7+N9CKAW2RClkKTxfFg44APHpLdGd6IRNZbH0CcOiJEyoinCAEDBGyUEWXH5qJx/Am27rA9SS7UrPxh1mjsodfJPNi2nm9ImV92U2OaDpYo74UZEktgWr1FTDI9A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752130684; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=q5k6fYM94q3Oyy8tWJX6HFcvBdl2o1FUCp9JW9sgzP0=; 
	b=VtOSSmqQ69fOh70QLt81pWquWhB08hxQQ28gbI6lkB6VCMdzDNrCTdNZQ0Vew437N3T48lHhWajOs1pBBRXLffminzt8loko5RiRLrm48HgD1WQI+f8KzYhYyxrfUgitW73rLlNuFBOrPQLjE+NB9vuE8o4gaRIUUdkzlCIcDZ4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752130684;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=q5k6fYM94q3Oyy8tWJX6HFcvBdl2o1FUCp9JW9sgzP0=;
	b=DseOOtU167HIXxp4KOncuYjGN8a1mJ1C15SazqjAkE+3FUowdINJvap63R3yz59j
	0LatnONpebG+vW7TyzWWpTxLgLjdNnazZgrhanrcSQqWGRXnL3N6PjYVvcQuQPP4wi1
	iNvIQcewpoSS0b8awmwCraJhcdxoQnp+dc2qWR5I=
Received: by mx.zohomail.com with SMTPS id 1752130682685296.63676004383854;
	Wed, 9 Jul 2025 23:58:02 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	shiju.jose@huawei.com
Cc: andriy.shevchenko@linux.intel.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v4 0/3] Fix wrong dpa checking in PPR operation
Date: Thu, 10 Jul 2025 14:56:44 +0800
Message-Id: <20250710065647.98094-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227cd1d9e06e6a837d7800e886600009d3326ef9514efbd209f82969c382abf081ff28d2db25ce77d:zu08011227f8ef997983b6b96f763bfa3f0000be9722d3411e27e32c5976c866672410bf81d0fef8ac6e35ab:rf0801122d4c22330253b83c163a412d460000168bfc60765283dedb846a185bb3ceec3e06d59b429af3365e2a246a8a9389:ZohoMail
X-ZohoMailClient: External

In cxl_do_ppr(), there is a checking to check if a DPA is valid, the
implementation of the checking is check if the DPA is 0, if yes,
consider that DPA is valid. the checking is not right, the correct
implementation is checking if the DPA is in the CXL device DPA range, if
yes, it is valid.

The patchset also includes another part implementing a general helper
function cxl_resource_contains_addr() in cxl core so that cxl drivers
can use it for all DPA/HPA/SPA availability checking.

v4:
- Add cxl_ prefix to resource_contains_addr().	(Andy & Alison)
- Add impact statement to the commit log of Patch #2. (Alison)
- Add review tags.

v3:
- Move resource_contains_addr() from include/linux/ioport.h to
cxl/core/hdm.c. (Andy)

v2:
- Implement a general helper resource_contains_addr() for DPA/HPA
resource. (Alison)

base-commit: d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af cxl/fixes

Li Ming (3):
  cxl/core: Introduce a new helper cxl_resource_contains_addr()
  cxl/edac: Fix wrong dpa checking for PPR operation
  cxl/core: Using cxl_resource_contains_addr() to check address
    availability

 drivers/cxl/core/core.h   | 1 +
 drivers/cxl/core/edac.c   | 9 ++++++---
 drivers/cxl/core/hdm.c    | 7 +++++++
 drivers/cxl/core/memdev.c | 2 +-
 drivers/cxl/core/region.c | 6 +++---
 5 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.34.1

