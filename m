Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2443E559B
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 21:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336515; cv=none; b=d24kN7RCybv9GXnnA1HjZH7kvvh/1hGhjnNNS9GS+sZx8KN+ruOqVHa6HMwfKZlcSdWBhKCFf4q9PaXhDiaolxT9PRdYSpnKLrH9/atUhpl2maLjyaiH6KFc8bBWRTv1xE3uI9UKuxbV2T9L5jz9Qna9VLJDVJbiBhDrMPuboHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336515; c=relaxed/simple;
	bh=/7Bi2SP89UaVH+WNAX/JDNY8yTBbPafOtAVxlzBF7ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQwZ7m/9VvhCfByU5jkpVLvBO+qWzsNWTxGE3Un07y2xvYbzYIa2y8HYhfVjBAcqDOzboXYLXwBgMKs/ykCGOEXVcdrU4+s7SM90020tc5XRTwCn1Sj5HCOSFv0E4rnRE93HKQqQLt6x7YaW+LVtlQYDVIK8sR39ogLDGoUZZvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DvYdHxd9; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DvYdHxd9"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-922ff615c14so156336085a.3
        for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 14:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782336513; x=1782941313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O6KvGnSeke+GyyXEP/Bx0FGRYD1wjPR1HoPpU93wagg=;
        b=DvYdHxd9zbtoTohSbz2k3eLcUytk6DwwZxSO8rU5h43h2c4W3bgrj96dmf8LU4VyrA
         FG5F59FRlQy4H6G2I859FQv4jwi3g0HqKac3HtL3eJzOraJO97V3eW/FqqH5YgWIDr/8
         HY2c68XSclC6yMHUrsCmFSbMzd5+qei94t0OfaCwfMIspRCro1fdSA8aDkZPe2LGQF8a
         JwhwQ7dVgdxLMtcjKxWzNSEc7KxsrRaULdT7mhbc4kPI6EkJF9zDYM52dzgAyBsPYN8j
         fJrDCUk/TiABwYWyCMMHfiwgi705A1iykpPMiDMRKFrhDMOhnS9+uX/gJAJjtuexHDg1
         uX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782336513; x=1782941313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6KvGnSeke+GyyXEP/Bx0FGRYD1wjPR1HoPpU93wagg=;
        b=Kh4zbAdce42ZTtOsD7d35MmRhyTL0IGlqHcO0vJeJQKLh7BuqJSa75V6cf5RmWDBUV
         iDmfnZGhJ6Ij4UzQIptaCAY8rjKoOk6+F8hijQFxsMuRqX3FJLFBdrn0HqO2TeEkbaPU
         WcFzUuOiBc5cmBD80LrBb3mA/fEtao79x4kSx2o+RuStvl9a9aMEWs7w7j0luLw4g0kp
         9ylu6FZah+ynBbq/VfRNjy3ognUPB+e/SBIOd/jyXnxBJQYEq28blTqBMhKT6I3fzerm
         t8J2ZfVpddezYXmV1d3RXGq/W0KXyj8YwCHRa9J+5ZTwwfyMhAhg8j3BrhapNlk51JH6
         OuKA==
X-Forwarded-Encrypted: i=1; AFNElJ9fj7kVDGfTMJcJ5Av0jwg8FPE3Aee83aTFpZg+Idvxa8U/TCKsh+LzBjv6wPbZA5/bFakk8zIgA5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyRH9pChHuUGjZtFE2M7AzxCNkLp2Nw5NtP8oSKgkTKpQjQBSf
	7VL0xrfLbnPN2Mz3dvUaz4Fbq0bPeD0ZLPF6bKaIR7FMbQpqED0GBHhfv4jjMofTkYw=
X-Gm-Gg: AfdE7ckY/+RPX6+6CLQK44vc+6AP6UYAo3/UbSTgT/nqgjWmSjOfoDBdXu7qWZloG4Y
	VKsA9Dp6EQ0xpO+Ljq7UlwyVlDxSlKRuGLysh+3HGJdFsPH0JIG6/ee8sjgcZ2QfLZNX/03cp7b
	aYAsbV/o801peG4F3uzgefIzciejNeyGCutEgplCKQsBZFE3TOoXcZ09sAXxEAB28oWaFIJrQrz
	nb8rWnNrGCseYC2OSpofrSOeuzjV6+kBVsAvESCSONX/PQNJmOFJAybFkKmC3OQspvqgoahZa/W
	Eoxu5qFurr7JbbFdhi+8k47KL4eZZhcfsYaNfw/XQuGRJLpLFuHM+BbMXEgT+KdcMS11FkzFo/7
	19R61oA4Neq8MPj923PH7gmR2Zc/z6571hcLflVNJhqyx5zinGKM+SuvWGysLGMOIJZ6YBCQ+ll
	2CaKWshg6UYTt5Q0hJ5HFTLI22Cq2XDO4tsj9N7AuwCc9SYdEamOevM+V/x+Lv9ucHmbqY
X-Received: by 2002:a05:620a:c45:b0:915:abc4:b570 with SMTP id af79cd13be357-9277ea2e6e2mr831365785a.48.1782336512781;
        Wed, 24 Jun 2026 14:28:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fd39106asm630817585a.7.2026.06.24.14.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:28:32 -0700 (PDT)
Date: Wed, 24 Jun 2026 17:28:27 -0400
From: Gregory Price <gourry@gourry.net>
To: sashiko-reviews@lists.linux.dev
Cc: nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, david@kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v5 8/9] dax/kmem: add sysfs interface for atomic
 whole-device hotplug
Message-ID: <ajxL-5d3JUArPRyo@gourry-fedora-PF4VCD3F>
References: <20260624145744.3532049-1-gourry@gourry.net>
 <20260624145744.3532049-9-gourry@gourry.net>
 <20260624151122.AFE551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624151122.AFE551F000E9@smtp.kernel.org>

On Wed, Jun 24, 2026 at 03:11:21PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The protection against deadlocks during driver unbind can be completely bypassed if the underlying memory blocks are manually onlined via the core memory sysfs, causing state desynchronization.
> 
> commit fa89899811083ada324ea3db8204b1c135005af5
> Author: Gregory Price <gourry@gourry.net>
> Subject: dax/kmem: add sysfs interface for atomic whole-device hotplug
> 
> > @@ -348,20 +490,26 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
> >  #ifdef CONFIG_MEMORY_HOTREMOVE
> >  static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
> >  {
> 
> [ ... ]
> 
> > +	if (dax_kmem_state_is_online(data->state)) {
> > +		dev_warn(dev, "Hotplug regions stuck online until reboot\n");
> > +		any_hotremove_failed = true;
> > +		return;
> > +	} else if (data->state == MMOP_OFFLINE &&
> > +	    dax_kmem_do_hotremove(dev_dax, data)) {
> > +		dev_warn(dev, "Unplug failed, resources leaked until reboot\n");
> >  		return;
> >  	}
> 
> [Severity: High]
> Can this deadlock during unbind if the memory state is desynchronized?
> 
> If the device is configured with auto_online_blocks=offline, data->state is
> initially MMOP_OFFLINE. If a user manually onlines the underlying memory
> blocks via the generic /sys/devices/system/memory/memoryX/state sysfs
> interface, data->state remains MMOP_OFFLINE.
> 
> During unbind, dev_dax_kmem_remove() will evaluate
> dax_kmem_state_is_online(data->state) as false and proceed to call
> dax_kmem_do_hotremove() instead of safely aborting. This attempts to offline
> the blocks while holding the device unbind lock, bypassing the intended
> deadlock protection.
> 

Pulling this feedback onto the list so you know i'm not going to address
both pieces here when it comes back in the next version.

1) dax/state and memoryN/state can become desynced.  We can't do
   anything about this without a memory notifier that prevents this
   desync by disallowing memoryN/state toggling for those blocks.

   https://lore.kernel.org/linux-mm/20260114235022.3437787-6-gourry@gourry.net/

   this unfortunately breaks existing userland tools.  I was told to
   drop the notifier path and explore deprecation at a later time.

2) What I will address: if state=UNPLUGGED we can safely proceed,
   otherwise we'll simply fall back to the old remove_memory() behavior
   where deadlocks are still possible.

   I'll add comments that address this.

~Gregory
