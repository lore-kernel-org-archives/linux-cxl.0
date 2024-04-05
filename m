Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7751D530
	for <linux-cxl@vger.kernel.org>; Fri,  5 Apr 2024 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338547; cv=none; b=krQtQGs/Js+a3vBsbvucWaDtnWWTWYyxNphB6C97jX9/3tia9ylyevHapmBY/n7iu5iW0nUm0Rsq/0COV8FG+QYZS2HXAeGL75dqdASNonXAKdY44dp5o7mJ0kf6jUx4WQb5vNEZl7sthe26IiEyQV3y6nESTRymu6atS167eTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338547; c=relaxed/simple;
	bh=sBDBnsnx3oq1ioosHvoXlqPamVZaxIF2A8ROWGJN3sc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ce4WTzPz40Y4iNyibIONANbe/ll64kPz+oI9RY3SYylqqp2WKYgCJpENXAWQAgRu/JL7c8hCTfuSN8aCxZZcDx3MQtwWzIM6uFsIK75BboJCw75prDX9vdjx6SygsMfLGySqKGSb1WdQyfWATwyEg9MLNWRGV+fNYZJ9cREpoUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VB59w2zZSz6K8xl;
	Sat,  6 Apr 2024 01:31:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 51615140A79;
	Sat,  6 Apr 2024 01:35:41 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Apr
 2024 18:35:40 +0100
Date: Fri, 5 Apr 2024 18:35:40 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 5/5] cxl/core: add poison injection event handler
Message-ID: <20240405183540.00003d5b@Huawei.com>
In-Reply-To: <48223415-8466-480d-86e1-8b9945782c0c@fujitsu.com>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
	<20240209115417.724638-8-ruansy.fnst@fujitsu.com>
	<20240213165150.00006d9a@Huawei.com>
	<48223415-8466-480d-86e1-8b9945782c0c@fujitsu.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 15 Mar 2024 10:29:07 +0800
Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:

> =E5=9C=A8 2024/2/14 0:51, Jonathan Cameron =E5=86=99=E9=81=93:
> >  =20
> >> +
> >> +void cxl_event_handle_record(struct cxl_memdev *cxlmd,
> >> +			     enum cxl_event_log_type type,
> >> +			     enum cxl_event_type event_type,
> >> +			     const uuid_t *uuid, union cxl_event *evt)
> >> +{
> >> +	if (event_type =3D=3D CXL_CPER_EVENT_GEN_MEDIA) {
> >>   		trace_cxl_general_media(cxlmd, type, &evt->gen_media);
> >> -	else if (event_type =3D=3D CXL_CPER_EVENT_DRAM)
> >> +		/* handle poison event */
> >> +		if (type =3D=3D CXL_EVENT_TYPE_FAIL)
> >> +			cxl_event_handle_poison(cxlmd, &evt->gen_media); =20
> >=20
> > I'm not 100% convinced this is necessary poison causing.  Also
> > the text tells us we should see 'an appropriate event'.
> > DRAM one seems likely to be chosen by some vendors. =20
>=20
> I think it's right to use DRAM Event Record for volatile-memdev, but=20
> should poison on a persistent-memdev also use DRAM Event Record too?=20
> Though its 'Physical Address' feild has the 'Volatile' bit too, which is=
=20
> same as General Media Event Record.  I am a bit confused about this.

That is indeed 'novel' in a DRAM device, but maybe it could be battery
backed and have a path to say a flash device that isn't visible to CXL
and form which the DRAM is refilled on power restore?

Anyhow, doesn't make sense for persistent memory that doesn't correspond
to all the other stuff in the DRAM event.
>=20
> >=20
> > The fatal check maybe makes it a little more likely (maybe though
> > I'm not sure anything says a device must log it to the failure log)
> > but it might be Memory Event Type 1, which is the host tried to
> > access an invalid address.  Sure poison might be returned to that
> > error but what would the main kernel memory handling do with it?
> > Something is very wrong
> > but it's not corrupted device memory.  TE state violations are in there
> > as well. Sure poison is returned on reads (I think - haven't checked).
> >=20
> > IF the aim here is to say 'maybe there is poison, better check the
> > poison list'. Then that is reasonable but we should ensure things
> > like timer expiry are definitely ruled out and rename the function
> > to make it clear it might not find poison. =20
>=20
> I forgot to distinguish the 'Transaction Type' here. Host Inject Poison=20
> is 0x04h. And other types should also have their specific handle method.
Yes. If you can use transaction type that solves this issue I think.
>=20
>=20
> --
> Thanks,
> Ruan.
>=20
> >=20
> > Jonathan =20

