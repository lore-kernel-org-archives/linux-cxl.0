Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A8A35C193;
	Mon, 13 Jul 2026 23:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783985864; cv=none; b=kuewJVHtB8zSLuGb/4sVNzX4U3VAKjHKhqKprQ5lqY9kXw1H/37GA/kxa3SRGqSIf3xdH9j7G9fgLtPpS5aaI6CNIKrBYNZ2U8T5p6nIO0FEJS8Uq/WVLuIedlhGIwGiEoPO3TYmim5dbKJoPjSE8wL3NTDwMjIZLlicoPqy1rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783985864; c=relaxed/simple;
	bh=nzmqcvHtzlfyNgIdbNSmfa7GD/3tkvZtSUeAK2xyOsk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=goCtwoFB2JaTf8CKyp3VPVMEwsa8HqwJO0f2Zgd76vpSh4/yIqvc68Y0qYnwnklLB1IUDgnrNHSqPABKJiGYmr9oyqyPA5Oeqj++NF8p8xI8kEKi1tBqUioSm21X69lZYiSGOUfwin7kFovnjWTkir3BeQc8vFjSMxoJ3n9hFJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=SRay9pS1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XdA3khTG; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="SRay9pS1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XdA3khTG"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7F0117A0116;
	Mon, 13 Jul 2026 19:37:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 13 Jul 2026 19:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783985859;
	 x=1784072259; bh=hfaitaNnjEf6rqXv+1vAtt6Mfbk8w+tp59BoL8YIQZg=; b=
	SRay9pS1t+MWuUKlrcj8xke1VSLP4EvKZ9vsZBtr8wQv+CWhwOsotbXUjR5ge4Ju
	a65m5LTAWipR8cv0TRrlG46j62T8qz8H0qms0kRcAM/4l4XQDZJdUpPnPZGBe7f1
	N9VjVmLhmT7SgCbh1Lf3jYq7UrTqBY3RjvFp76R6koRqxpooZlDY2zerPi/dm8IM
	Rfer6dufhomrdZ2Y2j9Kvzym++I5h/VhFUQxeQ00tjIfsd9AhTQ4lCi6uYU+vXC0
	DNZrd8RdBAM5B3+r6L8ZhLVmBexADjH5gax7IHy2vfSW0xWGcHlUFbA0MALT82XV
	g1zP5s1v6OFUwSOl+hEtQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783985859; x=
	1784072259; bh=hfaitaNnjEf6rqXv+1vAtt6Mfbk8w+tp59BoL8YIQZg=; b=X
	dA3khTGa1IE0Q5asqxHVIBc4mmX8iRqva4WvROY/uAmRsQ5POynIAJqm5NXUYkOZ
	b+wDA+VK1fd6bCjAd0vXsxyiBjReHjyqYrttVi+GNSJwjbAeI8L5qUbfOme2KeZA
	e4Z+djv1rVgh8Sw3rQ0swZWLLZz6+eBqMuvhFoTYSeAqFF/HrDAG7BWo8KBGqd3G
	IFeK4KJ6ewZNAZP5N20F/VFaFHYzQMLSIoG+pZiDHSXJ9uBFvkcoRq4UVEwsJZih
	iG86+JrR3H/EcnA+GSh4y7VgYRN7h2ftdaTBhcJABRCKguuGlgfIzyKGmjbMFq2A
	icmrSapw30KzuPqtaxlMA==
X-ME-Sender: <xms:wnZVap__XDov-SZJ86-0GWacm1LBJl9Gi8l8G4xuk5RIQaCEkj-Q5w>
    <xme:wnZVaq4HDgYSTs9_kzrDhkyCmGxEHGNJfYrsudd7RiAt6GNG0EEnlyMN-8Tzc5YwC
    lcWmJQRdkxjHMlKqhWelq4_5GwCzutZT8hfuGXxgvAPCB5BSviG>
X-ME-Received: <xmr:wnZVargR_x7qFF8w60yD564XP0mXUirf337C9gcqz8hLqy7jsxOfeyrFMg0>
X-ME-Proxy-Cause: dmFkZTGFOIUmX0QZz6a3YffLfc012wxaz6+SzFx8zgoMAEVEw426WACURyYV4j6lUaUfCj
    6lXuZNlomwm6GJy9NLvq++SZgqlXuNbCB2o5G07uzK+pUY4Eg1NE6cpC9dCIxfO0z4ydkV
    N0OWYSF0J2BRPOiIwa7ji1bnjeMDclHZVua0PCZzRC4tPvPRrtAFKges7mmvNYhS/otsjP
    Yj5ZLDG6oH4hdKj7hSHQdfQKJLmUgCK9pY5m2MbloA0pqYyixNNw+Qsc8N3IC4q9uoFhQO
    BoDWYHBr0BVdT1DSDaQe0da06aDPIsWoXuvutSyVJwY0x59hEtfYML7XeDaujCORNdY/Jx
    QbScP9hzcIntUC/0bLb3/HT5tTLVdF7ZLvB220tqRRjlDibwMnayQ+uCbw4atxe2jrPczX
    sHYun6h2RfA8ttJnuh3KhP1FppKkv/PCQlHuAN5NO9nE1k7VHEsQMjTlEg4j6Dv/1vClyM
    2S18099asPYSNDZmTd20zXlWKz+5mj6f923tNbBK8N2Cn4AO/lCiG4LZSa/lGEQdSp8ju/
    02d+CN9mBEIUzotdg9lanpqZMbqOJv8UB9Mn9gR3wUdrbrGEaRubuApgdtXVgwFXnj8Ieo
    fautHEJubGwrXBKYIPIvibvtIrrGXIWKFw4MszdXTjMRt9WJnAqfWUodh14A
X-ME-Proxy: <xmx:wnZVapri7lfez_yCCKAO11BDXkDNXCTs-IJhSwxrdD-WyoXNXfkvaw>
    <xmx:wnZVavK8BuncSst8lSPKpxeHQRnjdxdeFXL11iPfMUPnEfBYF1AdxA>
    <xmx:wnZVauuFyRb1pMLGBuIZImckHSGU1lL5JImPfXADUi_PNXV24pmHTQ>
    <xmx:wnZVanvDvc4HuG_gENFAAEMbhgTJDyiJyttKte0gMHb_BEOP9CE3_A>
    <xmx:w3ZVaheb7AY1p-2SOCKkhU1pFyRDOzXIfVvV4mj9DCDHP_Rc1nOh0y9f>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 19:37:34 -0400 (EDT)
Date: Mon, 13 Jul 2026 17:37:30 -0600
From: Alex Williamson <alex@shazbot.org>
To: Manish Honap <mhonap@nvidia.com>
Cc: "djbw@kernel.org" <djbw@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "jic23@kernel.org" <jic23@kernel.org>, "dave.jiang@intel.com"
 <dave.jiang@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 "alejandro.lucero-palau@amd.com" <alejandro.lucero-palau@amd.com>,
 "alison.schofield@intel.com" <alison.schofield@intel.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>, "dmatlack@google.com"
 <dmatlack@google.com>, "gourry@gourry.net" <gourry@gourry.net>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>, Neo Jia <cjia@nvidia.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Zhi
 Wang <zhiw@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v3 05/11] vfio: UAPI for CXL Type-2 device passthrough
Message-ID: <20260713173730.2de01a77@shazbot.org>
In-Reply-To: <IA1PR12MB9030E175587B09CEA7A4D90FBDFA2@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260625165407.1769572-1-mhonap@nvidia.com>
	<20260625165407.1769572-6-mhonap@nvidia.com>
	<20260710162322.012be635@shazbot.org>
	<IA1PR12MB9030E175587B09CEA7A4D90FBDFA2@IA1PR12MB9030.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jul 2026 16:44:53 +0000
Manish Honap <mhonap@nvidia.com> wrote:

> > -----Original Message-----
> > From: Alex Williamson <alex@shazbot.org>
> > Sent: 11 July 2026 03:53
> > On Thu, 25 Jun 2026 22:24:01 +0530
> > <mhonap@nvidia.com> wrote:  
> > > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > > index 5de618a3a5ee..3707d53c4de5 100644
> > > --- a/include/uapi/linux/vfio.h
> > > +++ b/include/uapi/linux/vfio.h
> > > @@ -215,6 +215,7 @@ struct vfio_device_info {
> > >  #define VFIO_DEVICE_FLAGS_FSL_MC (1 << 6)    /* vfio-fsl-mc device */
> > >  #define VFIO_DEVICE_FLAGS_CAPS       (1 << 7)        /* Info supports  
> > caps */  
> > >  #define VFIO_DEVICE_FLAGS_CDX        (1 << 8)        /* vfio-cdx  
> > device */  
> > > +#define VFIO_DEVICE_FLAGS_CXL        (1 << 9)        /* vfio-cxl  
> > Type-2 device */
> > 
> > Would we define a different flag for type-1/3 if we ever found a need to
> > expose them through vfio?  
> 
> Yes. The current flag is named VFIO_DEVICE_FLAGS_CXL and refers to
> Type-2 specifically. If Type-1 or Type-3 support is added later, a
> separate flag (or a VFIO_DEVICE_INFO_CAP sub-type field) would
> distinguish them. I can rename it VFIO_DEVICE_FLAGS_CXL_TYPE2 now if
> that is preferable; please advise.

I'd keep the broader flag, CXL, and use the device info capability to
zero in on the specific features we're trying to expose that can't be
readily obtained through DVSEC or needs a mechanism within the vfio
uAPI.  Thanks,

Alex
