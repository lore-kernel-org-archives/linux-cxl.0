Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151441D86D6
	for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 00:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745971978; cv=none; b=q1dN4vA1noiJ95OqQdrwjAhKbJt0Xa5I28HIZZVwEIFRMiYxstuachkmrga6MVBuVyui7WkcAfPgUfAsq15Rbce7xV/IEUUd1FHehldS+uHMs6A4Amcx1a30HT5fYyj5kJp7ag4Zewe/kktmPD0Y6hVLuOdFOMfvLCD+DDabt+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745971978; c=relaxed/simple;
	bh=5V599XTZxAA6qbUCrLydp2qtu/cxWmE54QcHni3HVGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGPCFz6z1bhIdkFvET1xG8UURIONvkHwpbHs6l2lJSsJf82SUarLEhy1stuKLdB5oBJB6adSLJkEj4hv9Kk/In276jDyYPWUSr+PNrOANuGg1uEztw3FUuhP7g7LSX6sryDDRwzcj7mZtChNgx88s0Ja3OxR+qN7Nmlh1OiOqFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=UKqpuuP2; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="UKqpuuP2"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47698757053so97160091cf.0
        for <linux-cxl@vger.kernel.org>; Tue, 29 Apr 2025 17:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745971974; x=1746576774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KE/unIJlMP8iLZOfjQZ/PwXn8D0sCs62FzmzF2efJyM=;
        b=UKqpuuP2l/w+KSXFw1UK+T9NjMZpGb3Cj1aFsj3bna9VFggzj5NDJh/zduHm6EOmQA
         3KVXbiXYmTSolWHizi+4yg+uRJhNSbQJIClAt/Ur631OGp0KJErMRba4W49eyazttZG8
         xvRu8yIFpNLbT2/ooqYiRB9hUZ7lUMT5T34QPQNpnI51zhLDRUz67C9PGY4CWQ4X6Xjq
         61sOaHUdbuxTyT9vfykUL9rSlV0srNh3UNp4ZO1NoAkzo8d56FV4FsxpVLuhrNod60Ih
         fcn+R74gFt9EuAi45MNzK96AUyJhUBQysIE9eeztx4KBcdyAwHsOoaujdmZZPsrp7s8z
         TB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745971974; x=1746576774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KE/unIJlMP8iLZOfjQZ/PwXn8D0sCs62FzmzF2efJyM=;
        b=A2dCEWi51a2w3ET/PEFHxU78lbRp+OI+hjDBBoV0z+Xj/9M1jNzL/PY33xTjdXNuQY
         ve6VgoUiYN9jBgMJqhqPZPGLwVgDW6ICdxWCSF74BainHKXKi7MIeWHHFR6g4F7IxNpz
         7k8U2P9AF5cuc4MXOeNI19mTvxqzhrfNoYsYjv2UT27azgOZuA1uGay1QXeoYtAktk0z
         MrJKBYdHcdlUilAb3w/HqPmMeBbiKOVZwtV4TC6Xo5Duv6y+z3TOqa9y3FmkQJcqpBlC
         Gpkr81zZ/v/huK/kE0rrO2WNSxIcytAmLtpqt2Gz4iDEKhdTlwDRWUeKgWKAF694iwRs
         /15w==
X-Gm-Message-State: AOJu0YwT0br1h9nOIOn2jSLuebdVKUTvElLVr3A1cA8w8rwyArBH78fp
	Vabry8xhqksRi5uNuVOWFqhwYFCDHVGNcKno9xpMGQvyNSK+WXadr5jc4Iy9NrBK+Dzz1LNbd8b
	F
X-Gm-Gg: ASbGncuadGvKz5T2UlyXgO7XtOfz/AHsDjrKtHCL0UXGyulfgWWjPcMQrrILDLgtxMz
	YguJurUrprUuYW2NaJov2nvifGWO58lZihOaWbDMIclLHUZJBUUdQw4XFl5mIHjsCjZXeO7hTKQ
	lTZELWAwcXI3IWErIC9PqyBlhae1KeVTtChm7Cp9z2kfEUMb3THQXQGXVk6X3uLHkib1q0bVZMe
	/vXDfHeCTr34koma02t7iBarQzLxt3xd+g2uqqPTgzZ+91iREofxyu3/+KthL8ZXbrmzjqboLvZ
	b5QBI8A572Mawm9CJRN8h7TuEZmEt4gsw1ELAB1tgjcEAj0VyQKUwMO5ef84JrBTy0KrhuItKcB
	TKh7Xqks1e89u33Kg/vcWQjcDNnpm
X-Google-Smtp-Source: AGHT+IEHDVkgWjoqnw57UMPr/IbEA4p7aS3feNOIrEU0q2Dur7jRTKnWJHv8ubLZEyWz+0kRa75TEQ==
X-Received: by 2002:a05:622a:580d:b0:478:f8bb:b5e with SMTP id d75a77b69052e-489c3d8aa99mr20146361cf.13.1745971974662;
        Tue, 29 Apr 2025 17:12:54 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f7a820esm87634411cf.41.2025.04.29.17.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:12:54 -0700 (PDT)
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
Subject: [RFC PATCH 11/17] cxl: docs/linux/memory-hotplug
Date: Tue, 29 Apr 2025 20:12:18 -0400
Message-ID: <20250430001224.1028656-12-gourry@gourry.net>
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

Add documentation on how the CXL driver surfaces memory through the
DAX driver and memory-hotplug.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 Documentation/driver-api/cxl/index.rst        |  1 +
 .../driver-api/cxl/linux/memory-hotplug.rst   | 77 +++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/linux/memory-hotplug.rst

diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index bfaf0e2ebfc0..d5186fc609a9 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -39,6 +39,7 @@ that have impacts on each other.  The docs here break up configurations steps.
    linux/early-boot
    linux/cxl-driver
    linux/dax-driver
+   linux/memory-hotplug
    linux/access-coordinates
 
 
diff --git a/Documentation/driver-api/cxl/linux/memory-hotplug.rst b/Documentation/driver-api/cxl/linux/memory-hotplug.rst
new file mode 100644
index 000000000000..a26516a6483e
--- /dev/null
+++ b/Documentation/driver-api/cxl/linux/memory-hotplug.rst
@@ -0,0 +1,77 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Memory Hotplug
+##############
+The final phase of surfacing CXL memory to the kernel page allocator is for
+the `DAX` driver to surface a `Driver Managed` memory region via the
+memory-hotplug component.
+
+There are four major configurations to consider
+
+1) Default Online Behavior (on/off and zone)
+2) Hotplug Memory Block size
+3) Memory Map Resource location
+4) Driver-Managed Memory Designation
+
+Default Online Behavior
+***********************
+The default-online behavior of hotplug memory is dictated by the following,
+in order of precedence:
+
+- :code:`CONFIG_MHP_DEFAULT_ONLINE_TYPE` Build Configuration
+- :code:`memhp_default_state` Boot parameters
+- :code:`/sys/devices/system/memory/auto_online_blocks` value
+
+These dictate whether hotplugged memory blocks arrive in one of three states:
+
+1) Offline
+2) Online in :code:`ZONE_NORMAL`
+3) Online in :code:`ZONE_MOVABLE`
+
+:code:`ZONE_NORMAL` implies this capacity may be used for almost any allocation,
+while :code:`ZONE_MOVABLE` implies this capacity should only be used for
+migratable allocations.
+
+:code:`ZONE_MOVABLE` attempts to retain the hotplug-ability of a memory block
+so that it the entire region may be hot-unplugged at a later time.  Any capacity
+onlined into :code:`ZONE_NORMAL` should be considered permanently attached to
+the page allocator.
+
+Hotplug Memory Block Size
+*************************
+By default, on most architectures, the Hotplug Memory Block Size is either
+128MB or 256MB.  On x86, the block size increases up to 2GB as total memory
+capacity exceeds 64GB.  As of v6.15, Linux does not take into account the
+size and alignment of the ACPI CEDT CFMWS regions (see Early Boot docs) when
+deciding the Hotplug Memory Block Size.
+
+Memory Map
+**********
+The location of :code:`struct folio` allocations to represent the hotplugged
+memory capacity are dicated by the following system settings:
+
+- :code:`/sys_module/memory_hotplug/parameters/memmap_on_memory`
+- :code:`/sys/bus/dax/devices/daxN.Y/memmap_on_memory`
+
+If both of these parameters are set to true, :code:`struct folio` for this
+capacity will be carved out of the memory block being onlined.  This has
+performance implications if the memory is particularly high-latency and
+its :code:`struct folio` becomes hotly contended.
+
+If either parameter is set to false, :code:`struct folio` for this capacity
+will be allocated from the local node of the processor running the hotplug
+procedure.  This capacity will be allocated from :code:`ZONE_NORMAL` on
+that node, as it is a :code:`GFP_KERNEL` allocation.
+
+Systems with extremely large amounts of :code:`ZONE_MOVABLE` memory (e.g.
+CXL memory pools) must ensure that there is sufficient local
+:code:`ZONE_NORMAL` capacity to host the memory map for the hotplugged capacity.
+
+Driver Managed Memory
+*********************
+The DAX driver surfaces this memory to memory-hotplug as "Driver Managed". This
+is not a configurable setting, but it's important to not that driver managed
+memory is explicitly excluded from use during kexec.  This is required to ensure
+any reset or out-of-band operations that the CXL device may be subject to during
+a functional system-reboot (such as a reset-on-probe) will not cause portions of
+the kexec kernel to be overwritten.
-- 
2.49.0

