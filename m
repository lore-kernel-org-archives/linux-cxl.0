Received: from mail-vs1-f68.google.com (mail-vs1-f68.google.com [209.85.217.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949F81DF97C
	for <linux-cxl@vger.kernel.org>; Thu, 18 Dec 2025 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766077708; cv=none; b=Spko27rvEsVyaJF9n7jQu2Y7O0f0ED/s5dhcu+1t01xJlaH3y9DtrO1n0hTT9tzfDY72Gf05s0NnlUam0RRmHNCKx1xImWA3lKDEb/ap09GFw/kIEh4/Wc74zSnOm3kY0EOiVTEYKPrTp18kskvzT6lZhU3J85wRRj8biacD+Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766077708; c=relaxed/simple;
	bh=8ye9FD0BFmVlW+0teHeZBRRFLyYOXqRaeSCCyvdA6iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eEs0fsCiNpL4h9eVMh94Gd8VsyW+mr0Eyuyf1RhtP38OufZuXcq+AyYHXF3AdvGwOjJCfNwUTJ8EJJRBTvwnq/YDPuueCwqvsNO3XT0h+IMxRnjhWxXsafnCeUzg8Usnj0fC6PA30J2P2bwK0LoNmzVbqTMj2cKxMVJ3DuDfExg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ssLttwpL; arc=none smtp.client-ip=209.85.217.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ssLttwpL"
Received: by mail-vs1-f68.google.com with SMTP id ada2fe7eead31-5dbe6304b79so326998137.3
        for <linux-cxl@vger.kernel.org>; Thu, 18 Dec 2025 09:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1766077705; x=1766682505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ya4unRoujhVC5tGQqPhGTBiLoZbxvuuVtCstkzd5+M=;
        b=ssLttwpLcnlzjVXrr+dQDTqJfXF3X+Ro3uMaia9IJB2PiRkn1mv+LcGpVhvtd+gkR8
         9OGyuRReXTviKVbj+32ofb9RuwFLPkclD7rXvfo9ZZyM8llVrMoH2vw/5lP6lB076kiz
         XEb2QFgSo5eGzDYqMWFGNcf1ueuK7v9OvcFvkn6BMRkBcNEaKjm0PT05x5pZzUZt/T32
         VPFtBOfH9EPgtfSAJcidDwkb6RkJzUBjjzBddqiG2JO95II0riYO2xgeJukh1bp7x0Jk
         O6KmzqiIkZhEoDdbXfBSX0//rQ2hPiWIKwUX9rgBCZsd94MSSKZWbaS2+xc01kPAcEkq
         K2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766077705; x=1766682505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ya4unRoujhVC5tGQqPhGTBiLoZbxvuuVtCstkzd5+M=;
        b=j9IW8o6AsEl18JSdnMLgVx1jU46rQlvdzBbM1xiAEez4x1PiHN0LS3+GsMfSBeowE2
         rEwVvoONZ6CTFa7JDfAszYoaOnW/Lx9XM4rPKNL60arIzC3Jbg9zxlfMqBsPn3Qp6hTX
         wyYhA8tUVtdqrMjS9JA19jn2Q33J1q9JkB0ENh7EkfSh+rvDhUgRxpx6YkVO2cqJ8uOA
         fvTxyS7EsumAMCveWpOY7Fo5YRnACweJUrfXb9KI1dLtIAJt7fEbrCevU+PsYZk6PVOX
         3LLdlH28LUGR/GwD2Z0qQG6LFbUIQjLgC305hnmtfTI8NE8Bow4duPOzBhzOTYX9MvU2
         iaiw==
X-Gm-Message-State: AOJu0YyD3d7KnZbSFAHfrTWNOG/6JRAUjnH0aT/8cWTEMZvNU9QjQvPa
	7tUn2t0G+w3IhyKuRv7MTTub7lh1qq8l8mrugaXkiEKpOa+8eHUBAoLxpijyXUu702OMRwTfow7
	MvHSEPbQ=
X-Gm-Gg: AY/fxX4kkpvBsaFi8cMJtuBl7M++HJfezSziAmWYhZXDxHb/3ApoDKWBq1l353DGVOg
	hqwTPOYYolxtuX24vDJ5e0K+nTyqSdguJF5xijRtr8JFM7Mb4zDDhdThPgrUhBH8k61X77kmQHO
	mrS5T7WUBbxqOuDiKuKg78lSaLzIY9C5PKpzmSDLbwF+VA9Cu5F0MyThc1RwNdrE7gftWZRBiYT
	CniK6HsMKvAU/Ih3hJMsEZFw7yxk6jBfy0wSSwtxx4QZyFqe3hWALi4BiQJ3jCeBO39ojrDH1xS
	79GfXXfHyJ0ktBSKhd/PNQc8i8hVQXZ69SaJEp4KaWuw6uKTuAYqaM3Pmrq5nll8pSscWFSWIrJ
	CLnSHRCU/oMKVbNYSPh42LkE6oG/l/EdwspenkNbA87piGubL7aRnfSPE7Cp8RFg7j1vuO42nvu
	PbAyKyfdbEnfOYIU5Uto07qQ8BVPu+rEy5yfUUp2ZE6inU3kJtWSqrKaGeAgeIQT4Aea9H/2xZX
	Hn/0uRKAe0MuQ==
X-Google-Smtp-Source: AGHT+IFSHbw0chfOWEQxtTLWjVKiGVd/5ep5H3OHMkfwYCMbPQeVBTd2RA/79NAFdzsJerniQ+4zzg==
X-Received: by 2002:a05:6102:3e84:b0:5db:cf38:f4f3 with SMTP id ada2fe7eead31-5e8277cde55mr7853764137.28.1766077704903;
        Thu, 18 Dec 2025 09:08:24 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9623ffe8sm222186d6.12.2025.12.18.09.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 09:08:24 -0800 (PST)
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
	gourry@gourry.net
Subject: [PATCH v2] Documentation/driver-api/cxl: device hotplug section
Date: Thu, 18 Dec 2025 12:07:47 -0500
Message-ID: <20251218170747.1278327-1-gourry@gourry.net>
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
v2: Jonathan's clarifications and diagrams.

 Documentation/driver-api/cxl/index.rst        |   1 +
 .../cxl/platform/device-hotplug.rst           | 112 ++++++++++++++++++
 2 files changed, 113 insertions(+)
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
index 000000000000..617e340bd556
--- /dev/null
+++ b/Documentation/driver-api/cxl/platform/device-hotplug.rst
@@ -0,0 +1,112 @@
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
+A device present at boot will be associated with a CXL Fixed Memory Window
+reported in :doc:`CEDT<acpi/cedt>`.  That CFMWS may match the size of the
+device, but the construction of the CEDT CFMWS is platform-defined.
+
+Hot-adding a memory device requires this pre-defined (*static*) CFMWS has
+sufficient space to describe that device.
+
+There are a few common scenarios to consider.
+
+Single-Endpoint Memory Device Present at Boot
+---------------------------------------------
+A device present at boot likely had its capacity reported in the
+:doc:`CEDT<acpi/cedt>`.  If a device is removed and a new device hotplugged,
+the capacity of the new device will be limited to the original CFMWS capacity.
+
+Adding capacity larger than the original device will cause memory region
+creation to fail if the region size is greater than the CFMWS size.
+
+The CFMWS is *static* and cannot be adjusted.  Platforms which may expect
+different sized devices to be hotplugged must allocate sufficient CFMWS space
+*at boot time* to cover all future expected devices.
+
+Multi-Endpoint Memory Device Present at Boot
+--------------------------------------------
+A hot-plug capable CXL memory device, such as one which presents multiple
+expanders as a single large-capacity device, should report the maximum
+*possible* capacity for the device at boot. ::
+
+                  HB0
+                  RP0
+                   |
+     [Multi-Endpoint Memory Device]
+              _____|_____
+             |          |
+        [Endpoint0]   [Empty]
+
+
+Limiting the size to the capacity preset at boot will limit hot-add support
+to replacing capacity that was present at boot.
+
+No CXL Device Present at Boot
+-----------------------------
+When no CXL memory device is present on boot, some platforms omit the CFMWS
+in the :doc:`CEDT<acpi/cedt>`.  When this occurs, hot-add is not possible.
+
+For a platform to support hot-add of a full memory device, it must allocate
+a CEDT CFMWS region with sufficient memory capacity to cover all future
+potentially added capacity.
+
+To support memory hotplug directly on the host bridge, or on a switch
+downstream of the host bridge (but not contained within a CXL memory device),
+a platform must construct a CEDT CFMWS at boot with sufficient resources to
+support the max possible (or expected) hotplug memory capacity. ::
+
+         HB0                 HB1
+      RP0    RP1             RP2
+       |      |               |
+     Empty  Empty            USP
+                      ________|________
+                      |    |    |     |
+                     DSP  DSP  DSP   DSP
+                      |    |    |    |
+                         All  Empty
+
+For example, a BIOS/EFI may expose an option to configure a CEDT CFMWS with
+a pre-configured amount of memory capacity (per host bridge, or host bridge
+interleave set), even if no device is attached to Root Ports or Downstream
+Ports at boot (as depicted in the figure above).
+
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
+hotplugged memory devices.  BIOS/EFI software should consider options to
+present flexible CEDT configurations with hotplug support.
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

