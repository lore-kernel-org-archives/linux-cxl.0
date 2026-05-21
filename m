Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94513A1A42
	for <linux-cxl@vger.kernel.org>; Thu, 21 May 2026 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779359013; cv=none; b=q151Za226I+XtteAtVQFuijN5vITbowiXllJm/RpDDVqJBnUjq6ltOITkP/wNYuwuitU8Y0HGr71gao2FcfQlvwWiIfjsYpkyaHkp8AooBBxb2kG33Z6xgUoayenJYWUwI98YKzT6fuUstCI5NenmfVN7+MPfwAz3Zm17G/Axpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779359013; c=relaxed/simple;
	bh=iOrQJNri7D/5ugaOdUFq88eR0Oiqa3VJ0O5guePPSCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPcB9Cl7HPs93577eypEr4IM0xar688p+UyzZp+WYLcaa+dibP/z6bafoikcIkcOrJTHEUtQHM6g4R78zgGqoARFQY6XFzg+97Hu5KHkZ27h0ywLnflQtVYJx/8P/EqLeDfBJ4aNosqDeBu9K0cjQD2Azh2/QEBTRtMwVz/J5X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5ZMAcqy; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5ZMAcqy"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43fe62837baso3464530f8f.3
        for <linux-cxl@vger.kernel.org>; Thu, 21 May 2026 03:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779359010; x=1779963810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QMYdl/jcyRx/rzoqCLEOyD78Cx4h4XXTE2K9BVYo1K0=;
        b=T5ZMAcqyZY8MgNfMy8PhosAB9okxrerpAum3eh1hR+I7eUZSU2n8n0NEtw3lof8gWy
         SHxPULA94jZ2CCM6AXpbORvNAuUwZNo8uYpVpHva4CN3gfUYokbPgtsJPPVz1rBNO5BW
         fInqH3g9S3YvbEu626yub6ICBJQ8xkHZMMDwic5EvOtlFVZP6uTN1OUOaZcRl3pqYDx6
         +ZTPH+Xrmqn0Xin5iPi26VSgDlUPknzKW7EHdnm/L4GRP06GIFrnp482q/28G/SwYZ3C
         F3sgJpz215xwxsReCPaBIwdWIB5AiBdcVhKNGcIEI1P9ynEUIMOamAiGrFy2EmAV4nkf
         V7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779359010; x=1779963810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMYdl/jcyRx/rzoqCLEOyD78Cx4h4XXTE2K9BVYo1K0=;
        b=W4PBvDUbXSUGLQzuEgywpuJ7oalmePP0/ye0XGxNciWOA34SeFlsfjHk2nK2928Rxm
         haKFsJbz7uHrjmOYU3NEUddcWm1CPfDuqmOJpK0PzODG+5r6x1Sduzy7eltxg2IjgYuj
         u/KN8bg0ogbvo2Pf2JBXfhnjRvM55gP1b9Fpoa5a08UW5PIQdl8mLA0PYO9Cl6HuTI5Q
         MApoXKxp3U1IB5yrLieanFFEZUBumfzhk19qJXY7Yb/1NbEW1dgOSmk8yh1m+SRZjybl
         Rlu8XaCNdV/e7Si7WkUcd6OE77SF9vXmA//P5JofTVJi9as+L5F2XdNh2rZfv10rZ2+h
         6NRw==
X-Gm-Message-State: AOJu0Yz2Pwdrf8zDNacv7l3CZcuU+tzVj5Df66fu8AoKzHlX675eIgki
	ht7RhDJ+xpEmph43qz9KRx98Kfnp6srCNDF5rQ9dVX6lP+Un4EGoo58P
X-Gm-Gg: Acq92OFDnt4PuLefA/DpccXLWP9kds/mgtOBMNmFj3iTPAIBJFv5lJvVp2eNlhU1f2H
	7rFelsbuXJk+UBpzYZA9c5gih1sdTUq25caneukuRN+9bB5Eda/L6QG5wsphiZHiVwFsz8VLjsj
	GfhKOnrkIcRaDPJn+pcPTdRgO7pJ7G62x7f/AeLIszCnh9ul/GJo2HrMnaUiRDacgXb3sMpLzwu
	rns42ru+PSeCEmdqeeqgt0QOUs1z+UukstF78JuwAc/N3tEas5rl/UC/z8ft23JVmFYru8Y2H2R
	IVotZza3sezBzYHxLLH/Ua96HRk439J+x/GM5bA8sUZ1tchT/zhAGWtAJJ7cQdgd8jeN7xVIF1a
	uu0DeF7xAua9YMReSob2aFr++aCYjnbrykEEbruo3jX0N9HQLP0hK7DcmzaVyHrlTicv4joWMnC
	kRMAvDsCRckRhdwb4uHastoBY/VmaR09EoYkdoLH7SI9PKJ7TA9uG/1pwg2LhZMm6Fui/GTtOAf
	D/7MLMTgKMM
X-Received: by 2002:a05:6000:240b:b0:45e:8526:7dc8 with SMTP id ffacd0b85a97d-45ea3ff7b2emr3512157f8f.25.1779359010014;
        Thu, 21 May 2026 03:23:30 -0700 (PDT)
Received: from thinkpc (shef-16-b2-v4wan-175958-cust4.vm3.cable.virginm.net. [80.193.46.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa7d0a36sm1700715f8f.2.2026.05.21.03.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 03:23:28 -0700 (PDT)
Date: Thu, 21 May 2026 11:23:27 +0100
From: Joshua Lant <joshualant@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
	Jonathan.Cameron@huawei.com, arpit1.kumar@samsung.com
Subject: Re: [RFC QEMU PATCH 02/10] qdev/qbus: Allow hidden devices to be
 busless on QEMU startup
Message-ID: <ag7dHwNXS/qGnEJD@thinkpc>
References: <20260429135717.3048713-1-joshualant@gmail.com>
 <20260429135717.3048713-3-joshualant@gmail.com>
 <20260520110205.428d0395@jic23-huawei>
 <ag7XkPS0ylFSeIGO@thinkpc>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag7XkPS0ylFSeIGO@thinkpc>

> > On Wed, 29 Apr 2026 14:48:36 +0100
> > Joshua Lant <joshualant@gmail.com> wrote:
> > 
> > > Extend the capability for hiding devices, introduced for virtio-net
> > > device in:
> > > 
> > > commit f3a8505656935cde32e28c1c6317f725084da1e0
> > > Author: Jens Freimann <jfreimann@redhat.com>
> > > Date:   Tue Oct 29 12:48:55 2019 +0100
> > > qdev/qbus: add hidden device support
> > > 
> > > Currently only endpoint devices can be hidden with a primary device
> > > and failover (known static configuration). However, looking at future
> > > composable systems, we see a need for hidden devices which have no associated
> > > bus upon boot. Move the check for hidden devices to before the bus
> > > search, and if it is hidden ignore the case where the device was
> > > described on the CLI without the "bus=" field.
> > > 
> > > This is motivated by a specific use-case: implementing the VCS
> > > command set, part of the CXL specification (CXL r3.2 Section 7.1.3). In
> > > this scenario a switch controlled by a Fabric Manager is able to change the
> > > virtual hierarchy of devices seen by a guest within a fixed physical system
> > > topology. The connecting bus is not known until runtime when
> > > a bind command is issued by the Fabric Manager.
> > 
> > So this comes back to the earlier comment on whether they are completely
> > hidden from a guest.  They aren't quite - we need to be able to
> > get to them via the MCTP or cxl-switch-cci (in band mailbox) paths.
> > 
> > Maybe we can solve that later without any compatibility problems
> > or by cheating and just searching hidden devices. I'm not sure.
> 
> Funnily enough I had something like this when I was originally writing
> this series. I scrapped it becasue I ran into issues. I was storing
> as a tree the QDicts of hidden busses and devices below them, but then realised
> I couldnt hotplug into the USP and abandoned it. I was doing this with the
> aim of eventual support for cascaded switches.
> 
> There was another issue I cant fully remember... That the searching was easy
> when it was referring to unrealized devices with QDicts from the CLI, but it
> became much more difficult to get proper reference to some structures I needed
> from the devices inside the qdev/qbus code when they were realized...
> 

I just remembered... I was having to introduce cxl specific code into the qdev
code... I'm sure it could be separated but would require a fair bit more work.

> > > 
> > > Signed-off-by: Joshua Lant <joshualant@gmail.com>
> > > ---
> > >  system/qdev-monitor.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> > > index f2aa400a77..b51dfe0645 100644
> > > --- a/system/qdev-monitor.c
> > > +++ b/system/qdev-monitor.c
> > > @@ -650,6 +650,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
> > >      DeviceState *dev;
> > >      BusState *bus = NULL;
> > >      QDict *properties;
> > > +    bool hide_device;
> > >  
> > >      driver = qdict_get_try_str(opts, "driver");
> > >      if (!driver) {
> > > @@ -663,6 +664,11 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
> > >          return NULL;
> > >      }
> > >  
> > > +    /* Is the device hidden from the guest?
> > > +     * If yes, no need to find a default bus if none given...
> > > +     * Bus could be provided at runtime (i.e. in a switch)*/
> > > +    hide_device = qdev_should_hide_device(opts, from_json, errp);
> > > +
> > >      /* find bus */
> > >      path = qdict_get_try_str(opts, "bus");
> > >      if (path != NULL) {
> > > @@ -675,14 +681,14 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
> > >                         driver, object_get_typename(OBJECT(bus)));
> > >              return NULL;
> > >          }
> > > -    } else if (dc->bus_type != NULL) {
> > > +    } else if (dc->bus_type != NULL && !hide_device) {
> > >          bus = qdev_find_default_bus(dc, errp);
> > >          if (!bus) {
> > >              return NULL;
> > >          }
> > >      }
> > >  
> > > -    if (qdev_should_hide_device(opts, from_json, errp)) {
> > > +    if (hide_device) {
> > >          if (bus && !qbus_is_hotpluggable(bus)) {
> > >              error_setg(errp, "Bus '%s' does not support hotplugging",
> > >                         bus->name);
> > 
