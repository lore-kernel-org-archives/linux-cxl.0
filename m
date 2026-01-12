Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8383BB40
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 23:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768259726; cv=none; b=SGAj+jdUa14csjUJ+l2tnQ/P7VRFzX2j0reH6t2hWgah6ECcj2vpqyCUBa1YfYGo8j3TMREmMYht+At4GbDhyxPab5cMjEK1JWE6A7N2bQ+j/Ni6dbGmd6wt1P2y+7C1YEkkueR3YfGB+0wU5bsyEjaUoWZDRep6S/yj7vx9/Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768259726; c=relaxed/simple;
	bh=BRENSHxOqnc0XTBgYPAYSrqv03RduyiJXfpNto3Du20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkLCe/psQXniBDa/nKyUMMvSudAjQVDBxUC6TMEK11Aecby1oJOaW2GYXW9kjK++7OxdQAZB3dGqKtH5/43P0mHSUzFxUFOAJ8qbEBv6tIKDNPc0VxQZ9IcpnKwfDv8keI8RzdukctQMyGQjLYFK+DuuApoe9pzZbCcSXVE7v2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=V/XYfcqy; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="V/XYfcqy"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b2d56eaaceso793727785a.0
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 15:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768259724; x=1768864524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kz2DiMZ9Jmi9alXldwvfU82+dy4M93Sr37IhN34NP6Q=;
        b=V/XYfcqyxCCxNSK1G5hOu7P230Z1PcFjifX37XOegkRC9exqznQIVZhvGF9TRKU/42
         S14J8bXZ3c+A1lqDj+sqYw+YKaQ+NXHL6KtmKRpp+tnXBe0JMS6dKVWEIsQKmPsWYhw8
         rC4RywH4sLAms84em0w6kstdhpeN5Tev8ueJhUoUPYFVOqBQazFzqm9R2rjE/KuWUZ+q
         PRacaQAeDeND/Up8FntVNiQVpA/1H85roXF1nA2siLCJAOYUtPUX97tKSa7iq5WxdkAV
         r39NcxDmF4duaAmdXHJmqo5Bdac4iReY6oGEaecGsH221dEBbhrQp+Jtk6uLiUWTc03d
         hlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768259724; x=1768864524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kz2DiMZ9Jmi9alXldwvfU82+dy4M93Sr37IhN34NP6Q=;
        b=hK4YS2KlBvPYyQYpdnY7U4yp95kdd8quvS2k3ct24pTm3rFGHwt5LVXlckeoq+RRZZ
         ++qovDZOXVMUQ8R9g1NnpS2GyaWEDNniUDVwV72eO0UgyoosZR8SCrid4nrQnTcnRNrC
         LcMiJOVLDcAmZI1kL4A5A4oYg//QMqMi7njnB+kY8ojG5AW2wPGvqDrpyA8EeCXfdNxp
         90OdPhg64HMEw4UfpQA0yh1/neKchoT6M9QFsRkq5HZW2n+KV5KLb/W8on3ONYFcU35y
         S+F0IAZGaRRodDYEZ5JHfUgwTrMcmocKucyiyxNMp35jCuaWr6tilR1W7YERLvGGx17k
         +Neg==
X-Gm-Message-State: AOJu0YxsCAo7P7bH2UdDnPl9VuwIY5NHZ7eKuf/s8ZJCiaXWOPotlBvl
	g2n5pVD+QanznJrvDh3hcdOKEUNMgqA/y52gB+Xm3XzZrMfxUi8WilkeyaDX0JzPmfo=
X-Gm-Gg: AY/fxX58bfA74Zg26Ra/u6/Dw7RL8cUstrgtDwR7RidYXUwjHoofxEYnpMgbm5x1tZ2
	gZJykwHzhquybDeK6C0R4NjJisosOX+tXYpQr8oCwnsKkTByIpFdFgEld2JzN05WYDC5Wb1HebI
	Zwxi7DM4dOOcjbDFj5Cb9mpYvlp/+k3+c4ZcNdiSo0YKtBohykX+yFxJ5rjDZxk1ZR0OT0qhGFt
	w4kf2kw58c4O+rdBWxeb6wldv7Eomtoug9nlqn1KxdpBGwtekfd0C81XLaZLpm2enCLXJRXbJSk
	61XeIyyxpxh0AymICNUIT49xyNk1wEm28zWQ8F1KaTexXpcm75ZDS6vYZqU4UHmisIRdUTIMOtS
	Um73t2aj4fbvUOAAKf8Yc8OghKmt3D799Nh+EekddIsYmzDKb6qsR3dxas4qavkusFsxvyYWVnr
	2Zf6wLTqOFV5GEK1d6s+OSOmGY7O+7WJuJAEfzsoPvmtmQ2E5W4XimDdWllJTaU9KzCwThZId01
	QA/u50A
X-Google-Smtp-Source: AGHT+IHEBdEFYGiGeIFxQsYqWbO8KZ5CI81tDM8GfmvVkP22qHVWlWJ3421TBDjCcBZXh9CMse0mQg==
X-Received: by 2002:a05:620a:2801:b0:8b3:3835:eeb3 with SMTP id af79cd13be357-8c389403176mr2610384385a.65.1768259724154;
        Mon, 12 Jan 2026 15:15:24 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c38a9244bdsm1341831185a.3.2026.01.12.15.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 15:15:22 -0800 (PST)
Date: Mon, 12 Jan 2026 18:14:48 -0500
From: Gregory Price <gourry@gourry.net>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	David Hildenbrand <david@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 6/6] cxl/sysram: disallow onlining in ZONE_NORMAL if
 state is movable only
Message-ID: <aWWAaDK91qAVLRLz@gourry-fedora-PF4VCD3F>
References: <20260112163514.2551809-1-gourry@gourry.net>
 <20260112163514.2551809-7-gourry@gourry.net>
 <9c975c63-2668-4283-a326-292e50bfbfec@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c975c63-2668-4283-a326-292e50bfbfec@amd.com>

On Mon, Jan 12, 2026 at 03:11:05PM -0600, Cheatham, Benjamin wrote:
> On 1/12/2026 10:35 AM, Gregory Price wrote:
> > If state is set to online (default to ZONE_MOVABLE), the user intends
> > for this memory to either refuse non-movable allocations, and/or intends
> > to preserve the hot-unpluggability of this memory.  However, any admin
> > can write `offline` and `online` to the memory block controller and
> > bring that memory online in ZONE_NORMAL.
> 
> Is it the expectation that the user will never want to change the zone from
> MOVABLE to NORMAL? I can't think of a reason someone would want to off the top
> of my head, but I also can't think of a reason to restrict it either.
>

It's more to restrict this pattern

echo online_movable > region0/hotplug
   -> creates:   node1/memory123/

echo offline > node1/memory123/state
echo online > node1/memory123/state

The result of this would be valid_zones=[normal movable], which would
break hot-unplug.

> > If an actor attempts to online the block into ZONE_NORMAL, it will fail,
> > but if it attempts to online into either NORMAL or MOVABLE, only MOVABLE
> > will be allowed and it will succeed.
> 
> I'm not sure you need this paragraph. I think it's a logical conclusion of the above
> that if someone attempts to online the memory as NORMAL or MOVABLE it'll only be onlined
> as MOVABLE.

in the above situation the following occurs:

echo online  > region0/hotplug
echo offline > node1/memory123/state
echo online  > node1/memory123/state
cat node1/memory123/valid_zones
   normal movable
echo offline > node1/memory123/state
echo 1  > node1/memory123/online
cat node1/memory123/valid_zones
   normal


echo online_movable  > region0/hotplug
echo offline > node1/memory123/state
echo online  > node1/memory123/state
cat node1/memory123/valid_zones
   movable
echo offline > node1/memory123/state
echo 1  > node1/memory123/online
   fail with EXXXX (i forget what code)

It's a little confusing.

> > +	switch (data->last_online_type) {
> > +	case MMOP_ONLINE_MOVABLE:
> > +		return sysfs_emit(buf, "online\n");
> > +	case MMOP_ONLINE_KERNEL:
> > +		return sysfs_emit(buf, "online_normal\n");
> > +	case MMOP_OFFLINE:
> > +	default:
> 
> You're missing the MMOP_ONLINE case. In that case the memory would be reported as "offline", which
> I doubt is the intention.
> 

Blah, i originally had all of them and just reduced to
MMOP_ONLINE_MOVABLE and MMOP_ONLINE (i don't see a good use for
MMOP_ONLINE_KERNEL), but i'll fix this up.

Thanks!
Gregory
