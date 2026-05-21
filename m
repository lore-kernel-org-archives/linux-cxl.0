Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066863806C1
	for <linux-cxl@vger.kernel.org>; Thu, 21 May 2026 09:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357592; cv=none; b=YVbBEnHHCWRFPYz+opqk1+l25LSYMli24GB5nmQg5o5Kijtw4Fx14HLmp1E/bDbPS4Mue30CAspW7ObZENFloUV5SgSpEOamCn1CfL07kFoprbgIkRsdda3Tpkj7UasEvGzgPlURylG2kZkezK2s9sD1/p2A1YWde3IVbLHZ3N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357592; c=relaxed/simple;
	bh=jVFFUjXPOjmm7FBPQVHufSg7QVs8eVZ/xTclHxhq9fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0YsKfDHOB7thzlXRgrdr/AVQ9ytMYal7rjO0qzZB6vSZj34cwqFcJ9HjseCRUpdPJoQd0ainEAG0CQF9uXXqFLXbhKnLAnwM8X2jpmrLLMSQq8fZqQT9hqZbmf6VcymcqiTHiZz+MVx3jiOqzLkZzm4XWLSXf/ROiNXzSwm8CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKJzaznQ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKJzaznQ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490229aa522so25092005e9.3
        for <linux-cxl@vger.kernel.org>; Thu, 21 May 2026 02:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779357587; x=1779962387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dzTLRpollRQBLkOpPiNx8RHjAt/9M8rw+2H6kzCL280=;
        b=hKJzaznQejXld8SMONItIG4tvV0/BYUY86FMhybZ3wwLapqYSLwAXVvxpQkYcI0lzY
         RRQn5Ue0m21L7k8VAvJh1sV2yhKIY3ovN33TSI9Rydmgb7MFm3shQlB5tYzs3bAtxzkM
         5IqcizkAGAZ1lDf97HEx37TWffwV0gDTyWThfQp1xnfB3jxWmhZ6xWyJXebqvTFsoiND
         Yd+m8Ir5c25IZaay5RGjcbf1eDfqZZh2HbdDAXOLfuLyYhZG8CEKw7F/cZUiYp8sFyIj
         tu/BDbCK0dBerz6wE0/wwgfQF6arVlG1vjC1uLB+EVhGQDRHVPLcGWHM3fDQ7TZs1a+g
         a0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779357587; x=1779962387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzTLRpollRQBLkOpPiNx8RHjAt/9M8rw+2H6kzCL280=;
        b=MAIT8mjDx6jnpWWVfK1IxxDyMqrA4LI8apsxCmiff8uxV3edUYDckFJhuque3faB52
         pzDUZcGw3pour8FvlsSvn1Y0mx9nqH8EX7X/O44Chf8nM1vFD8lej3YbD5ot3jVwdnbA
         gOzW4Zh96/vp00dX3s/kT959j2VxxISbtgauS87aKy0K/cWWskAjCPtYq2zDAzPGdfX+
         fztPKlJxvB+ZbFnbJGDNel7EoiNmYB7JFG2oB5d9FGFklvhu0xX5oCQr8JT+VkpilvLI
         puObFigq4q4OhAqjD3s8AnB6776mSBsYLScwul8SQCKRrMrDFYzR/XyDUVmp/HM5vpOM
         RX5w==
X-Gm-Message-State: AOJu0YyAEcLzIoJ/oUljDLfv5Kp4YfdmwjvWeYpMUgTOvr/04w708CJ3
	+Feif+yp5CuuRgO4C04uz45rqGsrJ5C1ZN/oPDeWHNA6ig60TiLDjpE1
X-Gm-Gg: Acq92OGUm/IYfB76kLkFgaj8Wq+J3kKlrWtVOUL1Q6Iqc+NfguioJkbZKLDBSZC94Ar
	eR/8JUKkjwXFc1Mn15pqcNl8TdufWA7ma/gLH+3P3bleBy9eqN0faWtUGubIto0uSXUl/+o4App
	IyV8xNxI4YTB0iEQ80MulPEy/1PbkT8NYVJNhn/h+vLIaCnPIWjSW7ROzhNs15bEzVFU+fK3ZBu
	KuX3wqux6L7qj5/a9S3GVJnrf1Iqe/rJil5Aes6TGurg3vqsI0xUf1qpHPB5OTkz+KyLRHZSdRF
	q4NKwIoctMT5+OqD0SW6ZIMQUrFKzSd78KdMNOHZYgafYI9Jh4UzUsmNwOuCFp+QUhBuKjKYXIg
	VDLiDq7hvNPTqMOwN1Zjk+DCMhlsBa+YYip5eOZ2D6SGAfbfb4/K1uqKmLxooFgeWUFKyNxFDLU
	ShIPCFQMhZxdf06fXnKrJTNMjHkc0vkvA4tbZaNkynNUhkCj0V8RZHwxYBxMwXYw/cFDwtECsaf
	w==
X-Received: by 2002:a05:600d:8:b0:490:778:4fe3 with SMTP id 5b1f17b1804b1-490360ee151mr26933195e9.32.1779357586536;
        Thu, 21 May 2026 02:59:46 -0700 (PDT)
Received: from thinkpc (shef-16-b2-v4wan-175958-cust4.vm3.cable.virginm.net. [80.193.46.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49035c72c78sm17817195e9.3.2026.05.21.02.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 02:59:45 -0700 (PDT)
Date: Thu, 21 May 2026 10:59:44 +0100
From: Joshua Lant <joshualant@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
	Jonathan.Cameron@huawei.com, arpit1.kumar@samsung.com
Subject: Re: [RFC QEMU PATCH 02/10] qdev/qbus: Allow hidden devices to be
 busless on QEMU startup
Message-ID: <ag7XkPS0ylFSeIGO@thinkpc>
References: <20260429135717.3048713-1-joshualant@gmail.com>
 <20260429135717.3048713-3-joshualant@gmail.com>
 <20260520110205.428d0395@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520110205.428d0395@jic23-huawei>

> On Wed, 29 Apr 2026 14:48:36 +0100
> Joshua Lant <joshualant@gmail.com> wrote:
> 
> > Extend the capability for hiding devices, introduced for virtio-net
> > device in:
> > 
> > commit f3a8505656935cde32e28c1c6317f725084da1e0
> > Author: Jens Freimann <jfreimann@redhat.com>
> > Date:   Tue Oct 29 12:48:55 2019 +0100
> > qdev/qbus: add hidden device support
> > 
> > Currently only endpoint devices can be hidden with a primary device
> > and failover (known static configuration). However, looking at future
> > composable systems, we see a need for hidden devices which have no associated
> > bus upon boot. Move the check for hidden devices to before the bus
> > search, and if it is hidden ignore the case where the device was
> > described on the CLI without the "bus=" field.
> > 
> > This is motivated by a specific use-case: implementing the VCS
> > command set, part of the CXL specification (CXL r3.2 Section 7.1.3). In
> > this scenario a switch controlled by a Fabric Manager is able to change the
> > virtual hierarchy of devices seen by a guest within a fixed physical system
> > topology. The connecting bus is not known until runtime when
> > a bind command is issued by the Fabric Manager.
> 
> So this comes back to the earlier comment on whether they are completely
> hidden from a guest.  They aren't quite - we need to be able to
> get to them via the MCTP or cxl-switch-cci (in band mailbox) paths.
> 
> Maybe we can solve that later without any compatibility problems
> or by cheating and just searching hidden devices. I'm not sure.

Funnily enough I had something like this when I was originally writing
this series. I scrapped it becasue I ran into issues. I was storing
as a tree the QDicts of hidden busses and devices below them, but then realised
I couldnt hotplug into the USP and abandoned it. I was doing this with the
aim of eventual support for cascaded switches.

There was another issue I cant fully remember... That the searching was easy
when it was referring to unrealized devices with QDicts from the CLI, but it
became much more difficult to get proper reference to some structures I needed
from the devices inside the qdev/qbus code when they were realized...

> > 
> > Signed-off-by: Joshua Lant <joshualant@gmail.com>
> > ---
> >  system/qdev-monitor.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> > index f2aa400a77..b51dfe0645 100644
> > --- a/system/qdev-monitor.c
> > +++ b/system/qdev-monitor.c
> > @@ -650,6 +650,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
> >      DeviceState *dev;
> >      BusState *bus = NULL;
> >      QDict *properties;
> > +    bool hide_device;
> >  
> >      driver = qdict_get_try_str(opts, "driver");
> >      if (!driver) {
> > @@ -663,6 +664,11 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
> >          return NULL;
> >      }
> >  
> > +    /* Is the device hidden from the guest?
> > +     * If yes, no need to find a default bus if none given...
> > +     * Bus could be provided at runtime (i.e. in a switch)*/
> > +    hide_device = qdev_should_hide_device(opts, from_json, errp);
> > +
> >      /* find bus */
> >      path = qdict_get_try_str(opts, "bus");
> >      if (path != NULL) {
> > @@ -675,14 +681,14 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
> >                         driver, object_get_typename(OBJECT(bus)));
> >              return NULL;
> >          }
> > -    } else if (dc->bus_type != NULL) {
> > +    } else if (dc->bus_type != NULL && !hide_device) {
> >          bus = qdev_find_default_bus(dc, errp);
> >          if (!bus) {
> >              return NULL;
> >          }
> >      }
> >  
> > -    if (qdev_should_hide_device(opts, from_json, errp)) {
> > +    if (hide_device) {
> >          if (bus && !qbus_is_hotpluggable(bus)) {
> >              error_setg(errp, "Bus '%s' does not support hotplugging",
> >                         bus->name);
> 
