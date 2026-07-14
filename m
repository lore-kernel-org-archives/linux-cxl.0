Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59841233937;
	Tue, 14 Jul 2026 04:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784003527; cv=none; b=H30fVb0lU9J0q3swSakWqq/48mkvcQvTOYu6sXs6wNA4Q1+kKZ9oZo4++GAXBnsihzUoeJFkJ0H1qmgzsm45pd9HvMGSw2yiI1BsAAZ1S420SGecu+6fbWDdiioMxMJ10CVBu6vuXp0WYRPLd2gpZwzmhxJJmTVUrQeYZw9xEMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784003527; c=relaxed/simple;
	bh=XM7VGBlv67NNumr+kynwEza1GVf1p/tMWmPt/JIhuv8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=p0ro9gcsHzPx6CUDdM+UliNoFP3oEVmcmN1oH31YGOwrNfQjFtDF54SSx9OMSJGYPHyiUyVNT1lxAEU0dBn2tzV318rYAg7ts1kRaQzKgy0px1o2eCzuGOkHtHkrpZ55a2QPMZi2AULSQedve+k9x73WO2My/ZWGxlRWTyozFAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYsFHduW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYsFHduW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4D61F00A3A;
	Tue, 14 Jul 2026 04:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784003526;
	bh=ICf9OHjwxFwehYXqEt5J3kn7A2kZgUciQx2f6MzCt2Y=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=cYsFHduWOEX/90cDUwmi0F84QmFNIfZ3UOkSD15Mm6AFMrgog/Z3+LhFLFXaQAF6w
	 MaIIiyoItCwgVQvrjwXYScVJkOZ9COVI0lMoPtIxy7gZt6l7vOqf84FObbfPBTPW9q
	 ykCjbvzwlf6xSxpshlJmNFLfJU9kM6hEl/zQWGyl+/zu1Nlm/hYaFnO27guyzVYIme
	 E9opmFJAhSYVTai4+TK2/6UgiDvmpkZrJKuWqvBO70tRnsAeHSMYvW+GMvvpe3uNeo
	 hexyC3uVOJDkaGDrod7y5bLFGU/aM73lRPPSIoO0cxExUIUlhZXHO7oYY6zhOfuTyf
	 tkJU8/4zTbNGA==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4EC2FF40078;
	Tue, 14 Jul 2026 00:32:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 14 Jul 2026 00:32:04 -0400
X-ME-Sender: <xms:xLtVarN6dk6rsOmCkO-hvq2gJutn2hmcYU2JOjSRSc0fi3AkkOV9ew>
    <xme:xLtVaq0DBDSAFo0Y760y9W7A4ziv7FNxyEMR1Ly7CC_JlHyw73eHHkuE0DMVm_n1x
    TeMCHOKzqdfWkwAV63jdG_QgaxiUJh7wsgWcIRfzFK2y-GaAZyxJIs>
X-ME-Received: <xmr:xLtVan0Pq4IxK_mW93Uam745vAuJ2f_c89w59gk_tIIS9-eAVoiO639-v9Vb-YCv3RR1fhYhXw46W-rY0bI5hNWZAb4sImHT9ao>
X-ME-Proxy-Cause: dmFkZTETAL60usH4lwlQ+4JamyiGMB40vHl7RgBXxsRW+Q/t46XOvYKxjtcqB7DgAdPC6i
    zMIujK7PY4sEwXxazD+cu/TeVDF4gGUKmmd54dtA25ch6rGoXJwCupkApom8abyimHWxjk
    DLdaPpsTwRaHCE++9rktMWDjVDFmr6CU0Jm7oQH94vJ7v+mplgl45VZFu0bVcmqSldtmyP
    TsPb5ggmXk5spRxfJAiNTZnPUydufMtrYp4tqcSf/n46+m3l7r38cEHazhwn6Qp7DP25OL
    +7gmDJ3RA06dy6rPvT8Slk3sgoDnnQ42j+hY5zYQVGCGqQspCGSx7XiOjPEtOtzmpVcxbM
    sxpp+PgECi1Nk6EOwSE5+G77XfTW+06KOFWMcYwxpsclj/vLEOOGfHjhEgQtQFRjAsmBq1
    nz0rZySu2yEuP/cuXXREFPtFMgH07FMuR3pMx57MagjZ4O+loKKKSoNHSPcieSeJ5/HZ6S
    hL7IRiKeWLeEuHKkbK7NktIMhi89NtiFQZw9e7Nt9G4HsFIJW3kpfnAgqzFOnHxsva95hS
    ssbW7ZxM53LmT9XKcEr50YysPX0vTrRoxmSGzMq16mukrhzOEBRx6jRmrY5j3iYbbvaFZe
    V0B3jQYtoJ58Zt7Wqu5UJn8rTsTND9kyp3b7TO/B8nNfcJPnZi0TK1Mem4bA
X-ME-Proxy: <xmx:xLtVahy2ngywLag-bMOt0yjyZRXwzIkHthZsohlCWRjaN92gSyj23A>
    <xmx:xLtVaikLSb0O6jdVHHApcpNpF9jpnWGMImdDuINYgaQtAWqL5qE1cA>
    <xmx:xLtVatzdFt6uVf1Kd6-ggDleOTtMVSJ_r4dg92V5tJ2S53s2ryETsg>
    <xmx:xLtVapJenbLv68dmWS4szRfchpH2gaL2c3Rl2STOKCitqmiivYnw2w>
    <xmx:xLtVagKBbKwjiBvK_qMG6wu9fLclvcCKO5KvhGBOnRpLAcnWoYdg7qjy>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 00:32:03 -0400 (EDT)
Date: Mon, 13 Jul 2026 21:32:02 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Manish Honap <mhonap@nvidia.com>, 
 Alex Williamson <alex@shazbot.org>
Cc: "djbw@kernel.org" <djbw@kernel.org>, 
 "jgg@ziepe.ca" <jgg@ziepe.ca>, 
 "jic23@kernel.org" <jic23@kernel.org>, 
 "dave.jiang@intel.com" <dave.jiang@intel.com>, 
 Ankit Agrawal <ankita@nvidia.com>, 
 "alejandro.lucero-palau@amd.com" <alejandro.lucero-palau@amd.com>, 
 "alison.schofield@intel.com" <alison.schofield@intel.com>, 
 "dave@stgolabs.net" <dave@stgolabs.net>, 
 "dmatlack@google.com" <dmatlack@google.com>, 
 "gourry@gourry.net" <gourry@gourry.net>, 
 "ira.weiny@intel.com" <ira.weiny@intel.com>, 
 Neo Jia <cjia@nvidia.com>, 
 Krishnakant Jaju <kjaju@nvidia.com>, 
 Vikram Sethi <vsethi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, 
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
 Manish Honap <mhonap@nvidia.com>
Message-ID: <6a55bbc276b96_f7ebd100e4@djbw-dev.notmuch>
In-Reply-To: <IA1PR12MB90309355D97FE886A1DA77BABDFA2@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260625165407.1769572-1-mhonap@nvidia.com>
 <20260625165407.1769572-8-mhonap@nvidia.com>
 <20260710162316.29cf8107@shazbot.org>
 <IA1PR12MB90309355D97FE886A1DA77BABDFA2@IA1PR12MB9030.namprd12.prod.outlook.com>
Subject: RE: [PATCH v3 07/11] vfio/pci: Add CONFIG_VFIO_PCI_CXL with bind-time
 CXL Type-2 acquisition
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Manish Honap wrote:
[..]
> > > vfio_pci_cxl_acquire() implements the bind sequence:
> > >
> > >   - pcie_is_cxl() and CXL Device DVSEC discovery (-ENODEV if absent=

> > >     or if MEM_CAPABLE clear =E2=80=94 caller falls back to plain vf=
io-pci)
> > >   - devm_cxl_dev_state_create() with struct vfio_pci_cxl_state
> > >     embedding cxl_dev_state at offset 0 (required by the 7-arg
> > >     macro's static_assert in include/cxl/cxl.h)
> > >   - pci_enable_device_mem(), cxl_pci_setup_regs(), cxl_get_hdm_info=
()
> > >     (rejecting hdm_count !=3D 1), cxl_regblock_get_bar_info(),
> > >     cxl_await_range_active()
> > =

> > The cover letter claims otherwise:
> > =

> >   "- cxl_await_range_active stays in cxl-core probe; not exported, vf=
io
> >   does not call it."
> > =

> > It's exported in 2/ and called below.

This feels like a gap on the CXL side. devm_cxl_probe_mem() should take
care to only succeed after memory is active, or fail with a timeout.

Recall that the current cxl_await_range_active() export is for the
"internal" cxl_pci driver. Now that there are external consumers
devm_cxl_probe_mem() should return a fully validated and awaited memory
range. Do not make every driver remember this part of the setup flow.

> > >   - devm_cxl_passthrough_create() to snapshot the DVSEC body, HDM
> > >     block, and CM cap-array shadows owned by cxl-core
> > >   - pci_disable_device() =E2=80=94 clears PCI_COMMAND_MASTER but NO=
T
> > >     PCI_COMMAND_MEMORY, so cxl-core MMIO accesses from the next ste=
p
> > >     still succeed
> > >   - devm_cxl_probe_mem() to register the cxl_memdev, enumerate the
> > >     endpoint port, and attach the firmware-committed autoregion
> > >   - request_mem_region() + memremap_wb() of the autoregion's HPA so=

> > >     the HDM VFIO region can serve guest accesses through it
> > =

> > How does this interact with:
> > =

> >  - The device making use of low power states while idle
> >  - Repeatability per tenant instance
> >  - Protection of tenant data per instance
> > =

> > The culmination of all of these, plus the basic housekeeping of
> > maintaining the lightest touch on the device, including keeping the
> > device in the minimum state of functionality outside of an actual use=
r,
> > is why I would expect to perform acquire/release as part of open/clos=
e.
> =

> The cover letter description is wrong. During my earlier thought proces=
s,
> creating a region during probe seemed a correct option as any later req=
uirement
> where region needs to be already created at probe emerged, we will have=
 easier
> way to handle it. I will give some more thought to update v4 to acquire=

> CXL state in open_device() and release it in close_device(), matching z=
pci.

This is going to run up against a current design wart of
devm_cxl_probe_mem() that does not have a teardown flow implemented
outside of the typical ->remove() to devres_release_all() flow. Even if
that was fixed I do not see it affecting the listed concerns.
devm_cxl_probe_mem() for firmware committed decoders is mostly just
reading resource values.

For power state management the power management that vfio-pci performs
only informs the CXL.io portion of device power. CXL.cache and CXL.mem
are dynamically managed by the device.

For repeatability I do think discarding and reinitializing the shadow
configuration makes sense, but the base HDM configuration does not
require teardown.

For tenant data protection that arises from the data retention after
reset policy, not impacted by unloading the HDM configuration.

I assume VFIO likely would want to build a capability to zero HDM memory
if the device leaves the state ambiguous / implementation defined?

That is a good note for the CXL Reset series as well. If VFIO issued
resets are for tenant handoff the make sure that CXL Reset requests
memory clearing.
