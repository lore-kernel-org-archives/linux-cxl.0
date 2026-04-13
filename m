Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A71938D688
	for <linux-cxl@vger.kernel.org>; Mon, 13 Apr 2026 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776109098; cv=none; b=qrp+Y5tm+LN4UBBSef3kQbY43mI6jAbM4PSv15L3sX/Q6sGiA55g7eOuuH5amKfA7T3rUKJeCA1FJhnk+f+jFxHqYldNu7qR9xIzGxjpxDg3le4ee1+vJoXj2vtIxYZPnZsrlQ5wRYwBPvKPrmSFP6FYF6fjXtOsntutIUoRerw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776109098; c=relaxed/simple;
	bh=iq+k1kdjsFO//4jKVGXmpkWsGljQ+hWQez+mk2k+r5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cA21HDO262IUcVd9xA12rzgVGz+AWql4i43Tj7QFjySShy2i8XN7eksnYuAYzAuBzc5t/9C9VpdZ7l6H4HzvqL+HqOiErTpDyfAUmgiabCYAjzxASTyUG/0m+wKKsQ/4l7NK4Wk/HaP+IYX1GdXvnUFeh9+M+T3rEt4Yk7qLZdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=pmBdQ1Vh; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="pmBdQ1Vh"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-506a747448dso39146621cf.0
        for <linux-cxl@vger.kernel.org>; Mon, 13 Apr 2026 12:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776109096; x=1776713896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+Cg30G7JazeOMCJRrNEUInL5xwrDgCPHzG/fcerzOo=;
        b=pmBdQ1Vhzc6MKRM6wQtKfOekfO63QxJ0E2e4ICRIqJWjDy5Ir7xLqywcjMZG1F0y9/
         4Mk6+0ZxlEMeRJdZ0uEl3uoOapiiQzL7ekmzBTU1dlpIIt8trF+I65eCLTvAiN+ajOem
         37MTDcNsRoHXuQ+g2i0FAVMsv1OGF0skstzKPWURYjflp9+xzeDYXVoED0NNdVE5V/xd
         QaCNgrbPdNUXF/Xz0BoWOELzpZVGPLzZPYH5vF936Z1w9uHDXR11wPCy0PRZqEiHMuyX
         Sa+v+Y6KZiqscRZDcu7FiAQnoSWoEXkgVt/19ck6OQaRNa5DuoBMEofP+ztE8N3ch+uI
         wDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776109096; x=1776713896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+Cg30G7JazeOMCJRrNEUInL5xwrDgCPHzG/fcerzOo=;
        b=dsgSc6pUs71IIiUEzrPM1Qo/Yw3cDQGsax9xovc3XCBxKC0z1a85VblR5xblt4LvCm
         Ox7I7yv3u9wXhQrFHbCY4EiNyLoCHx2fjh13MmP3dv6WP7CSWI1/c8q726aulaLMlErs
         qBBpFVvqaiLcuKCffN3vtSh0Uc6ejE/oTxye6qoKIfauRRsIJR20n+2yU4YDUoiSuPmv
         WjGjb+MKE/ucrm11ISDWeXq4eF9iFaPWmzZYo8k3fT+6ugsd5iC9/3IdFK2pHDMODCwD
         WRUiyAJWjLWVJVXVOCgAq4MELEaf/36Q1Al3S0GUkrJ5gLphsCzqcrZS0+9M/l6iOZI5
         ngdg==
X-Forwarded-Encrypted: i=1; AFNElJ9eqqM2HoaDi+tlkRay4THh+qIqW3uAAeWPrurs1R2kRK8+C1i/roSCU15uNREFWabFHsqRz17TuJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYu0FzXSNcjgL0B5pnrp2JGJIeRSleVfXMilqMTAhv01y7TKSW
	0vZbj9y9thG4f/Fp6tgVUmHW36SQ6zGLQILJI1betPxkXnettPwA8DWboNWWyJOpb3A=
X-Gm-Gg: AeBDiev4yC/E8l+WAmwWLKRMldcP0kJG13XIyFoUOIu9sB1HyOqeSRBPTJcHUYVPiDX
	vFRtGjtIcUefOW6w0huBzjrycpU6GRU9OdOHqUPpvC5Q6TSYl8LpvYzj/l9EVTiiaABDGaKiyDP
	ImjCi8D/7oN4Tq8R3Ts3iNBjix5z22SfbOW3eKZe+6HxVH0jOm8JStCxJy1hNxRIpgoG50YlTuJ
	R8BB8bWMv7930H6CqG2fw1YYEerMyO5CXWUyG60K9FEtg3LNwnAN8NZSb6N62CKdqKHqf+4BgVM
	/FfVV2leu60vKETCFCEipg4s/AnGTEoPcBcV1egnCfHqZjn9UyfK1FZNvRXY3S3X1EIjk8kwlXB
	rL/gWZFmLnp0IEg2DioRA/Hc0EnWyclsHtfoAabpRw+Shlv7HUz3fYGtXEUfdXz7eHtjsxD+9x7
	71W0JRif6Ye1j2PETruvSC1i6CIrgkGc98IbxUFSRKZLgL/Qul8hGFudSzI1N1dR20e3ZPfq936
	VtEzBT9XdoqXLpCZMPmQl/llTb5Vi/6+w==
X-Received: by 2002:a05:622a:82:b0:50d:8210:eea6 with SMTP id d75a77b69052e-50dd5a97fddmr224412971cf.1.1776109095971;
        Mon, 13 Apr 2026 12:38:15 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-243-150.washdc.fios.verizon.net. [71.191.243.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd564c160sm95841161cf.30.2026.04.13.12.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 12:38:15 -0700 (PDT)
Date: Mon, 13 Apr 2026 15:38:13 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	vishal.l.verma@intel.com, dave.jiang@intel.com, osalvador@suse.de,
	dan.j.williams@intel.com, ljs@kernel.org, Liam.Howlett@oracle.com,
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 0/8] dax/kmem: atomic whole-device hotplug via sysfs
Message-ID: <ad1GJRyAfIAhj1iz@gourry-fedora-PF4VCD3F>
References: <20260321150404.3288786-1-gourry@gourry.net>
 <20260321104021.4a6074330131a2058e8706bd@linux-foundation.org>
 <ab7_AVLgzLaDRcv5@gourry-fedora-PF4VCD3F>
 <a4be48f2-ab0a-4808-a7db-2532ec65ad0b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4be48f2-ab0a-4808-a7db-2532ec65ad0b@kernel.org>

On Mon, Apr 13, 2026 at 05:47:01PM +0200, David Hildenbrand (Arm) wrote:
> 
> So, really only user space can try offlining the memory after requested
> onlining succeeded.
> 
> I don't think any udev rules do that? The usually only request to
> online, which should be fine.
> 

In the offline case the block will cease to exist after offlin/remove
returns, so what should happen is the race on offline just fails and
the stale object cleans itself up on the way out after failure.

Userland temporarily sees a stale memory block but can't do anything
with it because sync'd on hotplug lock.

> So if a user does that manually, good for him. We just have to make sure
> that stuff keeps working as expected.
> 

Yeah the only catch is if a user does something dumb like

    cat block/state -> online_movable
    echo offline > block/state
    echo online > block/state

But like... don't do that :]

Udev won't ever offline-online-race like this, so it's not a real issue.

> Or am I missing a case?
> 

So yeah, I'm fairly confident this just works.

> 
> I'll note that offline_and_remove_memory() can take a long time/forever
> to succeed. User space can abort it by sending a critical signal.
> 
> For example, if you do
> 
> $ echo "unplugged" > magic_device_file
> 
> And it hangs, user space can kill the "echo" command, sending a fatal
> signal and making offline_and_remove_memory() fail.
> 
> The question is, if you want to do your best to revert the other offline
> operations and try re-adding/onlining what you already offlined.
> 
> offline_and_remove_memory() handles that much nicer internally, as it
> tries to revert offlining, and only removes once everything was offlined.
> 
> I think I raised it previously, but you could add a
> offline_and_remove_memory_ranges() that consumes multiple ranges, and
> would do this for you under a single lock_device_hotplug().
> 

I don't think this is a very large lift, just a slightly larger hotplug
locking scope.  But then - the per-range thing in this set should just
work, so let me know if it's worth the extra churn.

~Gregory
