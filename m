Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6E97FBA2
	for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 00:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745971954; cv=none; b=pyLtTgi+wQBx5mS94KvOboyF7zCzcw7csEik6gTvEm6EB1B4j/oG2PVVerbCMFEEC32OF4u4XbfiUEOvqcZZ0cEhRDk9PTeGP9hgSYxh1tXXTH9CbgxyWSPX8mcqJuQWlAxRKZgYW/drtD1vsR7kmtY1sYoeBymRAKVFm8kaQvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745971954; c=relaxed/simple;
	bh=ZXjEjXsHfjUa0iCrPCgE3lVEAf2malrtgL9WvuAkaWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fJHoEbi7bgTrPxT17CbHhdEG75DfW6/vQFE+krTQt51idvtE4F2Y+y07R4O10dZdNNTSNEkB3gncTD+6Pf/dVsQaaPZqZh5M8p0/klX8+Ijxew6qda1qG6Fi+PQDJeySIwfRX9I+js6PZjf+lLl2KkX/o1ASUFGnTD/qiOrb67o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=mtXtP6sn; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="mtXtP6sn"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476ab588f32so111271621cf.2
        for <linux-cxl@vger.kernel.org>; Tue, 29 Apr 2025 17:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745971951; x=1746576751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XwkrHfxPIhIcdIYIVNv5VYPO5SHZTfxK8AinQWxi748=;
        b=mtXtP6sn+DLqWZQ4B5+Mro5FUX85BEkBA3C3KO9jKMQmmXpaPLzCeV1KEZ19PUUGst
         zAjEmSmRJ+M/yclCin2aoVvRAoblqxbD6vll5J6soNmHBgiz4aEo6qqGan3ZAfanB/Q3
         ACA2BmpMI2FAUVVFMqwdb81dXFPj/SPZXFnoWliniuA1LeoiKxAhxuOIRm4eWQOQuJJt
         6no3Pj01tYYx0nBGN9aKLev4SS7v1vU6lWJoR62GHqilH70jX03xFUWl0Uh4Ho9MaXW6
         xxImKq++nNHIULW7LgV/Nxl6kxjRdvh5U2HJ8vTxNrGhsgC3Rt2X8pCfKzVmFYhEAPV9
         RPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745971951; x=1746576751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XwkrHfxPIhIcdIYIVNv5VYPO5SHZTfxK8AinQWxi748=;
        b=DO4yzn1yHKhl6OcGXBz9+/Lwvh0caenfbsW19h+dISAvb8o9s7JrSOkt0ReUVqGIcK
         jk5aqoWz7EvuWrmoQpo6+pzkjobYkBVld7CRXVXjzO3A4cRL2uAmCzi1eWfDuXh5DuUc
         1X3047dHssFs6CHEEmX5vQ9uS6wUoSeTSWxslr0B7demFfvujnMAmRQDt7KyMfRnLgvF
         oYpYIxDbkGAEviYV9KiOy5Lk8P78ZzRio0nmQ0Y1KDFA0VKi8CDrfFKBRIMFzRivpOZp
         bFHX6jU92SEfdddXINRSjL3duYvlJu1ZQliJSLPMOri3karSeSGUH6LBLKktTPxaqAl0
         s1TQ==
X-Gm-Message-State: AOJu0Yy60vvqkKWN+58LQdZQ7fN/NqMrd20CphzZMl6JN4alBFeCCB8T
	2UALpEwn4jM8a+zzOJZFcjrDFkXRgtCifhJmOPNgtvqyHi7NKOnGZ9ipBx2UdDXdyIzKqYzr+nE
	C
X-Gm-Gg: ASbGnct4RkqLbbDfcavZhg9Dfnz/mAXlc4HpURshwAyIrnBYzjiIXP/gyfLUTpynIp0
	GFInS9eLijJSKpPqL0VhM6tlZNaiSCvjQphf4zLack8nIjxlUMU7uEyP4Dg7B3CtVYt574efkqA
	JR3Nhy9Ztb0eHwUz3nF02tRP5DUkNuImbs/hvMUaSVhg6YQDCDdmTz/qFZHT4qNSOZSdSsbMLiX
	shJnNJVntncnRxYh1mZTBC9BfW6v8wf3PxsJChlt5aZgwEW3wNn6EiRwRJzeJVB0hDFElrR7H+r
	OL8oKj3Cj+w3EguZTInfv3oIkedIak/sFy7tmBy+P1tQHxs2RJ2VqnWHQ0q8Rb3JDmg7NtPkyFn
	Y3wofwPdRb0A1fIRLYxrhmkmLB527
X-Google-Smtp-Source: AGHT+IGx7yWMnstTX6Ocxy96mhz8w9pNto5sYt4gawjQLHNDDT1JWwKm6SA8P6j6AQaDIRZciIZTvw==
X-Received: by 2002:a05:622a:2b44:b0:476:b7cf:4d42 with SMTP id d75a77b69052e-489e4f6e095mr11161921cf.27.1745971951326;
        Tue, 29 Apr 2025 17:12:31 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f7a820esm87634411cf.41.2025.04.29.17.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:12:30 -0700 (PDT)
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
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: [RFC PATCH 00/17] CXL Boot to Bash Documentation
Date: Tue, 29 Apr 2025 20:12:07 -0400
Message-ID: <20250430001224.1028656-1-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts CXL Boot to Bash Docs to Linux Kernel Docs.
I tried to break it into separate patches to make it easier for
people with specific expertise to review.

The big open TODOs:
- use-case documentation.

  I only have the type-3 perspective, and only one perspective.
  It would be good to have that hacked on more generally.

- memory tiering documentation.

  I basically left this unfilled for now.  Would like some basic
  docs on at least TPP and DAMON.

- devices: CDAT explanation

  It would be good to have this spelled out at least a little bit.

- platform: ACPI SRAT Generic port / initiator docs

  I don't know anything about this and people say it's important.

Thank you to everyone who contributed feedback during LSF/MM
Boot-to-Bash proposal.  Hopefully I incorporated most feedback,
but I may have missed some.

Co-developed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Signed-off-by: Gregory Price <gourry@gourry.net>

Gregory Price (17):
  cxl: update documentation structure in prep for new docs
  cxl: docs/devices - device reference and uefi placeholder
  cxl: docs/platform/bios-and-efi documentation
  cxl: docs/platform/acpi reference documentation
  cxl: docs/platform/example-configs documentation
  cxl: docs/linux - overview
  cxl: docs/linux - early boot configuration
  cxl: docs/linux - add cxl-driver theory of operation
  cxl: docs/linux/cxl-driver - add example configurations
  cxl: docs/linux/dax-driver documentation
  cxl: docs/linux/memory-hotplug
  cxl: docs/allocation/dax
  cxl: docs/allocation/page-allocator
  cxl: docs/allocation/reclaim
  cxl: docs/allocation/hugepages
  cxl: docs/allocation/tiering
  cxl: docs/use-cases

 .../driver-api/cxl/allocation/dax.rst         |  59 ++
 .../driver-api/cxl/allocation/hugepages.rst   |  30 +
 .../cxl/allocation/page-allocator.rst         |  85 +++
 .../driver-api/cxl/allocation/reclaim.rst     |  50 ++
 .../driver-api/cxl/allocation/tiering.rst     |  30 +
 .../driver-api/cxl/devices/device-types.rst   | 169 ++++++
 .../theory-of-operation.rst}                  |   0
 Documentation/driver-api/cxl/devices/uefi.rst |   9 +
 Documentation/driver-api/cxl/index.rst        |  55 +-
 .../cxl/{ => linux}/access-coordinates.rst    |   0
 .../driver-api/cxl/linux/cxl-driver.rst       | 531 ++++++++++++++++++
 .../driver-api/cxl/linux/dax-driver.rst       |  42 ++
 .../driver-api/cxl/linux/early-boot.rst       | 129 +++++
 .../example-configurations/hb-interleave.rst  | 314 +++++++++++
 .../intra-hb-interleave.rst                   | 291 ++++++++++
 .../multi-interleave.rst                      | 401 +++++++++++++
 .../example-configurations/single-device.rst  | 246 ++++++++
 .../driver-api/cxl/linux/memory-hotplug.rst   |  77 +++
 .../driver-api/cxl/linux/overview.rst         | 104 ++++
 .../driver-api/cxl/platform/acpi.rst          |  83 +++
 .../driver-api/cxl/platform/acpi/cedt.rst     |  52 ++
 .../driver-api/cxl/platform/acpi/dsdt.rst     |  27 +
 .../driver-api/cxl/platform/acpi/hmat.rst     |  28 +
 .../driver-api/cxl/platform/acpi/slit.rst     |  17 +
 .../driver-api/cxl/platform/acpi/srat.rst     |  37 ++
 .../driver-api/cxl/platform/bios-and-efi.rst  | 261 +++++++++
 .../cxl/platform/example-configs.rst          |  13 +
 .../example-configurations/flexible.rst       | 296 ++++++++++
 .../example-configurations/hb-interleave.rst  | 107 ++++
 .../multi-dev-per-hb.rst                      |  90 +++
 .../example-configurations/one-dev-per-hb.rst | 136 +++++
 .../cxl/use-case/dynamic-capacity.rst         |  19 +
 .../cxl/use-case/memory-expansion.rst         |  14 +
 .../driver-api/cxl/use-case/shared-memory.rst |  14 +
 .../cxl/use-case/virtual-machines.rst         |  18 +
 35 files changed, 3831 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/driver-api/cxl/allocation/dax.rst
 create mode 100644 Documentation/driver-api/cxl/allocation/hugepages.rst
 create mode 100644 Documentation/driver-api/cxl/allocation/page-allocator.rst
 create mode 100644 Documentation/driver-api/cxl/allocation/reclaim.rst
 create mode 100644 Documentation/driver-api/cxl/allocation/tiering.rst
 create mode 100644 Documentation/driver-api/cxl/devices/device-types.rst
 rename Documentation/driver-api/cxl/{memory-devices.rst => devices/theory-of-operation.rst} (100%)
 create mode 100644 Documentation/driver-api/cxl/devices/uefi.rst
 rename Documentation/driver-api/cxl/{ => linux}/access-coordinates.rst (100%)
 create mode 100644 Documentation/driver-api/cxl/linux/cxl-driver.rst
 create mode 100644 Documentation/driver-api/cxl/linux/dax-driver.rst
 create mode 100644 Documentation/driver-api/cxl/linux/early-boot.rst
 create mode 100644 Documentation/driver-api/cxl/linux/example-configurations/hb-interleave.rst
 create mode 100644 Documentation/driver-api/cxl/linux/example-configurations/intra-hb-interleave.rst
 create mode 100644 Documentation/driver-api/cxl/linux/example-configurations/multi-interleave.rst
 create mode 100644 Documentation/driver-api/cxl/linux/example-configurations/single-device.rst
 create mode 100644 Documentation/driver-api/cxl/linux/memory-hotplug.rst
 create mode 100644 Documentation/driver-api/cxl/linux/overview.rst
 create mode 100644 Documentation/driver-api/cxl/platform/acpi.rst
 create mode 100644 Documentation/driver-api/cxl/platform/acpi/cedt.rst
 create mode 100644 Documentation/driver-api/cxl/platform/acpi/dsdt.rst
 create mode 100644 Documentation/driver-api/cxl/platform/acpi/hmat.rst
 create mode 100644 Documentation/driver-api/cxl/platform/acpi/slit.rst
 create mode 100644 Documentation/driver-api/cxl/platform/acpi/srat.rst
 create mode 100644 Documentation/driver-api/cxl/platform/bios-and-efi.rst
 create mode 100644 Documentation/driver-api/cxl/platform/example-configs.rst
 create mode 100644 Documentation/driver-api/cxl/platform/example-configurations/flexible.rst
 create mode 100644 Documentation/driver-api/cxl/platform/example-configurations/hb-interleave.rst
 create mode 100644 Documentation/driver-api/cxl/platform/example-configurations/multi-dev-per-hb.rst
 create mode 100644 Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
 create mode 100644 Documentation/driver-api/cxl/use-case/dynamic-capacity.rst
 create mode 100644 Documentation/driver-api/cxl/use-case/memory-expansion.rst
 create mode 100644 Documentation/driver-api/cxl/use-case/shared-memory.rst
 create mode 100644 Documentation/driver-api/cxl/use-case/virtual-machines.rst

-- 
2.49.0

