Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795025091;
	b=FqR/2OCbEorEGDcLPqGVEe6F9ZBZKUG5B/hZPnVTxz9/fMlQ57S7gzn/8yAIHq1vSEN0
	 P1ZeNTcGk1p8gPuUfqtad0qJ/uIxn2xoDzM5i2OSjiaPCDPFhMCOiAcw/PzImHDlnZoFW
	 iREXFVX03B//7bNCKxyJ7Wccfp9/KcoO7dacBlGAFHZmOX84wFXtFyuDquChIpjex/jiJ
	 Fh6XAvar3bPsRmOHuDjblQBtkp5k/Iv1JpGNVVqXPdfbipdDe0RbEOyZIIlUK67n/oUhF
	 O7CYDu0rtavLQzY/dR0YnwoUpU/29gPhAkaZ4YxodgIkjnbLO/ngtqAwHB0/n4qgMfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795025091;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YA6MAlWf4YjTf8My3K0oC88YjozjPwLivPE210GMvZQ=;
	b=irurPKO6NUJ33tvXAewyuypLGIqDzsW7tVkHile6QOLuNjGgrmm9dfF42/NvF9UnVfp7
	 D/o4gQtBiaIN+Z2rTPtKle/Y5a+N7SiH5XnHllMLicpNtma8qPbB5rHv8+aC/8/nGtbDr
	 dlKJzDJM7ckdxU2iVICBap8c6b6V0l3IEOVH2ai9FcQGo0lf0UixpKMU3+MRB+Ie0tr5a
	 qrOnLdbcDoEVsHCd68qyCWvvqnZpd72lFkD76I6wW4cLXlE/0Z4NTFGt0mQ8l2LOZMPdW
	 69HpDF10Bb3jOJjjE0LnW1rFjmA8Fg6vmfBs23nnj0oc/WMUBLPi6/9zHnNi/c0n6UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3b367Dx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020D6606A31C
	for <linux-cxl@vger.kernel.org>; Wed, 18 Nov 2026 18:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3b367Dx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC5D1F000C4;
	Wed, 18 Nov 2026 18:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795025090;
	bh=YA6MAlWf4YjTf8My3K0oC88YjozjPwLivPE210GMvZQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=S3b367DxIHlu+YHUXNwftjc8MIicybtf17rW+zSIlGgRd5YxTk3QvZto9nifZML1t
	 igrAHnBwvQGuRZyk6EDWSihmZxWkRDFdOuWX/pUMoZbMEUfdNuUtEqFLF/jYLv9qj8
	 mlE/3WvVpeXt7eUjk2yB2bi8zEB0xBvcI2Gp/eW0FJ6YNGpB7xRHDPR+t3/LMTOJwu
	 UM1bXVw9Nym9DpopnlKqBpuDLDHI28FARnN3VdAyPEhf+lxl2ZhNyPe28SJ7FUXi3H
	 K/BdKL3+4BwjgccZEc+zIPnu4WouoTXq+/Zi7GWfAMUd08ttLAReN1nEEcR1KLZYTN
	 0E3K5PNeybgtQ==
Message-ID: <sashiko-outbox-221722@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC 3/3] Documentation/cxl: add document about Type2 binding
 and unbinding
Reply-To: sashiko-reviews@lists.linux.dev
To: alucerop@amd.com, linux-cxl@vger.kernel.org
In-Reply-To: <20261118191431.21781-4-alucerop@amd.com>
References: <20261118191431.21781-1-alucerop@amd.com>
 <20261118191431.21781-4-alucerop@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 18:04:50 +0000
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] Documentation/cxl: missing toctree entry for
  cxl_type2_objects_unwinding.rst
- [Low] Documentation/cxl: broken RST list numbering and literal blocks
  in type2 doc
--

commit b833f3f32d3c092128799e7d5375466321b53bec
Author: Alejandro Lucero <alucerop@amd.com>

Documentation/cxl: add document about Type2 binding and unbinding

This commit adds documentation describing CXL Type 2 device chain creation
and unwinding across devres and explicit unbind paths.

> diff --git a/Documentation/driver-api/cxl/type2/cxl_type2_objects_unwindi=
ng.rst b/Documentation/driver-api/cxl/type2/cxl_type2_objects_unwinding.rst
> new file mode 100644
> index 0000000000000..873f95d9c202b
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/type2/cxl_type2_objects_unwinding.rst
> @@ -0,0 +1,102 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Compute Express Link: Type2 unwinding
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[Severity: Low]
Should type2/cxl_type2_objects_unwinding be added to a toctree in
Documentation/driver-api/cxl/index.rst?  Without a toctree reference, make
htmldocs emits a "WARNING: document isn't included in any toctree" warning
and leaves this page unlinked from the CXL documentation index.

> +
> +The CXL subsystem relies on the linux kernel device abstraction for repr=
esenting
> +the different componentes building up the subsystem itself. The core or =
root

[ ... ]

> + 1) The pci device owning the Type2 CXL "device" unbinds from its driver.
> + 2) The type2 driver is removed triggering the pci device unbinding.
> + 3) The cxl memdev is unbound from the cxl mem driver through sysfs.
> + 4) The cxl endpoint port is unbound from the cxl port driver through sy=
stfs.
> + 5) The cxl_region is unbound from the cxl region driver through sysfs.
> + 8) Root port linked to the device is unbound frmo the cxl port through =
sysfs.
> + 9) cxl acpi kernel module is removed.

[ ... ]

> +Visualizing the different unwinding cases
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +For helping with the debugging and/or understanding of current Type2, or=
 even
> +Type3 devices, unwinding some tracepoints are available for enabling the=
m all:
> +
> +
> +   # echo 1 > /sys/kernel/debug/tracing/events/cxl_unwinding/enable
> +
> +or individually as for example:
> +
> +   # echo 1 > /sys/kernel/debug/tracing/events/cxl_unwinding/cxl_memdev_=
release/enable
> +
> +	or
> +
> +   # echo "cxl_unwinding:cxl_memdev_release" > /sys/kernel/debug/tracing=
/set_event

[Severity: Low]
The numbered list jumps from 5) to 8) and 9) without a blank line, which
causes Sphinx/Docutils to fold items 8) and 9) into item 5) as
continuation text rather than separate list entries.

In the tracepoint section, the lines introducing the shell commands end
with ":" instead of "::", and "or" is indented with a tab while the
commands use three spaces, so Sphinx renders them as nested blockquotes
instead of literal code blocks.

There are also a few typos in the text: "componentes" ("components"),
"systfs" ("sysfs"), and "frmo" ("from").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118191431.2178=
1-2-alucerop@amd.com?part=3D3
