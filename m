Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1D61FBA
	for <linux-cxl@vger.kernel.org>; Mon,  1 Apr 2024 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711997094; cv=none; b=FdwYQnI4OWgE2u3EhnY8jI+wI42ftCi0bMchLumUdk5BWvJ5BqkOO8qTs68ehiwFerC1wKKtZ+ofCq3gcsT8f8VM0xb/gbKdsvqy2VUK1D2MyzS8Lyz18sEcgmn1NA3Z7tSZRM+Nx3yhGw+pvxX+A6FE6lSgKct/4bjeWswzun8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711997094; c=relaxed/simple;
	bh=Ebk3J/WEr5OXhWNdWrabLnZmZ+7Ff2xoKxCy0JgwDg8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tTQ694Ev6yrjcsEOtM5WdciuPUzhotb7zWRXZXnAv1Lnbl1hknQSUAQZk5x8nEqIl5Ly37zT4PdCQjpv+vit61tMy9Q/JLjjCiwdAI8j90OnoRuATb9YLR/IAh/49ajN/2btwj3teGlVe+8G6th7qf88AjzqkyHXK79W6hnVe3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V7fzX6Rcwz6K5WY;
	Tue,  2 Apr 2024 02:43:36 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id AEB1A1400D9;
	Tue,  2 Apr 2024 02:44:47 +0800 (CST)
Received: from localhost (10.48.156.172) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 1 Apr
 2024 19:44:47 +0100
Date: Mon, 1 Apr 2024 19:44:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>, "Michael
 S . Tsirkin" <mst@redhat.com>, <linux-cxl@vger.kernel.org>,
	<qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 3/4] hw/cxl/mbox: replace sanitize_running() with
 cxl_dev_media_disabled()
Message-ID: <20240401194444.00001db0@Huawei.com>
In-Reply-To: <CAB=+i9QrmMMazcNvEhuwTNF+UZMHPQE=yT=RE+MJCUQO+QY27A@mail.gmail.com>
References: <20231222090051.3265307-1-42.hyeyoo@gmail.com>
	<20231222090051.3265307-4-42.hyeyoo@gmail.com>
	<20240109175358.00007c48@Huawei.com>
	<CAB=+i9QrmMMazcNvEhuwTNF+UZMHPQE=yT=RE+MJCUQO+QY27A@mail.gmail.com>
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

On Sun, 21 Jan 2024 21:50:00 -0500
Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:

> On Tue, Jan 9, 2024 at 12:54=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Fri, 22 Dec 2023 18:00:50 +0900
> > Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> > =20
> > > The spec states that reads/writes should have no effect and a part of
> > > commands should be ignored when the media is disabled, not when the
> > > sanitize command is running.qq
> > >
> > > Introduce cxl_dev_media_disabled() to check if the media is disabled =
and
> > > replace sanitize_running() with it.
> > >
> > > Make sure that the media has been correctly disabled during sanitation
> > > by adding an assert to __toggle_media(). Now, enabling when already
> > > enabled or vice versa results in an assert() failure.
> > >
> > > Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
> > > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com> =20
> >
> > This applies to
> >
> > hw/cxl: Add get scan media capabilities cmd support.
> >
> > Should I just squash it with that patch in my tree?
> > For now I'm holding it immediately on top of that, but I'm not keen to
> > send messy code upstream unless there is a good reason to retain the
> > history. =20
>=20
> Oh, while the diff looks like the patch touches scan_media_running(), it'=
s not.
>=20
> The proper Fixes: tag will be:
> Fixes: d77176724422 ("hw/cxl: Add support for device sanitation")
>=20
> > If you are doing this sort of fix series in future, please call out
> > what they fix explicitly.  Can't use fixes tags as the commit ids
> > are unstable, but can mention the patch to make my life easier! =20
>=20
> Okay, next time I will either add the Fixes tag or add a comment on
> what it fixes.
>=20
> By the way I guess your latest, public branch is still cxl-2023-11-02, ri=
ght?
> https://gitlab.com/jic23/qemu/-/tree/cxl-2023-11-02
>=20
> I assume you adjusted my v2 series, but please let me know if you prefer
> sending v3 against your latest tree.
>=20
> Thanks,
> Hyeonggon

Side note, in it's current form this breaks the switch-cci support in upstr=
eam
QEMU.  I've finally gotten back to getting ready to look at MMPT support and
ran into a crash as a result.  Needs protection with checked object_dynamic=
_cast()
to make sure we have a type3 device.  I'll update the patch in my tree.

Thanks,

Jonathan

>=20

