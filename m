Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B221B39E190;
	Fri,  6 Mar 2026 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807363; cv=pass; b=OSVzsU5jzB3XVR8b0FwnkoknJEhmVKJbBUX2TinhTMThIVtZgwHiRvn9bGiVqfcz0EuXqUrQ+hglAApZ5O3ZKZlLwU++PGvCC//EfW8O6Xam6E8JXd0FZSShEwMhvt+T9EhPLExEbi0/Mm7KilCIg3hly4PCZEj06dvlVKf1ow4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807363; c=relaxed/simple;
	bh=rZL/kaONOLaFHKbYPhzNhJQybD4qccetMR6G+lvaMGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bb+iSfN3XeRlisWCJr/mdhoEZbfZING9bVjZa+kBnLQukvXhPZ6rWL/rcBmII0q8fM5gehz9fgR2Hm8HAZCMZ0iGwkRJm7zclxaifOoUDMOjckMeqHIUi0Z12VHbZzxUqCbq1pPn57X9nC9VMmMZG4b5i6ZYdfV/UVVGVPjMiCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=UJlbGW/D; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="UJlbGW/D"
ARC-Seal: i=1; a=rsa-sha256; t=1772807340; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=REDNzI064/uwXmzV6pUfKxOfk2rP7Cyzqt/2dXl+XanFqRuYGGFssRe383wCB9qEPUhkqEdq7sUtoKPI5lj24JhmsQM3/wKIi58by50LYCfpemu9una4YzNA7BoQ4MpurC8uIUYU1YmJBORkWEdQJCd4gBIStuaqMmpmuL2wjVk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772807340; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=M/5SDZn4jEYV7tq3cA52zV9AYqMUuN8OmaGUtw5K5uE=; 
	b=Tu8CUbwLWT56PmLL8Zokhghyg48ArEDQ3zecVQPlqzZZWjhod80IKy1NM7m/lQ1paMFYdId8CDZusfiO9o59LL3ODaaBAVEvbxOZqfEufoCgYkepsjKRhYl61pSB26HdMWEmPxxzQ60Dn69r+dIK2FHFBNeZd2vXqT6HaL/lAho=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772807340;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=M/5SDZn4jEYV7tq3cA52zV9AYqMUuN8OmaGUtw5K5uE=;
	b=UJlbGW/DiWCuAJoHrFNRzTtNUjrFU2rBy9k4DSjdstY9Udtsp2kuBPMU83Zua8x7
	gxphjsnFIjfHXp/r7Xb/u2eCBLD8TSZEREEq0sL6QNFWqBW72L+/kuARSReCTQSVh9o
	DWi8IwnfguG9b2pOkBrkfTNLKuAqex9k0vdydnxA=
Received: by mx.zohomail.com with SMTPS id 1772807337622120.20501429254477;
	Fri, 6 Mar 2026 06:28:57 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
Date: Fri, 06 Mar 2026 22:28:19 +0800
Subject: [PATCH] cxl/test: Update mock memdev array before calling
 platform_device_add()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-update_array_before_adding_mock_memdev-v1-1-a1a6af0952f1@zohomail.com>
X-B4-Tracking: v=1; b=H4sIAILkqmkC/x3NQQqDMBBA0avIrA0kWlLtVURCdEY7lCQysdIi3
 r2hy7f5/4RMwpThUZ0gdHDmFAtMXcH89HElxVgMjW6sbrVV7w39Ts6L+K+baElSgMhxdSHNLxc
 oIB2q6+29nW7YG9NBiW1CC3/+o2G8rh8dgActeAAAAA==
X-Change-ID: 20260306-update_array_before_adding_mock_memdev-89673b4d9118
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Li Ming <ming.li@zohomail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772807334; l=2855;
 i=ming.li@zohomail.com; s=20260210; h=from:subject:message-id;
 bh=rZL/kaONOLaFHKbYPhzNhJQybD4qccetMR6G+lvaMGM=;
 b=MLyQGcAxxUhX7xhQr5Qeir2jXsULliDbAv1o8w4bhusX5JB/p8fXvBwm3sMqBbc5X60t8EeeT
 MRxxLVT7EEwB97ezFdT1YvFDJKRsiqyiFgVC+q+YO/NVOF3PCH1TdYi
X-Developer-Key: i=ming.li@zohomail.com; a=ed25519;
 pk=JfhrdHjyYJMXt47Hy8d/fsqZuhGPD4Z3whV5lTfVvhE=
Feedback-ID: rr080112286dbc89f67518f16ebd03679b0000837725691fcb31ec042905c12ba0fbec3ef34646dbd2e28021d5:zu08011227801b9c4c05e946fa458593650000af48b12311f20964b8525cea412cac20804d431400c6a7ffc8:rf0801122df3c91cc07ccf43e10c691ae10000e2114dcd7f5be5a984b719bf23ced7e42d8289dc1b428b891aa2fe65f22ee8:ZohoMail
X-ZohoMailClient: External

CXL test environment hits the following error sometimes.

 cxl_mem mem9: endpoint7 failed probe

All mock memdevs are platform firmware devices added by cxl_test module,
and cxl_test module also provides a platform device driver for them to
create a memdev device to CXL subsystem. cxl_test module uses
cxl_rcd/mem_single/mem arrays to store different types of mock memdevs.
CXL drivers calls registered mock functions for a mock memdev by
checking if a given memdev is in these arrays.

When cxl_test module adds these mock memdevs, it always calls
platform_device_add() before adding them to a suitable mock memdev
array. However, there is a small window where CXL drivers calls mock
function for a added memdev before it added to a mock memdev array. In
above case, cxl endpoint driver considers a added memdev was not a mock
memdev, then calling devm_cxl_endpoint_decoders_setup() for it rather
than mock_endpoint_decoders_setup().

An appropriate solution is that adding a new mock memdev to a mock
memdev array before calling platform_device_add() for it. It can
guarantee the new mock memdev is visible to CXL subsystem.

Fixes: 3a2b97b3210b ("cxl/test: Improve init-order fidelity relative to real-world systems")
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 tools/testing/cxl/test/cxl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 81e2aef3627a..2664c9de8dd6 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1356,12 +1356,13 @@ static int cxl_mem_init(void)
 		pdev->dev.parent = &dport->dev;
 		set_dev_node(&pdev->dev, i % 2);
 
+		cxl_mem[i] = pdev;
 		rc = platform_device_add(pdev);
 		if (rc) {
 			platform_device_put(pdev);
+			cxl_mem[i] = NULL;
 			goto err_mem;
 		}
-		cxl_mem[i] = pdev;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(cxl_mem_single); i++) {
@@ -1374,12 +1375,13 @@ static int cxl_mem_init(void)
 		pdev->dev.parent = &dport->dev;
 		set_dev_node(&pdev->dev, i % 2);
 
+		cxl_mem_single[i] = pdev;
 		rc = platform_device_add(pdev);
 		if (rc) {
 			platform_device_put(pdev);
+			cxl_mem_single[i] = NULL;
 			goto err_single;
 		}
-		cxl_mem_single[i] = pdev;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(cxl_rcd); i++) {
@@ -1393,12 +1395,13 @@ static int cxl_mem_init(void)
 		pdev->dev.parent = &rch->dev;
 		set_dev_node(&pdev->dev, i % 2);
 
+		cxl_rcd[i] = pdev;
 		rc = platform_device_add(pdev);
 		if (rc) {
 			platform_device_put(pdev);
+			cxl_rcd[i] = NULL;
 			goto err_rcd;
 		}
-		cxl_rcd[i] = pdev;
 	}
 
 	return 0;

---
base-commit: 19d2f0b97a131198efc2c4ca3eb7f980bba8c2b4
change-id: 20260306-update_array_before_adding_mock_memdev-89673b4d9118

Best regards,
-- 
Li Ming <ming.li@zohomail.com>

