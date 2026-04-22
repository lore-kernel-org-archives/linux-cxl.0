Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF35334A79E
	for <linux-cxl@vger.kernel.org>; Wed, 22 Apr 2026 23:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776899614; cv=none; b=O0ILHzRwA81olRdqrP+O+YFIjFt09OZIHHHajwxBcAemBIZohiyVcnw+2MfsToYVHl4VmZ1+UrrFBUcAvnbJmgZG1nJhpio1D7qvB+GOjhE8fUSZtrRGohdLomn6cNKJPkHDRW1uJNCUa4+e6ASM+TAsX3NLjspbdj3b8t1fCzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776899614; c=relaxed/simple;
	bh=snPdnqNjN4bMLMnLQbpIohZ+OE4pGQNk7OOI5jnfiwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d/v718/BiEoD9occFc6zShjbY01IOmrcbjSD78dk2/e0BFKHt8Lg7/bijpeaeMPIOI9jzyd37qItllUFyQkTgKkM9XV7EzxeVvNP/uBwWa4h5UHx30ZTtoqdL0AS4ue/XxSTVw+U3W9wuCWZx0ysmcobza2CVHqbQzQX9GhExVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-66b2d49ffb0so7855878a12.3
        for <linux-cxl@vger.kernel.org>; Wed, 22 Apr 2026 16:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776899611; x=1777504411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yae4zFg77yiVQ3YBtLjxf8xA2pOvc097RwSS7LwABSY=;
        b=Itoa1mJMFX06S2ms/yxB7RnMFRJrrshp9UhoEJyIlxhL399gOu3ifyVUMKH046IXDY
         uDF5PhGlnWg7oitdBGF3yCl2O6BWvZQes+QMV70WIlVXxSTwvsOSKRJdks3CDh3M8R3s
         ikhhv4Bp2L0Kp/jGOCxWX4bREF6hB2+o0OZgKUFwi2GZ9Q0+eU2udN7+FJrInKDDITrq
         oYRxW43uDqRqwoNOfvF2gpY6lsY2JY282bkVpIpwLPnGNptEEs3yYrwDbDESJL+cKXAF
         vBiiW2XSvkmBaD/ZrNYSivOav7XxvLAIkjIYPL02+3dTn/vwp71rNQMC7jFXac48WBIJ
         blrg==
X-Forwarded-Encrypted: i=1; AFNElJ/jz+vcNide9lM2/53X99uSd/jMREKgtNVLJwZqBi/dPbvFnJmsqmgaAZViM1y5WvvkDaJZzHLCTKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN5aE7Pe/2KkrNwUMsHPRJ9CwjrlaHsLG8rfXCIIvBF5GQvxIQ
	SLkbg6Iv+1tFMtKKCRLtT9iJhrf9aES+LhgCawfZlGqpZiGj1i1tWLzJL+cGnSQvbE0=
X-Gm-Gg: AeBDievBx+kZV+XVdBhBcMqupgOHahO9l4uWy/Ll3bnEIlL1KBToP10dYBxtqohjaAt
	lQzB7RusqNNNE/FCDAxMHCBhNMXr6t7RBP/GNmRq3CGvomaGZD9LnSlBJBeYeajwtFp+Q5Oqrrw
	r1xCsA9KvMLYfyexxrdnhEcICIGY9dp1yP7mODKj8qoqtphRDFV0x9b9dWkMJZeXp3uKAuOz84G
	nLFOG+DOszcmfBfusXn7z3jyR0F/ZvO1Opiuu1vusqyjrJUvSBWXX+nKXUKBvOwaDqPO1tzDHgw
	DrULMrYZlQeyHYEd8A3AkUKUux8toWzweuXvNMa1ghiev+93AeRBtR88KUOFTIHfkAE7UmVjt8z
	9GwEOSQzKYhPte/CUgPJqzONOCF5HE2z64ioqEuqYM+EGKRIEH9BdcmnyJfZ4/EcwThZebmi7nn
	fGd8ISeONU91/ZuBWgg8mLXKEWifytsVXxMQPRAV6tJkWtFl3vft0QU5udU4hpF+V4Nw==
X-Received: by 2002:a17:907:948d:b0:ba8:ad6a:a63a with SMTP id a640c23a62f3a-ba8ad6b5d7fmr688806066b.1.1776899611059;
        Wed, 22 Apr 2026 16:13:31 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba45553e9e4sm606505366b.60.2026.04.22.16.13.30
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 16:13:30 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43eb05b1875so3555221f8f.3
        for <linux-cxl@vger.kernel.org>; Wed, 22 Apr 2026 16:13:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8OPHpgCMuXbYFXHYzeZirEAZ/eCcIRYW7TDTfBKWkZhzSaO3pBLdXcSIyYLBmkh2Aghlo18QGBKhw=@vger.kernel.org
X-Received: by 2002:a05:6000:2888:b0:439:c299:4d8f with SMTP id
 ffacd0b85a97d-43fe3dc61e3mr37267327f8f.17.1776899609887; Wed, 22 Apr 2026
 16:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422045637.3048249-2-iam@sung-woo.kim> <afb81a57-0dfc-4cd4-aba8-20d572a7f5aa@intel.com>
In-Reply-To: <afb81a57-0dfc-4cd4-aba8-20d572a7f5aa@intel.com>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Wed, 22 Apr 2026 19:13:12 -0400
X-Gmail-Original-Message-ID: <CAJNyHpJVnaxixygoDVQo492am_BEBeN_MQY2Q7wxDsVwVxic+w@mail.gmail.com>
X-Gm-Features: AQROBzBYLEVUu5gC0Sz6OeE5ripQ5wtVNIeXtvtKlDISK27uyp6YoH91yC5ouPM
Message-ID: <CAJNyHpJVnaxixygoDVQo492am_BEBeN_MQY2Q7wxDsVwVxic+w@mail.gmail.com>
Subject: Re: [PATCH v2] cxl/region: Fix a race bug in delete_region_store
To: Dave Jiang <dave.jiang@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <djbw@kernel.org>, 
	Ben Widawsky <bwidawsk@kernel.org>, Dave Tian <daveti@purdue.edu>, 
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 11:10=E2=80=AFAM Dave Jiang <dave.jiang@intel.com> =
wrote:
>
>
>
> On 4/21/26 9:56 PM, Sungwoo Kim wrote:
> > devm_release_action() cannot find a matching entry in the following two
> > race scenarios.
> >
> > scenario 1: delete two same regions concurrently
> >
> > CPU 0                     CPU 1
> > =3D=3D=3D=3D=3D=3D                    =3D=3D=3D=3D=3D=3D
> > delete_region_store()
> >   cxlr =3D cxl_find_region_by_name()
> >                           delete_region_store()
> >                             cxlr =3D cxl_find_region_by_name()
> >   devm_release_action()
> >                             devm_release_action()
> >                             // cannot find the action, WARN_ON()
> >
> > scenario 2: delete parent and child concurrently [1]
> >
> > CPU0                                    CPU1
> > devres_release_all()
> >    // take devres_lock
> >    remove_nodes(devres_head) // mv to local todo
> >    // drop devres_lock                   delete_region_store()
> >                                            cxlr =3D cxl_find_region_by_=
name()  // success
> >                                            devm_release_action(unregist=
er_region)
> >                                              devres_release()
> >                                                devres_remove()
> >                                                  // hold devres_lock
> >                                                  find_dr(devres_head) /=
/ does not find it
> >                                              WARN_ON(-ENOENT)
> >    release_nodes() // drain todo
> >      unregister_region(cxlr) // release() cb
> >        device_del()
> >
> > To fix scenario 1, delete_region_store() directly calls
> > unregister_region() with a test_and_set_bit(CXL_REGION_F_UNREGISTER).
> > Also, replace devm_release_action() to devm_remove_action() as
> > unregister_region() is now called directly.
> >
> > To fix scenario 2, delete_region_store() removes actions only if the
> > driver is still attached. To ensure this, scoped_guard(device,
> > port->uport_dev) is required to check port->uport_dev->driver.
> > To hold this lock, a workqueue is required for a clean context.
>
> Thank you Sungwoo for the fix. Given that this deals with 2 different sce=
narios, can this be split into 2 patches each address a scenario uniquely?

Sure thing. I think reforming it into a single patchset is better than
splitting it into two distinct patches, since they are highly
relevant.

>
> For scenario 2, can you please put a bit more context in its commit log t=
o explain why a workqueue is needed from your discussion with Dan for futur=
e readers?
>
> Also for the commit log please add context on how these issues were found=
 and what impact was observed and how that effects a user. This information=
 necessary for the Fixes tag dispatching upstream.

Will do in v3. How do you think about impact? I guess the impact (the
warning in devm_release_action()) is low, since the region has already
been released. So, it does not affect users, except for a negligible
warning message.

Apart from the impact, this bug is a case study in cleaning up a
resource, especially when it can be cleaned up by both upper and lower
devices. Since CXL is hierarchical, existing and future CXL components
may have a similar issue with different impacts and need to adopt this
pattern to avoid the same race condition. I'm personally interested in
finding bugs in this direction :)

Thank you!
Sungwoo.

>
> Thanks!
>
> DJ
>
> >
> > Splat:
> >
> > WARNING: drivers/base/devres.c:824 at devm_release_action drivers/base/=
devres.c:824 [inline], CPU#0: syz.1.12224/47589
> > WARNING: drivers/base/devres.c:824 at devm_release_action+0x2b2/0x360 d=
rivers/base/devres.c:817, CPU#0: syz.1.12224/47589
> >
> > [1] https://lore.kernel.org/linux-cxl/20260310183644.4rwc7ilmzy4t5xp6@o=
ffworld/
> >
> > Fixes: 779dd20cfb56 ("cxl/region: Add region creation support")
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> > ---
> > V1: https://lore.kernel.org/linux-cxl/20260308185958.2453707-2-iam@sung=
-woo.kim/
> > V1->V2:
> > - Made devm_remove_action() asynchronous.
> > - Made unregister_region() idempotent.
> > - Addressed Dan's comments and added the suggested-by tag.
> >
> >  drivers/cxl/core/region.c | 45 ++++++++++++++++++++++++++++++++++++---
> >  drivers/cxl/cxl.h         |  8 +++++++
> >  2 files changed, 50 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index e50dc716d4e8..64db0d332c13 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -39,6 +39,7 @@
> >  static nodemask_t nodemask_region_seen =3D NODE_MASK_NONE;
> >
> >  static struct cxl_region *to_cxl_region(struct device *dev);
> > +static void remove_devm_actions_work(struct work_struct *work);
> >
> >  #define __ACCESS_ATTR_RO(_level, _name) {                            \
> >       .attr   =3D { .name =3D __stringify(_name), .mode =3D 0444 },    =
     \
> > @@ -2543,6 +2544,9 @@ static void unregister_region(void *_cxlr)
> >       struct cxl_region_params *p =3D &cxlr->params;
> >       int i;
> >
> > +     if (test_and_set_bit(CXL_REGION_F_UNREGISTER, &cxlr->flags))
> > +             return;
> > +
> >       device_del(&cxlr->dev);
> >
> >       /*
> > @@ -2589,6 +2593,8 @@ static struct cxl_region *cxl_region_alloc(struct=
 cxl_root_decoder *cxlrd, int i
> >       dev->type =3D &cxl_region_type;
> >       cxl_region_setup_flags(cxlr, &cxlrd->cxlsd.cxld);
> >
> > +     INIT_WORK(&cxlr->remove_work, remove_devm_actions_work);
> > +
> >       return cxlr;
> >  }
> >
> > @@ -2831,20 +2837,53 @@ cxl_find_region_by_name(struct cxl_root_decoder=
 *cxlrd, const char *name)
> >       return to_cxl_region(region_dev);
> >  }
> >
> > +static void remove_devm_actions_work(struct work_struct *work)
> > +{
> > +     struct cxl_region *cxlr =3D container_of(work, typeof(*cxlr), rem=
ove_work);
> > +     struct cxl_root_decoder *cxlrd =3D cxlr->cxlrd;
> > +     struct cxl_port *port =3D to_cxl_port(cxlrd->cxlsd.cxld.dev.paren=
t);
> > +
> > +     if (test_and_set_bit(CXL_REGION_F_DEVM_REMOVE, &cxlr->flags)) {
> > +             put_device(&cxlr->dev);
> > +             return;
> > +     }
> > +
> > +     scoped_guard(device, port->uport_dev) {
> > +             if (port->uport_dev->driver)
> > +                     devm_remove_action(port->uport_dev, unregister_re=
gion, cxlr);
> > +     }
> > +
> > +     put_device(&cxlr->dev);
> > +}
> > +
> > +static int remove_devm_actions(struct cxl_region *cxlr)
> > +{
> > +     if (!schedule_work(&cxlr->remove_work))
> > +             return -EBUSY;
> > +
> > +     return 0;
> > +}
> > +
> >  static ssize_t delete_region_store(struct device *dev,
> >                                  struct device_attribute *attr,
> >                                  const char *buf, size_t len)
> >  {
> >       struct cxl_root_decoder *cxlrd =3D to_cxl_root_decoder(dev);
> > -     struct cxl_port *port =3D to_cxl_port(dev->parent);
> >       struct cxl_region *cxlr;
> > +     int rc;
> >
> > +     /* remove_devm_actions_work() will put cxlr->dev. */
> >       cxlr =3D cxl_find_region_by_name(cxlrd, buf);
> >       if (IS_ERR(cxlr))
> >               return PTR_ERR(cxlr);
> >
> > -     devm_release_action(port->uport_dev, unregister_region, cxlr);
> > -     put_device(&cxlr->dev);
> > +     unregister_region(cxlr);
> > +
> > +     rc =3D remove_devm_actions(cxlr);
> > +     if (rc) {
> > +             put_device(&cxlr->dev);
> > +             return rc;
> > +     }
> >
> >       return len;
> >  }
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 1297594beaec..75ec292a9f42 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -447,6 +447,12 @@ struct cxl_region_params {
> >   */
> >  #define CXL_REGION_F_NORMALIZED_ADDRESSING 3
> >
> > +/* Indicate that this region is being unregistered to prevent a race. =
*/
> > +#define CXL_REGION_F_UNREGISTER 4
> > +
> > +/* Indicate that this region called devm_remove_action. */
> > +#define CXL_REGION_F_DEVM_REMOVE 5
> > +
> >  /**
> >   * struct cxl_region - CXL region
> >   * @dev: This region's device
> > @@ -462,6 +468,7 @@ struct cxl_region_params {
> >   * @coord: QoS access coordinates for the region
> >   * @node_notifier: notifier for setting the access coordinates to node
> >   * @adist_notifier: notifier for calculating the abstract distance of =
node
> > + * @remove_work: trigger the remove action in a safe context to acquir=
e locks
> >   */
> >  struct cxl_region {
> >       struct device dev;
> > @@ -477,6 +484,7 @@ struct cxl_region {
> >       struct access_coordinate coord[ACCESS_COORDINATE_MAX];
> >       struct notifier_block node_notifier;
> >       struct notifier_block adist_notifier;
> > +     struct work_struct remove_work;
> >  };
> >
> >  struct cxl_nvdimm_bridge {
>
>
