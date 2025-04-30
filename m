Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BA61AAA1D
	for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 00:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745971969; cv=none; b=IA4FTcRG3fyZlwQ42OXH1qIvOQIM/0zAv2uf1XLWpMKF0xx8kniQsssnjZMr67gtN0AQs1fxVOBv32glraaMcAlEq/XvUCpyEuJO5VtPKT42lsViZQHemxOXRtskDdVcuSQcLQlxLqVqB2QPm410ElDLXcoVYsOAFriSgM3kq3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745971969; c=relaxed/simple;
	bh=JE870abXD6mvQOdGZhbrZh7Dlq87uN7FQJrDxkuYRko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukYuPq9JBJFkMwtFMiWv9GaGJU0v7rmmRWwMA4LSkJmHa6QwYN7i53L43EA+qrBKzoPvfQqdJcpioXM3TBr+W0DQGez7Olabxca8BckGvM5jpJRvgbj6fPBBlJSOfENEUKIq4djExCdsOyJUwEdLDHEybW6wdnxYwPx2Bec3NhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lUSBEjAF; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lUSBEjAF"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-476a720e806so64136731cf.0
        for <linux-cxl@vger.kernel.org>; Tue, 29 Apr 2025 17:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745971966; x=1746576766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzbJ+lbcTmilx4tIqHT+9/1H84YazWKPPxqiI2QgM8c=;
        b=lUSBEjAFbpw40mLUFTYrk5tygPrNk5yzEx0cIsNAqfRVGPXnnhUhDgT8aGhs60DP7L
         211tjICVhpddCL+9AduuNtTRt3IYX5akJWr18eJVrDdk1ykl9CS2rK8IjD+ZvR0h3uNy
         D+d7AhCpCiR0SYtGI41LCgEKALqvc+aT5q/dSLzDhsbc8xrU0NuWKzx442j047wduVug
         cZDE26wmOY4g9yEdim1LRucf8xfpJ232Ki2+YhXfl3SfB6T6MIazVdIFjlG3xXnIB5i7
         5PR7KAxgzeVFHgpQgIJkiAbenHw0S82g2hEKbRqgWo8UYN5sQH6H6l3Mih2YQS19wsO9
         gheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745971966; x=1746576766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzbJ+lbcTmilx4tIqHT+9/1H84YazWKPPxqiI2QgM8c=;
        b=cg2CFp74R2d1hhB6lc/SQFttMZUZh2kP55R247yF0quQROFNDvo96i8hAXrGR7MeqI
         PX5MFSAAZC6L5vqFTbkeFvVGkNM2dVLLHPV4yqN5nU77S0lTAu2X7bBWp6YQB++MqfOq
         7HybtKEGQQlI+cXuDt9rqD1Z77zlXe7bXbLLxG/4M1VKuG7uDFb2Lz+q5cxo1Mp8JNN4
         NwXWRpIRRhKo2bWjtQt8or/3UPUswiquavJ/GQ/5sTLIyfk5x2T5yFvt9EbiyBJqELU2
         MMtVM83dn3miWuMrx1UyJg19w48Sw37bazs+W2bmnDmSC/ejdKa4m7917mjBUuLOHK4w
         zUtw==
X-Gm-Message-State: AOJu0YxG7/F8/3UcdWZegNVmtzLAdMKUopRULsm+rRPqC70WYlncOpSS
	zng9YTrpS43KuWr6zGwsUVdNitTydlYwE6w4FRK9d+fmu6BSxKrcTkXXXgbQQELYTh5V6xFL0dK
	i
X-Gm-Gg: ASbGncs+ziLjjKe3Qj823iQBp2q0GZDlxvq89RG92uGZP/hgWsYVKvfZmWKaLNo1QaO
	e+5O7nMAkVZEaX1OTRBCcbK6ofiO1+zW4/SeDc39qRoUfGx2OYZZwnYBV0EgX8Ko1pL7TY64emS
	vcwpo3nhNs5KQwV85YLwQ/SQBkiMi3mvomZ855hQZ+U24J14HKt+dR0KfaZ7lI2ey09L0RiKZHu
	6cUe/zW9oka/Re78EKGhprC57rXzCJFr5BxlSJ8FdML+fyY1jtDUVjRN4bdHlts7LtSPnEyAvOZ
	OYP3V9PhynyODowLji24wVXbc/wa8YG32RQuaJslLtlwmZHNKe7URajJKOYAdbEb0+gG9hCGkbu
	GiGIlBTLs0Y/t6ipAAVSA/AicTJ2n
X-Google-Smtp-Source: AGHT+IFeXobGzY+UYaAw9ml70E4P3Ut/z3bwXmavgtI4R4ODTbaat+OFdnH3Erfh/wCpOWxEkkV53A==
X-Received: by 2002:a05:622a:5c99:b0:474:eff7:a478 with SMTP id d75a77b69052e-489c5412645mr17505051cf.46.1745971966068;
        Tue, 29 Apr 2025 17:12:46 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f7a820esm87634411cf.41.2025.04.29.17.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:12:45 -0700 (PDT)
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
Subject: [RFC PATCH 07/17] cxl: docs/linux - early boot configuration
Date: Tue, 29 Apr 2025 20:12:14 -0400
Message-ID: <20250430001224.1028656-8-gourry@gourry.net>
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

Document __init time configurations that affect CXL driver probe
process and memory region configuration.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 Documentation/driver-api/cxl/index.rst        |   1 +
 .../driver-api/cxl/linux/early-boot.rst       | 129 ++++++++++++++++++
 2 files changed, 130 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/linux/early-boot.rst

diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index 01c0284fc273..da74480207b7 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -36,6 +36,7 @@ that have impacts on each other.  The docs here break up configurations steps.
    :caption: Linux Kernel Configuration
 
    linux/overview
+   linux/early-boot
    linux/access-coordinates
 
 
diff --git a/Documentation/driver-api/cxl/linux/early-boot.rst b/Documentation/driver-api/cxl/linux/early-boot.rst
new file mode 100644
index 000000000000..ca9fa1b57855
--- /dev/null
+++ b/Documentation/driver-api/cxl/linux/early-boot.rst
@@ -0,0 +1,129 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Linux Init (Early Boot)
+***********************
+
+Linux configuration is split into two major steps: Early-Boot and everything else.
+
+During early boot, Linux sets up immutable resources (such as numa nodes), while
+later operations include things like driver probe and memory hotplug.  Linux may
+read EFI and ACPI information throughout this process to configure logical
+representations of the devices.
+
+During Linux Early Boot stage (functions in the kernel that have the __init
+decorator), the system takes the resources created by EFI/BIOS (ACPI tables)
+and turns them into resources that the kernel can consume.
+
+
+BIOS, Build and Boot Options
+============================
+
+There are 4 pre-boot options that need to be considered during kernel build
+which dictate how memory will be managed by Linux during early boot.
+
+* EFI_MEMORY_SP
+
+  * BIOS/EFI Option that dictates whether memory is SystemRAM or
+    Specific Purpose.  Specific Purpose memory will be deferred to
+    drivers to manage - and not immediately exposed as system RAM.
+
+* CONFIG_EFI_SOFT_RESERVE
+
+  * Linux Build config option that dictates whether the kernel supports
+    Specific Purpose memory.
+
+* CONFIG_MHP_DEFAULT_ONLINE_TYPE
+
+  * Linux Build config that dictates whether and how Specific Purpose memory
+    converted to a dax device should be managed (left as DAX or onlined as
+    SystemRAM in ZONE_NORMAL or ZONE_MOVABLE).
+
+* nosoftreserve
+
+  * Linux kernel boot option that dictates whether Soft Reserve should be
+    supported.  Similar to CONFIG_EFI_SOFT_RESERVE.
+
+Memory Map Creation
+===================
+
+While the kernel parses the EFI memory map, if :code:`Specific Purpose` memory
+is supported and detect, it will set this region aside as :code:`SOFT_RESERVED`.
+
+If :code:`EFI_MEMORY_SP=0`, :code:`CONFIG_EFI_SOFT_RESERVE=n`, or
+:code:`nosoftreserve=y` - Linux will default a CXL device memory region to
+SystemRAM.  This will expose the memory to the kernel page allocator in
+:code:`ZONE_NORMAL`, making it available for use for most allocations (including
+:code:`struct page` and page tables).
+
+If `Specific Purpose` is set and supported, :code:`CONFIG_MHP_DEFAULT_ONLINE_TYPE_*`
+dictates whether the memory is onlined by default (:code:`_OFFLINE` or
+:code:`_ONLINE_*`), and if online which zone to online this memory to by default
+(:code:`_NORMAL` or :code:`_MOVABLE`).
+
+If placed in :code:`ZONE_MOVABLE`, the memory will not be available for most
+kernel allocations (such as :code:`struct page` or page tables).  This may
+significant impact performance depending on the memory capacity of the system.
+
+
+NUMA Node Reservation
+=====================
+
+Linux refers to the proximity domains (:code:`PXM`) defined in the SRAT to
+create NUMA nodes in :code:`acpi_numa_init`. Typically, there is a 1:1 relation
+between :code:`PXM` and NUMA node IDs.
+
+SRAT is the only ACPI defined way of defining Proximity Domains. Linux chooses
+to, at most, map those 1:1 with NUMA nodes. CEDT adds a description of SPA
+ranges which Linux may wish to map to one or more NUMA nodes
+
+If there are CXL ranges in the CFMWS but not in SRAT, then a fake :code:`PXM`
+is created (as of v6.15). In the future, Linux may reject CFMWS not described
+by SRAT due to the ambiguity of proximity domain association.
+
+It is important to note that NUMA node creation cannot be done at runtime. All
+possible NUMA nodes are identified at :code:`__init` time, more specifically
+during :code:`mm_init`. The CEDT and SRAT must contain sufficient :code:`PXM`
+data for Linux to identify NUMA nodes their associated memory regions.
+
+The relevant code exists in: :code:`linux/drivers/acpi/numa/srat.c`.
+
+See the Example Platform Configurations section for more information.
+
+Memory Tiers Creation
+=====================
+Memory tiers are a collection of NUMA nodes grouped by performance characteristics.
+During :code:`__init`, Linux initializes the system with a default memory tier that
+contains all nodes marked :code:`N_MEMORY`.
+
+:code:`memory_tier_init` is called at boot for all nodes with memory online by
+default. :code:`memory_tier_late_init` is called during late-init for nodes setup
+during driver configuration.
+
+Nodes are only marked :code:`N_MEMORY` if they have *online* memory.
+
+Tier membership can be inspected in ::
+
+  /sys/devices/virtual/memory_tiering/memory_tierN/nodelist
+  0-1
+
+If nodes are grouped which have clear difference in performance, check the HMAT
+and CDAT information for the CXL nodes.  All nodes default to the DRAM tier,
+unless HMAT/CDAT information is reported to the memory_tier component via
+`access_coordinates`.
+
+Contiguous Memory Allocation
+============================
+The contiguous memory allocator (CMA) enables reservation of contiguous memory
+regions on NUMA nodes during early boot.  However, CMA cannot reserve memory
+on NUMA nodes that are not online during early boot. ::
+
+  void __init hugetlb_cma_reserve(int order) {
+    if (!node_online(nid))
+      /* do not allow reservations */
+  }
+
+This means if users intend to defer management of CXL memory to the driver, CMA
+cannot be used to guarantee huge page allocations.  If enabling CXL memory as
+SystemRAM in `ZONE_NORMAL` during early boot, CMA reservations per-node can be
+made with the :code:`cma_pernuma` or :code:`numa_cma` kernel command line
+parameters.
-- 
2.49.0

