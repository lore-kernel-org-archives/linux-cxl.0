Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8362D20A5EB;
	Mon, 23 Jun 2025 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750670382; cv=none; b=tCAErzbT6IR4Ssg4UxwFKDtswvfMUuO23CLw7gZ4tuPdIx8A6h06C7J+2w4P0bqGrPVOjPBbsEEu41AZBYid1Ijh6r4LNL/jHvxPdIkvgQUiWg2C/s96yVFzhGSmb3Z8GeDkGiDjKEXvSBmHtG+9SrCYMlIhav2Ylnrv9vY3UsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750670382; c=relaxed/simple;
	bh=ji/FAgHI92OTK5f23io89QCG5WvGIIeBGOkDnmo9nuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jZQM/D8n1E9T08kznFn62aB2bfArEt449IYWis2D+pgclkagwNxIOiptOjIKazI4NoW4nl2+H5uUQhUEQ1mcCzVAC+7yubbN5648zwVKELT6oDVXIFU5Z9e5I/KJ0Rqdn7Wbq3KImYmPBiRmOfDS73KBbJ0Tz90pYVB4mVsGajs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLypZivO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLypZivO"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-747fba9f962so2916002b3a.0;
        Mon, 23 Jun 2025 02:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750670381; x=1751275181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W4YJw5XPCMvS5//y1Mmde0UI3BPz61gnsXJcsAlcDn4=;
        b=aLypZivOUPa91pG2I0TFpImeEOfX4BGBt3XZcFTc/mzHF+6LdA616PHLLBa0H8EzHD
         APsVxV+dYyvRvwfOVKiW9/Dr66rUkgPY2gWQuP9v0ZtJ8KBWNqJmn+GAe1lfLpZ2lYbF
         ZGws+hoYzadWTZ1s/5NOC/vsbvTjN8D6zuG3/XF+rqSO3k8X0GNhKQF4QRFBg2lkAU8v
         pWMRzdiQNB7PVIuNRMx7qhkltGonq06TXoX4a8zhHxCvwbY4snawrdmgFTykqcgWrdnQ
         q87ohJ5zcvZpFx7vdJxrCk/9IwIBGnHLnDCMiuOqYtQ6Q7sBppiL0CthvIcUhZ6kLK51
         YUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750670381; x=1751275181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W4YJw5XPCMvS5//y1Mmde0UI3BPz61gnsXJcsAlcDn4=;
        b=iS/MMVwcb9zW1EwGN+Lmq6tpeiQWPOKgVaQzbkLB0NHIPh5RZi20EPqAg9M4QH7cq9
         QJpQ11uH04ROmD9tq3i/gHUyldckkCtXqHc37PSWMYK6dD+hlLcDgoLErfCoTYhIa6Z0
         wGh+tnkoazlLsqBLlkHemvoQQQn2GgFNukQOI0CFPp9oadJuiMQcUU71DC0HxUJi+aAv
         SXCjPipVcYUw6+egIqHD465MkmXMCjDtMoCJMMk7HqtXaA4hqwixy5X00WoclEkGkUVA
         OX1tDwa0gRADOi9l2gonZH1Si2mD4ZsAAowcKMC+4gO/aIhhr9yB8sqt26btf/3Eigsa
         i0Pw==
X-Forwarded-Encrypted: i=1; AJvYcCU9N8bALWimWGxrpN4sYvvX2TdPtez7FOqfB51+5h4F29ojLnY4BIadMPhKXe2sbI42Ft3jTGZN/js=@vger.kernel.org, AJvYcCWSvsrLLHDbyyvSxJ/bGp6JuWZ2yAhtuBM/3ENDAVwalila/+pm5Oy+NKhRkRJ3qKTL8JlOH0IeQw2YXBQq@vger.kernel.org
X-Gm-Message-State: AOJu0YxL9nfd0/O/WzQWcTzISrrEtcu/iJbTbLf8HhOtvWe48WrGC2VV
	/M11m/e1ERa7croMROU5aGWK0T/bYOr5CJdihmWQ2FdQMYYX3UP7A+5V
X-Gm-Gg: ASbGncuR+a6c3r/nuwNBrdGZ9d+BJizFypi1xOxQq13vyid5Eh0K3izmYaiINvDCTZ0
	qM8dEH0Q5PDspHRDUVP+s3M7neZL2uSCdvvkncQeFO9QdGm2HzIOgqrgQGySVbK5wXgwj9ugFKW
	iWVayieRR0mcakvNMYDyAPkaicRn8mkeVPjONRoehSDVZNYW2wgLZDQ1KCQra+uD0vwXQ+FtgtP
	w0hIL1pvZXHV0NkHBEG5F+VvRooqhIvF+yM5kgevvdVSNbdDOLOo9HrYgC31Mag5H2l7PxN7S9r
	3OB0Pv0t+AJzTX61BvszRWxBdyCiIq48MKlH7kIi+qiI0OYXu+XscdxCENJRswHuwBiu8ihl9Jx
	PdYTyCuM=
X-Google-Smtp-Source: AGHT+IH9RLIYNgOIHeCndHNhloZ7mp+IiMwxQJdW8lE1NhoYyXy7rgsiZiOa8Fo2+Ilx9+DVNMOxdA==
X-Received: by 2002:a05:6a00:cd4:b0:742:ae7e:7da1 with SMTP id d2e1a72fcca58-7490f287c44mr14578637b3a.0.1750670380544;
        Mon, 23 Jun 2025 02:19:40 -0700 (PDT)
Received: from manjaro.domain.name ([2401:4900:1c66:8091:47dd:9377:3ab1:4e4c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a6bd5bbsm7773093b3a.168.2025.06.23.02.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 02:19:40 -0700 (PDT)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: ming.li@zohomail.com,
	rrichter@amd.com,
	jeff.johnson@oss.qualcomm.com,
	peterz@infradead.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH] cxl/port: automate cleanup with __free()
Date: Mon, 23 Jun 2025 14:49:29 +0530
Message-ID: <20250623091929.366357-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the scope based resource management (defined in linux/cleanup.h) to
automate the lifetime control of struct cxl_endpoint_decoder. This
eliminates the explicit kfree() call and makes the code more robust and
maintainable in presence of early returns.

Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
---
 drivers/cxl/core/port.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index eb46c6764d20..c35946882b20 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/idr.h>
 #include <linux/node.h>
+#include <linux/cleanup.h>
 #include <cxl/einj.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
@@ -1888,14 +1889,14 @@ EXPORT_SYMBOL_NS_GPL(cxl_switch_decoder_alloc, "CXL");
  */
 struct cxl_endpoint_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port)
 {
-	struct cxl_endpoint_decoder *cxled;
 	struct cxl_decoder *cxld;
 	int rc;
 
 	if (!is_cxl_endpoint(port))
 		return ERR_PTR(-EINVAL);
 
-	cxled = kzalloc(sizeof(*cxled), GFP_KERNEL);
+	struct cxl_endpoint_decoder *cxled __free(kfree) =
+		kzalloc(sizeof(*cxled), GFP_KERNEL);
 	if (!cxled)
 		return ERR_PTR(-ENOMEM);
 
@@ -1904,7 +1905,6 @@ struct cxl_endpoint_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port)
 	cxld = &cxled->cxld;
 	rc = cxl_decoder_init(port, cxld);
 	if (rc)	 {
-		kfree(cxled);
 		return ERR_PTR(rc);
 	}
 
-- 
2.49.0

