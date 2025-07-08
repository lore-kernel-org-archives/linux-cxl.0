Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7461401B;
	Tue,  8 Jul 2025 05:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751951786; cv=pass; b=WL5JSlWpkb8QxWDSLIq49/9ELgqZOoJQ8/JP2UXVJnhOZ3mVo/1qnILmNZG93x3iNc1ND0oeg0hyp0YQYEF8PVh94u8dacGAS54JTVdambDAhUQBcr/ADJIGPShG/an8HM10Y+tp0JTgpTstVMs7hH4FKhycHt0SeUMvweMlr8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751951786; c=relaxed/simple;
	bh=OjdxmwMXDPYXS8qT/V/kbLssW1z+9gXnleRpOG+/CQo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S5n+Y+s+1ILbDb1WW7WaefVDkIgBtKlKlTOzx84uAq2vFO3TRk+MEwroUVCmrFEAd+xlcKe1ZhisYKjd+TkWHIbwsn0k1LZwG8o8DlX4XP16ruDuvybSxPtVqcv9r4p6OzQNFbEGLydTt26pZCVpXdWX/X55SDyISn62dS/lGWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=b2tlNUKA; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="b2tlNUKA"
ARC-Seal: i=1; a=rsa-sha256; t=1751951767; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dE2HONNSv6kh9rPAs0KGUr3UdtgqlRtvxYc27E2YEPo3HqnB8F8/VAd8tlKhoIrEzt2cPRDnQsoMZKmpYMNPbDjpmhg7Klp/XYoCSZXRHTzq2hbZQ0wl2kokswJFsy4zZOc+iXHjbmQ9gWf4ILztSWbsPCO6MQnhxAKGzki5uTc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751951767; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VdJBR3xkVEXpspBmpp+HOAGZXyoX/VnKRvJsfGM6zxU=; 
	b=UOYd9EPbCYTmw22sYi70mo11sRs4jqT3s8rnNuRINKvC7l5cRxt5nHwC3ACmSVXv7JGtkbQy+U7hIcbRXfY5DjJlUjFKTLfZDuNoQvsvG6fdXL0ai/vJA/WRFcpguJSLn1yX8aDXvlNZiNPmH8xgv7T6WZtxNH4+JDYG3VkWkPk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751951767;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=VdJBR3xkVEXpspBmpp+HOAGZXyoX/VnKRvJsfGM6zxU=;
	b=b2tlNUKAX9YO3dzuwlBnxV88xh6D2psGEPVyXQz2YHiTwsN98w7+rA9yV+XhlxPv
	zOpV12cM20njBcqLTmVMwRx1cmgmh7JASVEh2QMuaUcxiqa8XPEl1ufdzqVI/SVC5EP
	oOE843pG0rJU1NwGq4QSGVVuS/L+Mhh68zuPaKM4=
Received: by mx.zohomail.com with SMTPS id 1751951764396422.7352412149231;
	Mon, 7 Jul 2025 22:16:04 -0700 (PDT)
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
Subject: [PATCH v3 0/3] Fix wrong dpa checking in PPR operation
Date: Tue,  8 Jul 2025 13:15:33 +0800
Message-Id: <20250708051536.92119-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122796f1981d6e4e4c7e318598560000a7a08f3b697add15807d1af374d648de1de403443747d99b3d:zu08011227ef1fc988d3702716bc2db9e100009866dc6f911dc8a522968a292cea1f0e8d7d9192f70de509da:rf0801122d4d66c8b88d13ae0ce8b266110000522752bc1b753c5e4137e3da3ae98b643ea7fb9bcbff9400fbcca939e1fc5d:ZohoMail
X-ZohoMailClient: External

In cxl_do_ppr(), there is a checking to check if a DPA is valid, the
implementation of the checking is check if the DPA is 0, if yes,
consider that DPA is valid. the checking is not right, the correct
implementation is checking if the DPA is in the CXL device DPA range, if
yes, it is valid.

The patchset also includes another part implementing a general helper
function resource_contains_addr() in cxl core so that cxl drivers can
use it for all DPA/HPA/SPA availability checking.


v3:
- Move resource_contains_addr() from include/linux/ioport.h to
cxl/core/hdm.c. (Andy)

v2:
- Implement a general helper resource_contains_addr() for DPA/HPA
resource. (Alison)

base-commit: 0a46f60a9fe16f5596b6b4b3ee1a483ea7854136 cxl/fixes

Li Ming (3):
  cxl/core: Introduce a new helper resource_contains_addr()
  cxl/edac: Fix wrong dpa checking for PPR operation
  cxl/core: Using resource_contains_addr() to check address availability

 drivers/cxl/core/core.h   | 1 +
 drivers/cxl/core/edac.c   | 9 ++++++---
 drivers/cxl/core/hdm.c    | 8 ++++++++
 drivers/cxl/core/memdev.c | 2 +-
 drivers/cxl/core/region.c | 6 +++---
 5 files changed, 19 insertions(+), 7 deletions(-)

-- 
2.34.1

