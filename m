Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE9A3382F4;
	Mon, 13 Jul 2026 21:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783977265; cv=none; b=Puk5RXe5PwXP3zYae8B2XYWsz4ookJwrXC3tvIGotVePZP+DvCopN9GZZgu9mHN43cGjVsrxdaL/3ASjxcqUCRE1LIMe8ZOuNlEpfdIlkcrU7jL3S5fouxdu/I0M6VB53/GhHPPhnlEb9yMzaZGqcbBUBtTdw3nfkjobUuXR/Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783977265; c=relaxed/simple;
	bh=hFLJTEOtnPP+/owFXOrP6LuYyD2e+GGiXgitKVu3Klk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NxDNCrlzg9okSEeQzwcmWyagBBLxlgm+V0QMthPD1clG/U6RG2cWtQiw5/mTfmSYF8SoWJ/xsLnwIZdJzdoQL3ZS2qXQhTRdmY22DXaPqh0RqS+yISihXEeHl2ith4nu+/Qf2wsID/ridYWJOmTh2ykiclTqytDiV9wq94Zzjlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRLvYS10; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRLvYS10"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4631F00A3D;
	Mon, 13 Jul 2026 21:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783977264;
	bh=sMBui836HM41KY8s3+Mm8qIHFtVsg0cuQwuzcHoGBGw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=bRLvYS10AMK0kvxXR59RYA9FSFouJAeQczmz5wHotdAOb74uqEkRikcm5pf+pfEJc
	 N32c0SXNup4oYQS36yo4Lw2rFyX7svFRyU9E/Z9DxaF7RZM3kPz7f+Iz44z00wbLy6
	 xBQBrI3T6p91Oy/j2zaSSSRBnQcJjp7E8AWp/IbyE500OfGUjHVLTp+ssakvW2mteY
	 ga6dVNMXSJZ0hqpksKKkmmENN+wIwLcD8UTyBq9M1S9dbyaq9/wUxWJn6M9Ile2HMg
	 vN+C6lw/1x6vhf/Hb5XZU41u12CrKTyykSOwdGOq4ujQmoj+zaj9xKc1RPJFsgnjiQ
	 QsjgcIMVf9ojw==
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5B70AF40119;
	Mon, 13 Jul 2026 17:14:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 13 Jul 2026 17:14:22 -0400
X-ME-Sender: <xms:LlVVanX9epxdm6vE5XaKiNEEQE8RKCum1fePyhsn_ISXeIHTZMgGLA>
    <xme:LlVVakf8QUACxIZ9ofCaRIvRzAE4f99-TaNSXzQNE0oDatgLYxvQ0VHz8z2sV9Keo
    8I9j3WcFVjgh5iN3qEW2-JAYdbEL6AIGLOdyPxy52uN1QLDYg4Uic0>
X-ME-Received: <xmr:LlVVag9FYCB5M6mjXULxej9uYDxuBEEl0WiGrWL_gmBJywMTsys5S7PVjWTfqxRETzZixnlc2zD6mbBT22skSFfdSTlgccsSgNI>
X-ME-Proxy-Cause: dmFkZTFNij3gMh+X8Z9njSKkNHcXU0qZMJw/Gf1R/d3jzfKrxojwVNTxUV2e6GTfe7KByY
    JijsFbEuiYnrxI0HagcW2l/RzWe8ge82nq9KT9GRAr3TDEmmqpMjDJNV6fEhBUsPJqJH9x
    hioaW0XiA1PEFvoChOb0xHMAzsHUG1vslBm3qHrmUPMNxNGj55Br7P9rco5to57Ki8PYVN
    iaTcBCQdQJxD3DftDB7VTuGVCIhM4yJL589c5sJhmWqP6VwwEpGINQtJvK06TFKk4fxN3y
    88sk4YXX+DCCNUwIBOJwgt0dhTvbEWUISQho5kTNm5pVfdqWp1kocfsy1dWzX6GWcdQpf9
    CVIycnV+YUFYiz34PXnhpZIOdzVSp7ca6F79kcbcLAJ6aea/zrPCAYyrzCbzMpGonQlCPQ
    0WeEg2t+0qdX1lNeRjo9wAP/8IN1It6m5yY3lnpHY6NPa23cbE62uvKyGgU3l0+V39NNmc
    8vYtkF5xdjOHYiED9NDvKTuJz1PRt8qIkJTFaROCBEwZCNxnr+5vUDKNc0y6nQjDIOZSwm
    tAlrfS6+bUTtfnG8w9M9b1LRhQ3765pbUSEa6RTn+O0HBoIoSy0nUX7c0FokUGtNLPvTHI
    gd62w4vF1ESfrI5ZbZHGgDvtwUIsaVr8tNPRvGBMcUbO/V2FnrmuI4imfsPw
X-ME-Proxy: <xmx:LlVVakaxf__zGGvNap-G0VcZCHvGKTgpIknaKFPsN4SFO-CGy9GLfQ>
    <xmx:LlVVagu4cz_fcZD7XFiW6WYtUDZIBVm6ZqVefKqvPUnAg9cGtZPg0w>
    <xmx:LlVVahaG7f00MGJ4UGx3l9TQuFmS4wnLstbuR9VYMjrCkyMz2a_jiQ>
    <xmx:LlVVakQbn33zqUbj-xtZv-5_1D6XSTeM6RfoQyscg_JzCJfnuqjnvQ>
    <xmx:LlVVaszEyftclIAwPMVRESgjM2bmZBdJHybVxBjcC0cMjCJsDUO-tBMv>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 17:14:21 -0400 (EDT)
Date: Mon, 13 Jul 2026 14:14:20 -0700
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
Message-ID: <6a55552c98a82_35cf3310082@djbw-dev.notmuch>
In-Reply-To: <IA1PR12MB9030E175587B09CEA7A4D90FBDFA2@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260625165407.1769572-1-mhonap@nvidia.com>
 <20260625165407.1769572-6-mhonap@nvidia.com>
 <20260710162322.012be635@shazbot.org>
 <IA1PR12MB9030E175587B09CEA7A4D90FBDFA2@IA1PR12MB9030.namprd12.prod.outlook.com>
Subject: RE: [PATCH v3 05/11] vfio: UAPI for CXL Type-2 device passthrough
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Manish Honap wrote:
> > -----Original Message-----
> > From: Alex Williamson <alex@shazbot.org>
> > Sent: 11 July 2026 03:53
> > To: Manish Honap <mhonap@nvidia.com>
> > Cc: djbw@kernel.org; jgg@ziepe.ca; jic23@kernel.org;
> > dave.jiang@intel.com; Ankit Agrawal <ankita@nvidia.com>;
> > alejandro.lucero-palau@amd.com; alison.schofield@intel.com;
> > dave@stgolabs.net; dmatlack@google.com; gourry@gourry.net;
> > ira.weiny@intel.com; Neo Jia <cjia@nvidia.com>; Krishnakant Jaju
> > <kjaju@nvidia.com>; Vikram Sethi <vsethi@nvidia.com>; Zhi Wang
> > <zhiw@nvidia.com>; kvm@vger.kernel.org; linux-cxl@vger.kernel.org;
> > linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > kselftest@vger.kernel.org; alex@shazbot.org
> > Subject: Re: [PATCH v3 05/11] vfio: UAPI for CXL Type-2 device
> > passthrough
> > 
[..]
> > 
> > On Thu, 25 Jun 2026 22:24:01 +0530
> > <mhonap@nvidia.com> wrote:
> > > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > > index 5de618a3a5ee..3707d53c4de5 100644
> > > --- a/include/uapi/linux/vfio.h
> > > +++ b/include/uapi/linux/vfio.h
> > > @@ -215,6 +215,7 @@ struct vfio_device_info {
> > >  #define VFIO_DEVICE_FLAGS_FSL_MC (1 << 6)    /* vfio-fsl-mc device */
> > >  #define VFIO_DEVICE_FLAGS_CAPS       (1 << 7)        /* Info supports
> > caps */
> > >  #define VFIO_DEVICE_FLAGS_CDX        (1 << 8)        /* vfio-cdx
> > device */
> > > +#define VFIO_DEVICE_FLAGS_CXL        (1 << 9)        /* vfio-cxl
> > Type-2 device */
> > 
> > Would we define a different flag for type-1/3 if we ever found a need to
> > expose them through vfio?
> 
> Yes. The current flag is named VFIO_DEVICE_FLAGS_CXL and refers to
> Type-2 specifically. If Type-1 or Type-3 support is added later, a
> separate flag (or a VFIO_DEVICE_INFO_CAP sub-type field) would
> distinguish them. I can rename it VFIO_DEVICE_FLAGS_CXL_TYPE2 now if
> that is preferable; please advise.

The CXL specification itself has deprecated the "Type" names because
they are ambiguous. For example, you can have a "Type-3" device that
supports "device memory (HDM-DB)", Type-2 is a superset of Type-1 in
many cases, etc.

This flag will never be able to capture a coherent / standard set of
device capabilities. It can really only be a plain "CXL" flag with
an implementation that is ready for the superset of capabilities:
CXL.cache, HDM-H (host-only memory expansion), HDM-D (legacy device
memory), HDM-DB (device memory via device cache management
back-invalidate).

I think the HDM-{H,D,DB} difference are not relevant to VFIO, it is all
just CXL HDM.

The capabilities that may need a different VFIO implementation model are
interleaved devices and maybe dynamic capacity devices, but that is not
a type designation.

[..]
> > Does that leave this device level capability describing the device as
> > type-2 (by existence), with only a flags field to declare HDM as
> > firmware committed, for future compatibility should we support non-fw
> > committed?  Thanks,
> > 
> > Alex
> 
> Yes, I will shape the v4 in this direction. The device-level CAP_CXL
> shrinks to "this is a CXL device" (by existence) plus a flags field whose
> only defined bit today is HOST_FIRMWARE_COMMITTED, leaving
> room for a future non-fw-committed mode. Everything else moves to region
> caps. Thanks for this suggestion.

How can VFIO discern if the HDM is host firwmare committed? If
devm_cxl_probe_mem() grows to auto-activate unmapped capacity rather
than finds firmware committed decoders, can VFIO even tell the
difference?
