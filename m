Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CED19E975
	for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 00:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745971967; cv=none; b=tAiMStjWrxBXv6U6qC/0kmB53XgHT+XgMNIxhh7cfos+zmHKiP9hqG2ka1MlnN8dSKfSFC7XBWOSxkENcOkDoDc9dxBXu3zviFphxmwb1TzGB0NYywD9he/3o8gFlHenIAEs5EE6VAiw0DcfK0Ye4If87R0mYeYQyFaQk+PlBrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745971967; c=relaxed/simple;
	bh=BDXb7lgzBNxpVwjYFyJjd4t2j9sJSet0d7GASa7svQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfxNM0FgAW3ELGN3FPYWaDJSfj82p4yF+1lgH8KqCj9OICgvyBb0VooRDEgXizXu4SGNYwQe7tPxWuxT8h7BkMul8T1OnO1xdoKlhR22INlNjemZ0z/Qwq2ymM05W0JMU9soi6UmhYdM3vyHl0UW8hFH7RPh/ZMysOZj0h9FttE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=D74bUmKd; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="D74bUmKd"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4774d68c670so114319361cf.0
        for <linux-cxl@vger.kernel.org>; Tue, 29 Apr 2025 17:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745971964; x=1746576764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rp9atE4oqYHZI7zGuWpnaPq/N7S8aRGjs0Vq4QAx9No=;
        b=D74bUmKdC8yw+6rYsyb5RBpIe7ez1AfZ614t7zjQOWnl7yC7wOIZGvzGjg7Woa28Tj
         C6yRWUSwOAybDK+KDlI6TM+1swzxA0HchazMtCLBgQMnCDoyih5y2MgahR9ubq6/ynvg
         WVoj3/aGWUIgNIhq6FGfdWhqcSwcq4yTLhbiSsO6bGWucrHkeV1JKx30Rir97cXAO7yb
         Qnmg3ISIXRRrhrbiNNkUTDLC43gzoXoaE2zZX7ZkGx4v1MCuF8s2vgfzPl+yVBq5s37y
         ExCNCpAwT9Eh7hSt9eOrVPDsuk/RbE01OsFwqWOXGtCkHFNmw2UYZDhVz1bRwNu5hXvX
         v+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745971964; x=1746576764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rp9atE4oqYHZI7zGuWpnaPq/N7S8aRGjs0Vq4QAx9No=;
        b=vDtgLTKFN1Y8BJBYuJetcnd1HWRwYCX7bvPY7uy1ynG/sY79Uft7CSMLktaqo7dDrg
         aha0w+CSSXb9DRBrat3SMeAoBYEZulmTsUBRHMvQmr93kkcsb0B1pu3zjoo5oRyZz7BX
         avHbPJMAHUWq0P/Ls0tuKQ084hUGZDg/tvo7QbpevPrmrhnmiLc7UJkOlazS3ymbD4Df
         7W8aR/xqcOJKuXd6unObIb5g5nosTHIfIekg1dMv5HSlnPCMq74Vb9eYoVqNV/NvCPCS
         qwkftZFJBfQdKYQopipvzFH0a8/rCVHUT6r6mGQ9dVpBM0rkQvlFEQ6FAf++a7NTkF6g
         1/CA==
X-Gm-Message-State: AOJu0YzIC8u3m19Dxadf+Lb7IasL7FC5WzYS0U4fcOKUtExi5g5kGHFq
	HqxQig0pgXdIMslL+/Ie3eaDkMwYRljl+VpG0mv3e1BWmAkTmivvsgfL1CXiK8lGtYYa+otVZls
	+
X-Gm-Gg: ASbGncsccrluBqaHxLjcdleNlLrPLLEDMKANN06UYRlOsheUD8ixmy1QvVfRM+lTjYj
	yIvqULsGR3hI7kRB+Jl2QAzWPagQgPCCKYSprkFOqw0L+rjEP10o9skBeTcTs92zdITs7l3OBfR
	aq1YVgly45V0lx2e+UpXmxJA4TqBRGVeM/+qdzQjk96ptNazjEAQGmFygZwWZWT6HTmnMh5O3QW
	Cd3EVmQlzORJ/ZcG0YMR2gmJ10L+gBykWIgYl+iH40GJ8+MSjeCVUxqaUPqC8T45HQAgkhR8uxo
	O5IhOipyDmCh105P5WYxYdej/DimUpYP2Xc2qIfGJtVpLxUdVzkUnCXe7zPbV136JFiqbO6JQe0
	3vnorgdNyaXZjytNhqhgxx36r+mDg
X-Google-Smtp-Source: AGHT+IFWuPCqJzafZiXkTM0FkbazmzhXWCCT/3TEiGPXkXbgX4OBk3+9TL3sm/DfypsQTK99+QJYgA==
X-Received: by 2002:a05:622a:1f8d:b0:477:4df:9a58 with SMTP id d75a77b69052e-489e4a8d38fmr11558301cf.18.1745971963895;
        Tue, 29 Apr 2025 17:12:43 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f7a820esm87634411cf.41.2025.04.29.17.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:12:43 -0700 (PDT)
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
Subject: [RFC PATCH 06/17] cxl: docs/linux - overview
Date: Tue, 29 Apr 2025 20:12:13 -0400
Message-ID: <20250430001224.1028656-7-gourry@gourry.net>
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

Add type-3 device configuration overview that explains the probe
process for a type-3 device from early-boot through memory-hotplug.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 Documentation/driver-api/cxl/index.rst        |   3 +-
 .../driver-api/cxl/linux/overview.rst         | 104 ++++++++++++++++++
 2 files changed, 106 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/driver-api/cxl/linux/overview.rst

diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index afc66759eed2..01c0284fc273 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -32,9 +32,10 @@ that have impacts on each other.  The docs here break up configurations steps.
    platform/example-configs
 
 .. toctree::
-   :maxdepth: 1
+   :maxdepth: 2
    :caption: Linux Kernel Configuration
 
+   linux/overview
    linux/access-coordinates
 
 
diff --git a/Documentation/driver-api/cxl/linux/overview.rst b/Documentation/driver-api/cxl/linux/overview.rst
new file mode 100644
index 000000000000..33017ccb84f1
--- /dev/null
+++ b/Documentation/driver-api/cxl/linux/overview.rst
@@ -0,0 +1,104 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Overview
+########
+
+This section presents the configuration process of a CXL Type-3 memory device,
+and how it is ultimately exposed to users as either a :code:`DAX` device or
+normal memory pages via the kernel's page allocator.
+
+Portions marked with a bullet are points at which certain kernel objects
+are generated.
+
+1) Early Boot
+
+  a) BIOS, Build, and Boot Parameters
+
+    i) EFI_MEMORY_SP
+    ii) CONFIG_EFI_SOFT_RESERVE
+    iii) CONFIG_MHP_DEFAULT_ONLINE_TYPE
+    iv) nosoftreserve
+
+  b) Memory Map Creation
+
+    i) EFI Memory Map / E820 Consulted for Soft-Reserved
+
+      * CXL Memory is set aside to be handled by the CXL driver
+
+      * IO Resources are created for CFMWS entry
+
+  c) NUMA Node Creation
+
+    * ACPI CEDT and SRAT table are used to create Nodes from Proximity domains (PXM)
+
+  d) Memory Tier Creation
+
+    * A default memory_tier is created with all nodes.
+
+  e) Contiguous Memory Allocation
+
+    * Any requested CMA is allocated from Online nodes
+
+  f) Init Finishes, Drivers start probing
+
+2) ACPI and PCI Drivers
+
+  a) Detect CXL device, marking it for probe by CXL driver
+
+  b) This portion will not be covered specifically.
+
+3) CXL Driver Operation
+
+  a) Base device creation
+
+    * root, port, and memdev devices created
+    * CEDT CFMWS IO Resource creation
+
+  b) Decoder creation
+
+    * root, switch, and endpoint decoders created
+
+  c) Logical device creation
+
+    * memory_region and endpoint devices created
+
+  d) Devices are associated with each other
+
+    * If auto-decoder (BIOS-programmed decoders), driver validates
+      configurations, builds associations, and locks configs at probe time.
+
+    * If user-configured, validation and associations are built at
+      decoder-commit time.
+
+  e) Regions surfaced as DAX region
+
+    * dax_region created
+
+    * DAX device created via DAX driver
+
+4) DAX Driver Operation
+
+  a) DAX driver surfaces DAX region as one of two dax device modes
+
+    * kmem - dax device is converted to hotplug memory blocks
+
+      * DAX kmem IO resource creation
+
+    * hmem - dax device is left as daxdev to be accessed as a file.
+
+      * If hmem, journey ends here.
+
+  b) DAX kmem surfaces memory region to Memory Hotplug to add to page
+     allocator as "driver managed memory"
+
+5) Memory Hotplug
+
+  a) mhp component surfaces a dax device memory region as multiple memory
+     blocks to the page allocator
+
+    * blocks appear in :code:`/sys/bus/memory/devices` and linked to a NUMA node
+
+  b) blocks are onlined into the requested zone (NORMAL or MOVABLE)
+
+    * Memory is marked "Driver Managed" to avoid kexec from using it as region
+      for kernel updates
-- 
2.49.0

