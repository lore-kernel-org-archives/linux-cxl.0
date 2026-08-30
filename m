Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796007E0E4
	for <linux-cxl@vger.kernel.org>; Sun, 30 Aug 2026 06:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788071464; cv=none; b=kx+3rf23LfSQAwIl5PLreEONFy4gO4sNzK7hVqgV37/lLBk5oGhDTq7dfmlK/r5eAkqaskcC0S6gTEXRz/jL6ISZxY7OZu8MXE/AKUwbHO/9czhpsLAxzbL0x2G9hhfDPJZKKmpa0Xy3DftINiFscaCzylyrR528nEixkItK06M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788071464; c=relaxed/simple;
	bh=TSEQiLSfQIx1mLOA+XKxNMty1GQpQ6loxhCgp4N8diU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ci+t3iGrzMWWSVDyQbTo5vkxDdspYqBMoz3H8mo6nra+XZPbakqtIW+8YEO3Y9AJNw1KVF8yE23RsB6rsqSqg+UtTGprA5KKAeStTlro0dzFlABA+uey/S+WvlWhkl03ERb/hSVksBKqJ0xxSv36Y9xHrNfABLzvrSjI87IBlvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYx4AoVa; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYx4AoVa"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-381b831d535so4213828a91.0
        for <linux-cxl@vger.kernel.org>; Sat, 29 Aug 2026 23:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788071463; x=1788676263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7SgG4ULXn9nLszph3Ufioq+asWKXXMJI40EWbAAqIR8=;
        b=lYx4AoVaP9PsYvW9Z9vrh99gpM4LLUA9NiW8Xshx4BkDn0LP9vDpEH6b+k5tf/B/EQ
         TVoauZSzF5tffj60F4Z4DLH/5dRl3+4lP+f476l9eHPEgZsjCWQziTMQRwAN6A2so9ao
         gQkiRajrU/OWg5LK0G0lEkvOXKA0Etsag8ksfRXcZF8LZE1O+AJ3CH7JXbkoZTXKxLoO
         b+LnGjQVyzLmY+SwiosdUOb7+vLSQ+4+FtfovLDMmamUR6/rhyoxxqj1vYUjbpBaBKUo
         4TD2HV9Y3Wy1uiAyMdnVV3DUQOW095v5kGca0JzY2Ih2YyACpaCyuU9q9r64cn2UqpNN
         j8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788071463; x=1788676263;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7SgG4ULXn9nLszph3Ufioq+asWKXXMJI40EWbAAqIR8=;
        b=ngKH9hHB0QeY2XvIrc7ycT8+qUzjCFc1EH8VrIo/jhwXJm0clHHZ0OAtUh8RQjj/sQ
         GFTUkI93/sJpqvcGHGjVI3shguVj8fbu91RA+34igMzm7DngLzOKUwDmMPXD+FJwnEMv
         Hvdy74O8UgusFJZYDBNk8ARpcYSFFADlU4fGPcEy0py5ztkEjoh/3Er8un/e+E9BTPM5
         GzKqzqwiBom4AbXNvsdHprVmu1xz9NSLnz8/5vFs+RKuPDZjclFzhs5leVovALruhOHc
         sEcrjD3ow4XZJ5H0qqIGzz7Z6DFic5I+78ewZsZCaI97cTNuiqyshCI+6uXND1uB66d0
         DTBg==
X-Forwarded-Encrypted: i=1; AKwUvBwJLpioS7HX5f2BSQd9lphtmdHvcq/F2n4ST6rr/HWqgd3g4U145YbhxQfWf+flasjhwdFhBvmJarw=@vger.kernel.org
X-Gm-Message-State: AFuF++n/TR7VMVXdKYjCD0W4NF0sfyNApR4CNt/ikFyQLwUlyubvEYYr
	Ock5GH0UFzUyHLbQN6Sho+Gqf6HpuwC2h4dY/b+BrdZndRMUxUcqnQHG
X-Gm-Gg: AYBFou0mOQHyH/ZaXVSrlQIYicPz8rOaZPy1N/9wKvLLgs1oyI/41wP9seBLPm0hDwh
	NcaaVMZurd9ueSdOvSoDTJ11jZLv/wV6n0UnA/l7UbJfvDGXR3LwSNWE67HN8KvLMsNAP/8eLw0
	+WN440ft5V4diK4L6liBB/pWbxvlXCXXVBshgUhRiMftixWbHrleX26NemioyQYfUxcJdzggCrJ
	XlxD4uJnY55wNCPg0tClrRyHRF6Mt+3+ST06ztbZzTPbB50ruKxsUtiWtOjl6HK/GnjEbOxauKe
	i+cd6J3SKId4M3BdkNQut4KBnw4iXCufHu6R6mL8TDOjyAkBVBsEUeQ/eEP1nyO6wYFlMLjh7Sx
	hQ9O5lbBf+Tsx/ReEm/st2ntvshD2OzyV4A3xS9TKCkRzAw7nfCjWkpSPJTKGvXmVRlaDOOdE22
	jGXOyE4MwUHLKKJCyV/OivTzPf0wHL7E6+zBRSmPsJhJHnY4AtpDmUUuU79BW+0Jo=
X-Received: by 2002:a17:90b:2ec7:b0:395:7fff:a08f with SMTP id 98e67ed59e1d1-396d0c0af4bmr32333507a91.0.1788071462681;
        Sat, 29 Aug 2026 23:31:02 -0700 (PDT)
Received: from localhost ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396d2a73375sm3482434a91.1.2026.08.29.23.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 23:31:02 -0700 (PDT)
Date: Sun, 30 Aug 2026 12:01:00 +0530
From: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>, xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/memdev: Fix deadlock between poison debugfs and
 cxl_mem unbind
Message-ID: <apPOJD_CN-0aMXjQ@acer-nitro-anv15-41>
References: <20260826125248.4003792-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260826125248.4003792-1-kanie@linux.alibaba.com>

On Wed, Aug 26, 2026 at 08:52:48PM +0800, Guixin Liu wrote:
> Writing to the memdev poison debugfs files while cxl_mem is being unbound
> deadlocks. The unbind path takes the memdev device lock and then waits for
> the debugfs file to drain, while the writer holds the debugfs reference and
> waits for that same lock:
> 
>   unbind_store()                     echo 0 > .../mem0/inject_poison
>     device_release_driver_internal()   full_proxy_write()
>       <takes cxlmd->dev lock>            <takes debugfs_file_get() ref>
>       device_unbind_cleanup()            debugfs_attr_write()
>         devres_release_all()               cxl_debugfs_poison_inject()
>           remove_debugfs()                   <waits for cxlmd->dev lock>
>             debugfs_remove_recursive()
>               __debugfs_file_removed()
>                 <waits for the ref to drain>
> 
> Neither side can make progress. A third task piles up behind the held
> device lock: detach_memdev() runs on cxl_bus_wq, and since that is an
> ordered workqueue the wedged work item stalls every other CXL bus work
> item, so unrelated devices stop being rescanned or detached.
> 
> The write side only needs the device lock so that cxl_dpa_to_region() sees
> a stable cxlmd->dev.driver. Nothing requires the caller to wait for the
> lock, so use device_trylock() and report -EBUSY instead. That keeps the
> debugfs reference from ever being held across a wait for the lock, which
> breaks the cycle. A concurrent unbind now either completes before the write
> starts, in which case the write fails with -ENOENT because the file is
> gone, or loses the race and the write reports -EBUSY.
> 
> The unbind task sits in uninterruptible sleep and cannot be killed. The
> writer can be signalled, which is the only reason the current code is
> recoverable at all.
> 
> Reproducer, on a device that advertises poison inject support:
> 
>   while :; do echo 0 > /sys/kernel/debug/cxl/mem0/inject_poison; done &
>   while :; do
>       echo mem0 > /sys/bus/cxl/drivers/cxl_mem/unbind
>       echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
>   done
> 
> This hits within milliseconds. Note that lockdep stays quiet: one end of
> the cycle is the debugfs active_users completion rather than a lock it
> tracks. The hung task detector does report both blocked tasks.
> 
> Fixes: 574eda81d0a7 ("cxl/memdev: Hold memdev lock during memdev poison injection/clear")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>  drivers/cxl/mem.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 798e5c369cfc..01d2d5855694 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -50,11 +50,20 @@ static int cxl_debugfs_poison_inject(void *data, u64 dpa)
>  	struct cxl_memdev *cxlmd = data;
>  	int rc;
>  
> -	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
> -	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
> -		return rc;
> +	/*
> +	 * The debugfs proxy holds a debugfs_file_get() reference across this
> +	 * callback, and cxl_mem unbind removes this file from devres while
> +	 * holding the same device lock. Blocking here would let unbind wait
> +	 * in debugfs_remove() for a reference that cannot be dropped until
> +	 * unbind releases the lock, so never wait for the lock.
> +	 */
> +	if (!device_trylock(&cxlmd->dev))
> +		return -EBUSY;
>  
> -	return cxl_inject_poison(cxlmd, dpa);
> +	rc = cxl_inject_poison(cxlmd, dpa);
> +	device_unlock(&cxlmd->dev);
> +
> +	return rc;
>  }
>  
>  DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_inject_fops, NULL,
> @@ -65,11 +74,14 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
>  	struct cxl_memdev *cxlmd = data;
>  	int rc;
>  
> -	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
> -	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
> -		return rc;
> +	/* Avoid the unbind deadlock described in the inject path above. */
> +	if (!device_trylock(&cxlmd->dev))
> +		return -EBUSY;
> +
> +	rc = cxl_clear_poison(cxlmd, dpa);
> +	device_unlock(&cxlmd->dev);
>  
> -	return cxl_clear_poison(cxlmd, dpa);
> +	return rc;
>  }

Hi Guixin

The analysis and the fix look correct to me. The cycle reduces to:

  Poison writer: holds debugfs reference -> waits for device lock
  Unbind:        holds device lock       -> waits for debugfs refs to drain

Since one leg is the debugfs active_users completion rather than a
tracked lock, lockdep cannot see it and only trylock semantics can break
it -- an interruptible lock would still sleep on the device lock while
holding the debugfs reference, leaving the cycle intact.

Two suggestions:

1. This wants:

   Fixes: 574eda81d0a7 ("cxl/memdev: Hold memdev lock during memdev poison injection/clear")

   since that commit introduced taking the memdev device lock in these
   debugfs entry points, which is what closed the cycle against
   debugfs_remove_recursive() on the unbind path.

2. That same commit used the ACQUIRE(device_intr, ...) conditional
   guard, so rather than open-coding device_trylock()/device_unlock(),
   consider keeping the existing style by adding the trylock sibling of
   commit bb729bf1d6fd ("driver core: Add conditional guard support for
   device_lock()"):

	--- a/include/linux/device.h
	+++ b/include/linux/device.h
	@@
	 DEFINE_GUARD(device, struct device *, device_lock(_T), device_unlock(_T))
	 DEFINE_GUARD_COND(device, _intr, device_lock_interruptible(_T), _RET == 0)
	+DEFINE_GUARD_COND(device, _try, device_trylock(_T))

   and switching the lock class in the debugfs handlers:

	ACQUIRE(device_try, devlock)(&cxlmd->dev);
	if ((rc = ACQUIRE_ERR(device_try, &devlock)))
		return rc;

   device_trylock() returns 1 on success like mutex_trylock(), so the
   default condition applies and ACQUIRE_ERR() yields -EBUSY on
   contention, matching the behavior described above. The device.h hunk
   would need a Cc to the driver core maintainers, same routing as
   bb729bf1d6fd.


Best regards,
Shaikh Kamaluddin

>  
>  DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
> -- 
> 2.43.7
> 
