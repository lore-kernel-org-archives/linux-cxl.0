Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A002035294F;
	Wed, 25 Mar 2026 06:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774419807; cv=pass; b=dnRmrOhdop6vFYfr0UPNy3VCttIXZIx/uYwSS+gyXW1HT6S7yKUo1OLMYXZrLqXMlZwjzGPKEm7adSAB/5yJ3NHYEalNhHG1wYNS07AX8q9VbIv3wkgi467m16SuuwR8KZSk0QXzPQ0eBCJphje9QdpARPKnjB4VeMsjgQwKn1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774419807; c=relaxed/simple;
	bh=ka+L+NmENH6mMYc0s+Vexxh5j+m+jH0VhMa9DrY4v+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OzikiGVp6SontDmNOi9vMIurRGNr7qJjr2lx6MmgJGDLuMwYQVtB6btkZC36zbcD21/3PteH/gzU0Ak9Vi7drljKIjF5irPf08iDGePs7y4vvZDoJKTLLprFbP6pmsFEsC3gQ2bh9byHliZH0lGOK+1A62FeiWM1Mu7Gj9Ac33w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=pTOQO1VR; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="pTOQO1VR"
ARC-Seal: i=1; a=rsa-sha256; t=1774419669; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ESVd4i2rDU3X8pjd+Mjt0Dbdqbc3n279ka4ZNhahyO4G3qywlXKw9XyxqKVoq8ulT2wqcmgNSJ3uAM2HeWctlAk8TPkCUog3x2247tfpwZYpyddE/plX9FlfXuDYgURSKz3sMa/2lHq7bRj3kYw+vvqEAnGYWfTteTA+wxpajMk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774419669; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xj6IbX0jdjOzXcy7+49WQ4813NeLRgRq3AXpibPQd5o=; 
	b=mX3DzLXJvWcnwdLQGV/60+ndacSvxgjEnYA3lT5HKLMzuRweWlv/QlH3Zin/SMkSZFT/NGYB+hKMgzaawTM6f3ZBgrMkVJ4rZYWj+4fJMrzKbhW8Sv+nmor0kxZrBFSg7Uu9jAV2V5gEoUWVgP+K0OXmxZA71BM00gb666IpIbM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774419669;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=xj6IbX0jdjOzXcy7+49WQ4813NeLRgRq3AXpibPQd5o=;
	b=pTOQO1VR5k8KxrC+5K8wv58J/t2witPAeVtYJUIhE/WpyWtpJx2CE3urMY2tQvfQ
	QUmnhMCY94Zz3z7Jb1H28SY/BKq1QbnKTPjY+eX3Wv1+QxBbmnYInjyMyvnV1JfMSvN
	ceOIyyhsU28ey6xdZEyEhsQYZm2ML1mxJrlaLYEY=
Received: by mx.zohomail.com with SMTPS id 1774419666952985.4214995192101;
	Tue, 24 Mar 2026 23:21:06 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Kees Cook <kees@kernel.org>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Subject: [PATCH v1] cxl/pmem: Defer nvdimm bridge attachment failures
Date: Wed, 25 Mar 2026 14:20:47 +0800
Message-ID: <20260325062051.3777413-1-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

cxl_acpi is initialized before cxl_pmem registers
cxl_nvdimm_bridge_driver when both are built in.
__devm_cxl_add_nvdimm_bridge() creates the nvdimm bridge
device and immediately checks whether a driver bound to it.
At that point the device may already exist while the bridge
driver is not registered, or has not bound yet, so

dev->driver == NULL

is only a temporary state rather than a permanent -ENODEV
failure.

Treating that state as fatal makes cxl_acpi probe fail, so
the root CXL topology never becomes visible to userspace and
region creation later reports no active memdevs.

Return -EPROBE_DEFER instead so cxl_acpi retries after
cxl_nvdimm_bridge_driver is registered.

Signed-off-by: Li Chen <me@linux.beauty>
---
 drivers/cxl/core/pmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index 68462e38a977..a213eb074814 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -149,7 +149,7 @@ struct cxl_nvdimm_bridge *__devm_cxl_add_nvdimm_bridge(struct device *host,
 
 	if (cxl_nvdimm_bridge_failed_attach(cxl_nvb)) {
 		unregister_nvb(cxl_nvb);
-		return ERR_PTR(-ENODEV);
+		return ERR_PTR(-EPROBE_DEFER);
 	}
 
 	rc = devm_add_action_or_reset(host, unregister_nvb, cxl_nvb);
-- 
2.52.0
