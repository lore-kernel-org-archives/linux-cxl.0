Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A985B15853B
	for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 00:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745971961; cv=none; b=KY6tBBiUeF9zwSWHo+1pchnskVEpb0Vwlj2gVMCgrfIEYaxV4DK5dwLqd9+d51UlrPPyoVWpdbmzYXGIGozJqcVGXGIPfom8Jgu8eFu2sH1y2WzcJLrwW+MAgSqsNqHpQXmZixvKV3ZCw4FEFsH4/FOCNkk3vVBS464lsDpoYTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745971961; c=relaxed/simple;
	bh=TJRzvtOcEZDWDTNl4nSpUSla4nmEEtSDMsHWKes/U8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XyV+RZ2egGnD66oDWSGO1QLIssLuX6+SWBq2a/UJ+6T25QcIwBg4u5LZqN2m0pvVuur1Ktd/pAs/S4H3nttowjighEAz/ubmik4m/B5RDgrBAadNyiLxnGfcY63uSx0Y1bPhonIj5Dw5tIbitoZIGgKzrYwElMQvDyDXGERrUO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=W36ccfOj; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="W36ccfOj"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-476f4e9cf92so49650491cf.3
        for <linux-cxl@vger.kernel.org>; Tue, 29 Apr 2025 17:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745971958; x=1746576758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pz4UQ+Wge1xHKt3y/MSWGIk9eVOTEVkWdrgaSHZA/wE=;
        b=W36ccfOjNSLCvfR53gBHm/d9+BK3+UCwb0nVdQc5FCZpZ+7CGwgQYmBxweucm7oVJ+
         v0+Iwu0hRwat4Ite+Q/A0ayVJiYg8rdCCg3KK0GdW6LIOCHHMnTmf8j+lbawqQcoDCrm
         YWWbt/Ipoteq2ygKui9BPDEbj48RtPGmRVeYpM85WgZl5Wx0Aw6ybGqIGC3E9J1ocJNe
         4MMbkAHYHgcULmOt98OVROpsORIs6w8VovEnMusbFErJsQ5zAv7aQyDWekruBM74enmT
         OGD8bSrgmU5QOXBHG4T6giYeByjd4ydSzzeLSppSYZOXLuWSoF93FKmaJvS/pbs1W5P9
         j9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745971958; x=1746576758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pz4UQ+Wge1xHKt3y/MSWGIk9eVOTEVkWdrgaSHZA/wE=;
        b=fyfsR79zmnkKsFnbcV2pVsHZ8zXXhs11bgI2DyGDhZpIRWmpywLHoe4GdT/++5oplr
         wFIVo30Qllq5ijngR3wXNJhwlxJfhVDKdu1Uu+1QNUSCoA58VsM3qNqCt/s3d2bDyTkD
         teOcp45tW2P+VoRSjPFNLGfuF3QJs4y2F7GRe3zwTGS5z35hShwLaLpEHd0HvMVUMMHv
         HjBZMn0+X5i0exAHOGoDRcgROUvnCZKRH71RZC2aqwKP39jOTqdVLtgfcpdtCDWJXF+G
         4t9N1NBJCoeoNIclZzKZPQMH53VtQnDkH9bu9KlbUennCdbAzn74EZXiTPJGr9VXm6gm
         BhWw==
X-Gm-Message-State: AOJu0YzkfhnJGGhUSljdTNMRztBVrGl9juyttXFIKYmbyVfZjrEzTTjt
	bDynYgjSL4KnZaThbgxSQqR1IeZ+z6Nbv040uPCo5+4dRiGprpttk945CuR1jEfRKM2RvIhIQ1w
	F
X-Gm-Gg: ASbGncuYuEPqQexWzDfMgUZE6pjB7UidCLgtcWgbxID710xxGYWl0guzpzJZhGZnB/w
	VWzLaF0wypWIc8g3uQTZmjM47yx552eBxd1fJ3DPtX4UMDizFZ6iskruSRvznaEz5yH+FTAQbt9
	mW6ckvrGiKahdtVhTdvR+0nMGt6gH1FC2G8z6W4tyEI9cUoZbQ86KMKbZ8JC43obVjC1NmD3ztP
	zHS+uDrFwqqDL+M0L1Zu47bKGTOM8FVjfuynNpTHqNIAz+8CSoyToHGG3PtOGdaTrARWhNc6vLC
	Ty/XAuyA8f+Fxf5OVh/Qps6DM3fKrn050UGXPA9n1U5Qp6arISyHmd+s9bd/QFDeQ7rZ8PdTGln
	8Ht69ufjQN4S0TI5f2NZJvTVOMUlM
X-Google-Smtp-Source: AGHT+IFAs3fb/lD26OIqHoAciKrHVh44tYCONI63s56rmd4jvJ0V7S0OOlc5UI4z1GQc7Gnm5d9iHw==
X-Received: by 2002:a05:622a:1b0c:b0:476:903a:b7f1 with SMTP id d75a77b69052e-489c34c7bacmr19217621cf.11.1745971958194;
        Tue, 29 Apr 2025 17:12:38 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f7a820esm87634411cf.41.2025.04.29.17.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:12:37 -0700 (PDT)
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
Subject: [RFC PATCH 03/17] cxl: docs/platform/bios-and-efi documentation
Date: Tue, 29 Apr 2025 20:12:10 -0400
Message-ID: <20250430001224.1028656-4-gourry@gourry.net>
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

Add some docs on CXL configurations done in bios/efi that affect
linux configuration - information vendors may care to consider.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 Documentation/driver-api/cxl/index.rst        |   6 +
 .../driver-api/cxl/platform/bios-and-efi.rst  | 261 ++++++++++++++++++
 2 files changed, 267 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/platform/bios-and-efi.rst

diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index 4dc99a6b08bd..7f4055503a43 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -23,6 +23,12 @@ that have impacts on each other.  The docs here break up configurations steps.
    devices/uefi
    devices/theory-of-operation
 
+.. toctree::
+   :maxdepth: 2
+   :caption: Platform Configuration
+
+   platform/bios-and-efi
+
 .. toctree::
    :maxdepth: 1
    :caption: Linux Kernel Configuration
diff --git a/Documentation/driver-api/cxl/platform/bios-and-efi.rst b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
new file mode 100644
index 000000000000..0d83aa817e9d
--- /dev/null
+++ b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
@@ -0,0 +1,261 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+BIOS/EFI Configuration
+######################
+
+BIOS and EFI are largely responsible for configuring static information about
+devices (or potential future devices) such that Linux can build the appropriate
+logical representations of these devices.
+
+At a high level, this is what occurs during this phase of configuration.
+
+* The bootloader starts the BIOS/EFI.
+
+* BIOS/EFI do early device probe to determine static configuration
+
+* BIOS/EFI creates ACPI Tables that describe static config for the OS
+
+* BIOS/EFI create the system memory map (EFI Memory Map, E820, etc)
+
+* BIOS/EFI calls :code:`start_kernel` and begins the Linux Early Boot process.
+
+Much of what this section is concerned with is ACPI Table production and
+static memory map configuration. More detail on these tables can be found
+under Platform Configuration -> ACPI Table Reference.
+
+.. note::
+   Platform Vendors should read carefully, as this sections has recommendations
+   on physical memory region size and alignment, memory holes, HDM interleave,
+   and what linux expects of HDM decoders trying to work with these features.
+
+UEFI Settings
+*************
+If your platform supports it, the :code:`uefisettings` command can be used to
+read/write EFI settings. Changes will be reflected on the next reboot. Kexec
+is not a sufficient reboot.
+
+One notable configuration here is the EFI_MEMORY_SP (Specific Purpose) bit.
+When this is enabled, this bit tells linux to defer management of a memory
+region to a driver (in this case, the CXL driver). Otherwise, the memory is
+treated as "normal memory", and is exposed to the page allocator during
+:code:`__init`.
+
+uefisettings examples
+=====================
+
+:code:`uefisettings identify` ::
+
+        uefisettings identify
+
+        bios_vendor: xxx
+        bios_version: xxx
+        bios_release: xxx
+        bios_date: xxx
+        product_name: xxx
+        product_family: xxx
+        product_version: xxx
+
+On some AMD platforms, the :code:`EFI_MEMORY_SP` bit is set via the :code:`CXL
+Memory Attribute` field.  This may be called something else on your platform.
+
+:code:`uefisettings get "CXL Memory Attribute"` ::
+
+        selector: xxx
+        ...
+        question: Question {
+            name: "CXL Memory Attribute",
+            answer: "Enabled",
+            ...
+        }
+
+Physical Memory Map
+*******************
+
+Physical Address Region Alignment
+=================================
+
+As of Linux v6.14, the hotplug memory system requires memory regions to be
+uniform in size and alignment.  While the CXL specification allows for memory
+regions as small as 256MB, the supported memory block size and alignment for
+hotplugged memory is architecture-defined.
+
+A Linux memory blocks may be as small as 128MB and increase in powers of two.
+
+* On ARM, the default block size and alignment is either 128MB or 256MB.
+
+* On x86, the default block size is 256MB, and increases to 2GB as the
+  capacity of the system increases up to 64GB.
+
+For best support across versions, platform vendors should place CXL memory at
+a 2GB aligned base address, and regions should be 2GB aligned.  This also helps
+prevent the creating thousands of memory devices (one per block).
+
+Memory Holes
+============
+
+Holes in the memory map are tricky.  Consider a 4GB device located at base
+address 0x100000000, but with the following memory map ::
+
+  ---------------------
+  |    0x100000000    |
+  |        CXL        |
+  |    0x1BFFFFFFF    |
+  ---------------------
+  |    0x1C0000000    |
+  |    MEMORY HOLE    |
+  |    0x1FFFFFFFF    |
+  ---------------------
+  |    0x200000000    |
+  |     CXL CONT.     |
+  |    0x23FFFFFFF    |
+  ---------------------
+
+There are two issues to consider:
+
+* decoder programming, and
+* memory block alignment.
+
+If your architecture requires 2GB uniform size and aligned memory blocks, the
+only capacity Linux is capable of mapping (as of v6.14) would be the capacity
+from `0x100000000-0x180000000`.  The remaining capacity will be stranded, as
+they are not of 2GB aligned length.
+
+Assuming your architecture and memory configuration allows 1GB memory blocks,
+this memory map is supported and this should be presented as multiple CFMWS
+in the CEDT that describe each side of the memory hole separately - along with
+matching decoders.
+
+Multiple decoders can (and should) be used to manage such a memory hole (see
+below), but each chunk of a memory hole should be aligned to a reasonable block
+size (larger alignment is always better).  If you intend to have memory holes
+in the memory map, expect to use one decoder per contiguous chunk of host
+physical memory.
+
+As of v6.14, Linux does provide support for memory hotplug of multiple
+physical memory regions separated by a memory hole described by a single
+HDM decoder.
+
+
+Decoder Programming
+*******************
+If BIOS/EFI intends to program the decoders to be statically configured,
+there are a few things to consider to avoid major pitfalls that will
+prevent Linux compatibility.  Some of these recommendations are not
+required "per the specification", but Linux makes no guarantees of support
+otherwise.
+
+
+Translation Point
+=================
+Per the specification, the only decoders which **TRANSLATE** Host Physical
+Address (HPA) to Device Physical Address (DPA) are the **Endpoint Decoders**.
+All other decoders in the fabric are intended to route accesses without
+translating the addresses.
+
+This is heavily implied by the specification, see: ::
+
+  CXL Specification 3.1
+  8.2.4.20: CXL HDM Decoder Capability Structure
+  - Implementation Note: CXL Host Bridge and Upstream Switch Port Decoder Flow
+  - Implementation Note: Device Decoder Logic
+
+Given this, Linux makes a strong assumption that decoders between CPU and
+endpoint will all be programmed with addresses ranges that are subsets of
+their parent decoder.
+
+Due to some ambiguity in how Architecture, ACPI, PCI, and CXL specifications
+"hand off" responsibility between domains, some early adopting platforms
+attempted to do translation at the originating memory controller or host
+bridge.  This configuration requires a platform specific extension to the
+driver and is not officially endorsed - despite being supported.
+
+It is *highly recommended* **NOT** to do this; otherwise, you are on your own
+to implement driver support for your platform.
+
+Interleave and Configuration Flexibility
+========================================
+If providing cross-host-bridge interleave, a CFMWS entry in the CEDT must be
+presented with target host-bridges for the interleaved device sets (there may
+be multiple behind each host bridge).
+
+If providing intra-host-bridge interleaving, only 1 CFMWS entry in the CEDT is
+required for that host bridge - if it covers the entire capacity of the devices
+behind the host bridge.
+
+If intending to provide users flexibility in programming decoders beyond the
+root, you may want to provide multiple CFMWS entries in the CEDT intended for
+different purposes.  For example, you may want to consider adding:
+
+1) A CFMWS entry to cover all interleavable host bridges.
+2) A CFMWS entry to cover all devices on a single host bridge.
+3) A CFMWS entry to cover each device.
+
+A platform may choose to add all of these, or change the mode based on a BIOS
+setting.  For each CFMWS entry, Linux expects descriptions of the described
+memory regions in the SRAT to determine the number of NUMA nodes it should
+reserve during early boot / init.
+
+As of v6.14, Linux will create a NUMA node for each CEDT CFMWS entry, even if
+a matching SRAT entry does not exist; however, this is not guaranteed in the
+future and such a configuration should be avoided.
+
+Memory Holes
+============
+If your platform includes memory holes intersparsed between your CXL memory, it
+is recommended to utilize multiple decoders to cover these regions of memory,
+rather than try to program the decoders to accept the entire range and expect
+Linux to manage the overlap.
+
+For example, consider the Memory Hole described above ::
+
+  ---------------------
+  |    0x100000000    |
+  |        CXL        |
+  |    0x1BFFFFFFF    |
+  ---------------------
+  |    0x1C0000000    |
+  |    MEMORY HOLE    |
+  |    0x1FFFFFFFF    |
+  ---------------------
+  |    0x200000000    |
+  |     CXL CONT.     |
+  |    0x23FFFFFFF    |
+  ---------------------
+
+Assuming this is provided by a single device attached directly to a host bridge,
+Linux would expect the following decoder programming ::
+
+     -----------------------   -----------------------
+     | root-decoder-0      |   | root-decoder-1      |
+     |   base: 0x100000000 |   |   base: 0x200000000 |
+     |   size:  0xC0000000 |   |   size:  0x40000000 |
+     -----------------------   -----------------------
+                |                         |
+     -----------------------   -----------------------
+     | HB-decoder-0        |   | HB-decoder-1        |
+     |   base: 0x100000000 |   |   base: 0x200000000 |
+     |   size:  0xC0000000 |   |   size:  0x40000000 |
+     -----------------------   -----------------------
+                |                         |
+     -----------------------   -----------------------
+     | ep-decoder-0        |   | ep-decoder-1        |
+     |   base: 0x100000000 |   |   base: 0x200000000 |
+     |   size:  0xC0000000 |   |   size:  0x40000000 |
+     -----------------------   -----------------------
+
+With a CEDT configuration with two CFMWS describing the above root decoders.
+
+Linux makes no guarantee of support for strange memory hole situations.
+
+Multi-Media Devices
+===================
+The CFMWS field of the CEDT has special restriction bits which describe whether
+the described memory region allows volatile or persistent memory (or both). If
+the platform intends to support either:
+
+1) A device with multiple medias, or
+2) Using a persistent memory device as normal memory
+
+A platform may wish to create multiple CEDT CFMWS entries to describe the same
+memory, with the intent of allowing the end user flexibility in how that memory
+is configured. Linux does not presently have strong requirements in this area.
-- 
2.49.0

