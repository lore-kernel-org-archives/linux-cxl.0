Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4724293740
	for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066930; cv=none; b=NUku3YhNh6wvGEHuc/pFxeTszZGH6hoBQxFgG+x2alC04IFuVDMpKvetaQkBo4InNGZnTC+7FOOOuQHGaktl4W1wASDMldV5mgrSId8IKNyCqteO+fbQyxhb1lMxcylpd830Hjt1PKG3TRiTRw8jKFzHDx/o4SQvqWl9eT5W03U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066930; c=relaxed/simple;
	bh=02rFqC3gSUB4Fy4+GT/QyZr7jHPjwxLz9IoPedteAik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfJ9B0nkdewSO6LHO5a9PnveyWZqUad5dGnmNNor4PRjrvClvpUcBkJB4aHEBx+CiDNrIy9htf/2Fo1ySUNhIdEs1umQItCwrwfbXERjHXzsOqFzwtogDqqR7xl8csZ8uto3IxxgAjf9P3Jz9M8AYC2ACmDHIj0bdTs2e1boooQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SbIsS6Yw; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SbIsS6Yw"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4775ce8a4b0so83326851cf.1
        for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 09:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747066926; x=1747671726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsjZ8+vqh9tLCwEMgliXk7JRqYeLc6j1GH7rHKcC4Fk=;
        b=SbIsS6YwW57XJuyeYgmxF9B4fxxJ2WETuQcFS/bsiU0dBMwUDvc7stG5P1Y9szPM6Y
         Ocu1QSlVumnQVcUHIAP3Jc4wJHopKP5uRZexOBBPxxEnoYLeyz90d2GEeiCHJPZtOb65
         CRbwYauS8+xL9Gorb/zkDEg2fjRnkFTnR+Spc6tMjDEIyA7Hxibj6ov+7pYtplXM2Xs4
         a+3nDfA0G6W5+YI5R5pP9Hcn2xZVO3jWp/Anfvz+ViJUW8ajiPqPRblh7Y04XvDw1shA
         gzjgSSAPvLWnhJkDjaNkr28M+rr7jp5hyceGpYOUsPuG9+WKbgBRIV7ypJo8KW+kkqrB
         rZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747066926; x=1747671726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsjZ8+vqh9tLCwEMgliXk7JRqYeLc6j1GH7rHKcC4Fk=;
        b=efEL0Nihu8U1qt7yfshWETtY6FXBM4sxdArPG9dsWlighRLXAnCXm+B6IspvrGaUnt
         3+6XH4BUA60KTJyQn8WIbL8NS1i4hJHjyxKR9PB3gsLTs6jIb/A9uwbRqWsdWX4lefWy
         nMZNlXItS0/pN6pTnIIG73jDkxyuISxp123kKmG/3oD22XUurI4A32x+aRi7//I8zTC0
         iAU39douE2oC1Oj05RkKbmNZJmPDaz5DAXyanGTYaexzHBs3rbphCylTCEmLOL3cMudW
         k/BqSG1ke5fxfMjdWlhI8ZAbsDcWVNqERvdJoYl4AbfMx7UW7mlTwpzwYBqx+8hKDR0d
         MQZw==
X-Gm-Message-State: AOJu0Yz8YzlByxIEVnIa+AYF1eX+SNhhh1XyiuyibSGHcdwGy+O9oyc7
	EQhiq67153jsrY+QisDqTu8C2AjhVoH9EYLkdHJHAg+U4Yez1bIVQ7A/Y+Cig+AbgJS0RPX6Bd8
	S
X-Gm-Gg: ASbGncvMy7+Kh4e5j0aREXAO0I/GtkqsAq4b4hF28MsVCr0jgAnhhs0xYbQuzThNTGG
	qQvBAuRx4gl/X7Nn3lQXvph7yR45+N3tfpq1V69r0oLH0cCyTprJ6Mvy0S1If574KJRNE327I5p
	9C+b0xTEafGTx8SmrCMw3Aqh85acLl2ZtvGr67n/30Yv6RYBoiHTgZ5ZcAZrlUaJWwo/kZW503l
	1iZUU+Uvu8xhs/VvqYcE9nfDLSyKh37UQaP4v1rg4qTnoQAVt5i6PkIzGVajB4GwdHJDlS90Qo5
	f2iPjh2SK43QHMekg9wlUrczpiF/UBaMXkDotYAlH1jQ6l05hp36M1QVryk3Dre+3rZZAi1oYOQ
	rcYqMcoH8t7fbdj65bgBfsy+ANsHnTZRXQveO
X-Google-Smtp-Source: AGHT+IESCJ4wxgoeogGabJwCYGcV8hNihMeEX8lTGFo0c9q1TtRsQ3SAwLcPjqupzQu+Z/KuxiouEA==
X-Received: by 2002:a05:622a:110c:b0:476:9377:17aa with SMTP id d75a77b69052e-494527fd87amr209927431cf.52.1747066926366;
        Mon, 12 May 2025 09:22:06 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583961sm52461791cf.58.2025.05.12.09.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 09:22:06 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	corbet@lwn.net
Subject: [PATCH v3 16/17] cxl: docs/allocation/hugepages
Date: Mon, 12 May 2025 12:21:33 -0400
Message-ID: <20250512162134.3596150-17-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512162134.3596150-1-gourry@gourry.net>
References: <20250512162134.3596150-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add docs on how CXL capacity interacts with CMA and HugeTLB allocation
interfaces.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 .../driver-api/cxl/allocation/hugepages.rst   | 32 +++++++++++++++++++
 Documentation/driver-api/cxl/index.rst        |  1 +
 2 files changed, 33 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/allocation/hugepages.rst

diff --git a/Documentation/driver-api/cxl/allocation/hugepages.rst b/Documentation/driver-api/cxl/allocation/hugepages.rst
new file mode 100644
index 000000000000..1023c6922829
--- /dev/null
+++ b/Documentation/driver-api/cxl/allocation/hugepages.rst
@@ -0,0 +1,32 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========
+Huge Pages
+==========
+
+Contiguous Memory Allocator
+===========================
+CXL Memory onlined as SystemRAM during early boot is eligible for use by CMA,
+as the NUMA node hosting that capacity will be `Online` at the time CMA
+carves out contiguous capacity.
+
+CXL Memory deferred to the CXL Driver for configuration cannot have its
+capacity allocated by CMA - as the NUMA node hosting the capacity is `Offline`
+at :code:`__init` time - when CMA carves out contiguous capacity.
+
+HugeTLB
+=======
+Different huge page sizes allow different memory configurations.
+
+2MB Huge Pages
+--------------
+All CXL capacity regardless of configuration time or memory zone is eligible
+for use as 2MB huge pages.
+
+1GB Huge Pages
+--------------
+CXL capacity onlined in :code:`ZONE_NORMAL` is eligible for 1GB Gigantic Page
+allocation.
+
+CXL capacity onlined in :code:`ZONE_MOVABLE` is not eligible for 1GB Gigantic
+Page allocation.
diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index d3ab928d4d7c..366faf851fc7 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -47,5 +47,6 @@ that have impacts on each other.  The docs here break up configurations steps.
    allocation/dax
    allocation/page-allocator
    allocation/reclaim
+   allocation/hugepages.rst
 
 .. only::  subproject and html
-- 
2.49.0

