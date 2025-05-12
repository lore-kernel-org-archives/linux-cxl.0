Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6DD251788
	for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 16:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066917; cv=none; b=YUW7pU2bpyzNE95cORnhZFsZy8pyljfFYVMem3gj5fdI6sehQGJNSEuH84eqPYldOzdbHNftHqyNZninNRbKnB6sQlsqE8lpS0mgsOq4CU9knH2Iyz4qkByvPHWzS3dq/T6X8jGkU0UZW0cJbpYMlAGdJmarpayZVFfF2dZQNwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066917; c=relaxed/simple;
	bh=X7EJbGzB/GZuOpW1q7+z422dxgR1XteIB0LGULxl5oA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9ccg6Ymna0eeLjCnr2QFbKyyTNmc3jvu5U4k3T20KvmEh6u3O250RC+HXL9ZL1kMWlcAgr4eia1wdjSfPqW9ltzcXaOdbnRWyDuhHvC2eTwLDJcr3eorlb4JTryvNLxy7bljgqwwi69XwCc8tFFnyhigm4Xfu1sXMtn/GxbmHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DwqkKUAA; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DwqkKUAA"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-476f4e9cf92so38854721cf.3
        for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 09:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747066913; x=1747671713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DC0/ofhj7JKy32BqrO/IxOiR9eJ+JSl3w3qlcKUJ5PI=;
        b=DwqkKUAANeIBbwyvQzlwlIuNpBJVvkgTnpCd0sDKvoe2+0yj6V6DWSf4zetopIVXlv
         LTR6EGW375cNiPZasD9HJc/4TpfkFn/HV0UWg+/k0lT/Sh1Dg218ru1iAivXhUPvq3kW
         NfDHAjuRBj8QpkHkC+wKu7wWTVak2UO/piS6//vtpmEF9bqDyzSKVr6sFZq/+FgGY9yA
         yVfkzXDUP8g42X9FB/US3vnhYDtp/g3LtUBPIiN/LZy/fjodCQWsTWYgeMdNUFNipK3R
         XchGsjfdhQ3Y5dfADeD8uIQAjaRuyiW1VUo44s/dMeQM98hNwQTlFKFHq1+WzHuSzWOI
         BIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747066913; x=1747671713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DC0/ofhj7JKy32BqrO/IxOiR9eJ+JSl3w3qlcKUJ5PI=;
        b=Z7JFEG7p6GK73P0FXtgiR85D1PENdJ1ZcwsfHehpqdhj3YEl8Q5OOSLbiJDK5819b3
         JaJG4G7oekCR0T34rvEO8w2PJpxUS4rXxYoj2c4WhiWRTrLLlBpO74rlpSsMN391i1US
         55eYli5L6LAoaTlFDIexCs2bjbjVit99aMkbnhfKB+wtsEs6xhdDhe36uOdvX63VDugR
         BCwu57mhEABgBl/tw772lqRISrtcwfFZNjjzW/mN1/dWwYrr7qpZ3HblJHjWcdphlKrH
         k005zs/5YLPGljflUbYWieWncRbETUkJsmrXiPHBI9ZDN+92WTVozCU1gfM9GChREOoF
         cdwQ==
X-Gm-Message-State: AOJu0YxT1q8e4SJ+bkB8RnWGaPZ9oCRyutWpn0vbFGJIvAOu/pqcU1SQ
	lDfPk7XGVi79H9FdkEPLWKwqWrecQVCBobRXSxxHZkPqGdUroQjVEk8udyLfGxPpS1P552UvT64
	h
X-Gm-Gg: ASbGnctWAuspiumab5YIlxaIMeuFH8LLPDiqMcfiu0ObiaY1c97eakKM743b4xbh7jZ
	RZRhn1XT2nB6RZonwtH1b4GuBrWxSHUQuu/ddjUxdDAfujoE0JLKTCDVvU7Mzh7fDSyx15ZCiiV
	T+laZJjmoxa4tbqAU1X6ZPT67bhHY23V35x8FcHnkhhrveIcXLKzqRmTpC09NBkalkTuADjCmrq
	PmngGbuJb16Xpj7sVnK1SlMkJXBqg/8FL2Umz8IexJS37jw/RHm54Y7DZxcfQBqovp01OKu33yM
	EbRDVl1o+myL13AMsod5c+0x2dl9PBmNMu6hYxXrpzg1xflRe+NfUrPGopx8FvUmWKFaDtppXtc
	R2w/FmxVMlAAZHC83cYUXFKiXtiiSmnjHPFUf
X-Google-Smtp-Source: AGHT+IHRtIB0fCjA+A9cMknQMzSETec9axcuV/yvNPBERr6Pc5t0djPvfI94QTi3RZ4eSxuBkXdaIw==
X-Received: by 2002:ac8:7e95:0:b0:477:64b0:6a26 with SMTP id d75a77b69052e-4945273c329mr213344211cf.22.1747066913103;
        Mon, 12 May 2025 09:21:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583961sm52461791cf.58.2025.05.12.09.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 09:21:52 -0700 (PDT)
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
Subject: [PATCH v3 07/17] cxl: docs/linux - overview
Date: Mon, 12 May 2025 12:21:24 -0400
Message-ID: <20250512162134.3596150-8-gourry@gourry.net>
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

Add type-3 device configuration overview that explains the probe
process for a type-3 device from early-boot through memory-hotplug.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 Documentation/driver-api/cxl/index.rst        |   3 +-
 .../driver-api/cxl/linux/overview.rst         | 103 ++++++++++++++++++
 2 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/driver-api/cxl/linux/overview.rst

diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index 6a5fb7e00c52..bc2228c77c32 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -30,9 +30,10 @@ that have impacts on each other.  The docs here break up configurations steps.
    platform/example-configs
 
 .. toctree::
-   :maxdepth: 1
+   :maxdepth: 2
    :caption: Linux Kernel Configuration
 
+   linux/overview
    linux/access-coordinates
 
 
diff --git a/Documentation/driver-api/cxl/linux/overview.rst b/Documentation/driver-api/cxl/linux/overview.rst
new file mode 100644
index 000000000000..648beb2c8c83
--- /dev/null
+++ b/Documentation/driver-api/cxl/linux/overview.rst
@@ -0,0 +1,103 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========
+Overview
+========
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
+      * Soft-Reserved IO Resource created for CFMWS entry
+
+  c) NUMA Node Creation
+
+    * Nodes created from ACPI CEDT CFMWS and SRAT Proximity domains (PXM)
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
+  a) Detects PCI device is CXL, marking it for probe by CXL driver
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
+      * DAX kmem IO Resource creation
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

