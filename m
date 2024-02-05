Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A202C183
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142783; cv=none; b=bRCfbfB9/lkvL5wL00bPfhzdviUnHd2+68WVFNdu3KxP5W5XwgP4O6MGLd/AH+tUC2t9J4uz6zCKjbQi0rSpV1CBNUHxuZwfUkHQhapmXYzGaUnbdS9QbSfcStUpmfhckAYHkr0eCarqpwpmVwZR9ND/C74Ml2DEnNnTyRNd5oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142783; c=relaxed/simple;
	bh=pzlegcs0hOao2uQi/Y1xRldU30nf6k7nSTV4ivAYtwk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qRlnOW4YMDGz1bZrldb9ax97Q94WxPmlKYI0oquHFK7zf/5mWgTk4rElp5+871RapVkVfScQbATN/H/LT/NC/PPHdwLZ4BVEza12OVZtYroRQd35TIN43K0LloZKXZI32dAQ01EQtRLJULx23lJ3xHW0VMDcT8EJIE7uJzQzZJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TT7hf3s0Hz6JB8S;
	Mon,  5 Feb 2024 22:16:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B6DEB1409F9;
	Mon,  5 Feb 2024 22:19:36 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 14:19:36 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
CC: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Dongjiu Geng
	<gengdongjiu1@gmail.com>, <linuxarm@huawei.com>, "Michael S . Tsirkin"
	<mst@redhat.com>, Ira Weiny <ira.weiny@intel.com>, Peter Maydell
	<peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>, Marcel Apfelbaum
	<marcel.apfelbaum@gmail.com>
Subject: [RFC PATCH 00/11 qemu] arm/acpi/pci/cxl: ACPI based FW First error injection.
Date: Mon, 5 Feb 2024 14:19:29 +0000
Message-ID: <20240205141940.31111-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

I've had a version of this code for many years (and occasionally mention it
as test platform for kernel patches) and it keeps coming in handy, so time
to share the CXL version.

What is this?
- ACPI + UEFI specs define a means of notifying the OS of errors that
  firmware has handled (gathered up data etc, reset the relevant error tracking
  units etc) in a set of standard formats (UEFI spec appendix N).
- ARM virt already supports standard HEST ACPI table description of Synchronous
  External Abort (SEA) for memory errors. This series builds on this to
  add a GHESv2 / Generic Error Device / GPIO interrupt path for asynchronous
  error reporting.
- CXL and PCI AER both already have injection commands (via HMP / QMP)
  These are repurposed to perform FW first injection if the guest OS has not
  negotiated OS first handling (so before the CXL / PCIE _OSC is called or
  when it doesn't negotiate control of AER / CXL Memory Errors).
- The OS normally negotiates for control of error registers via _OSC.
  Previously QEMU unconditionally granted control of these registers.
  This series includes a machine parameter to allow the 'FW' to not let the
  OS take control and tracks whether the OS has asked for control or not.
  Note this code relies on the standard handshake - it's not remotely
  correct if the OS does follow that flow - this can be hardened with some
  more AML magic.

Alternatives:
- In theory we could emulate a management controller running appropriate firmware
  and have that actually handle the errors. It's much easier to instead intercept
  them before the error reporting messages are sent and result logged in the root
  ports error registers. As far as the guest is concerned it doesn't matter if
  these registers are handled via the firmware or never got written in the first
  place (the guest isn't allowed to touch these registers anyway!)
  This is sort of same argument for why we build ACPI tables in general in QEMU
  rather than making that an EDK2 problem.

Why?
- The kernel CXL code supports both firmware first and native RAS.
  As only some vendors have adopted a FW first model and hardware
  availability is limited this code has proven challenging to test.

Why an RFC?
- Small matter that the ARM CXL support isn't upstream.
- I'm assuming adding this support to QEMU will be controversial.
- There are some loose ends, TODOs and Fixme's in the code.
- Only one type of CXL event currently handled - should provide them all
  CXL Protocol and AER error reporting is more complete.
- I should probably figure out how to do this for x86 as apparently people
  also want to use that architecture ;)

Thanks to Shiju Jose for help testing this.

Based on: Random stack of patches on my gitlab.com/jic23/qemu cxl-2024-02-05-draft
branch. Specifically:
https://gitlab.com/jic23/qemu/-/commit/0fa064b9c8eeef468d8a19e87f39f230b4fa4da9

All comments welcome - particularly anyone who can advise on what the HEST
table should look like an x86 machine - too many options!

Jonathan Cameron (11):
  hw/pci: Add pcie_find_dvsec() utility.
  hw/acpi: Allow GPEX _OSC to keep fw first control of AER and CXL
    errors.
  arm/virt: Add fw-first-ras property.
  acpi/ghes: Support GPIO error source.
  arm/virt: Wire up GPIO error source for ACPI / GHES
  acpi: pci/cxl: Stash the OSC control parameters.
  pci/aer: Support firmware first error injection via GHESv2
  hw/pci/aer: Default to error handling on.
  cxl/ras: Set registers to sensible state for FW first ras
  cxl/type3: FW first protocol error injection.
  cxl/type3: Add firmware first error reporting for general media
    events.

 include/hw/acpi/cxl.h         |   2 +-
 include/hw/acpi/ghes.h        |  14 +
 include/hw/arm/virt.h         |   1 +
 include/hw/boards.h           |   1 +
 include/hw/cxl/cxl.h          |   2 +
 include/hw/pci-host/gpex.h    |   1 +
 include/hw/pci/pcie.h         |   1 +
 hw/acpi/cxl-stub.c            |   2 +-
 hw/acpi/cxl.c                 |  50 ++-
 hw/acpi/ghes-stub.c           |  25 ++
 hw/acpi/ghes.c                | 634 +++++++++++++++++++++++++++++++++-
 hw/arm/virt-acpi-build.c      |  71 +++-
 hw/arm/virt.c                 |  32 +-
 hw/cxl/cxl-component-utils.c  |   4 +-
 hw/i386/acpi-build.c          |   2 +-
 hw/mem/cxl_type3.c            |  42 ++-
 hw/pci-bridge/cxl_root_port.c |   1 -
 hw/pci-host/gpex-acpi.c       |  17 +-
 hw/pci-host/gpex.c            |   1 +
 hw/pci/pcie.c                 |  30 ++
 hw/pci/pcie_aer.c             |  35 +-
 21 files changed, 914 insertions(+), 54 deletions(-)

-- 
2.39.2

