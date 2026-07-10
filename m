Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859733955FF;
	Fri, 10 Jul 2026 21:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783720612; cv=none; b=HTO0f/4pP1mzcUfqVoAlVsXXJAt0cpgvWoMHlTJdTbfbgr3DUUMu05FpS3DdyehLfBP1v/27uAvTL8xUWfopZ5XtkWivUYFQOlvt1vqWXFvrEOsU3LDjDUpp8k6egEvqlyc/7yIs5plsSME9RXhFacRqIapnE3eXhpktCtcDZmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783720612; c=relaxed/simple;
	bh=G+V7KLBu+YUjsdj55W/3Is+D/ERT4z9n7mBUnr8xkoA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=L5AmqmwDNx0fyPMPji5COhAzBpMcBd4bxaG5oen+gIfFqH62fg6Lx+Xu0N/PsR29Kjh45jC62JT3SUcNWYDm9IZE5VNjZFbF2SwYygjY0nc1ND56G0hKc0sY+KMMctMfBQN7hUhdWIkD/c5Fu4PgUQGUZdO5Le+N/eC4pR/H6oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+hLZSgy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+hLZSgy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5C71F00A3D;
	Fri, 10 Jul 2026 21:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783720610;
	bh=dcLqSyPTlqf7JCb7XBEKNsyTBYjzwiboiKQq3lVN5Qk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=d+hLZSgyFu0wfmrOVJKvrP/qlzb8uiGJGTBuQsj/VqCAVFlS46ezSfF1Ay4MPiW48
	 CyRoI347vP0Tbr3875QjXsSxqWafl+QSwmC5oeYYE6pByr/Na6AKOhyGFQeaouZEBC
	 QR8Z0h+SasIFRI8ax/19JhUIRimoqq0A9BMGQRWHXy6zjN2+W659h3l3wbpznyN/zh
	 bggmD9XtwIpF7IN28zMOmd7PviOOQpRkbLvv8Wrc8ELNiUucIyQ7LGYl4jPAqsxioM
	 zeZaj9bjKpay2Sm1Z7IUjwFUxbPL7Nlqnm7QFJKPJ2dqqLOTJtwQlCnkSlFer0gxoj
	 GGQUmm9R5YibA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9A6EFF40236;
	Fri, 10 Jul 2026 17:56:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 10 Jul 2026 17:56:48 -0400
X-ME-Sender: <xms:oGpRajXfFqx30YVlmEKtZVxfgwz8jbhYcWT0Y29naqgFj-tZEdcWrQ>
    <xme:oGpRagebc48xT6TYSQbX79kRxpr4A2y4WVrnD41XbZGmEuWfqAOgdOLHUAYWHNPEF
    PHvnjIlCGwB97BVE-EPkjws7IX4fBFs78c5ehr-X5iOlaot0G_8Vg>
X-ME-Received: <xmr:oGpRas9cIUZUPYzvfKEpkrfdqnXjP0U3ydcrv9aVMcY3t25OLs7h0333jOmJjtJ9wMjgrfKJeKIu25wPNs2TMPnIf-1tCTPwOio>
X-ME-Proxy-Cause: dmFkZTFLtg+YqWUhOEF/WtpIBFsZc3bKTzyiq5hRZmsHLR+ozQ5AhiwlA6W6utzPwilAM7
    xf1BBBrf+l8XQmee5vcdytusSHszXoTCe5M0tUtVxbHLFatXRn0a1geqgMQC96ktFQJvMs
    HqNlMpbg3ezIFYdXp8Fz1UsY0XTprTyAPQMSdddrAnp+q1Q9nLWhFblfGCbgXQtrR6dKwj
    4HDoSQEnbjZWDOPjKGfr81FiKSzftZaU4w13iv/nPVTKveW8vBgfW6wvMSznnju2ZZNvRY
    GsdLX8yy4qIaGVxVXDIB7i7FC3Re6OQxB/ML1fNvgC+zh9I244aaaC9UAYZquYrKn7s+Dk
    xqkOmgW0UxUdeDznLNzcO32Qx1y0S7av4htDEXj44lkqpKhY9c/4NBi0oOE8LzwioEVTzC
    es8yA2i2OS6onc2IsevUsPjZsA9cQUD9eGx6gc8LvX0CoXHarG2rv49BGwdk5CS5t2HwlR
    JmKjlUIEU5ninZPqsIi5gB8QaqMitFwJHQoYmTEsb0peaZCSY5LAQcxCYd+CEagGFLD7dM
    xUVrkPXE0UENq7U7oASjqqpWb+j8PZUGr9q3KK9X1U7xaiawSMO1DCCTAjyUArRkUUxGmj
    g9zESev5k7Lixbn8HGDQuhIznYirIDOWdVzsIztMrfi3H0FPQpzCWuz/RV1g
X-ME-Proxy: <xmx:oGpRagZODfN7OfDnbNp8CNs9ERUYdXaPwJJSTZ1EzQmjjUznlQIqWQ>
    <xmx:oGpRasv1ky6q1IrwZsQ_oYmedj7Ek8jZuXV490FZ7h3zsGgcNkaodQ>
    <xmx:oGpRatZQIjM89pZDJ71byLJJ2C4OraYYwVkcJiXHyF5Xpi2jt2WaAw>
    <xmx:oGpRagTvQfy5pFHnr61bbJngSCv9DbcKLFHUGx4LA6t1GZjRNHpucA>
    <xmx:oGpRaoxtXOZYoP6ef6yVH1lBs60EIvfhdvROhMUfFAjYbtsLhLKRds4f>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 17:56:47 -0400 (EDT)
Date: Fri, 10 Jul 2026 14:56:46 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: mhonap@nvidia.com, 
 djbw@kernel.org, 
 alex@shazbot.org, 
 jgg@ziepe.ca, 
 jic23@kernel.org, 
 dave.jiang@intel.com, 
 ankita@nvidia.com, 
 alejandro.lucero-palau@amd.com, 
 alison.schofield@intel.com, 
 dave@stgolabs.net, 
 dmatlack@google.com, 
 gourry@gourry.net, 
 ira.weiny@intel.com
Cc: cjia@nvidia.com, 
 kjaju@nvidia.com, 
 vsethi@nvidia.com, 
 zhiw@nvidia.com, 
 mhonap@nvidia.com, 
 kvm@vger.kernel.org, 
 linux-cxl@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <6a516a9e86b8_3cfbb510040@djbw-dev.notmuch>
In-Reply-To: <20260625165407.1769572-7-mhonap@nvidia.com>
References: <20260625165407.1769572-1-mhonap@nvidia.com>
 <20260625165407.1769572-7-mhonap@nvidia.com>
Subject: Re: [PATCH v3 06/11] cxl: Add register-virtualization helpers for
 vfio Type-2 passthrough
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

mhonap@ wrote:
> From: Manish Honap <mhonap@nvidia.com>
> =

> vfio-pci needs the CXL Device DVSEC body, the HDM Decoder Capability
> block, and the CXL.cache/mem cap-array prefix to be virtualized
> toward a KVM guest in a CXL-spec-compliant way.
> =

> Introduce a narrow helper API owned by cxl-core:
> =

>   struct cxl_passthrough *
>   devm_cxl_passthrough_create(struct device *dev,
>                               struct cxl_dev_state *cxlds);
> =

>   int cxl_passthrough_dvsec_rw(struct cxl_passthrough *p, u32 off,
>                                u32 *val, size_t sz, bool write);
>   int cxl_passthrough_hdm_rw(struct cxl_passthrough *p, u32 off,
>                              u32 *val, bool write);
>   int cxl_passthrough_cm_rw(struct cxl_passthrough *p, u32 off,
>                             u32 *val, bool write);
> =

> Each helper takes a per-device mutex covering the DVSEC + HDM shadows
> (the CM cap-array snapshot is immutable after create) and dispatches
> by offset to a hand-written write handler against CXL r4.0 =C2=A78.1.3
> (DVSEC: LOCK is RWO, CONTROL/CONTROL2 are RWL gated on CONFIG_LOCK,
> STATUS/STATUS2 are RW1C, RANGE1 is HwInit, RANGE2 is RsvdZ) and
> =C2=A78.2.4.20 (HDM: GLOBAL_CTRL RW, decoder CTRL implements
> COMMIT/COMMITTED, decoder BASE/SIZE RWL gated on COMMITTED or
> LOCK_ON_COMMIT, cap header HwInit).
> =

> Writes to the CM cap-array are silently discarded because the
> cap-array headers are RO per CXL r4.0 =C2=A78.2.4; the write parameter =
is
> kept on the rw API to make the drop policy explicit at the call site.
> =

> The shadows are snapshotted at create time: the DVSEC body from PCI
> config space dword-at-a-time, the CM cap-array and HDM block from
> the cxl-core MMIO mapping at cxlds->reg_map.base.  This preserves
> firmware-committed values so the guest reads what the host BIOS
> committed, while writes update the shadow per the per-field write
> semantics above.
> =

> The file is gated by the hidden Kconfig CXL_VFIO_PASSTHROUGH so the
> passthrough code stays out of cxl_core when no vfio consumer is configu=
red.
> =

> Scope: firmware-committed, single-decoder, no-interleave Type-2
> passthrough.  Multi-decoder, interleave, and hotplug are
> out-of-scope and rejected at create time (-EOPNOTSUPP for
> hdm_count !=3D 1).

Hi Manish, many style comments below, but one hard concern to highlight
is that some component capability registers require 64-bit access.

> =

> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/cxl/Kconfig            |   7 +
>  drivers/cxl/core/Makefile      |   1 +
>  drivers/cxl/core/passthrough.c | 590 +++++++++++++++++++++++++++++++++=


Likely this should be called vfio.c because nothing in this file is
relevant to the rest of the CXL core. However, it is not even clear
there is value in it living in drivers/cxl/.

A lot of this code is a VFIO backend implemnentation detail, not
anything that CXL core needs. It also seems to have little if any
dependency on any core symbols. Does it really belong in
drivers/cxl/core/?

>  include/cxl/passthrough.h      | 121 +++++++
>  4 files changed, 719 insertions(+)
>  create mode 100644 drivers/cxl/core/passthrough.c
>  create mode 100644 include/cxl/passthrough.h
> =

> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 80aeb0d556bd..7c874d486a9c 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -19,6 +19,13 @@ menuconfig CXL_BUS
>  =

>  if CXL_BUS
>  =

> +config CXL_VFIO_PASSTHROUGH
> +	bool
> +	# Hidden symbol selected by VFIO_PCI_CXL to pull
> +	# drivers/cxl/core/passthrough.c into cxl_core when a vfio
> +	# Type-2 passthrough consumer is configured.  Keep silent: no
> +	# help text, no default, no user-visible prompt.

No need for a paragraph of documentation to explain why this prompt has
no documention. If probably just be called CXL_VFIO.

> +
>  config CXL_PCI
>  	tristate "PCI manageability"
>  	default CXL_BUS
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index ce7213818d3c..0cc80bd35a88 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -22,3 +22,4 @@ cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) +=3D edac.o
>  cxl_core-$(CONFIG_CXL_RAS) +=3D ras.o
>  cxl_core-$(CONFIG_CXL_RAS) +=3D ras_rch.o
>  cxl_core-$(CONFIG_CXL_ATL) +=3D atl.o
> +cxl_core-$(CONFIG_CXL_VFIO_PASSTHROUGH) +=3D passthrough.o
> diff --git a/drivers/cxl/core/passthrough.c b/drivers/cxl/core/passthro=
ugh.c
> new file mode 100644
> index 000000000000..b89829586024
> --- /dev/null
> +++ b/drivers/cxl/core/passthrough.c
> @@ -0,0 +1,590 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2026 NVIDIA Corporation. All rights reserved.
> + *
> + * vfio-pci Type-2 device passthrough =E2=80=94 CXL register virtualiz=
ation.
> + *
> + * Owns the CXL spec-defined virtualization semantics for the
> + *   - CXL Device DVSEC capability body  (CXL r4.0 =C2=A78.1.3)
> + *   - HDM Decoder Capability block      (CXL r4.0 =C2=A78.2.4.20)
> + *   - CXL.cache/mem (CM) cap-array      (CXL r4.0 =C2=A78.2.4)
> + *
> + * vfio-pci is the only caller.  This file is NOT a generic emulation
> + * framework: every register the guest may touch has a hand-written
> + * write handler against the spec.  Reads serve from a shadow
> + * snapshotted at create time; writes update the shadow per the spec
> + * attribute mode for that field.
> + *
> + * Scope: firmware-committed, single-decoder, no-interleave Type-2
> + * passthrough.  Multi-decoder, interleave, and hotplug are
> + * out-of-scope and rejected at create time.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/export.h>
> +#include <linux/io.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/pci_ids.h>
> +#include <linux/pci_regs.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +
> +#include <uapi/cxl/cxl_regs.h>
> +
> +#include <cxlpci.h>
> +#include <cxlmem.h>
> +#include <cxl/cxl.h>
> +#include <cxl/passthrough.h>
> +
> +#include "core.h"
> +
> +/* DVSEC CXL Device body offsets =E2=80=94 relative to DVSEC capabilit=
y start.
> + * Body begins at PCI_DVSEC_CXL_CAP (0x0a); preceding bytes are the PC=
I
> + * ext-cap header and DVSEC headers handled by the generic vfio
> + * perm-bits path.
> + */
> +#define DVSEC_OFF_CAPABILITY		PCI_DVSEC_CXL_CAP	/* 0x0a, u16 */
> +#define DVSEC_OFF_CONTROL		PCI_DVSEC_CXL_CTRL	/* 0x0c, u16 */
> +#define DVSEC_OFF_STATUS		0x0e			/* u16 */
> +#define DVSEC_OFF_CONTROL2		0x10			/* u16 */
> +#define DVSEC_OFF_STATUS2		0x12			/* u16 */
> +#define DVSEC_OFF_LOCK			0x14			/* u16 */
> +#define DVSEC_OFF_RANGE1_SIZE_HI	0x18			/* u32 */
> +#define DVSEC_OFF_RANGE1_SIZE_LO	0x1c
> +#define DVSEC_OFF_RANGE1_BASE_HI	0x20
> +#define DVSEC_OFF_RANGE1_BASE_LO	0x24
> +#define DVSEC_OFF_RANGE2_SIZE_HI	0x28
> +#define DVSEC_OFF_RANGE2_SIZE_LO	0x2c
> +#define DVSEC_OFF_RANGE2_BASE_HI	0x30
> +#define DVSEC_OFF_RANGE2_BASE_LO	0x34
> +#define DVSEC_BODY_END			0x38

Please do not duplicate the existing definitions in
include/uapi/linux/pci_regs.h.

> +
> +#define DVSEC_LOCK_CONFIG_LOCK		BIT(0)

> +
> +/* HDM Decoder Capability block offsets =E2=80=94 relative to HDM bloc=
k base.
> + * Decoder N register set starts at 0x10 + N * 0x20.
> + */
> +#define HDM_OFF_CAP_HEADER		0x00
> +#define HDM_OFF_GLOBAL_CTRL		0x04
> +#define HDM_DEC_BASE			0x10
> +#define HDM_DEC_STRIDE			0x20
> +#define HDM_DEC_OFF_BASE_LO(n)		(HDM_DEC_BASE + (n) * HDM_DEC_STRIDE +=
 0x00)
> +#define HDM_DEC_OFF_BASE_HI(n)		(HDM_DEC_BASE + (n) * HDM_DEC_STRIDE +=
 0x04)
> +#define HDM_DEC_OFF_SIZE_LO(n)		(HDM_DEC_BASE + (n) * HDM_DEC_STRIDE +=
 0x08)
> +#define HDM_DEC_OFF_SIZE_HI(n)		(HDM_DEC_BASE + (n) * HDM_DEC_STRIDE +=
 0x0c)
> +#define HDM_DEC_OFF_CTRL(n)		(HDM_DEC_BASE + (n) * HDM_DEC_STRIDE + 0x=
10)
> +
> +/* HDM Decoder CTRL bits per CXL r4.0 =C2=A78.2.4.20.5. */
> +#define HDM_CTRL_LOCK_ON_COMMIT		BIT(8)
> +#define HDM_CTRL_COMMIT			BIT(9)
> +#define HDM_CTRL_COMMITTED		BIT(10)
> +#define HDM_CTRL_ERR_NOT_COMMITTED	BIT(11)

Please do not duplicate the definitions in drivers/cxl/cxl.h?

If you move this file to drivers/vfio/ then also move the definitions to
include/cxl/.

> +struct cxl_passthrough {

This structure should be called cxl_vfio so that any grep for "vfio" in
drivers/cxl/ brings up this code. Otherwise "passthrough" is not a term
I would expect someone to understand is immediately vfio related. Even
drivers/vfio/ barely uses the term.

> +	struct cxl_dev_state *cxlds;
> +
> +	/* DVSEC body shadow.  Byte-indexed by (off - PCI_DVSEC_CXL_CAP).
> +	 * Allocated rounded up to a dword so dword reads at the tail
> +	 * never overrun.
> +	 */
> +	u8 *dvsec_shadow;
> +	u16 dvsec_size;			/* full DVSEC cap length, incl. headers */
> +	bool dvsec_config_locked;
> +
> +	/* HDM block shadow.  Byte-indexed; size =3D hdm_reg_size. */
> +	u8 *hdm_shadow;
> +	resource_size_t hdm_reg_size;
> +
> +	/* CM cap-array snapshot.  Dword-indexed by (off / 4) where off
> +	 * is the byte offset from CXL_CM_OFFSET.  Read-only after create.
> +	 */
> +	__le32 *cm_snapshot;
> +	size_t cm_snapshot_dwords;
> +
> +	/* Covers dvsec_shadow + dvsec_config_locked + hdm_shadow.
> +	 * cm_snapshot is immutable after create; no lock needed.  Leaf-
> +	 * level: no entry point holding this mutex calls into cxl-bus or
> +	 * vfio.
> +	 */
> +	struct mutex lock;
> +};
> +
> +/* ------------------------------------------------------------------ =
*/
> +/* Snapshot helpers                                                   =
 */
> +/* ------------------------------------------------------------------ =
*/
> +
> +/* Read the DVSEC body bytes [PCI_DVSEC_CXL_CAP, dvsec_size) from PCI
> + * config space into the shadow.
> + *
> + * The body starts at PCI_DVSEC_CXL_CAP (0x0a), which is word-aligned =
but
> + * NOT dword-aligned, and CXL r4.0 =C2=A78.1.3 places six 16-bit descr=
iptors
> + * (CAPABILITY through LOCK) at offsets 0x0a..0x14 before any 32-bit
> + * field.  Strict-alignment PCIe host bridges (e.g. ARM64 ECAM) reject=

> + * misaligned dword config accesses with PCIBIOS_BAD_REGISTER_NUMBER;
> + * snapshot at the natural granularity of the body's 16-bit descriptor=
s
> + * (2-byte stride) so every offset in the range is naturally aligned.
> + */
> +static int snapshot_dvsec_body(struct cxl_passthrough *p)
> +{
> +	struct pci_dev *pdev =3D to_pci_dev(p->cxlds->dev);
> +	u16 dvsec =3D p->cxlds->cxl_dvsec;
> +	u16 off;
> +	u16 word;
> +	int rc;
> +
> +	for (off =3D PCI_DVSEC_CXL_CAP; off < p->dvsec_size; off +=3D 2) {
> +		rc =3D pci_read_config_word(pdev, dvsec + off, &word);
> +		if (rc)
> +			return -EIO;
> +		put_unaligned_le16(word, p->dvsec_shadow +
> +				   (off - PCI_DVSEC_CXL_CAP));
> +	}
> +	return 0;
> +}
> +
> +/* Read the CM cap-array prefix [CXL_CM_OFFSET, hdm_reg_offset) from
> + * MMIO into cm_snapshot, and the HDM block [hdm_reg_offset,
> + * hdm_reg_offset + hdm_reg_size) into hdm_shadow.
> + *
> + * @base is a short-lived kva for the component register block,
> + * established by the caller via ioremap() against cxlds->reg_map.reso=
urce.
> + * cxl_setup_regs() drops its own ioremap (clears reg_map.base) after =
the
> + * cap-array probe completes, so this function cannot rely on
> + * cxlds->reg_map.base being valid; the caller passes a fresh mapping
> + * here and releases it once snapshot data has been copied into the
> + * in-memory shadows.

This commentary is point in time research about how the CXL core
behaves. I do not see a reason for devm_cxl_vfio_create() to document
the semantics of cxl_setup_regs().

If you want to add documentation that explains how cxl_setup_regs()
works that belongs on cxl_setup_regs() directly.

Lastly cxl_setup_regs() is a convenience function for the cxl_pci driver
that wants to parse the component register block into per capability
sparse mappings. The only functionality this implementation wants is the
base resource address, but that might change with the next comment.

> + */
> +static void snapshot_cm_and_hdm(struct cxl_passthrough *p,
> +				void __iomem *base,
> +				resource_size_t hdm_off)
> +{
> +	size_t i;
> +
> +	for (i =3D 0; i < p->cm_snapshot_dwords; i++)
> +		p->cm_snapshot[i] =3D cpu_to_le32(readl(base + CXL_CM_OFFSET +
> +						      i * 4));

Unfortunately there are some registers that are 64-bit only registers.

The spec says: "A 64-bit register shall be accessed as an 8-byte
quantity. Partial reads are not permitted."

That means if a device has a link capability structure, a CHMU, or a
CPMU then this implementation will violate that requirement. Maybe the
implemetnation indeed needs to limit the component register blocks that
are supported.

> +
> +	for (i =3D 0; i < p->hdm_reg_size / 4; i++)
> +		put_unaligned_le32(readl(base + hdm_off + i * 4),
> +				   p->hdm_shadow + i * 4);
> +}
> +
> +/* ------------------------------------------------------------------ =
*/
> +/* devres                                                             =
 */
> +/* ------------------------------------------------------------------ =
*/
> +
> +static void cxl_passthrough_release(struct device *dev, void *res)
> +{
> +	struct cxl_passthrough *p =3D *(struct cxl_passthrough **)res;
> +
> +	kfree(p->dvsec_shadow);
> +	kfree(p->hdm_shadow);
> +	kfree(p->cm_snapshot);
> +	mutex_destroy(&p->lock);
> +	kfree(p);
> +}
> +
> +struct cxl_passthrough *
> +devm_cxl_passthrough_create(struct device *dev, struct cxl_dev_state *=
cxlds)
> +{
> +	struct cxl_passthrough **dres;
> +	struct cxl_passthrough *p;
> +	struct pci_dev *pdev;
> +	resource_size_t hdm_off, hdm_size;
> +	size_t dvsec_shadow_size;
> +	u8 hdm_count;
> +	u32 hdr;
> +	int rc;
> +
> +	/*
> +	 * cxl_setup_regs() releases its short-lived ioremap before returning=
,
> +	 * so reg_map.base is NULL by the time we run.  Validate the persiste=
nt
> +	 * fields (resource address and size) instead; the local ioremap
> +	 * established further below covers the snapshot reads.
> +	 */

This is the cxl_setup_regs() documentation again.


> +	if (!dev || !cxlds || !cxlds->dev || !cxlds->cxl_dvsec ||
> +	    !cxlds->reg_map.resource || !cxlds->reg_map.max_size)
> +		return ERR_PTR(-EINVAL);
> +
> +	pdev =3D to_pci_dev(cxlds->dev);
> +
> +	rc =3D cxl_get_hdm_info(cxlds, &hdm_count, &hdm_off, &hdm_size);
> +	if (rc)
> +		return ERR_PTR(rc);
> +	if (hdm_count !=3D 1 || !hdm_size || hdm_off <=3D CXL_CM_OFFSET ||
> +	    !IS_ALIGNED(hdm_size, 4))
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	p =3D kzalloc_obj(*p, GFP_KERNEL);
> +	if (!p)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mutex_init(&p->lock);
> +	p->cxlds =3D cxlds;
> +	p->hdm_reg_size =3D hdm_size;
> +
> +	/* DVSEC body length from PCI ext-cap header. */
> +	rc =3D pci_read_config_dword(pdev, cxlds->cxl_dvsec + PCI_DVSEC_HEADE=
R1,
> +				   &hdr);
> +	if (rc) {
> +		rc =3D -EIO;
> +		goto err;
> +	}
> +	p->dvsec_size =3D PCI_DVSEC_HEADER1_LEN(hdr);
> +	if (p->dvsec_size < DVSEC_BODY_END) {
> +		rc =3D -EINVAL;
> +		goto err;
> +	}
> +
> +	dvsec_shadow_size =3D round_up(p->dvsec_size - PCI_DVSEC_CXL_CAP, 4);=

> +	p->dvsec_shadow =3D kzalloc(dvsec_shadow_size, GFP_KERNEL);
> +	if (!p->dvsec_shadow) {
> +		rc =3D -ENOMEM;
> +		goto err;
> +	}
> +
> +	p->cm_snapshot_dwords =3D (hdm_off - CXL_CM_OFFSET) / 4;
> +	p->cm_snapshot =3D kcalloc(p->cm_snapshot_dwords, sizeof(__le32),
> +				 GFP_KERNEL);
> +	if (!p->cm_snapshot) {
> +		rc =3D -ENOMEM;
> +		goto err;
> +	}
> +
> +	p->hdm_shadow =3D kzalloc(hdm_size, GFP_KERNEL);
> +	if (!p->hdm_shadow) {
> +		rc =3D -ENOMEM;
> +		goto err;
> +	}
> +
> +	rc =3D snapshot_dvsec_body(p);
> +	if (rc)
> +		goto err;
> +
> +	{
> +		void __iomem *base;

Just declare this at the top and skip the new scope, or just make this a
helper function.

> +
> +		/*
> +		 * Bind-time-only ioremap.  cxl_setup_regs() has already
> +		 * released the cxl-core ioremap (see comment on the entry
> +		 * gate).  Take a fresh, short-lived mapping for the
> +		 * snapshot, then release it; all subsequent reads serve
> +		 * from the in-memory shadows.
> +		 */

More redundant explanation of the cxl_setup_pci_regs() semantics.

> +		base =3D ioremap(cxlds->reg_map.resource,
> +			       cxlds->reg_map.max_size);
> +		if (!base) {
> +			rc =3D -ENOMEM;
> +			goto err;
> +		}
> +		snapshot_cm_and_hdm(p, base, hdm_off);
> +		iounmap(base);
> +	}
> +
> +	dres =3D devres_alloc(cxl_passthrough_release, sizeof(*dres),
> +			    GFP_KERNEL);
> +	if (!dres) {
> +		rc =3D -ENOMEM;
> +		goto err;
> +	}
> +	*dres =3D p;
> +	devres_add(dev, dres);

This is just:

rc =3D devm_add_action_or_reset(dev, cxl_passthrough_release, p);
if (rc)
	return ERR_PTR(rc);

> +	return p;
> +
> +err:
> +	kfree(p->dvsec_shadow);
> +	kfree(p->cm_snapshot);
> +	kfree(p->hdm_shadow);
> +	mutex_destroy(&p->lock);
> +	kfree(p);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_passthrough_create, "CXL");
> +
> +/* ------------------------------------------------------------------ =
*/
> +/* DVSEC write semantics                                              =
 */
> +/* ------------------------------------------------------------------ =
*/
> +
> +static u16 dvsec_shadow_get_u16(struct cxl_passthrough *p, u16 off)
> +{
> +	return get_unaligned_le16(p->dvsec_shadow + (off - PCI_DVSEC_CXL_CAP)=
);
> +}
> +
> +static void dvsec_shadow_set_u16(struct cxl_passthrough *p, u16 off, u=
16 val)
> +{
> +	put_unaligned_le16(val, p->dvsec_shadow + (off - PCI_DVSEC_CXL_CAP));=

> +}
> +
> +/* Apply a write to a single DVSEC field at @off, with the field's
> + * native width (2 for descriptors, 4 for RANGE entries).  @width is
> + * the field's spec width; @new is the merged value to apply.  Caller
> + * holds p->lock.
> + */
> +static void dvsec_apply_write(struct cxl_passthrough *p, u16 off, size=
_t width,
> +			      u32 new)
> +{
> +	u16 cur16;
> +
> +	switch (off) {
> +	case DVSEC_OFF_CAPABILITY:
> +		/* HwInit =E2=80=94 drop. */
> +		return;
> +	case DVSEC_OFF_CONTROL:
> +	case DVSEC_OFF_CONTROL2:
> +		/* RWL =E2=80=94 gated on CONFIG_LOCK. */
> +		if (p->dvsec_config_locked)
> +			return;
> +		dvsec_shadow_set_u16(p, off, (u16)new);
> +		return;
> +	case DVSEC_OFF_STATUS:
> +	case DVSEC_OFF_STATUS2:
> +		/* RW1C =E2=80=94 clear bits where the guest wrote 1. */
> +		cur16 =3D dvsec_shadow_get_u16(p, off);
> +		dvsec_shadow_set_u16(p, off, cur16 & ~(u16)new);
> +		return;
> +	case DVSEC_OFF_LOCK:
> +		/* RWO =E2=80=94 first 1-write latches CONFIG_LOCK; subsequent
> +		 * writes are ignored.
> +		 */
> +		cur16 =3D dvsec_shadow_get_u16(p, off);
> +		if (cur16 & DVSEC_LOCK_CONFIG_LOCK)
> +			return;
> +		if (new & DVSEC_LOCK_CONFIG_LOCK) {
> +			dvsec_shadow_set_u16(p, off,
> +					     cur16 | DVSEC_LOCK_CONFIG_LOCK);
> +			p->dvsec_config_locked =3D true;
> +		}
> +		return;
> +	case DVSEC_OFF_RANGE1_SIZE_HI:
> +	case DVSEC_OFF_RANGE1_SIZE_LO:
> +	case DVSEC_OFF_RANGE1_BASE_HI:
> +	case DVSEC_OFF_RANGE1_BASE_LO:
> +		/* HwInit =E2=80=94 drop. */
> +		return;
> +	case DVSEC_OFF_RANGE2_SIZE_HI:
> +	case DVSEC_OFF_RANGE2_SIZE_LO:
> +	case DVSEC_OFF_RANGE2_BASE_HI:
> +	case DVSEC_OFF_RANGE2_BASE_LO:
> +		/* RsvdZ =E2=80=94 drop. */
> +		return;
> +	default:
> +		/* Reserved offsets inside the modelled body: drop. */
> +		(void)width;
> +		return;
> +	}
> +}
> +
> +/* Map a byte offset @off inside the DVSEC body to the natural-width
> + * field that contains it: returns the field's base offset (16-bit
> + * aligned for descriptors, 32-bit aligned for RANGE entries) and widt=
h.
> + * Returns false if @off lies outside any modelled field.
> + */
> +static bool dvsec_field_at(u16 off, u16 *field_off, size_t *width)
> +{
> +	if (off >=3D DVSEC_OFF_CAPABILITY && off < DVSEC_OFF_RANGE1_SIZE_HI) =
{
> +		*field_off =3D ALIGN_DOWN(off, 2);
> +		*width =3D 2;
> +		return true;
> +	}
> +	if (off >=3D DVSEC_OFF_RANGE1_SIZE_HI && off < DVSEC_BODY_END) {
> +		*field_off =3D ALIGN_DOWN(off, 4);
> +		*width =3D 4;
> +		return true;
> +	}
> +	return false;
> +}
> +
> +int cxl_passthrough_dvsec_rw(struct cxl_passthrough *p, u32 off, u32 *=
val,
> +			     size_t sz, bool write)
> +{
> +	u8 *shadow;
> +	u16 field_off;
> +	size_t field_width;
> +	u32 cur, merged;
> +	u32 sub_shift;
> +	u32 width_mask;
> +
> +	if (!p || !val)
> +		return -EINVAL;
> +	if (sz !=3D 1 && sz !=3D 2 && sz !=3D 4)
> +		return -EINVAL;
> +	if (off < PCI_DVSEC_CXL_CAP || off + sz > p->dvsec_size)
> +		return -EINVAL;
> +
> +	guard(mutex)(&p->lock);
> +
> +	shadow =3D p->dvsec_shadow + (off - PCI_DVSEC_CXL_CAP);
> +
> +	if (!write) {
> +		switch (sz) {
> +		case 1:
> +			*val =3D *shadow;
> +			break;
> +		case 2:
> +			*val =3D get_unaligned_le16(shadow);
> +			break;
> +		case 4:
> +			*val =3D get_unaligned_le32(shadow);
> +			break;
> +		}
> +		return 0;
> +	}
> +
> +	if (!dvsec_field_at(off, &field_off, &field_width))
> +		return 0;	/* outside any modelled field: drop */
> +
> +	/* Read-modify-merge the field at its natural width. */
> +	if (field_width =3D=3D 2)
> +		cur =3D dvsec_shadow_get_u16(p, field_off);
> +	else
> +		cur =3D get_unaligned_le32(p->dvsec_shadow +
> +					 (field_off - PCI_DVSEC_CXL_CAP));
> +
> +	width_mask =3D (sz =3D=3D 4) ? 0xffffffff : (sz =3D=3D 2 ? 0xffff : 0=
xff);
> +	sub_shift =3D (off - field_off) * 8;
> +	merged =3D cur & ~(width_mask << sub_shift);
> +	merged |=3D (*val & width_mask) << sub_shift;
> +
> +	dvsec_apply_write(p, field_off, field_width, merged);
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_passthrough_dvsec_rw, "CXL");

Hmm, no other "CXL" namespace consumer would ever care about this
mechanism.  The export goes away if this file moves drivers/vfio/. If
there is a good argument to stay in drivers/cxl/ then it should be
EXPORT_SYMBOL_FOR_MODULES.

> +
> +/* ------------------------------------------------------------------ =
*/
> +/* HDM write semantics                                                =
 */
> +/* ------------------------------------------------------------------ =
*/
> +
> +static u32 hdm_shadow_get(struct cxl_passthrough *p, u32 off)
> +{
> +	return get_unaligned_le32(p->hdm_shadow + off);
> +}
> +
> +static void hdm_shadow_set(struct cxl_passthrough *p, u32 off, u32 val=
)
> +{
> +	put_unaligned_le32(val, p->hdm_shadow + off);
> +}
> +
> +/* Decoder index for a per-decoder register offset. */
> +static u32 hdm_decoder_of(u32 off)
> +{
> +	return (off - HDM_DEC_BASE) / HDM_DEC_STRIDE;
> +}
> +
> +static u32 hdm_decoder_field(u32 off)
> +{
> +	return (off - HDM_DEC_BASE) % HDM_DEC_STRIDE;
> +}
> +
> +static void hdm_decoder_ctrl_write(struct cxl_passthrough *p, u32 off,=
 u32 val)
> +{
> +	u32 cur =3D hdm_shadow_get(p, off);
> +	u32 next;
> +
> +	/* Once COMMITTED, only the COMMIT toggle is honoured.  Releasing
> +	 * COMMIT clears COMMITTED and Lock-on-Commit per CXL r4.0
> +	 * =C2=A78.2.4.20.5.
> +	 */
> +	if (cur & HDM_CTRL_COMMITTED) {
> +		next =3D (cur & ~HDM_CTRL_COMMIT) | (val & HDM_CTRL_COMMIT);
> +		if (!(val & HDM_CTRL_COMMIT)) {
> +			next &=3D ~HDM_CTRL_COMMITTED;
> +			next &=3D ~HDM_CTRL_LOCK_ON_COMMIT;

No, when the decoder is locked its commit bit becomes read-only. Only
reset can clear lock-on-commit.


> +		}
> +		hdm_shadow_set(p, off, next);
> +		return;
> +	}
> +
> +	next =3D val & ~(HDM_CTRL_COMMITTED | HDM_CTRL_ERR_NOT_COMMITTED);
> +	if (val & HDM_CTRL_COMMIT)
> +		next |=3D HDM_CTRL_COMMITTED;
> +	hdm_shadow_set(p, off, next);
> +}
> +
> +static void hdm_decoder_basesize_write(struct cxl_passthrough *p, u32 =
off,
> +				       u32 val)
> +{
> +	u32 n =3D hdm_decoder_of(off);
> +	u32 ctrl =3D hdm_shadow_get(p, HDM_DEC_OFF_CTRL(n));
> +
> +	/* RWL =E2=80=94 BASE/SIZE locked when the decoder is committed or
> +	 * lock-on-commit has been latched.
> +	 */
> +	if (ctrl & (HDM_CTRL_COMMITTED | HDM_CTRL_LOCK_ON_COMMIT))
> +		return;
> +	hdm_shadow_set(p, off, val);
> +}
> +
> +int cxl_passthrough_hdm_rw(struct cxl_passthrough *p, u32 off, u32 *va=
l,
> +			   bool write)
> +{
> +	u32 field;
> +
> +	if (!p || !val)
> +		return -EINVAL;
> +	if (!IS_ALIGNED(off, 4) || off + 4 > p->hdm_reg_size)
> +		return -EINVAL;
> +
> +	guard(mutex)(&p->lock);
> +
> +	if (!write) {
> +		*val =3D hdm_shadow_get(p, off);
> +		return 0;
> +	}
> +
> +	switch (off) {
> +	case HDM_OFF_CAP_HEADER:
> +		/* HwInit =E2=80=94 drop. */
> +		return 0;
> +	case HDM_OFF_GLOBAL_CTRL:
> +		/* RW =E2=80=94 shadow. */
> +		hdm_shadow_set(p, off, *val);
> +		return 0;
> +	}
> +
> +	if (off < HDM_DEC_BASE)
> +		return 0;	/* gap before per-decoder regs: drop */
> +
> +	field =3D hdm_decoder_field(off);
> +	switch (field) {
> +	case 0x00: case 0x04:	/* BASE_LO / BASE_HI */
> +	case 0x08: case 0x0c:	/* SIZE_LO / SIZE_HI */
> +		hdm_decoder_basesize_write(p, off, *val);
> +		return 0;
> +	case 0x10:		/* CTRL */
> +		hdm_decoder_ctrl_write(p, off, *val);
> +		return 0;
> +	default:
> +		/* TARGET_LIST_{LO,HI} and other per-decoder bytes are
> +		 * accepted as plain RW shadow for the firmware-committed
> +		 * scope; multi-decoder / interleave behaviour is
> +		 * out-of-scope.
> +		 */
> +		hdm_shadow_set(p, off, *val);
> +		return 0;
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_passthrough_hdm_rw, "CXL");


> +
> +/* ------------------------------------------------------------------ =
*/
> +/* CM cap-array snapshot                                              =
 */
> +/* ------------------------------------------------------------------ =
*/
> +
> +int cxl_passthrough_cm_rw(struct cxl_passthrough *p, u32 off, u32 *val=
,
> +			  bool write)
> +{
> +	if (!p || !val)
> +		return -EINVAL;
> +	if (!IS_ALIGNED(off, 4) || off / 4 >=3D p->cm_snapshot_dwords)
> +		return -EINVAL;
> +
> +	if (write)
> +		return 0;	/* cap-array headers are RO; drop. */
> +
> +	*val =3D le32_to_cpu(p->cm_snapshot[off / 4]);
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_passthrough_cm_rw, "CXL");
> diff --git a/include/cxl/passthrough.h b/include/cxl/passthrough.h
> new file mode 100644
> index 000000000000..43214b0d34f6
> --- /dev/null
> +++ b/include/cxl/passthrough.h

This file becomes private to drivers/vfio if it moves.

Otherwise it needs s/passthrough/vfio/ as mentioned earlier.

> @@ -0,0 +1,121 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2026 NVIDIA Corporation. All rights reserved.
> + *
> + * CXL register virtualization helpers for vfio-pci Type-2 passthrough=
.
> + *
> + * See Documentation/driver-api/vfio-pci-cxl.rst for the ownership
> + * contract.  In short: cxl-core owns the per-device DVSEC body, HDM
> + * Decoder block, and CM cap-array shadows; vfio-pci is a transport
> + * that forwards guest reads and writes through the helpers below.
> + *
> + * The helpers are not a generic emulation framework.  Each register
> + * is hand-coded against CXL r4.0 =C2=A78.1.3 and =C2=A78.2.4.20.  Add=
ing a new
> + * field is "add a case", not "add a mode".
> + */
> +#ifndef __CXL_PASSTHROUGH_H__
> +#define __CXL_PASSTHROUGH_H__
> +
> +#include <linux/types.h>
> +
> +struct cxl_dev_state;
> +struct cxl_passthrough;
> +struct device;
> +
> +/**
> + * devm_cxl_passthrough_create - snapshot a Type-2 device's DVSEC + HD=
M +
> + * CM cap-array shadows and return the opaque handle the rw helpers
> + * operate on.
> + *
> + * @dev: device whose devres lifetime bounds the returned handle.
> + * @cxlds: CXL device state with cxlds->cxl_dvsec populated and
> + *	   cxlds->reg_map.resource and cxlds->reg_map.max_size describing
> + *	   the component register block.  cxlds->reg_map.base is NOT
> + *	   required; cxl_pci_setup_regs() releases its short-lived
> + *	   ioremap before returning, so this helper takes a local
> + *	   bind-time ioremap against cxlds->reg_map.resource for the
> + *	   duration of the snapshot.

More out of place cxl_pci_setup_regs() documentation...

> + *
> + * On success the returned handle is bound to @dev's devres so unwind
> + * happens automatically when @dev is unbound.  The handle must not be=

> + * freed by the caller.
> + *
> + * Return: a valid &struct cxl_passthrough on success, ERR_PTR(-errno)=

> + * on failure.
> + */
> +struct cxl_passthrough *
> +devm_cxl_passthrough_create(struct device *dev, struct cxl_dev_state *=
cxlds);
> +
> +/**
> + * cxl_passthrough_dvsec_rw - read or write the CXL Device DVSEC body =
shadow.
> + *
> + * @p: handle from devm_cxl_passthrough_create().
> + * @off: byte offset from the start of the DVSEC capability.  Must be
> + *	 >=3D PCI_DVSEC_CXL_CAP and (off + sz) must lie inside the DVSEC.
> + *	 Accesses to the PCI ext-cap header bytes (off < PCI_DVSEC_CXL_CAP)=

> + *	 are the caller's responsibility; they belong on the generic
> + *	 perm-bits path, not here.
> + * @val: pointer to a u32 holding the read result or the write value.
> + *	 The low @sz bytes of *val are the payload; upper bytes ignored
> + *	 for writes and zero for reads.
> + * @sz: 1, 2, or 4.  Other values return -EINVAL.
> + * @write: false for read, true for write.
> + *
> + * Reads serve from the shadow.  Writes update the shadow per the spec=

> + * attribute mode for the addressed field (LOCK is RWO, CONTROL/CONTRO=
L2
> + * are RWL gated on CONFIG_LOCK, STATUS/STATUS2 are RW1C, RANGE1/2 are=

> + * HwInit, Reserved/RsvdZ silently consumed).
> + *
> + * Known limitation: a 4-byte write whose @off straddles a 16-bit DVSE=
C
> + * field boundary (CONTROL/STATUS at 0x0c/0x0e, CONTROL2/STATUS2 at
> + * 0x10/0x12) applies only the field containing the first byte of the
> + * access; the adjacent 16-bit field is not updated by the same write.=

> + * Standard CXL register-access patterns issue separate 2-byte accesse=
s
> + * to CONTROL, STATUS, CONTROL2 and STATUS2, so this corner case is
> + * documented rather than handled.
> + *
> + * Return: 0 on success; -EINVAL on out-of-range or bad size.
> + */
> +int cxl_passthrough_dvsec_rw(struct cxl_passthrough *p, u32 off, u32 *=
val,
> +			     size_t sz, bool write);
> +
> +/**
> + * cxl_passthrough_hdm_rw - read or write the HDM Decoder block shadow=
.
> + *
> + * @p: handle from devm_cxl_passthrough_create().
> + * @off: byte offset from the HDM block base; must be 4-byte aligned a=
nd
> + *	 (off + 4) <=3D hdm_reg_size.  Sub-dword access is not supported on=

> + *	 HDM registers per CXL r4.0 =C2=A78.2.4.
> + * @val: pointer to a u32 holding the read result or the write value.
> + * @write: false for read, true for write.
> + *
> + * Reads serve from the shadow.  Writes implement the per-decoder
> + * COMMIT/COMMITTED handshake (CTRL) and the RWL gating on BASE/SIZE
> + * imposed by COMMITTED|LOCK_ON_COMMIT.  GLOBAL_CTRL is RW; the cap
> + * header is HwInit (writes dropped); other offsets in the per-decoder=

> + * stride are RW shadow.
> + *
> + * Return: 0 on success; -EINVAL on misalignment or out-of-range.
> + */
> +int cxl_passthrough_hdm_rw(struct cxl_passthrough *p, u32 off, u32 *va=
l,
> +			   bool write);
> +
> +/**
> + * cxl_passthrough_cm_rw - read or write the CXL.cache/mem cap-array s=
napshot.
> + *
> + * @p: handle from devm_cxl_passthrough_create().
> + * @off: byte offset from CXL_CM_OFFSET (the start of the CM cap-array=

> + *	 header in the component register block); must be 4-byte aligned
> + *	 and (off + 4) <=3D cm_snapshot_size.
> + * @val: pointer to a u32 holding the read result; ignored on write.
> + * @write: false for read.  Writes to the cap-array are silently dropp=
ed
> + *	   (the array headers are RO per CXL r4.0 =C2=A78.2.4); the @write
> + *	   parameter is present only to keep the API symmetric with the
> + *	   other rw helpers and to make the drop policy explicit at the
> + *	   call site.
> + *
> + * Return: 0 on success; -EINVAL on misalignment or out-of-range.
> + */
> +int cxl_passthrough_cm_rw(struct cxl_passthrough *p, u32 off, u32 *val=
,
> +			  bool write);
> +
> +#endif /* __CXL_PASSTHROUGH_H__ */
> -- =

> 2.25.1


