Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C5428CF65
	for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746036695; cv=none; b=pSUSY1G2FP4YaNSudEW7MDfIj1Gx409NIRGaaNMdiSki4xhHUuIjnuGFzwOyp+ewodgoH28sP8FbDldVJsKLQHtwGVdNRyDgTsMH+wGeniBJwdGlDMjR7t/IyDliizZfySyoXn/yUTe8E401VKzO+uS2gBGd9L0w9gvvHxhN7DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746036695; c=relaxed/simple;
	bh=C3+NE4GL2t1S6bA4q6zdjnZHIEhMLXG6A09ekqGmY6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmMyfKoXBUrFDrqysDJtMG/yxeWQ92FvhmuftEfNK/N9Adi86huPxBQkAr5DS7Lfk55kEVQk6De7ImPVj4BEKjdr4PsFDd5N9R2Zlxv9oT0BzSEJfDcDLlGTSbliJ/isXZ9cCo09cosDFa4v+TwIJT0TcaZ3AfO4niZC3ttn2MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=RIUUMZr1; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="RIUUMZr1"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8f06e13a4so16327926d6.0
        for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 11:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1746036692; x=1746641492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gs5zk7qO3i+Gy6m+o2xD6HywWGNnomysRu1myabmsGg=;
        b=RIUUMZr1SV1Maab2CTREPne9xVwtCWL7n7klAqHyC+hVSis2AHOlPdzfWSjFfLpMP+
         BOQchk0hFz8vprocAQbvDOcUYMdZW8TSqSkRDRJd37VkkcRWk5vLSipqVj/dqno6O3pz
         Wif2tE0NREr9PkIefm0lRT0tnDY0Ibe0x02JBR6nIdgWNpvFBWa7Hqi86BOKVT4hk9Qm
         9yFMQti8dVRoSes95LMYlAB9i+Rj9AA3sWB7w7zSymXvgEk2AaOvvN/PEgWo+JqFtK6i
         fLuiEikiAXsWwoCK0y5pniQjbJ0zkVA7hPc5UY6UzWeIThT5G8fQGGt55D2sBlDHVS8U
         byxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746036692; x=1746641492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gs5zk7qO3i+Gy6m+o2xD6HywWGNnomysRu1myabmsGg=;
        b=NOGKsEVJ7hrjAC0vlyzflVJZNXt6o+7/+T+jLLUXtxFJ4hHUE8Szx9Iy94rVGHB2Qx
         Ce03iiJo1EsV6uzLlbBvjPMKpxSF2RBQ6v9CDxbzz3isfck/XhZv6+zqKtpUf9Yx0Eyg
         Qh8iPwHpc4GYuz5Nwa9AT9qNuTek7fuqRK7xvNkHl0fySQiiE4zFJHgWqAENYXYjh5RK
         oZFii391UIw5FOhHISUCmGGt+DJO4tJwAeK/yc13hC5iB5v9HGYnF+sIUotw3g2hS1nR
         o6RVamtRcMV6cPOXMG2aozrhXXg5DGmD2aHl+3/5Bnc691TO0ryuS1fOoIjuPsPiDi+8
         NuLA==
X-Gm-Message-State: AOJu0Yyj0raW95bCUoCdCeyDTLkRUZNq7b/QqcmraxAx9ErZ41ugk+Wu
	D6wvSFmVYYgnBmTj/YYyF61pPbfRf9yRWByitiGjZenqq7SrtMUTTZhhpoamqWJYe6NHEbg2KH5
	P
X-Gm-Gg: ASbGncu3hxPRTVIguDhezz21OzLJUxWHKm575/NjNWqCn3kQcPU+3ssnEVK8RdjAdMj
	4xfc35f6FAToXGfLIKLEfKQZPD1jyUkJ1tx0IlHUwNt1amLKN+JWvJ79vwMDfwXidEWic52pV6p
	pm7aL4TwtIIKC6wG1yofQmq243a4PC1thTZOOdPcdpVzQ1gDBOcEVHBjx9D3Q3wtHMDB3zoQp+j
	ELKJZCqpneg2Ct2kJmofrvSH0z5/5U5G/z+oiD3XCQjQWOXJoEl1jCTJFiqvs/F/7/1lRxpJ813
	BtFZpXBxxmEXxqndpqZW58JK9NA6IkW1r109f+IxyLht4SEYxX1cFosDgkaB7jjn3iOsNWf+tN/
	P+Zeg6Vd1jxf9pBahos/NqSmNvkgN
X-Google-Smtp-Source: AGHT+IHvKw+43hjj7TQq+F9B1nQszjFX2xfpktZG1aDblkxQcdp18PoqTjnDcTGLxNGttqu63c1aFg==
X-Received: by 2002:ad4:5ca5:0:b0:6f0:e2e1:3f7b with SMTP id 6a1803df08f44-6f508c6bcc0mr7245106d6.3.1746036691378;
        Wed, 30 Apr 2025 11:11:31 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-48a64fe04efsm5897421cf.19.2025.04.30.11.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 11:11:31 -0700 (PDT)
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
Subject: [RFC PATCH v2 18/18] cxl: docs - add self-referencing cross-links
Date: Wed, 30 Apr 2025 14:10:48 -0400
Message-ID: <20250430181048.1197475-19-gourry@gourry.net>
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

Add some crosslinks between pages in the CXL docs - mostly to the
ACPI tables.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 .../driver-api/cxl/devices/device-types.rst   |  2 +-
 .../cxl/linux/access-coordinates.rst          |  8 +++--
 .../driver-api/cxl/linux/cxl-driver.rst       | 36 ++++++++++---------
 .../driver-api/cxl/linux/early-boot.rst       | 30 +++++++++-------
 .../driver-api/cxl/platform/bios-and-efi.rst  | 13 +++----
 .../example-configurations/flexible.rst       | 10 +++---
 .../example-configurations/hb-interleave.rst  | 10 +++---
 .../multi-dev-per-hb.rst                      | 10 +++---
 .../example-configurations/one-dev-per-hb.rst | 10 +++---
 9 files changed, 71 insertions(+), 58 deletions(-)

diff --git a/Documentation/driver-api/cxl/devices/device-types.rst b/Documentation/driver-api/cxl/devices/device-types.rst
index dfe8d4711987..f33a40d2284d 100644
--- a/Documentation/driver-api/cxl/devices/device-types.rst
+++ b/Documentation/driver-api/cxl/devices/device-types.rst
@@ -115,7 +115,7 @@ A Multi-Headed Single-Logical Device (MHSLD) exposes a single logical
 device to multiple heads which may be connected to one or more discrete
 hosts.  An example of this would be a simple memory-pool which may be
 statically configured (prior to boot) to expose portions of its memory
-to Linux via the CEDT ACPI table.
+to Linux via Documentation/driver-api/cxl/platform/acpi/cedt.rst
 
 MHMLD
 ~~~~~
diff --git a/Documentation/driver-api/cxl/linux/access-coordinates.rst b/Documentation/driver-api/cxl/linux/access-coordinates.rst
index b07950ea30c9..24db5b41716a 100644
--- a/Documentation/driver-api/cxl/linux/access-coordinates.rst
+++ b/Documentation/driver-api/cxl/linux/access-coordinates.rst
@@ -24,7 +24,8 @@ asymmetry in properties does not happen and all paths to EPs are equal.
 
 There can be multiple switches under an RP. There can be multiple RPs under
 a CXL Host Bridge (HB). There can be multiple HBs under a CXL Fixed Memory
-Window Structure (CFMWS).
+Window Structure (CFMWS) in the
+Documentation/driver-api/cxl/platform/acpi/acpi/cedt.rst.
 
 An example hierarchy:
 
@@ -83,8 +84,9 @@ also the index for the resulting xarray.
 
 The next step is to take the min() of the per host bridge bandwidth and the
 bandwidth from the Generic Port (GP). The bandwidths for the GP is retrieved
-via ACPI tables SRAT/HMAT. The min bandwidth are aggregated under the same
-ACPI0017 device to form a new xarray.
+via ACPI tables Documentation/driver-api/cxl/platform/acpi/srat.rst and
+Documentation/driver-api/cxl/platform/acpi/hmat.rst. The min bandwidth are
+aggregated under the same ACPI0017 device to form a new xarray.
 
 Finally, the cxl_region_update_bandwidth() is called and the aggregated
 bandwidth from all the members of the last xarray is updated for the
diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
index 1a354ea1cda4..b4cb1910adde 100644
--- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
+++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
@@ -77,11 +77,11 @@ Root Object` Device Class is found.
 
 The Root contains links to:
 
-* `Host Bridge Ports` defined by ACPI CEDT CHBS.
+* `Host Bridge Ports` defined by CHBS in Documentation/driver-api/cxl/platform/acpi/cedt.rst.
 
 * `Downstream Ports` typically connected to `Host Bridge Ports`
 
-* `Root Decoders` defined by ACPI CEDT CFMWS.
+* `Root Decoders` defined by CFMWS in Documentation/driver-api/cxl/platform/acpi/cedt.rst.
 
 ::
 
@@ -150,9 +150,9 @@ An `endpoint` is a terminal port in the fabric.  This is a `logical device`,
 and may be one of many `logical devices` presented by a memory device. It
 is still considered a type of `port` in the fabric.
 
-An `endpoint` contains `endpoint decoders` available for use and the
-*Coherent Device Attribute Table* (CDAT) used to describe the capabilities
-of the device. ::
+An `endpoint` contains `endpoint decoders` available for use and the CDAT in
+Device's Documentation/driver-api/cxl/devices/uefi.rst used to describe the
+capabilities of the device. ::
 
   # ls /sys/bus/cxl/devices/endpoint5
     CDAT        decoders_committed  modalias      uevent
@@ -247,17 +247,18 @@ parameter.
 Root Decoder
 ~~~~~~~~~~~~
 A `Root Decoder` is logical construct of the physical address and interleave
-configurations present in the ACPI CEDT CFMWS.  Linux presents this information
-as a decoder present in the `CXL Root`.  We consider this a `Root Decoder`,
-though technically it exists on the boundary of the CXL specification and
-platform-specific CXL root implementations.
+configurations present in the CFMWS field of the
+Documentation/driver-api/cxl/platform/acpi/cedt.rst.
+Linux presents this information as a decoder present in the `CXL Root`.  We
+consider this a `Root Decoder`, though technically it exists on the boundary
+of the CXL specification and platform-specific CXL root implementations.
 
 Linux considers these logical decoders a type of `Routing Decoder`, and is the
 first decoder in the CXL fabric to receive a memory access from the platform's
 memory controllers.
 
 `Root Decoders` are created during :code:`cxl_acpi_probe`.  One root decoder
-is created per CFMWS entry in the ACPI CEDT.
+is created per CFMWS entry in the Documentation/driver-api/cxl/platform/acpi/cedt.rst.
 
 The :code:`target_list` parameter is filled by the CFMWS target fields. Targets
 of a root decoder are `Host Bridges`, which means interleave done at the root
@@ -267,9 +268,11 @@ Only root decoders are capable of `Inter-Host-Bridge Interleave`.
 
 Such interleaves must be configured by the platform and described in the ACPI
 CEDT CFMWS, as the target CXL host bridge UIDs in the CFMWS must match the CXL
-host bridge UIDs in the ACPI CEDT CHBS and ACPI DSDT.
+host bridge UIDs in the CHBS field of the
+Documentation/driver-api/cxl/platform/acpi/cedt.rst and the UID field of CXL
+Host Bridges defined in the Documentation/driver-api/cxl/platform/acpi/dsdt.rst.
 
-Interleave settings in a rootdecoder describe how to interleave accesses among
+Interleave settings in a root decoder describe how to interleave accesses among
 the *immediate downstream targets*, not the entire interleave set.
 
 The memory range described in the root decoder is used to
@@ -531,10 +534,11 @@ granularity configuration.
 
 At Root
 ~~~~~~~
-Root decoder interleave is defined by the ACPI CEDT CFMWS.  The CEDT
-may actually define multiple CFMWS configurations to describe the same
-physical capacity - with the intent to allow users to decide at runtime
-whether to online memory as interleaved or non-interleaved. ::
+Root decoder interleave is defined by CFMWS field of the
+Documentation/driver-api/cxl/platform/acpi/cedt.rst.  The CEDT may actually
+define multiple CFMWS configurations to describe the same physical capacity,
+with the intent to allow users to decide at runtime whether to online memory
+as interleaved or non-interleaved. ::
 
              Subtable Type : 01 [CXL Fixed Memory Window Structure]
        Window base address : 0000000100000000
diff --git a/Documentation/driver-api/cxl/linux/early-boot.rst b/Documentation/driver-api/cxl/linux/early-boot.rst
index 275174d5b0bb..309cc6999c6b 100644
--- a/Documentation/driver-api/cxl/linux/early-boot.rst
+++ b/Documentation/driver-api/cxl/linux/early-boot.rst
@@ -12,7 +12,8 @@ read EFI and ACPI information throughout this process to configure logical
 representations of the devices.
 
 During Linux Early Boot stage (functions in the kernel that have the __init
-decorator), the system takes the resources created by EFI/BIOS (ACPI tables)
+decorator), the system takes the resources created by EFI/BIOS
+(Documentation/driver-api/cxl/platform/acpi.rst)
 and turns them into resources that the kernel can consume.
 
 
@@ -69,13 +70,15 @@ significant impact performance depending on the memory capacity of the system.
 NUMA Node Reservation
 =====================
 
-Linux refers to the proximity domains (:code:`PXM`) defined in the SRAT to
-create NUMA nodes in :code:`acpi_numa_init`. Typically, there is a 1:1 relation
-between :code:`PXM` and NUMA node IDs.
+Linux refers to the proximity domains (:code:`PXM`) defined in the
+Documentation/driver-api/cxl/platform/acpi/srat.rst to create NUMA nodes in
+:code:`acpi_numa_init`. Typically, there is a 1:1 relation between
+:code:`PXM` and NUMA node IDs.
 
-SRAT is the only ACPI defined way of defining Proximity Domains. Linux chooses
-to, at most, map those 1:1 with NUMA nodes. CEDT adds a description of SPA
-ranges which Linux may wish to map to one or more NUMA nodes
+The SRAT is the only ACPI defined way of defining Proximity Domains. Linux
+chooses to, at most, map those 1:1 with NUMA nodes.
+Documentation/driver-api/cxl/platform/acpi/cedt.rst
+adds a description of SPA ranges which Linux may map to one or more NUMA nodes
 
 If there are CXL ranges in the CFMWS but not in SRAT, then a fake :code:`PXM`
 is created (as of v6.15). In the future, Linux may reject CFMWS not described
@@ -88,7 +91,7 @@ data for Linux to identify NUMA nodes their associated memory regions.
 
 The relevant code exists in: :code:`linux/drivers/acpi/numa/srat.c`.
 
-See the Example Platform Configurations section for more information.
+See Documentation/driver-api/cxl/platform/example-configs.rst for more info.
 
 Memory Tiers Creation
 =====================
@@ -107,10 +110,13 @@ Tier membership can be inspected in ::
   /sys/devices/virtual/memory_tiering/memory_tierN/nodelist
   0-1
 
-If nodes are grouped which have clear difference in performance, check the HMAT
-and CDAT information for the CXL nodes.  All nodes default to the DRAM tier,
-unless HMAT/CDAT information is reported to the memory_tier component via
-`access_coordinates`.
+If nodes are grouped which have clear difference in performance, check the
+Documentation/driver-api/cxl/platform/acpi/hmat.rst and CDAT
+(Documentation/driver-api/cxl/devices/uefi.rst) information for the CXL nodes.
+All nodes default to the DRAM tier, unless HMAT/CDAT information is reported
+to the memory_tier component via `access_coordinates`.
+
+For more, see Documentation/driver-api/cxl/linux/access-coordinates.rst.
 
 Contiguous Memory Allocation
 ============================
diff --git a/Documentation/driver-api/cxl/platform/bios-and-efi.rst b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
index 552a83992bcc..cdbba6798079 100644
--- a/Documentation/driver-api/cxl/platform/bios-and-efi.rst
+++ b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
@@ -22,7 +22,7 @@ At a high level, this is what occurs during this phase of configuration.
 
 Much of what this section is concerned with is ACPI Table production and
 static memory map configuration. More detail on these tables can be found
-under Platform Configuration -> ACPI Table Reference.
+at Documentation/driver-api/cxl/platform/acpi.rst.
 
 .. note::
    Platform Vendors should read carefully, as this sections has recommendations
@@ -175,9 +175,10 @@ to implement driver support for your platform.
 
 Interleave and Configuration Flexibility
 ----------------------------------------
-If providing cross-host-bridge interleave, a CFMWS entry in the CEDT must be
-presented with target host-bridges for the interleaved device sets (there may
-be multiple behind each host bridge).
+If providing cross-host-bridge interleave, a CFMWS entry in the
+Documentation/driver-api/cxl/platform/acpi/cedt.rst
+must be presented with target host-bridges for the interleaved device sets
+(there may be multiple behind each host bridge).
 
 If providing intra-host-bridge interleaving, only 1 CFMWS entry in the CEDT is
 required for that host bridge - if it covers the entire capacity of the devices
@@ -193,8 +194,8 @@ different purposes.  For example, you may want to consider adding:
 
 A platform may choose to add all of these, or change the mode based on a BIOS
 setting.  For each CFMWS entry, Linux expects descriptions of the described
-memory regions in the SRAT to determine the number of NUMA nodes it should
-reserve during early boot / init.
+memory regions in the Documentation/driver-api/cxl/platform/acpi/srat.rst to
+determine the number of NUMA nodes it should reserve during early boot / init.
 
 As of v6.14, Linux will create a NUMA node for each CEDT CFMWS entry, even if
 a matching SRAT entry does not exist; however, this is not guaranteed in the
diff --git a/Documentation/driver-api/cxl/platform/example-configurations/flexible.rst b/Documentation/driver-api/cxl/platform/example-configurations/flexible.rst
index 13a97c03e25a..b2559d2de225 100644
--- a/Documentation/driver-api/cxl/platform/example-configurations/flexible.rst
+++ b/Documentation/driver-api/cxl/platform/example-configurations/flexible.rst
@@ -18,7 +18,7 @@ Things to note:
 * This SRAT describes one-node for each of the above CFMWS.
 * The HMAT describes performance for each node in the SRAT.
 
-CEDT ::
+Documentation/driver-api/cxl/platform/acpi/cedt.rst ::
 
             Subtable Type : 00 [CXL Host Bridge Structure]
                  Reserved : 00
@@ -137,7 +137,7 @@ CEDT ::
                     QtgId : 0001
              First Target : 00000006
 
-SRAT ::
+Documentation/driver-api/cxl/platform/acpi/srat.rst ::
 
          Subtable Type : 01 [Memory Affinity]
                 Length : 28
@@ -223,7 +223,7 @@ SRAT ::
        Hot Pluggable : 1
         Non-Volatile : 0
 
-HMAT ::
+Documentation/driver-api/cxl/platform/acpi/hmat.rst ::
 
                Structure Type : 0001 [SLLBI]
                     Data Type : 00   [Latency]
@@ -263,7 +263,7 @@ HMAT ::
                         Entry : 0100
                         Entry : 0100
 
-SLIT ::
+Documentation/driver-api/cxl/platform/acpi/slit.rst ::
 
      Signature : "SLIT"    [System Locality Information Table]
     Localities : 0000000000000003
@@ -276,7 +276,7 @@ SLIT ::
   Locality   6 : FF FF FF FF FF FF 0A FF
   Locality   7 : FF FF FF FF FF FF FF 0A
 
-DSDT ::
+Documentation/driver-api/cxl/platform/acpi/dsdt.rst ::
 
   Scope (_SB)
   {
diff --git a/Documentation/driver-api/cxl/platform/example-configurations/hb-interleave.rst b/Documentation/driver-api/cxl/platform/example-configurations/hb-interleave.rst
index fa0885d82deb..9cbf3dd44b0f 100644
--- a/Documentation/driver-api/cxl/platform/example-configurations/hb-interleave.rst
+++ b/Documentation/driver-api/cxl/platform/example-configurations/hb-interleave.rst
@@ -13,7 +13,7 @@ Things to note:
 * This SRAT describes one-node for both host bridges.
 * The HMAT describes a single node's performance.
 
-CEDT ::
+Documentation/driver-api/cxl/platform/acpi/cedt.rst ::
 
             Subtable Type : 00 [CXL Host Bridge Structure]
                  Reserved : 00
@@ -48,7 +48,7 @@ CEDT ::
              First Target : 00000007
             Second Target : 00000006
 
-SRAT ::
+Documentation/driver-api/cxl/platform/acpi/srat.rst ::
 
          Subtable Type : 01 [Memory Affinity]
                 Length : 28
@@ -62,7 +62,7 @@ SRAT ::
        Hot Pluggable : 1
         Non-Volatile : 0
 
-HMAT ::
+Documentation/driver-api/cxl/platform/acpi/hmat.rst ::
 
                Structure Type : 0001 [SLLBI]
                     Data Type : 00   [Latency]
@@ -80,14 +80,14 @@ HMAT ::
                         Entry : 1200
                         Entry : 0400
 
-SLIT ::
+Documentation/driver-api/cxl/platform/acpi/slit.rst ::
 
      Signature : "SLIT"    [System Locality Information Table]
     Localities : 0000000000000003
   Locality   0 : 10 20
   Locality   1 : FF 0A
 
-DSDT ::
+Documentation/driver-api/cxl/platform/acpi/dsdt.rst ::
 
   Scope (_SB)
   {
diff --git a/Documentation/driver-api/cxl/platform/example-configurations/multi-dev-per-hb.rst b/Documentation/driver-api/cxl/platform/example-configurations/multi-dev-per-hb.rst
index 6adf7c639490..fa24243968ac 100644
--- a/Documentation/driver-api/cxl/platform/example-configurations/multi-dev-per-hb.rst
+++ b/Documentation/driver-api/cxl/platform/example-configurations/multi-dev-per-hb.rst
@@ -14,7 +14,7 @@ Things to note:
 * This CEDT/SRAT describes one node for both devices.
 * There is only one proximity domain the HMAT for both devices.
 
-CEDT ::
+Documentation/driver-api/cxl/platform/acpi/cedt.rst ::
 
             Subtable Type : 00 [CXL Host Bridge Structure]
                  Reserved : 00
@@ -39,7 +39,7 @@ CEDT ::
                     QtgId : 0001
              First Target : 00000007
 
-SRAT ::
+Documentation/driver-api/cxl/platform/acpi/srat.rst ::
 
          Subtable Type : 01 [Memory Affinity]
                 Length : 28
@@ -53,7 +53,7 @@ SRAT ::
        Hot Pluggable : 1
         Non-Volatile : 0
 
-HMAT ::
+Documentation/driver-api/cxl/platform/acpi/hmat.rst ::
 
                Structure Type : 0001 [SLLBI]
                     Data Type : 00   [Latency]
@@ -69,14 +69,14 @@ HMAT ::
                         Entry : 1200
                         Entry : 0200
 
-SLIT ::
+Documentation/driver-api/cxl/platform/acpi/slit.rst ::
 
      Signature : "SLIT"    [System Locality Information Table]
     Localities : 0000000000000003
   Locality   0 : 10 20
   Locality   1 : FF 0A
 
-DSDT ::
+Documentation/driver-api/cxl/platform/acpi/dsdt.rst ::
 
   Scope (_SB)
   {
diff --git a/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst b/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
index 8b732dc8c5b6..ee65b3364c5b 100644
--- a/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
+++ b/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
@@ -14,7 +14,7 @@ Things to note:
 * This CEDT/SRAT describes one-node per device
 * The expanders have the same performance and will be in the same memory tier.
 
-CEDT ::
+Documentation/driver-api/cxl/platform/acpi/cedt.rst ::
 
             Subtable Type : 00 [CXL Host Bridge Structure]
                  Reserved : 00
@@ -62,7 +62,7 @@ CEDT ::
                     QtgId : 0001
              First Target : 00000006
 
-SRAT ::
+Documentation/driver-api/cxl/platform/acpi/srat.rst ::
 
          Subtable Type : 01 [Memory Affinity]
                 Length : 28
@@ -88,7 +88,7 @@ SRAT ::
        Hot Pluggable : 1
         Non-Volatile : 0
 
-HMAT ::
+Documentation/driver-api/cxl/platform/acpi/hmat.rst ::
 
                Structure Type : 0001 [SLLBI]
                     Data Type : 00   [Latency]
@@ -108,7 +108,7 @@ HMAT ::
                         Entry : 0200
                         Entry : 0200
 
-SLIT ::
+Documentation/driver-api/cxl/platform/acpi/slit.rst ::
 
      Signature : "SLIT"    [System Locality Information Table]
     Localities : 0000000000000003
@@ -116,7 +116,7 @@ SLIT ::
   Locality   1 : FF 0A FF
   Locality   2 : FF FF 0A
 
-DSDT ::
+Documentation/driver-api/cxl/platform/acpi/dsdt.rst ::
 
   Scope (_SB)
   {
-- 
2.49.0

