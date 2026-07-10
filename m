Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE8C4343F7;
	Fri, 10 Jul 2026 22:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783722223; cv=none; b=Btg5eOAr3PqsQQrIxPIgVNEQkP4fs0c4ca3ea3UdlWCwOM2jQIvZ88qFSqVDKdE6UE++Kp3qYOuG2lOnNxb7PlBVlrA8f65Ejo4MPoJoQzfjnjsEsfzhX5n2clMWM2EEYDRtXrcj9hkwLhM2wE9HkXq0lrgVIFyDcVrvPeS4ekg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783722223; c=relaxed/simple;
	bh=PLz6/Jj/jgz/O4Ur+Z8G2Q+f6i1hu4B5PAOfVPbrFIs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnvy5YAMbbpZ7u8+d+Pb+EuxS37z1Ub+3tYWiL8l5IebSm8V1Az/FDEwP86pp3IzNl5i3XopWr4w5oIPBWjjGvghm/wJCfp9SI8g9Sma9S807vFnltEGSA6Ul8TyOu3tU45rAXNkP2WOQOlmWUA5DZvxCnt/6ipvVG+uDyh1Cx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=I/1dPPYG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NRAKZoQ7; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="I/1dPPYG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NRAKZoQ7"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1730914000FA;
	Fri, 10 Jul 2026 18:23:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 10 Jul 2026 18:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783722216;
	 x=1783808616; bh=wUuG2lDCstVuRMaTCE5N6+6AhROHyvgUduvjttpjJzA=; b=
	I/1dPPYGqh6ce0q5dugLlURqq4W8Hl27mum4ntQEY35HGBz1SqjIcW82+ZyJcmY6
	4gJYLpNBmG7TZYLazM7jJZVWG/nuWAWFJQ1eeIBFTYP92ynxxZG9Wg3KT9JqAIk7
	faKh0ZZcicY6bfK84Vhf8yVvnJZiP95f5mlLVp1uBcd+n6GYzAxBXeXtAtZdjgcs
	KdTf3HfIQxt4BECrd1DNinuMFu3ZtwQSsnycxXTyt5cE1V30PsvbQhHi/qRFSA+c
	yZpEoqTObQo07rl2xc4E3LI1XP300QVM978QaEYjM1cAUoc6/mcD5T1ySyLM5Jbv
	PRw7xgq0btQel9fCm4vyyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783722216; x=
	1783808616; bh=wUuG2lDCstVuRMaTCE5N6+6AhROHyvgUduvjttpjJzA=; b=N
	RAKZoQ7s4JiQ8w1kJAgUz2tEeXwx/JNz2stgTNx9CX3A68oMlW20Xo1TYZWSv5Pb
	yLVBj01FdWex7bA5aknivT9WW+hrmsdhFev7sYtRYtnPIjXZXuz5nDiM8PTTSX34
	gV+2BCaqN5pqZqwxNbj0tCn8rVw3oAzfdM9cRP5CQ1+hyJ1O5BlNKRWawCeKWbNO
	aocMGi+rMH5gsbjVPNVUymtbOjTBxG2WkfEOl7CDVtruoXMyPR5g276xmyh2P/B1
	qUj+vB9VnzwxMvCOiV8Qjg1+uUV6pp5d5tPX9bUHCPKr+F2gopPT88QqJDcuTh+u
	cgaDNH/PoU3RWwNcGM0lw==
X-ME-Sender: <xms:53BRaljP_kBaNJNmwQKd3vnS55TnmbO9mk2YJ8W4KHqbatOiH-eibQ>
    <xme:53BRanOvHyYNwzWnhH6DES74UDAXqxvExYaLB2l1tFwm6IjYZ05ry3KL8zlHRgV2N
    l3-YDACJW_3uPj-vUsZlBVGI8Q2dblitQOb1tGUWSaCUrYFRYTNow>
X-ME-Received: <xmr:53BRapl-2iKjyKu9u-Pv7ZwTvoTR-AneGwQ207rBfwFsuBHpZYHTO_Z6V7E>
X-ME-Proxy-Cause: dmFkZTGx+9uZUNtMzRtQiKCbA/b6PtqZ/X9uRh5e8XP9efc/+m30rms4tUuiY8fuXNVXKu
    7M3W+ROb9+E+H5XeLxWLiOCDR4/EUqwkIVFYEaK0GoJ6IJGSFIoORQt5p8tiD7P1Os0W/5
    /ZJyNdpAfITO5/710uYKhpN0VdfoIUfGZSkKcTCXxulh7+BcGL3l5JO291bxdkaVC4uJUx
    +UGX6EQNgR+m0w3DX1wa53Qbo4sbiF8G69C93Rild0v9kS9ssEFHLXpsdJYxKPaib2BTlP
    2VwB6xFSTts8zRTVW+f/R/p8Z1TjftqcCvr5biZlhagvnS75aCJQmqLVSh+Abdgfj/NdPb
    tPzydtWDVJMpw3Pk6ZvIpQQxI8q8TdOhvJ8TfMUI+vIjexjNlm0d2UjI6SiYACzIGGdQho
    x5KOdSOgtEKscujj0Ka/q4G7l2m6KZF1JVCroRPqD2/9J4KrCPGZpgGOUH8weMQM0Zl9wy
    fraNbMwsQQKqYOSYbilVQ//TBNeIq4Z+QCzQTmGSa6C/Yh1RTe5ffYEZqaNwcQXJRuNW3Q
    qMOe3ltzgf+UamtTg1SVnYmzJCwDrN/0E536x8bbscZa0F62sQ0wO129G3Izncz4zeibOg
    8GPuOPUm0Qi9nnbYlkFrGRvm6Bi1Y3NLUPY8/jolK6/yaoEfqIi3qpOIMFlQ
X-ME-Proxy: <xmx:53BRamdkmp1rkBgqkeid1IejLIm8iyOl6Liwh_FxH52UV6-s-P9nKA>
    <xmx:53BRajsvpxg-suEDOl4eD3VR6snApGNC_MXgxQWUme8OL4bnN7lY1g>
    <xmx:53BRagDFEy7TO00DHeu6r8p2jwzqIuiZNU-A0rSmUBB4vBQOwBNrzg>
    <xmx:53BRamx9Y8sBK43NE-vAFljJKn18ue8r6ibSVUNtJIrVkK5MNjHTsg>
    <xmx:6HBRaqxCKqOe0X7LOlNcJ0zGAV7jai6ZHlWCZajcR-mgdNK-63SGy2h_>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 18:23:34 -0400 (EDT)
Date: Fri, 10 Jul 2026 16:23:16 -0600
From: Alex Williamson <alex@shazbot.org>
To: <mhonap@nvidia.com>
Cc: <djbw@kernel.org>, <jgg@ziepe.ca>, <jic23@kernel.org>,
 <dave.jiang@intel.com>, <ankita@nvidia.com>,
 <alejandro.lucero-palau@amd.com>, <alison.schofield@intel.com>,
 <dave@stgolabs.net>, <dmatlack@google.com>, <gourry@gourry.net>,
 <ira.weiny@intel.com>, <cjia@nvidia.com>, <kjaju@nvidia.com>,
 <vsethi@nvidia.com>, <zhiw@nvidia.com>, <kvm@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v3 07/11] vfio/pci: Add CONFIG_VFIO_PCI_CXL with
 bind-time CXL Type-2 acquisition
Message-ID: <20260710162316.29cf8107@shazbot.org>
In-Reply-To: <20260625165407.1769572-8-mhonap@nvidia.com>
References: <20260625165407.1769572-1-mhonap@nvidia.com>
	<20260625165407.1769572-8-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Jun 2026 22:24:03 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
>=20
> Wire vfio-pci-core to acquire CXL Type-2 device state at PCI bind
> and release it at PCI unbind, mirroring the existing vfio_pci_zdev_*
> integration model.

I don't follow, zpci has the following matching hooks:

 - vfio_pci_zdev_open_device
 - vfio_pci_zdev_close_device

Plus it also has:

 - vfio_pci_info_zdev_add_caps

What about those suggest "zdev state" is acquired at bind and released
on unbind?

>  Four lifecycle hooks are introduced =E2=80=94
> vfio_pci_cxl_acquire / _release / _open / _close =E2=80=94 with !-config
> stubs that return -ENODEV / 0 / 0 / no-op respectively so vfio-pci
> behaviour is unchanged when CONFIG_VFIO_PCI_CXL=3Dn.
>=20
> vfio_pci_cxl_acquire() implements the bind sequence:
>=20
>   - pcie_is_cxl() and CXL Device DVSEC discovery (-ENODEV if absent
>     or if MEM_CAPABLE clear =E2=80=94 caller falls back to plain vfio-pci)
>   - devm_cxl_dev_state_create() with struct vfio_pci_cxl_state
>     embedding cxl_dev_state at offset 0 (required by the 7-arg
>     macro's static_assert in include/cxl/cxl.h)
>   - pci_enable_device_mem(), cxl_pci_setup_regs(), cxl_get_hdm_info()
>     (rejecting hdm_count !=3D 1), cxl_regblock_get_bar_info(),
>     cxl_await_range_active()

The cover letter claims otherwise:

  "- cxl_await_range_active stays in cxl-core probe; not exported, vfio
  does not call it."

It's exported in 2/ and called below.

>   - devm_cxl_passthrough_create() to snapshot the DVSEC body, HDM
>     block, and CM cap-array shadows owned by cxl-core
>   - pci_disable_device() =E2=80=94 clears PCI_COMMAND_MASTER but NOT
>     PCI_COMMAND_MEMORY, so cxl-core MMIO accesses from the next step
>     still succeed
>   - devm_cxl_probe_mem() to register the cxl_memdev, enumerate the
>     endpoint port, and attach the firmware-committed autoregion
>   - request_mem_region() + memremap_wb() of the autoregion's HPA so
>     the HDM VFIO region can serve guest accesses through it

How does this interact with:

 - The device making use of low power states while idle
 - Repeatability per tenant instance
 - Protection of tenant data per instance

The culmination of all of these, plus the basic housekeeping of
maintaining the lightest touch on the device, including keeping the
device in the minimum state of functionality outside of an actual user,
is why I would expect to perform acquire/release as part of open/close.

Could a low power transition invalidate the state established by
acquire, leading to the issue Richard encountered?

Also, on the direct calls to cxl functions, I thought one of our goals
was to avoid vfio-pci statically pulling in CXL module dependencies.
To achieve that, it seems like at some point we need to detect that we
have a CXL device (pcie_is_cxl(pdev)), do a request_module() to load
vfio-cxl, where the init function would register callback ops with
vfio-pci-core and each dependent device would acquire a reference to
the vfio-cxl module.

> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 89165b769e5c..541c1911e090 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -142,6 +142,13 @@ struct vfio_pci_core_device {
>  	struct notifier_block	nb;
>  	struct rw_semaphore	memory_lock;
>  	struct list_head	dmabufs;
> +	/*
> +	 * Opaque pointer to struct vfio_pci_cxl_state (defined in
> +	 * drivers/vfio/pci/cxl/vfio_cxl_priv.h).  Set by
> +	 * vfio_pci_cxl_acquire() at PCI bind; NULL on non-CXL devices
> +	 * and when CONFIG_VFIO_PCI_CXL=3Dn.
> +	 */
> +	void			*cxl;

Use a forward declaration rather than void, that avoids half your
comment.  The remainder of the comment is just explaining the obvious
parts of the code, unnecessary.  Thanks,

Alex
