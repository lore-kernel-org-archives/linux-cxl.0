Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1F025A2C6;
	Fri, 11 Sep 2026 23:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789168156; cv=none; b=EgdMy89TUn8I5uxZ5J7/0b3+9vUm0UxuCS7SFGq3PWMZTHC65b2rD5OhkjWKKm5sfhfPd/dvR6MfU4vVHzHeIZ0/JOvVJoLL3AJUyqUSQ8LjpryYTShQyNKVfyiWiHHJdN2/tI7WlZgIk1efGWt/DHFcpgNSxTEdc1XqyutbORk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789168156; c=relaxed/simple;
	bh=CymmYiRgBPmwWvpAZuotQEH/kPy51FRClbyn5orchBI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LjShMJ7TNC07KfUoX2buAG4hqgegN4S+u4biU2buUjYd2CtRQrhea7ovyMeNGHNiT8SbpqT1ZeyZXZY/VuAI6IMf+jSHNqPOyGbaq4SxyQugHnV0LegsspJzlVDxMJ4/ei3HqSfPK29e3WkH09KavT8cSc4+1Lmaqu0YvXYMJgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mm8GeF4f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mm8GeF4f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259161F00893;
	Fri, 11 Sep 2026 23:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789168155;
	bh=iDhVegdwkibgQqjiYTJPliTOFap1UcaMZtnEWIWLDQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Mm8GeF4ffUxR7RXMKYaW7kOP5J/xdO5N0sDyByd6daZXW3Fc35wQ6WebbntgGk+hT
	 s+gAQe+ZITKfOI9ae9qzTOngjxzhbn+c57OT61lziZqaakKvDn7xX+fhsBp+KRac/p
	 tYdRcNousMovf/o6552Ngtp4AbROaqMe141uOk8dBH2CB8+B1yzRyC6KxAvSlrbu2P
	 B0RdXQRMigdZ5HEZjSv8HEdQYAh/SjYovJBPR0IM7s39y5h0YPBW/+e4KViae1GuZf
	 ct1QX/ouO9oD5XUwVbS4kzJcQAULXkRaWAq7PkxN0XRUJQ8CfQ+XXVsfYN1O5y3IRd
	 OsFGp8Ft4jgFg==
Date: Sat, 12 Sep 2026 00:09:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny
 <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Shaikh Kamaluddin
 <shaikhkamal2012@gmail.com>, linux-cxl@vger.kernel.org,
 driver-core@lists.linux.dev
Subject: Re: [PATCH v3 2/2] cxl/memdev: Fix deadlock between poison debugfs
 and cxl_mem unbind
Message-ID: <20260912000908.5df0b62f@jic23-hlaptop>
In-Reply-To: <08cbc221-a4b5-4674-ae5e-4e7b5df9293e@linux.alibaba.com>
References: <20260910094017.4032170-1-kanie@linux.alibaba.com>
	<20260910094017.4032170-3-kanie@linux.alibaba.com>
	<20260910220329.20b62302@jic23-hlaptop>
	<08cbc221-a4b5-4674-ae5e-4e7b5df9293e@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Sep 2026 11:04:47 +0800
Guixin Liu <kanie@linux.alibaba.com> wrote:

> =E5=9C=A8 2026/9/11 05:03, Jonathan Cameron =E5=86=99=E9=81=93:
> > On Thu, 10 Sep 2026 17:40:17 +0800
> > Guixin Liu <kanie@linux.alibaba.com> wrote:
> > =20
> >> The poison debugfs handlers take the memdev device lock so that the
> >> region lookup sees a stable cxlmd->dev.driver. debugfs holds a referen=
ce
> >> on the file across the handler, and cxl_mem unbind removes that file
> >> while holding the very same device lock, so a handler that waits for t=
he
> >> lock deadlocks against a concurrent unbind.
> >>
> >> Both tasks then hang. The unbind side is uninterruptible, and it also
> >> blocks the memdev detach work, which runs on an ordered workqueue and =
so
> >> stalls every other CXL bus work item.
> >>
> >> Take the lock with the trylock guard and return -EBUSY instead of
> >> waiting. An unbind that wins the race removes the file first and the
> >> write fails with -ENOENT.
> >>
> >> Found by code inspection. Reproduced by writing inject_poison in a loop
> >> while unbinding and rebinding cxl_mem, and confirmed fixed by the same
> >> test.
> >>
> >> Fixes: 574eda81d0a7 ("cxl/memdev: Hold memdev lock during memdev poiso=
n injection/clear")
> >> Suggested-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> >> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com> =20
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> >
> > Probably not one to rush in but nice to clean up the deadlock even if it
> > is a little hard to hit.  If it is possible to test with a hot remove
> > flow even better.  You should be able to do that with emulation in qemu
> > if you don't have hardware capable of safe hotplug operations. =20
> Sure, I reproduced this on hot-remove situation:
>=20
> debugfs writer, state S, waits for the memdev lock
>  =C2=A0 =C2=A0 =C2=A0 cxl_debugfs_poison_inject+0x25/0xa0 [cxl_mem]
...

> With this patch, the hot-remove flow completed normally.

Nice. Thanks for doing that.

>=20
> > =20
> >> ---
> >> checkpatch reports "do not use assignment in if condition" twice, on t=
he
> >> two ACQUIRE_ERR() lines. Those are pre-existing: the unpatched file and
> >> the Fixes: commit report the same two, this patch only swaps the lock
> >> class on them, and the combined form is what all 40 ACQUIRE_ERR() call
> >> sites in drivers/cxl use. =20
> > We should fix that up. Oddly I thought we had, but guess not. =20
> I think we should fix this in checkpatch.pl, like this:
>  =C2=A0 =C2=A0 if ($c =3D~ /\bif\s*\(.*[^<>!=3D]=3D[^=3D].*/s &&
>  =C2=A0 =C2=A0+=C2=A0 =C2=A0 $c !~ /=3D\s*ACQUIRE_ERR\s*\(/) {

There are a few other macros that are wrappers of ACQUIRE_ERR
that should be covered in such a patch as well.  If you have
time send a patch!

Thanks,

Jonathan
