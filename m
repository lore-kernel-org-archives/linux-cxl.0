Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A583C09EF
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 08:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789029411; cv=none; b=goC+goLYVY6UarTGlIJOcvcp0DNExkJY0P8KuntYTv34Uu+8489aQu3laoMIh+zbleU9FT7RJe84xTc2lCw4RsJ+P1FEY3q50kne2aMiQlOml4WrL6lEWydsDvRJto7MDbxlFhvy04xp7E3Oc/s0vBwesvplxcNrXqJhrYHSP8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789029411; c=relaxed/simple;
	bh=+cuqiLgFwII/Qa8jNVLRCXi1pmYZkK/jTAhYpQCQ2Wg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OdWgNto65YoP8SNiVj81KfgayDyKu+abELs9Jw35EcS5I0KclKvhyrXA5an5EmpKDUaNz8Vk8YKvyoVnOb/mBV1UnYui1cWvzP1Wt6Vb1vEk5tWYP77I/7qdxFaoIi/85sQ83n4PUh8ZO23P48H8RtK083Bqd2ahlc2R4maKWrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuZThmd3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuZThmd3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08631F00893;
	Thu, 10 Sep 2026 08:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789029410;
	bh=BNR5EWwtcgBA/F4mFzZLCO6x0D09Iwzryy5/sUwhmDA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YuZThmd3pcv4KG87KbJTq2s7055k+8n43O7P86JBwxiahkJ4hXLlEXoC/c5N9i35E
	 Hc9jD+YWmIA8gvgGapU4uJ9dJ1VJXxvgseFQ1rc7BgFH/VdbvQABxXLiG5dr5n3740
	 a8CR1Y/YAL0j9jAPGESXOUeLDgcsW86ky5stE9hT9fvsjjJuvhdi0sZuLDX9ntEQCt
	 5Sgn1ISYRFIDxchEQ67Q0MeqjBlcMhSj1dk9q2e+oapG7JRiNC0TI6ALTxtjWAJQhH
	 NQD7NeXz2nQPNwQO4gZ/qm8VNWxgMxCmrJEqSPl3d5hEk61sw6Gq6V2bq92PPXViUj
	 veIzZJ+uzl6eQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] cxl/pci: Skip reset detection for DVSEC emulated
 decoders
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260910082141.3908416-1-kanie@linux.alibaba.com>
References: <20260910082141.3908416-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 08:36:49 +0000
Message-Id: <20260910083649.F08631F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Non-atomic read-modify-write of cxld->flags in cxl_endpoint_decode=
r_clear_reset_flags() can race with concurrent updates.
- [High] Missing exclusion against cxl_port unbind in the reset handler can=
 lead to a use-after-free or NULL pointer dereference of the devm-allocated=
 cxlhdm structure.
--

commit d4b494faf63903a18d56d255741d1947191718ae
Author: Guixin Liu <kanie@linux.alibaba.com>

cxl/pci: Skip reset detection for DVSEC emulated decoders

This commit skips reset detection for HDM decoders that are emulated from
DVSEC range registers, as they lack component registers or Committed bits.
It warns when doing so since these non-sticky registers might be cleared by
a reset and the loss cannot be detected.

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9d807c1a002ca..03dae6b701a43 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c

[ ... ]

> @@ -683,6 +683,16 @@ static int __cxl_endpoint_decoder_reset_detected(str=
uct device *dev, void *data)

[ ... ]

>  	if (!cxld->commit) {
>  		dev_warn(dev, "DVSEC emulated decode may have been cleared by reset\n"=
);
>  		return 0;
>  	}
> =20
>  	cxlhdm =3D dev_get_drvdata(&port->dev);
>  	hdm =3D cxlhdm->regs.hdm_decoder;

[Severity: High]
This isn't a bug introduced by this patch, but does the lack of exclusion
against cxl_port unbind risk a use-after-free or NULL pointer dereference
here?

If an administrator unbinds the cxl_port driver via sysfs concurrently with
an asynchronous CXL AER reset triggering cxl_reset_done(), the devm-allocat=
ed
cxlhdm structure bound to port->dev could be freed or NULLed before it is
accessed, since there appears to be no mutual exclusion.

>  	ctrl =3D readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> =20
>  	return !FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
>  }

Additionally, looking at the wider reset handling path in drivers/cxl/pci.c:

[Severity: High]
This is a pre-existing issue, but does the non-atomic modification of
cxld->flags in cxl_endpoint_decoder_clear_reset_flags() risk torn writes
when racing against concurrent updates?

drivers/cxl/pci.c:cxl_endpoint_decoder_clear_reset_flags() {
    ...
    cxled->cxld.flags &=3D ~CXL_DECODER_F_RESET_MASK;
    ...
}

If the asynchronous CXL AER reset handler executes concurrently with region
setup paths (driven via sysfs or driver core), both could attempt to modify
cxld->flags. If cxl_rwsem.region is not held in the reset handler, could
this result in decoder state corruption, such as losing the
CXL_DECODER_F_ENABLE or CXL_DECODER_F_LOCK flags?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910082141.3908=
416-1-kanie@linux.alibaba.com?part=3D1
