Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9322749CA
	for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 18:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746036689; cv=none; b=CGK//efEQtHghenSOW7NPa/cQH/gicqzXm/5326BmKx/ZZEtd0OdorMkJTNE2WVvdbyW246fJA98XJ+aIko84JDT5JW501wfm1boe+4vHenAJALcoQ3xm7ZnHjRQMPCUpNaLdOO7J7mKjpNdylp6ih1wW/ZvAFAqi3LKgAnoQFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746036689; c=relaxed/simple;
	bh=X5+Ukdg7rvV7208banBi4yu0UKjpHItJx+R1YJoxna4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ds0sOaEbhgFqzm+npAooLtrLC2ZYerEYCqxR6NIX+37HiMb0u4sYMxtfolMiz7IXEkLkGQP/V9OEaNYkW/CBLn55Qfm/NEcsCBpr3+7iyTm4nNtc9e/CC/F9loR0p9PEBTPVOLVqPBcX+aMbUOHPiOb3t4/KUZSenqbnjpj+8Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jYWcxVEs; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jYWcxVEs"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6ecf0e07954so2634996d6.1
        for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 11:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1746036687; x=1746641487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEWVWC2naWxysqXPj2rk0b5ktFtoGcxHBqlN3kboVV0=;
        b=jYWcxVEsbDJBnoS5QJ51o+vShg3KBRbOkrQYPMwN3yu+TPIk43b650NfEecd16qZ0c
         knq6XPHLYzGzGDFy3/bDI76jJDPgJtatt2aQ4GMKb8I0yPYQCLGJQVxOimmjO8Wt9lx0
         IPbRwtYDTnI7RD0SpXEEU0QxOdl1zyI41ywrUsZryxS7DXeGBqUWJp+8/wpHEOAEv01S
         hYtHErphWa6cn8urLprX2ZKFkPXrZs0wyRvcxXgQWWVX4Spfo/Ojs8cVQNNfv3V/Fj0A
         MF0TbsPWLNiOk4GwLCkjnXVnIgSsni43LrrxIughxbj/MEqhJvFnqHQ5rl1XBTbua7Ad
         72Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746036687; x=1746641487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEWVWC2naWxysqXPj2rk0b5ktFtoGcxHBqlN3kboVV0=;
        b=kDUWqPxqRdNkeF2529fRUDa60Sq6k/EbjKt73t78I7D5ciRMPuud7Q3AQi6o2NZMGT
         FW64i1sd4iXggRUpT361RQp2UrNp9bepwrO2VpRvKBp0JD8TNYo3z+Oh0TQlqjQG+yb7
         3wa7GR+8gB2d2YBYvDk3cg/l4j926yZ0Irflezt3EEkMePH76P6tci0Rk8nrIZSNL8CP
         UZMcl4ifPGYHy6BMs9DJas8JNVp39Az9+8QAoNXYg6LR+PD0zXHHvoCrtN7IrTh3sndq
         CxBE9Vs7T7Vin5YO+wVsINUUH6fCLFJgIlv+Oueumx2q/wDP5OYX8PJv7wcaXqTUmxyv
         E/rA==
X-Gm-Message-State: AOJu0YwbV41vAfGwm65oq1WG0XQFqBCZLqoHkm6ceBTSdovimAVZkKxf
	0isNUcNDZNuEFacHZ/VQ372DHiUOhmHvo13hfqWm2GVdPm81hfwxOOj435cf9KE8mr9WEzMjfjB
	r
X-Gm-Gg: ASbGncsFo9BgcvXZ974UghJXJ/2fhgPpqKQnxfdv+cxvGxyRGc6DOapYG4aWETIhTDm
	PA04/ddfpCs6en+mGiE498D8i4+OrpXusOMj/PaNpt8b2wOU+AffiLBZc+Ru5Fn3VngP7UJxgEM
	QQwqOUhDncj0PwTUtI+w773wz8RQeCltfywlFV5u76jSjgCMSpebnM+yYpt4F+4qG6VG2KngqKN
	ltbUe14PABQz+ieF6lllH3XzTXiCtD8YZalZ5v/zoAh6cw+t0ldVsWgU0BbO1B1sxKemJcX/xRS
	m2NRXWfhAV1mwbCL7cIrJhwcJ2bFqp+aMIXn9sv3XygZ4PnoXcBa7P9ZjzmSILvZFLhRrF+GizC
	6scPr0Rz+I/Z2piFsRi7fp9c38tjM
X-Google-Smtp-Source: AGHT+IG3vL7CDX13v14KAJlzknmgSXzqC6Sf41KMMOAFk0Ub1O74GkEtzw6Jz1Yr0ZgIjWvJ/mA6mA==
X-Received: by 2002:a05:6214:d88:b0:6e8:fa72:be4c with SMTP id 6a1803df08f44-6f5090dad94mr4412706d6.1.1746036686871;
        Wed, 30 Apr 2025 11:11:26 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-48a64fe04efsm5897421cf.19.2025.04.30.11.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 11:11:26 -0700 (PDT)
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
Subject: [RFC PATCH v2 15/18] cxl: docs/allocation/hugepages
Date: Wed, 30 Apr 2025 14:10:45 -0400
Message-ID: <20250430181048.1197475-16-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430181048.1197475-1-gourry@gourry.net>
References: <20250430181048.1197475-1-gourry@gourry.net>
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
 .../driver-api/cxl/allocation/hugepages.rst   | 34 +++++++++++++++++++
 Documentation/driver-api/cxl/index.rst        |  1 +
 2 files changed, 35 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/allocation/hugepages.rst

diff --git a/Documentation/driver-api/cxl/allocation/hugepages.rst b/Documentation/driver-api/cxl/allocation/hugepages.rst
new file mode 100644
index 000000000000..279970d73a28
--- /dev/null
+++ b/Documentation/driver-api/cxl/allocation/hugepages.rst
@@ -0,0 +1,34 @@
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
+at :code:`__init` time - which CMA carves out contiguous capacity.
+
+HugeTLB
+=======
+HugeTLB capacity is reserved from the page allocator. Only CXL memory onlined
+as SystemRAM during :code:`__init` and via memory-hotplug can be used via
+HugeTLB.
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
index a768144698e9..e58d057a16e3 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -48,5 +48,6 @@ that have impacts on each other.  The docs here break up configurations steps.
    allocation/dax
    allocation/page-allocator
    allocation/reclaim
+   allocation/hugepages.rst
 
 .. only::  subproject and html
-- 
2.49.0

