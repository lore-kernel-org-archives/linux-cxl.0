Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420CA34D3BD
	for <linux-cxl@vger.kernel.org>; Fri, 30 Jan 2026 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769794973; cv=none; b=uG/1gtLmDfMT4PEXrAdPz2bMjWtwezk9lMKH6F/oguMTpEoEhEewhn3uYrLMA9jGukx2M9l+qwegBWg04ghqXUBluLXDZS5hhlYjFvAkjcSmMIxy2rUR6A2Vn+o7xNJp4lRhnK0aGHJM+Xs1U+fx2X7xLrAB6vii7So6CEg15iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769794973; c=relaxed/simple;
	bh=qir4Qt/9j0ChreJ1PNmYRC+z+yUclfd5yhERSQ/Q1v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiXeaFhJsEnJZPFkwXGH3/NHBx06NsQnPkA0whVJnPgMUD62wFOeJdE3Cp/KHOSsoGmZ6h1BxJDZ1hGIDZnm0Ro3yKUf/0d8NrJgciecPxbQ3VK2UopciTxlfdrfoDbY6OV9Fejc054WWgfHunNWJ5vQoZ5ZrDTLpinPky8EwYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=B9tOg+xf; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="B9tOg+xf"
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-88a3d2f3299so26695906d6.2
        for <linux-cxl@vger.kernel.org>; Fri, 30 Jan 2026 09:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769794971; x=1770399771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dAyAYHObkSxm3zdHkJL7gWXqxUus0GaV1cyoU1hNpeE=;
        b=B9tOg+xfkYhCrCz9BPjlO+tPnPP0WUVucLCDL6+m1ZwaWESs8GGGvseFVHMnIa5Lqi
         Br3UG1Y9zvkMrYGN6XlRsENeMeZ/++hc/JD1wADMd9skut0RHe2kvTc+nRazeKrtqntT
         JNXpkXMhVTFrkcVAYL2b43jNEgNzOh6ABn8YgRqKqgr1hoy1EQJ3Ju57KeYVs4hQXEYU
         Z9+wy9op4xQizhvrMna8Qhf9nlgXS+1Kv2wd9thswWepkkfuseGym/BVnUi2kdOO6nQ/
         Ib8oJUFA71vZmIUjPvJPNOE7In4Wf3qjV6FNuW9GvSFdui5zgnMzWnZPk99CumTfENeD
         XxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769794971; x=1770399771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAyAYHObkSxm3zdHkJL7gWXqxUus0GaV1cyoU1hNpeE=;
        b=SMNPUjJcGbpagAcZ7GOTMCbgeJbu68uQbltpV67uo+BBhZpXEEM9ENgsnWUK7uGbRT
         LbckS5NKadoi1Zf0jf3NJCo5z2hZUeDupRjJCAt5+XLoXjCR5KUzkZZLQzRcDiqDuaT1
         OcsZZl34SrT/Xeq+aMvL/GGQbJz6T3f0+N02ovu2foOlapfxuufiO3e+vTdZobagF70g
         LBZyfcVH4IaAtpTQErECEGdGYO9oxcshijpB7Drk/6LkFnJSMh6KQPa7JE0XT6nqX4Q6
         QmYcTpGBDJzLCouVBNqPzKgsQASWMqX6a0/qLPyNLS/zj61F/Bt5J829t01GElYAcUqe
         I+sg==
X-Forwarded-Encrypted: i=1; AJvYcCU1NTha5G8u3/reZYpOkrqIKzQaCN3rRc63aPbrJ441o2J7tOX6gReSP/h4yeobFyvxexwjfLaNOLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyusCiHMnbZUlaxXLH8jgejZkjiehjnLw0dls5XfnQxspbv/cFN
	va++5OOIjUWdTtrVPzYoMgZ2ByKaKAo4kRbpF6GcF6h/BjkX6T7cAuLkxoKtpbSHMQw=
X-Gm-Gg: AZuq6aILzGiIgZSgHv+7o/UbUqtZUwBGSIkTsXcFDyOqQgolxS66vQfffEvcMKgZX54
	562x2mHg8LRUXyci3zl/0T+B/yN9+iU4bcWSbYrDe8WSf2SE5iFPC7TOL4rUPfitcIa4Ub6iGp3
	KzyJP1Aii23xaNVYxSCYpt0O0stzDgfUJ6iFOywaASA7UCdTPaj1/7+vtvm8dkrKkRq+uOqKE/g
	SHHHkcdiFK8IEKiMFeGzAsG/Dn+PThkVcC5lqfAPqdpgdVPI9G9NmMTuefXN6r6f2xL2JjOPFI0
	S/4/aOYK8eqa1xD+vvfnByxy+fMDoT9UARe9ywNAD//Diw1Pghwmu7NaBlk1JQepDg2Nz0Meow+
	kBnoOFUphXj7cCJNoE5cK7+RUsqweYV4VFWFDIUUAIHLO1AlYXLBmD8f6h9iChMTF+Ej5n8T/r5
	BFLV3exp6dne0QjPMDbOUWOwhBrBaM9E0rD3cBfK46tNfwMrr9hYpe/kgCkY3iG84orLMdLF8ke
	6khiubk
X-Received: by 2002:a05:6214:e8a:b0:884:5bc7:6590 with SMTP id 6a1803df08f44-894ea026efbmr55102516d6.43.1769794971253;
        Fri, 30 Jan 2026 09:42:51 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d375e1c8sm65386426d6.48.2026.01.30.09.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 09:42:50 -0800 (PST)
Date: Fri, 30 Jan 2026 12:42:49 -0500
From: Gregory Price <gourry@gourry.net>
To: dan.j.williams@intel.com
Cc: Alison Schofield <alison.schofield@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/2] cxl/region: Timeout auto region assembly waiting for
 endpoints
Message-ID: <aXztmSYih24WZgsr@gourry-fedora-PF4VCD3F>
References: <3bcc5143777acc6d45675d78dd8c57079406bc53.1769746294.git.alison.schofield@intel.com>
 <697c3a6155b46_1d6f100e1@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <697c3a6155b46_1d6f100e1@dwillia2-mobl4.notmuch>

On Thu, Jan 29, 2026 at 08:58:09PM -0800, dan.j.williams@intel.com wrote:
> 
> > Cancel the timeout when all expected endpoints attach or the region is
> > unregistered for any reason.
> 
> Setting aside the above, this looks like policy, and every time I see
> policy the first question is "can userspace do it?". It would be
> straightforward for userspace to kick a 30 second watchdog upon each
> region KOBJ_ADD event. Each time that fires go cleanup partially
> assembled regions.
> 
> For example there is no automatic cleanup of partially assembled RAID
> arrays. So, precedent leans towards letting userspace decide what
> happens when composite devices fail assembly.

Sounds like there'll be a nasty race implied here.

Lets assume a kmem region that gets auto-onlined

0) Region is waiting for a device
   1) Final device arrives and starts probing, locking the region
   2) Userspace timeout occurs, firing a cleanup request
2) Region finishes probing
   2a) this creates the dax region
   2b) this creates the dax_kmem device
   2c) this may auto-hotplug into ZONE_NORMAL
   2d) kernel page gets allocated on the memory region
3) Userspace cleanup arrives to unbind
   3a) dax_kmem is online and can't hot-unplug
   3b) dax_kmem abandons hope and leaves the memory online
       (see dev_dax_kmem_remove and remove_memory)
   3c) region cleans up

Final state: region can't be rebound because memory is left online
and unassociated with any device

This will be hard to get right

~Gregory
