Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C163A3E9A;
	Mon, 28 Sep 2026 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617403; cv=none; b=mHVYaemzEEVgd5/vuFBW5ZaywA7TvYtyYO2yqwENGJZ9C8zxFiJb9TC5BFlpHrgGSUpYCUp+3tDKI/SUiPXzGGdIdq+OqbgliN1wUWILB+ptPne6MJcE4DTX7qnvVBJum497k728l7iC5NNq+8EqJLVO9uEdxQLduBt+CKGdPXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617403; c=relaxed/simple;
	bh=ryb09pFPeF7Togyu5rRGmyyzNr+3gn9WfSykpvsACBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uVS3VKFpDmcAgBnzE5uLrRNNDYgIPTObc+/GlNWs+PE1Ib4M7Nj/6+z/tS8me3KYyRqkNY6LAN0S8CJW38Wu+vKie1Qw7KeCLu17t4YkLwYowuZfee1WyorSGBzCwXn4/k67n5ob3ywUx7bJHqsLlVEYDUZzNrERAy9cpqBb6JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDZaOmmx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDZaOmmx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7931F00898;
	Mon, 28 Sep 2026 17:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790617402;
	bh=NibMVE7Rbn2cdnnpH1xf5xfPMGYhh0V3wESIcQR4aeo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YDZaOmmxHJXOWadrXzSHq/NQ/dFDVhU5C7NAIXSJhc2bQw0sYfa6SBvN06c0mAVVv
	 CJxyZee1xtwuTOmqYBArhJd1BMk/Gppm/hpRzQXMwQuR1M2Dzu9MfvGoEnJclIfo8i
	 huXHCrDypq7pbOfVivklwZVeLm/RIM3YEJISTqSQFqyRUjTZnlfq4P6kZOPgY4ePL2
	 Z1MgMcMUvAnNalNF9vKMr/2ecIxIuLLeogTTdRtfFLHU4HGZ/eYR5MXVR9AteFHdxE
	 r3ewUNRtIFz9kRKumZS74j3UDVgZUS7lydu83Us71rYCtW2q3gDNuKjixKTMlg+cRY
	 KmzghmITPakHw==
Date: Mon, 28 Sep 2026 18:43:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: Richard Cheng <icheng@nvidia.com>, "Lucero Palau, Alejandro"
 <alejandro.lucero-palau@amd.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>, "alison.schofield@intel.com"
 <alison.schofield@intel.com>, "vishal.l.verma@intel.com"
 <vishal.l.verma@intel.com>, "djbw@kernel.org" <djbw@kernel.org>,
 "iweiny@kernel.org" <iweiny@kernel.org>, "ming.li@zohomail.com"
 <ming.li@zohomail.com>, "gourry@gourry.net" <gourry@gourry.net>,
 "rrichter@amd.com" <rrichter@amd.com>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Newton Liu <newtonl@nvidia.com>, Kristin
 Chuang <kristinc@nvidia.com>, Kai-Heng Feng <kaihengf@nvidia.com>, Koba Ko
 <kobak@nvidia.com>
Subject: Re: [RFC PATCH 0/3] cxl: Auto-create a region for Type-2 memdev
 attach
Message-ID: <20260928184315.05038feb@jic23-hlaptop>
In-Reply-To: <SAWPR12MB9992678E92777730BE483F6511B08D2@SAWPR12MB999267.namprd12.prod.outlook.com>
References: <20260805074042.30173-1-icheng@nvidia.com>
	<a3978557-59d5-49bc-bdb3-9ef2dfa025d3@amd.com>
	<aobIoBYBACGlJ-OD@MWDK4CY14F>
	<53689d31-3707-4c15-9eb9-eb6c77ab3ca0@amd.com>
	<apU6tyyxSIGvzSs6@MWDK4CY14F>
	<20260922022518.1002b083@jic23-hlaptop>
	<SAWPR12MB9992678E92777730BE483F6511B08D2@SAWPR12MB999267.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Sep 2026 05:37:45 +0000
Ankit Agrawal <ankita@nvidia.com> wrote:

> >> >=20
> >> >=20
> >> > <snip> =20
> >> > > I think you are right that this RFC doesn't currently have a produ=
ction platform
> >> > > where the system FW publishes a Type-2 CFMWS but leaves the EP dec=
oder
> >> > > uncommitted.
> >> > >=20
> >> > > However, the config appears to be permitted by the CXL model. A CF=
MWS describes
> >> > > a FW-established root HPA window and the restrictions governing it=
s use,
> >> > > including Type-2 v.s. Type-3 and volatile v.s. PMEM. The CFMWS def=
 also
> >> > > describes OSPM assigning HPA ranges from those windows to discover=
ed CXL.mem
> >> > > devices [1].=C2=A0  =20
> >> >=20
> >> >=20
> >> > Right. I'm not saying this should not be supported, just pointing ou=
t the
> >> > use case does not make sense with current BIOS functionality. I thin=
k BIOS
> >> > will/could support a config option for just leaving a Type2 HDM unco=
mmitted,
> >> > but then why the kernel should do the same a default BIOS config wou=
ld do?
> >> >=C2=A0  =20
> >>=20
> >> Agreed. The kernel shouldn't recreate the config that BIOS would norma=
lly provide. =20
> >
> > I'm a bit lost. Both BIOS doing nothing beyond cfmws as a design decisi=
on and
> > hotplug (where bios isn't in the loop) require this sort of flow.
> >
> > Sure both might not be what you happen to have today but they are both
> > very much real usecases!
> >
> > Jonathan =20
>=20
> So, can we consider doing both in 2 phases..
> 1. Autocreate a default region that is sized to the device's DVSEC report=
ed
> DPA capacity when the platform signals it (applicable only to CFMWS prese=
nt
> Type-2 CXL.mem-capable, decoder uncommitted case?). I suppose this could
> cover the use cases suggested by Jonathan?
> 2. Let the driver explicitly replace/override it with a different sized r=
egion
> once bound per its own policy.

I don't see a reason for 1.  The bios has to have provided a CFMWS that will
work or option 2 will fail - if it supports hotplug or indeed doesn't want =
to
do config of devices on cold plug it just provides 'enough space'.  Whether=
 it
does that by hard coded big number, bios menu option or otherwise doesn't
matter to us.

But in general a driver should bind before we create anything (assuming we
are in a host OS managed flow).  Why would we want to do anything before th=
at
as we have no idea if a driver will ever bind - or if there is flexibility
in size exposed that can't be known until driver bind.

>=20
> >> And that's why I think we should move region createion out of devm_cxl=
_probe_mem().
> >> That helper should discover and attach to an already committed region.
> >>=20
> >> If FW leaves the decoders unconfigured intentionally , a driver may ex=
plicitly request a region
> >> and provide the size it needs.
> >>=20
> >> In my mind the new model should be
> >> - FW-committed config is only discovered and attached
> >> - an uncommitted config remains untouched unless a driver explicitly r=
equests it
> >> - CXL core supplieds the allocation, validation, programming, accounti=
ng and teardown mechnism
> >> - the requesting driver owns the policy and the use of the region =20
>=20
> Is there going to be a custom non-default size to commit be communicated
> to the vendor driver? AIU currently the size is only driver-internal cons=
tant.

Given it is potentially a contended resource, we may need a way to clamp
the maximum a particular instances is allowed to request. For now maybe
first come, first served is good enough? No idea.=20

Jonathan

>=20
> Thanks
> Ankit Agrawal

