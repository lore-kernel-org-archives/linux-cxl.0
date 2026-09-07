Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409B1299959;
	Mon,  7 Sep 2026 23:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788822302; cv=none; b=grgpkNN0UY/qvR5kq+3Z+LTk0SUo8HNJgxyNkPHlGbXxh7sOGIfpq7A/DQ/HXyMMEn6xs7xlZCnQAqoxZVNhFZFbeeTFQSLIPDbxelnkNWxART0tGXFOAicVJjmNCmysFKl+QLs2DTwBJOx6LaPGIefchrLFSEF7iAi9+ZjfgA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788822302; c=relaxed/simple;
	bh=RErVJt9PyWKnN+ncfPNhdBw9MPDdBVJeZZq2Ejk813g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S9tEPceADF4DrL3BYGkTDx3BJHqo/W8rF5wqFIL8mdq1I4skoy7zyd20wuxgA24iTXlAQVEDYb9epYlb6DpKnuZn8nQ2N0My51c/7+q96Zg8k9vHrRZmeZPCgmwrBL03gnccOaviLhtdEqTxXJ+eEJT51bZZhDf7Mxi53BYgwrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJpo8eIW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJpo8eIW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4622D1F00A3A;
	Mon,  7 Sep 2026 23:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788822301;
	bh=MTbdfzFilQG/172ywwQoJrOvulCi1skkPF0yIh1s9X0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RJpo8eIW6WxlO6e1W3+0R88w69hHyYprTNte2QxYW+UNp0DrVsQBJNULeP6tAG8HJ
	 4gx75Ba6SVwIolJwS2mbWa3r58NaO47UOeu5KpHnDmsV97MC7Q+hF1IKeJlG9Up28R
	 cs1395oqk6eU41ckIcMV+LpByMauzdTTt/CiFzLyAp3jEl7fJtw/zRHtacW0b5/Nid
	 +J7ESWRuw4en4vrQPEviWcp4rE42k5w0qWnzOd2H4VqpJZlrp7K/Vs2XS+DpImYDLl
	 cBsX2qPZEvfg8zDVrhA6k90u40EG6Jp6rKes06Khs3usL4v392+F37js9J+stMBegM
	 q0y08aabVCpow==
Date: Tue, 8 Sep 2026 00:04:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Richard Cheng <icheng@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 sashiko-reviews@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cxl/region: Allow passthrough decoders with >16K
 granularity
Message-ID: <20260908000455.32884adc@jic23-huawei>
In-Reply-To: <alXqISpyXQVzOlmq@MWDK4CY14F>
References: <cover.1783795720.git.alison.schofield@intel.com>
	<9a798f6b445ca8f2b16743d3e16fa289efadd86a.1783795720.git.alison.schofield@intel.com>
	<20260711201508.082531F000E9@smtp.kernel.org>
	<alL3a2UXB38XI7Nb@aschofie-mobl2.lan>
	<alXqISpyXQVzOlmq@MWDK4CY14F>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Jul 2026 15:56:18 +0800
Richard Cheng <icheng@nvidia.com> wrote:

> On Sat, Jul 11, 2026 at 07:09:47PM +0800, Alison Schofield wrote:
> > On Sat, Jul 11, 2026 at 08:15:07PM +0000, sashiko-bot@kernel.org wrote:=
 =20
> > > Thank you for your contribution! Sashiko AI review found 1 potential =
issue(s) to consider:
> > > - [High] During auto-discovery (CXL_REGION_F_AUTO), passthrough decod=
ers fail to update their `interleave_granularity` software state to the com=
puted value, causing downstream decoders to inherit incorrect granularity a=
nd fail validation upon reboot. =20
> >=20
> > Same NO as in v1[1]  and I don't see a way to graciously alert you to t=
his
> > in the code. Gratuitously updating the field is not the right thing to
> > do.
> >=20
> >=20
> > [1] https://lore.kernel.org/linux-cxl/alKP8OP4DNT2nJnu@aschofie-mobl2.l=
an/#r
> > No. A downstream decoder can't inherit an unecodable value into a faili=
ng
> > check. A >16K granularity only appears below a wide interleave, and
> > everything below that inherits an equal-or-larger value that an interle=
aving
> > decoder couldn't encode. So every descendant is necessarily passthrough=
 and
> > never validates granularity. There is no path where updating the F_AUTO
> > value would prevent a failure because the failure cannot happen.
> > =20
>=20
> Hi Alison,
>=20
> I'm thinking of 1 scenario where a regression might still happen,
> independent of whether an interleaving decoder can appear below a >16k
> passthrough decoder.
>=20
> The new cxld_set_interleave() behavior writes EIG=3D0 for every IW=3D1 de=
coder,
> including cases where logical granularity is encodable.
>=20
> For example,
> root: IW=3D2, IG=3D4k
> passthrough: IW=3D1, logical IG=3D8K
> downstream: IW=3D2, IG=3D8K
>=20
> During manual setup, the passthrough decoder gets a logical IG of 8K.
> With your change, committing it writes EIG=3D0. On rediscovery, that is
> read back as 256 byte.
>=20
> The AUTO path accepts the passthrough decoder because it skips the IG
> comparison for IW=3D1, but it does not restore.
>=20
> The downstream decoder will inherits 256 bytes instead of 8K and its 8K c=
onfig
> fails validation.

I was looking back having seen some text on this in v4 that confused me.

Isn't a failure on this combination a bug anyway (that we should fix)?=20
The downstream decoder shouldn't inherit a value of granularity from a
pass through decoder (as it's meaningless) it should be getting the
appropriate values from next level up in the tree (or further if
there are more passthrough decoders up there).

Jonathan

>=20
> Could cxld_set_interleave() keep the real IG encoding when it's encodable=
 and
> use EIG=3D0 only when an IW=3D1 value isn't encodable?
> For latter case, AUTO still need to restore the computed logical IG before
> walking descendants.
>=20
> What do you think ?
>=20
> Best regards,
> Richard Cheng.
> >=20
> >  =20
> > > --
> > >=20
> > > --- Patch [1]: [PATCH v2 1/2] cxl/region: Allow passthrough decoders =
with >16K granularity ---
> > > commit 9e2526342188a97e338bfc63d454c253f1e2b3ef
> > > Author: Alison Schofield <alison.schofield@intel.com>
> > >=20
> > > cxl/region: Allow passthrough decoders with >16K granularity
> > >=20
> > > This commit allows passthrough decoders beneath wide parent interleav=
es
> > > to have a granularity exceeding 16K by programming a don't-care value
> > > in hardware for non-interleaving decoders.
> > >  =20
> > > > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > > > index 0c80b76a5f9b4..d164662668c19 100644
> > > > --- a/drivers/cxl/core/hdm.c
> > > > +++ b/drivers/cxl/core/hdm.c
> > > > @@ -691,9 +691,16 @@ static void cxld_set_interleave(struct cxl_dec=
oder *cxld, u32 *ctrl)
> > > >  	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
> > > >  		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
> > > >  		return;
> > > > -	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &e=
ig),
> > > > -		      "invalid interleave_granularity: %d\n",
> > > > -		      cxld->interleave_granularity))
> > > > +
> > > > +	/*
> > > > +	 * A non-interleaving decoder ignores the IG field. Encode a
> > > > +	 * don't-care value instead of validating the stored granularity.
> > > > +	 */
> > > > +	if (cxld->interleave_ways =3D=3D 1)
> > > > +		eig =3D 0;
> > > > +	else if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularit=
y, &eig),
> > > > +			   "invalid interleave_granularity: %d\n",
> > > > +			   cxld->interleave_granularity))
> > > >  		return;
> > > > =20
> > > >  	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK); =20
> > >=20
> > > [ ... ]
> > >  =20
> > > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > > index 1e211542b6b64..5a443551288c4 100644
> > > > --- a/drivers/cxl/core/region.c
> > > > +++ b/drivers/cxl/core/region.c =20
> > >=20
> > > [ ... ]
> > >  =20
> > > > @@ -1549,20 +1557,21 @@ static int cxl_port_setup_targets(struct cx=
l_port *port,
> > > >  	 * Interleave granularity is a multiple of @parent_port granulari=
ty.
> > > >  	 * Multiplier is the parent port interleave ways.
> > > >  	 */
> > > > -	rc =3D granularity_to_eig(parent_ig * parent_iw, &eig);
> > > > -	if (rc) {
> > > > -		dev_dbg(&cxlr->dev,
> > > > -			"%s: invalid granularity calculation (%d * %d)\n",
> > > > -			dev_name(&parent_port->dev), parent_ig, parent_iw);
> > > > -		return rc;
> > > > -	}
> > > > +	ig =3D parent_ig * parent_iw;
> > > > =20
> > > > -	rc =3D eig_to_granularity(eig, &ig);
> > > > -	if (rc) {
> > > > -		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
> > > > -			dev_name(port->uport_dev), dev_name(&port->dev),
> > > > -			256 << eig);
> > > > -		return rc;
> > > > +	/*
> > > > +	 * Keep the computed granularity for descendant setup. Only
> > > > +	 * interleaving decoders require an encodable granularity.
> > > > +	 */
> > > > +	if (iw > 1) {
> > > > +		rc =3D granularity_to_eig(ig, &eig);
> > > > +		if (rc) {
> > > > +			dev_dbg(&cxlr->dev,
> > > > +				"%s: invalid granularity calculation (%d * %d)\n",
> > > > +				dev_name(&parent_port->dev), parent_ig,
> > > > +				parent_iw);
> > > > +			return rc;
> > > > +		}
> > > >  	}
> > > > =20
> > > >  	if (iw > 8 || iw > cxlsd->nr_targets) { =20
> > >=20
> > > [Severity: High]
> > > Does this code break region auto-discovery on reboot for topologies
> > > containing a passthrough decoder?
> > >=20
> > > When cxld_set_interleave() configures a passthrough decoder, it now s=
ets
> > > eig =3D 0 (a don't-care value) in the hardware.
> > >=20
> > > Upon reboot, reading this hardware state will initialize the decoder's
> > > software interleave_granularity to a stale value.
> > >=20
> > > During auto-discovery in cxl_port_setup_targets(), the CXL_REGION_F_A=
UTO
> > > path skips validating the granularity for passthrough decoders (iw =
=3D=3D 1),
> > > but it appears to be missing an update to correct the software state:
> > >=20
> > > 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> > > 		if (cxld->interleave_ways !=3D iw ||
> > > 		    (iw > 1 && cxld->interleave_granularity !=3D ig) ||
> > > 		    !spa_maps_hpa(p, &cxld->hpa_range) ||
> > > 		    ((cxld->flags & CXL_DECODER_F_ENABLE) =3D=3D 0)) {
> > > 			...
> > > 			return -ENXIO;
> > > 		}
> > > 		/* missing update: cxld->interleave_granularity =3D ig; */
> > > 	}
> > >=20
> > > If cxld->interleave_granularity is not updated to the computed ig her=
e, won't
> > > any interleaving descendants read the stale parent_ig, compute a mism=
atched
> > > expected granularity, and fail validation?
> > >=20
> > > --=20
> > > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783795=
720.git.alison.schofield@intel.com?part=3D1 =20
> >  =20

