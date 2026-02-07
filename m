Received: from sender4-pp-o90.zoho.com (sender4-pp-o90.zoho.com [136.143.188.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19159256C84;
	Sat,  7 Feb 2026 13:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770471362; cv=pass; b=toXslKrX2auiq4y/LKZwzo9VQT6WH1wfFVCzRspki4gic5MRFUYAX5mc3462HK1upomjzbhqiJlI4CEIBvbHsFOtgOJS2LMKLH6tgj3G90BQ1AnCxJ99JGCT4xf2zQmfRI/8QrvrB26MMWmDcuqWpWJurbPdXLIF5JJ2cFT9vxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770471362; c=relaxed/simple;
	bh=Wj+Edtse/Lq3KveIVEuMg/iVoXInkhtSSqk5bsZ7TOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dT+nxtS5qAyM+kBfmuuEa7lAb59ArWRVFbOaldbrQQLyZvm9GZ29ELjLOswOdSTfdTTqwoyIUKB23RWytYj9WReWg20EiLxNEnFnaxK/WY8y9TtFy+vHzOnxeQPW85GKrQXw+u4UlbMOgre6U/+d0ettEgXjRZiHlZd/SxBcbE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=EePkxq1M; arc=pass smtp.client-ip=136.143.188.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="EePkxq1M"
ARC-Seal: i=1; a=rsa-sha256; t=1770471337; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SOmFF5jz2LY1uXfEscXS1Jzjc/9QPgehUAiFmQyxDHU/oBgcvZTFg67yrtyAx1stuH/60SZF+xiZZpIq5fzqg7oX4XPb9ZtpEF2XRRh6xkjkB5ZVA9c9yiAtTJApRuI2vWGIP+p4K+rtcDeGLUqt10jpeSR7k+aN+gy/TBrtgHA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770471337; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZmhajZZv4+w4HGyHDMoQMi5/3D+hEo5GfuUZivO6pYU=; 
	b=j83/4gqor5t6qsxambhuWnAismU4ekcc2R7jMFQNUwkK/0noLue73litqMigwhYWiCGm3ImRMmy6Urbwq3BOblXPl3g8JlxJtQ3JdoMtpJ6+cqjeitYCVnWwh52S3LF5zkvjK1r/7U0VvYTlu+J3x0xJ4lSrF/pfNlHiLvWT8gk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770471337;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=ZmhajZZv4+w4HGyHDMoQMi5/3D+hEo5GfuUZivO6pYU=;
	b=EePkxq1MCp9nAn/BaL1yluKymgaQsixSYn1jwG6eYKhqClYKJziYegn+ust/Ig5j
	ByEuVMrSUSEwmEA8jJEt0dbluRIMO7LAPNEcyYBujKZAytA5nOGQPH8YbeNbkmJFevT
	S/Hsa/TDw1EZZPcYtJdyuCV6dSu7O03xsqGjZRjM=
Received: by mx.zohomail.com with SMTPS id 1770471334015567.5376710576885;
	Sat, 7 Feb 2026 05:35:34 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] cxl/port: unregister_port() cleanup
Date: Sat,  7 Feb 2026 21:35:12 +0800
Message-ID: <20260207133512.306128-3-ming.li@zohomail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260207133512.306128-1-ming.li@zohomail.com>
References: <20260207133512.306128-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122c6464dbb94a293f1f6af484c300007f2f9cfbd066e422cbcb7381ad3ab4ae85cce04fb0fd836d3a19bc92204a:zu0801122728b2e2a134c68d7ea1ff6fae00001c8e897e9c58e34661863593b5066d2cd9c68b05d8738d63a9:rf080112326660016915cfc0bc554fe3c10000d463fc9790ab552adc09aaf623cfc23cfe6bd0a90bb1c94c568b1d08e37e37ce62a14c87:ZohoMail
X-ZohoMailClient: External

to_port_host() has been introduced, use to_port_host() in
unregister_port() to get the host device of the target port.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/port.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 6f0d9fe439db..5754cffe6b8e 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -632,22 +632,8 @@ static struct device *to_port_host(struct cxl_port *port)
 static void unregister_port(void *_port)
 {
 	struct cxl_port *port = _port;
-	struct cxl_port *parent = parent_port_of(port);
-	struct device *lock_dev;
-
-	/*
-	 * CXL root port's and the first level of ports are unregistered
-	 * under the platform firmware device lock, all other ports are
-	 * unregistered while holding their parent port lock.
-	 */
-	if (!parent)
-		lock_dev = port->uport_dev;
-	else if (is_cxl_root(parent))
-		lock_dev = parent->uport_dev;
-	else
-		lock_dev = &parent->dev;
 
-	device_lock_assert(lock_dev);
+	device_lock_assert(to_port_host(port));
 	port->dead = true;
 	device_unregister(&port->dev);
 }
-- 
2.43.0

