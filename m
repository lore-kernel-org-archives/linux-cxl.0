Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7F73B961F;
	Tue, 10 Mar 2026 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158451; cv=pass; b=C1PMOomIY8QymauMfPjTOGFBQ2Jianpgs0n9jU/1sAN4tW+epA8nEhumcVesJcCJIUaVJy+KGxbWukPjZT+rPMJKIB+FO5ugmFu5pdWytXF9v76EmS0l+scG/0OoEde/rVN8Zv0VXpjkaQo4mBFREjQuwYWcpPCX/0VMAtjuM/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158451; c=relaxed/simple;
	bh=gJIldBxJTJwrhD2wi8vJwHvkBYFJIDTvTezNZFVbbus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PQnzUbhdFohpJoQ8+BG0UPvAuxjsQn1bJpVYiLI5CPLuncYfcFW2YdFLPIIJJfxHA61x2LxQP04zm7hxeFBqbLw3zIUquwhf+2c9QpdJDdZcy+fJ0kyq51l///3Hes29zsMQkiWbew2TEpjpvWOkCvSfWRGuGUm9Gs6XeCLH8rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=VaEw4n/F; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="VaEw4n/F"
ARC-Seal: i=1; a=rsa-sha256; t=1773158325; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NKCK4ZytXUVu4VXXCtr6SgpaJU0SWS3J5lLO+lAvqgT2IRzPoIVoZmlqBaVcsmOXz1Pj/KPluM9ak5ROAlPfFjMo8mKY2VTmwA9c9R/msrQcYN9VY6rvv/A1P+LzIniuZ+nrMoFy9/u3KmdKG0PadXnbaH1PGkUf/d28N7rmKec=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773158325; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Pnh5nC8/LJro4qNP/zkN11H/U/xj34QIgmeJ29VYt98=; 
	b=TZ+Fta6aIhLqWUPvIL7cbgL3U8fm5TPLxa8m/1E7hZNBFf4lgol9QJaWfUkoa9unXFB12XJSyigiXUpR4BRjouiY6MguvYm3lufx1KYbih8XX1eULftaYTCw40/BWYGtywqQqbOuIOTbQ1JA8kDxwRKc2ELFGKsc14+O6YFV6Pk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773158325;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=Pnh5nC8/LJro4qNP/zkN11H/U/xj34QIgmeJ29VYt98=;
	b=VaEw4n/FJ9Zxo25PRltkQV1BeMyqA/9+Gw6+FRdLqq9y5pby4b7bvBDotsiGYptf
	0dJL/6CZxYHfPwRTy0Snhn6gmN1A6ty0qYA50FMT6RN6bnSx0odqBYL4scP0QtBcmHh
	NohCkbJ/8DTOg34LiNulz0cI2XwDcOKrgNRkJ53U=
Received: by mx.zohomail.com with SMTPS id 1773158323649820.767978388912;
	Tue, 10 Mar 2026 08:58:43 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
Date: Tue, 10 Mar 2026 23:57:58 +0800
Subject: [PATCH 6/7] cxl/pci: Check memdev driver binding status in
 cxl_reset_done()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-fix_access_endpoint_without_drv_check-v1-6-94fe919a0b87@zohomail.com>
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
In-Reply-To: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Ben Cheatham <benjamin.cheatham@amd.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Li Ming <ming.li@zohomail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773158297; l=1235;
 i=ming.li@zohomail.com; s=20260210; h=from:subject:message-id;
 bh=gJIldBxJTJwrhD2wi8vJwHvkBYFJIDTvTezNZFVbbus=;
 b=oYeKqnw2zbpigLP2RCEfoTymUkQPkL197I7pziy3Ojt/YQ+839KbxeNkDiJCFOBrKDJfgtXzP
 dyXScEsHx8eDxflMD8LC743TL+1BkurepkGwcaNa7gROZkkfmcwJIGZ
X-Developer-Key: i=ming.li@zohomail.com; a=ed25519;
 pk=JfhrdHjyYJMXt47Hy8d/fsqZuhGPD4Z3whV5lTfVvhE=
Feedback-ID: rr08011228499b0d183bc0108b8f2e19410000750d81cab8f9f677f6aed14a55597fb378256618360490065ba2:zu08011227574fc12cb677958417c0791e000024fe5500685b0e90edc25e1d277976831b8f18d9499197d8cb:rf0801122d566657bd15f8dbf36b0f0620000053083ec2d2a51c0ba3a04b8b9a8fbe1ab772b8ed694bf408691fd6232cf820:ZohoMail
X-ZohoMailClient: External

cxl_reset_done() accesses the endpoint of the corresponding CXL memdev
without endpoint validity checking. By default, cxlmd->endpoint is
initialized to -ENXIO, if cxl_reset_done() is triggered after the
corresponding CXL memdev probing failed, this results in access to an
invalid endpoint.

CXL subsystem can always check CXL memdev driver binding status to
confirm its endpoint validity. So adding the CXL memdev driver checking
inside cxl_reset_done() to avoid accessing an invalid endpoint.

Fixes: 934edcd436dc ("cxl: Add post-reset warning if reset results in loss of previously committed HDM decoders")
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index fbb300a01830..a5922116db2a 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1043,6 +1043,9 @@ static void cxl_reset_done(struct pci_dev *pdev)
 	 * that no longer exists.
 	 */
 	guard(device)(&cxlmd->dev);
+	if (!cxlmd->dev.driver)
+		return;
+
 	if (cxlmd->endpoint &&
 	    cxl_endpoint_decoder_reset_detected(cxlmd->endpoint)) {
 		dev_crit(dev, "SBR happened without memory regions removal.\n");

-- 
2.43.0

