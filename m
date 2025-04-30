Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3A8289E2F
	for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746036694; cv=none; b=AlG0kExhUnXGtKcP6fhx8tcV3cmeuVApo5xO9dUooAJRPHfHUPJjDvRyybwTE35xW1TTb/7BLY2jd/hbcCiUusbyh+Ir4p7Hlja9TsUx2ou4S2XHweY1G29vy3I/QTC6Gc38ifYJSrxYQtLFJRPAZv4d/dH/OqrIsn4g8sRNOjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746036694; c=relaxed/simple;
	bh=y+zXYdm8lR81Xt8s2hy8d74VfZoLwscWMB6SycFNemM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDiWWFe42g0aFYaUA5fYuQ5bkIxH5Ygwm0KfXR5INTE7AKLEhZ9vXRdK36DercUuVSH/qLQ03Trf6AN7LrL82IEv6WVmCMuJ1p+y2QevXEXItnjWL9S7ztquPwny7ZYt/cm84c5LBXh8osNx9tZCMrc2Mm0OXhORSe0AAImaf6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=doA73Zbz; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="doA73Zbz"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-476ac73c76fso2191991cf.0
        for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 11:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1746036690; x=1746641490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZA/uzDtyuFWn0NODL0whOKAEDNrO7IK9AQ6WwWNv0fM=;
        b=doA73ZbzVUZrFPubkg+KlKO3AfNyAz5rQdhhQi5a6rHopWQGXMvZkoBW4TByp2uzaK
         1ighbuIXTaJdYI2BPtYP1Zqe+CpPzocB6YpJsaWADV2s/wXjQYp4/l1qmO45I2HhDLNZ
         jK5Tu/O+roAeJMzc7XvTo7PFk6mS7sjd648KSouXXZUpmsQLEcVazdqpgPMR04U4wbQX
         hWo3lH8kUMaPm+OYS9x8aatuRxIUNTv+57lsfIVneaG7dOE7hERz8yMmKqNbLllwSulk
         ywlLTeAWo6XIQoakdU145GBhwlnUFcDe0J/UgWrfDLHlZ8d7+4tNKd07+FVn7n98xa4X
         Zu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746036690; x=1746641490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZA/uzDtyuFWn0NODL0whOKAEDNrO7IK9AQ6WwWNv0fM=;
        b=Eck+U1MVB9Ngm4Eg9xOV20/EoVRX3Mk8gR8RRkIZznRjaK+s+hfbVAnH+lC2lVoKR2
         kHKdkjnQTabGzp7l/pNFojR1qyHmRQbWFFue06z2IiyQRN39bo20uDMAcpC3ls7y91V3
         DbA5VP5pegaL8/LKbO+Z8xvLEU79BbJwZOTOJOj0QWSJT+LdLtnDMU+XRIrrBwgs8Mmf
         gWcM2TsAEOuVE5vLY039VeHxWuH0cmjwGBG6mDz+PjCKH1wEnGqYyNLtYWQivHi+djps
         PQJKk7z/A8K1Zc2qMMNqP/y/9DzjStS47KC52xfJDDI8YEUHsNwogOzXXXBsQ3OuZKVk
         +2FQ==
X-Gm-Message-State: AOJu0YzlsUWg9JwkMKxTuX0mG1hww6NzZmmn3T1ssdyQmykqPeBspW5G
	pDVlDNMVN3kX1EpEA6ubw4O5eIoT6Iy3KcIHPo3LJJ5epoqSEeWQutHxDIUfSrZuOhs+h/2Vn9o
	7
X-Gm-Gg: ASbGncuKDXi9DC31a5AATI7MBK/3c+N81Egizd0UAXaCHt3irmNTm/kkL8AIFohSNV6
	hwPsQBw1xyv5kzazzaOtYXOSWLkYLQf6GBy1Qvcxad2UmH8BYowhdCZNM2noUqaqios1PannEuy
	ggO0ZDXsmB0V/M7pcN5TXL885ZSKL8Qpgb6EufS6U2GBoMGlfFDSYr6XVxftb9+MstnDRPa/bUd
	cxYZwCV9mJJAO4Yf6MadBhhqettVLwVMUF+nlcbgs64KvYZLzFqv9BeQTSaA0i/+O4cXD+PIcqo
	WPI/yBCjQrhG/xwZK/094V6dT8BmgBOoJf1RKE64fM5+/srZuFwFmQ0zSA5V/aL+8thlbV+TNLM
	amkRpaHq4AeumX+loTxWiWE/FFn80
X-Google-Smtp-Source: AGHT+IEv91mZMPKNU0PUGx07QOnNDsFCio0WccLHM/KQVlDxKGCYzZ3aQ4Acw83pDA3zj/uh5YlXmQ==
X-Received: by 2002:a05:622a:5c1b:b0:476:71d2:61e0 with SMTP id d75a77b69052e-489c4356885mr70289341cf.23.1746036689813;
        Wed, 30 Apr 2025 11:11:29 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-48a64fe04efsm5897421cf.19.2025.04.30.11.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 11:11:29 -0700 (PDT)
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
Subject: [RFC PATCH v2 17/18] cxl: docs/use-cases
Date: Wed, 30 Apr 2025 14:10:47 -0400
Message-ID: <20250430181048.1197475-18-gourry@gourry.net>
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

Add carve-outs for use-case documentation.  Complete open as to
what (if anything) we should explain here, and/or what the structure
should be.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 Documentation/driver-api/cxl/index.rst        | 10 ++++++++++
 .../cxl/use-case/dynamic-capacity.rst         | 20 +++++++++++++++++++
 .../cxl/use-case/memory-expansion.rst         | 15 ++++++++++++++
 .../driver-api/cxl/use-case/shared-memory.rst | 15 ++++++++++++++
 .../cxl/use-case/virtual-machines.rst         | 19 ++++++++++++++++++
 5 files changed, 79 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/use-case/dynamic-capacity.rst
 create mode 100644 Documentation/driver-api/cxl/use-case/memory-expansion.rst
 create mode 100644 Documentation/driver-api/cxl/use-case/shared-memory.rst
 create mode 100644 Documentation/driver-api/cxl/use-case/virtual-machines.rst

diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index e58d057a16e3..956434e23e41 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -49,5 +49,15 @@ that have impacts on each other.  The docs here break up configurations steps.
    allocation/page-allocator
    allocation/reclaim
    allocation/hugepages.rst
+   allocation/tiering.rst
+
+.. toctree::
+   :maxdepth: 1
+   :caption: Use Cases
+
+   use-case/memory-expansion.rst
+   use-case/dynamic-capacity.rst
+   use-case/virtual-machines.rst
+   use-case/shared-memory.rst
 
 .. only::  subproject and html
diff --git a/Documentation/driver-api/cxl/use-case/dynamic-capacity.rst b/Documentation/driver-api/cxl/use-case/dynamic-capacity.rst
new file mode 100644
index 000000000000..002f30e6eca9
--- /dev/null
+++ b/Documentation/driver-api/cxl/use-case/dynamic-capacity.rst
@@ -0,0 +1,20 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+Dynamic Capacity
+================
+todo
+
+For Virtual Machines
+====================
+todo
+
+For Workload Orchestration
+==========================
+todo
+
+For Shared Memory
+=================
+todo
+
+
diff --git a/Documentation/driver-api/cxl/use-case/memory-expansion.rst b/Documentation/driver-api/cxl/use-case/memory-expansion.rst
new file mode 100644
index 000000000000..2ebe1d92b556
--- /dev/null
+++ b/Documentation/driver-api/cxl/use-case/memory-expansion.rst
@@ -0,0 +1,15 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+Memory Expansion
+================
+
+todo
+
+As Page Cache
+=============
+todo
+
+As DAX Device
+=============
+todo
diff --git a/Documentation/driver-api/cxl/use-case/shared-memory.rst b/Documentation/driver-api/cxl/use-case/shared-memory.rst
new file mode 100644
index 000000000000..3b13b30ddd70
--- /dev/null
+++ b/Documentation/driver-api/cxl/use-case/shared-memory.rst
@@ -0,0 +1,15 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+Shared Memory
+=============
+todo
+
+Coherence
+=========
+todo
+
+Fabric Attached Memory FileSystem (FAMFS)
+=========================================
+
+todo
diff --git a/Documentation/driver-api/cxl/use-case/virtual-machines.rst b/Documentation/driver-api/cxl/use-case/virtual-machines.rst
new file mode 100644
index 000000000000..8fdeccdd5c1c
--- /dev/null
+++ b/Documentation/driver-api/cxl/use-case/virtual-machines.rst
@@ -0,0 +1,19 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+Virtual Machines
+================
+
+todo
+
+NUMA Passthrough
+================
+todo
+
+Flexible Shapes
+===============
+todo
+
+Datacenter Efficiency
+=====================
+todo
-- 
2.49.0

