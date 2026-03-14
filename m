Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549E4248F47;
	Sat, 14 Mar 2026 07:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773472242; cv=pass; b=Ey8i66xP4Gypwf4QVPnAfDtf9wKLVoyxDz1Grw0FN5MnlIvL7HwlNe0gBKapq9pPz+ch5zB/v+QTdpupoGDZkFbb8R1jgjcXVwto1SWOGE5SDzJD8y2JguFhpN0lZ+AI5U57qrhuxrBff98EEOg2KLRaIlUuq4pz+5Dcm1DGl6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773472242; c=relaxed/simple;
	bh=NW7dQqdAptqS0gVRYu4H5M0FqfuCUNK8ccC5vmFcZ9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GXgdV7lzL+Wr3g0xsRjWqiHeEwjyMrxHBhnhugNm6fSVFgCGe/J1sSGL/+PB90SFJf1Nj7shX1YfPZCxPQxC+HTtnfc8LzNJfwC04NycmjwtEN/HJGz/pSM8D8yZX/mSUsYejbsvXpogucqjCbSxCVKRB7sInBobiTXwgjfXz2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=fNqu6sWY; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="fNqu6sWY"
ARC-Seal: i=1; a=rsa-sha256; t=1773472033; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bxTgp+U1cYUzCxsoV+5LFnas+/WRMWXbB/WwXbeUKJP2Wumu5PCENJyfsw64daX1j/Usuw2APk+0zaUWj6vHMUhmhgEJkH6INnTHobvN91ukbBl4PVGCfi+PLZ9Kyj6fdhaOdNvAlS7w092rKS7psvQVlE+ClR7mAo7OWkKlRgE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773472033; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CqKW/toPt1wNfoYaxL/9v536eeycxjvx8DUPN+FlQ/g=; 
	b=YseOGEqEghJh1UoDApXMv3fUL9SRKq6Api00eh8hN3OrLvK896GpFvAJ4FYvlgkGHqyNXRWgecSHnZ7cqu2caqTfrfAGV+XcnX5Gc4fw5+0hFf6nhJ4bSYznZ+tTWTQMFLVjfNxpu176mxovSiH1/wQIwckCjYsm0GEPm11yOuk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773472033;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=CqKW/toPt1wNfoYaxL/9v536eeycxjvx8DUPN+FlQ/g=;
	b=fNqu6sWYc1OHL80hRDi1o1ryYhxcUd0Jakw4C1dkgTe8ZaZO+7qktA6yofkuC113
	3yTrxOvBGs83pxueYSE1ayKhklp5a9mKwVBMI/6Y3j6HC1/V3PJXaLrIdza1hGD2erP
	fuw+mZEIwkpc+LFuWNPyHvZuGvg8kGsDg3zS2As4=
Received: by mx.zohomail.com with SMTPS id 1773472030594510.5995389105003;
	Sat, 14 Mar 2026 00:07:10 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
Date: Sat, 14 Mar 2026 15:06:33 +0800
Subject: [PATCH v2 4/4] cxl/pci: Check memdev driver binding status in
 cxl_reset_done()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-fix_access_endpoint_without_drv_check-v2-4-4c09edf2e1db@zohomail.com>
References: <20260314-fix_access_endpoint_without_drv_check-v2-0-4c09edf2e1db@zohomail.com>
In-Reply-To: <20260314-fix_access_endpoint_without_drv_check-v2-0-4c09edf2e1db@zohomail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773472001; l=1337;
 i=ming.li@zohomail.com; s=20260210; h=from:subject:message-id;
 bh=NW7dQqdAptqS0gVRYu4H5M0FqfuCUNK8ccC5vmFcZ9U=;
 b=ww9ZpRC1Mbgm1Of8nO7h3Z5EDQNImBh9q8OyOJEuLyyqjDur8UhGp7z4ZiKG6ryfu0QHPKIVf
 b8FpBAYxWq3BHmMcUsWkwetMLNeDhILcrFkLGq+9Ms0c6M83ltCvJai
X-Developer-Key: i=ming.li@zohomail.com; a=ed25519;
 pk=JfhrdHjyYJMXt47Hy8d/fsqZuhGPD4Z3whV5lTfVvhE=
Feedback-ID: rr080112282abbe5bde50ad67bfa29fdcf000024033e84f2418389e844768c1b14a83f87c6eea2aef437987e23:zu08011227c1daf4087b0bdca627c5885500001d81fbf71559b8901613e13761d8e3176369fda8d089b27077:rf0801122dcf13f46313b3b6a1ddd8aa910000db282683c3f9a0e26083c6552a11a5e96d07d41334d09415422f9660bff90a:ZohoMail
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
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
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

