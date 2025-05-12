Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF4B2951DB
	for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066932; cv=none; b=ib3GBSAL3DulvACX5+BC186Ly/FKXHzx3znwxjsme24/H1opKbqaTeh59Cb3ZtTLCCI5PBIg1HD+Lmn6vH9pdwApl/dPCMKJtZ2KG+p2EI7VQp3E9QQCm1f7ChSFFzQVNVY+Zfx2xx+WFc7a1E86WTmvmsS87BPQp8BGX2Y7PAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066932; c=relaxed/simple;
	bh=A6Mies9hUhfrCMV4P20s2B5vlbK+fHovsvjiHQdVYCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFptW4ZxEqTd2Kv0F+n7J5pqjVIrm8QyGEIbg1w3U3Ur9pIYI9Ths4CjRhuiPRlQemNHW/i3AiyPweV7p3lQ86xtxBwszab/wNrrZ1sgXTYHPZU3tsszuRjkNNrunPMIKYNpjjoFiEoiBeTpFdHcfb4ZjTDlssIUlJQmwYJ2h+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=WHZUZlq+; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="WHZUZlq+"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-47662449055so26191711cf.1
        for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 09:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747066928; x=1747671728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ci6f1K89LsZ+DF6ZgFYZsgSAOzS56KH3yJTL4ef3rh0=;
        b=WHZUZlq+1rTSFZZPWvR1HjwnFQqgSG3OpqUrEt2xKc150AA+9Qj33nRvvGMLLg44YZ
         TM5csfL4HO9k/iW3wBUT5Ka1omzgO5kVKmNMRqYFDxpRWAnkiNYXigersQl8JmrktOAZ
         gdGmyMU5tmijl/Ov+l6i0mIydMzZt3r1u0LQPer9wV/QTGT1N3YXHnVmU8c9hbojzHAN
         P9cwMQ86r0a9728uYlFP4LHAARZRACZCQZxd4fDzVAFfYJH9tUy6y5WATEIM5i/l2nVS
         Zcy2JDgiHMGnWusOVWtQt/h/j1XH22cfgwbcRDboGZh0IURpUimWtN2QgFUPZerIukcp
         a5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747066928; x=1747671728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ci6f1K89LsZ+DF6ZgFYZsgSAOzS56KH3yJTL4ef3rh0=;
        b=kZQwBxDK5K0L0v11kOriTzCY8TnIQUhLxHQfloKM9r1rLgoWyuFxWxTCuI+phDj9jS
         k3VCwwmw79d8qmvMPcNW9/Y9Hs+pqU8f+8QItoIXbKgqQ0RauVTyj/8qyQLR1wVz3OiW
         Z1nBMekaPDpuIRIx+9bgHChrFNJqab9KKBArT0ELF09WSPm5gAI47+jomLaxcZCO986y
         vrZYrb4HzagnU6PWnj6vXYS4n1g/s+xsOUTvswb2BbvLF0enOsMhsPjZIJHweFJjSue9
         5Y58k4/4+6PUvgXal7lVzbyHBZL+xQ7DIwX5/PbLP3vFGxNtjX1JbJlgJIqujKoW4JMc
         9/TA==
X-Gm-Message-State: AOJu0YzEOAQPsSG7iWFJhhNE/vS3vWHXjvUfLIBB88Wa03RMAfOLbLGJ
	Fdf0EhAuCmb9GNbRjhUUS0rFkHnGnGh7DzWtQlxE4hoXIHtE/GOzUklYNodNWhGvcF6u583GT7H
	2
X-Gm-Gg: ASbGncscqBpCsDIzm9dk4r6C6RXYUb5PZZ32aCyqaH0YtEcNKeecN6Cuw7kkXQpfrRN
	itlSbSP78xdzySu5HnU9HZDzwr7oLaDFHHfo4uyzl47D6Bu0H0DHgwmpvRMQroZd5PxoiZFfv8F
	RKpy2YD9mqhjsBRea+6qr4jOEcoYdPUF/KfflnM4KwqMBnZPj+MfxGP7aLHzXp75nbyi8bEQZlz
	4oGv8PfZrraUWiKBSsH+UeYTYzgO07TQ9rEoWzxIUnw9X/PIxrF9UQZO+1Wqjn7ruRUYda5ndwq
	vQNwv61J8mqsannHHlYj9nDDtynl2c3FbAuDni4hx6VQURUEcqAWn4nn7ZbOwMSkr2DrY3rn+PU
	5bTEf2p6/aYjRe/YctadS+TtqI/lcOd3bP4HTJoqBYdJ1HNQ=
X-Google-Smtp-Source: AGHT+IE6kifyyq68JXmdCyyHqCef0H7CrWN95iUQ8mmLv4UnZnRRmN3QUvUDR9Mvy0G1oQqLngMKog==
X-Received: by 2002:a05:622a:1984:b0:476:ac73:c3f3 with SMTP id d75a77b69052e-494527162demr247105181cf.1.1747066928404;
        Mon, 12 May 2025 09:22:08 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583961sm52461791cf.58.2025.05.12.09.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 09:22:08 -0700 (PDT)
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
	corbet@lwn.net,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v3 17/17] cxl: docs - add self-referencing cross-links
Date: Mon, 12 May 2025 12:21:34 -0400
Message-ID: <20250512162134.3596150-18-gourry@gourry.net>
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

Add some crosslinks between pages in the CXL docs - mostly to the
ACPI tables.

Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 .../driver-api/cxl/devices/device-types.rst   |  2 +-
 .../cxl/linux/access-coordinates.rst          |  7 ++--
 .../driver-api/cxl/linux/cxl-driver.rst       | 35 ++++++++++---------
 .../driver-api/cxl/linux/early-boot.rst       | 32 ++++++++++-------
 .../driver-api/cxl/platform/bios-and-efi.rst  | 12 +++----
 .../example-configurations/flexible.rst       | 10 +++---
 .../example-configurations/hb-interleave.rst  | 10 +++---
 .../multi-dev-per-hb.rst                      | 10 +++---
 .../example-configurations/one-dev-per-hb.rst | 10 +++---
 9 files changed, 69 insertions(+), 59 deletions(-)

diff --git a/Documentation/driver-api/cxl/devices/device-types.rst b/Documentation/driver-api/cxl/devices/device-types.rst
index c70564cf0be3..f5e4330c1cfe 100644
--- a/Documentation/driver-api/cxl/devices/device-types.rst
+++ b/Documentation/driver-api/cxl/devices/device-types.rst
@@ -115,7 +115,7 @@ A Multi-Headed Single-Logical Device (MHSLD) exposes a single logical
 device to multiple heads which may be connected to one or more discrete
 hosts.  An example of this would be a simple memory-pool which may be
 statically configured (prior to boot) to expose portions of its memory
-to Linux via the CEDT ACPI table.
+to Linux via :doc:`CEDT <../platform/acpi/cedt>`.
 
 MHMLD
 ~~~~~
diff --git a/Documentation/driver-api/cxl/linux/access-coordinates.rst b/Documentation/driver-api/cxl/linux/access-coordinates.rst
index e408ecbc4038..71024fa0f561 100644
--- a/Documentation/driver-api/cxl/linux/access-coordinates.rst
+++ b/Documentation/driver-api/cxl/linux/access-coordinates.rst
@@ -24,7 +24,7 @@ asymmetry in properties does not happen and all paths to EPs are equal.
 
 There can be multiple switches under an RP. There can be multiple RPs under
 a CXL Host Bridge (HB). There can be multiple HBs under a CXL Fixed Memory
-Window Structure (CFMWS).
+Window Structure (CFMWS) in the :doc:`CEDT <../platform/acpi/cedt>`.
 
 An example hierarchy::
 
@@ -83,8 +83,9 @@ also the index for the resulting xarray.
 
 The next step is to take the min() of the per host bridge bandwidth and the
 bandwidth from the Generic Port (GP). The bandwidths for the GP are retrieved
-via ACPI tables SRAT/HMAT. The minimum bandwidth are aggregated under the same
-ACPI0017 device to form a new xarray.
+via ACPI tables (:doc:`SRAT <../platform/acpi/srat>` and
+:doc:`HMAT <../platform/acpi/hmat>`). The minimum bandwidth are aggregated
+under the same ACPI0017 device to form a new xarray.
 
 Finally, the cxl_region_update_bandwidth() is called and the aggregated
 bandwidth from all the members of the last xarray is updated for the
diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
index cf6b397abdb1..9759e90c3cf1 100644
--- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
+++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
@@ -77,11 +77,11 @@ Root Object` Device Class is found.
 
 The Root contains links to:
 
-* `Host Bridge Ports` defined by ACPI CEDT CHBS.
+* `Host Bridge Ports` defined by CHBS in the :doc:`CEDT<../platform/acpi/cedt>`
 
 * `Downstream Ports` typically connected to `Host Bridge Ports`.
 
-* `Root Decoders` defined by ACPI CEDT CFMWS.
+* `Root Decoders` defined by CFMWS the :doc:`CEDT<../platform/acpi/cedt>`
 
 ::
 
@@ -150,9 +150,8 @@ An `endpoint` is a terminal port in the fabric.  This is a `logical device`,
 and may be one of many `logical devices` presented by a memory device. It
 is still considered a type of `port` in the fabric.
 
-An `endpoint` contains `endpoint decoders` available for use and the
-*Coherent Device Attribute Table* (CDAT) used to describe the capabilities
-of the device. ::
+An `endpoint` contains `endpoint decoders` and the device's Coherent Device
+Attribute Table (which describes the device's capabilities). ::
 
   # ls /sys/bus/cxl/devices/endpoint5
     CDAT        decoders_committed  modalias      uevent
@@ -247,17 +246,18 @@ parameter.
 Root Decoder
 ~~~~~~~~~~~~
 A `Root Decoder` is logical construct of the physical address and interleave
-configurations present in the ACPI CEDT CFMWS.  Linux presents this information
-as a decoder present in the `CXL Root`.  We consider this a `Root Decoder`,
-though technically it exists on the boundary of the CXL specification and
-platform-specific CXL root implementations.
+configurations present in the CFMWS field of the :doc:`CEDT
+<../platform/acpi/cedt>`.
+Linux presents this information as a decoder present in the `CXL Root`.  We
+consider this a `Root Decoder`, though technically it exists on the boundary
+of the CXL specification and platform-specific CXL root implementations.
 
 Linux considers these logical decoders a type of `Routing Decoder`, and is the
 first decoder in the CXL fabric to receive a memory access from the platform's
 memory controllers.
 
 `Root Decoders` are created during :code:`cxl_acpi_probe`.  One root decoder
-is created per CFMWS entry in the ACPI CEDT.
+is created per CFMWS entry in the :doc:`CEDT <../platform/acpi/cedt>`.
 
 The :code:`target_list` parameter is filled by the CFMWS target fields. Targets
 of a root decoder are `Host Bridges`, which means interleave done at the root
@@ -267,9 +267,11 @@ Only root decoders are capable of `Inter-Host-Bridge Interleave`.
 
 Such interleaves must be configured by the platform and described in the ACPI
 CEDT CFMWS, as the target CXL host bridge UIDs in the CFMWS must match the CXL
-host bridge UIDs in the ACPI CEDT CHBS and ACPI DSDT.
+host bridge UIDs in the CHBS field of the :doc:`CEDT
+<../platform/acpi/cedt>` and the UID field of CXL Host Bridges defined in
+the :doc:`DSDT <../platform/acpi/dsdt>`.
 
-Interleave settings in a rootdecoder describe how to interleave accesses among
+Interleave settings in a root decoder describe how to interleave accesses among
 the *immediate downstream targets*, not the entire interleave set.
 
 The memory range described in the root decoder is used to
@@ -531,10 +533,11 @@ granularity configuration.
 
 At Root
 ~~~~~~~
-Root decoder interleave is defined by the ACPI CEDT CFMWS.  The CEDT
-may actually define multiple CFMWS configurations to describe the same
-physical capacity - with the intent to allow users to decide at runtime
-whether to online memory as interleaved or non-interleaved. ::
+Root decoder interleave is defined by CFMWS field of the :doc:`CEDT
+<../platform/acpi/cedt>`.  The CEDT may actually define multiple CFMWS
+configurations to describe the same physical capacity, with the intent to allow
+users to decide at runtime whether to online memory as interleaved or
+non-interleaved. ::
 
              Subtable Type : 01 [CXL Fixed Memory Window Structure]
        Window base address : 0000000100000000
diff --git a/Documentation/driver-api/cxl/linux/early-boot.rst b/Documentation/driver-api/cxl/linux/early-boot.rst
index 8c1c497bc772..a7fc6fc85fbe 100644
--- a/Documentation/driver-api/cxl/linux/early-boot.rst
+++ b/Documentation/driver-api/cxl/linux/early-boot.rst
@@ -12,8 +12,9 @@ read EFI and ACPI information throughout this process to configure logical
 representations of the devices.
 
 During Linux Early Boot stage (functions in the kernel that have the __init
-decorator), the system takes the resources created by EFI/BIOS (ACPI tables)
-and turns them into resources that the kernel can consume.
+decorator), the system takes the resources created by EFI/BIOS
+(:doc:`ACPI tables <../platform/acpi>`) and turns them into resources that the
+kernel can consume.
 
 
 BIOS, Build and Boot Options
@@ -70,13 +71,14 @@ significant impact performance depending on the memory capacity of the system.
 NUMA Node Reservation
 =====================
 
-Linux refers to the proximity domains (:code:`PXM`) defined in the SRAT to
-create NUMA nodes in :code:`acpi_numa_init`. Typically, there is a 1:1 relation
-between :code:`PXM` and NUMA node IDs.
+Linux refers to the proximity domains (:code:`PXM`) defined in the :doc:`SRAT
+<../platform/acpi/srat>` to create NUMA nodes in :code:`acpi_numa_init`.
+Typically, there is a 1:1 relation between :code:`PXM` and NUMA node IDs.
 
-SRAT is the only ACPI defined way of defining Proximity Domains. Linux chooses
-to, at most, map those 1:1 with NUMA nodes. CEDT adds a description of SPA
-ranges which Linux may wish to map to one or more NUMA nodes.
+The SRAT is the only ACPI defined way of defining Proximity Domains. Linux
+chooses to, at most, map those 1:1 with NUMA nodes.
+:doc:`CEDT <../platform/acpi/cedt>` adds a description of SPA ranges which
+Linux may map to one or more NUMA nodes.
 
 If there are CXL ranges in the CFMWS but not in SRAT, then a fake :code:`PXM`
 is created (as of v6.15). In the future, Linux may reject CFMWS not described
@@ -89,7 +91,8 @@ data for Linux to identify NUMA nodes their associated memory regions.
 
 The relevant code exists in: :code:`linux/drivers/acpi/numa/srat.c`.
 
-See the Example Platform Configurations section for more information.
+See :doc:`Example Platform Configurations <../platform/example-configs>`
+for more info.
 
 Memory Tiers Creation
 =====================
@@ -108,10 +111,13 @@ Tier membership can be inspected in ::
   /sys/devices/virtual/memory_tiering/memory_tierN/nodelist
   0-1
 
-If nodes are grouped which have clear difference in performance, check the HMAT
-and CDAT information for the CXL nodes.  All nodes default to the DRAM tier,
-unless HMAT/CDAT information is reported to the memory_tier component via
-`access_coordinates`.
+If nodes are grouped which have clear difference in performance, check the
+:doc:`HMAT <../platform/acpi/hmat>` and CDAT information for the CXL nodes. All
+nodes default to the DRAM tier, unless HMAT/CDAT information is reported to the
+memory_tier component via `access_coordinates`.
+
+For more, see :doc:`CXL access coordinates documentation
+<../linux/access-coordinates>`.
 
 Contiguous Memory Allocation
 ============================
diff --git a/Documentation/driver-api/cxl/platform/bios-and-efi.rst b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
index 552a83992bcc..645322632cc9 100644
--- a/Documentation/driver-api/cxl/platform/bios-and-efi.rst
+++ b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
@@ -22,7 +22,7 @@ At a high level, this is what occurs during this phase of configuration.
 
 Much of what this section is concerned with is ACPI Table production and
 static memory map configuration. More detail on these tables can be found
-under Platform Configuration -> ACPI Table Reference.
+at :doc:`ACPI Tables <acpi>`.
 
 .. note::
    Platform Vendors should read carefully, as this sections has recommendations
@@ -175,9 +175,9 @@ to implement driver support for your platform.
 
 Interleave and Configuration Flexibility
 ----------------------------------------
-If providing cross-host-bridge interleave, a CFMWS entry in the CEDT must be
-presented with target host-bridges for the interleaved device sets (there may
-be multiple behind each host bridge).
+If providing cross-host-bridge interleave, a CFMWS entry in the :doc:`CEDT
+<acpi/cedt>` must be presented with target host-bridges for the interleaved
+device sets (there may be multiple behind each host bridge).
 
 If providing intra-host-bridge interleaving, only 1 CFMWS entry in the CEDT is
 required for that host bridge - if it covers the entire capacity of the devices
@@ -193,8 +193,8 @@ different purposes.  For example, you may want to consider adding:
 
 A platform may choose to add all of these, or change the mode based on a BIOS
 setting.  For each CFMWS entry, Linux expects descriptions of the described
-memory regions in the SRAT to determine the number of NUMA nodes it should
-reserve during early boot / init.
+memory regions in the :doc:`SRAT <acpi/srat>` to determine the number of
+NUMA nodes it should reserve during early boot / init.
 
 As of v6.14, Linux will create a NUMA node for each CEDT CFMWS entry, even if
 a matching SRAT entry does not exist; however, this is not guaranteed in the
diff --git a/Documentation/driver-api/cxl/platform/example-configurations/flexible.rst b/Documentation/driver-api/cxl/platform/example-configurations/flexible.rst
index e39daba65fa0..dab704b6fcc2 100644
--- a/Documentation/driver-api/cxl/platform/example-configurations/flexible.rst
+++ b/Documentation/driver-api/cxl/platform/example-configurations/flexible.rst
@@ -18,7 +18,7 @@ Things to note:
 * This SRAT describes one node for each of the above CFMWS.
 * The HMAT describes performance for each node in the SRAT.
 
-CEDT ::
+:doc:`CEDT <../acpi/cedt>`::
 
             Subtable Type : 00 [CXL Host Bridge Structure]
                  Reserved : 00
@@ -137,7 +137,7 @@ CEDT ::
                     QtgId : 0001
              First Target : 00000006
 
-SRAT ::
+:doc:`SRAT <../acpi/srat>`::
 
          Subtable Type : 01 [Memory Affinity]
                 Length : 28
@@ -223,7 +223,7 @@ SRAT ::
        Hot Pluggable : 1
         Non-Volatile : 0
 
-HMAT ::
+:doc:`HMAT <../acpi/hmat>`::
 
                Structure Type : 0001 [SLLBI]
                     Data Type : 00   [Latency]
@@ -263,7 +263,7 @@ HMAT ::
                         Entry : 0100
                         Entry : 0100
 
-SLIT ::
+:doc:`SLIT <../acpi/slit>`::
 
      Signature : "SLIT"    [System Locality Information Table]
     Localities : 0000000000000003
@@ -276,7 +276,7 @@ SLIT ::
   Locality   6 : FF FF FF FF FF FF 0A FF
   Locality   7 : FF FF FF FF FF FF FF 0A
 
-DSDT ::
+:doc:`DSDT <../acpi/dsdt>`::
 
   Scope (_SB)
   {
diff --git a/Documentation/driver-api/cxl/platform/example-configurations/hb-interleave.rst b/Documentation/driver-api/cxl/platform/example-configurations/hb-interleave.rst
index ce07e6162f26..c474dcf09fb0 100644
--- a/Documentation/driver-api/cxl/platform/example-configurations/hb-interleave.rst
+++ b/Documentation/driver-api/cxl/platform/example-configurations/hb-interleave.rst
@@ -13,7 +13,7 @@ Things to note:
 * This SRAT describes one node for both host bridges.
 * The HMAT describes a single node's performance.
 
-CEDT ::
+:doc:`CEDT <../acpi/cedt>`::
 
             Subtable Type : 00 [CXL Host Bridge Structure]
                  Reserved : 00
@@ -48,7 +48,7 @@ CEDT ::
              First Target : 00000007
             Second Target : 00000006
 
-SRAT ::
+:doc:`SRAT <../acpi/srat>`::
 
          Subtable Type : 01 [Memory Affinity]
                 Length : 28
@@ -62,7 +62,7 @@ SRAT ::
        Hot Pluggable : 1
         Non-Volatile : 0
 
-HMAT ::
+:doc:`HMAT <../acpi/hmat>`::
 
                Structure Type : 0001 [SLLBI]
                     Data Type : 00   [Latency]
@@ -80,14 +80,14 @@ HMAT ::
                         Entry : 1200
                         Entry : 0400
 
-SLIT ::
+:doc:`SLIT <../acpi/slit>`::
 
      Signature : "SLIT"    [System Locality Information Table]
     Localities : 0000000000000003
   Locality   0 : 10 20
   Locality   1 : FF 0A
 
-DSDT ::
+:doc:`DSDT <../acpi/dsdt>`::
 
   Scope (_SB)
   {
diff --git a/Documentation/driver-api/cxl/platform/example-configurations/multi-dev-per-hb.rst b/Documentation/driver-api/cxl/platform/example-configurations/multi-dev-per-hb.rst
index 6adf7c639490..a7854a79dbbd 100644
--- a/Documentation/driver-api/cxl/platform/example-configurations/multi-dev-per-hb.rst
+++ b/Documentation/driver-api/cxl/platform/example-configurations/multi-dev-per-hb.rst
@@ -14,7 +14,7 @@ Things to note:
 * This CEDT/SRAT describes one node for both devices.
 * There is only one proximity domain the HMAT for both devices.
 
-CEDT ::
+:doc:`CEDT <../acpi/cedt>`::
 
             Subtable Type : 00 [CXL Host Bridge Structure]
                  Reserved : 00
@@ -39,7 +39,7 @@ CEDT ::
                     QtgId : 0001
              First Target : 00000007
 
-SRAT ::
+:doc:`SRAT <../acpi/srat>`::
 
          Subtable Type : 01 [Memory Affinity]
                 Length : 28
@@ -53,7 +53,7 @@ SRAT ::
        Hot Pluggable : 1
         Non-Volatile : 0
 
-HMAT ::
+:doc:`HMAT <../acpi/hmat>`::
 
                Structure Type : 0001 [SLLBI]
                     Data Type : 00   [Latency]
@@ -69,14 +69,14 @@ HMAT ::
                         Entry : 1200
                         Entry : 0200
 
-SLIT ::
+:doc:`SLIT <../acpi/slit>`::
 
      Signature : "SLIT"    [System Locality Information Table]
     Localities : 0000000000000003
   Locality   0 : 10 20
   Locality   1 : FF 0A
 
-DSDT ::
+:doc:`DSDT <../acpi/dsdt>`::
 
   Scope (_SB)
   {
diff --git a/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst b/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
index b89ba3cab98f..aebda0eb3e17 100644
--- a/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
+++ b/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
@@ -14,7 +14,7 @@ Things to note:
 * This CEDT/SRAT describes one node per device
 * The expanders have the same performance and will be in the same memory tier.
 
-CEDT ::
+:doc:`CEDT <../acpi/cedt>`::
 
             Subtable Type : 00 [CXL Host Bridge Structure]
                  Reserved : 00
@@ -62,7 +62,7 @@ CEDT ::
                     QtgId : 0001
              First Target : 00000006
 
-SRAT ::
+:doc:`SRAT <../acpi/srat>`::
 
          Subtable Type : 01 [Memory Affinity]
                 Length : 28
@@ -88,7 +88,7 @@ SRAT ::
        Hot Pluggable : 1
         Non-Volatile : 0
 
-HMAT ::
+:doc:`HMAT <../acpi/hmat>`::
 
                Structure Type : 0001 [SLLBI]
                     Data Type : 00   [Latency]
@@ -108,7 +108,7 @@ HMAT ::
                         Entry : 0200
                         Entry : 0200
 
-SLIT ::
+:doc:`SLIT <../acpi/slit>`::
 
      Signature : "SLIT"    [System Locality Information Table]
     Localities : 0000000000000003
@@ -116,7 +116,7 @@ SLIT ::
   Locality   1 : FF 0A FF
   Locality   2 : FF FF 0A
 
-DSDT ::
+:doc:`DSDT <../acpi/dsdt>`::
 
   Scope (_SB)
   {
-- 
2.49.0

