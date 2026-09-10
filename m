Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDA03C0A00;
	Thu, 10 Sep 2026 20:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073528; cv=none; b=SKQCKwqNC5SAOi5eIQ7YKh2eymfDtlDP17s9odc89rZTtchR6lUVcHTrSUS7oeE9P1lB8+6xNDiPe0OasHnGcQQcxws08N9kt8uGZ/1Ouaqz6oFNyw/ovTASeI9xhoaOFrWDpmpY4wk45BZaCpnZ+XvwFGR7ujjLlXg0osLlLOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073528; c=relaxed/simple;
	bh=VvPJkxjXZqeEEGs6FachlDK8+7jtRGpBSMPG7YzAPUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rlfoI9y3JuJq+WtmuHWLwM5VgFZGTC+eehKIyYwh5bg3X2vtFcrD7fH/dDe9tQmeEcm3un8s30wtAa54dGImATWnPZ1oQHzwenP7j/emkH9D0j99NBWZULsLinJv1AW3CnIuNhljkGmJrH+Z+kks8IUMVd/Z6IpQR4kxwJNxtAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9/Sdb0F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9/Sdb0F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC101F000FF;
	Thu, 10 Sep 2026 20:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789073524;
	bh=ARy8RdgZuRLYXG020/f90w1jqch81coF+Ip26d3310A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R9/Sdb0FC0YydKwEgopOaiyPLJ21VKcg/KWJIjFJefd2tF8JphqExULZ1L+PIuWFv
	 NBLo/aDh0jzADhNAdSzz83L+lrL1WL1WreDmQDV4od6Mx+BROyuem/ZZERCBCIN9tU
	 p/XnfRNY0c5hIvCzGTkf1oGnJ/ANmM3zYXwcNqZhnbzXCw6NvKg3iXqqfZTX60U8XD
	 TbkiY7wuZK7ETc/cPq6Qoc2CFg25xVKFQ3o2dhVlCqDAhVfrE2Io8B97MvNDpfx2mG
	 qT4V/oWJ2hiLIhoSNg/F1w5zO4rMsfkcGFntveaWQY7vrXf8d9tayA+EUuruspjqWu
	 Xmf5taZdebO0Q==
Date: Thu, 10 Sep 2026 21:52:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guixin Liu <kanie@linux.alibaba.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
 <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Dan
 Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
 <ming.li@zohomail.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo
 Krummrich <dakr@kernel.org>, Shaikh Kamaluddin <shaikhkamal2012@gmail.com>,
 linux-cxl@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH v3 2/2] cxl/memdev: Fix deadlock between poison debugfs
 and cxl_mem unbind
Message-ID: <20260910215201.167040fe@jic23-hlaptop>
In-Reply-To: <2026091021-could-rockiness-15db@gregkh>
References: <20260910094017.4032170-1-kanie@linux.alibaba.com>
	<20260910094017.4032170-3-kanie@linux.alibaba.com>
	<2026091013-deepness-astronaut-471a@gregkh>
	<ea74384f-714a-495a-8d78-d47a9657e05e@linux.alibaba.com>
	<2026091021-could-rockiness-15db@gregkh>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Sep 2026 13:58:28 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Sep 10, 2026 at 07:28:03PM +0800, Guixin Liu wrote:
> >=20
> >=20
> > =E5=9C=A8 2026/9/10 17:52, Greg Kroah-Hartman =E5=86=99=E9=81=93: =20
> > > On Thu, Sep 10, 2026 at 05:40:17PM +0800, Guixin Liu wrote: =20
> > > > The poison debugfs handlers take the memdev device lock so that the
> > > > region lookup sees a stable cxlmd->dev.driver. debugfs holds a refe=
rence
> > > > on the file across the handler, and cxl_mem unbind removes that file
> > > > while holding the very same device lock, so a handler that waits fo=
r the
> > > > lock deadlocks against a concurrent unbind.
> > > >=20
> > > > Both tasks then hang. The unbind side is uninterruptible, and it al=
so
> > > > blocks the memdev detach work, which runs on an ordered workqueue a=
nd so
> > > > stalls every other CXL bus work item.
> > > >=20
> > > > Take the lock with the trylock guard and return -EBUSY instead of
> > > > waiting. An unbind that wins the race removes the file first and the
> > > > write fails with -ENOENT.
> > > >=20
> > > > Found by code inspection. Reproduced by writing inject_poison in a =
loop
> > > > while unbinding and rebinding cxl_mem, and confirmed fixed by the s=
ame
> > > > test. =20
> > > Why would anyone normally "unbind" cxl_mem at all?  That will taint
> > > kernels soon, so you don't normally want to do that, right?
> > >=20
> > > And debugfs is root-only, so this is a "root did something bad, and g=
ets
> > > to keep the mess", right?  This should not ever be a normal operation=
. =20
> > Agreed, nobody should unbind cxl_mem in production. The sysfs unbind is
> > in the reproducer only because it's the cheapest trigger.
> >=20
> > The window itself is not sysfs-unbind specific.
> > The debugfs directory is torn down from a devm action, so every path th=
at
> > ends
> > in device_release_driver_internal() hits the same wait: rmmod cxl_mem, =
and
> > the
> > memdev detach work that PCI hot-remove schedules. That detach path is t=
he
> > third
> > task in the reproducer stack, the one wedged on cxl_bus_wq.
> > A poison write racing an rmmod or a hot-remove is not root misbehaving,
> > and no taint flags it either. =20
>=20
> But how can cxl_mem ever be removed, it doesn't live on a bus that is
> hot-removable, does it?

It is effectively a child of cxl_pci and that lives on the pci bus and
definitely is hotpluggable.  Those flows should work fine so
I see this as a real if somewhat obscure bug to fix.

Jonathan



>=20
> rmmod doesn't count either, that never happens except by developers.
>=20
> thanks,
>=20
> greg k-h

