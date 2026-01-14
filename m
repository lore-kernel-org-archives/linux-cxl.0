Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A58285CAD
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411991; cv=none; b=Yf3BsRFhUZyYi5hAThK4t9dMcvj02hUSYtuREct2Wy741Z27tTmldNXsyGyf7LOr9cbtIu1HwqoPuYdl0U42iRlgFCWY8lED/d1SP2DpTvjQvrWlXxijPNJH1sU0Ik0hzBqH8pXBidxg2iS26pY/35PlM/l/geY0yk+t6RZL7mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411991; c=relaxed/simple;
	bh=8O9PPhw4HJ1ghVcptQLNcB4UFjagJSyTGDFo/SN9nX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyIObixvY/0qkr+JHb25i0bltYoRmz2gAcIdvDvaWv+v3oXZ87y2CFJYgif7widNcxyDZMn0bySBeMgTmbgxMeA0FmXjsOCIJXEEaRMD7ZmJa/KkzX9Y9K9Ne/z6TTSNRAMAzp87GUNQirz7Q5f2VRukSX9PvI3PfG608zBqA9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=pdbbGpZB; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="pdbbGpZB"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c5386f1c9fso9712285a.1
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 09:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768411989; x=1769016789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bCjYai9Len2QQEYBKyLKOlFSVdw2VqJPxFxPg7dhnMU=;
        b=pdbbGpZB4FN/pc1oIcYQI2sdb7LPSfe4Xrf2buGe9SLPgSmqbntdcOm6xMmIo6+64d
         4ger4ttSlWYVfZcN/f8jUP9nkbzLmnEYARy4HRpwNZTdAI8yk5WWq3iK1dlFBPIooVLu
         A+YF+dPOjM6m/7VFyMbBrXhthQN2NF22KiepJdJEBuHtJwsJyiC7A+WODwUGW2BYVCMo
         T6rH15gdShRF8SKkfcQ5xw86Tq0TBTYYzaCk/XtDt+23sLvPxJeQLvflYo0dQLGoU3d6
         DDrj1Zl2vDy0bJl5GARWZorTYFz0cMdFiLCU2N7XdtUn5D52+fHVuSKETgA0zVMKzJj3
         fD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768411989; x=1769016789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCjYai9Len2QQEYBKyLKOlFSVdw2VqJPxFxPg7dhnMU=;
        b=iB1uVb+jUVYzfDBEfl8Ao5k9rqAxvPTXQ77T+URJcyQ1edZ0UqZky+c/IdZ2wq2R+M
         Z+kbYtw6Z1OpldUUMXww56xKd6DCUjH4ZgDCFhz3wone61VMJLRPNX2sWhLP/zqRujtq
         Og9UbhCSOjwaqqk+Pv21s2AFmsxO83suPsN09iphNz8Y33bSTVtKntVzQmtMbGSqsbNK
         5DwyucQkahLl5DlqHtG1zkU+cVL979xQp1qBzkU3glWHnDhmI6v/PBg1U+ng1D8oYvAm
         ENC1iaN7BI2b57xQUGLU3iipdn82ITq/BhZHbEO3xeJ0VLSdoNUCNzsZm4i2m4snP4yZ
         j4ew==
X-Forwarded-Encrypted: i=1; AJvYcCV3f7gMQRS1d4o/2P/6NJ/Y7YgkxR5Umv4pvDGDqTskIQIqr6Rk/pWj2sVXuShGWM9NuynDqm8/pXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2k49fIwFRQYvHy0rWalCAYzsTClexSGVPvKnd9Xph6DRqcdKn
	q9qhL8lZGk0EQP/fvotdnLKaW8Azbd9kiEb/+SrhFzQMUCzlmnvEIc0vVrBbBFht79s=
X-Gm-Gg: AY/fxX5+NSmdK2kHVaIBdiIb4TvPxAlO91ES267BF8OytLFQQqNMfJUCxedlCBlIJNe
	gh/ryXL2Gxil0aCedDEbrV2U95MzEL51zbk7Gv0SOWXmPWmYzWny6HN/QYrkX6O6/iUXdZieTVO
	m4ktd33zVTxFJ5zoiJLcvFQqMAgDKECv6gVRE/7KN41rOCJDnpXGCnVG/fsAO8n/AGcj0lCwVu4
	g//1Nu1aJPYsnZojNpmYrsj5XKAcKRrlnkrqgv+6Do1/gwuW1QD8wcGkgQZKffopoqNZItMgYVU
	vsYVAMyJpB21ogdCHvTLGgfhCzytCEtE7C+yh99htMpw5qxS0r+r8XYO04XSFK3H2Uu/8gfCls2
	DP6OucOR+XUrXqL+OKlVsTqX1LAsV7WzHQEKcApLhDlL3bvnUX1opDO6d//8fLL9Z49Aw7uTeig
	pH7ebziMES0Db+NJqDhfsY3HoD5puUTJDtFGbQTJw4sOYI/EDCFQ5wKZoq1nt+FX3OiBr1qg==
X-Received: by 2002:a05:620a:458b:b0:8b2:7290:27da with SMTP id af79cd13be357-8c52fafd245mr470291685a.12.1768411989233;
        Wed, 14 Jan 2026 09:33:09 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c530b6e7d4sm198764985a.28.2026.01.14.09.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:33:08 -0800 (PST)
Date: Wed, 14 Jan 2026 12:32:36 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kernel-team@meta.com, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Subject: Re: [PATCH 7/8] dax/kmem: add sysfs interface for runtime hotplug
 state control
Message-ID: <aWfTNGMqn7S3b9z9@gourry-fedora-PF4VCD3F>
References: <20260114085201.3222597-1-gourry@gourry.net>
 <20260114085201.3222597-8-gourry@gourry.net>
 <3555385d-23de-492c-8192-a991f91d4343@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3555385d-23de-492c-8192-a991f91d4343@kernel.org>

On Wed, Jan 14, 2026 at 11:55:21AM +0100, David Hildenbrand (Red Hat) wrote:
> On 1/14/26 09:51, Gregory Price wrote:
> > The dax kmem driver currently onlines memory automatically during
> > probe using the system's default online policy but provides no way
> > to control or query the memory state at runtime. Users cannot change
> > the online type after probe, and there's no atomic way to offline and
> > remove memory blocks together.
> > 
> > Add a new 'hotplug' sysfs attribute that allows userspace to control
> > and query the memory state. The interface supports the following states:
> > 
> >    - "offline": memory is added but not online
> >    - "online": memory is online as normal system RAM
> >    - "online_movable": memory is online in ZONE_MOVABLE
> >    - "unplug": memory is offlined and removed
> > 
> > The initial state after probe uses MMOP_SYSTEM_DEFAULT to preserve
> > backwards compatibility - existing systems with auto-online policies
> > will continue to work as before.
> > 
> > The state machine enforces valid transitions:
> >    - From offline: can transition to online, online_movable, or unplug
> >    - From online/online_movable: can transition to offline or unplug
> >    - Cannot switch directly between online and online_movable
> 
> Do we have to support these transitions right from the start?
> 
> What are the use cases for adding memory as offline and then onlining it,
> and why do we have to support that through this interface?
>

the default build config does this, so anyone using the SYSTEM_DEFAULT
will have to at least support this unless we want to change peoples
existing systems.  They'll expect to use the existing pattern.

That is:

add_memory_driver_managed(, SYSTEM_DEFAULT) -> offline
echo online[_*] -> memory*/state

If we disallow "offline", then we essentially leave it "unplugged" and
the second line (existing user policy) breaks.

I thought this would be considered "breaking userland".

I could see disallow "offline" if the memory is "online", and just force
"unplug".

> It would be a lot simpler if we would only allow
> 
> >    - "offline": memory is added but not online
> >    - "online": memory is online as normal system RAM
> >    - "online_movable": memory is online in ZONE_MOVABLE
> >    - "unplug": memory is offlined and removed
> 
> That is, transitioning from offline to online or vice versa fails with
> -ENOSUPP. User space can do that itself through sysfs and if there is ever a
> good use case we can extend this interface here to allow it.
> 
> Or is there a good use case that really requires this?
> 

There's no good use case, just existing users and expected behavior.

~Gregory
