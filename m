Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCD2311592
	for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789763497; cv=none; b=mrqS2UAslyFF/ONsFH2bIdMbZKTQ5/lMPCpZzAkG0xQgpvfxSHNIe+ayMWxkb9Fa7ocuIV+oohLHtheCGkqhKT8jrWLh7rRyP990D24Y5j8dmmAkMft4P6QVj9aan8OY5dwkhjNS0BdOJYZnIKfFmSvcGlI8lczst1TOyidgnOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789763497; c=relaxed/simple;
	bh=7wnneYPbMznMF8HPMv3YViTjG24qrOptqJejm9L45Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCoXR4awKuOBCqUGRwZzUWqTydSth7pEs/u+/MRukotXNniiFI4ByQRsud4zU/x0+bGI5Y55/C7PCUA0DxMFuWMde9QMlrBdv1ATzhrueT6i4d565iGZ9o1MfAE+kNSP8XbEoZdDHmbN4AamsPwjeY+0JsuJx6B9nMgN2QBoRB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhNy1oQQ; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhNy1oQQ"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab201ecso1104595d50.2
        for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 13:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789763494; x=1790368294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MvFtz5y/sorv3tIgg5GnEFon3D7Wrah7ryHvIafK0+4=;
        b=XhNy1oQQVDajBjj5RL3VJsl0mQIuUYH7qdLTcZzzLR7UCvGVDwHLcaOcTQuN3jjduR
         blDJxrzvRq1i5n5PJfYmyoWfnjK5SO3Id+ItVBQY42DQkzS4NFFvEajqhjlsTZKWZw1C
         CyzGkcEMALypRyzkBoSsgIuNCqMdPa34TEHaRfc/6NGwuOsQExWtYNKRnQRwjCwtpcTF
         mCskhEDBab6s4wRfdn2PmvbSajckmSLv2gUivde4edA37lMq3IXq6BrRZsYPJhwzkDgM
         eUWG5MSXvoLcjWPFhwbq+WpbA11Gl0/yktfqczOHlTCvnsTpnaFsf9CSfkpyn4ZTfqe4
         IWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789763494; x=1790368294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MvFtz5y/sorv3tIgg5GnEFon3D7Wrah7ryHvIafK0+4=;
        b=M1ae/hnsCkXGbov/ajCGK5M69VH4c7zl0QU0GmFzxZjYXd5JZ25HG53Co89cIiNdj6
         B0z1ZC8XN3IVVEZf35tH+e1htHzG/KIUwB92nDXA9NOHqrL9EawprCcs3EbF+wzx9uWl
         nIY++8+OYnuYQfWcdej9uzJFmE1AXGYjjGaPF+XTacSsMxGcY0fNugzdyZmgSF0Kmvi/
         ziJnw0Qb979D1tDbmiTKJkZ0KphyFROxvYEQn3oWe94jSHfYtZ/twfMrk4MGgJ1Lzk7g
         gWT+lZKqn9S3Ktd3E5i1ss5deupAvzq9/LY9jXvy+VJTDQ3vpmGXKYlmA5fTPAJRpyCc
         cyug==
X-Gm-Message-State: AFuF++nZV377kH62RGh4IS+TAy2zzsnrs08u3UaLc6JuYI2GkgYYDO4k
	rpMr/wqbzcBlK3ahe1zVI5GFe9q4gykTxmwWcBkpl/07+h29Urx7F3YyjZYDYw==
X-Gm-Gg: AYBFou2ZxXd9Muq0lkRl4G2cCw6Cgw6Wc4n2Ur8O2t8qJkS6FaaSk3QLIun2r2DU+ml
	omH+qbbEKcpAubjYKimuQ+UqTHr72e8NWKAyPAb5wmTvTmNy51gDe7maAUTfFhCw8kwRFT/57kH
	1Lyz85uZ84dbsfX7CYbKUM2Vd/i5x3f2y/77EQg5CSbYUDRgafvxMaA1Hu8FdyHd0hh8R9GXeSW
	TT2CpFn1XtSB2BLCRNSt+GvvVChW1GE2jIthfyaw/vUbnxdN07Zg8FPhv2LYXDgBK59QOd1upUx
	AHJDLzzdvFzFUe/+IwR0M7fhNTFH7UHzUKNSF3Nb1kk1Vh3q8iLDgIhV4IWScKrLb9i4rnIVgLg
	Ad+5/5idsQpKB59kVXCRhK4qI3715+I4gqFAGncs3nhyoYcyQPJPsMTsmdvd0tTLY4geJsWfaVe
	L6R7s5oGGrmgf3a4Byt9EOCJU2PQpBdub0xNo/qG2JxZ38CDuK20NSS5rH9s+kwou6gDfMpBzTw
	OtjyKkEHxMNvcKP7Od4NpWzDRpo6lXO5bwznyW4JRaNvw7fcQ==
X-Received: by 2002:a05:690e:bc3:b0:671:1a33:6c09 with SMTP id 956f58d0204a3-6717fe06dbfmr1036665d50.79.1789763494499;
        Fri, 18 Sep 2026 13:31:34 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67298f64b74sm427240d50.1.2026.09.18.13.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 13:31:34 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Li Ming <ming.li@zohomail.com>,
	Gregory Price <gourry@gourry.net>,
	Richard Cheng <icheng@nvidia.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>,
	Ira Weiny <iweiny@kernel.org>,
	Anisa Su <anisa.su@samsung.com>,
	Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Fan Ni <nifan.cxl@gmail.com>
Subject: [PATCH v14 4/8] cxl/events: Split event msgnum configuration from irq setup
Date: Fri, 18 Sep 2026 13:30:13 -0700
Message-ID: <20260918203049.7273-5-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918203049.7273-1-anisa.su@samsung.com>
References: <20260918203049.7273-1-anisa.su@samsung.com>
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
Tested-by: Wonjae Lee <wj28.lee@samsung.com>
Tested-by: Junhee Park <jh9934.park@samsung.com>
Tested-by: Heesoo Kim <habil.kim@samsung.com>
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Fan Ni <nifan.cxl@gmail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
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

