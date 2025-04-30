Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B74267733
	for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 18:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746036668; cv=none; b=LDqZiPITyMg564nRMBCU7z+qlbuxPMhvga4ey1x+npM62ZLKKpVo5NRtMSCIXAjE81jdna7KmuKMm7hpmgHUjnARpV2s01inPC/qJFcCi+DMKqc3DeB5rTcd/8YPANMMZRHuCDDux/v2hodMS9HkjCuaTaZVnAy/9TyludMGzRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746036668; c=relaxed/simple;
	bh=KvNSFJq9rASJXID87NCuG6RqLE6dY1Gl1jvW5kVlqFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOn+/m9cEqhpsa3Q1Y2mbiNhb8cwBeBSnw/ci5Za8F4fazHaSwSPdOoYPPKcU0GJHw/IHwS8KfDrac8aTGlCcP/lBBrvgy/h3OYG5FdtXIS/XbrKbLY4YDzzXx9mO7ueo56vRe0uUJGinorGNb5tXV1SCfIwmFcFTL/Oy5l/TiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LsO4fOz5; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="LsO4fOz5"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47664364628so2282401cf.1
        for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 11:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1746036665; x=1746641465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4TKqosidfYPUmViNB1FSWtCP5cThhjm46zc8OPnQtc=;
        b=LsO4fOz5lmO2fb4m0V+RNF8MNJLVchcWWIutmp4DZIdJYlRPYOMdxZ02FTZjH40qeS
         rIH2u9qFhGe+N9e4zcHLa6STuwy/kn6Hoe+kwcGLibws+qmlIlUHvTZ0LyyUMp9JK1Du
         BGEEBWN10mY1G8B3BvqZB9YcD2QHH4LrzR3GUGR1Q/0gaPuYyQU0G0uifGzbVMptI/pl
         yz9+G5j+nOxzSoAMVNhYBPVl9IoRbGS6xO+x8CPXpYNsJbeyYbxxyieMXFQ+v3OhBWFa
         iNkXsohlWODn885k8xwEtaHdUzX136Jlz/Dw0MO/Da19cvTmOHgFgTW1+rM+QmLPZRrZ
         /E6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746036665; x=1746641465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4TKqosidfYPUmViNB1FSWtCP5cThhjm46zc8OPnQtc=;
        b=LVDSIpMjXbLJJQ0Zo1Sg/LeXfO5u6Hs7H59ivJDB7DP/o7oKs0ujN7pT2Cy87OrTE/
         J27zxhrvfZzX0u+AXr0D79vX0CfufKhczZscxoj+Klo40N9IgIkoYUhr3jQe9uZ25nFK
         kpx8H7XqurxJjXvJbpQKnNasgBT8r/Y4x27Y2mZ+8Gf/WhLOdhQdpq73ylHY0lPQhbCr
         6beBSjuj4VmBQvaGqxgtpqCcoINjgOd9pNLM4yp9aYN4gmSFWw1KAKZ62nOel4shwRL3
         F8DA1VrjDbxAv1lblDZegb2pe/sX3KA/MIqHINc8uK8k9EnBabtDpMTRfjB4pZi/FBRB
         Ayeg==
X-Gm-Message-State: AOJu0YwyxhBDt2DtXzqMwK9VaOXDD3XAwet/hDKN3ufpMFAQ0mAM5vJx
	1j+C9zrCBuSxof+M3qYVf2N9uGjMtYaRqz8wdHgAFN9c8K3urMs0WHOH4MFStA5+1Od98sorKQw
	0
X-Gm-Gg: ASbGnctvEKsbI+2aZdu+mD4PH/cFb9Y/t8T5qz8aKdqPaNJjw+srvY4E4hxxJFVZUQx
	qJ0HOA8Mw1wnSC12q7cYDPKcu6zektW0ZvexzyhJ9delY/A2ct3pWhI4fi25bMkD77sd5vxkiwV
	vLYpXuPKRtQ8CgBlu/SLnOBilo5xQbkuzaz0XhzM7VJDqKqvsn3JEd478xZgEDKGAahi5bqrvyn
	XVCKg9jh9WDuwygI5ls60JZ0EB676xPL07Tc48U9A4h6C6lyIIwXQComu8YD6Ze0KGtkMNaqQIf
	QKXqYvBNcGU6a/oInCD7GocAgmgirlX4TLCEQPgCUgBa69djwmlKnkulfgTlrbtNymrCrOBIiyf
	XdtgxoowVHAVo/0+feusM803J6M6h
X-Google-Smtp-Source: AGHT+IGjywhCYYedP88BeAr8yEhOXWYBcOSmHHv4KQzgFZDxo4I+IaCwfDxqzyJr+OpTscZoDFNxiQ==
X-Received: by 2002:a05:622a:5a10:b0:47b:3a2:ff1f with SMTP id d75a77b69052e-48ad89a4684mr8061961cf.12.1746036664771;
        Wed, 30 Apr 2025 11:11:04 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-48a64fe04efsm5897421cf.19.2025.04.30.11.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 11:11:04 -0700 (PDT)
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
Subject: [RFC PATCH v2 03/18] cxl: docs/platform/bios-and-efi documentation
Date: Wed, 30 Apr 2025 14:10:33 -0400
Message-ID: <20250430181048.1197475-4-gourry@gourry.net>
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

Add some docs on CXL configurations done in bios/efi that affect
linux configuration - information vendors may care to consider.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 Documentation/driver-api/cxl/index.rst        |   6 +
 .../driver-api/cxl/platform/bios-and-efi.rst  | 262 ++++++++++++++++++
 2 files changed, 268 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/platform/bios-and-efi.rst

diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index 8e9d024cdfac..b8f82cdf1435 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -22,6 +22,12 @@ that have impacts on each other.  The docs here break up configurations steps.
    devices/device-types
    devices/uefi
 
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
index 000000000000..552a83992bcc
--- /dev/null
+++ b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
@@ -0,0 +1,262 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+BIOS/EFI Configuration
+======================
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
+=============
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
+---------------------
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
+===================
+
+Physical Address Region Alignment
+---------------------------------
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
+------------
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
+===================
+If BIOS/EFI intends to program the decoders to be statically configured,
+there are a few things to consider to avoid major pitfalls that will
+prevent Linux compatibility.  Some of these recommendations are not
+required "per the specification", but Linux makes no guarantees of support
+otherwise.
+
+
+Translation Point
+-----------------
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
+----------------------------------------
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
+------------
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
+-------------------
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

