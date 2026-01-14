Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8182FFF80
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768412197; cv=none; b=rH0zPMAM9jq1ERSUNtFdu9bCL805McR3rBFg1Rc6967eHko7LoI/Qv7fgHZq7Tz4MyxjrbsO7j6rdD7ziabU7TedFLHJpvelPqbyDlb7pnGCYQHeC0hW3XatFDvmnVKsc6XX8q+UYnAKWQby9wu2NkosiZu6+Zy8V8oWGoLsfXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768412197; c=relaxed/simple;
	bh=kiL1vI/3XAUWl4aE2fDFyGqz7AzrKtHTl9V5sXFpytI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8TA/5ICnuV1v7Nx37xaMihG/5hdFWGWZP626dSz6AfTMkOKoXI9vVrPLRDs/45WlFPzf5hiIPMpmfL8TY0/ZgtbelJjQpuwyxrExfIFID6spyR+3XhegjcPwbBDVMFPazeDJ08NxLz2VVGhPYUxIZGpwNmuX8i29A5nfq63zow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=JrHV57V+; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="JrHV57V+"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c53421cdbfso8130385a.0
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 09:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768412195; x=1769016995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=figB8dzHwd2D0XvRaWeBpTz4+U95P61NoReY1arrqU0=;
        b=JrHV57V+TkKzL1+/Du7WAZr3Kgjh8CzhskHGmeKTC9mRiwdwYU3NmoofHK0t2riBXO
         9DF+8qDaflAuViw0jCJ+17XeJef2jx1LHwaVeANg1GeVXp8QGfbdjkx9Qne2iotunCPT
         8z31aho5HhUF7BDcIgVoslHuh43euciccmHfOwiZkm0auxskfPYcNq53ep7VHUJE2CXO
         Gi+lxyh5LOIgBifqUVoIBGRl6/8jYd6ZELRukZ8fOXmnkdJI1Y70uyXVyBpcP+EclT/T
         tniL+/HUG7va/RINmzw5M3GFzK2batceRfqy2X0D1jE+cmB+aJg8LCA0kWU6SYcVpELl
         2KkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768412195; x=1769016995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=figB8dzHwd2D0XvRaWeBpTz4+U95P61NoReY1arrqU0=;
        b=baxEI+17yn9nLqHe6uMHx0Pcp4PVeIqO3HwJiykoT7Cjm1ejpKTIuKBIsR9B5g+tqI
         /eaWFfp84cR6oVdTWxZKrmGMxC4nd8SiyvCwOhvLlHTCqzZiDzvug6Cy2fRO60r61cv7
         txli8hPv59R3JNcDi8YLDkPpnNxCEBz6oOlGKb6q8YS5UhPnSfWu7NGDy+w/yXvd+e7c
         73I74SFC8IL/IdN7VS6TbIsxZqnKkBrZ4xk8mbShI+W73eJIYGRLT4tKf66Cgp60BVsm
         TK35N6yKqlzRAcjQUL22ApaFQF/r1h+BSmmSe6yyAny2YssuZJMUsQFySyL2YCNalu70
         ilXA==
X-Forwarded-Encrypted: i=1; AJvYcCVfAa26K2TnyfUpSIbiu/ANg7O1aevKAyNcDN1H+kSoH/hkJaZGplX3+5oreWxhozwUA2whQRcj8n4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNYKhIthYrUifGIrz/LtR9UEW6EKvKq/YdMV0lkBVslDdCqtuh
	VFCqDH105y7GfSsWZr/eHnUAUurKn0oI2VggHoYv53cmBZ3stDRgovsdwh/WRqMeL0E=
X-Gm-Gg: AY/fxX6lvF5gfQ6/VjzIcVOgUNRw25oCGEVWv3Y1rqepWJbwItUDYgyZQtcBJq5IaFy
	/vSUAybu3XB9RQwDsTd0zX8RrzFcrWH0vVP3/b12H/9GFh7eX9urAN32elj2tPwM9VQBAhy+xcf
	ggvJu+oto5MCX0/50GPyMjlz/aWImJJxHENwcwwsFbJBuBrdofgq4k2om0Vo4WO40zH+Pgmr/Pv
	4plkwR0VNxKrBn+l8EGffmX8+2vy+BKhNj+CQtwcMs4x2oxUsjvk5nENnq+FveCf0dmN+utg6Oz
	uRTHc0oSnxYmNi4rvaiMbG8Cow9UdVBZv9LaT80Xmwyr19L34YTWDNT4k7GPxVjOwISclXsk1VU
	hJF5m4Lc60SfEgOw6yVNEbAPQhUS3sDqsX/oQKZgU20ciFCfFORz2nf+RM17vdFnI5EtpcZnzfa
	IJuWiBdchpI7ih7r1FPFiPwG56Y+Gpi4toTubV6+M7oEtfNm7+ZqlqLzH5Rr5zvW/8voe22A==
X-Received: by 2002:a05:620a:4502:b0:8b9:7a1a:8c73 with SMTP id af79cd13be357-8c52fb90a04mr537400485a.46.1768412195222;
        Wed, 14 Jan 2026 09:36:35 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c530a6bdbdsm200764785a.10.2026.01.14.09.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:36:34 -0800 (PST)
Date: Wed, 14 Jan 2026 12:36:02 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kernel-team@meta.com, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, osalvador@suse.de, akpm@linux-foundation.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 8/8] dax/kmem: add memory notifier to block external
 state changes
Message-ID: <aWfUAiag6khaLJpq@gourry-fedora-PF4VCD3F>
References: <20260114085201.3222597-1-gourry@gourry.net>
 <20260114085201.3222597-9-gourry@gourry.net>
 <d1938a63-839b-44a5-a68f-34ad290fef21@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1938a63-839b-44a5-a68f-34ad290fef21@kernel.org>

On Wed, Jan 14, 2026 at 10:44:08AM +0100, David Hildenbrand (Red Hat) wrote:
> On 1/14/26 09:52, Gregory Price wrote:
> > Add a memory notifier to prevent external operations from changing the
> > online/offline state of memory blocks managed by dax_kmem. This ensures
> > state changes only occur through the driver's hotplug sysfs interface,
> > providing consistent state tracking and preventing races with auto-online
> > policies or direct memory block sysfs manipulation.
> > 
> > The notifier uses a transition protocol with memory barriers:
> >    - Before initiating a state change, set target_state then in_transition
> >    - Use a barrier to ensure target_state is visible before in_transition
> >    - The notifier checks in_transition, then uses barrier before reading
> >      target_state to ensure proper ordering on weakly-ordered architectures
> > 
> > The notifier callback:
> >    - Returns NOTIFY_DONE for non-overlapping memory (not our concern)
> >    - Returns NOTIFY_BAD if in_transition is false (block external ops)
> >    - Validates the memory event matches target_state (MEM_GOING_ONLINE
> >      for online operations, MEM_GOING_OFFLINE for offline/unplug)
> >    - Returns NOTIFY_OK only for driver-initiated operations with matching
> >      target_state
> > 
> > This prevents scenarios where:
> >    - Auto-online policies re-online memory the driver is trying to offline
> 
> Is this still a problem when using offline_and_remove_memory() ?
> 

I just remembered another reason I did this:  

echo offline > memoryN/state

This leaves the dax/hotplug state in an inconsistent state.

if you do the above for every block in a dax region, `daxN.M/hotplug`
still shows up as online.

This just hard-locks the state to consistent (unless an online/offline
fails along with its rollback).

The additional complexity seemed warranted for that, but if you're happy
to leave users to their footguns I'm not going to argue it.

---

I just realized this breaks the current ndctl pattern and would force
ndctl to convert to `hotplug` since memory block onlining will fail.

~Gregory
