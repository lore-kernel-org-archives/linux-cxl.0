Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8E913B5AE;
	Tue,  7 Jan 2025 03:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736222345; cv=pass; b=TdIVpT4WVnkIt2SWzs2VE1vjFFT2XPziinpq43K+33nCTDXs4cI7ugN8wFAHlXXJaE5O0C4JxYkYUtZ48z8j2ykNhFe3Q9hvhFZsNIxr7AyzaODMJC1ZfOsBGpvE/oQj10CuYq6tKubg+K5hzci/au+ue6/n8tCGaYL4tgxj7/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736222345; c=relaxed/simple;
	bh=XV1Sm6zlbGQZLKWsYSFwTAf2+p//RWPpGqQk/f5Gac4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BqzC45MBTmdJdi72G3enaOLo+7Aq7mRA6qoUZLIbbnuI+t0NghnQjzZyBPkaxb4Ea+aM/VCzsfJ7Quw5EZbWkJ4ZmYuDukBALLVWsEsM7mRi7L8NtBjKAM06K2feT01ze3cjiuQ8a+OVGrQ0YIHWdx+2aC3nUkw19sIO0J7M6RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Wd4LHNkW; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Wd4LHNkW"
ARC-Seal: i=1; a=rsa-sha256; t=1736222312; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PelTFagZT8Ce0BvQapzhgwy5dCmgNwERabRVwa0vwcdIugWdLQsSSAi7BALqUUoY53V/4UWutskbrOSKcM7OQi6awiR4xs2djg6LLKD1VQHidjdHE9v51gpmdQseoctdGSvYbB2LyXEKaagVx4u4GOqCeyHSmMz23gXptOvNq7A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736222312; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=M2mXgobPS3ES8nLPgPspoAhdDoBwUuAj8Zp/1t1ZuSI=; 
	b=RPIgqXY/SghI8jUj8bCdFEkxoYj9zGviLY+33S8yBpcxLSIde6KM8EtnHflq557uafPEKlXjy4PucucH5jTbqTqgLLMJwBU9CbgJjhW0oYDjXIMnatmrRycsZGFs/u484hRE3+ZNwYFpWUwlGGaN84xrLePQmOk0PK8UpkSiijE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736222312;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=M2mXgobPS3ES8nLPgPspoAhdDoBwUuAj8Zp/1t1ZuSI=;
	b=Wd4LHNkW+vQOdHo3p9QHZ+QR1PZGqQMAOR3jBpNhVCoYXyZgtAi0SMcmx5cQPbTH
	YisDB3iYNW+oU7BZHT+LTLrXVVBzySIrRlbk0e3adxYhglQlH4/z1LCYQDNb6A/0OxX
	TKg5mLC2nG4z20XFe6F2VSbQgtO6pNSN9Jtnjdgg=
Received: by mx.zohomail.com with SMTPS id 1736222310497623.7130777416584;
	Mon, 6 Jan 2025 19:58:30 -0800 (PST)
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
Subject: [RFC PATCH 8/8] cxl/mem: Adjust cxl_dport_init_ras_reporting() invoked position
Date: Tue,  7 Jan 2025 11:57:08 +0800
Message-Id: <20250107035708.1134954-9-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107035708.1134954-1-ming.li@zohomail.com>
References: <20250107035708.1134954-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112273613dc2fa3c07da19fe930d70000a3c615016a20dea8f05d19ef791ed4dac6877394e8be151f91:zu0801122744e16cdb5a5e17798d1f6d5000001d34f13629b2506cdd426258d2e3c1cc7f01454deb8cea5765:rf0801122d850d40504611565227a893d80000869a4f3b15f442da3b1e631244bbad6e2e0d8bdb1c25c989bd7ecdde68bbac:ZohoMail
X-ZohoMailClient: External

component registers of endpoint's parent dport is set up in
devm_cxl_add_endpoint(), so cxl_dport_init_ras_reporting() should be
only invoked after that.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 39da99a4bf4d..73b5a28db8cb 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -79,6 +79,8 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 		return -ENXIO;
 	}
 
+	cxl_dport_init_ras_reporting(parent_dport, &cxlmd->dev);
+
 	return 0;
 }
 
@@ -165,8 +167,6 @@ static int cxl_mem_probe(struct device *dev)
 	else
 		endpoint_parent = &parent_port->dev;
 
-	cxl_dport_init_ras_reporting(dport, dev);
-
 	scoped_guard(device, endpoint_parent) {
 		if (!endpoint_parent->driver) {
 			dev_err(dev, "CXL port topology %s not enabled\n",
-- 
2.34.1

