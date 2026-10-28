Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223152;
	b=Me0HOWHop66k/LlS5XE7EqBqD3aH0wKKwiPJ8f6WFJkSrbk9ooNrZE9WaqNsa1A/EIOz
	 xxZ6qAkCCgHq78OWptgMDnzK0kcwvsBy59d6vXlQ+t5E75LUtIZGSLQr5ezSIAzenvviR
	 rJLEauRWwjM8iLBFPCtAbqt+d9yiOXBV8VKBq/NdQIKgcEEJVV705NZvXg3k7iD9ilkNr
	 GChlkcrHpp+bCh12Kz5MUEUhAnFTuMncr7KwkLZQ1t2frfpVRMu79NW28SzVMLKIoPTqn
	 kkmzjFX7OwBGVPAvO30ZIdzHD76HGV3OssrTARg7Shpa6IMgR97hqxJZbicqfKxEiZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223152;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qpYAKI/mvXtVk+gZIz49wphRFQPIjr2T3XBTat4EzQs=;
	b=rDLu7tk3DB5+t4ce70X80OfHeokt9U5QCGCNhPmUcQ+4SoELpAz5lFHayxKQmBFYBbB8
	 cK5f+slOlyhc/33wK7zlGPP0HHRTLLsghZwlHSowrOJ6UuBxW1msslmYkvL9sSmu5VGp6
	 qTL0GYhoyjr1q/iFjeGc1xhriK2twjQLZLdACRJuVthBdoH8VIDO1x9BNmYIJPaQRpMiE
	 nW7xIR4WFxAGQUtWymo1Xppa55I3cOBW4QBUXlbn1/QS22Swal4VsfjQsqBq1EytFJxKj
	 kO4kiMBF/NyfJAESplgDtiAitiqRBMzTKxysHkv1ctphrxaxMlnkFGj9Di9hIs9Uohg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ARqT/Izw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FB8606A32D
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 21:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ARqT/Izw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469291F01825;
	Wed, 28 Oct 2026 21:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793223151;
	bh=qpYAKI/mvXtVk+gZIz49wphRFQPIjr2T3XBTat4EzQs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ARqT/IzwGlsXFRd8nOAJOV0iw8/HDPaHzTQERNTxcb0zOtYlqqnllKedhj0PV8Pn6
	 SBKASB9G3Cwr6HXqt3WuiKC8hJ1Tr45u0lPbNKSKovUzf7XwcPKMDxRzW1nIZF3rHl
	 N6H1AFJOZTlCAYBNOZRZ7Px8I+7QM72r9ftl3I/Bivn8DhlH3sNJ9u5oUgZRxRVBxd
	 mT7ntoHOK29Yk64sG1da4nqsaMvnKtc8tJOQohhaT44MzfZYCR2es2sDgbFqJVGL1Y
	 Rcf9y98v0FIYw0M7HrKgfmMJHhgXt8Pr2/KarAFgy4fOxVUJhBTVxAIPRroK+0EVB3
	 GGi82gXY8z2Bw==
Message-ID: <sashiko-outbox-188460@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/hdm: Account for a firmware-armed Lock On Commit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Davidlohr Bueso" <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20261028211836.939648-1-dave@stgolabs.net>
References: <20261028211836.939648-1-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 21:32:30 +0000
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] cxl/hdm: missing CXL_REGION_F_LOCK propagation in cxl_decoder_comm=
it()
--

commit 38da830927e8d8e6e1d5d4154ac43502a9344546
Author: Davidlohr Bueso <dave@stgolabs.net>

cxl/hdm: Account for a firmware-armed Lock On Commit

This patch reads back the HDM decoder control register after committing a
decoder in cxl_decoder_commit() and sets CXL_DECODER_F_LOCK on cxld->flags =
if
CXL_HDM_DECODER0_CTRL_LOCK is set, so that an uncommitted decoder with Lock
On Commit armed by firmware is treated as locked once committed.

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index fdcef20e01baa..d23076aabb89b 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -856,6 +856,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxl=
d)
>  	struct cxl_hdm *cxlhdm =3D dev_get_drvdata(&port->dev);
>  	void __iomem *hdm =3D cxlhdm->regs.hdm_decoder;
>  	int id =3D cxld->id, rc;
> +	u32 ctrl;
> =20
>  	if (cxld->flags & CXL_DECODER_F_ENABLE)
>  		return 0;
> @@ -899,6 +900,14 @@ static int cxl_decoder_commit(struct cxl_decoder *cx=
ld)
>  	port->commit_end++;
>  	cxld->flags |=3D CXL_DECODER_F_ENABLE;
> =20
> +	/*
> +	 * Lock On Commit armed by firmware engages on this commit and
> +	 * makes the decoder read-only, like one found locked at probe.
> +	 */
> +	ctrl =3D readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> +		cxld->flags |=3D CXL_DECODER_F_LOCK;

[Severity: High]
Does setting CXL_DECODER_F_LOCK here in cxl_decoder_commit() leave the owni=
ng
cxl_region unlocked because CXL_REGION_F_LOCK is never propagated to
cxlr->flags?

For a decoder found committed and locked at probe time, init_hdm_decoder()
sets CXL_DECODER_F_LOCK before targets are attached. When targets are
subsequently attached via the attach_target() -> __attach_target() ->
cxl_region_attach() -> cxl_port_attach_region() call chain,
cxl_region_setup_flags() propagates the lock to the region:

drivers/cxl/core/region.c:cxl_region_setup_flags() {
	if (cxld->flags & CXL_DECODER_F_LOCK) {
		set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
		clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
	}
}

However, when firmware arms Lock On Commit on an uncommitted decoder,
CXL_DECODER_F_LOCK is not set during cxl_port_attach_region(). It is only s=
et
later when commit_store() -> __commit() -> cxl_region_decode_commit() ->
commit_decoder() -> cxl_decoder_commit() runs:

drivers/cxl/core/region.c:cxl_region_decode_commit() {
		/* commit bottom up */
		for (iter =3D cxled_to_port(cxled); !is_cxl_root(iter);
		     iter =3D to_cxl_port(iter->dev.parent)) {
			cxl_rr =3D cxl_rr_load(iter, cxlr);
			cxld =3D cxl_rr->decoder;
			rc =3D commit_decoder(cxld);
			if (rc)
				break;
		}
}

Because neither cxl_decoder_commit() nor cxl_region_decode_commit() updates
cxlr->flags after committing the decoder, CXL_REGION_F_LOCK remains clear on
the region.

Without CXL_REGION_F_LOCK set on cxlr->flags:

1. The region sysfs attribute locked_show() reports 0 even though the
   underlying decoder is locked.

2. Writing 0 to the region commit sysfs attribute in commit_store() bypasses
   the -EPERM check:

drivers/cxl/core/region.c:commit_store() {
	if (test_bit(CXL_REGION_F_LOCK, &cxlr->flags))
		return -EPERM;
}

3. When the region is reset or torn down via commit_store(),
   unregister_region(), or the error rollback path in
   cxl_region_decode_commit(), cxl_region_decode_reset() bypasses its early
   return:

drivers/cxl/core/region.c:cxl_region_decode_reset() {
	if (test_bit(CXL_REGION_F_LOCK, &cxlr->flags))
		return;
}

   As a result, cxl_region_decode_reset() resets any unlocked upstream swit=
ch,
   host-bridge, or peer endpoint decoders in the region (clearing their
   CXL_DECODER_F_ENABLE flag and allowing peer DPA to be freed) while
   cxl_decoder_reset() skips the locked decoder, leaving the hardware decode
   hierarchy partially torn down.

Should cxl_region_decode_commit() call cxl_region_setup_flags(cxlr, cxld) (=
or
propagate CXL_DECODER_F_LOCK to cxlr->flags) after commit_decoder() succeed=
s?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028211836.9396=
48-1-dave@stgolabs.net?part=3D1
