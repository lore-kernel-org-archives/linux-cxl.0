Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B23379C40
	for <linux-cxl@vger.kernel.org>; Wed,  7 Oct 2026 20:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791404317; cv=none; b=Nzo90EINl+lVBfI8BmrXwAAkkIymlb34KhcYJOV3p6QL8hBkUiXSxJT9KD6M7NJGA0TxG4umKUTxp4nCTtiVEOvMsVYLBhmXbB9tldLk16wGDKaL5kE1ae2AhfumCIaI0Z0MzfHcfSVuOiZKX/MT/49xtSKxM7l8VL+oA+WDjAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791404317; c=relaxed/simple;
	bh=Mm0fG/P6PzrdX8Rjw2ojzv5keGjmPaoO1yPnuUJtTyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XpM0P94zI4asRt6jCkfm16iUqaSkRy350EbZOwu/6hX8h1KiDOpnBZE3hV1MFOQn4GWQoFyba0mcz+ZgRJB9Fru2obI55zNLFqCOTc3wFGIuT9tfmpSH2FIZ59HN+1oSf3Y2MS8IHu7hwpToA9EYPerh6F45aqNos5I+M3NgEp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RM4ZIGtl; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RM4ZIGtl"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3a7cfe8f761so4879a91.1
        for <linux-cxl@vger.kernel.org>; Wed, 07 Oct 2026 13:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791404315; x=1792009115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fCLbHGwsWnPpim7MfXHsc24iqNdo+Md2nOyN7gtEbes=;
        b=RM4ZIGtlWZHj5NMJLROosomMK+9W0sWyBsVkV1pNA+jZpCoWEHUXa4OO/A0SgY2xHg
         fMXFVdlREPKB+L2obx27WauF5v77oByxNRtyAkUELlwKi9dw7DWTbeL8j9HpnYTcKQ4i
         W76oDHKvlaihZ07nNbFRIrcSgB9kqmKpPyn7RtsMXWwiiHz9A7wvv988hY9drqFRnrB3
         pIdqlvg7pEfEKm+Pd6zCNPzG7k9DvNRbxDiLH1mSqrUV3ikWRORcCd1pTCUWQHe4M7zu
         jpHUSJ4N8qHUHq6OWq+9z2LGrGyR68IuuSSU/LNjTbx025KREeaPdphJK6HsNQdEcEfg
         y3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791404315; x=1792009115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fCLbHGwsWnPpim7MfXHsc24iqNdo+Md2nOyN7gtEbes=;
        b=veys3N6/fLfW6ylz3CTwEuotCeVg5HJM9NDfZ3RouV/YUawT76PKBPYdGs1RvH6GUa
         DM9a8OKjNJbAp2hWZbK9OvWEbvtq+K1di4Fc9deR6k26Uwpe3J6omSKD8Ha4RGZXlglW
         umHuxR0M3V4J15B6f0Hb/UEf7jrZJF/ZYap0QsofDVVoI/73w/N9dOa0SNml9T5u5AZN
         3GimyYlOUsAkgywQWL4bJqK1icFYF8Vm6sRnJP5B/6MkDUw/QERsywZB+ipoLt+CdBwY
         +UdPfNaBPT1i3ZYS0ul5ntpfMp+NhC8xZt3g3MoZIcxp6QT5T7riSizVMb8amGQsHsT9
         yaVw==
X-Gm-Message-State: AFq9FYJkJwDb/OL+vMyKtzXa9Pl/2TGC4dISq6e3W8wsnn2XXpBFEnkb
	D3a0t6+N7iC0WnqVKiaKfy+rtN2/+s5p97qYd1b/zQwN9qW42zx2BGmmC+lELg==
X-Gm-Gg: AYBFou3vL7nS1muB+fZvxNn01hS2krk61OCe+JZjEB3MZRtjCnLZPp6bZusMp2iGun1
	MIo9wxxrc33Se2Scw0LQ6lvH6h5eAHX7+D9SdzZLw6po2LSIZeBFSKpnhWj/fo191ZFyNUfr2hq
	N1ZU/IuBKKCOWnDeZI+fa7hv1r8U/tPhKEDIHlSdABMd3aHzzgiLjEIADsySRC4WCiwlL5J0BdE
	yzysiNtc5HUWkDzjq8VfcvIoGWNUcPCrLqouykayv9Gqcb6qMPrcGVtAA44xCnyapWTiaUT0ZLh
	qCr0JXABac8lfD4rCTTsf8buG8GsHsxR++Xqcl1qlFp1U9cITo/Ptm7cExuR3jxeYVef4oKshLM
	2dzDflDPOdOJ/iJdY/FA0l+94AH5VkvosmhCSeWvuiGyZbn0IGvnFNaf6LChC6+aORyi9qF4tfi
	6qWTNGOAiPZaOcwv07JlN/jVFPZVmvKl9SSfznczeaIRVospcmySCAU6h4A8rni1XoQwHAKntG9
	3vLG9ZI+C3Bx/WkJud24J2vui3J0MRieMBNNSMy/AyeSnr1bCpKhDqBNaZpGtZ34Pncp3iMg+2a
	2vvkCDVy+vdRmA==
X-Received: by 2002:a17:90a:c88b:b0:3a8:63da:44b5 with SMTP id 98e67ed59e1d1-3aaed7e77a6mr144349a91.24.1791404314693;
        Wed, 07 Oct 2026 13:18:34 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com (c-24-19-224-150.hsd1.wa.comcast.net. [24.19.224.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9ff7ab034sm967623a91.4.2026.10.07.13.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 13:18:34 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Fan Ni <nifan.cxl@gmail.com>,
	Li Ming <ming.li@zohomail.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Gregory Price <gourry@gourry.net>,
	Richard Cheng <icheng@nvidia.com>,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v15 0/8] DCD Prep Series
Date: Wed,  7 Oct 2026 13:16:33 -0700
Message-ID: <20261007201828.952-1-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are the first eight patches of the Dynamic Capacity Device (DCD)
series. They set up: DCD enumeration, CDAT handling for DC partitions,
the event interrupt plumbing, a preparatory refactor, and
documentation of the DPA partition layout. They stand alone and keep DCD
disabled. They are not dependent on the rest of the series.

Patch 1 detects the 48h command set and then leaves mds->dcd_supported
false. The flag is only turned on by the series that adds DCD event
handling, so every DCD specific path added here is shut off at runtime:
cxl_configure_dcd() never runs, no DC partition is created, no DCD
interrupt is armed, and the CXL_PARTMODE_DYNAMIC_RAM paths are
unreachable. The intent is to land the enumeration and plumbing while
the extent to DAX pipeline is still under review.

Based on v7.3-rc6

v14: https://lore.kernel.org/linux-cxl/20260918203049.7273-1-anisa.su@samsung.com/T/#m0b6ade9da2d4fefa8aab3bb7db7c29516bc3f955

v14 -> v15 Changes:
===================
The first and only supported DC partition's DPA resource name is still
dynamic_ram_1 because the partition's sysfs directory comes from the DPA
resource name. So it would show up as /sys/bus/.../dynamic_ram_1/
No sysfs patches are in this series, those come later.

 - Patch 1: cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
        - No change.

 - Patch 2: cxl/mem: Read dynamic capacity configuration from the device
        - Renamed partition mode from CXL_PARTMODE_DYNAMIC_RAM_1 to
	  CXL_PARTMODE_DYNAMIC_RAM.
	  The mode should only describe the capacity type, not the number of
	  the partition. The _1 looks to be an artifact from v8 to v9, when we
	  went from supporting all 8 partitions down to limiting to 1.
	  The first and only supported DC partition's DPA resource name is still
	  dynamic_ram_1 because the partition's sysfs directory comes from the DPA
	  resource name. So it would show up as /sys/bus/.../dynamic_ram_1/
	  when the sysfs patches from the rest of the series are added.

 - Patch 3: cxl/cdat: Gather DSMAS data for DCD partitions
        - Disable DCD when the DC partition has no valid DSMAS entry:
          no CDAT, CDAT parse failure, or no entry matching the
          partition. A DCD shall describe its DC partition in a DSMAS
          (CXL r4.0 9.13.3), so rather than run with unknown attributes
          the device keeps its static capacity and loses DCD (Richard,
          Dave).
        - DSLBIS is optional. cxl_cdat_endpoint_process() treated zero
          DSLBIS entries as a parse failure, which with the change above
          would have disabled DCD on a device with a perfectly valid
          DSMAS. An empty DSLBIS no longer fails the parse, and
          cxl_port_perf_data_calculate() skips DSMAS entries that have
          no DSLBIS coordinates so the QTG _DSM is never evaluated with
          zero bandwidth
        - cxl_memdev_apply_dsmas() takes an enum cxl_dsmas_apply
          (FLAGS / FLAGS_PERF) instead of a bool so the call sites say
          what is applied (Dave).
        - The DSMAS read-only flag (CDAT 1.04, Flags bit 6) is recorded
          on the partition alongside shareable. (Jonathan)

 - Patch 4: cxl/events: Split event msgnum configuration from irq setup
        - No code change.

 - Patch 5: cxl/pci: Factor out interrupt policy check
        - No code change.

 - Patch 6: cxl/mem: Configure dynamic capacity interrupts
        - CXLDEV_EVENT_STATUS_STANDARD_LOGS names the four standard
          logs (INFO | WARN | FAIL | FATAL) that cxl_event_drain_mask()
          and the cxl_test mock's probe-time drain spelled out long-hand
          (Dave/Jonathan)
        - On platforms where BIOS owns the event logs, a failed Get or
          Set Event Interrupt Policy now disables DCD instead of failing
          the memdev probe. Before this series that path never reached
          the mailbox on such a platform; DCD is now the only reason it
          does, so a failure there costs DCD, not the device. With OS
          owned logs the commands remain fatal to probe as before
          (Sashiko).

 - Patch 7: cxl/core: Enforce partition order/simplify partition calls
        - No change.

 - Patch 8: Documentation/cxl: Document DPA partition layout and
   ordering rules
        - No change.

Review status
=============
Dropped all tested-by tags for patches 1-8

Patch 2: Dropped all Review tags.

Patch 3: Dropped all Review tags.

Patch 6: Dropped all Review tags.

Patch organization
==================
 1-3: enumerate DCD command support, read the DC configuration, and pick
      up DSMAS data for DC partitions.
 4-6: split event msgnum configuration from irq setup, factor out the
      interrupt policy check, then configure the DCD event interrupt.
   7: preparatory refactor -- enforce partition order while collapsing
      the ram/pmem specific partition helpers into one.
   8: document the DPA partition layout the previous patches enforce,
      and where Linux is stricter than the specification.

Testing
=======
This series leaves mds->dcd_supported false on purpose, so
cxl_configure_dcd(), cxl_dev_dc_identify() and cxl_dc_check() are
unreachable at runtime as posted. The tests below are done with the rest
of the series on top, otherwise testing would not yield any meaningful
results.

HW:
Waiting on results from partner team.

cxl_test:
ndctl's cxl suite against cxl_test (7.3.0-rc6, CXL as modules)
16 of 17 pass, cxl-features.sh skips for lack of FWCTL, and
cxl-dcd.sh passes.

QEMU:
Tested extent add/release and DAX device create/destroy.
Tested that expected errors are printed from malformed Get DC Configuration
payload.

Anisa Su (1):
  Documentation/cxl: Document DPA partition layout and ordering rules

Ira Weiny (7):
  cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
  cxl/mem: Read dynamic capacity configuration from the device
  cxl/cdat: Gather DSMAS data for DCD partitions
  cxl/events: Split event msgnum configuration from irq setup
  cxl/pci: Factor out interrupt policy check
  cxl/mem: Configure dynamic capacity interrupts
  cxl/core: Enforce partition order/simplify partition calls

 .../driver-api/cxl/linux/cxl-driver.rst       |  35 +++
 Documentation/driver-api/cxl/maturity-map.rst |   4 +
 drivers/cxl/core/cdat.c                       |  97 +++++-
 drivers/cxl/core/hdm.c                        |  24 +-
 drivers/cxl/core/mbox.c                       | 285 ++++++++++++++++++
 drivers/cxl/core/memdev.c                     |  94 ++++--
 drivers/cxl/cxl.h                             |  14 +-
 drivers/cxl/cxlmem.h                          |  88 +++++-
 drivers/cxl/mem.c                             |   2 +-
 drivers/cxl/pci.c                             | 176 +++++++++--
 include/cxl/cxl.h                             |  29 +-
 tools/testing/cxl/test/mem.c                  |   2 +-
 12 files changed, 761 insertions(+), 89 deletions(-)


base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
-- 
2.43.0

