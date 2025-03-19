Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEFA29A2;
	Wed, 19 Mar 2025 03:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742356719; cv=pass; b=THUrM+SxPXILO/ZBRWrJhvwjtQ0/Bz6KJG66S0FB3NvfQbB69WKUfM8hyyl9uL23VSNmMfm1zWb4ImA++LmDndwXoR8uyEDZXOe3EmIzvAZJNB2tzRlL6gyDSTnKVd4uR/j8lL9SWS4CEDjjzoHhw66CGx9+l7JxQ4X5fGk54Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742356719; c=relaxed/simple;
	bh=vFl7+KI25G06WB4Ii5RNEppk5Q0CoJfBQKER5TCbsmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Va9MHF1F+JB8dqWXmAEJJ6mIBUH+D3RUX8ZjMvOWl/883szHdBHCOkOsp4wf410lt9BHp9tPBGYquuGFpT7ZmyZFgznqawKvcpjCw/fgdcMd6Y8M02GBzVkuVv3OEL/DVBmJ3tBlGELoc9AnLUf+AFBTnNK6I6iKKdOQPOLabw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=KZIj3mCc; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="KZIj3mCc"
ARC-Seal: i=1; a=rsa-sha256; t=1742356691; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=P6uVoAQbJB3ZdcaPRBMYFn/kWCT09hDCHSittoHKqekbYY8AVgv1+B38VnJoHH3pKi9ICBC175MdyziiMIfkIc2W5ACEW0RNIyl+IV6mFsmIc+9/3nPHmwjMJ/WU+IOrJDvLVNdHmva1+VD2/jucCwXBrIx0zHFqBjYedWn8Dic=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742356691; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wvgc8dYNQQGzr6MTeobR21CbxdNqphd0ruKgerBMsE0=; 
	b=cRze6VqcmbjfvkRAUGqm24zhqPa6t35LWHVC7uGkqWPKzW76tQuad01U4ObjlDF+LrNAkMFzWQovRqOgXnvF9r2JYHdvZlAPWkEz6mgZWj1BXnuAwV4iWzWoJjKOZwrEBoTIKTmnZkZUjFYFX3T2X79/NVQcJFlSkUf5hPwebjw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742356690;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=wvgc8dYNQQGzr6MTeobR21CbxdNqphd0ruKgerBMsE0=;
	b=KZIj3mCc5E1gc8mLn94Xk4CXTsiWj+WRfw4sVv4VkZGkGpwm24RZ5GyaBhfWt99Z
	bcVHQlsk9pN2hYyvhDNLRy2lJdHlERpZhkHWzGD1V69sjuH8pzxnflWR1VQNqhkb1od
	/KG4q2avFUtk0OCzjhxNOrBgnPTB0L/yBuijJlDw=
Received: by mx.zohomail.com with SMTPS id 1742356687352389.5562931049451;
	Tue, 18 Mar 2025 20:58:07 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [RFC Patch v1 2/3] cxl/pci: Update Port GPF timeout only when the first EP attaching
Date: Wed, 19 Mar 2025 11:55:15 +0800
Message-Id: <20250319035516.222054-3-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319035516.222054-1-ming.li@zohomail.com>
References: <20250319035516.222054-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112272190d1ed063520eb051ea6a00000b2b35d83061a7cb2006ba4df8274ea651d9c3eed049a55ee3d:zu0801122730f31dd76230d2ddd3dd5d100000d0ce2a9181d7604d7889208669f267ee784f853ba5a620b566:rf0801122dde59c8ea3c60c1ecaa1169130000b3f10ff269604c17e90e68f8117813e1dd24744bf760d57be212ddb78ec734:ZohoMail
X-ZohoMailClient: External

If a CXL switch is under a CXL root port, The Port GPF Phase timeout
will be updated on the CXL root port when each cxl memory device under
the CXL switch is attaching. It is possible to be updated more than
once. Actually, it is enough to initialize once, other extra
initializations are redundant.

When the first EP attaching, it always triggers its ancestor dports to
locate their own Port GPF DVSEC. The change is that updating Port GPF
Phase timeout on these ancestor dports after ancestor dport locating a
Port GPF DVSEC. It guaranttess that Port GPF Phase timeout updating on a
dport only happens during the first EP attaching.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/pci.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index aab0a505d527..edbdaf1681e8 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1130,12 +1130,11 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
 
 int cxl_gpf_port_setup(struct cxl_dport *dport)
 {
-	struct pci_dev *pdev;
-
 	if (!dport)
 		return -EINVAL;
 
 	if (!dport->gpf_dvsec) {
+		struct pci_dev *pdev;
 		int dvsec;
 
 		dvsec = cxl_gpf_get_dvsec(dport->dport_dev, true);
@@ -1143,11 +1142,10 @@ int cxl_gpf_port_setup(struct cxl_dport *dport)
 			return -EINVAL;
 
 		dport->gpf_dvsec = dvsec;
+		pdev = to_pci_dev(dport->dport_dev);
+		update_gpf_port_dvsec(pdev, dport->gpf_dvsec, 1);
+		update_gpf_port_dvsec(pdev, dport->gpf_dvsec, 2);
 	}
 
-	pdev = to_pci_dev(dport->dport_dev);
-	update_gpf_port_dvsec(pdev, dport->gpf_dvsec, 1);
-	update_gpf_port_dvsec(pdev, dport->gpf_dvsec, 2);
-
 	return 0;
 }
-- 
2.34.1

