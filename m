Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377A1306B1B
	for <linux-cxl@vger.kernel.org>; Thu, 23 Apr 2026 02:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776912786; cv=none; b=FWpjiv09xBwHHa6enTjxKOrI9hbvTu5YYhAbswNa3l50icudF8X7rF6iIxnArQFezqL5gOX7eifE/YH37NbITbkGQAT0u7hzORfA2Umc7OBxXN/aU32aEOzCHwyuP+Uk7pnkBQZf+qJDgoZv3dwwKXk3g9RyDcAYPEUr0xdQUAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776912786; c=relaxed/simple;
	bh=5Lcd36kvdkkOyv/xofyXkJPrjHvo28uig6EffiTjSiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXSHboYK4pULasrSqsX1BB350Hw4iOrxGfl4IzBWqTJjbjDt+GUtMMQghuC6A+5eLMjDKiMknZVK6k9fYPiulVCJIxS1mbHAjAJEnmiAziWYR1vQx0lVU+Tn4IZ7VH+xAz4JSBn2vsEB0OkeUoYJ2kys5rHuWqPhbTkUKhxR17c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-66d65646c65so261102a12.1
        for <linux-cxl@vger.kernel.org>; Wed, 22 Apr 2026 19:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776912782; x=1777517582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9HAoGjnNFM2+q0F2AC/fCbC7H6tq/YD/bj0Nyyj8Skg=;
        b=hm5ggSED/6demtrWE3SEzfv6Hrp2okQV6oQ3ZqOlGUE9IyN0BnSD8QcdE6gbZx70Z5
         XXCuItq7w1TPhpj15AVtoFqPMkRr5sbqL/dTrac9FhpcaMTYbh9OTMmOckWAy4NznqDm
         BaLH/QlHczpTLoIMsPeeAEcQTL0Ye/lGGQkmaSUwtXX1zr29JlLo0+U1cdbUdLnMNulP
         YTG0DvGFVKs+W4gRHGiEyv6qK/9tYX0VEQyCk3SCml3o9gUQGZbx/c4afn7gfTx9L+Vo
         iZ03YtPkQ0nxbsM1+le6X/pS6OhV5loxWvbjgDMqwNzY41PnTg1zmLxpsFziFc96ZU1r
         EM+g==
X-Forwarded-Encrypted: i=1; AFNElJ8UusZFjfuJwNHdgycPzdY6MShJlWMQg5eCtglN94aoaXhDXkMRiVytLJTEkiRUdXXfFMFZbOHFmgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpLPGXWmN4bcz74j97YTChev3oF4nRqhv6CfW949kIq3zYKpxe
	+SQCUY4gOxJqi+6zV8Nm4s5nP6dtXNHBYdbQ5xX4ehrbmnYZIPgA2mIoNuQJQiXSB0bkug==
X-Gm-Gg: AeBDieu11GKTFxPLfalhQRS476e/U6d0KL8VwXZtrlnaQCV+UiU1aoT8l/Wr1KGafr4
	azW4EVEDIEby/nwlMIuxXIu9yPh9utkxrv6LqhjZKv7X1tfsGzrjjJubM+Qpza+bBAZ2ZpxlARI
	ZBmn3x0OeDPItobKpE9tTxPGwU6AgNcQ9CwX74WFA5+pUCMyrZ/2LFWtz3DQ6YJjRFQVpLxxNGE
	MAMG7uUFcTK1lpVoeQks2CSgK2KIyjtde+XSAQ+EQ6yIWMhpZVk5FRnuFj4DSUm8+MXnrZQUWJi
	itvEO0Ajw212QyAs74ifuk2I4OpzJjBydMb9qjExpzPZHNUIvNlsKzJnTqHg2TzXuMhkOBmRdGz
	N1VHZyHtd5pIBIRY1uiR54UOuzl/pkIGVeyJj0MZNNxZrsnoj0CJRC5qdrVPRf/MY2Y9t3qv2fu
	Kv2BcIF4Qskhfco+fiiV/6QW0PgmPlJBM6iIHgl1h/uLGZbBThfqruiLNAcLZDD09aaA==
X-Received: by 2002:aa7:da10:0:b0:672:524f:525d with SMTP id 4fb4d7f45d1cf-672c0f808bcmr7209583a12.8.1776912781863;
        Wed, 22 Apr 2026 19:53:01 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c480e2d2sm3561463a12.12.2026.04.22.19.52.59
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 19:53:00 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d70c30767so4146571f8f.0
        for <linux-cxl@vger.kernel.org>; Wed, 22 Apr 2026 19:52:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/ywN/M2Ofr5Pkd0XDRacWQOV2JH23FCzbOGjc3Xn9KYuEyoJkYrtokuQZP9/djxiICiX4chwmyVFU=@vger.kernel.org
X-Received: by 2002:a5d:6f13:0:b0:43e:a703:3675 with SMTP id
 ffacd0b85a97d-43fe40329ecmr33573473f8f.5.1776912779227; Wed, 22 Apr 2026
 19:52:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422045637.3048249-2-iam@sung-woo.kim>
In-Reply-To: <20260422045637.3048249-2-iam@sung-woo.kim>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Wed, 22 Apr 2026 22:52:42 -0400
X-Gmail-Original-Message-ID: <CAJNyHpL22nbS5AcPAyBPOX4rb1S-TSem97zCouyT_xw2jmFyXA@mail.gmail.com>
X-Gm-Features: AQROBzDAeUBo12-oIaGK7V3z5xonvdQ29_Q6mFGNEDjCsnzBloI3qJ85w1J1OpA
Message-ID: <CAJNyHpL22nbS5AcPAyBPOX4rb1S-TSem97zCouyT_xw2jmFyXA@mail.gmail.com>
Subject: Re: [PATCH v2] cxl/region: Fix a race bug in delete_region_store
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Dan Williams <djbw@kernel.org>, Ben Widawsky <bwidawsk@kernel.org>
Cc: Dave Tian <daveti@purdue.edu>, Dan Williams <dan.j.williams@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is a follow-up based on Sashiko's review.
https://sashiko.dev/#/patchset/20260422045637.3048249-2-iam%40sung-woo.kim

In sum, using a global system wq was a wrong choice. Instead, use a
cxl's wq to match wq and the driver's lifetime.
Also, Sashiko figured out a new race scenario in construct_region().

On Wed, Apr 22, 2026 at 1:00=E2=80=AFAM Sungwoo Kim <iam@sung-woo.kim> wrot=
e:
>
> devm_release_action() cannot find a matching entry in the following two
> race scenarios.
>
> scenario 1: delete two same regions concurrently
>
> CPU 0                     CPU 1
> =3D=3D=3D=3D=3D=3D                    =3D=3D=3D=3D=3D=3D
> delete_region_store()
>   cxlr =3D cxl_find_region_by_name()
>                           delete_region_store()
>                             cxlr =3D cxl_find_region_by_name()
>   devm_release_action()
>                             devm_release_action()
>                             // cannot find the action, WARN_ON()
>
> scenario 2: delete parent and child concurrently [1]
>
> CPU0                                    CPU1
> devres_release_all()
>    // take devres_lock
>    remove_nodes(devres_head) // mv to local todo
>    // drop devres_lock                   delete_region_store()
>                                            cxlr =3D cxl_find_region_by_na=
me()  // success
>                                            devm_release_action(unregister=
_region)
>                                              devres_release()
>                                                devres_remove()
>                                                  // hold devres_lock
>                                                  find_dr(devres_head) // =
does not find it
>                                              WARN_ON(-ENOENT)
>    release_nodes() // drain todo
>      unregister_region(cxlr) // release() cb
>        device_del()
>
> To fix scenario 1, delete_region_store() directly calls
> unregister_region() with a test_and_set_bit(CXL_REGION_F_UNREGISTER).
> Also, replace devm_release_action() to devm_remove_action() as
> unregister_region() is now called directly.
>
> To fix scenario 2, delete_region_store() removes actions only if the
> driver is still attached. To ensure this, scoped_guard(device,
> port->uport_dev) is required to check port->uport_dev->driver.
> To hold this lock, a workqueue is required for a clean context.
>
> Splat:
>
> WARNING: drivers/base/devres.c:824 at devm_release_action drivers/base/de=
vres.c:824 [inline], CPU#0: syz.1.12224/47589
> WARNING: drivers/base/devres.c:824 at devm_release_action+0x2b2/0x360 dri=
vers/base/devres.c:817, CPU#0: syz.1.12224/47589
>
> [1] https://lore.kernel.org/linux-cxl/20260310183644.4rwc7ilmzy4t5xp6@off=
world/
>
> Fixes: 779dd20cfb56 ("cxl/region: Add region creation support")
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> ---
> V1: https://lore.kernel.org/linux-cxl/20260308185958.2453707-2-iam@sung-w=
oo.kim/
> V1->V2:
> - Made devm_remove_action() asynchronous.
> - Made unregister_region() idempotent.
> - Addressed Dan's comments and added the suggested-by tag.
>
>  drivers/cxl/core/region.c | 45 ++++++++++++++++++++++++++++++++++++---
>  drivers/cxl/cxl.h         |  8 +++++++
>  2 files changed, 50 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e50dc716d4e8..64db0d332c13 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -39,6 +39,7 @@
>  static nodemask_t nodemask_region_seen =3D NODE_MASK_NONE;
>
>  static struct cxl_region *to_cxl_region(struct device *dev);
> +static void remove_devm_actions_work(struct work_struct *work);
>
>  #define __ACCESS_ATTR_RO(_level, _name) {                              \
>         .attr   =3D { .name =3D __stringify(_name), .mode =3D 0444 },    =
     \
> @@ -2543,6 +2544,9 @@ static void unregister_region(void *_cxlr)
>         struct cxl_region_params *p =3D &cxlr->params;
>         int i;
>
> +       if (test_and_set_bit(CXL_REGION_F_UNREGISTER, &cxlr->flags))
> +               return;
> +
>         device_del(&cxlr->dev);
>
>         /*
> @@ -2589,6 +2593,8 @@ static struct cxl_region *cxl_region_alloc(struct c=
xl_root_decoder *cxlrd, int i
>         dev->type =3D &cxl_region_type;
>         cxl_region_setup_flags(cxlr, &cxlrd->cxlsd.cxld);
>
> +       INIT_WORK(&cxlr->remove_work, remove_devm_actions_work);
> +
>         return cxlr;
>  }
>
> @@ -2831,20 +2837,53 @@ cxl_find_region_by_name(struct cxl_root_decoder *=
cxlrd, const char *name)
>         return to_cxl_region(region_dev);
>  }
>
> +static void remove_devm_actions_work(struct work_struct *work)
> +{
> +       struct cxl_region *cxlr =3D container_of(work, typeof(*cxlr), rem=
ove_work);
> +       struct cxl_root_decoder *cxlrd =3D cxlr->cxlrd;
> +       struct cxl_port *port =3D to_cxl_port(cxlrd->cxlsd.cxld.dev.paren=
t);
> +
> +       if (test_and_set_bit(CXL_REGION_F_DEVM_REMOVE, &cxlr->flags)) {
> +               put_device(&cxlr->dev);
> +               return;
> +       }
> +
> +       scoped_guard(device, port->uport_dev) {
> +               if (port->uport_dev->driver)

A rapid driver unbind-and-rebind can happen before this work. If so,
the work becomes stale, and devm_remove_action() is called on the
rebound driver, which has no reason to remove an action.

To fix this, use a driver's wq instead of system wq so unbinding can
drain this work.

> +                       devm_remove_action(port->uport_dev, unregister_re=
gion, cxlr);
> +       }
> +
> +       put_device(&cxlr->dev);
> +}
> +
> +static int remove_devm_actions(struct cxl_region *cxlr)
> +{
> +       if (!schedule_work(&cxlr->remove_work))

This code can introduce use-after-free because the global system wq is
not flushed when the kernel module is unloaded.
After unloading the module, this can execute free'd remove_devm_actions_wor=
k().

To fix this, use a driver's wq instead of system wq so unbinding can
drain this work.

> +               return -EBUSY;
> +
> +       return 0;
> +}

Sashiko suggested a new race scenario. construct_region() can also
race with delete_region_store().

drivers/cxl/core/region.c:construct_region() {
  ...
  /* remove_devm_actions_work() can be scheduled and run at this point */
  rc =3D __construct_region(cxlr, ctx);
  if (rc) {
    /* this will fail to find an action and trigger WARN_ON */
    devm_release_action(port->uport_dev, unregister_region, cxlr);
    return ERR_PTR(rc);
  }
  ...
}

To fix this, construct_region() should directly call
unregister_region() and schedule remove_devm_actions_work().

> +
>  static ssize_t delete_region_store(struct device *dev,
>                                    struct device_attribute *attr,
>                                    const char *buf, size_t len)
>  {
>         struct cxl_root_decoder *cxlrd =3D to_cxl_root_decoder(dev);
> -       struct cxl_port *port =3D to_cxl_port(dev->parent);
>         struct cxl_region *cxlr;
> +       int rc;
>
> +       /* remove_devm_actions_work() will put cxlr->dev. */
>         cxlr =3D cxl_find_region_by_name(cxlrd, buf);
>         if (IS_ERR(cxlr))
>                 return PTR_ERR(cxlr);
>
> -       devm_release_action(port->uport_dev, unregister_region, cxlr);
> -       put_device(&cxlr->dev);
> +       unregister_region(cxlr);
> +
> +       rc =3D remove_devm_actions(cxlr);
> +       if (rc) {
> +               put_device(&cxlr->dev);
> +               return rc;
> +       }
>
>         return len;
>  }
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1297594beaec..75ec292a9f42 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -447,6 +447,12 @@ struct cxl_region_params {
>   */
>  #define CXL_REGION_F_NORMALIZED_ADDRESSING 3
>
> +/* Indicate that this region is being unregistered to prevent a race. */
> +#define CXL_REGION_F_UNREGISTER 4
> +
> +/* Indicate that this region called devm_remove_action. */
> +#define CXL_REGION_F_DEVM_REMOVE 5
> +
>  /**
>   * struct cxl_region - CXL region
>   * @dev: This region's device
> @@ -462,6 +468,7 @@ struct cxl_region_params {
>   * @coord: QoS access coordinates for the region
>   * @node_notifier: notifier for setting the access coordinates to node
>   * @adist_notifier: notifier for calculating the abstract distance of no=
de
> + * @remove_work: trigger the remove action in a safe context to acquire =
locks
>   */
>  struct cxl_region {
>         struct device dev;
> @@ -477,6 +484,7 @@ struct cxl_region {
>         struct access_coordinate coord[ACCESS_COORDINATE_MAX];
>         struct notifier_block node_notifier;
>         struct notifier_block adist_notifier;
> +       struct work_struct remove_work;
>  };
>
>  struct cxl_nvdimm_bridge {
> --
> 2.47.3
>
