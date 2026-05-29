Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945DC3659EB
	for <linux-cxl@vger.kernel.org>; Fri, 29 May 2026 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068741; cv=none; b=MG/J8k4Rn0IahCQpmgC/7cV2iVrgLIqJVpbtXULi1g4oCRZOEYA9jHe6dyU8wVlPhTy7zQfn1ZbX0i/ThvJTHfQeuhSXR4/sFRWDIaAj0W+jjaKa9gw2P7852A7v/KjTDOJQQzNXYP9dy8A036Hcv5vs9dag1XAdCQr7RFgU/Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068741; c=relaxed/simple;
	bh=FC1QHWXzUWMCawcF5h1nwCZk4Cume/mCllXKL190rc4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yf0cbV0d6H6lPHUEaKuXYGHeEpxW+3XkduTKrF49EQbbEyR9bukC5VcbxCdWj5dg/qvTtCaA0PZnNhtQFMpJz9vrQ8Id/WgfDUUfPpLxz4nF6nYiTiLzLXQkeDgi3WiI5cHcIYgKgJqJKKN9bCw4s78Fwx8QbX8/6wp3aiVvmE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wjy4gSaU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wjy4gSaU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C541F00893;
	Fri, 29 May 2026 15:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780068740;
	bh=Y3vjd5QJErX2a3pzWjMiS5bsStbQ/a8eVnAmenqyOqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Wjy4gSaUA4nLzPnGRx2pV0Xyv+nebtLMCDpiQrqjTDtFqKFiiw5mTP7fjX0LK9i0L
	 an1qPlRIfv6z/dm0gow2mlfU7E23W8oPZA7gWHwCPFX9FfU+LPqd4VAOKI8w+ODKpo
	 AHF6lyoVdmKvw0pJHC/pE0B905GjCV4vtFnUhd1xb2TlotgkXjG33HV7/yy2HnXWKW
	 UTYPYkfBZTeQbZ2fCRMEeWlGhuIqpXweCKVmWyFmJrYKVJVnttYPXOI9iR0xx0m27g
	 +InU4+uBBut2amMrf+ijbiArKZ8G9YICmhbpSRUzXwAx1dlG0RCoLbt796FetSdBBH
	 4ETr1s1yT/PTQ==
Date: Fri, 29 May 2026 16:32:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Li Ming <ming.li@zohomail.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Alison Schofield
 <alison.schofield@intel.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, Vishal Verma <vishal.l.verma@intel.com>, Dan
 Williams <djbw@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add CXL reviewer
Message-ID: <20260529163211.453ed712@jic23-huawei>
In-Reply-To: <7da588a2-cbdc-4f63-aadb-9faf0125e90a@zohomail.com>
References: <20260527001305.533170-1-alison.schofield@intel.com>
	<27e15fda-2994-4fd4-9822-d0006b01a26e@intel.com>
	<7da588a2-cbdc-4f63-aadb-9faf0125e90a@zohomail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 27 May 2026 21:08:14 +0800
Li Ming <ming.li@zohomail.com> wrote:

> =E5=9C=A8 2026/5/27 08:33, Dave Jiang =E5=86=99=E9=81=93:
> >
> > On 5/26/26 5:13 PM, Alison Schofield wrote: =20
> >> Add Li Ming as CXL subsystem reviewer.
> >>
> >> Thanks to Li Ming for all the CXL bugs they've found and fixed,
> >> and looking forward to many more prevented!
> >>
> >>
> >> Signed-off-by: Alison Schofield <alison.schofield@intel.com> =20
> > Acked-by: Dave Jiang <dave.jiang@intel.com> =20
>=20
> Thank you all for trusting me as a reviewer for the CXL subsystem. I=20
> truly appreciate this opportunity. I will keep learning, do my best to=20
> help you to improve the CXL subsystem.
>=20
> Reviewed-by: Li Ming <ming.li@zohomail.com>

Excellent!  Thanks for helping out.

Acked-by: Jonathan Cameron <jic23@kernel.org>

>=20
> >> ---
> >>   MAINTAINERS | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 2fb1c75afd16..992e1fa57b72 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -6428,6 +6428,7 @@ M:	Alison Schofield <alison.schofield@intel.com>
> >>   M:	Vishal Verma <vishal.l.verma@intel.com>
> >>   M:	Ira Weiny <ira.weiny@intel.com>
> >>   M:	Dan Williams <djbw@kernel.org>
> >> +R:	Li Ming <ming.li@zohomail.com>
> >>   L:	linux-cxl@vger.kernel.org
> >>   S:	Maintained
> >>   F:	Documentation/driver-api/cxl =20
>=20

