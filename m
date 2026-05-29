Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162583D76
	for <linux-cxl@vger.kernel.org>; Fri, 29 May 2026 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780055591; cv=none; b=mMf62LndgemvA5nSYzwqp62gOuZFgGrEGw9KqL8AGFgO9LGG1/eNj/N5RikNobeWNu3nPjJGZHKuvrIoJykl48a0j6D8O4FQVV3/Ghh4NqgtC8xvVa2Yq1wjDxnWHd9PIG/SXhDFzWjiyoe2uRCDfGIbbL8KmxvJEw7Lek1/mJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780055591; c=relaxed/simple;
	bh=Y2jWj7JM65/tZSpKXXsbogVe+X9JVi7aPogkzSInJfA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bWEDvTjpTQNvBRdk0ChIscMbIen49DrtJI7JJ8QrxMilmwBaLyZaFoksCZ/k1SVtoPdTOJhcLUNU2yt+yROOVb43Bn6h2Ph4JCdGRkEKACqC+JYHR15AFiCw0he/N4EojipSHFOvEjX5pBYUe54U1WSXiCCwH0qPklzSUZktB/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKy5z1xC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKy5z1xC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73481F00893;
	Fri, 29 May 2026 11:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780055589;
	bh=vph/IA+xak26xLPAwzzNA1eKOZZHpZ7wKRfzzNO7HiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lKy5z1xCCDYdNLy+6GWw5Atl5sNO7OialJgik3eOfmeP3DK/HJc4tOkI5/tpKBnul
	 X5+LV5SG4xvfhbf7FkVWt4judJ3kH72IcyK15flYOGdhTFHmR03NS7bT01Xw9vwviY
	 fblo+DZIHDbUW32/DWAgaq665A0ajbm1aE9x39S+PVw06Gz2cFHHY6J/0UeO7oyED/
	 njCcflRtPoucWHCyc/wIVAoKERSGxXdJvjZQVs/M4m12c5iXTlNhip4bOjZqIU/izv
	 dgmDpUg1ym8bXFpxB3oJZXLOndI27cVuGxp3uRovMj6gQHcB5lMIbT6IvOwFfIwOCE
	 sqjU1y+LzqhLg==
Date: Fri, 29 May 2026 12:53:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Aaron Esau <aaron1esau@gmail.com>
Cc: mjt@tls.msk.ru, qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com,
 berrange@redhat.com, qemu-stable@nongnu.org, jic23@kernel.org,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/2] hw/cxl: fix OOB read in Get Log command due to
 incorrect pointer arithmetic
Message-ID: <20260529125301.44c7a382@jic23-huawei>
In-Reply-To: <CADucPGTnQdxsGDkpyfnGUvqWu6Y6Ph_NbAgP4D3=__OpNiJ0Jw@mail.gmail.com>
References: <20260416200702.2374709-1-git@aaronesau.com>
	<20260416200702.2374709-2-git@aaronesau.com>
	<c18a3fa5-4474-42db-b8be-95f164d1b184@tls.msk.ru>
	<CADucPGTnQdxsGDkpyfnGUvqWu6Y6Ph_NbAgP4D3=__OpNiJ0Jw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 13 May 2026 16:41:48 -0500
Aaron Esau <aaron1esau@gmail.com> wrote:

> Hi mjt,
>=20
> I haven't contributed to qemu before. Am I responsible for anything
> beyond submitting the patch here, to get this merged into master?
>=20
> - Aaron
>=20
> On Wed, May 13, 2026 at 1:35=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> =
wrote:
> >
> > On 16.04.2026 23:07, Aaron Esau wrote: =20
> > > From: Aaron Esau <aaron1esau@gmail.com>
> > >
> > > The memmove in cmd_logs_get_log() uses cci->cel_log + get_log->offset,
> > > which performs pointer arithmetic in units of sizeof(struct cel_log)
> > > (4 bytes per element). However, per CXL r3.1 Section 8.2.9.5.2, the
> > > offset field is a byte offset into the log.
> > >
> > > The existing bounds check correctly treats offset as a byte value:
> > >
> > >      (uint64_t)get_log->offset + get_log->length >=3D sizeof(cci->cel=
_log) =20
> >
> > ...
> >
> > Ping?
> >
> > Has this patchset been forgotten, or is it not needed anymore?
> > If it's needed, it would be nice if it lands in the master branch
> > in the next 10 days.

Sorry, this is me running slow due to other demands. I'm just catching
up with the qemu list as the email address this went to for me is dead.
Looks like my maintainers update hasn't been picked up by anyone yet.

The fix may look frightening but for now it's hardening only as offset
passed by all the guest software stacks I know of is always 0.

Fix looks correct to me.  I'll queue it up on my cxl tree but more
than happy if this goes directly via someone else.

Reviewed-by: Jonathan Cameron <jic23@kernel.org>


+ cc linux-cxl (and my kernel.org) address so that folk are aware of the po=
tential
issue.

Thanks,

Jonathan

> > Thanks,
> >
> > /mjt
> > =20

