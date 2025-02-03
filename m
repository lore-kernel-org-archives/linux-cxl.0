Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C749D204C04
	for <linux-cxl@vger.kernel.org>; Mon,  3 Feb 2025 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.189.100.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738602711; cv=none; b=hcB65ZbHyWPAJFTcEsGqPAS6IzJgsWJuNZeUwnd077q8kjaWqqYIRoJ+yHWuY9A/+rgTgtOqZgPCrk+Fy/+7/AUPeur13gi6j+h+fBRa3GK3R/4JuEvk0IlnuJqvoWCJz0E9/QMquc4wzWp2WHhxyLwM2JRvTMn0piVJgfolqvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738602711; c=relaxed/simple;
	bh=XZfCb2+DRLMjOhNbi2CK0sEWR+uTBEmYAmpLkAjobac=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=OSsT56K3AbCGCvXrZY7V745PGF2sxtwAE75D/JcLLvYv+yYvSuwNetrKLcwsRmdf+Qa6hGgb7VzBmHbSctYJujpixSDtR1/RY/UNbBT5Kh+a/HvQimioGR/nteJ+kTfVmNwR9YZehrRqWk+LXTIrb7kFTRFOmt6NrqDQAt6Z1rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=d+HRWgqf; arc=none smtp.client-ip=211.189.100.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="d+HRWgqf"
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20250203170214usoutp02c0bc34a432bba144bf582982a2c20c64~gwW4Zqa490085200852usoutp02V;
	Mon,  3 Feb 2025 17:02:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20250203170214usoutp02c0bc34a432bba144bf582982a2c20c64~gwW4Zqa490085200852usoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738602134;
	bh=BwhtO6kqC+n300ONTIZajYEPaTqkPWvbhKnpHPc8Hss=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=d+HRWgqf7ag+0q1JyPHgyj8JCu6eEhan2a0kcspMHP4z8ZoC2yxDN/ZgmrDPV1M2s
	 57cpr9GHdYY/8x4Ve4LNUExGReP4ReuDY3I3UbrvT++0rVPEPLFx/WyJ2V5V4nH/fU
	 zMZaxs4tKXrNkL0XHOnm4SO3JgNtcdU+UECkbGvg=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
	[203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250203170214uscas1p2d4a4e2601743af20cc2bc2b3d535ac08~gwW4OaYWp1255112551uscas1p27;
	Mon,  3 Feb 2025 17:02:14 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
	ussmges1new.samsung.com (USCPEMTA) with SMTP id 35.DA.10915.696F0A76; Mon, 
	3 Feb 2025 12:02:14 -0500 (EST)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
	[203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250203170214uscas1p17bf09ddb3f8d1739befdb4c3017e736d~gwW333l2M1907919079uscas1p1H;
	Mon,  3 Feb 2025 17:02:14 +0000 (GMT)
X-AuditID: cbfec36d-f4dc370000002aa3-c1-67a0f69647dc
Received: from SSI-EX3.ssi.samsung.com ( [105.128.3.66]) by
	ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 7D.4E.23624.596F0A76; Mon, 
	3 Feb 2025 12:02:14 -0500 (EST)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
	SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2507.44; Mon, 3 Feb 2025 09:02:13 -0800
Received: from SSI-EX3.ssi.samsung.com ([105.128.8.30]) by
	SSI-EX3.ssi.samsung.com ([105.128.8.30]) with mapi id 15.01.2507.044; Mon, 3
	Feb 2025 09:02:13 -0800
From: Adam Manzanares <a.manzanares@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Vinayak Holikatti <vinayak.kh@samsung.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "krish.reddy@samsung.com"
	<krish.reddy@samsung.com>, "vishak.g@samsung.com" <vishak.g@samsung.com>,
	"alok.rathore@samsung.com" <alok.rathore@samsung.com>,
	"s5.kumari@samsung.com" <s5.kumari@samsung.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] hw/cxl/cxl-mailbox-utils: Add support for Media
 operations Sanitize and Write Zeros commands (8.2.9.9.5.3)
Thread-Topic: [PATCH 2/2] hw/cxl/cxl-mailbox-utils: Add support for Media
	operations Sanitize and Write Zeros commands (8.2.9.9.5.3)
Thread-Index: AQHbbVtToxMXh83zVkezCaraYyzDprMmkjIAgAtcIgCABBwTAIAAW7YA
Date: Mon, 3 Feb 2025 17:02:12 +0000
Message-ID: <Z6D2jT6lp6tABnDL@sjvm-adma01.eng.stellus.in>
In-Reply-To: <20250203113354.00007cd7@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <068AA8CEC92F2F4AB7AA2EBB86B249CB@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZduzrOd1p3xakG5ydI2exauE1Novzs06x
	WBzv3cHiwOzRcuQtq8eTa5uZPD5vkgtgjuKySUnNySxLLdK3S+DKuPT9AWPBYbGKn2ceMzUw
	vhPoYuTkkBAwkfg09zl7FyMXh5DASkaJ+1e3QzmtTBLLfz1hg6lq+/SbCcQWEljDKPH0iSZE
	0UdGiX9f17NBOIsZJa4dbAPrYBMwkPh9fCMziC0iYCTx7sYkRpAiZoF3TBKzbs9jAUkIC7Qy
	SnxYlQ+SEBFoY5Q4NPMJE0SHm8StX51gk1gEVCQW79oLdBQHB6+ApUT/KQeQMKeAocTxHdfA
	yhkFxCS+n1oDZjMLiEvcejKfCeJsQYlFs/cwQ9hiEv92PYR6R1Hi/veX7BD1OhILdn9ig7Dt
	JK7uvQ5la0ssW/garJcXaM7JmU9YIHolJQ6uuMECcrOEwBYOiW8vFzFCJFwkTv68CbVMWmL6
	mstQDfkSu9quQMUrJK6+7oY6wlpi4Z/1TBMYVWYhuXsWkptmIblpFpKbZiG5aQEj6ypG8dLi
	4tz01GLDvNRyveLE3OLSvHS95PzcTYzANHP63+HcHYw7bn3UO8TIxMF4iFGCg1lJhPf09gXp
	QrwpiZVVqUX58UWlOanFhxilOViUxHlVDrSmCwmkJ5akZqemFqQWwWSZODilGphsg/lrao2C
	TB7KSAsZlh63nfxfvJ6Hv4p1VtJt1XCvaYqHFjAIrnq5/sYD/Zsbb+f1Hqm+wfqy4AHbIl25
	nzMSmL5aOm122/9t+Sl2Q7+OVduiRNS6Vp+K3O15pIYp2Pneis1GBj68DIIb1y713SO+86L5
	GyanqYcljrQaZN+of7+8Yzd7x5yDVfXNypXGxtP97S9InmPMX8Sr1LyeXVdd5knNu6AlASk+
	zMqrXi/t4J274ZT79rTqrlTJzvcftnyMXDupw6XnzBUbvnMdGeKTJTc9UzaZknf6171WcVUV
	F/NHni0qSeuiQ26eDGHVeq3YwpVdIJhrV5X+4Z/cQgEx1meHeKSeLt3i06b7SImlOCPRUIu5
	qDgRAKSF4bGiAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsWS2cDspDvt24J0gzcL2CxWLbzGZnF+1ikW
	i+O9O1gcmD1ajrxl9XhybTOTx+dNcgHMUVw2Kak5mWWpRfp2CVwZl74/YCw4LFbx88xjpgbG
	dwJdjJwcEgImEm2ffjN1MXJxCAmsYpS4f3YyO0hCSOAjo8TibxIQicWMEpffdoMl2AQMJH4f
	38gMYosIGEm8uzGJEaSIWeANk8Tm73/BEsICrYwSH1blgyREBNoYJTZO/cEC0eEmcetXJxuI
	zSKgIrF4116gqRwcvAKWEv2nHCC27WeSePRtFtg2TgFDieM7rjGB2IwCYhLfT60Bs5kFxCVu
	PZnPBPGDgMSSPeeZIWxRiZeP/7FC2IoS97+/ZIeo15FYsPsTG4RtJ3F173UoW1ti2cLXYL28
	AoISJ2c+YYHolZQ4uOIGywRGiVlI1s1CMmoWklGzkIyahWTUAkbWVYzipcXFuekVxcZ5qeV6
	xYm5xaV56XrJ+bmbGIExevrf4ZgdjPdufdQ7xMjEwXiIUYKDWUmE9/T2BelCvCmJlVWpRfnx
	RaU5qcWHGKU5WJTEee8+0EgVEkhPLEnNTk0tSC2CyTJxcEo1MDGekT7QpLJ66rlpZxOKOwy6
	nT/GujH6OFsJrFENnr9ZN9p6S2YR59vgdxYGz4WnJZbMiv/pE/LInnH/48AvnHv8nzsePBbF
	VBzkF1CewTBFutt73yKHpxu/nH4aZzvx3Q5eZacbH6SVdR+Wswu0/Z385e8U9f0ud/f9vCxs
	qt99ryH60SmFYlf1KjudKXI9v9RF309wfJ9g4SH4fu706M339HKf7JY9Kn1nn9Xp96fc3paL
	Xaw+KGy7MeOikrcu8+oT6x6rh+3pW8z/oa6Cw6D5RkBg+31uzivLta1fuB79c/HC+vtqHx/P
	viowr4VJ6fXTFyFO7xce/2C8g+mp7AyWRgWpjbUSXK99hQwlqpVYijMSDbWYi4oTAbZyB+hA
	AwAA
X-CMS-MailID: 20250203170214uscas1p17bf09ddb3f8d1739befdb4c3017e736d
CMS-TYPE: 301P
X-CMS-RootMailID: 20250123050913epcas5p45fb9a638e62f436076da283e86e54ea2
References: <20250123050903.92336-1-vinayak.kh@samsung.com>
	<CGME20250123050913epcas5p45fb9a638e62f436076da283e86e54ea2@epcas5p4.samsung.com>
	<20250123050903.92336-3-vinayak.kh@samsung.com>
	<20250124151946.0000134f@huawei.com>
	<Z503EpvqMczHIZqF@sjvm-adma01.eng.stellus.in>
	<20250203113354.00007cd7@huawei.com>

On Mon, Feb 03, 2025 at 11:33:54AM +0000, Jonathan Cameron wrote:
>=20
> > >  =20
> > > > +    int dpa_range_count =3D san_info->dpa_range_count;
> > > > +    int rc =3D 0;
> > > > +
> > > > +    for (int i =3D 0; i < dpa_range_count; i++) {
> > > > +        rc =3D sanitize_range(ct3d, san_info->dpa_range_list[i].st=
arting_dpa,
> > > > +                san_info->dpa_range_list[i].length, san_info->fill=
_value);
> > > > +        if (rc) {
> > > > +            goto exit;
> > > > +        }
> > > > +    }
> > > > +    cxl_discard_all_event_records(&ct3d->cxl_dstate); =20
> > >=20
> > > Add a comment on why we are deleting event records when sanitizing a =
small
> > > part of memory?
> > >  =20
> >=20
> > See response below for disabling the media state. Same section referenc=
ed
> > below, 8.2.10.9.5.1 states all event logs should be deleted. Outcome
> > depends on how we interpret "follow the method described in 8.2.10.9.5.=
1".
> >=20
>=20
> This also sounds like reading too much into that comment.
>

Agreed, Vinayak let's drop the discard of all event records
from this patch.

> > > > +    }
> > > > +
> > > > +start_bg:
> > > > +    /* EBUSY other bg cmds as of now */
> > > > +    cci->bg.runtime =3D secs * 1000UL;
> > > > +    *len_out =3D 0;
> > > > +    /* sanitize when done */
> > > > +    cxl_dev_disable_media(&ct3d->cxl_dstate); =20
> > > Why?  This is santizing part of the device. As I undestand it the
> > > main aim is to offload cleanup when the device is in use. Definitely
> > > don't want to disable media.  If I'm missing a reason please give
> > > a spec reference. =20
> >=20
> > Table 8-164, sanitize description mentions to follow method
> > in 8.2.10.9.5.1, which does call out placing device in disabled
> > state, but I'm not sure if method refers to all text in 8.2.10.9.5.1
> > or the method devices uses to sanitize internally.
>=20
> I think it is meant to just be the method of sanitizing.=20
>=20

Ok, let's use this interpretation. Vinayak, can you remove this as well
and then we put a comment in the patch that media op sanitize is targeted=20
so no need to disable media or clear event logs.


> >=20
> > I would imagine since sanitize is destructive we would not want to retu=
rn=20
> > any data from device ranges impacted by sanitize. I believe a simple
> > way to achieve this is to disable entire device.=20
>=20
> Hmm.  That rather destroys the main use case I'm aware of for this
> (unlike the general santize commands from earlier CXL versions)/
> Superficially sounds like we need a spec clarification as
> clearly not super clear!
>=20

For this series, let's drive the work with the use case you have in
mind. We will start a thread with the consortium, but I don't think
that should delay this work.

> >=20
>=20
> Jonathan
>=20
> =
