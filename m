Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606DBCA6B
	for <linux-cxl@vger.kernel.org>; Fri, 21 Aug 2026 20:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787344534; cv=none; b=aA7nfTV3qVgFcwirZ6QIExxTzyq1HABW+/3e7DfmdtXrjEr2zUdphodmB0cAJR8/+8YCP30DDDv75zfqoT72kBl0Yl6GvyJQhgFX6okEGvq/kv0t3maXpPNctCFOLLx//pWrUjqPrZ9ZcnneQGR3OUQV4etIewO4tMV+se508Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787344534; c=relaxed/simple;
	bh=c8YSQWWf1Yunx2MDjBIwuxsRcBHyPsU+f9VtffZFmNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQ8JL9w9A1gqyQYcn0nSVvQ/nWlFrXFXTpPHxz6xAcQBgJ/HfmQaDUSMoR6L2lfA/2xmX4I0q5jD2P9uViqIWxchefbTjOlvYn4A6oFWrZVpntKD7pKjn/FA+lV+9Q/USAAagyBZi1nzQGMagwuOvnpGaLiSPwrP6YpcsC8kYxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDA9ExHk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDA9ExHk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9C41F000E9;
	Fri, 21 Aug 2026 20:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787344533;
	bh=O44QXNGAhxvmCWDCqnYLN+9K78qtJVxhHIxbgk0SYrk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XDA9ExHkultZFrOgBASHm+bys799ugAZm8T+rT8ntYerQW6XNnauVyY70GqrZCX+V
	 9DcGypmYjQcZT92NJUc8BN7NhudrxQtG3ezy6dGimUEs+5SMjwcUB7f/Mfk77A19gN
	 HBvqdQzC3V82Q95QmnZE+4+YTUJ3kWxcOCI0l4Eo9yZK/SjruGBozYs602DLUPcMQo
	 Sz2dZXR3+X8zPGcJi34o/qkomUuRNuG3lUSiZ+uS6guNuBaVAxpJ6KluB6OOxBVvVy
	 QQqThhRJayP6YrF1TQ1F0NSBB1bBK2dCnyeOAdD6Gg5KGxWE1nIAry54eDtsll6y1a
	 k7CE765efrsEQ==
Date: Fri, 21 Aug 2026 21:35:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 6/6] Documentation/cxl: Describe mixed-granularity
 regions
Message-ID: <20260821213527.48d71a39@jic23-huawei>
In-Reply-To: <3ad2df22dacea3cbd58a3ca2732003e120605277.1787255388.git.alison.schofield@intel.com>
References: <cover.1787255388.git.alison.schofield@intel.com>
	<3ad2df22dacea3cbd58a3ca2732003e120605277.1787255388.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Aug 2026 16:31:24 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

Hi Alison,

Can we pull this up to be at top of patch set?  People really need
to read this first, so make that easy!

> Mixed-granularity region support introduces interleave relationships
> that are not obvious from the existing CXL documentation. This is
> particularly true for the 3-, 6-, and 12-way configurations and for
> understanding which configurations permitted by the CXL Specification
> are supported by Linux.
>=20
> Document the mixed-granularity model and Linux's coarse-to-fine
> restriction. Include the relevant configurations from CXL 4.0 Section
> 9.13.1.1 and annotate their Linux support status.
>=20
> This intentionally repeats information from the CXL Specification.
> The specification remains authoritative, but showing the Linux support
> policy alongside the legal configurations ensures readers do not
> mistake an unsupported Linux setup for a configuration unsupported by
> the CXL Specification.
>=20
> Assisted-by: Claude:Opus-5
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

My biggest queries are:
- Naming.  bike shed time :)  I think this evolved to point where 'mixed'
  no longer describes what is being built. I'm not sure what is mixed.

- Are we sure people are doing coarse to fine?
  They might be - I remember a discussion with Dan way back where I was
  arguing that was the natural way round, but he convinced me that fine
  as fast as possible made more sense, as about spreading larger hotspots
  and linear accesses onto as many paths as possible as quickly as
  possible.

  Given the reason to do this is either a hardware restriction, or non
  power of 2, going fine as fast as possible may still make sense.

Honestly I don't (I think) have any skin in the game here so if this
works for you I am fine with restricting things - as long as we make
it even clearer what is going on!

> ---
>  .../driver-api/cxl/linux/cxl-driver.rst       | 135 ++++++++++++++++++
>  1 file changed, 135 insertions(+)
>=20
> diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Document=
ation/driver-api/cxl/linux/cxl-driver.rst
> index dd6dd17dc536..4e56c18294ef 100644
> --- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
> +++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
> @@ -602,6 +602,11 @@ derived from their upstream port connections. In `Cr=
oss-Link First` interleave
>  configurations, the :code:`interleave_granularity` of a decoder is equal=
 to
>  :code:`parent_interleave_granularity * parent_interleave_ways`.
> =20
> +When the region granularity is finer than the granularity of an interlea=
ving
> +root decoder, the relation inverts: the :code:`interleave_granularity` o=
f a
> +decoder is equal to :code:`parent_interleave_granularity / interleave_wa=
ys`.
> +See `Mixed Granularity`_.
> +
>  At Endpoint
>  ~~~~~~~~~~~
>  `Endpoint Decoders` are programmed similar to Host Bridge and Switch dec=
oders,
> @@ -619,6 +624,136 @@ from HPA to DPA.  This is why they must be aware of=
 the entire interleave set.
>  Linux does not support unbalanced interleave configurations.  As a resul=
t, all
>  endpoints in an interleave set must have the same ways and granularity.
> =20
> +Mixed Granularity
> +~~~~~~~~~~~~~~~~~

My main question here is why are we calling them mixed?
=46rom that name I was assuming we were doing

Root 4K
HB   1K
Sw   2K

Where the granularity isn't monotonic.

> +Every decoder advances one target every multiple of its own granularity,=
 and
> +the decoders below it subdivide the span their parent assigns to a single
> +target.  Linux supports two orderings of granularity down the hierarchy.
> +
> +The `Cross-Link First` example above shows the first ordering, where the=
 region
> +granularity equals the granularity of the root decoder and granularity c=
oarsens
> +toward the endpoints.  In the second ordering the region granularity is =
finer
> +than the root decoder's and granularity refines toward the endpoints, re=
aching
> +the region granularity at the innermost interleaving decoder.  A region =
using
> +that ordering is a *mixed-granularity* region.  A mixed-granularity regi=
on
> +requires an interleaving root decoder.
> +
> +Linux supports only monotonic granularity hierarchies, either coarsening=
 or
> +refining from the root toward the endpoints.  The CXL Specification does=
 not
> +require a monotonic ordering, see `Mod3 Interleave Configurations`_.
> +
> +For an 8-way mixed-granularity region below a 2-way interleaving root de=
coder
> +at 4096, where each host bridge routes through two levels of switch, Lin=
ux
> +programs::
> +
> +  Level             Ways    Granularity
> +  -----             ----    -----------
> +  Root                 2         4096
> +  Host bridge          1         4096
> +  Upper switch         2         2048
> +  Lower switch         2         1024
> +  Endpoint             8         1024

Given multi switch restrictions, why not just do one level and make the
host bridge do 2 way interleave (to two RPs each of which has a switch belo=
w)

I don't think that changes the logic, but it reflects more standard
CXL topology (if no PBR fun involved)


> +
> +Each decoder contributes to an endpoint's region position in proportion =
to its
> +granularity::
> +
> +  position +=3D target_position *
> +              decoder_granularity / region_granularity
> +
> +The root above selects a host bridge every 4096 bytes, so it advances one
> +target every four region positions, while the lower switch advances one =
target
> +every position.  When the region granularity equals the root granularity=
, the
> +root advances one target per region position and each level's weight is =
the
> +number of ways below it.
> +
> +The ways and granularity of a mixed-granularity region must describe the=
 same
> +interleave span as the root decoder::
> +
> +  root_ways * root_granularity =3D=3D region_ways * region_granularity
> +
> +A region that does not describe that span either leaves part of the range
> +unclaimed or reaches beyond it, and Linux rejects it.  A same-granularity
> +region below a power-of-two root decoder spans a multiple of the root's =
range
> +rather than one target's share of it, and is not subject to this relatio=
nship.
> +
> +Mod3 Interleave Configurations
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +A 3-way, 6-way, or 12-way interleave, known as a Mod3 interleave, select=
s its
> +target with a factor-of-three selection rather than from binary interlea=
ve
> +selector bits alone.  CXL 4.0 Section 9.13.1.1 defines the 3-way selecti=
on as
> +the address above the decoder granularity taken modulo 3.  A 6-way selec=
tion
> +claims one binary HPA bit at the decoder granularity and takes the modul=
o 3 of
> +the address above that bit, and a 12-way selection claims two.
> +
> +The factor-of-three selection is not an additional binary selector bit, =
so a
> +Mod3 interleave distributes across the hierarchy as::
> +
> +  3  =3D 3
> +  6  =3D 3 * 2
> +  12 =3D 3 * 4
> +
> +The cross-host bridge selection carries the factor of three, and the rem=
aining
> +x2 or x4 is binary interleave selection below it.  A 6-way region at IGB=
 across
> +three host bridges is therefore::
> +
> +  Device-level region:   6-way @ IGB
> +  Cross-host bridge:     3-way @ 2*IGB
> +  Below the root:        2-way @ IGB
> +
> +where both levels describe the same interleave span::
> +
> +  3 * (2 * IGB) =3D=3D 6 * IGB
> +
> +The CXL Specification defines the legal Mod3 compositions and is normati=
ve.
> +CXL 4.0 Section 9.13.1.1, "Legal Interleaving Configurations: 12-way, 6-=
way,
> +and 3-way", Tables 9-6, 9-7, and 9-8 list them for a 12-way, 6-way, and =
3-way
> +device-level interleave at IGB.  Those tables are summarized below, anno=
tated
> +with the subset Linux supports.
> +
> +CXL 4.0 Table 9-8, 3-way device-level interleave at IGB::
> +
> +  Row  Cross-host bridge  Host bridge    Switch         Linux
> +  ---  -----------------  -----------    ------         -----
> +   1   3-way @ IGB        none           none           supported
> +
> +CXL 4.0 Table 9-7, 6-way device-level interleave at IGB::
> +
> +  Row  Cross-host bridge  Host bridge    Switch         Linux
> +  ---  -----------------  -----------    ------         -----
> +   1   6-way @ IGB        none           none           supported
> +   2   3-way @ 2*IGB      2-way @ IGB    none           supported
> +   3   3-way @ 2*IGB      none           2-way @ IGB    supported
> +
> +CXL 4.0 Table 9-6, 12-way device-level interleave at IGB::
> +
> +  Row  Cross-host bridge  Host bridge    Switch         Linux
> +  ---  -----------------  -----------    ------         -----
> +   1   12-way @ IGB       none           none           supported
> +   2   6-way @ 2*IGB      2-way @ IGB    none           supported
> +   3   6-way @ 2*IGB      none           2-way @ IGB    supported
> +   4   3-way @ 4*IGB      4-way @ IGB    none           supported
> +   5   3-way @ 4*IGB      none           4-way @ IGB    supported
> +   6   3-way @ 4*IGB      2-way @ IGB    2-way @ 2*IGB  unsupported
> +   7   3-way @ 4*IGB      2-way @ 2*IGB  2-way @ IGB    supported
> +
> +Table 9-6 row 6 is legal per the CXL Specification and unsupported by Li=
nux.

but is unsupported by Linux.
(perhaps clearer?)

> +Walking it from the root toward the endpoints, granularity goes::
> +
> +  4*IGB -> IGB -> 2*IGB
> +
> +which refines and then coarsens.  Row 7 interleaves the same 12 endpoint=
s at
> +the same granularity with those two levels exchanged::
> +
> +  4*IGB -> 2*IGB -> IGB
> +
> +which is monotonic.  Linux programs row 7 for a user region and assemble=
s an
> +auto region whose decoders are programmed that way.  An auto region matc=
hing
> +row 6 is not assembled.
> +
> +Leaving row 6 unsupported does not prevent a 12-way device-level interle=
ave.
> +The specification defines six other legal compositions, all monotonic and
> +supported by Linux.

Silly question - does anyone actually care about 12 way? :)  This would all
be much easier without it.

> +
>  Example Configurations
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  .. toctree::

