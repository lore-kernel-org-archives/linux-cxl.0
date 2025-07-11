Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D408625;
	Fri, 11 Jul 2025 03:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752204285; cv=pass; b=IxCWMErgp8egyABw0MQsm+xDPuUFaaWYsYLy7h7LptFigtp+v2m88kSPQziIWQKZPDBl+Xs20eSzlfHX7dVcmYog/iAv2MkyfeqlLlAOpKD7invFrKZy/yCWMrAn1Z5eXmZ+AK6xspJ5Cs6pYf7R5bX+mt9ip95yMAnRtJytMeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752204285; c=relaxed/simple;
	bh=Oi0WThDTz7oxscDgMG+B0X4n0CVWhgp4F/CPSsJUgIU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O7V7Xu6G6Uq+zW/7ah9vlTlfN7ADhGlGmg+CfyYjU7hT6Y4HwSuNucFEOD1S/vxvy40XlR6dMgmCM8IW9WriMiLQrCFVCoBCZyx1ClIxWgIpdHKz5nyR3XnfE2slvKtmoX1+rucrxJNXKhaXp52Ppl6xrYlRtCccj+/mP7PURuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=RxRlDaj7; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="RxRlDaj7"
ARC-Seal: i=1; a=rsa-sha256; t=1752204266; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bdJLLbh7ngA/bsu43q/YLw8NEkwI++ki4IUkEh4J9mQgNeym7MySGdALybVHs4MtiPy/nlmM6UXJSYnAY/g9QCqNyVQrRQ3L/nlW5Adsn4n8qJAA0WV6w5S0NrbCyGgV+VwlXKs1p9k2H0wQPRg7oeCte11StoeYEQ+LGPdQhww=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752204266; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oOHKoalO8btsJD+VLTbNZ0lY6t1aKJ1Pwn43u186p30=; 
	b=SNCUlFAnw67QVNJh8MGDgzqpyrVg+MxKVSbxJavIHdBZaZAkV1gPC6CoR3wh2oYDBf5CuYvnDTp44M2mAqgYOXlUAQDQtv7tbR30gjaoIcM0DFp5aJ6Qd3AdKlWsIy9mMgl4fiR9Ii5NihMUkUwSGocaZJWFdQsVmmIAPt7xq4I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752204266;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=oOHKoalO8btsJD+VLTbNZ0lY6t1aKJ1Pwn43u186p30=;
	b=RxRlDaj74RDikg5EY134JQ0yHKz/ckHT6+bO5hp3qViUCMCcV2Hyfom9NVRfqZTI
	PI86dhf2+5WJcv1rWFF+WT66YpWXQHgirmOqIFCiK8z0bAoivZnRKHpOgOZxB7fGzZ/
	JDN47krq8PllFjaEVALe8B/79OiLZmg6eLMdkZ58=
Received: by mx.zohomail.com with SMTPS id 1752204265443223.6339959818855;
	Thu, 10 Jul 2025 20:24:25 -0700 (PDT)
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
Subject: [PATCH v6 0/3] Fix wrong dpa checking in PPR operation
Date: Fri, 11 Jul 2025 11:23:54 +0800
Message-Id: <20250711032357.127355-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227b5e1f2de3361f710528e4ce000005ff400629c028dc796abe63bb3ef9fdd1502cb4272e171707a:zu08011227d48ac31883290a1465d603f90000852c9f31e17b749ef7f1b71abdda585be07c9b810734a796e5:rf0801122d47855e27d70615e71b7455cd0000f037de2bef5ba9d1c6fe941bbcd6e14bd0670f699907f51f13697df6f99841:ZohoMail
X-ZohoMailClient: External

In cxl_do_ppr(), there is a checking to check if a DPA is valid, the
implementation of the checking is check if the DPA is 0, if yes,
consider that DPA is valid. the checking is not right, the correct
implementation is checking if the DPA is in the CXL device DPA range, if
yes, it is valid.

The patchset also includes another part implementing a general helper
function cxl_resource_contains_addr() in cxl core so that cxl drivers
can use it for all DPA/HPA/SPA availability checking.

v6:
- Fix reviewed-by tag mistake.

v5:
- Reverse checkings order in cxl_do_ppr(). (Alison)

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

