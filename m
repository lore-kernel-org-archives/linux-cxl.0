Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A673323D2A4
	for <linux-cxl@vger.kernel.org>; Tue, 28 Apr 2026 20:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777408143; cv=none; b=lUcsGARTmtYzuO65DhKBxDQIriIFYPd+tipgGfR39kKyvV+T2FvbAKcsXbPvUDETmWdrm+y33E2NCMkMHIGjiIt4N1u/x6cwMUP1CqlhHmzRO6Skg8ROe17tAO65Kn/YA410mhG/Kt10cvu+Qxo9luQ5a/+NTsoLwgHk3u1P/GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777408143; c=relaxed/simple;
	bh=NKVCtzjc1c1vEj7W3utOewOrTqqpRxIzXMSrqsPr6Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqyJDCDr7mgvBEgnUvMaTZy/3OVAj9Sshy5CGRrLPp0ONkBVH91RIvt95qkRt/uGl02a652Z1IZ4G5J8nkzD4koY2mrq2Ftm0adDrVA1duurIMLmzroNPhvuHl7ompVA6jq+F60F10ekLTHsOs5EoxFiuRKM0RGZnABBKAeQaVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ba67b332bbaso1432353066b.0
        for <linux-cxl@vger.kernel.org>; Tue, 28 Apr 2026 13:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777408140; x=1778012940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NE5I47sNT+dcQmmgWOI2lerrkJzoXVJcFIVrqlbVr2w=;
        b=fp2WwZiJKAALTGkwEplBjNXUrFYBwE5C4vNGSnlGepPdpJ7xFN1vtWzYbyBHnqqddK
         ZFgw2Q4Bsg+NTAp8RPr+xmSdnuQOq2BVUIzkBDwbBsomZJJV+nUpAUxCPmTKL2+8Q/Jl
         +RjqQdgZ73jYklMoMa/20fimy+HTCRPc78vKEFe0xVowJAgkiZzAeCtWPWTuSPnucP4c
         2z6AamVhy6S9xos+7e0WjVyOzLd+1+L3X+2ZQ+dT+K14LIYiizLMs2sihdNAMtceXX+F
         Dd+K+b4biq7cZ1Qe5OwUTTWPqe42jyc6XpXlYfpKX5jJ+oQeFT5mmzQTCefOB/qMud0G
         +6Bw==
X-Forwarded-Encrypted: i=1; AFNElJ9BwN8TSw+jPrspQ+wgQ23PHCEAQ3Xgn7xticB+2hr3JTqWJIdDsi08X4pTPsiZHSjrOwxs0DCLdyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTgswT6FalWU05bEqizJBYVihn9vNb8oK9Xctt2hiyFKE4mAjR
	9bdUeQzs2ghOSJwcs/NjLdOqBDghjuxLMPp2nOOt5Twc24xOFwyRQXQAsPZ44+T+u1k=
X-Gm-Gg: AeBDies866AFKfqFg1RuQ8TdBdNzILYr7l7Bm67Ethl/uLg5to7Cmla9zxEOq9yg42E
	wQzw9DswOtGPBpN1Gl67j/PlM23vhHKcSlWofPh7nCA9b0tZ/T0ly0JF0IgyWyVLoY7zVelAvvS
	OruTA3rD3W1EuObHmvCpND2IagwK7r1dm7zYQliCQRm1xqhDChk+4bDh3WvIU9K7ZbZ5RIV033T
	W8Onqp1u5AATD4/AQ0r9pZXfgZFNTepU+yJlIjCfKQEni2NuX7OxEQQ2iNnCN34eovj9kUxBD48
	0GjBMTCvxifhdzjnBp/cT9QLJ9hkOv+7FN/Ib05z1iBpAziY8rZEHh2Ah9pk96UYl9LXrnC1yrZ
	Bylpk0atbZGpncd0t4bC/gOxDSq3sX7On0XnZHLm1c0B5Zi2BjUnBimrXvT1HokLhY8O5GQ9fWU
	Y+UKK/YuUwFdRPIuYDidaf/xTSxvziyp17cKc8YhfECx5QVG2o8zmWY1xy3CHBsIUSew==
X-Received: by 2002:a17:907:a80b:b0:b98:411a:116f with SMTP id a640c23a62f3a-bb93c5a035bmr57630166b.2.1777408139682;
        Tue, 28 Apr 2026 13:28:59 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b21e4bd61sm47066a12.0.2026.04.28.13.28.59
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 13:28:59 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso163338035e9.3
        for <linux-cxl@vger.kernel.org>; Tue, 28 Apr 2026 13:28:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8D9Wd+kD6j5e0qsESwWHtg3NzANT5LCAeA83Ti+hfxTkY0/nzkad6OMwCgDGOfqtSGAx93P6Kpc+4=@vger.kernel.org
X-Received: by 2002:a05:600c:c101:b0:488:8c89:cfaa with SMTP id
 5b1f17b1804b1-48a7b5125b7mr13294345e9.3.1777408138891; Tue, 28 Apr 2026
 13:28:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427032010.916681-2-iam@sung-woo.kim> <5b46d2ca-7821-4245-92fc-7169ea7435ae@intel.com>
 <CAJNyHpKMMwGnf7+2yzNnSbzozm2ROzfWmWg4xj8gROha+ncQeA@mail.gmail.com> <4a20f390-a49d-4a9f-911f-21c36449b990@intel.com>
In-Reply-To: <4a20f390-a49d-4a9f-911f-21c36449b990@intel.com>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Tue, 28 Apr 2026 16:28:41 -0400
X-Gmail-Original-Message-ID: <CAJNyHpJjXCRitQykyNTseGGstP2XbRXroZ+YzkQxMLECj32BUw@mail.gmail.com>
X-Gm-Features: AVHnY4JVmal0wQ03wAJ_ifi-kTd5MdpTYIGo20RRgTjBOBq7JTERzBJ4zkoXR7o
Message-ID: <CAJNyHpJjXCRitQykyNTseGGstP2XbRXroZ+YzkQxMLECj32BUw@mail.gmail.com>
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

Dear Dave, thank you for sharing the patch that doesn't use the workqueue.

Claude suggests not using wq, since it's simpler. I agree that it's
simple, but it's overly tailored to fix a specific bug.
Actually, v1[1] proposed a similar patch. So let me bring a patch and
discussion from v1:

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 08fa3deef70ab..7ade9aa2aeecc 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2745,12 +2745,19 @@ static ssize_t delete_region_store(struct device *d=
ev,
  struct cxl_root_decoder *cxlrd =3D to_cxl_root_decoder(dev);
  struct cxl_port *port =3D to_cxl_port(dev->parent);
  struct cxl_region *cxlr;
+ int err;

  cxlr =3D cxl_find_region_by_name(cxlrd, buf);
  if (IS_ERR(cxlr))
  return PTR_ERR(cxlr);

- devm_release_action(port->uport_dev, unregister_region, cxlr);
+ err =3D devm_remove_action_nowarn(port->uport_dev, unregister_region,
+       cxlr);
+ if (err) {
+ put_device(&cxlr->dev);
+ return err;
+ }
+ unregister_region(cxlr);
  put_device(&cxlr->dev);

  return len;

However, v1 has not been merged. Dan[2] commented that "No, that is
not an acceptable or comprehensive fix. A subsystem should never try
to double unregister a device." Also in the following thread[3], "The
patch was technically correct but it relies on a design that requires
depending on a double free semantic."

I respect this design decision. Then, I need to execute
devm_release_[action|all]() only once, which requires a device lock,
guard(device)(port->uport_dev). Under a lock, I can check a flag to
execute devm_release_[action|all]() only once.
To use the lock, a clean work without a prior lock is required. That's
a reason this patch ended up in wq.

I hope I've explained the rationale for using wq. What do you think?

Thank you!
Sungwoo.

[1] https://lore.kernel.org/linux-cxl/20260308185958.2453707-2-iam@sung-woo=
.kim/
[2] https://lore.kernel.org/linux-cxl/69b0a0f8bfb0b_213210026@dwillia2-mobl=
4.notmuch/
[3] https://lore.kernel.org/linux-cxl/69cc961ef12e8_17890410036@dwillia2-mo=
bl4.notmuch/

On Tue, Apr 28, 2026 at 3:05=E2=80=AFPM Dave Jiang <dave.jiang@intel.com> w=
rote:
>
>
>
> On 4/27/26 10:42 PM, Sungwoo Kim wrote:
> > On Mon, Apr 27, 2026 at 1:42=E2=80=AFPM Dave Jiang <dave.jiang@intel.co=
m> wrote:
> >>
> >>
> >>
> >> On 4/26/26 8:20 PM, Sungwoo Kim wrote:
> >>> This version mainly addresses Dave's comments and meaningful issues r=
eported by Sashiko AI[1].
> >>>
> >>> Overview
> >>> =3D=3D=3D=3D=3D=3D=3D=3D
> >>> This patch series fixes race conditions in cxl region unregistration.
> >>>
> >>> devm_release_action() should be called once, otherwise, it warns abou=
t
> >>> the second call. However, the current implementation has a race condi=
tion
> >>> that allows multiple calls to devm_release_action(). The details are =
in
> >>> each patch.
> >>>
> >>> To fix these, the first patch adds a new function that guarantees tha=
t
> >>> devm_release_action() is called only once.
> >>> Using this function, the second patch subsitutes the current use of
> >>> devm_release_action() in cxl region with the new function.
> >>>
> >>> Change in v3
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> Addressed Dave's comments:
> >>> - Split and made this in a patch series.
> >>> - Enhanced a commit log explaining why a workqueue is used in the fir=
st patch.
> >>> - Added a context on how these issues were found and what impact was =
observed and how that effects a user in the second patch.
> >>> Sashiko AI review fixes:
> >>> - Fixed construct_region() as it also can race.
> >>> - Used a driver's wq instead of system wq so unbinding can drain a wo=
rk.
> >>
> >> A few issues Sashiko raised with the v3.
> >> https://sashiko.dev/#/patchset/20260427032010.916681-2-iam%40sung-woo.=
kim
> >
> > A Sashiko's reasoning makes sense to me. In the middle of
> > construct_region(), users can perform a sysfs write, which then calls
> > unregister_region().
> > unregister_region() must not be called before construct_region() has
> > completed, since it calls device_del() and put_device().
> >
> > This isn't introduced by this patch, but I can fix it in v4.
> >
> > An enable/disable flag to allow sysfs write might fix this, like:
> >
> > static struct cxl_region *construct_region(...)
> > {
> > ... // when a construction is done
> >   set_bit(CXL_REGION_F_ENABLE_SYSFS);
> >   return cxlr;
> > }
> >
> > This prevents a sysfs write before it's done:
> >
> > static ssize_t delete_region_store(...)
> > {
> >   if (!test_bit(CXL_REGION_F_ENABLE_SYSFS)) {
> >     return -EBUSY;
> >   }
> > ...
> > }
> >
> > Would there be a better solution? I'd like to ask for comments on this.
> > This patch series already introduces two new flags, and I'm concerned
> > about adding another.
>
> Sungwoo,
> I looked at the sachiko raised issues and looked at the current patches. =
I threw the sachiko objections and the current patches at Claude and it say=
s the workqueue change made this more complicated and proposed this solutio=
n. Seems reasonable. What do you think?
>
> ---
>
>     Race 1: Concurrent delete_region_store() calls
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     CPU 0                                  CPU 1
>     delete_region_store()                  delete_region_store()
>       cxl_find_region_by_name()              cxl_find_region_by_name()
>       devm_release_action()                  devm_release_action()
>         unregister_region()                    WARN_ON(-ENOENT)
>
>     The second call fails because the devm action was already removed.
>
>     Race 2: Concurrent delete and driver unbind
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     CPU 0                                  CPU 1
>     delete_region_store()                  driver unbind
>       cxl_find_region_by_name()              devres_release_all()
>       devm_release_action()                    unregister_region()
>         unregister_region()                    // cleanup done
>         // cleanup done again!
>                                              WARN_ON(-ENOENT)
>
>     Race 3: Use-after-free during construction
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     CPU 0: __construct_region()            CPU 1: delete_region_store()
>     device_add(&cxlr->dev)
>       // Region visible in sysfs!
>                                            cxl_find_region_by_name()
>                                              // SUCCESS!
>     __construct_region(cxlr)
>       p =3D &cxlr->params
>       // p->interleave_ways still 0
>                                            unregister_region(cxlr)
>                                              device_del()
>                                              for (i =3D 0; i < 0; i++)
>                                                // LOOP SKIPPED!
>                                              put_device(&cxlr->dev)
>                                              // refcount -> 0
>                                            // cxlr FREED!
>
>       p->interleave_ways =3D ctx->...        // USE-AFTER-FREE!
>       p->state =3D INTERLEAVE_ACTIVE         // USE-AFTER-FREE!
>
>     The Solution
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>     1. Make unregister_region() idempotent using CXL_REGION_F_UNREGISTER =
flag
>        Multiple concurrent calls will have one do the cleanup and others
>        return early safely.
>
>     2. Use synchronous devm_remove_action_nowarn() instead of devm_releas=
e_action()
>        - Call unregister_region() first (idempotent cleanup)
>        - Then remove devm action with _nowarn variant
>        - -ENOENT is benign in all race scenarios:
>          * devres_release_all() already handled it
>          * Driver unbind/rebind race (old action gone, new devres list)
>
>     3. Protect params read in unregister_region() with lock
>        Use scoped_guard(rwsem_read) to safely read interleave_ways even
>        during concurrent construction. If state < INTERLEAVE_ACTIVE, the
>        region is still initializing and ways=3D0 is correct.
>
>     4. Add memory barriers for state transitions
>        Use smp_store_release() in __construct_region() and smp_load_acqui=
re()
>        in unregister_region() to ensure proper ordering of initialization=
.
>
>     5. Hold extra reference during construct_region()
>        Prevents premature freeing if unregister races during initializati=
on.
>
>     6. Check unregister flag in __construct_region()
>        Abort construction early if delete_region_store() raced after
>        device_add() but before acquiring the write lock.
>
>     This approach is simpler and more correct than async workers because:
>     - Relies on fundamental kernel primitives (idempotency + locks)
>     - No TOCTOU races with driver binding state
>     - Fewer lines of code
>     - Handles all race scenarios correctly
>
>     Race Scenario Analysis:
>
>     | Scenario                  | Outcome                              |
>     |---------------------------|--------------------------------------|
>     | Normal delete             | Cleanup done, action removed         |
>     | Concurrent deletes        | One cleans up, others return early   |
>     | Delete + driver unbind    | One cleans up, other gets -ENOENT    |
>     | Delete + unbind/rebind    | Old action handled, -ENOENT benign   |
>     | Delete during construct   | Extra ref prevents UAF, lock protects|
>
> ---
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e50dc716d4e8..8474756913e6 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2541,16 +2541,45 @@ static void unregister_region(void *_cxlr)
>  {
>         struct cxl_region *cxlr =3D _cxlr;
>         struct cxl_region_params *p =3D &cxlr->params;
> -       int i;
> +       int i, ways;
> +
> +       /*
> +        * Idempotency: prevent multiple concurrent calls to unregister_r=
egion().
> +        * This can happen if user calls delete_region_store() while driv=
er
> +        * unbind triggers devres_release_all() concurrently.
> +        */
> +       if (test_and_set_bit(CXL_REGION_F_UNREGISTER, &cxlr->flags))
> +               return;
>
>         device_del(&cxlr->dev);
>
>         /*
> -        * Now that region sysfs is shutdown, the parameter block is now
> -        * read-only, so no need to hold the region rwsem to access the
> -        * region parameters.
> +        * Even though sysfs is shutdown, the region may still be initial=
izing
> +        * if construct_region() is running concurrently. We must safely =
read
> +        * interleave_ways under lock to avoid reading uninitialized valu=
es.
> +        *
> +        * Use a read lock (not write) to allow concurrent operations if =
needed.
> +        * Read the ways count under lock, then release before the loop t=
o
> +        * minimize lock hold time.
> +        *
> +        * Memory ordering: use smp_load_acquire() to ensure we see the f=
ully
> +        * initialized value of interleave_ways if state >=3D INTERLEAVE_=
ACTIVE.
>          */
> -       for (i =3D 0; i < p->interleave_ways; i++)
> +       scoped_guard(rwsem_read, &cxl_rwsem.region) {
> +               /*
> +                * Pairs with smp_store_release() in __construct_region()=
.
> +                * Ensures if we see state >=3D INTERLEAVE_ACTIVE, we als=
o see
> +                * the initialized interleave_ways value.
> +                */
> +               enum cxl_config_state state =3D smp_load_acquire(&p->stat=
e);
> +
> +               if (state >=3D CXL_CONFIG_INTERLEAVE_ACTIVE)
> +                       ways =3D READ_ONCE(p->interleave_ways);
> +               else
> +                       ways =3D 0; /* Still initializing, nothing to det=
ach */
> +       }
> +
> +       for (i =3D 0; i < ways; i++)
>                 detach_target(cxlr, i);
>
>         cxlr->hpa_range =3D DEFINE_RANGE(0, -1);
> @@ -2838,14 +2867,48 @@ static ssize_t delete_region_store(struct device =
*dev,
>         struct cxl_root_decoder *cxlrd =3D to_cxl_root_decoder(dev);
>         struct cxl_port *port =3D to_cxl_port(dev->parent);
>         struct cxl_region *cxlr;
> +       int rc;
>
>         cxlr =3D cxl_find_region_by_name(cxlrd, buf);
>         if (IS_ERR(cxlr))
>                 return PTR_ERR(cxlr);
>
> -       devm_release_action(port->uport_dev, unregister_region, cxlr);
> +       /*
> +        * Call unregister_region() first to do the cleanup. This is
> +        * idempotent (CXL_REGION_F_UNREGISTER flag), so if
> +        * devres_release_all() calls it concurrently, one will do the
> +        * work and the other will return early.
> +        */
> +       unregister_region(cxlr);
> +
> +       /*
> +        * Now remove the devm action to prevent devres_release_all()
> +        * from calling unregister_region() again during driver unbind.
> +        *
> +        * Three possible outcomes:
> +        *
> +        * 1. Success: We removed the action before driver unbind.
> +        *    Driver unbind won't call unregister_region().
> +        *
> +        * 2. -ENOENT: devres_release_all() already removed the action
> +        *    and called unregister_region() (which returned early due
> +        *    to F_UNREGISTER flag). This is benign.
> +        *
> +        * 3. -ENOENT: Driver was unbound and rebound between
> +        *    unregister_region() above and here. The old action was
> +        *    already handled by the old unbind. The new binding has
> +        *    no action for this region. This is benign.
> +        *
> +        * Use _nowarn variant since -ENOENT is expected and benign.
> +        * The devres_lock serializes access, so we can't corrupt the
> +        * devres list.
> +        */
> +       rc =3D devm_remove_action_nowarn(port->uport_dev, unregister_regi=
on, cxlr);
> +       if (rc && rc !=3D -ENOENT)
> +               dev_warn(&cxlr->dev,
> +                        "Unexpected error removing devm action: %d\n", r=
c);
> +
>         put_device(&cxlr->dev);
> -
>         return len;
>  }
>  DEVICE_ATTR_WO(delete_region);
> @@ -3644,6 +3707,16 @@ static int __construct_region(struct cxl_region *c=
xlr,
>                 return -EBUSY;
>         }
>
> +       /*
> +        * Check if region is being unregistered concurrently. This can h=
appen
> +        * if user triggers delete_region_store() right after device_add(=
) but
> +        * before we acquire the write lock above.
> +        */
> +       if (test_bit(CXL_REGION_F_UNREGISTER, &cxlr->flags)) {
> +               dev_dbg(&cxlr->dev, "Region unregister in progress, abort=
ing construction\n");
> +               return -EBUSY;
> +       }
> +
>         set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
>         cxlr->hpa_range =3D *hpa_range;
>
> @@ -3686,7 +3759,16 @@ static int __construct_region(struct cxl_region *c=
xlr,
>         p->res =3D res;
>         p->interleave_ways =3D ctx->interleave_ways;
>         p->interleave_granularity =3D ctx->interleave_granularity;
> -       p->state =3D CXL_CONFIG_INTERLEAVE_ACTIVE;
> +
> +       /*
> +        * Use smp_store_release() to ensure all initialization above is
> +        * visible before state becomes INTERLEAVE_ACTIVE. This pairs wit=
h
> +        * smp_load_acquire() in unregister_region().
> +        *
> +        * This ensures that if unregister_region() sees state >=3D
> +        * INTERLEAVE_ACTIVE, it will also see the initialized interleave=
_ways.
> +        */
> +       smp_store_release(&p->state, CXL_CONFIG_INTERLEAVE_ACTIVE);
>
>         rc =3D sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_=
group());
>         if (rc)
> @@ -3728,12 +3810,31 @@ static struct cxl_region *construct_region(struct=
 cxl_root_decoder *cxlrd,
>                 return cxlr;
>         }
>
> +       /*
> +        * Hold an extra reference during initialization to prevent
> +        * unregister_region() from freeing the object if delete_region_s=
tore()
> +        * races with __construct_region(). The device_initialize() in
> +        * cxl_region_alloc() set refcount=3D1, and device_add() above ma=
de it
> +        * visible, so a concurrent unregister could drop that reference =
while
> +        * we're still initializing.
> +        */
> +       get_device(&cxlr->dev);
> +
>         rc =3D __construct_region(cxlr, ctx);
>         if (rc) {
> -               devm_release_action(port->uport_dev, unregister_region, c=
xlr);
> +               /*
> +                * Construction failed. Unregister the partially initiali=
zed
> +                * region and remove the devm action. Both are safe to ca=
ll
> +                * due to idempotency and proper locking.
> +                */
> +               unregister_region(cxlr);
> +               devm_remove_action_nowarn(port->uport_dev, unregister_reg=
ion, cxlr);
> +
> +               put_device(&cxlr->dev); /* Drop construction reference */
>                 return ERR_PTR(rc);
>         }
>
> +       put_device(&cxlr->dev); /* Drop construction reference */
>         return cxlr;
>  }
>
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1297594beaec..81952f0763e1 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -447,6 +447,13 @@ struct cxl_region_params {
>   */
>  #define CXL_REGION_F_NORMALIZED_ADDRESSING 3
>
> +/*
> + * Indicate that this region is being unregistered. Used to make
> + * unregister_region() idempotent and prevent race conditions between
> + * delete_region_store() and devres_release_all().
> + */
> +#define CXL_REGION_F_UNREGISTER 4
> +
>  /**
>   * struct cxl_region - CXL region
>   * @dev: This region's device
>
