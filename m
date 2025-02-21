Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6168156CA;
	Fri, 21 Feb 2025 01:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101153; cv=pass; b=Ej09SYHY7aBzNYvmMeJKyhd1P9Y4a7RqxDP+lQKxsftZ6Wkp3Ep9Wcv99GAS4mxOdMgVuurN3d0PVn6OHLmGvotTT+76+7rQpOnKCnN0xWRwIApW0j1VgDjzEbbIdikA/ZNPS6yaSL4JW8xSJXD397aJGJEv4BE/aN1Lx16h6U0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101153; c=relaxed/simple;
	bh=BxKLsz4m6cNejeUryr2DNhsK/1T8hophPCnG1dnP8cY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fsot2YL1zK3N2ZssHwGaJzW6vKb3wU1Kp4B4XTozY25xCxxVnSplm/DRfylH0FheFF4IM210CnLvaYxbe5JOvn5AfRmFzADYLq36YWx1jG0muSnpj9PjasWDH69hJ84dniOxpvNLYHHRIWsILhESsXh3xc4wf0AwgJM5djCW9eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=CnRprxun; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="CnRprxun"
ARC-Seal: i=1; a=rsa-sha256; t=1740101128; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cjzA3lx+1/hsTfQIklsaTUYVxWENSaXbvRUz8Yd1mhpCGFl5lnXs9NA4zHMBh/jq05YyZ5KLB0fzHLu8kz9+IcBwm5sv1f0A1R/cD4PvfGYX2EJenhDsRyT6H/dDyy+RinX6F0K2akJzjMjvaiIWOfEf11F8IQewYt4QHPNUizQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740101128; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8oF8ZEIjicOXrbCZQsPl+9CxN22U5vsjMMwzPbg5exw=; 
	b=JlgGeNftipisKpTaZ6qT4h+6aoOKWC3bQkbs6fSbnBdBqK7DMd8bixRGRfopmXh2MTQPrRbMEAkqUHS5qkSKFx2vQPT/AUIEZAC1ZWPme8X2NUEEgmb9OXQK8P83mLkpktQMksjhXeH2jKxx5TDWZBc3c/Aw9hYPy0UdIeSbuNA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740101128;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=8oF8ZEIjicOXrbCZQsPl+9CxN22U5vsjMMwzPbg5exw=;
	b=CnRprxunYdEDFgYBabfqQmoNU1eqQIYQDW3QTwH3K/P2iOOx+Oglsw6cqCm3MDEq
	gFFEkQTGauNDD/wy5PEcUnrpJw58J/498nAe5prrAKaanv7klk2u2p7LSDykNLfFrcP
	jnIODbs4GJyfkn+fhMinlBTqCJf2Adbn6gVLeC5w=
Received: by mx.zohomail.com with SMTPS id 1740101126623454.0470289865325;
	Thu, 20 Feb 2025 17:25:26 -0800 (PST)
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
Subject: [PATCH v3 2/7] cxl/core: cxl_mem_sanitize() cleanup
Date: Fri, 21 Feb 2025 09:24:48 +0800
Message-Id: <20250221012453.126366-3-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221012453.126366-1-ming.li@zohomail.com>
References: <20250221012453.126366-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227975c16155ec4881c0b8d16fb000060b1f79b1c69fa28aa44949337a925436a2748953fe749e172:zu080112273ccc9047c40acfa0e4e72b380000cf8c4fddca64041d54204cd0098db1857be967023e0c75d258:rf0801122d3cc15077e793fd98e7058ec800004752cc9e06728805b2d0248eefb7dd28da7a85139dcc00d0d8dfabb89f9b67:ZohoMail
X-ZohoMailClient: External

In cxl_mem_sanitize(), the down_read() and up_read() for
cxl_region_rwsem can be simply replaced by a guard(rwsem_read), and the
local variable 'rc' can be removed.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Acked-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/mbox.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index c5eedcae3b02..80916a5b0e34 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1213,23 +1213,19 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
 {
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 	struct cxl_port  *endpoint;
-	int rc;
 
 	/* synchronize with cxl_mem_probe() and decoder write operations */
 	guard(device)(&cxlmd->dev);
 	endpoint = cxlmd->endpoint;
-	down_read(&cxl_region_rwsem);
+	guard(rwsem_read)(&cxl_region_rwsem);
 	/*
 	 * Require an endpoint to be safe otherwise the driver can not
 	 * be sure that the device is unmapped.
 	 */
 	if (endpoint && cxl_num_decoders_committed(endpoint) == 0)
-		rc = __cxl_mem_sanitize(mds, cmd);
-	else
-		rc = -EBUSY;
-	up_read(&cxl_region_rwsem);
+		return __cxl_mem_sanitize(mds, cmd);
 
-	return rc;
+	return -EBUSY;
 }
 
 static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
-- 
2.34.1

