Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795024831;
	b=RngCS4zsoborE3Namhuph43XPbiEVz/qMqXsbGL4M/wMOHvaaNJKH3u4IEsrzV7qiUks
	 zmm4j9D805E3nR4VaVOmJ6ueI2lMTLiU/yDUJ19eM/OyE2zDhXGR14WkKwLNnOVGNcdMx
	 ibIZ5FjEybz7Am06HRjWrcQ9NDbfqI8amx0MW3o7SRi3iNfHbQ8Db4IaDmZE2T52FL7kL
	 nfsVh69Li5/wpIhF/janxLOeyQON9ETpDu2lxbugqZZjQy1mEnSgI1P5MQfmCMUi7wO47
	 CqwMoDMpE1xCI25h+zzKW5P7RbuQQ7SfS2wuLxuMtY3QoK60bcLCDKnGfL8IxEx5lXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024831;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=spGJBelfAvjQeObbOmrJaqjUIiuWKt1FXlZ//MJVCus=;
	b=ddTary6gA2jLGqVvP4GZ4hTycHmJqSyt5Yat7rjgBmwFd6ZUY+2ng8FI/yVlUhTp0PCk
	 vcC9Eso4efRTtqc/6CX+p9YDvR7fIqM7zl5fHsVOyJlFJQQqzx8uonXx7LiaJzCGBYPTb
	 LRcSfiiyJ9lwAkxGqPgJNsQ+soR/mLiStTx1DN41qOFtj9Q+kO3eh96wmMlFQFA68nMbp
	 FxFdlbGn6wEvw/B+FR6+8Y9Y3en/3Y23ZAAx/Jnxtwm/CuQh1//iYqPPeXlCR7FhtfR4e
	 DjUWMuXlXW4ZK1owqUj75jIk8eQxxMecogRixuT5P1tgf52lTTYmRBsL95PBNZiYweQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UjKbSogk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741BC606A334
	for <linux-cxl@vger.kernel.org>; Wed, 18 Nov 2026 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UjKbSogk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DDC1F000C7;
	Wed, 18 Nov 2026 18:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795024831;
	bh=spGJBelfAvjQeObbOmrJaqjUIiuWKt1FXlZ//MJVCus=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=UjKbSogk/iPgX2P/mOgljqIK6qLZ49dagI3A+ahOixDG0jjcYW8x2C2ZY9b8iCi5m
	 /+vlgnCZWI6WynQ2QR7k9uxNTemQQTSug7jcyvhpn5EmYGW+0ffetib55RrnmF978w
	 ToTVg9g4L46Ywwdd1kfUXJDBRkPgtVKnw4BPJom6ooxzbTdRU9hYGwOd5Tl5i6PP76
	 lLJHW7gHfRqZ6itQ02qqNKeFPQsKaMWKcE71Kq8QvIqOe4mQ4J8+8p/JjrxhiGNDaI
	 Mjp2QdH32uqKKEL0544+UZw4qoYGVfUzs5dz+d4UIDlVxPFB0Otl2RwqIPbCg8HvgN
	 eHyUsjUVqbaYQ==
Message-ID: <sashiko-outbox-221716@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC 1/3] cxl: add tracepoints to the unwinding code path
Reply-To: sashiko-reviews@lists.linux.dev
To: alucerop@amd.com, linux-cxl@vger.kernel.org
In-Reply-To: <20261118191431.21781-2-alucerop@amd.com>
References: <20261118191431.21781-1-alucerop@amd.com>
 <20261118191431.21781-2-alucerop@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 18:00:30 +0000
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] cxl: use-after-free in unwinding tracepoints after kfree() and
  put_device()
- [Low] cxl: unmatched start tracepoint on early return in
  __cxl_decoder_detach()
- [Low] cxl: missing multi-read guards and convention defects in
  tracepoint headers
--

commit a8dc1dbd6b765af2c082df04014f6b4732355967
Author: Alejandro Lucero <alucerop@amd.com>

cxl: add tracepoints to the unwinding code path

This commit adds start and done tracepoints under the cxl_unwinding trace
system across CXL memdev, port, decoder, and region teardown paths.

> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 787988e92965a..7333fe7594bd9 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
[ ... ]
> @@ -27,9 +30,11 @@ static void cxl_memdev_release(struct device *dev)
>  	struct cxl_memdev *cxlmd =3D to_cxl_memdev(dev);
>  	struct device *parent =3D dev->parent;
> =20
> +	trace_cxl_memdev_release(cxlmd, "start");
>  	ida_free(&cxl_memdev_ida, cxlmd->id);
>  	kfree(cxlmd);
>  	put_device(parent);
> +	trace_cxl_memdev_release(cxlmd, "done");
>  }
> =20
>  static char *cxl_memdev_devnode(const struct device *dev, umode_t *mode,=
 kuid_t *uid,
> @@ -752,9 +757,11 @@ static void cxl_memdev_unregister(void *_cxlmd)
>  	struct cxl_memdev *cxlmd =3D _cxlmd;
>  	struct device *dev =3D &cxlmd->dev;
> =20
> +	trace_cxl_memdev_unregister(cxlmd, "start");
>  	cdev_device_del(&cxlmd->cdev, dev);
>  	cxl_memdev_shutdown(dev);
>  	put_device(dev);
> +	trace_cxl_memdev_unregister(cxlmd, "done");
>  }
> =20
>  static void detach_memdev(struct work_struct *work)
> @@ -763,6 +770,7 @@ static void detach_memdev(struct work_struct *work)
> =20
>  	cxlmd =3D container_of(work, typeof(*cxlmd), detach_work);
> =20
> +	trace_cxl_memdev_detach(cxlmd, "start");
>  	/*
>  	 * When the creator of @cxlmd sets ->attach it indicates CXL operation
>  	 * is required. In that case, @cxlmd detach escalates to parent device
> @@ -772,7 +780,9 @@ static void detach_memdev(struct work_struct *work)
>  		device_release_driver(cxlmd->dev.parent);
>  	else
>  		device_release_driver(&cxlmd->dev);
> +
>  	put_device(&cxlmd->dev);
> +	trace_cxl_memdev_detach(cxlmd, "done");
>  }
> =20
>  static struct lock_class_key cxl_memdev_key;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index f3705ea44db77..9ccb0d1859047 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
[ ... ]
> @@ -540,8 +544,10 @@ EXPORT_SYMBOL_NS_GPL(to_cxl_switch_decoder, "CXL");
> =20
>  static void cxl_ep_release(struct cxl_ep *ep)
>  {
> +	trace_cxl_ep_release(ep->ep, "start");
>  	put_device(ep->ep);
>  	kfree(ep);
> +	trace_cxl_ep_release(ep->ep, "done");
>  }
> =20
>  static void cxl_ep_remove(struct cxl_port *port, struct cxl_ep *ep)
> @@ -558,6 +564,7 @@ static void cxl_port_release(struct device *dev)
>  	unsigned long index;
>  	struct cxl_ep *ep;
> =20
> +	trace_cxl_port_release(dev, "start");
>  	xa_for_each(&port->endpoints, index, ep)
>  		cxl_ep_remove(port, ep);
>  	xa_destroy(&port->endpoints);
> @@ -571,6 +578,7 @@ static void cxl_port_release(struct device *dev)
>  		put_device(dev->parent);
>  		kfree(port);
>  	}
> +	trace_cxl_port_release(dev, "done");
>  }
> =20
>  static ssize_t decoders_committed_show(struct device *dev,
> @@ -1478,6 +1486,8 @@ static void delete_endpoint(void *data)
>  	struct cxl_port *endpoint =3D cxlmd->endpoint;
>  	struct device *host =3D port_to_host(endpoint);
> =20
> +	trace_cxl_delete_endpoint(&endpoint->dev, "start");
> +
>  	scoped_guard(device, host) {
>  		if (host->driver && !endpoint->dead) {
>  			devm_release_action(host, cxl_unlink_parent_dport, endpoint);
> @@ -1488,6 +1498,7 @@ static void delete_endpoint(void *data)
>  	}
>  	put_device(&endpoint->dev);
>  	put_device(host);
> +	trace_cxl_delete_endpoint(&endpoint->dev, "done");
>  }
[ ... ]
> @@ -2283,6 +2296,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_decoder_add, "CXL");
> =20
>  static void cxld_unregister(void *dev)
>  {
> +	trace_cxld_unregister(dev, "start");
>  	if (is_endpoint_decoder(dev))
>  		cxl_decoder_detach(NULL, to_cxl_endpoint_decoder(dev), -1,
>  				   DETACH_INVALIDATE);
> @@ -2290,6 +2304,7 @@ static void cxld_unregister(void *dev)
>  		kill_regions(to_cxl_root_decoder(dev));
> =20
>  	device_unregister(dev);
> +	trace_cxld_unregister(dev, "done");
>  }
> =20
>  int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld)
[ ... ]
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a048bd5c06cb6..efbd53a37405d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
[ ... ]
> @@ -2275,6 +2278,7 @@ __cxl_decoder_detach(struct cxl_region *cxlr,
>  	lockdep_assert_held_write(&cxl_rwsem.region);
> =20
>  	if (!cxled) {
> +		trace_cxl_decoder_detach(&cxlr->dev, "start");
>  		p =3D &cxlr->params;
> =20
>  		if (pos >=3D p->interleave_ways) {

[Severity: Low]
Does emitting trace_cxl_decoder_detach(&cxlr->dev, "start") before
checking pos and p->targets[pos] leave an unmatched "start" trace event
when __cxl_decoder_detach() returns NULL early?

When unregister_region() loops over p->interleave_ways calling
detach_target(cxlr, i), any target already detached by cxld_unregister()
has p->targets[pos] =3D=3D NULL and returns without a matching "done" event
(as does the dev_WARN_ONCE() return later in __cxl_decoder_detach()).

> @@ -2521,6 +2528,7 @@ static void cxl_region_release(struct device *dev)
>  	struct cxl_root_decoder *cxlrd =3D cxlr->cxlrd;
>  	int id =3D atomic_read(&cxlrd->region_id);
> =20
> +	trace_cxl_region_release(dev, "start");
>  	/*
>  	 * Try to reuse the recently idled id rather than the cached
>  	 * next id to prevent the region id space from increasing
> @@ -2536,6 +2544,7 @@ static void cxl_region_release(struct device *dev)
>  out:
>  	put_device(dev->parent);
>  	kfree(cxlr);
> +	trace_cxl_region_release(dev, "done");
>  }
> =20
>  const struct device_type cxl_region_type =3D {
> @@ -2565,6 +2574,7 @@ static void unregister_region(struct cxl_region *cx=
lr)
>  	struct cxl_region_params *p =3D &cxlr->params;
>  	int i;
> =20
> +	trace_cxl_unregister_region(&cxlr->dev, "start");
>  	xa_erase(&cxlrd->regions, cxlr->id);
>  	device_del(&cxlr->dev);
> =20
> @@ -2580,6 +2590,7 @@ static void unregister_region(struct cxl_region *cx=
lr)
> =20
>  	cxl_region_iomem_release(cxlr);
>  	put_device(&cxlr->dev);
> +	trace_cxl_unregister_region(&cxlr->dev, "done");
>  }
> =20
>  static void endpoint_unregister_region(void *_cxlr)
> @@ -2587,10 +2598,12 @@ static void endpoint_unregister_region(void *_cxl=
r)
>  	struct cxl_region *cxlr =3D _cxlr;
>  	struct cxl_root_decoder *cxlrd =3D to_cxl_root_decoder(cxlr->dev.parent=
);
> =20
> +	trace_cxl_endpoint_unregister_region(&cxlr->dev, "start");
>  	guard(mutex)(&cxlrd->regions_lock);
>  	if (xa_load(&cxlrd->regions, cxlr->id))
>  		unregister_region(cxlr);
>  	put_device(&cxlr->dev);
> +	trace_cxl_endpoint_unregister_region(&cxlr->dev, "done");
>  }

[Severity: High]
Do the "done" tracepoints in these release and unregister callbacks trigger
a use-after-free?

Each of these tracepoints reads dev->kobj.name (or cxlmd->dev.kobj.name),
but the "done" call runs after kfree(), put_device(), or
device_unregister() has already freed the object and its kobject name:

- cxl_ep_release() calls kfree(ep) after put_device(ep->ep), and then
  trace_cxl_ep_release(ep->ep, "done") evaluates ep->ep from the freed
  struct cxl_ep even when tracing is disabled.
- cxl_memdev_release(), cxl_port_release(), and cxl_region_release() call
  kfree() on the enclosing struct before the "done" tracepoint reads
  dev->kobj.name.
- cxl_memdev_unregister(), detach_memdev(), delete_endpoint(),
  cxld_unregister(), unregister_region(), and
  endpoint_unregister_region() drop the final device reference via
  put_device() or device_unregister() before calling the "done"
  tracepoint.

> diff --git a/drivers/cxl/cxl_memdev_tracepoints.h b/drivers/cxl/cxl_memde=
v_tracepoints.h
> new file mode 100644
> index 0000000000000..6e8206cf178a0
> --- /dev/null
> +++ b/drivers/cxl/cxl_memdev_tracepoints.h
> @@ -0,0 +1,58 @@
[ ... ]
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM cxl_unwinding
> +
> +#include <linux/tracepoint.h>
> +#include "cxlmem.h"
> +
> +TRACE_EVENT(cxl_memdev_release,
> +	    TP_PROTO(struct cxl_memdev *cxlmd, char *action),
> +	    TP_ARGS(cxlmd, action),
> +	    TP_STRUCT__entry(__string(devname, cxlmd->dev.kobj.name)
> +			     __string(action, action)
> +	    ),
> +	    TP_fast_assign(__assign_str(devname);
> +			   __assign_str(action);
> +	    ),
> +	    TP_printk("%s, %s", __get_str(devname), __get_str(action))
> +);
[ ... ]
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH .
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_FILE cxl_memdev_tracepoints
> +
> +#include <trace/define_trace.h>
> diff --git a/drivers/cxl/cxl_port_tracepoints.h b/drivers/cxl/cxl_port_tr=
acepoints.h
> new file mode 100644
> index 0000000000000..faefa418d9684
> --- /dev/null
> +++ b/drivers/cxl/cxl_port_tracepoints.h
> @@ -0,0 +1,91 @@
[ ... ]
> +TRACE_EVENT(schedule_cxl_memdev_detach,
> +	    TP_PROTO(struct cxl_memdev *cxlmd),
> +	    TP_ARGS(cxlmd),
> +	    TP_STRUCT__entry(__string(devname, cxlmd->dev.kobj.name)),
> +	    TP_fast_assign(__assign_str(devname);
> +	    ),
> +	    TP_printk("%s", __get_str(devname))
> +);
[ ... ]
> +TRACE_EVENT(cxld_unregister,
> +	    TP_PROTO(struct device *dev, char *action),
[ ... ]
> diff --git a/drivers/cxl/cxl_region_tracepoints.h b/drivers/cxl/cxl_regio=
n_tracepoints.h
> new file mode 100644
> index 0000000000000..977eb45b6aad8
> --- /dev/null
> +++ b/drivers/cxl/cxl_region_tracepoints.h
> @@ -0,0 +1,78 @@
[ ... ]
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM cxl_unwinding
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(cxl_decoder_detach,
> +	    TP_PROTO(struct device *dev, char *action),

[Severity: Low]
Should these new tracepoint headers wrap their definitions in a
"#if !defined(...) || defined(TRACE_HEADER_MULTI_READ)" guard with #endif
placed before #include <trace/define_trace.h>, like
drivers/cxl/core/trace.h?

Also, schedule_cxl_memdev_detach and cxld_unregister do not start with the
cxl_ subsystem prefix, the events read dev->kobj.name directly instead of
using dev_name(dev) (and take char *action instead of const char *action),
and the twelve identical (dev, action) TRACE_EVENT definitions could share
a DECLARE_EVENT_CLASS in drivers/cxl/core/trace.h.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118191431.2178=
1-2-alucerop@amd.com?part=3D1
