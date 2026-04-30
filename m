Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DFE2848BA
	for <linux-cxl@vger.kernel.org>; Thu, 30 Apr 2026 04:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777524013; cv=none; b=uHT4qXRNQ37wv448kmDKnjxrHkHVIgHh1P+LOF+/STwDyHF8tgt82ZCMD7+6GiRDoMFaQWp27wNgsIliS8pGcwt8s4ac3oPt9oCAy1SNrPr2luztwhX1H7/VRLRObr+GNUoee7Dc5YcFVpAilyNQCs66pI2Nt8zG0aNOzSTmgSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777524013; c=relaxed/simple;
	bh=weQmzl240UiOVV1FFPuDPP4dDbv1jAURb2KsbFkvJ3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcqmGdO8m6Jxe8f5e5Q8kttLpQ0DuQZbABPM3F2ulg0k0Lc4EykKh1GEifk2XSNLF9hzEt4peXUrVp8sRk2F7HJVX7/qcaubo6Jsr1w21zDzruSdyQl+Jed/k1sIgvgB8d0ehgWW7PuccV3AfWUfI18KvpZjMEjcSxiXZ0bGneQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bb91b426e40so75749566b.0
        for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 21:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777524010; x=1778128810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qz/T5ZTiKaQf+2ei2q62fsye3ZhhA8xr2WcrY8JJu1k=;
        b=rW0/JHpoaHebH5ZjmR+16r3J2RmIqrtBHiKmSzlUapMmAtqjj9IUelNpVscVBL6JTN
         tkwKl6o7R6WwPItuWadfVH6eIpml0sNoFS+1KGh2STnDpGZfKUa08lIf7kYmNQQy+71C
         vq6DDALShmwPvb2MvKbFh3TsIuomgwjaSK7UbovGk+ekLaF0p9hYOQLIzt7kcB1fypEu
         Xjp6J2VHObQomPSaf6KGcq4EPUh+EUINLqJ/AQo9wRc7UxgNT6KOBYVbui9U4/Q1wDBp
         WDTQMDwftPYIW++gnMD97ydfc469FsAIk52HIRi4fIqv9XjMQgfDgNxCpLc1vzPdwdYy
         n4CA==
X-Forwarded-Encrypted: i=1; AFNElJ+cqqVM4tkqa7c+JIlAC2cy7lb0ALMXqNrfNfb/e9VLbw1crhz0rdWs+qbRxNxO1F+ecjh83AM6dDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOurWi2oiDBnWRJjxuK2IoAz8lpcagISP3j8yrlSdtbKYsXZUa
	sjs0c6gjdlS+1oQXiSdd3tnub4xUg/V+E3iiSSFpXjtI2gENv2dYcox/LbFru6SVKE8=
X-Gm-Gg: AeBDiesKWo0ylKMyY9Y+j34o7pwtCzlJ7sOK6KYNcAmUDMC/YFOVEkNKTy36P1zb3Qt
	h0esG1owb2aCDtkcnQJh/ybUVSxrDf2qy8MVlb7zLbEh/8mnxVIn9I0pDkh8nLYox/yNNXIQxY0
	b2U2akuYZopa4f1msjtLce7Ra4otulYjMvwuT28Y6friFCtkuCKe5hpG/+XK2CQjf3vxTyM4C4Z
	1BdOprnGApMeWzd4Db9MWdF+BT2bQ5mRNzcdw2AWBCJgphkqrZZy+SrePv9TmgXW/SXWQbHWofd
	2Psd7rAp/n1AT0xmyghFEW7FJ/4DSPJ2C+WUajvESbYrlikPn/BcM02ezEPORMMjXQvDO5rsu6/
	t+FfFRrQQ+tp2l8P8nEC+/4LAf8ct7T8ldy7hOVc7410rcN1NRCgrFYxFb/h/M7hSN0TfGwTWxE
	VFXPOz+7q0cTjAQKjab3AkMegPyG0+AQN8MrE7akZUkLAUy2t23dknbRg5SsCtYYrkRQ==
X-Received: by 2002:a17:906:dc8f:b0:b9c:4a6c:7dc5 with SMTP id a640c23a62f3a-bbac4aca04emr86819166b.5.1777524009655;
        Wed, 29 Apr 2026 21:40:09 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb980a6f9d6sm176156866b.10.2026.04.29.21.40.09
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 21:40:09 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso2072125e9.3
        for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 21:40:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/pcoqwReIxVjRiNUPI4aOy8TDSCMD84uZqV62+WRAbFmc6Ai8W9e62XIEZBFXielqBUtvSqDX0xUw=@vger.kernel.org
X-Received: by 2002:a05:600c:34c3:b0:48a:56de:d620 with SMTP id
 5b1f17b1804b1-48a84452637mr22103135e9.14.1777524008632; Wed, 29 Apr 2026
 21:40:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427032010.916681-2-iam@sung-woo.kim> <5b46d2ca-7821-4245-92fc-7169ea7435ae@intel.com>
 <CAJNyHpKMMwGnf7+2yzNnSbzozm2ROzfWmWg4xj8gROha+ncQeA@mail.gmail.com>
 <4a20f390-a49d-4a9f-911f-21c36449b990@intel.com> <CAJNyHpJjXCRitQykyNTseGGstP2XbRXroZ+YzkQxMLECj32BUw@mail.gmail.com>
 <7e023076-6603-4a02-8e90-47bdad562b5e@intel.com>
In-Reply-To: <7e023076-6603-4a02-8e90-47bdad562b5e@intel.com>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Thu, 30 Apr 2026 00:39:50 -0400
X-Gmail-Original-Message-ID: <CAJNyHpLFGxu3u7GHLsmL+U0Q3U7hNY3UzYVQmBFSxUuZDzU-wA@mail.gmail.com>
X-Gm-Features: AVHnY4JpTK2KVPqK0TC7LLIZ2bgmRBZzYzwUbY_9URBZ9TCn83l4IskqxejwoOs
Message-ID: <CAJNyHpLFGxu3u7GHLsmL+U0Q3U7hNY3UzYVQmBFSxUuZDzU-wA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] cxl/region: Fix race conditions in cxl region unregistration.
To: Dave Jiang <dave.jiang@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <djbw@kernel.org>, Robert Richter <rrichter@amd.com>, 
	Li Ming <ming.li@zohomail.com>, Gregory Price <gourry@gourry.net>, 
	Ben Widawsky <bwidawsk@kernel.org>, Dave Tian <daveti@purdue.edu>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 6:33=E2=80=AFPM Dave Jiang <dave.jiang@intel.com> w=
rote:
>
>
>
> On 4/28/26 1:28 PM, Sungwoo Kim wrote:
> > Dear Dave, thank you for sharing the patch that doesn't use the workque=
ue.
> >
> > Claude suggests not using wq, since it's simpler. I agree that it's
> > simple, but it's overly tailored to fix a specific bug.
> > Actually, v1[1] proposed a similar patch. So let me bring a patch and
> > discussion from v1:
> >
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 08fa3deef70ab..7ade9aa2aeecc 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -2745,12 +2745,19 @@ static ssize_t delete_region_store(struct devic=
e *dev,
> >   struct cxl_root_decoder *cxlrd =3D to_cxl_root_decoder(dev);
> >   struct cxl_port *port =3D to_cxl_port(dev->parent);
> >   struct cxl_region *cxlr;
> > + int err;
> >
> >   cxlr =3D cxl_find_region_by_name(cxlrd, buf);
> >   if (IS_ERR(cxlr))
> >   return PTR_ERR(cxlr);
> >
> > - devm_release_action(port->uport_dev, unregister_region, cxlr);
> > + err =3D devm_remove_action_nowarn(port->uport_dev, unregister_region,
> > +       cxlr);
> > + if (err) {
> > + put_device(&cxlr->dev);
> > + return err;
> > + }
> > + unregister_region(cxlr);
> >   put_device(&cxlr->dev);
> >
> >   return len;
> >
> > However, v1 has not been merged. Dan[2] commented that "No, that is
> > not an acceptable or comprehensive fix. A subsystem should never try
> > to double unregister a device." Also in the following thread[3], "The
> > patch was technically correct but it relies on a design that requires
> > depending on a double free semantic."
> >
> > I respect this design decision. Then, I need to execute
> > devm_release_[action|all]() only once, which requires a device lock,
> > guard(device)(port->uport_dev). Under a lock, I can check a flag to
> > execute devm_release_[action|all]() only once.
> > To use the lock, a clean work without a prior lock is required. That's
> > a reason this patch ended up in wq.
> >
> > I hope I've explained the rationale for using wq. What do you think?
>
> Right I went back and also read what Dan proposed. I just wonder if we ar=
e over complicating things now and introducing more issues on top by doing =
that. Obviously we have to address the issues sachiko brought up in v3. Bel=
ow is what claude suggested to fix the Sashiko issues in v3 patches. Some o=
f the comments may be excessive but help reading through the changes.

I (and Claude) don't have a better solution than using wq, although I
agree that not using wq is simpler.
Also, I'm not yet experienced enough to decide which is better for
CXL, so I'm happy with both directions. Would you prefer the version
without wq?

>
> Issue 1: Lockless read of p->interleave_ways
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Problem: unregister_region() reads p->interleave_ways without holding
> the region rwsem while __construct_region() may still be initializing it
> under write lock. This can result in reading 0 and skipping target
> detachment, potentially causing use-after-free.
>
> Solution: Acquire rwsem read lock before reading p->interleave_ways to
> serialize with __construct_region(). Add explicit handling for
> interleave_ways =3D=3D 0 (uninitialized region) and use smp_rmb() to ensu=
re
> proper memory ordering.

Memory barrier is a good catch.

>
> Issue 2: Driver unbind/rebind race with workqueue
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> Problem: The async workqueue could execute after driver unbind clears
> the devres list, then operate on a new/empty list after rebind.
>
> Solution: The workqueue already checks if driver is bound before calling
> devm_remove_action(). Added cancel_work_sync() in cxl_region_release()
> to ensure no dangling work when region is freed. Enhanced comments to
> clarify the synchronization.

Sounds good to me.

>
> Issue 3: Use-after-free in construct_region() error path
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> Problem: In the original problematic code, calling unregister_region()
> directly then get_device() created a window where concurrent
> delete_region_store() could free the region.
>
> Solution: Never call unregister_region() directly. The workqueue calls
> devm_remove_action() which invokes unregister_region() in a safe context.
> Reference transfer is now clean - caller's reference is transferred to
> the workqueue, which drops it after work completes.
>
> Key design:
> - unregister_region() is ONLY called as a devm callback (driver unbind
>   or workqueue via devm_remove_action())
> - CXL_REGION_F_UNREGISTER flag is ONLY set by unregister_region() itself,
>   preventing concurrent execution
> - CXL_REGION_F_DEVM_REMOVE flag is set by workqueue to prevent duplicate
>   devm_remove_action() calls
> - Reference counting is clear: lookup refs are transferred to workqueue
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 08b93b14a2c7..4c5771bc4717 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2500,6 +2500,14 @@ static void cxl_region_release(struct device *dev)
>         struct cxl_root_decoder *cxlrd =3D cxlr->cxlrd;
>         int id =3D atomic_read(&cxlrd->region_id);
>
> +       /*
> +        * Ensure pending removal work completes before freeing.
> +        * This is safe even if called from within the work function
> +        * because cancel_work_sync() returns immediately if the work
> +        * is currently executing.
> +        */
> +       cancel_work_sync(&cxlr->remove_work);
> +
>         /*
>          * Try to reuse the recently idled id rather than the cached
>          * next id to prevent the region id space from increasing
> @@ -2544,22 +2552,46 @@ static void unregister_region(void *_cxlr)
>         struct cxl_region_params *p =3D &cxlr->params;
>         int i;
>
> +       /*
> +        * This is ONLY called as a devm callback:
> +        * 1. During driver unbind (devres_release_all)
> +        * 2. Via devm_remove_action() from workqueue
> +        *
> +        * The UNREGISTER flag prevents concurrent execution if both
> +        * paths race (e.g., user delete concurrent with driver unbind).
> +        */
>         if (test_and_set_bit(CXL_REGION_F_UNREGISTER, &cxlr->flags))
>                 return;
>
>         device_del(&cxlr->dev);
>
>         /*
> -        * Now that region sysfs is shutdown, the parameter block is now
> -        * read-only, so no need to hold the region rwsem to access the
> -        * region parameters.
> +        * Sysfs is shutdown, blocking new writers. However, __construct_=
region()
> +        * may still be initializing params under region rwsem write lock=
.
> +        * Acquire read lock to serialize and get consistent view of inte=
rleave_ways.
> +        *
> +        * If interleave_ways is 0, region was never fully initialized.
>          */
> +       guard(rwsem_read)(&cxl_rwsem.region);
> +
> +       /*
> +        * Ensure UNREGISTER flag check happens-before interleave_ways re=
ad.
> +        */
> +       smp_rmb();
> +
> +       if (p->interleave_ways =3D=3D 0) {
> +               /* Not initialized - skip target detachment */
> +               goto out;
> +       }
> +
>         for (i =3D 0; i < p->interleave_ways; i++)
>                 detach_target(cxlr, i);
>
>         cxlr->hpa_range =3D DEFINE_RANGE(0, -1);
>
> +out:
>         cxl_region_iomem_release(cxlr);
> +       /* Drop the devm-owned reference */
>         put_device(&cxlr->dev);

Does this lead to dropping the refcount to below 0 in __construct_region()?
If unregister_region() is called before __construct_region() by
devm_remove_all(), cxlr->dev's refcount can be 0 at this point, and
could lead to use-after-free or refcount underflow in
__construct_region().

Such as:

__create_region()
  devm_cxl_add_region()
    cxl_region_alloc();   // refcount =3D 1   ... (1)
  __construct_region() ... (3)
    get_device(&cxlr->dev); // BUG: refcount is already 0 at (2)

devm_remove_all()
...
  unregister_region() ... (2)
    put_device(); // refcount =3D 0, release.

To fix this, __construct_region() should also check that
unregister_region() has been called. If so, __construct_region()
should return failure.

Thank you!
Sungwoo.


>  }
>
> @@ -2842,22 +2874,59 @@ static bool remove_devm_actions(struct cxl_region=
 *cxlr)
>         return schedule_cxl_region_remove_devm_actions(cxlr);
>  }
>
> +/**
> + * remove_devm_actions_work - Workqueue handler for region removal
> + * @work: work_struct embedded in cxl_region
> + *
> + * Runs in safe context where it can acquire locks and call
> + * devm_remove_action() which will invoke unregister_region() without de=
adlock.
> + *
> + * This ensures unregister_region() is called through the devm system.
> + */
>  static void remove_devm_actions_work(struct work_struct *work)
>  {
>         struct cxl_region *cxlr =3D container_of(work, typeof(*cxlr), rem=
ove_work);
>         struct cxl_root_decoder *cxlrd =3D cxlr->cxlrd;
>         struct cxl_port *port =3D to_cxl_port(cxlrd->cxlsd.cxld.dev.paren=
t);
>
> +       /*
> +        * Prevent multiple attempts to remove devm actions.
> +        * If already set, another thread beat us to it.
> +        */
>         if (test_and_set_bit(CXL_REGION_F_DEVM_REMOVE, &cxlr->flags)) {
>                 put_device(&cxlr->dev);
>                 return;
>         }
>
> +       /*
> +        * Lock port device and verify driver is still bound.
> +        * If driver was unbound, devres_release_all() already called
> +        * unregister_region() and the devres entry is gone.
> +        */
>         scoped_guard(device, port->uport_dev) {
> -               if (port->uport_dev->driver)
> +               if (port->uport_dev->driver) {
> +                       /*
> +                        * Call devm_remove_action() which will:
> +                        * 1. Find and remove the devres entry
> +                        * 2. Call unregister_region(cxlr)
> +                        *
> +                        * The UNREGISTER flag in unregister_region() pre=
vents
> +                        * re-entry if this races with driver unbind.
> +                        */
>                         devm_remove_action(port->uport_dev, unregister_re=
gion, cxlr);
> +               }
> +               /*
> +                * If driver not bound, devres already released everythin=
g.
> +                * The UNREGISTER flag would have prevented duplicate exe=
cution.
> +                */
>         }
>
> +       /*
> +        * Drop the extra reference taken when work was queued.
> +        * After this put_device(), if ref reaches 0, cxl_region_release(=
)
> +        * will be called, which does cancel_work_sync() on this work ite=
m
> +        * (safe because we're about to return from the work function).
> +        */
>         put_device(&cxlr->dev);
>  }
>
> @@ -2868,17 +2937,40 @@ static ssize_t delete_region_store(struct device =
*dev,
>         struct cxl_root_decoder *cxlrd =3D to_cxl_root_decoder(dev);
>         struct cxl_region *cxlr;
>
> -       /* remove_devm_actions_work() will put cxlr->dev. */
> +       /*
> +        * Look up region by name. Takes a reference that will be transfe=
rred
> +        * to the workqueue.
> +        */
>         cxlr =3D cxl_find_region_by_name(cxlrd, buf);
>         if (IS_ERR(cxlr))
>                 return PTR_ERR(cxlr);
>
> -       unregister_region(cxlr);
> +       /*
> +        * Queue work to remove devm action. The workqueue will call
> +        * devm_remove_action() -> unregister_region() in safe context.
> +        *
> +        * unregister_region() will set CXL_REGION_F_UNREGISTER to preven=
t
> +        * concurrent execution. We don't set it here because that would
> +        * cause unregister_region() to return early without cleanup.
> +        *
> +        * The work function expects to hold a reference, and will drop i=
t
> +        * when done. We transfer our lookup reference to the workqueue.
> +        */
>         if (!remove_devm_actions(cxlr)) {
> +               /*
> +                * Failed to queue work. This can happen if:
> +                * - Work already queued (another thread racing)
> +                * - Workqueue stopped
> +                * Drop our reference and return busy.
> +                */
>                 put_device(&cxlr->dev);
>                 return -EBUSY;
>         }
>
> +       /*
> +        * Work queued successfully. The workqueue now owns our reference
> +        * and will drop it after calling devm_remove_action().
> +        */
>         return len;
>  }
>  DEVICE_ATTR_WO(delete_region);
> @@ -3762,11 +3854,32 @@ static struct cxl_region *construct_region(struct=
 cxl_root_decoder *cxlrd,
>
>         rc =3D __construct_region(cxlr, ctx);
>         if (rc) {
> -               /* remove_devm_actions_work() will put the device */
> -               get_device(&cxlr->dev);
> -               unregister_region(cxlr);
> -               if (!remove_devm_actions(cxlr))
> +               /*
> +                * Construction failed. We need to unregister the region.
> +                * We hold a reference from __create_region() above.
> +                *
> +                * Queue work to remove devm action. The work will call
> +                * devm_remove_action() -> unregister_region() which will
> +                * set CXL_REGION_F_UNREGISTER to prevent concurrent exec=
ution.
> +                *
> +                * The work function expects a reference. We transfer our
> +                * reference from __create_region() to the workqueue.
> +                */
> +               if (!remove_devm_actions(cxlr)) {
> +                       /*
> +                        * Failed to queue work. This can happen if:
> +                        * - Another thread already queued removal
> +                        * - Workqueue is stopped
> +                        *
> +                        * In either case, drop our reference and let the=
 other
> +                        * path handle cleanup.
> +                        */
>                         put_device(&cxlr->dev);
> +               }
> +               /*
> +                * If work queued successfully, it now owns our reference
> +                * and will drop it after calling devm_remove_action().
> +                */
>
>                 return ERR_PTR(rc);
>         }
>
