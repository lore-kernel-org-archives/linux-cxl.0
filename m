Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2643ACF0B;
	Wed,  9 Sep 2026 19:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981095; cv=none; b=RXudwOKK8Huvm4xviTvv92blQOvV49ti4HbK36GJ8yojF2yuqhSH/Wv8fpkhsJtZs9v4V2sb0FLbqRCKGARn6yTE67+Sq0pDXYRNPdkTw1c1HE8GAC/hG1FqCnuxNnHJnPNrcmgMDwGsE7WsuC1iwdFcYlHFDq4wF/fVsWMmPQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981095; c=relaxed/simple;
	bh=ibMGoZNFVcERL68F6QE3UT1XnEua4MeDZrrFkasR/M0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7+lczvpphPf21GdyozBaNwyymI9XmJMFuBdElJZp6OXLu2a17b8OfIXmyAFX8wBBl3Lj0/IsceTw2mevyrp5ZsgxZX1Fl1uZd4uw0a+UYs1NItEg8Mu07BWGiJ5+f7mVo/FxGz5bVGF0hvcP898cB8nIiy1ffnD5qFoBK4SjH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+hkhVly; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+hkhVly"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B731F000FF;
	Wed,  9 Sep 2026 19:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788981092;
	bh=YrVzVZFAj9c+kcR8ihQIElO4jyvfEdwPLoLRmPTnBUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=O+hkhVlyjoV8DOkR2ZAwgJx0L7Peef5U/bwWbqjnDRVO3wbBKQeLxgeOU5BzdUgFq
	 j6zHQkqUxn+v1Ra4FTCz7REcg9+HxGqWj/9o2kT8+PiKl4mp6HmpS1bKDcm3yKfIK+
	 EusHsD6RaK0zQeRvq2cEsBYXd8tfF/GbcZQSlA7RqVT9TA3tY9q5ZdHlH5CQ54FArD
	 lC+upPE1mdfV0mzcs4UzBI/ixJjc0Uu2DggmKuaqdOAPZg/tgh4LFufwh6e5Dm51nT
	 BrZeqa8HRREen3UBlGVg/mVprCS17n3ffqoxiTe0Mk2H3RX1/EpqsMPuMIe1nlnq9o
	 f2R3CPYXwSvOA==
Date: Wed, 9 Sep 2026 20:11:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Li Ming <ming.li@zohomail.com>
Cc: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
 <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Dan
 Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/events: Return IRQ_NONE when no event is pending
Message-ID: <20260909201126.091cc7f0@jic23-hlaptop>
In-Reply-To: <fc844c0b-e429-4c0d-9113-35a1635c03a3@zohomail.com>
References: <20260906155705.13252-1-shaikhkamal2012@gmail.com>
	<20260907194824.615e47ff@jic23-huawei>
	<fc844c0b-e429-4c0d-9113-35a1635c03a3@zohomail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Sep 2026 10:08:14 +0800
Li Ming <ming.li@zohomail.com> wrote:

> =E5=9C=A8 2026/9/8 02:48, Jonathan Cameron =E5=86=99=E9=81=93:
> > On Sun,  6 Sep 2026 21:27:05 +0530
> > Shaikh Kamaluddin <shaikhkamal2012@gmail.com> wrote:
> > =20
> >> CXL event interrupts may share an MSI/MSI-X vector with other event
> >> logs or device features. Consequently, cxl_event_thread() is registered
> >> with IRQF_SHARED and must determine whether an interrupt belongs to the
> >> event-log facility.
> >>
> >> The handler masks the Device Event Status register to the event logs
> >> supported by the driver. However, when no supported status bit is set,
> >> it exits the processing loop and still returns IRQ_HANDLED.
> >>
> >> Track whether at least one supported event status bit was observed.
> >> Return IRQ_NONE when there was no event to service, while continuing to
> >> return IRQ_HANDLED after processing one or more event logs. =20
> > What is the practical result of this change?
> > I think it will only affect the spurious interrupt detection so
> > to me it looks like a cleanup rather than a fix.  Is there
> > any path by which we actually lose interrupts as a result of this?
> > =20
> >> Fixes: a49aa8141b65 ("cxl/mem: Wire up event interrupts")
> >> =20
> > No blank lines in tag blocks.  There are a number of tools that rely
> > on there not being any and as such there are also scripts that run
> > on various upstream trees that will send us annoying emails if this
> > blank line is still here!  I'm not sure why this mistake in patch
> > formatting is so common as there are plenty of docs without the
> > blank lines!
> > =20
> >> Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com> =20
> > A suggestion for an alternative implementation below.
> > =20
> >> ---
> >>   drivers/cxl/pci.c | 5 ++++-
> >>   1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> >> index c7c91e8dc51d..8b560cae91f2 100644
> >> --- a/drivers/cxl/pci.c
> >> +++ b/drivers/cxl/pci.c
> >> @@ -515,6 +515,7 @@ static irqreturn_t cxl_event_thread(int irq, void =
*id)
> >>   	struct cxl_dev_id *dev_id =3D id;
> >>   	struct cxl_dev_state *cxlds =3D dev_id->cxlds;
> >>   	struct cxl_memdev_state *mds =3D to_cxl_memdev_state(cxlds);
> >> +	bool handled =3D false;
> >>   	u32 status;
> >>  =20
> >>   	do {
> >> @@ -527,11 +528,13 @@ static irqreturn_t cxl_event_thread(int irq, voi=
d *id)
> >>   		status &=3D CXLDEV_EVENT_STATUS_ALL;
> >>   		if (!status) =20
> > 			return IRQ_NONE;
> >
> > And don't need the other changes. =20
>=20
> Hi Jonathan,
>=20
>=20
> I think we should not return IRQ_NONE here, because the loop could run=20
> multiple times untill no event record, so we always get a status with=20
> 0x0 value in the last loop. In that case, we still need to return=20
> IRQ_HANDLED.

Ah excellent point.  Ignore me.  Any dance to return here needs
a handled variable to be checked so ends up just being moving the
return.  Maybe that's worth doing but not important.

Jonathan

>=20
>=20
> Ming
>=20
> > =20
> >>   			break;
> >> +
> >> +		handled =3D true;
> >>   		cxl_mem_get_event_records(mds, status);
> >>   		cond_resched();
> >>   	} while (status);
> >>  =20
> >> -	return IRQ_HANDLED;
> >> +	return handled ? IRQ_HANDLED : IRQ_NONE;
> >>   }
> >>  =20
> >>   static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
> >>
> >> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
> >> prerequisite-patch-id: 92e40cd60a697020faac475dcc77ba63b33434ea
> >> prerequisite-patch-id: 10027ad5d9aed85806047f807b3a76273b6c4a77 =20

