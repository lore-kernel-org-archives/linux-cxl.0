Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24802749FA
	for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746036672; cv=none; b=qz9sQWQkJhVERckT86kB8oXYCsMS4MqZgmVlwyECv5PwkbkBN8JYSAHW96jsGNNx3tr/5TwuAOFp5MBTE7wmDrzOR4RNT3pbo1rXg6JmT1im0CpBQV3q00AEli/YNyngrUWoyn06+swTXAH0mQxgNjd+hllBrGrvo7Jr2eVaYWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746036672; c=relaxed/simple;
	bh=ysuz2dbhIUwSeo5TDdeE8cXgy0TSC86HQ4jDAdk8nAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xo8ma8hb57U6nzYr9oyzlezgZwkm9lYPDrTuGAcE7+dshAbsYM6D3E8uzli89dCuwL2EGxtvPhUbuVS9215lM11H1DCMEWtAausWeG728vYj4elmbRtp9HFBZWyMf1CAtUSZhsAY/pIJiPpQN51HETr56AzKtVNmSx6CbKA6q0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jBXdzvrm; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jBXdzvrm"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-476f4e9cf92so1299651cf.3
        for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 11:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1746036669; x=1746641469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wCLWtxPZo+z1qXRRB8VDvRxUJkg0/tm2oCyfTLu558=;
        b=jBXdzvrmhjYS681cdzRfZOZX8erz+5H7fGiauW0hgRhZ0066NIcnLFRpRIA0A4H+93
         jJgkH88krYXL00OjBjEgHRC8KpTzQFV0TNYFW7o1LV6jg7ndLFPtWMNd8kBOiHK/zI1Q
         oboQckc++P355FS5bvh9COUdmsPKV7LQB/3brr98vqpfWZjFqvKV5ds2plR4t3Qa5DwL
         SM6Jk7AGwkFJr3bANJuJ+DeWwRP5UnSmIM8C4sWwxKpl6+k6f7wPQUGKrIHB+MOV/TSe
         t0cM5soxi4AjRRpIRowrZPm+QXbaTzr4CQsPEzgM0LZPwmqsSMdefXoHgY24S23NfrxP
         rPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746036669; x=1746641469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wCLWtxPZo+z1qXRRB8VDvRxUJkg0/tm2oCyfTLu558=;
        b=Ndaw5nBb5OF1on6dcC95ImrOdlYx5KnHAyB6Unt0g0LF0Mwu8otLVkD034GaN83dO9
         cwFzy7u7N3DKm5bC+1J5lXX/OW5Lgo18CtiHCxmmSeYIiOxhpupXHfZdWncVgswxmtfd
         ek4JoGxeaEdMPdUiyrEWKKZg1TOZ0/muNoL9mmsvuzuJDwPcuF4FsvIuF5f4c/LcHwF0
         3IGvAGKFFA+X1CX0dcezpcWdtpVVsR47YLuNID6XchQnxRsWNM1H6zQDcOhcvk7BLq/R
         z/d8Cl0Rj7E/r//Mtz+D36Von3o50RHfBIhl8bsfYaJGML7/TxevoHKB58ZqjzV9C3M8
         v+7w==
X-Gm-Message-State: AOJu0YzoU24gUv4zVy35y8PrtOceQ5Fi3fomzsHiJ+peBng252V5hGAr
	FESYj+IecPOz0E5XkK7l5ucz/3cMIA7Y0aKgFPDl/JN6/Oc/ILNVpebFr+QVoPqJ9K6XyRAlNsm
	t
X-Gm-Gg: ASbGncvvA7NJ5KwT9Aix4he2gOqRKuO0C/Jy265kXcDeCGKAjfRbOXEoTU6/8aG/9oD
	AwDLb1ly/blZ5NpP5vldEwzQndskY1mBU2Ail9A4reHnr8YzA1Y3w50Eu5JxSJU2b9TMoXUCubd
	TxfP7CDQoqyAuZoxtyu61CIxgnv5iHrM4GLeNbPjHpsg5mHe79FLtQrLVLnHafKP6JHWXOpk7qi
	Dsxtymsr3Ke2VP/ujMeLuRZItE8Z0LvDYo8aB7peAe/po4iJDXVE/AmQbDidnxsn0HtgX3Sg84k
	9YgB/5gv8UEL/dPKg7TO0Ea+vrD7MWp1KFnnfvTJhXBsOL0wCLTTUMDgUzg/maHuxLshu5BfmQO
	5c3+/njRSOv+JLZf1dgs89xk5OKZk
X-Google-Smtp-Source: AGHT+IFZXlyw0vAGV8CcwH9mLxar0qE/OpSzEUJceMsLJiqWVmOB/kxElfqTZAE+Wa/7CGDcCw6Uwg==
X-Received: by 2002:a05:622a:a15:b0:477:6e6a:7cfe with SMTP id d75a77b69052e-489c0be6448mr59562341cf.0.1746036669411;
        Wed, 30 Apr 2025 11:11:09 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-48a64fe04efsm5897421cf.19.2025.04.30.11.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 11:11:09 -0700 (PDT)
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
Subject: [RFC PATCH v2 06/18] cxl: docs/linux - overview
Date: Wed, 30 Apr 2025 14:10:36 -0400
Message-ID: <20250430181048.1197475-7-gourry@gourry.net>
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

Add type-3 device configuration overview that explains the probe
process for a type-3 device from early-boot through memory-hotplug.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 Documentation/driver-api/cxl/index.rst        |   3 +-
 .../driver-api/cxl/linux/overview.rst         | 103 ++++++++++++++++++
 2 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/driver-api/cxl/linux/overview.rst

diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index 5fa66e668b49..284ac71bf292 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -31,9 +31,10 @@ that have impacts on each other.  The docs here break up configurations steps.
    platform/example-configs
 
 .. toctree::
-   :maxdepth: 1
+   :maxdepth: 2
    :caption: Linux Kernel Configuration
 
+   linux/overview
    linux/access-coordinates
 
 
diff --git a/Documentation/driver-api/cxl/linux/overview.rst b/Documentation/driver-api/cxl/linux/overview.rst
new file mode 100644
index 000000000000..f440d79d77d1
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
+  a) Detects PCI devices is CXL, marking it for probe by CXL driver
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

