Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA5F3398E
	for <linux-cxl@vger.kernel.org>; Wed, 30 Oct 2024 06:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730268080; cv=none; b=LR1A6CmpdYTdfCEZpc4/7uMPybMtmtRIV8T/QSGShPtA+TFVr59zR0pCu+q3JmoALU9MQUm29dj7wxRvVXJ+mDCczkkM5+q5EL1DhCE1nyqt5i1CkpJdPdqLC3mw6iNsFnXm/wgUAWQWruDyd5Uv0v5WDdq5fUitaa47FcNch04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730268080; c=relaxed/simple;
	bh=EjGDiTKzaOBN8VDg/967deIrUpk91RFrgnzOw7F6KH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bhkzl492VqxZ+YIJ1uHi1KstjBcYjIp187urhKbK62cE1+npeqej+Vxfqq/hnGQoBk/wSPdAIA9b9Rgixh/jEUOQctA79R1u2GDJbeKoex9R1ZEg+Tqio+0Fe4lA18Jq0Iw6PaxgisS3Al94el1w8q9LzaOo8oOiSpKr82F9fms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk; spf=pass smtp.mailfrom=irrelevant.dk; dkim=pass (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b=gmgqcY7v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EIK+lziB; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irrelevant.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="gmgqcY7v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EIK+lziB"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CFBBA11400D9;
	Wed, 30 Oct 2024 02:01:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 30 Oct 2024 02:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1730268074; x=
	1730354474; bh=SJgybJpt+nV8SoJCmz4xWg5DLbsh66RohILsXS/7Wpw=; b=g
	mgqcY7viscu6cYj9gzXGulABtPU92ZghrDYCu9j0YtUT52ZbjV99j6rvkcJTmCHX
	pOKD1kuGb/Fpby9SDHlm/Jmm2rSqEFe8ftDBFBTMowNVaGCkUmnG0MRT/pXoV9+/
	P+h+ss1Zmto8ViNSwSGRYZCHxv/dIUDeiyEqL6UPtVcHiEewQNNxGXapoh08CyNT
	OmSDWHocxbjVdDFFb67ZVxvEbZyFerJ4m1kUf/0qO/ZXzSwcCKyOAG6Bwgcc7ewv
	7FW5/Hgn+yg+fuxHCjbRsLKnNrRzeI6Tb23k7s8SdMtbNkQEObwIqLNi9aJVHTAW
	/vTt+GNsl6yllum7Z3KFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730268074; x=1730354474; bh=SJgybJpt+nV8SoJCmz4xWg5DLbsh66RohIL
	sXS/7Wpw=; b=EIK+lziBwgIvJsOM+JXG6NXFgX2e0cHy5GRqisPpXFJCM+S3Loz
	E/p86VZRqSSTeHAgcisJWlvVQPSMp+pRKmDcKpNiT10D1XHu3M8bJX/znANfuJMu
	Bjq4QFgIJztJKG1h7c53rRPZRrkm5I5zwk0ja8+vxVBlvHwJLwCCQuQ6aGxag6xs
	8HA0pJOXvAhHFsDiABQJziW/Ozl97egspxA5wmQo2KqAnckK3CHQ+QHyHktIzwgJ
	AtwKJaPAEjsxrq7Oh9YFw/n3Bxe062bbP0zDwJhpB39GX2ZFyL2+Kqp0NKZJ+/kJ
	CcSBWpqJCSy5CHoPm9Qe+3l4hXzSNbeGakQ==
X-ME-Sender: <xms:p8shZ_3knMLzLgrrZLTIjOvJjJvrsJA7zYDPE3csng7I_ZnI4kTuqA>
    <xme:p8shZ-HpuplR5C0FEz7hgKysj2Apu0Wz-mhPmO2cxFo_8JtlPzwnrvyci4whNTEGH
    dpRwAEcr8aiFoAnZdU>
X-ME-Received: <xmr:p8shZ_4SghPVkPV1zWYd0B3-yKRFqBrf9G6UZT4BOKFW_z7sCyxulp284AHE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekvddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeen
    ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
    gukheqnecuggftrfgrthhtvghrnhepveeiheffhfduieeikefghedtudehudduueekiefg
    geffuedvkefgfeeuheejieefnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhr
    vghlvghvrghnthdrughkpdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepjhhonhgrthhhrghnrdgtrghmvghrohhnsehhuhgrfigvihdrtgho
    mhdprhgtphhtthhopehmihhnhigrrhgusegrtghmrdhorhhgpdhrtghpthhtoheprghnug
    hrvgifsegtohguvggtohhnshhtrhhutghtrdgtohhmrdgruhdprhgtphhtthhopehmrght
    thestghouggvtghonhhsthhruhgtthdrtghomhdrrghupdhrtghpthhtoheptghmihhnhi
    grrhgusehmvhhishhtrgdrtghomhdprhgtphhtthhopehpsghonhiiihhnihesrhgvughh
    rghtrdgtohhmpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhord
    horhhgpdhrtghpthhtohepjhgrshhofigrnhhgsehrvgguhhgrthdrtghomhdprhgtphht
    thhopehksghushgthheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:p8shZ022fTZAfKDMeVI6KsMPTAlXTd-U1uit_S_OZhI6oCVDDhTW3Q>
    <xmx:p8shZyGRjzYegaYOvRWVUokN_I285O_ZqQDnueNcPCgtVz0G_dEQ8g>
    <xmx:p8shZ18N1yCJlA5ovAZOjUrb3Toq30QZQeYxLlfvYzUT_yq0TW6Lnw>
    <xmx:p8shZ_mcxVmKKWqpZO8W_lGVMDYuwV_T2gy0bqdpPS0UWSBv20FYHg>
    <xmx:qsshZ1ncfOzfZpwpnPcakeej658ShTWCsAOS9QhXvBuIo4kzD1fvKTc0>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Oct 2024 02:01:11 -0400 (EDT)
Date: Wed, 30 Oct 2024 07:01:09 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Corey Minyard <minyard@acm.org>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Corey Minyard <cminyard@mvista.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
	Lior Weintraub <liorw@pliops.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Peter Delevoryas <peter@pjd.dev>, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, qemu-block@nongnu.org,
	Klaus Jensen <k.jensen@samsung.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v6 0/3] hw/{i2c,nvme}: mctp endpoint, nvme management
 interface model
Message-ID: <ZyHLpSzAAt7CevSg@AALNPWKJENSEN.aal.scsc.local>
References: <20230914-nmi-i2c-v6-0-11bbb4f74d18@samsung.com>
 <20230920124803.00005ae9@Huawei.com>
 <ZQrrgxHrfzmGyhZU@mail.minyard.net>
 <ZQr0LXsSRXGqJ4EL@cormorant.local>
 <ZQsDcmkZYCk0eVhA@mail.minyard.net>
 <20241014103653.00002c83@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j6NcMIs1GVbu8Nan"
Content-Disposition: inline
In-Reply-To: <20241014103653.00002c83@Huawei.com>


--j6NcMIs1GVbu8Nan
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 14 10:36, Jonathan Cameron via wrote:
> On Wed, 20 Sep 2023 09:36:34 -0500
> Corey Minyard <minyard@acm.org> wrote:
>=20
> > On Wed, Sep 20, 2023 at 06:31:25AM -0700, Klaus Jensen wrote:
> > > On Sep 20 07:54, Corey Minyard wrote: =20
> > > > On Wed, Sep 20, 2023 at 12:48:03PM +0100, Jonathan Cameron via wrot=
e: =20
> > > > > On Thu, 14 Sep 2023 11:53:40 +0200
> > > > > Klaus Jensen <its@irrelevant.dk> wrote:
> > > > >  =20
> > > > > > This adds a generic MCTP endpoint model that other devices may =
derive
> > > > > > from.
> > > > > >=20
> > > > > > Also included is a very basic implementation of an NVMe-MI devi=
ce,
> > > > > > supporting only a small subset of the required commands.
> > > > > >=20
> > > > > > Since this all relies on i2c target mode, this can currently on=
ly be
> > > > > > used with an SoC that includes the Aspeed I2C controller.
> > > > > >=20
> > > > > > The easiest way to get up and running with this, is to grab my =
buildroot
> > > > > > overlay[1] (aspeed_ast2600evb_nmi_defconfig). It includes modif=
ied a
> > > > > > modified dts as well as a couple of required packages.
> > > > > >=20
> > > > > > QEMU can then be launched along these lines:
> > > > > >=20
> > > > > >   qemu-system-arm \
> > > > > >     -nographic \
> > > > > >     -M ast2600-evb \
> > > > > >     -kernel output/images/zImage \
> > > > > >     -initrd output/images/rootfs.cpio \
> > > > > >     -dtb output/images/aspeed-ast2600-evb-nmi.dtb \
> > > > > >     -nic user,hostfwd=3Dtcp::2222-:22 \
> > > > > >     -device nmi-i2c,address=3D0x3a \
> > > > > >     -serial mon:stdio
> > > > > >=20
> > > > > > From within the booted system,
> > > > > >=20
> > > > > >   mctp addr add 8 dev mctpi2c15
> > > > > >   mctp link set mctpi2c15 up
> > > > > >   mctp route add 9 via mctpi2c15
> > > > > >   mctp neigh add 9 dev mctpi2c15 lladdr 0x3a
> > > > > >   mi-mctp 1 9 info
> > > > > >=20
> > > > > > Comments are very welcome!
> > > > > >=20
> > > > > >   [1]: https://github.com/birkelund/hwtests/tree/main/br2-exter=
nal
> > > > > >=20
> > > > > > Signed-off-by: Klaus Jensen <k.jensen@samsung.com> =20
> > > > >=20
> > > > > Hi Klaus,
> > > > >=20
> > > > > Silly question, but who is likely to pick this up? + likely to be=
 soon?
> > > > >=20
> > > > > I'm going to post the CXL stuff that makes use of the core suppor=
t shortly
> > > > > and whilst I can point at this patch set on list, I'd keen to see=
 it upstream
> > > > > to reduce the dependencies (it's got 2 sets ahead of it of CXL st=
uff
> > > > > anyway but that will all hopefully go through Michael Tsirkin's t=
ree
> > > > > for PCI stuff in one go). =20
> > > >=20
> > > > I can pick it up, but he can just request a merge, too.
> > > >=20
> > > > I did have a question I asked earlier about tests.  It would be unu=
sual
> > > > at this point to add something like this without having some tests,
> > > > especially injecting invalid data.
> > > >  =20
> > >=20
> > > Hi all,
> > >=20
> > > Sorry for the late reply. I'm currently at SDC, but I will write up s=
ome
> > > tests when I get back to in the office on Monday.
> > >=20
> > > Corey, what kinds of tests would be best here? Avocado "acceptance"
> > > tests or would you like to see something lower level? =20
> >=20
> > My main concern is testing what happens when bad data gets injected, to
> > avoid people coming up with clever names for exploits in qemu.  It's not
> > so much for this code, it's for the changes that comes in the future.
> >=20
> > And, of course, normal functional tests to make sure it works.  What a
> > friend of mine calls "dead chicken" tests.  You wave a dead chicken at
> > it, and if the chicken is still dead everything is ok :).
> >=20
> > I'm fine with either type of tests, but I'm not sure you can do this
> > with avocado.  It's probably about the same amount of work either path
> > you choose.
> >=20
> > -corey
>=20
> Hi Klaus, All,
>=20
> I was looking at what dependencies I'm carrying on my CXL tree and this
> series is one of the bigger bits :(
>=20
> Any plans to take it forwards?
> I have some other stuff to solve to have a fully upstream QEMU
> solution for the CXL fm-api over mctp (direct from host anyway), but
> if this is blocked indefinitely tackling how to get a controller onto
> a typical server system isn't going to be productive :(
>=20
> As Davidlohr called out at in the CXL LPC Uconf [1] this is really handy
> for testing his work on libcxlmi. A number of people are looking
> at more sophisticated CXL fabric emulation and that will also need
> us to close this gap!
>=20
> No promises but maybe we can find someone to help with adding tests
> if that's the only remaining blocker.
>=20

Yes, I believe the lack of tests are the blocker currently. I've mostly
been testing this through a buildroot. That allows me to at least kick
it with invalid fields and so on, but it all depends on the linux mctp
driver doing the bulk of the work (and it's not really supposed to do
"bad stuff"), so it's limited how low we can go.

While I have the infrastructure to do that, I'm really not sure where to
start if we want to test what happens when the emulated mctp device gets
bad packets. I don't think we can instruct the mctp subsystem in linux
to do that easily. And if we do not use it (to forcefully write invalid
packets on the bus), I'm not sure how to deal with the required target
mode.

Would anyone know if the i2c-slave-testunit could be viable way forward
to test this?

--j6NcMIs1GVbu8Nan
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmchy6MACgkQTeGvMW1P
DengKQgAgnPE1IbGBycgJBotI9FlQfKbmbcoOH6PaK3pr4EUO7uFCoUO0z97Ua8p
3Nxkb+xTvWJFSMvxd2kmAKNU77o8imATPx8SWNMGuKKX9I0OmofUigMYwhd8UPkP
dPZN76fAB4lD7QalwUIrj7k/AiXwsdGYmsa7E5HnkdLBJmiZLyACOyXFmSeqFCky
20XpXbLRh8ptRUi1NjBvNKI/roCCAnpmY/CoqXyAIaD6tVZvxLEr4uuxSbWlFI4L
yg9++qrVRyy/AUyDwbJ5ed8NoLx8uyKjW4L0lBdgNTIJWvxPGWIabSBjfebPCiuY
Jpwtl+lXpSDSdZCRFsZlHvz11AmIEA==
=COjM
-----END PGP SIGNATURE-----

--j6NcMIs1GVbu8Nan--
