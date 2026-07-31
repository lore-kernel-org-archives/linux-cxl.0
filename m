Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8119C3D75A6
	for <linux-cxl@vger.kernel.org>; Fri, 31 Jul 2026 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785487787; cv=none; b=Z0lNmV24knPRfll0n44Tn8yEKNriswmovy4voHPkZR7/nyZkrouY+puQYRpIcJgaimH05f1HHDY5Zc3DT8pAqeCe2C9bFxSgVpSA/0wuIv7d8oy/IEYxwIUFB/wEsZFc7d9+6HO7fkhF4jQgtnmxTmRJ+GUjDvrAtsLeTpQXgbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785487787; c=relaxed/simple;
	bh=hC92LITz7Yccr/XageZqVp/voSi/++OW1y3xLwXgptM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=So7+QqFtaLTLOSqIc3WzK5QfJkhJ/Jcg3Sz/7kg5aQK1ijOx4/K1Lzgq2IwPj287p3v6zjsgAL7JEE0WrPE6enPwcISLZ1VNNI58YffZJj6s/fut2JNHrgP/kYVa11Rcbk8tAwRN8qw/+lAzIO8JPkz1tbmy7aNpmO62EtzP37U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKQ24wyz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKQ24wyz"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc97653887so7500015ad.1
        for <linux-cxl@vger.kernel.org>; Fri, 31 Jul 2026 01:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785487786; x=1786092586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kAapaizwDkinO3KVOW2bB2GwZSS0Ne6+YXNPHio3Jxc=;
        b=fKQ24wyz+aL8EG9Ttomrz0bg6gMq5nYyPW5scUegjQLYwyJfLcJagIFpsnRfJPw0rM
         joItpEeFP9h+tqhZ/ffjJLfUOxQvWcnrRWLg9vDvhUZ7elruaWqFPfPIFg1H7IC9WTeV
         TWaQrV42LetvLLh5Q73CbGrSjMNhgKoXgG7O6bFUnD5yPaZC142V9FNE8Aed6IV7Ha89
         KbEsWsfijWL8AkBA5N3a9SBbDhdPOm9PUubs8lsPFLnGBHiK5UsVeMBeKng3WUBXxWuz
         Xx4s6yuY29XAOcTO6Ufqe9S3EHZyKqQvrL0k3TwAliqmI4mmoD9DzBJIfFwoUNhcAjwY
         7wNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785487786; x=1786092586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kAapaizwDkinO3KVOW2bB2GwZSS0Ne6+YXNPHio3Jxc=;
        b=Y1quSXleJbOGPvoJyKucobU125hCvYFiJQRP6ku39hUOwMZw1XaZGWx8IcZa3dTkEs
         KJavQpdiWZhCjWfaLk3N+9ZeGW+MHRYSuqezDuau4G4UzAuOf8mepea1UOJ9uZK0X5OB
         0mytTHslIVhdNuJOWme5si2c233KPpoGo3z3AmqDXT3/WY8MNKWb2gMxX9Y3Ni3T8Afz
         QpBC9bJleourWaWM6QoUHGHnehpLpu0rbnrBKvNnjldvoRZvVOufV2puE9yD7bx2P16Q
         uruSHVK98BVP+rz7uOX8CVJqhr3sKTmodIsbroMdgjmtfvLko4HLSRju9hGr+L9m5ilp
         u+Tw==
X-Gm-Message-State: AOJu0YxsySTRygFOiY8AvJn02ZiIhmzY16PlIDzbwyyZIoI31dm5cCPE
	q73Dai6QnBesRKPCuRcY7qEa3JF991IdYPr1fTrgLAWZE9YTBGTpMNYNzu4xHQ==
X-Gm-Gg: AR+sD11kFzIaZcfrIxmI9/5k73/a/dzZUfrvSu34ZgLRBigqHmuFDiXcHhkhJjUaKVK
	PWXR+HVXtupc7epUANwtdbjUym1sLE7sk6JfsMbpt1eJGC40H3uwoCOZnauKBzVgFDKug5KF3gZ
	gIIHue2cbNcduEzMGyRtP4psVH9cm2VB00lWR0N8JnseAF8t3m5QTOYMCeqIpvJx9oAaoluNUWi
	FezIKx1+QIVqf+rNkmb4A4EHRBpviub2PFqCEnx61EPTuq7v0FzbiQZkNv1LNHlGxn7yXihg5CJ
	IUds3kflaKpjbbpUABwCzjjcnvmlHLnBEmMOXvXmNmw0A58afqv4pHvIZbrruS0W30yr7qLLBQt
	jvsnbpzVXAIoctA6C+mk4Ule7KOqvmV7hgVsPgNhr9Y5Dss4OxbyZsM94Pb65K2GCM/3e2gVpIt
	oyhbHaX4uJ/sMZWUmMnJnLuPTvEP85mr016AsS1y/eGun3E1EhZs+QvTJrgiYoplanLTYG9FB9d
	iGaGSMiJZK11ojAVGQIUnfwmN4/yKyrdLufwnbe5wUB
X-Received: by 2002:a17:903:2ac3:b0:2ca:5a42:d8c5 with SMTP id d9443c01a7336-2d046f0318emr12343185ad.46.1785487785643;
        Fri, 31 Jul 2026 01:49:45 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae5abaesm2708425ad.27.2026.07.31.01.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 01:49:45 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Fan Ni <nifan.cxl@gmail.com>,
	Li Ming <ming.li@zohomail.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v12 4/8] cxl/events: Split event msgnum configuration from irq setup
Date: Fri, 31 Jul 2026 01:48:09 -0700
Message-ID: <20260731084901.1512819-5-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731084901.1512819-1-anisa.su@samsung.com>
References: <20260731084901.1512819-1-anisa.su@samsung.com>
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
---
 drivers/cxl/pci.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 9b320a2b6fe0..8e122de1876b 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -599,35 +599,31 @@ static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
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
@@ -674,11 +670,15 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
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

