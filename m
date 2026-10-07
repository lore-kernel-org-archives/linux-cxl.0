Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636412D2381
	for <linux-cxl@vger.kernel.org>; Wed,  7 Oct 2026 20:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791404330; cv=none; b=MdVbDxBMeSjbZ2t/9VtY9MzY7WX0uzADCIiCAR/Uc0sHZcGB8LshQXGrd/hbUySXuCIsWM/tvE/eLcjMDrMBSupLaklyaKsf6s+viZ7/j1cN8wkGvMmcoDtcOYadEJlM1EKPRNF4syAPGTq+cc4Byiut250qpVUtRFh693/gNsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791404330; c=relaxed/simple;
	bh=1tLVbNbDl7HUDxUPwAgwX4uqgjQuBujm+60EP1X9Ssg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIR/5D3gnunLvKu1jAKa4/dsagG8FGOVe6Rp5cMECFcicaAKX3MDjS3hNJlnxmRUVovVGppErAk8R9bF9j19VmKJzqj59czfrRBpGynGzG6HBRSO3a6dWzStMmZBVWk9Ti9/+EhVewrOCWf8YpjUGiyFY4uWkoOVt9QA2/nfqkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0sBWnWM; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0sBWnWM"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so20553a91.0
        for <linux-cxl@vger.kernel.org>; Wed, 07 Oct 2026 13:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791404322; x=1792009122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=98oKjZ2K1yRfCkrJS+595quXtp5aYGeP0oglAScHwVE=;
        b=j0sBWnWMRx9RhkDjFPz5MoM5g+/5bud6df34TfmjM97b2YkxA7s/9MaNcq9UK5dZg9
         pt/c6G++i49wREwgOQ58eEy2QxV2sHA+bGr4qkeNhrOD3bqcp0q6eZ5BCawAqrR/qnP6
         +YDb7vlAqWtNjiZrZ/u8EjXENaBl3cH0/nf2vXFn7RGrkP90sn/dnIiWlaOV9iy4tp8p
         sQ6xED1xL/HYXrUOdhwo/63V/pEoIGLEuWKfO9v6QIlOCABqy1gwxlhZyyrQ7HuYSSp6
         R7P7Je7a7+f9fcZ3gR4npy6rpjm5GBcJTr8zUzP9l/Dw2MjrpfUK60wiuwrGpL/fZ46i
         ruGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791404322; x=1792009122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=98oKjZ2K1yRfCkrJS+595quXtp5aYGeP0oglAScHwVE=;
        b=1OqIT79KP8OSstmXf1adlgAOa3RRPMjlV1XvIBiqwjnQpSB1n0cP/grEAGc8+nrDj3
         7eMXcltxqHF+BgWN4MC19CAViA1xLQRQn8kmCDfmYqNlT1QwoSwYySBgnm+tbeoVaVke
         qpDD9fX49BBs3B0FsXRTpKmagcN+zpXmxTPqWK9BjQchIGQK7QJ6c3/eLR+CKCYFirtV
         yAk933D+fhJwJIVtz1nhUK64doXDie4uqeDrYYgPd8Wfe6o8+2+4KtG5pSWHUPtvZHBu
         g1hqVwi0RZRj4ig3kxuVJZJIkHjz960QRryyuCVXHgPVpan/aRDMm61HRGvuq4TGkVj4
         tXeA==
X-Gm-Message-State: AFq9FYJ3E6SOLxLPDCzkPg9sv4VOi20zjN6K02VJMpjeFlfg4XKyECZJ
	MLc7BgOwI3oIMWz2sbJzC0VBDKgSStt5ZBm0782YsXEVIbs728ianvueWLEXAw==
X-Gm-Gg: AYBFou2OJuLYnInL73ug15AQhkhYXGsznwad1LamPAwNBrGYn8vLw7VLQc5WPHSHHAV
	kXvUbGgHJxrDbQvAB9y4PFTT+ldH8gchd1bQrZMmNCLIUOJBfrFpfTDB0uCpYvlhJGhcEMnm7ge
	dN+ZMCNiod7RBAMCjuzNzB7MuoErm/PA1p0reVlfcvDXBnJljsp2qwVM4z969S5E/OdTK9GYh1O
	kOrdoEqPFTNuhb5+fWYM/EP3kyVV/ZVmk6LsBgAhYooO9BEi//5zAXGX1cZY9aKytKPruCOx/5d
	WcVEnLjz8bGgXL8G9R6niiUt9EZrscAbK2CTfb2VU7O3E+0jMMyEO8G9LzD+dK5MMQ6xrSzWbAL
	NSiO/2MfeYJ3xZAL0d1WHJEJKIsd2/3L6lX69Uxc7ksR72EJYE5zPZD5TxmsPG9HWUEtdOToUTm
	CtIKqZVxpZnEgazRxh8AFYdSIZZX2EK2gF+NS3QIVoHm+O9/uFhRerdz67586umSGfFzpRZP0bP
	ySbx/t9RI7dVBVCEcfSSPNYRNhrUdcJ9G9o8DqxQgkCeMBVw5IF2yco8jFXKGrvPXmeSKd6SeKd
	iYF2hAyw0/cIZA==
X-Received: by 2002:a17:90b:2789:b0:3a0:c85a:ee12 with SMTP id 98e67ed59e1d1-3aaedba393fmr139084a91.41.1791404321274;
        Wed, 07 Oct 2026 13:18:41 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com (c-24-19-224-150.hsd1.wa.comcast.net. [24.19.224.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9ff7ab034sm967623a91.4.2026.10.07.13.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 13:18:40 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Fan Ni <nifan.cxl@gmail.com>,
	Li Ming <ming.li@zohomail.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Gregory Price <gourry@gourry.net>,
	Richard Cheng <icheng@nvidia.com>,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v15 4/8] cxl/events: Split event msgnum configuration from irq setup
Date: Wed,  7 Oct 2026 13:16:37 -0700
Message-ID: <20261007201828.952-5-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007201828.952-1-anisa.su@samsung.com>
References: <20261007201828.952-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <iweiny@kernel.org>

Dynamic Capacity Devices (DCD) require event interrupts to process
memory addition or removal.  BIOS may have control over non-DCD event
processing.  DCD interrupt configuration needs to be separate from
memory event interrupt configuration.

Split cxl_event_config_msgnums() from irq setup in preparation for
separate DCD interrupts configuration.

Signed-off-by: Ira Weiny <iweiny@kernel.org>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Fan Ni <nifan.cxl@gmail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/pci.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 2fe9db4b3d86..4867657f5526 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -600,35 +600,31 @@ static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
 	return cxl_event_get_int_policy(mds, policy);
 }
 
-static int cxl_event_irqsetup(struct cxl_memdev_state *mds)
+static int cxl_event_irqsetup(struct cxl_memdev_state *mds,
+			      struct cxl_event_interrupt_policy *policy)
 {
 	struct cxl_dev_state *cxlds = &mds->cxlds;
-	struct cxl_event_interrupt_policy policy;
 	int rc;
 
-	rc = cxl_event_config_msgnums(mds, &policy);
-	if (rc)
-		return rc;
-
-	rc = cxl_event_req_irq(cxlds, policy.info_settings);
+	rc = cxl_event_req_irq(cxlds, policy->info_settings);
 	if (rc) {
 		dev_err(cxlds->dev, "Failed to get interrupt for event Info log\n");
 		return rc;
 	}
 
-	rc = cxl_event_req_irq(cxlds, policy.warn_settings);
+	rc = cxl_event_req_irq(cxlds, policy->warn_settings);
 	if (rc) {
 		dev_err(cxlds->dev, "Failed to get interrupt for event Warn log\n");
 		return rc;
 	}
 
-	rc = cxl_event_req_irq(cxlds, policy.failure_settings);
+	rc = cxl_event_req_irq(cxlds, policy->failure_settings);
 	if (rc) {
 		dev_err(cxlds->dev, "Failed to get interrupt for event Failure log\n");
 		return rc;
 	}
 
-	rc = cxl_event_req_irq(cxlds, policy.fatal_settings);
+	rc = cxl_event_req_irq(cxlds, policy->fatal_settings);
 	if (rc) {
 		dev_err(cxlds->dev, "Failed to get interrupt for event Fatal log\n");
 		return rc;
@@ -675,11 +671,15 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 		return -EBUSY;
 	}
 
+	rc = cxl_event_config_msgnums(mds, &policy);
+	if (rc)
+		return rc;
+
 	rc = cxl_mem_alloc_event_buf(mds);
 	if (rc)
 		return rc;
 
-	rc = cxl_event_irqsetup(mds);
+	rc = cxl_event_irqsetup(mds, &policy);
 	if (rc)
 		return rc;
 
-- 
2.43.0

