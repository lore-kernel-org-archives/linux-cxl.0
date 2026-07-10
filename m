Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6587C434E52;
	Fri, 10 Jul 2026 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783700822; cv=none; b=LFd/HPMes7pHHRgp9AKL+zfnVk2Mcmw9t2pyFJlhAyJqYs7blWHdWM98kAIj6BREa2D04MMxT2KkPjB6K208golpLIamSwN5Gl5QRvG40cjUqqrvGKNcx+NCXzwmQsR6ZNRdUkrYPS76wMf6xZMi/s/JHzUfnFFbZ1hupBqmvgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783700822; c=relaxed/simple;
	bh=IYFVsZWbDUDmjZJgF1r3Y7n9OU4bDSbiqXArEvuUfV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3UxDIkxiANO8AuiswKeORfNR7QL18CjzT85q9pH2+I7g/bhvvTLgDmVWKdZ6Jug7W9JCSkSHNR6gdpuvmcyLgJryfMOnCvjOCxCWIuJGKypHqXRYML92+zAopXr0JscNnFIvgdRpN92MbJMFrUi0cI/8UAZluDOWh3KfJNfeIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FuvVbg6u; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FuvVbg6u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783700818; x=1815236818;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IYFVsZWbDUDmjZJgF1r3Y7n9OU4bDSbiqXArEvuUfV8=;
  b=FuvVbg6uhf1ApJmlL3C8vt74IqFNCdjG/OBj6qAzrcyxwJg30bmECjqQ
   lCO+jinNLjc7YSBFq/cI2hcc9tIOXxRru6ZenZecqu3RTD1pOFlq6PDpa
   1lXbPrgbKCtJzHGdNROhabiw/FpMkNaunQznZXekyJB2963xE9wWtMUnn
   rEsbwg6DedvOcf9hIRDtUcqahJ9dGK/NvG7Qj1pbfAWcXVhHC2h6tfKnJ
   XT/i6szjfvIPXwbPiDdyrVM52ZAwQA1Cv9ao/e3BiToEJkTIXYAcmQg6f
   NyICaWzvhf9ui9onf3FLkMpUj/UiIyD4Ml285l9wXdDDLTJcX55vDn0q4
   w==;
X-CSE-ConnectionGUID: HY1TKhXyT1OXFm9P0EjQFg==
X-CSE-MsgGUID: Zm2OqE92RYSJ2xcejUI8eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84281236"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84281236"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 09:26:56 -0700
X-CSE-ConnectionGUID: K0fZ0+qERy2T/HftTs8OMw==
X-CSE-MsgGUID: QTAz0LkZTGSq6GM3DaYvYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="250937422"
Received: from smithj1-mobl2.amr.corp.intel.com (HELO [10.125.111.214]) ([10.125.111.214])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 09:26:54 -0700
Message-ID: <6f8bf672-8e10-440c-a396-086f2c71b69f@intel.com>
Date: Fri, 10 Jul 2026 09:26:53 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] vfio/pci: Add CXL Type-2 device passthrough
 support
To: mhonap@nvidia.com, djbw@kernel.org, alex@shazbot.org, jgg@ziepe.ca,
 jic23@kernel.org, ankita@nvidia.com, alejandro.lucero-palau@amd.com,
 alison.schofield@intel.com, dave@stgolabs.net, dmatlack@google.com,
 gourry@gourry.net, ira.weiny@intel.com
Cc: cjia@nvidia.com, kjaju@nvidia.com, vsethi@nvidia.com, zhiw@nvidia.com,
 kvm@vger.kernel.org, linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260625165407.1769572-1-mhonap@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260625165407.1769572-1-mhonap@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/25/26 9:53 AM, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> CXL Type-2 accelerators (CXL.mem-capable GPUs and similar) cannot be
> passed through to virtual machines with stock vfio-pci because the
> driver has no concept of HDM decoder management, HDM region exposure,
> or component register virtualization.  This series adds those three
> pieces, sufficient for a guest to use the device's firmware-committed
> coherent memory under UVM / ATS.
> 
> v3 is a rewrite of the v2 framework form, responding to Dan's request
> in the v2 review for "less emulation, narrower interfaces, and a
> closer mapping to the spec language."
> In this release, cxl-core exposes four EXPORT_SYMBOL_GPL helpers behind
> an opaque handle.  vfio-pci becomes a thin transport on top of those.
> Please see "Changes since v2" and "Reviewer feedback addressed" below for
> the per-area summary.
> 
> Motivation
> ==========
> 
> A CXL Type-2 device exposes its HDM-mapped device memory through HDM
> decoders that BIOS programs and commits at boot.  To pass such a
> device to a guest, vfio-pci has to do three things at once:
> 
>   1. Surface the firmware-committed HDM-mapped HPA range as a guest-
>      mmappable region.
> 
>   2. Surface a CXL-spec-compliant view of the CXL Device DVSEC body,
>      the HDM Decoder Capability block, and the CXL.cache/mem cap-array
>      prefix, so the guest's CXL driver enumerates the same topology
>      the host saw.
> 
>   3. Keep the host's committed decoder configuration intact (the
>      physical decoder is never reprogrammed) while letting the guest
>      observe and manage a shadow that follows the per-field write
>      semantics in the spec.
> 
> The series builds on Alejandro Lucero-Palau's v28 work
> applied on for-7.3/cxl-type2-enabling [1] (sfc is the in-tree consumer
> today). vfio-pci becomes the second consumer.
> 
> Architecture
> ============
> 
> cxl-core owns the CXL semantics.  A new file
> drivers/cxl/core/passthrough.c (gated by hidden Kconfig
> CXL_VFIO_PASSTHROUGH) provides four exported symbols:
> 
>     struct cxl_passthrough *
>     devm_cxl_passthrough_create(struct device *dev,
>                                 struct cxl_dev_state *cxlds);
> 
>     int cxl_passthrough_dvsec_rw(p, off, val, sz, write);
>     int cxl_passthrough_hdm_rw  (p, off, val,      write);
>     int cxl_passthrough_cm_rw   (p, off, val,      write);
> 
> cxl_passthrough is an opaque handle; vfio-pci sees no cxl-internal
> struct pointers.  The shadows are snapshotted at create time: the
> DVSEC body from PCI config space dword by dword, the CM cap-array and
> HDM block from the cxl-core MMIO mapping at cxlds->reg_map.base.
> Per-field write semantics follow below:
> CXL r4.0 8.1.3 DVSEC:
> - LOCK is RWO,
> - CONTROL/CONTROL2 are RWL gated on CONFIG_LOCK,
> - STATUS/STATUS2 are RW1C,
> - RANGE1 is HwInit, RANGE2 is RsvdZ
> CXL r4.0 8.2.4.20 HDM:
> - GLOBAL_CTRL RW,
> - decoder CTRL implements COMMIT/COMMITTED,
> - decoder BASE/SIZE RWL gated on COMMITTED or LOCK_ON_COMMIT,
> - cap header HwInit).
> 
> vfio-pci becomes a thin transport.  The new module
> drivers/vfio/pci/cxl/ exposes two VFIO regions.
> 
>   VFIO_REGION_SUBTYPE_CXL (HDM region): mmappable view of the
>   HDM-mapped HPA. The mmap fault handler calls vmf_insert_pfn() from
>   the physical HPA. pread/pwrite go through the memremap_wb() kva
>   captured at bind time.
> 
>   VFIO_REGION_SUBTYPE_CXL_COMP_REGS (component register shadow):
>   pread/pwrite only, dword-aligned (-EINVAL on misalignment).
>   Each dword dispatches by offset to cxl_passthrough_cm_rw() or
>   cxl_passthrough_hdm_rw(). No shadow state on the vfio side; cxl-core
>   enforces the spec.
> 
> CXL DVSEC config-space accesses use a clipping shim in
> vfio_pci_config_rw_single(). A config-space chunk that crosses the
> DVSEC body boundary is split: header bytes go through the generic
> perm-bits path, body bytes go through cxl_passthrough_dvsec_rw().
> The shim replaces v2's approach of repointing ecap_perms[]
> 
> Sparse-mmap is exposed on the component BAR so userspace can mmap the
> non-component portions directly; only the CXL component register
> sub-range goes through pread/pwrite emulation. The CXL sub-range is
> also skipped from vfio_pci-core's request_selected_regions() set
> because cxl-core's devm_cxl_probe_mem() already holds a
> request_mem_region() on it; the asymmetric skip is matched by an
> asymmetric release on disable().
> 
> Scope and out-of-scope
> ======================
> 
> In scope (rejected at create time with -EOPNOTSUPP otherwise):
> 
>   - Firmware-committed devices (HOST_FIRMWARE_COMMITTED set).
>   - Single HDM decoder (hdm_count == 1).
>   - No interleave (IW == 0).
> 
> Out of scope, deferred for follow-on work:
> 
>   - Multi-decoder devices and interleave.
>   - Guest-driven (non-firmware-committed) HDM commit.
>   - Hotplug, FLR, and sibling-function reset of CXL Type-2 devices.
> 
> Changes since v2
> ================
> 
> This is a rewrite, not an incremental update.  The structure of the
> series changed (20 patches in v2 to 11 in v3) because v3 collapses
> v2 patches 9-15 (detection, HDM emulation, media readiness, region
> management, HDM region, DVSEC emulation) into one cxl-core helper
> file and one vfio-pci consumer.
> 
> Framework replaced by narrow opaque-handle helpers (patches 6, 8)
> 
>   v2 carried a generic register-emulation framework split across four
>   state-machine files in cxl-core.
>   v3 collapses it into one file: drivers/cxl/core/passthrough.c
>   exposing the four EXPORT_SYMBOL_GPL helpers above behind a struct
>   cxl_passthrough opaque handle.
> 
> Shadow ownership moved into cxl-core (patches 6, 8)
> 
>   vfio-pci no longer keeps any per-field state. It forwards
>   (offset, value) into cxl-core, and cxl-core enforces the spec
>   (RWO, RWL, RW1C, HwInit, RsvdZ) with explicit CXL r4.0 section
>   references in the switch arms.
> 
> DVSEC config-space clipping shim (patch 8)
> 
>   v2 repointed ecap_perms[] to redirect CXL DVSEC reads and writes.
>   v3 keeps ecap_perms[] untouched and clips per-config-access chunks
>   at the DVSEC body boundary in vfio_pci_config_rw_single(); header bytes
>   go through the generic perm-bits path, body bytes go through
>   cxl_passthrough_dvsec_rw(). The shim is local to the per-device
>   path.
> 
> CONFIG_VFIO_PCI_CXL gates the new module (patch 7)
> 
>   v2 had a CONFIG_VFIO_CXL_CORE Kconfig stub; v3 renames it to
>   CONFIG_VFIO_PCI_CXL to match the vfio-pci naming convention.
>   The hidden CXL_VFIO_PASSTHROUGH selects the cxl-core helper file
>   on demand. With both disabled, the cxl-core size is unchanged.
> 
> UAPI rewritten with named fields (patch 5)
> 
>   vfio_device_info_cap_cxl in v3 carries:
>     flags + HOST_FIRMWARE_COMMITTED bit
>     hdm_region_idx
>     comp_reg_region_idx
>     comp_reg_bar
>     comp_reg_offset
>     comp_reg_size
>   The DPA terminology is renamed to HDM region throughout.
>   CACHE_CAPABLE (HDM-DB indicator) is dropped;
>   it was informational only in v2 with no caller, and re-adding it
>   for an active CXL.cache plumbing series later.
> 
> Selftests trimmed (patch 9)
> 
>   v2 carried selftests for device detection, capability parsing,
>   region enumeration, HDM register emulation, HDM mmap with
>   page-fault insertion, FLR invalidation, and DVSEC register
>   emulation. v3 keeps a smoke-test set of six focused tests:
> 
>     device_is_cxl                  GET_INFO advertises FLAGS_CXL
>                                    and a populated CAP_CXL.
>     hdm_region_mmap_rw             mmap one page, write+read back.
>     component_bar_sparse_mmap      SPARSE_MMAP cap excludes the
>                                    CXL component register sub-range.
>     comp_regs_cm_cap_array_read    pread of the CM cap-array
>                                    header at CXL_CM_OFFSET succeeds
>                                    (CAP_ID == 1).
>     dvsec_lock_byte_read           pread of the DVSEC CONFIG_LOCK
>                                    byte through the clipping shim
>                                    succeeds.
>     hdm_decoder_commit_fsm         COMMIT / COMMITTED state machine
>                                    and LOCK_ON_COMMIT behaviour.
> 
>   FLR invalidation, page-fault insertion under load, and full
>   DVSEC field-by-field write coverage are deferred to a follow-on
>   selftest series. The current six are the minimal set that
>   exercises the kernel-side contract end-to-end.
> 
> cxl-core prep patches split (patches 1-4)
> 
>   v3 keeps the cxl-side enablers from v2 patches 1-4 but each as
>   a standalone change so the cxl maintainer can review the helper
>   API independently of the vfio consumer:
> 
>     [1/11] cxl_get_hdm_info()
>     [2/11] cxl_await_range_active() split from media-ready wait
>     [3/11] cxl_register_map records BIR + BAR offset
>     [4/11] component/HDM register defines moved to uapi/cxl/cxl_regs.h
> 
> Reviewer feedback addressed
> ===========================
> 
> Dan
> ---
> 
> - VFIO exposes HDM/host-visible region, not raw DPA; docs/UAPI say HDM
>   region, DPA only inside cxl-core where appropriate.
> - One vfio-pci device = one HDM region / one decoder, no interleave;
>   hdm_count != 1 → -EOPNOTSUPP.
> - Global HDM on DVSEC Range Base treated as legacy; RANGE1/RANGE2
>   read-only snapshot, guest writes dropped.
> - No guest/kernel lock games; DVSEC LOCK and HDM LOCK_ON_COMMIT RWO,
>   fixed at create from firmware snapshot.
> - Opaque cxl_passthrough handle only; vfio gets HPA via memdev probe +
>   layout via cxl_get_hdm_info(), rw via helpers.
> - No multi-region accelerator case in v3; single region enforced,
>   multi-region deferred.
> - cxl_await_range_active stays in cxl-core probe; not exported, vfio does
>   not call it.
> - No guest LOCK→0 reprogram; guest cannot clear LOCK to remap host HPA;
>   kernel uncommit tied to COMMIT, not LOCK alone.
> 
> Jason / Gregory / Dan
> ---------------------
> 
> - memremap(WB) + request_mem_region on HPA; conflicting direct-map/EFI use
>   fails probe with -EBUSY.
> 
> Jonathan
> --------
> 
> - uapi/cxl/cxl_regs.h for register defines so VMMs need no private
>   kernel headers.
> - __free() locals on cxl-core/passthrough error paths instead of
>   struct-owned temporaries.
> - No "precommitted at probe" assumption; acquire checks COMMITTED in
>   HDM shadow and refuses if missing.
> 
> Dave
> ----
> 
> - memremap(MEMREMAP_WB) for HDM host mapping (not ioremap_cache).
> - Renamed cap flag to VFIO_CXL_CAP_HOST_FIRMWARE_COMMITTED for clarity.
> - __free() / DEFINE_FREE() cleanup in new passthrough.c create path.
> 
> Patch series
> ============
> 
>  [1/11] cxl: Add cxl_get_hdm_info() helper for HDM decoder metadata
>  [2/11] cxl: Split cxl_await_range_active() from media-ready wait
>  [3/11] cxl: Record BIR and BAR offset in cxl_register_map
>  [4/11] cxl: Move component/HDM register defines to
>         uapi/cxl/cxl_regs.h
>  [5/11] vfio: UAPI for CXL Type-2 device passthrough
>  [6/11] cxl: Add register-virtualization helpers for vfio Type-2
>         passthrough
>  [7/11] vfio/pci: Add CONFIG_VFIO_PCI_CXL with bind-time CXL Type-2
>         acquisition
>  [8/11] vfio/pci/cxl: Add HDM + COMP_REGS regions and DVSEC clipping
>         shim
>  [9/11] selftests/vfio: Add CXL Type-2 device passthrough smoke test
> [10/11] docs: vfio-pci: Document CXL Type-2 device passthrough
> [11/11] vfio/pci: Provide opt-out for CXL Type-2 extensions
> 
> Dependencies
> ============
> 
> [1] [PATCH v28 0/5] Type2 device basic support
> https://lore.kernel.org/linux-cxl/20260618181806.118745-1-alejandro.lucero-palau@amd.com/
> 
> [2] Previous version of this patch series
> [PATCH v2 00/20] vfio/pci: Add CXL Type-2 device passthrough support
> https://lore.kernel.org/linux-cxl/20260401143917.108413-1-mhonap@nvidia.com/
> 
> [3] Companion QEMU series
> [RFC 0/9] QEMU: CXL Type-2 device passthrough via vfio-pci
> https://lore.kernel.org/linux-cxl/20260427181235.3003865-1-mhonap@nvidia.com/
> 
> Manish Honap (11):
>   cxl: Add cxl_get_hdm_info() helper for HDM decoder metadata
>   cxl: Split cxl_await_range_active() from media-ready wait
>   cxl: Record BIR and BAR offset in cxl_register_map
>   cxl: Move component/HDM register defines to uapi/cxl/cxl_regs.h
>   vfio: UAPI for CXL Type-2 device passthrough
>   cxl: Add register-virtualization helpers for vfio Type-2 passthrough
>   vfio/pci: Add CONFIG_VFIO_PCI_CXL with bind-time CXL Type-2
>     acquisition
>   vfio/pci/cxl: Add HDM + COMP_REGS regions and DVSEC clipping shim
>   selftests/vfio: Add CXL Type-2 device passthrough smoke test
>   docs: vfio-pci: Document CXL Type-2 device passthrough
>   vfio/pci: Provide opt-out for CXL Type-2 extensions
> 
>  Documentation/driver-api/index.rst            |   1 +
>  Documentation/driver-api/vfio-pci-cxl.rst     | 282 ++++++
>  drivers/cxl/Kconfig                           |   7 +
>  drivers/cxl/core/Makefile                     |   1 +
>  drivers/cxl/core/passthrough.c                | 590 ++++++++++++
>  drivers/cxl/core/pci.c                        |  70 +-
>  drivers/cxl/core/regs.c                       |  35 +
>  drivers/cxl/cxl.h                             |  52 +-
>  drivers/vfio/pci/Kconfig                      |   2 +
>  drivers/vfio/pci/Makefile                     |   1 +
>  drivers/vfio/pci/cxl/Kconfig                  |  34 +
>  drivers/vfio/pci/cxl/Makefile                 |   2 +
>  drivers/vfio/pci/cxl/vfio_cxl_core.c          | 889 ++++++++++++++++++
>  drivers/vfio/pci/cxl/vfio_cxl_priv.h          |  71 ++
>  drivers/vfio/pci/vfio_pci.c                   |   9 +
>  drivers/vfio/pci/vfio_pci_config.c            |  31 +
>  drivers/vfio/pci/vfio_pci_core.c              |  68 +-
>  drivers/vfio/pci/vfio_pci_priv.h              |  93 ++
>  drivers/vfio/pci/vfio_pci_rdwr.c              |  17 +
>  include/cxl/cxl.h                             |  18 +
>  include/cxl/passthrough.h                     | 121 +++
>  include/linux/vfio_pci_core.h                 |   8 +
>  include/uapi/cxl/cxl_regs.h                   |  63 ++
>  include/uapi/linux/vfio.h                     |  46 +
>  tools/testing/selftests/vfio/Makefile         |   1 +
>  .../selftests/vfio/lib/vfio_pci_device.c      |  11 +-
>  .../selftests/vfio/vfio_cxl_type2_test.c      | 350 +++++++
>  27 files changed, 2821 insertions(+), 52 deletions(-)
>  create mode 100644 Documentation/driver-api/vfio-pci-cxl.rst
>  create mode 100644 drivers/cxl/core/passthrough.c
>  create mode 100644 drivers/vfio/pci/cxl/Kconfig
>  create mode 100644 drivers/vfio/pci/cxl/Makefile
>  create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_core.c
>  create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_priv.h
>  create mode 100644 include/cxl/passthrough.h
>  create mode 100644 include/uapi/cxl/cxl_regs.h
>  create mode 100644 tools/testing/selftests/vfio/vfio_cxl_type2_test.c
> 
> base-commit: 90cf2e0d702c8a132ccbe72e7687f33c04c14658

Hi Manish,
b4 seems to be failing with applying on top of this base-commit.


