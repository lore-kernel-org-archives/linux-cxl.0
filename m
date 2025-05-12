Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4335D2571D0
	for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066924; cv=none; b=dA8fLA7Ox64NytLQPPPlLD7Fo2Z79fXVT2w6Bk+t2uRB2IcI+W7iFBl687kgdH5FwdMh1fBn5Zv+1dWgtZEEOOncwccPQyZwQJmxkTkX8PgMvtD85di+4daj+luWP0fnxbSPpx4HdnhLe5Z/zEOw2Hm1m09mSvLHs8zncz0lTbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066924; c=relaxed/simple;
	bh=5OMS59Fls7yssVe/eBHwNamMLgl3UdidmTKUG9C1bZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OmxtJnyz9bxnnQP2SNC5LKLErvHrCq3Ml5PoR7Rn9d4dypQv/Un+TVtKSVml5L5EghHsRhdTUq/sme8Q6dmgmT1p+nQuoJJiY/VJl/g1MO51184d01YOPa94IuiWGcEfxQh4cOpnVME18JAZkRMnXrZUzH5OPVzXKIa6oyzwSAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=idlrGWSh; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="idlrGWSh"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c59e7039eeso724551685a.2
        for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 09:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747066921; x=1747671721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jt/521w64tsazt1m4c92762k12ji8Xm+LaBsIndvwlE=;
        b=idlrGWShYcmS0kBdN03qsDplFZD51eVgFIUDAh04x6UNfmnz8JbmVD4rRHDXMstURM
         UuQBfy5SZQj0G9OkyV/zcxTCljHNknoeS5rbipkh1YKJI0hSw3TjP7PaQWd3zulgUpc5
         fvrlNh3ibagZthQc3Cgy9Gj+1bg1OC84HNsYArRqmVCAYlYp3FZaFKI6PyUc79yDK38Q
         O7yGZ27QZwb3s1lW4n/hy+EbOTifKJ17ugoVxytjSizHoPvLdZJmGoFRH9sfcgthXf90
         9hbn8oqHE+FIS0lm2KSKwJlvAojVlsP3RAJ4o4Mw6JeNS6zLEDqiIIT5LwJv+4PSj3y7
         UwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747066921; x=1747671721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jt/521w64tsazt1m4c92762k12ji8Xm+LaBsIndvwlE=;
        b=iD2ODGBpGLjn4q/DGN7GStA1NcztpFQGbm1K+moojIjXjCSFQ/GHRP8d6cSJglf1Da
         H5cxUXICqaC3Wl5IML6LhRVtGJdeJINdiFHrH/ILcw+SIh/TMZ23sd/qcHy+aHJx3nQb
         +f0yPy9bkoH6vq6ZgbpSobyTrc5TawALBi+6R+5J2A5lIRrADmBmE6TNLQCvzf3exG9O
         EfTr4BC3kjDVAVVNndJh1q5QNTkQGN1SEM3JYIPbWNlLnLfF5AyGVkl6dwcW4h4H1Lua
         WRlOndWqyHE1OL2JnFZs8pKcBmPCLr0YYGVXkf7Uu7zRfUMGt76X5ymahfnf5bxD1fWa
         mpow==
X-Gm-Message-State: AOJu0YxkKaj4rkNZ7d6V2dmAHYz0lNMWtxi31E2D6kU4SPcIRByfIPfz
	b+IxvKScgdYBm8xKAffRkq8mC+vGDx/j9JB5un3ee8GfFjJ7U2xiyKdrkrjiMqWfkrEBhSH0+oR
	U
X-Gm-Gg: ASbGnctH9x8D21Z2vzNCnSMp3Djpo0hlYdvKxh4NxwO65FJ/jR2+IRc8L0LZSjSZjeh
	NdXc4jn/Qw+VtCTpIIMkahoz2uUsUphzVbjCHUKd30/Gi/uSGwdnjjIt/mvMENbm9Ad+kW2RvED
	qs8BvhwASxXR0M5ZvS+XemPjbZzLaxAq4MqFJDg3iLQH9LCuvSYFIY/dM+OMRf+ztTLCQGlhp1H
	4ardZ4EiXktNPscFI212RYhgf9TK7vmJS9qkMwvv6POL9hbLQDcUP4slJi5tgUl3uJmrxPR7CvT
	bPzFzyRZpGndpLF8VaV449C5/cd4mvxJhZ6L0FnFhCJoyLnU37vAi79uizFkdgKCyR82T/82ClH
	SbNHyvYvnwAgxsp4Q+QHVFYd5My3DIFQNrilh
X-Google-Smtp-Source: AGHT+IGgq4dX8u+VS136dy5RsF6lNNfBNEBuuVYsuUsKinYkKNcF5+J+dn7L3DuanbNeTbM5peQhrw==
X-Received: by 2002:a05:6214:400b:b0:6e4:2dcb:33c8 with SMTP id 6a1803df08f44-6f6e4802e14mr217368156d6.29.1747066906925;
        Mon, 12 May 2025 09:21:46 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583961sm52461791cf.58.2025.05.12.09.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 09:21:46 -0700 (PDT)
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
Subject: [PATCH v3 03/17] cxl: docs/devices - add cxl device and protocol reference
Date: Mon, 12 May 2025 12:21:20 -0400
Message-ID: <20250512162134.3596150-4-gourry@gourry.net>
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

Add a simple device primer sufficient to understand the theory
of operation documentation.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 .../driver-api/cxl/devices/device-types.rst   | 165 ++++++++++++++++++
 Documentation/driver-api/cxl/index.rst        |   6 +
 2 files changed, 171 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/devices/device-types.rst

diff --git a/Documentation/driver-api/cxl/devices/device-types.rst b/Documentation/driver-api/cxl/devices/device-types.rst
new file mode 100644
index 000000000000..c70564cf0be3
--- /dev/null
+++ b/Documentation/driver-api/cxl/devices/device-types.rst
@@ -0,0 +1,165 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+Devices and Protocols
+=====================
+
+The type of CXL device (Memory, Accelerator, etc) dictates many configuration steps. This section
+covers some basic background on device types and on-device resources used by the platform and OS
+which impact configuration.
+
+Protocols
+=========
+
+There are three core protocols to CXL.  For the purpose of this documentation,
+we will only discuss very high level definitions as the specific hardware
+details are largely abstracted away from Linux.  See the CXL specification
+for more details.
+
+CXL.io
+------
+The basic interaction protocol, similar to PCIe configuration mechanisms.
+Typically used for initialization, configuration, and I/O access for anything
+other than memory (CXL.mem) or cache (CXL.cache) operations.
+
+The Linux CXL driver exposes access to .io functionalty via the various sysfs
+interfaces and /dev/cxl/ devices (which exposes direct access to device
+mailboxes).
+
+CXL.cache
+---------
+The mechanism by which a device may coherently access and cache host memory.
+
+Largely transparent to Linux once configured.
+
+CXL.mem
+---------
+The mechanism by which the CPU may coherently access and cache device memory.
+
+Largely transparent to Linux once configured.
+
+
+Device Types
+============
+
+Type-1
+------
+
+A Type-1 CXL device:
+
+* Supports cxl.io and cxl.cache protocols
+* Implements a fully coherent cache
+* Allows Device-to-Host coherence and Host-to-Device snoops.
+* Does NOT have host-managed device memory (HDM)
+
+Typical examples of type-1 devices is a Smart NIC - which may want to
+directly operate on host-memory (DMA) to store incoming packets. These
+devices largely rely on CPU-attached memory.
+
+Type-2
+------
+
+A Type-2 CXL Device:
+
+* Supports cxl.io, cxl.cache, and cxl.mem protocols
+* Optionally implements coherent cache and Host-Managed Device Memory
+* Is typically an accelerator device w/ high bandwidth memory.
+
+The primary difference between a type-1 and type-2 device is the presence
+of host-managed device memory, which allows the device to operate on a
+local memory bank - while the CPU sill has coherent DMA to the same memory.
+
+The allows things like GPUs to expose their memory via DAX devices or file
+descriptors, allows drivers and programs direct access to device memory
+rather than use block-transfer semantics.
+
+Type-3
+------
+
+A Type-3 CXL Device
+
+* Supports cxl.io and cxl.mem
+* Implements Host-Managed Device Memory
+* May provide either Volatile or Persistent memory capacity (or both).
+
+A basic example of a type-3 device is a simple memory expander, whose
+local memory capacity is exposed to the CPU for access directly via
+basic coherent DMA.
+
+Switch
+------
+
+A CXL switch is a device capacity of routing any CXL (and by extension, PCIe)
+protocol between an upstream, downstream, or peer devices.  Many devices, such
+as Multi-Logical Devices, imply the presence of switching in some manner.
+
+Logical Devices and Heads
+-------------------------
+
+A CXL device may present one or more "Logical Devices" to one or more hosts
+(via physical "Heads").
+
+A Single-Logical Device (SLD) is a device which presents a single device to
+one or more heads.
+
+A Multi-Logical Device (MLD) is a device which may present multiple devices
+to one or more devices.
+
+A Single-Headed Device exposes only a single physical connection.
+
+A Multi-Headed Device exposes multiple physical connections.
+
+MHSLD
+~~~~~
+A Multi-Headed Single-Logical Device (MHSLD) exposes a single logical
+device to multiple heads which may be connected to one or more discrete
+hosts.  An example of this would be a simple memory-pool which may be
+statically configured (prior to boot) to expose portions of its memory
+to Linux via the CEDT ACPI table.
+
+MHMLD
+~~~~~
+A Multi-Headed Multi-Logical Device (MHMLD) exposes multiple logical
+devices to multiple heads which may be connected to one or more discrete
+hosts.  An example of this would be a Dynamic Capacity Device or which
+may be configured at runtime to expose portions of its memory to Linux.
+
+Example Devices
+===============
+
+Memory Expander
+---------------
+The simplest form of Type-3 device is a memory expander.  A memory expander
+exposes Host-Managed Device Memory (HDM) to Linux.  This memory may be
+Volatile or Non-Volatile (Persistent).
+
+Memory Expanders will typically be considered a form of Single-Headed,
+Single-Logical Device - as its form factor will typically be an add-in-card
+(AIC) or some other similar form-factor.
+
+The Linux CXL driver provides support for static or dynamic configuration of
+basic memory expanders.  The platform may program decoders prior to OS init
+(e.g. auto-decoders), or the user may program the fabric if the platform
+defers these operations to the OS.
+
+Multiple Memory Expanders may be added to an external chassis and exposed to
+a host via a head attached to a CXL switch.  This is a "memory pool", and
+would be considered an MHSLD or MHMLD depending on the management capabilities
+provided by the switch platform.
+
+As of v6.14, Linux does not provide a formalized interface to manage non-DCD
+MHSLD or MHMLD devices.
+
+Dynamic Capacity Device (DCD)
+-----------------------------
+
+A Dynamic Capacity Device is a Type-3 device which provides dynamic management
+of memory capacity. The basic premise of a DCD to provide an allocator-like
+interface for physical memory capacity to a "Fabric Manager" (an external,
+privileged host with privileges to change configurations for other hosts).
+
+A DCD manages "Memory Extents", which may be volatile or persistent. Extents
+may also be exclusive to a single host or shared across multiple hosts.
+
+As of v6.14, Linux does not provide a formalized interface to manage DCD
+devices, however there is active work on LKML targeting future release.
diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index fe1594dc6778..a2d1c5b18a8a 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -15,6 +15,12 @@ that have impacts on each other.  The docs here break up configurations steps.
    theory-of-operation
    maturity-map
 
+.. toctree::
+   :maxdepth: 2
+   :caption: Device Reference
+
+   devices/device-types
+
 .. toctree::
    :maxdepth: 1
    :caption: Linux Kernel Configuration
-- 
2.49.0

