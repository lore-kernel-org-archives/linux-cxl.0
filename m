Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F4E20010A;
	Sun, 23 Mar 2025 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742722460; cv=pass; b=q3sO3OtaCPBPFW1PLfPXHMiH/XRDVaJcOfD90hs9/DUl03frnYn8cILw8of1U6xTo20uw0AHomv2zXFBiXTfmVlLyESgloj19sMkfsszdiKX3yBbmryT5NkvUzJOaeyAWNIY6s+oLWcTbz4v/M0nrX+kPVqm/3+MD5liqKWzrjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742722460; c=relaxed/simple;
	bh=ShRA8ZBoRFnVe0Wl7B/SZm4cKibBbHPKuwpH1fR39Mo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pEN5Rz6X+/A5BClXjuvUy8WXKbt0p/eM7jTJadNJBwOkWc05NfwIA99VDQyy26pKZyHypTESSPIiIiMaLI16B8Ix/WV8BxAbriZOYn5tZqkbMgOy7LZr2I3eAJJztme87zWu+jQ9qmTT0QthJK3PO4d7MX+18WwcZt5JPo4tDm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=VsPSyc/z; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="VsPSyc/z"
ARC-Seal: i=1; a=rsa-sha256; t=1742722309; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cbNvGfxBKw3j6fDb6u44jRtg2QyJaTnamxrQWs2J9OCvNxjwL0ueXQ5vKpEeTvVhEMYP+BRw5PtJAZpkCH24sifI2hLdzFiEX7VGl8BjW+vzNrVk6Y4LHmTzzld9vYANHl3azyhsgLshnfomLokKHa09qAvJlRgQC8JwU5ADWEg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742722309; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZLARjwAi2392p8qFoWGnePnOKEDFNhB7tQ3qGWk+kKE=; 
	b=Y/R9Rxzg3pX52JY4+BEGy9Ph+0ul4MlqVmRd6oICOCpNeD34PzGuGSLZIvNCgHbiEwqjtdPBjP5kW6jbXLsCtdL9YWYpSd7TUvvJVJDmTo4cRaGcWRx7NKJXzd6/OoOhsrLlA2Ik4U2RAQEOU0tFfOK1676KRwYVXhPLHHNAOoM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742722309;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=ZLARjwAi2392p8qFoWGnePnOKEDFNhB7tQ3qGWk+kKE=;
	b=VsPSyc/zZFU7Fpaj3JLnE2wD3mxqU3JnUwUEn43/lxlu0gtbkEP0pbR/gvyAzwd/
	jxfvPw3G3T6FHeAm2YHpCYY8htSV+iA9WvV2502O9sNCNztlAof28hZVPWnem1Ta37C
	CsW1fXioG6I6PJks5An7dBmguVy0sTfHIwO24fvU=
Received: by mx.zohomail.com with SMTPS id 1742722308773820.132550490878;
	Sun, 23 Mar 2025 02:31:48 -0700 (PDT)
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
	Li Ming <ming.li@zohomail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 2/3] cxl/pci: Update Port GPF timeout only when the first EP attaching
Date: Sun, 23 Mar 2025 17:31:09 +0800
Message-Id: <20250323093110.233040-3-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250323093110.233040-1-ming.li@zohomail.com>
References: <20250323093110.233040-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112272c91780d6c5df78b68f6195f00000d8cc653897a034d35ae8cb727c3355149c8eb984fcbc587e5:zu0801122770b2788d9b14d8742fed872f0000ea9ade01511b63d93c673046a85b8c558303d8404a7772c6c4:rf0801122dc6eafe463c03ceba032e5d93000090526bea9f4fe57b589f3d522acae1d80418a58ff590f9b44663410d5f2f21:ZohoMail
X-ZohoMailClient: External

update_gpf_port_dvsec() is used to update GPF Phase timeout, if a CXL
switch is under a CXL root port, update_gpf_port_dvsec() will be invoked
on the CXL root port when each cxl memory device under the CXL switch is
attaching. It is enough to be invoked once, others are redundant.

When the first EP attaching, it always triggers its ancestor dports to
locate their own Port GPF DVSEC. The change is that invoking
update_gpf_port_dvsec() on these ancestor dports after ancestor dport
locating a Port GPF DVSEC. It guarantees that update_gpf_port_dvsec() is
invoked on a dport only happens during the first EP attaching.

Signed-off-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Davidlohr Bueso <dave@stgolabs.net>
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

