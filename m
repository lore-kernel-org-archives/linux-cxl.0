Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F4129293D
	for <linux-cxl@vger.kernel.org>; Thu, 18 Dec 2025 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766069238; cv=none; b=k5TyUEkBccmkcZzyJh0VTE7BsJ8S64IMTG9y2wjMuH9Fyp84BkvB0AYOyTZJlLfaGEDSZQM7Hoqnp0BL4qMCLfH4Tgf1VYKsxxmOvul7nMtuNv7ChGzAWyeBq/5j3qlmNHjed4yFFVj3SFS4PJSjTwUbdC0l59QjoSUv/ZpSxh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766069238; c=relaxed/simple;
	bh=wUkrh8TV1+RwPKNKqlybTP/4u0tI61BgBs1sDpD1Mn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oGnnxhsN/YlS8OK1MJ4kau2oTwN+zqMFpDX/iSrWX01oD2YBc3LXJJU0qk7SMUvcWBDeASQTje1IJugY9b+ZCK6sLOKLX/KMMY4nCPn6cR8RHlejpxqvTK9D+HRWtT1pvpq4EOSpMcLMHuoU9hed3VhY9Q9YZNAMm+hjt/dwNWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=FguINTqc; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="FguINTqc"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8b2627269d5so73498785a.2
        for <linux-cxl@vger.kernel.org>; Thu, 18 Dec 2025 06:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1766069235; x=1766674035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=80Wj3hQjVTosfLzfe42v+uXysTzJn7NF93jJAzRmue0=;
        b=FguINTqc/xR8BzBmDZJE/YWPVmI0KgSp++X/tMalDopEJeOOTblT+a8USadhSBMelJ
         1tOxOoCdAd/GfPB785xWwcUfUx+az0ZX+1SpAFaiJfTGMmMNCyu7TWtKFsWpLBNkw3aY
         NXjfDxB796Y7sj26k6Elj8mahTmLSLvxQZccBqYg6k8S+oeTrdz5MY4osGhP+WyHWUJJ
         kF0jXl+W+QyyTmwpQP7AGMyb5Ydl6QIQ8U0GEVbuvpXIBzhl1RmArxdSywmuDL2F/2R0
         Q24U2DQH+L/y1dUZ8l/ORhb3wQiwZYAJAFem378n60cOkoiZmIpa0g4RlQHkh7ZtBPPx
         1lrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766069235; x=1766674035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80Wj3hQjVTosfLzfe42v+uXysTzJn7NF93jJAzRmue0=;
        b=tn/kiP39GGF0X5NGeI0QtR1JcVN7VrpEv8gGxb1xMUqeI//UaX7gmlNNWUsHE3oC47
         g86s9ukZzgaWZHx7GoogjtBsayAma+/qy+HVkjGqm6YdxezcNKjU6QYNQfQpeP0OWRic
         g1V+VftfRbbPWzJYDQpM0C2BzpTspukMUFejC7VLGVE7UAk+IyasufTLL3pRHIgzy6LE
         TEclA8mzKcXNwfVdUxacEzKXBivB5Ie+rD5+wxF05tKU5tRAr1U+HgIyVSwne0toUaBx
         lLSRlW5htmZTUp7XMVIbRgvappSrj3t4qxD9ZILg0BReuaJfd4unLABuYtGsPPsNt8XI
         pMcQ==
X-Gm-Message-State: AOJu0YzPJ6X2bofwvPxNa4j8aYqoQFUbDpjsoGNUGSNxlvnGHALJHOi4
	nGbUPBBsfGPDHfifp1hEJKiNDNzZquAS7cj6MHTtUE76rmqszCq7EOqKBpuZd/Yb79JR6BAZ/DO
	caHy+xTs=
X-Gm-Gg: AY/fxX7WtuuZ7VebqJMaThfwJHyZ8ZUH5ixU8W3PPl7tJux8uiGEfsrdbyBuUkRhiCh
	9/86K7vnq1hTNPj3immFPJX5WQHbRkFsozZ6vILhPgbTsPypPUybL2XnSv2dNHhJoxHnMvkTnFn
	AxB2uEaRSk5SvwxZuGHFeTHgyq0Ui0/b6tgk0jro1i1mz3t/0fETq6vUftsPfKVwQ6QPYJ1S5+a
	x0v08rN9O45+fRuQjU2whSi8fv5KH6amTNgRk6CdBT/Gj+HBt04j5XTreCz6WQof/Qwgtr9S90K
	CfUkIPMFnfbq8w53baRDJawjmnv8DcIlttUzSBdKKRTB+bV2+7SGFllfITbL49Aa1d9SRVY4sR8
	eEJdcs53BBpe44IT+kXEPrigUhRbmZE6uWSD5iARHw0J+wA7M3oNAmvZSOX+bu2+vnNF1Snt2oz
	GxC1KuD+oJc1NM3Vtj3Jlk2OXMKecnSUZv7eXpOchfMHg4mJQ0CAoHMwRHcxox9cVLC16W5ZFcy
	Gc=
X-Google-Smtp-Source: AGHT+IEdAyMXoma3TrY3Lym0Vh+WqzB3ClBsV+sicG97PTfmTxHbrxYNEk6Y81DCqBXNEjeXI5rhbQ==
X-Received: by 2002:a05:620a:40d3:b0:8b2:f145:7f2e with SMTP id af79cd13be357-8bb3a39bdd9mr2875380285a.77.1766069235039;
        Thu, 18 Dec 2025 06:47:15 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8beeb5f189fsm177076185a.14.2025.12.18.06.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 06:47:14 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	corbet@lwn.net,
	gourry@gourry.net,
	kernel-team@meta.com,
	alejandro.lucero-palau@amd.com
Subject: [PATCH] Documentation/driver-api/cxl: device hotplug section
Date: Thu, 18 Dec 2025 09:46:36 -0500
Message-ID: <20251218144636.1232527-1-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe cxl memory device hotplug implications, in particular how the
platform CEDT CFMWS must be described to support successful hot-add of
memory devices.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 Documentation/driver-api/cxl/index.rst        |  1 +
 .../cxl/platform/device-hotplug.rst           | 77 +++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/platform/device-hotplug.rst

diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index c1106a68b67c..5a734988a5af 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -30,6 +30,7 @@ that have impacts on each other.  The docs here break up configurations steps.
    platform/acpi
    platform/cdat
    platform/example-configs
+   platform/device-hotplug
 
 .. toctree::
    :maxdepth: 2
diff --git a/Documentation/driver-api/cxl/platform/device-hotplug.rst b/Documentation/driver-api/cxl/platform/device-hotplug.rst
new file mode 100644
index 000000000000..9af8988bd47a
--- /dev/null
+++ b/Documentation/driver-api/cxl/platform/device-hotplug.rst
@@ -0,0 +1,77 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================
+CXL Device Hotplug
+==================
+
+Device hotplug refers to *physical* hotplug of a device (addition or removal
+of a physical device from the machine).
+
+Hot-Remove
+==========
+Hot removal of a device typically requires careful removal of software
+constructs (memory regions, associated drivers) which manage these devices.
+
+Hard-removing a CXL.mem device without carefully tearing down driver stacks
+is likely to cause the system to machine-check (or at least SIGBUS if memory
+access is limited to user space).
+
+Memory Device Hot-Add
+=====================
+Hot-adding a memory device requires that the memory associated with that
+device fits in a pre-defined (*static*) CXL Fixed Memory Window in the
+:doc:`CEDT<acpi/cedt>`.
+
+There are two basic hot-add scenarios which may occur.
+
+Device Present at Boot
+----------------------
+A device present at boot likely had its capacity reported in the
+:doc:`CEDT<acpi/cedt>`.  If a device is removed and a new device hotplugged,
+the capacity of the new device will be limited to the original CFMWS capacity.
+
+Adding a device larger than the original device will cause memory region
+creation to fail if the region size is greater than the CFMWS size.
+
+The CFMWS is *static* and cannot be adjusted.  Platforms which may expect
+different sized devices to be hotplugged must allocate sufficient CFMWS space
+*at boot time* to cover all future expected devices.
+
+No CXL Device Present at Boot
+-----------------------------
+When no CXL device is present on boot, most platforms omit the CFMWS in the
+:doc:`CEDT<acpi/cedt>`.  When this occurs, hot-add is not possible.
+
+For a platform to support hot-add of a memory device, it must allocate a
+CEDT CFMWS region with sufficient memory capacity to cover all future
+potentially added capacity.
+
+Switches in the fabric should report the max possible memory capacity
+expected to be hot-added so that platform software may construct the
+appropriately sized CFMWS.
+
+Interleave Sets
+===============
+
+Host Bridge Interleave
+----------------------
+Host-bridge interleaved memory regions are defined *statically* in the
+:doc:`CEDT<acpi/cedt>`.  To apply cross-host-bridge interleave, a CFMWS entry
+describing that interleave must have been provided *at boot*.  Hotplugged
+devices cannot add host-bridge interleave capabilities at hotplug time.
+
+See the :doc:`Flexible CEDT Configuration<example-configurations/flexible>`
+example to see how a platform can provide this kind of flexibility regarding
+hotplugged memory devices.
+
+Platform vendors should work with switch vendors to work out how this
+HPA space reservation should work when one or more interleave options are
+intended to be presented to a host.
+
+HDM Interleave
+--------------
+Decoder-applied interleave can flexibly handle hotplugged devices, as decoders
+can be re-programmed after hotplug.
+
+To add or remove a device to/from an existing HDM-applied interleaved region,
+that region must be torn down an re-created.
-- 
2.52.0

