Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37FC33BBD2
	for <linux-cxl@vger.kernel.org>; Fri, 19 Dec 2025 17:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766163987; cv=none; b=YvhdJNSmMD2zM3k9XgIlmO6JpktoQ7grJkig9e19Vuz/YfsbnIlKWldCFTEMPOeMK43j/Qi3oweUJjc+Oq/X8PcH9zOcMEVClNmy2MMajsEW29NvtZ/UqYqxoLqARlJbfsanVKRtGbKcXCJSVoawgQB8/ARhTXkBFWaSoJFPfYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766163987; c=relaxed/simple;
	bh=Y+71PUVRfwuvUKxaHdzqE9jx5sqntnX+4UWIz5GKPsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6YNqYRepGPkAuPNPpfxIzi9RnUgWDd94XsP3gtwyzDlKuNExyoEdajNECnJfx7YI9QiRvSsEorYOkFIebVcPibrw5CPF+ejIspmhs6AmbN4Wbic14uLMF4U7fLoUuRRBK/Ne9KFnEn33Q7X6n1qn3giTkrCNLtyx1dU0BnOMuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=erBE4GC4; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="erBE4GC4"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8b2d7c38352so298770585a.0
        for <linux-cxl@vger.kernel.org>; Fri, 19 Dec 2025 09:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1766163984; x=1766768784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ve73z4RK/cYcNMBA2t4ADqsjJbpaVx1NScHqoDm2Vdk=;
        b=erBE4GC4Inpl1kZlITE3hnD+U9NVUqo5T9x0GfFt0MYjlPcjix1elMFZq9Zqeb533K
         qXHmpvV7x8ink+nv8aE5UqCDBg5U2KnesSuVee+0u/qcAYN+GN9y9E5tDQKOJLiRKfVE
         dCZK8HYwq1SWUjC+MkS0M29L8dy3y1xy0pzd3TsE6vnSUUMRPJ+OZnUTPZG0h5PCCKYw
         F2ZNF/ap51NxMLwqJqB2M7J4K6PrrNC9gLraksGV2gTgezpv8MJgtgTQwi9bytKBa525
         4cokFih8UrJlcOHc16NMHiMLjZEb/p9h9tcufttXrkbsJMIElnwBQkpkk6BRT2l05/Ib
         cAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766163984; x=1766768784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ve73z4RK/cYcNMBA2t4ADqsjJbpaVx1NScHqoDm2Vdk=;
        b=CAOC2lNHlTRC2GRLVWYObwszUPbTlJVC1nkXJuOk5HfZPhEh9y5qLuPp9TaiiuYg/y
         1gG934ygh8MiK0117VcWuGEJy+9ppRXxqXXfcg6XdtdYSTtN1AHB/W5BGWfc3npFtL62
         O3CFaZRjjAIZ0sUVlb/uDA50XKGf0YB0aIHtow8OFS3Zvk2VfBh18KFz6TP97p8VoPEz
         0Cnm4K4H7Mz9C0UtnALijovHiBYTBPtzheIrkAdQIX7/vQl5J2ZlwFTpwT/N/2Afg2+f
         h0t7jKj2X+HX0tVzXF+3q6380BND7OHQ8EUti4OatC2tTwqDB7T8erUpbdjBc2e9ct55
         e1qw==
X-Gm-Message-State: AOJu0YyI7FxEOqR6uQBGgiNNMfocl0cg7uEgqFi1ADMSkDpDv1DeA01l
	wvDGSiOsrKp8ul12LZ8w1+fU9olHzq88wjUkzrwRYy+gO/Bvl7v/UT3FmY/hkTItoSw6/GkjrDE
	PNmouemE=
X-Gm-Gg: AY/fxX4VyUNxtGv2Khp/E6cKG5u4ZOG6/UqzYrmO+KLEI33yMpSgIBzwtIoQ30NVd3P
	qJzY6ba3YVgr0jUY1PUmojGKtvSyDkmRfkpLXwg87Z+8Mcx4zvT9Mn3p39ZHekg6fCZ+nYdp5P3
	z0RDV6qQYfzBZWb9pbCBY5W66k23GbZtd2taqME3dOIZ5v5XBUZJnOwXFXmGWA8pf9sdKQiqbQs
	bITAU51VVNCV0E29nDREE9kLfoTLHAfxNGHVC+0HkEIfqdMQEhX+/+e3j9NzHIiHAf4ySGLWRqc
	Dujcth1/NzwTrQZSqzlaRUIL8Tefp4XuFPJg+ofxBm4z6PO60hm1XpMT49nAZtEfrKjJ2VcH7rS
	tFJDNDn5yYzBtDX2Ln1l1WXkM9iFdT6DABQt9NRGzeaWcV63BcZAF6K6FcUY7lapy2/nuXcMYlP
	A5oVv75b2Baoi8GgufRY+RDdPu/57E0iLf8viLNxu8NVZJC6HjHTrF9py66kg9fIJCtgG5RV30o
	2Q=
X-Google-Smtp-Source: AGHT+IGhL++VzFeCqDT/tB5Cvy1Ps114ykiQjB+fbR/l94srArH+8w2+c687M3sNwAIPyDyiArGerA==
X-Received: by 2002:a05:620a:4495:b0:8a3:c4fa:9b5b with SMTP id af79cd13be357-8bee682063amr943344385a.12.1766163983905;
        Fri, 19 Dec 2025 09:06:23 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c096787536sm223197185a.4.2025.12.19.09.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 09:06:23 -0800 (PST)
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
	gourry@gourry.net,
	rakuram.e96@gmail.com,
	alucerop@amd.com
Subject: [PATCH v3 2/2] Documentation/driver-api/cxl: device hotplug section
Date: Fri, 19 Dec 2025 12:05:38 -0500
Message-ID: <20251219170538.1675743-3-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219170538.1675743-1-gourry@gourry.net>
References: <20251219170538.1675743-1-gourry@gourry.net>
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

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
v3: Jonathan updates, change some italics to bold, add some bits about
    Linux's expectations for BIOS/EFI behavior at runtime.

 Documentation/driver-api/cxl/index.rst        |   1 +
 .../driver-api/cxl/platform/bios-and-efi.rst  |   3 +
 .../cxl/platform/device-hotplug.rst           | 130 ++++++++++++++++++
 3 files changed, 134 insertions(+)
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
diff --git a/Documentation/driver-api/cxl/platform/bios-and-efi.rst b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
index 9034c206cf8e..a4b44c018f09 100644
--- a/Documentation/driver-api/cxl/platform/bios-and-efi.rst
+++ b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
@@ -49,6 +49,9 @@ up without requiring CXL driver support.  These platform vendors should
 test their configurations with the existing CXL driver and provide driver
 support for their auto-configurations if features like RAS are required.
 
+Platforms requiring boot-time programming and/or locking of CXL fabric
+components may prevent features, such as device hot-plug, from working.
+
 UEFI Settings
 =============
 If your platform supports it, the :code:`uefisettings` command can be used to
diff --git a/Documentation/driver-api/cxl/platform/device-hotplug.rst b/Documentation/driver-api/cxl/platform/device-hotplug.rst
new file mode 100644
index 000000000000..e4a065fdd3ec
--- /dev/null
+++ b/Documentation/driver-api/cxl/platform/device-hotplug.rst
@@ -0,0 +1,130 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================
+CXL Device Hotplug
+==================
+
+Device hotplug refers to *physical* hotplug of a device (addition or removal
+of a physical device from the machine).
+
+BIOS/EFI software is expected to configure sufficient resources **at boot
+time** to allow hotplugged devices to be configured by software (such as
+proximity domains, HPA regions, and host-bridge configurations).
+
+BIOS/EFI is not expected (**nor suggested**) to configure hotplugged
+devices at hotplug time (i.e. HDM decoders should be left unprogrammed).
+
+This document covers some examples of those resources, but should not
+be considered exhaustive.
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
+A device present at boot may be associated with a CXL Fixed Memory Window
+reported in :doc:`CEDT<acpi/cedt>`.  That CFMWS may match the size of the
+device, but the construction of the CEDT CFMWS is platform-defined.
+
+Hot-adding a memory device requires this pre-defined, **static** CFMWS to
+have sufficient HPA space to describe that device.
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
+The CFMWS is **static** and cannot be adjusted.  Platforms which may expect
+different sized devices to be hotplugged must allocate sufficient CFMWS space
+**at boot time** to cover all future expected devices.
+
+Multi-Endpoint Memory Device Present at Boot
+--------------------------------------------
+Non-switch-based Multi-Endpoint devices are outside the scope of what the
+CXL specification describes, but they are technically possible. We describe
+them here for instructive reasons only - this does not imply Linux support.
+
+A hot-plug capable CXL memory device, such as one which presents multiple
+expanders as a single large-capacity device, should report the **maximum
+possible capacity** for the device at boot. ::
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
+This describes the base case for any given device not being present at boot.
+If a future possible device is not described in the CEDT at boot, hot-add
+of that device is either limited or not possible.
+
+For a platform to support hot-add of a full memory device, it must allocate
+a CEDT CFMWS region with sufficient memory capacity to cover all future
+potentially added capacity (along with any relevant CEDT CHBS entry).
+
+To support memory hotplug directly on the host bridge/root port, or on a switch
+downstream of the host bridge, a platform must construct a CEDT CFMWS at boot
+with sufficient resources to support the max possible (or expected) hotplug
+memory capacity. ::
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
+Host-bridge interleaved memory regions are defined **statically** in the
+:doc:`CEDT<acpi/cedt>`.  To apply cross-host-bridge interleave, a CFMWS entry
+describing that interleave must have been provided **at boot**.  Hotplugged
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

