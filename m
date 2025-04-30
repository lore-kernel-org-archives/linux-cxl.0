Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2621E5B8E
	for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 00:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745971989; cv=none; b=fhHjgmdMx0PDmdqgWaW7OmYX53CqG03xnBjgFZ2tF3PYG47mn3PKXb9Gc0oN4eA9ez+WmJNAavrqdpG+1qzVeUfRd4ZzIlBb31wan2taTTW9H1qzuW6X7T2c6X1YM/GLjML9DoQ61kW2BZVcFM7Y2yepNUARN9N6N6DJb4qkH6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745971989; c=relaxed/simple;
	bh=BzfFAM5BhwnMp75QAL22bKF9ElQQxGopTB6tLuSsWJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgVROkcor3GTDHKwM/8yMjmKAkD56npFP+IjHm4gBICf1FD9GHRrEvm/kKId8omUMspHrdjdqnnvrJqxSm27ThZXFsrnlnIrHeXy0OBtUkVjHk0y+gc601QuOZSnTFdwY6FiUEon5xC4liV3fgXKVkrX/W8SRR4bGy2OKC5Cib8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=EQAEqXJe; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="EQAEqXJe"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4767e969b94so149604061cf.2
        for <linux-cxl@vger.kernel.org>; Tue, 29 Apr 2025 17:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745971986; x=1746576786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3Yyi9y+v5P6bmpZgdp45DsIU9acCM/HjEvTDZbsG00=;
        b=EQAEqXJe6sjJzQYrxPBEe5xRaSbx+ib/+GvuPxwq9/h8jM4I/R8CJANbkbgTnXMO99
         9khpcaeCCb6B8eqL+/FHyYCdnX6N0wvKeXz2KXZQpQnLuyiVfIjPl7tEWtHemHq8uEID
         7wKYwjCmV8WSr7YRNcAcCZXbVhHu9Qi0mhg8YOyUayGEvTtKOJJA5C3wniEH+aIQg4q7
         mVtPixyORl006jKHhnAbv+1QojHQ7Swjdgoa+ql0IAr9UPdVPykxjDafZ8AJGaAhzC+u
         zKNCcW8P/cinfLvZuOrO6L24T6JV/sEZ/QgVYJHMm0kLWNzS+Z0+MslQumaV37KC1S/G
         i0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745971986; x=1746576786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3Yyi9y+v5P6bmpZgdp45DsIU9acCM/HjEvTDZbsG00=;
        b=wTxcDfy1ZD8vt8uocVQlFDmkOh9haFwrJNCb/ssz3qe+64INZ/HusOpMZGjITpHUtl
         fKBWMInVE3x+/R6se5WDPJ1ownaAxbupYcIakQyneG7W4Fzqfg+J3165eW6sa+kISrbc
         MAtfGzFrwphlUGs4Zmg3DmVNArOmzE11P+EOFxRWp14NIkVDwWrWLuYZuGURvKBNAXSR
         L5khqLOUkp4ej/wKLvEawG/5dlnJBswL9zFKqQDpooPNoPVbCm5MEq+qXsLwZ9ZWKnfx
         cvXdq2+H48Zu5hEHKESc7nY8DKNGmT6LnDu5Ps850AHjYgD7TJLX5L95rzGcq2wwZ9kL
         6Biw==
X-Gm-Message-State: AOJu0YwJ5JrF8D7+PL4AbNcJGvxqDndjBYZ7D7OcWwnRFRTC5gjJG3oP
	KI0B+6mk3IDikweYNvzubfeGzYmXnhtmfLJ9MEa5hJs5cKtVFf+RfSq4LIJYn9sImm+OUz9UloU
	H
X-Gm-Gg: ASbGncuwUOzSDEHVdlwOrnhM4ufG7LXxltQcTfxOC7ifzZq117K333Yj7/zEM8iEHyg
	vNRQo8iEGV8GZ5aAAnht7fhPqET/BhqWWLU6eGpD2k8AJgVkhXSr3jy18P9PyCK0KpTTh6K/i6/
	IqP5gnCmVm4bRSuySU+kvh4pT/O/+VkYFhuXLL9VLCpTKU9EKiPGuauk2f7IRhbOXaXxTVsxj3R
	I2alHBN5TgVb/Ze3GqSDiN7dqNOjTFlAeCU+jq838eVqfAu5bQmuL7rItDSPaxpUFVW3MwgOxmL
	gxXvoEDsZaB8R5OqN7qZIdG2dgP90HcbtlX1HA33Nm0QZafSRVMKaaCPxA6GUNdFjkIpmm0MGeq
	RZe0PO5+HerNX7wh3njUP3Wr4p7uqh3m2NYHqG3c=
X-Google-Smtp-Source: AGHT+IHDh8J8wln5z2S1SJ1zWQwlLw93RU9T3YfEZpUHWnDL1YaDIdRHES8teoNW5qqZZtojkjVFlQ==
X-Received: by 2002:a05:622a:17cc:b0:476:bb72:f429 with SMTP id d75a77b69052e-489e63d8bbamr9206451cf.42.1745971986365;
        Tue, 29 Apr 2025 17:13:06 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f7a820esm87634411cf.41.2025.04.29.17.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:13:06 -0700 (PDT)
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
Subject: [RFC PATCH 17/17] cxl: docs/use-cases
Date: Tue, 29 Apr 2025 20:12:24 -0400
Message-ID: <20250430001224.1028656-18-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430001224.1028656-1-gourry@gourry.net>
References: <20250430001224.1028656-1-gourry@gourry.net>
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
 .../cxl/use-case/dynamic-capacity.rst         | 19 +++++++++++++++++++
 .../cxl/use-case/memory-expansion.rst         | 14 ++++++++++++++
 .../driver-api/cxl/use-case/shared-memory.rst | 14 ++++++++++++++
 .../cxl/use-case/virtual-machines.rst         | 18 ++++++++++++++++++
 5 files changed, 75 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/use-case/dynamic-capacity.rst
 create mode 100644 Documentation/driver-api/cxl/use-case/memory-expansion.rst
 create mode 100644 Documentation/driver-api/cxl/use-case/shared-memory.rst
 create mode 100644 Documentation/driver-api/cxl/use-case/virtual-machines.rst

diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index 51dd0392883b..e0a86f68b6f8 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -50,5 +50,15 @@ that have impacts on each other.  The docs here break up configurations steps.
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
index 000000000000..93a24aa1edc5
--- /dev/null
+++ b/Documentation/driver-api/cxl/use-case/dynamic-capacity.rst
@@ -0,0 +1,19 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Dynamic Capacity
+################
+todo
+
+For Virtual Machines
+********************
+todo
+
+For Workload Orchestration
+**************************
+todo
+
+For Shared Memory
+*****************
+todo
+
+
diff --git a/Documentation/driver-api/cxl/use-case/memory-expansion.rst b/Documentation/driver-api/cxl/use-case/memory-expansion.rst
new file mode 100644
index 000000000000..d1d25e0e4498
--- /dev/null
+++ b/Documentation/driver-api/cxl/use-case/memory-expansion.rst
@@ -0,0 +1,14 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Memory Expansion
+################
+
+todo
+
+As Page Cache
+*************
+todo
+
+As DAX Device
+*************
+todo
diff --git a/Documentation/driver-api/cxl/use-case/shared-memory.rst b/Documentation/driver-api/cxl/use-case/shared-memory.rst
new file mode 100644
index 000000000000..dfdc2c419ea2
--- /dev/null
+++ b/Documentation/driver-api/cxl/use-case/shared-memory.rst
@@ -0,0 +1,14 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Shared Memory
+#############
+todo
+
+Coherence
+*********
+todo
+
+Fabric Attached Memory FileSystem (FAMFS)
+*****************************************
+
+todo
diff --git a/Documentation/driver-api/cxl/use-case/virtual-machines.rst b/Documentation/driver-api/cxl/use-case/virtual-machines.rst
new file mode 100644
index 000000000000..0411d37092ce
--- /dev/null
+++ b/Documentation/driver-api/cxl/use-case/virtual-machines.rst
@@ -0,0 +1,18 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Virtual Machines
+################
+
+todo
+
+NUMA Passthrough
+****************
+todo
+
+Flexible Shapes
+***************
+todo
+
+Datacenter Efficiency
+*********************
+todo
-- 
2.49.0

