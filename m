Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E53149DF1
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 12:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784724475; cv=pass; b=j4zMZS6tV+BgraRwMilzKduRFEIV8MmmxKQV2/gIcEx6MsazvYrxSvqrcIMloU091s7yhgbbGbwQGSB9pEAeiw2PfYR5PgTPVGFF4Xbt6l++P0WCi0zSupRId+iQZexm1YhdBrFHAQ8dSW+tfYadee8eiV33i2nIYLi/gHomUWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784724475; c=relaxed/simple;
	bh=TWe1Cg0XZd9aKCfBim6632tR82TsQqkTtOSHRxZ8GhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jAgWwA668muvBF26g+J3fgvEVDn3W1oeTDYsnc+qAqMKrzK8fwPleg3XtCuRT3u/ub75wByyKVJWAm52fnuSplu5iza++jAmqU9A1GN8mOTGJmxb88U0tAdViIzTcDsYacmkNMKLooecOeFR+ku6ZJqJl8zEvldgpjcGiL0c1/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brRId3TP; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brRId3TP"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15f020a223so1626730466b.1
        for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 05:47:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784724472; cv=none;
        d=google.com; s=arc-20260327;
        b=Jpzgla6xtHQoBSsxuvslzoCUfAKuwwUw1SbmT3vBWgUjdfUIO+It8MOfkJQOZO79VP
         N0JRCycEqvied6mU4QZFZ4yOwHtNlIJ1iYn3z2DEgfnqR97PXz+iGrfOiup29rO1U24H
         Rai59adAXX+nQ5lBM3YOrgs1YsenmOX1momzGestrQHwTtNb4y8TiaG6qJOnMoWr7WaE
         l6izAYmeFzmos6bVz78kxX4j/5DWokuUhoWSf85V+4GEN0XNucrxALMUPcPPh+zBUDUL
         aUDrQM4QJEUyk1TOpH59lj0MQ+e9gioUkzGio/fMjz7b4g5O4c2U9gJGCBLQKa5iE0FK
         zYHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XYV9hkuF2d5ODBMLR+pFWv3rbaq2dbZuJ+4IyfPmr+A=;
        fh=/xYBiJuwweajcI8lqHA7vph0VQSmkvvUr2JrWhaX4eg=;
        b=U4TEbffNoIsl9Y4QGquPKwgX9nMKu+pf+mcPjHxlROYrpiQe4K3dKXUHr27LUqKxuT
         7xLD+yaK8pXOXNt8rRKl2JXMBqb8CkEFXGkVdhzq0kNPwY7RRmBGkeaG2hD6sRjxg6ca
         4Ckdf52CXxKVYZmF9B0HrdTktiluhPi//UHjdq6Op3yX7QTpnSGisc1v7MFEvkQk98Kz
         pJ8I9V5t2/p0NmzJF7HP3HHDzh1XiyCIVIRtjs29Eb7PLAtNzQIFmbaGm0s2wSUgn8Xr
         vmhJvHcYGx5WpZX2NCaPGI86Y1M1XDY4N3Cod4k5jmxsdaLsI6Z+pMzzKvSES4cEk7HK
         UDVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784724472; x=1785329272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XYV9hkuF2d5ODBMLR+pFWv3rbaq2dbZuJ+4IyfPmr+A=;
        b=brRId3TPWt1m/r+PuXSWAwdfqAY4dtCCP5M63A4yYVkmjXM/Vtfgc8136k4/ty3Y1n
         QVuQ5GkIubXX/JyQKYOCLeMH5i4EM91ZUTrkyqEuOZfnL/n5XD4kbUllgiFLnuUinUaR
         zF0Y/Nqzn0XDu98ZhtEmLfq/r3+B2pcsxe/CZtBqdSWfqUR5+8OvOaCqDp2mqiniPmi6
         lxdYD3LUGRCdCEcD6tc0Qb7xZlxx7ULPjXehFIOjT9JV0JNQxMGJYbXsILsDpmrqndST
         UNjgAwCkJj4dbYw7keH9EuHoKdlcpjXuufHpdn+oUNyfkKQtFChYO/oNIGmqUUBtwhr5
         Hdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784724472; x=1785329272;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XYV9hkuF2d5ODBMLR+pFWv3rbaq2dbZuJ+4IyfPmr+A=;
        b=oFxmJx7pyyoupJbkD2Cts42wVhdmoFyALvq/4AuiaWK9UFOuzpsiouiCqYrR8RULb2
         3DW26FOsQMWw52wdLYNDqGKB25s7H3wBCR8Q6VJmpho8JTR0ViYmRjyUa18jyg3mnwXM
         T0psqHX53IeZ9MGhQXQ6D4cOO0noPgklERbVSSPOZB05Cis4uEz0OmVvIItoAGerR08D
         fyo6d29YKkH4pTuPh5p1TMmf4SXR5AmygAN8fn0aUnRwbGUYIAsw1GTGy8bHvjgFdYrt
         TlNutj8E4/q+KswQNwxdQ99g1Banv2ugy+64QmQchktsaika+LB5cApS0aRGXr/W6O24
         icLQ==
X-Forwarded-Encrypted: i=1; AHgh+RoOevdbqBavvmSGQf2XuE0wBLYgGnpJP8CaybHZ/DUSWFxdXsSWJwNdjE+VePAG1rrsUnmFxTs/K+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwViArzjdh1+NU+Wmngh9JgQUJi/V1jiqNDnIEe5yDw1CnS5un+
	7lLatKjK9k4AWStAG70WXzyEkANSdA7JaLB1nDC5nmZR8kEMHxESBnAy0DV/FZ5sY2E/o/WSWJ0
	+x/49j5zWMH4EAtIqR0LrCSP22yVPW7U=
X-Gm-Gg: AR+sD123WtL1WGUxLGGEq/YltA/X0+TkVDSOZxmc2m3aV8iKi1k6XfbesaC5ZTzU+42
	IY+1V9sHeM5m7zyzJ6sk6ecD4FVPLritFmXdgps+qZOXZIYqI0YR+VNq8CiC3lVyPkfH9R8kdkZ
	G0qTFR/9bcRqT7uuHa1KxgAciJI31R6VkXZUxOpopOqLvzrDVd3Yinvd+gj/1aBh+UEGYAwvUMj
	gQ8u47LLulJaRDJu0XimO9cErVTwgG/iM/Mm2dkrvVszI6iumKYOihtGVgM8Bg=
X-Received: by 2002:a17:907:972a:b0:c16:46b1:e0c2 with SMTP id
 a640c23a62f3a-c16b48a8b9dmr984425966b.62.1784724471369; Wed, 22 Jul 2026
 05:47:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720034358.68714-1-john@jagalactic.com> <0100019f7d9fbe81-6cb16662-2522-47ea-a152-fab0ee3d9b35-000000@email.amazonses.com>
 <CAOQ4uxiEzP2e=cRw-AiGxtSv6WMSA5yR3cmgrF97s7ggU6wzqg@mail.gmail.com> <CAJfpegt9PwHksYhsQZeCsW0eooXVVihyieTpeHMmC-+Pq8BWaw@mail.gmail.com>
In-Reply-To: <CAJfpegt9PwHksYhsQZeCsW0eooXVVihyieTpeHMmC-+Pq8BWaw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 22 Jul 2026 14:47:37 +0200
X-Gm-Features: AUfX_my2cSFlhFYxiKgO1hiNmZM0_RgRfBeCPM6_N17W9wq10tY2PdKKMNctT2o
Message-ID: <CAOQ4uxhuivjMMt_Dm3VwKmOhHg7ZHdAww6j6jp+RMjPoRde+bA@mail.gmail.com>
Subject: Re: [PATCH V11 0/9] famfs: port into fuse
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: John Groves <john@jagalactic.com>, John Groves <John@groves.net>, Dan Williams <djbw@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"fuse-devel@lists.linux.dev" <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 12:47=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Mon, 20 Jul 2026 at 12:07, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > It's not about this ioctl, it's about infrastructure reuse.
> > It's about the fact that there is NOTHING special about dax_devlist;
> > and no reason not to manage it via backing_files_map.
> >
> > The reason you stated was that you want userspace to determine the
> > daxdev_index/backing_id - fine, no problem - this is why I asked that
> > you pass it the desired backing_id in the ioctl.
> > In fact I think that all fuse backing_ids would be better assigned by u=
ser space
> > so the extension of padding =3D> backing_id is not unique to famfs.
>
> Right, so I suggest to just reuse FUSE_DEV_IOC_BACKING_OPEN and add
> two flags: one to enable user supplied backing ID and the other to
> indicate that fd refers to DAX device.  The changes to do compared to
> the current patchset are quite minimal.
>
> > And the best part is that this request requires no changes to your user=
space.
> > You already bite the bullet and maintain the new/old uapi but changing =
the
> > kernel implementation does not require this burden from you, so to be h=
onest
> > I really don't understand why you did not follow Miklos' suggestion.
>
> Code reuse is also important, but I understand John's position to want
> to separate famfs from existing codebase as much as possible.  And
> because this is an implementation detail I don't want to make this a
> show stopper.  We can easily fix it later.
>
> > > - Lose the famfs interleaved extent format. I have complied with this=
 request.
> > >   It makes some things worse, but we'll discuss that later.
> > >
> >
> > I am really not aware of a request to lose the interleaved extent forma=
t.
> > How can this patch [2] from Miklos which reimplements this format as a =
generic
> > uapi be mistaken for a request to lose this format?
>
> Let's not care.  We can easily add this later if famfs (or any other
> use case) decides to want this after all.
>
> Making the initial patchset smaller is win in any case.
>
> > Let me recap the former review requests as I understand them:
> >
> > 1. Use ioctl instead of GET_DAXDEV
>
> This is done, just need to reuse the existing ioctl instead of add a
> new one with the same semantics (okay not true because of the fixed
> backing ID extension...)
>
> > 2. Use backing files infra for daxdev table
>
> Leave this later.
>
> > 3. Use ioctl instead of GET_FMAP
>
> Not sure we agreed to use an ioctl for extent mapping.   What we did
> agree on was to use a generic interface that doesn't have anything
> famfs specific in it.

My bad. I thought that FUSE_DEV_IOC_STRIPE_OPEN was an
example of how GET_FMAP should be made into a generic interface.

Sorry for the misunderstanding John.

Thanks,
Amir.
