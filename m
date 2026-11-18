Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795025392;
	b=iEM3UQsxc6Vyl3Rz0RUU2zbu5FXh8fqHTfLm0l4CDFBwIJPB+4xdRYlLFpGZXLcX7Y7B
	 TjIUaX2LX0TjpMvNYAiEbQL1U9wYeJc4AXvJ/LOQ61jtrX6JPHS9l29rxH7q2EJheI1y6
	 iNyxuOSAUuSwHKyMOLyT3yAwRXhcpmBQ3WJ4ycDH035XnxqiIPdJRnVExxz2tuh+8IEAL
	 RIz41i/iLouP4VO4nJsofWN9RiD03saaFSI8DlLm1iJj/0ztmGQ9OrzqksRXysxrrg4es
	 pE3lcnLJ8anWNmzkVvbMpjhIPIkH9ipE90mzhzmQ5DQMIjr5GyGf/ae7bHK5vyFTDJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795025392;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UwpPf3r3mppEZO5QKOfq3lzKabKp0bG9iB/l7EczDjU=;
	b=v/4GKtIUYYQEl3KDHq55oqkvp4aWwlWLZMRG0ttr6Msker4Ilpn3Qc+UnetTZINaR1D5
	 Fg+IkUI/hQfzlnRF8NT9Fzw8m2e4XkaD8PyQg1bQ+ucwruSpuT/3mU4qzduPgUN8EEQ9Q
	 sASZuaXqaVCJSAJTjLkyJritkejgz5jdw1OAsffhvyqp1+bzG15XquE8p2/W900Md/B4/
	 jezODi/vBMUmvdUtsXgEJCKwnaS/+10JIz1uOTehQ4ErNaWhBzsnbs7WACsifEtSL97Np
	 q8/HhokPDB4Oz6dYKhEwXAbmSacQjAfj4jSAsp+5zCXTDXflU5pf8rUkIZiI2nfyFcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ReFWxF6N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59376606A31C
	for <linux-cxl@vger.kernel.org>; Wed, 18 Nov 2026 18:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ReFWxF6N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B7F1F000C4;
	Wed, 18 Nov 2026 18:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795025392;
	bh=UwpPf3r3mppEZO5QKOfq3lzKabKp0bG9iB/l7EczDjU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ReFWxF6Nqa+5EqRDMX4Ls3jT3BKUijL6O9batr5HnFGfY1tW7mOpoVitEMPy9VnP0
	 cAwwyHb14S/V3OpuypjizFbyQ1hvL7jvu52zNCiBTi8gJlk8+Sgdrz6t3eoMewQSAC
	 MSsA2bzqk1L9rssQisFAlOK7p/mhO7IICuotlTZDLUIMOILSjhqkejlIBezS8LiDdS
	 lltyWTwZ2ksxlnPsbamdbeBbBrzmR/HjUOEPjrwdQJTmCBvdxRE3l3s2VCJDpUUWwk
	 m/s268CzcCXNUYA1t2Lc3tfvplHP/lXSxpszWPvS5myv6jYQAt1UP7Axj3RXtkCxCI
	 wCk65eJ7i07rg==
Message-ID: <sashiko-outbox-221725@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC 2/3] cxl: make explicit removal of endpoint and decoder
 for Type2
Reply-To: sashiko-reviews@lists.linux.dev
To: alucerop@amd.com, linux-cxl@vger.kernel.org
In-Reply-To: <20261118191431.21781-3-alucerop@amd.com>
References: <20261118191431.21781-1-alucerop@amd.com>
 <20261118191431.21781-3-alucerop@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 18:09:51 +0000
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 8 potential
issues to consider:
- [High] cxl: double cxld_unregister() and use-after-free in
  delete_endpoint()
- [High] cxl: endpoint->dev reference leak in detach_memdev() after
  delete_endpoint()
- [High] cxl: invalid pointer dereference in delete_endpoint() on Type2
  probe failure
- [High] cxl: cxl_detach_ep() runs before delete_endpoint() on Type2
  memdev unbind
- [High] cxl: cxlmd->detach_scheduled is never reset and races across
  device locks
- [Medium] cxl: link failure on endpoint_unregister_region() when
  CONFIG_CXL_REGION=3Dn
- [Medium] cxl: reference leak in cxl_memdev_attach_region() on devm
  registration error
- [Medium] cxl: use-after-free in unwinding tracepoints after
  put_device()
--

commit 5ea2db5ceee405003c55ceb45874754b74107942
Author: Alejandro Lucero <alucerop@amd.com>

cxl: make explicit removal of endpoint and decoder for Type2

This commit replaces devm-based endpoint and region teardown for Type 2 CXL
devices with explicit teardown in cxl_memdev_unregister() and
delete_endpoint(), while pinning the endpoint device and adding
schedule_detach actions in cxl_memdev_attach_region().

> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 7333fe7594bd9..c699c5561037e 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -758,6 +758,14 @@ static void cxl_memdev_unregister(void *_cxlmd)
>  	struct device *dev =3D &cxlmd->dev;
> =20
>  	trace_cxl_memdev_unregister(cxlmd, "start");
> +
> +	/*
> +	 * Type2 requires to explicitly remove endpoint while Type3 relies on
> +	 * devm mechanisms.
> +	 */
> +	if (cxlmd->attach)
> +		delete_endpoint(cxlmd);
> +

[Severity: High]
Can this dereference an invalid cxlmd->endpoint pointer when a Type 2
memdev fails to probe cxl_mem?

cxl_memdev_alloc() initializes cxlmd->endpoint to ERR_PTR(-ENXIO).  If
cxl_mem_probe() does not run or fails before registering the endpoint
(for example when !cxlds->media_ready returns -EBUSY),
__devm_cxl_add_memdev() -> cxl_memdev_autoremove() sees
cxl_memdev_attach_failed(cxlmd) and calls cxl_memdev_unregister(cxlmd).
Because cxlmd->attach is set, delete_endpoint(cxlmd) runs and immediately
dereferences cxlmd->endpoint in port_to_host(endpoint) and
trace_cxl_delete_endpoint().

>  	cdev_device_del(&cxlmd->cdev, dev);
>  	cxl_memdev_shutdown(dev);
>  	put_device(dev);
> @@ -776,10 +784,14 @@ static void detach_memdev(struct work_struct *work)
>  	 * is required. In that case, @cxlmd detach escalates to parent device
>  	 * detach.
>  	 */
> -	if (cxlmd->attach)
> +	if (cxlmd->attach) {
>  		device_release_driver(cxlmd->dev.parent);
> -	else
> +
> +		/* Type2 attach region did a get. */
> +		put_device(&cxlmd->endpoint->dev);
> +	} else {
>  		device_release_driver(&cxlmd->dev);
> +	}

[Severity: High]
Does put_device(&cxlmd->endpoint->dev) here leak the endpoint->dev
reference taken in cxl_memdev_attach_region()?

device_release_driver(cxlmd->dev.parent) synchronously releases devres on
the parent device, which runs cxl_memdev_unregister() ->
delete_endpoint(cxlmd).  delete_endpoint() sets cxlmd->endpoint =3D NULL and
only drops the reference taken in cxl_endpoint_autoremove().  When control
returns to detach_memdev(), cxlmd->endpoint is NULL (and since dev is at
offset 0 of struct cxl_port, put_device(NULL) is a no-op).  The extra
reference is also leaked if cxlmd->dev.parent is unbound directly without
going through detach_memdev().

> =20
>  	put_device(&cxlmd->dev);
>  	trace_cxl_memdev_detach(cxlmd, "done");

[Severity: Medium]
Can trace_cxl_memdev_detach(cxlmd, "done") read freed memory after
put_device(&cxlmd->dev)?

For a Type 2 device, device_release_driver(cxlmd->dev.parent) has already
run cxl_memdev_unregister() and dropped the initial reference on
cxlmd->dev, so put_device(&cxlmd->dev) here drops the final reference and
frees cxlmd before trace_cxl_memdev_detach() reads cxlmd->dev.kobj.name.
The same issue exists in endpoint_unregister_region(), cxld_unregister(),
and delete_endpoint(), where the "done" tracepoints read dev->kobj.name
after put_device() or device_unregister().

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 9ccb0d1859047..de109fb600386 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1480,14 +1480,24 @@ static struct device *grandparent(struct device *=
dev)
>  	return NULL;
>  }
> =20
> -static void delete_endpoint(void *data)
> +static void cxld_unregister(void *dev);
> +
> +void delete_endpoint(void *data)
>  {
>  	struct cxl_memdev *cxlmd =3D data;
>  	struct cxl_port *endpoint =3D cxlmd->endpoint;
>  	struct device *host =3D port_to_host(endpoint);
> +	struct cxl_attach_region *attach =3D
> +		container_of(cxlmd->attach, typeof(*attach), attach);
> =20
>  	trace_cxl_delete_endpoint(&endpoint->dev, "start");
> =20
> +	/* Type2 requires to explicitly remove region and decoder */
> +	if (attach && attach->cxlr) {
> +		endpoint_unregister_region(attach->cxlr);
> +		cxld_unregister(&attach->cxled->cxld.dev);
> +	}

[Severity: High]
Won't calling cxld_unregister(&attach->cxled->cxld.dev) directly here
cause a double unregister and use-after-free of attach->cxled?

add_hdm_decoder() still registers cxld_unregister as a devm action on
&endpoint->dev via cxl_decoder_autoremove() for both Type 2 and Type 3
devices, and cxl_memdev_attach_region() drops the device_find_child()
reference on &cxled->cxld.dev when dev goes out of scope.  Calling
cxld_unregister() directly in delete_endpoint() unregisters the decoder
while leaving the devm action queued on &endpoint->dev; a few lines below,
devm_release_action(host, unregister_port, endpoint) unregisters
&endpoint->dev and runs devres_release_all(&endpoint->dev), which calls
cxld_unregister() a second time and then runs cxl_dpa_release() on the
freed decoder.

Conversely, if &endpoint->dev is unbound via sysfs first,
__device_release_driver(&endpoint->dev) runs devres_release_all() and
frees attach->cxled immediately (get_device(&endpoint->dev) only prevents
device_release(), not driver unbind devres cleanup), after which
delete_endpoint() calls cxld_unregister() on the already-freed
attach->cxled.

> +
>  	scoped_guard(device, host) {
>  		if (host->driver && !endpoint->dead) {
>  			devm_release_action(host, cxl_unlink_parent_dport, endpoint);
> @@ -1509,7 +1519,10 @@ int cxl_endpoint_autoremove(struct cxl_memdev *cxl=
md, struct cxl_port *endpoint)
>  	get_device(host);
>  	get_device(&endpoint->dev);
>  	cxlmd->depth =3D endpoint->depth;
> -	return devm_add_action_or_reset(dev, delete_endpoint, cxlmd);
> +	/* Only Type3 relies on devm for decoder unwinding. */
> +	if (cxlmd->cxlds->type =3D=3D CXL_DEVTYPE_CLASSMEM)
> +		return devm_add_action_or_reset(dev, delete_endpoint, cxlmd);
> +	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_autoremove, "CXL");

[Severity: High]
When cxlmd->dev is unbound on a Type 2 device, doesn't skipping the
devm action here cause cxl_detach_ep() to run before delete_endpoint()?

devm_cxl_enumerate_ports() registers cxl_detach_ep on &cxlmd->dev.
Previously delete_endpoint was registered on &cxlmd->dev after
cxl_detach_ep, so devres ran delete_endpoint() first.  Now, when
&cxlmd->dev unbinds (or fails in cxl_memdev_attach_region() after
devm_cxl_add_endpoint()), devres on &cxlmd->dev runs cxl_detach_ep()
before cxl_memdev_unregister() calls delete_endpoint().  cxl_detach_ep()
frees the struct cxl_ep entries in ancestor ports and deletes empty switch
ports while the endpoint port and region are still attached, causing
delete_endpoint() to hit dangling cxl_ep pointers (or NULL ep in
cxl_region_teardown_targets() / cxl_region_decode_reset()) or skip
unregister_port(endpoint) if a parent switch port's driver was detached.

> @@ -2413,6 +2426,12 @@ EXPORT_SYMBOL_NS_GPL(cxl_bus_drain, "CXL");
>  bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
>  {
>  	trace_schedule_cxl_memdev_detach(cxlmd);
> +
> +	if (cxlmd->detach_scheduled)
> +		return 0;
> +
> +	cxlmd->detach_scheduled =3D true;
> +
>  	return queue_work(cxl_bus_wq, &cxlmd->detach_work);
>  }
>  EXPORT_SYMBOL_NS_GPL(schedule_cxl_memdev_detach, "CXL");

[Severity: High]
Since cxlmd->detach_scheduled is never cleared in detach_memdev(), won't
a Type 3 cxl_memdev that is detached and later re-probed fail to detach on
any subsequent port removal and leak the cxlmd->dev reference taken by
cxl_endpoint_port_probe()?

In addition, cxlmd->detach_scheduled is a plain bool accessed without
synchronization from schedule_detach actions on three different devices
(&cxlr->dev, &endpoint->dev, and &cxlmd->dev), and if a Type 2 parent
driver is unbound directly while cxlmd->detach_scheduled is still false,
cxl_memdev_unregister() will trigger those schedule_detach actions and
queue detach_work while cxlmd is already being unregistered.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index efbd53a37405d..6a188041791c2 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c

[ ... ]

> @@ -4177,11 +4177,33 @@ int cxl_memdev_attach_region(struct cxl_memdev *c=
xlmd)
>  	/* Only teardown regions that pass validation, ignore the rest */
>  	get_device(&cxlr->dev);
> =20
> -	rc =3D devm_add_action_or_reset(&endpoint->dev,
> -				      endpoint_unregister_region, cxlr);
> +	/*
> +	 * While region in use by the Type2 device driver, no unbinding can
> +	 * happen. Keeping a reference to the endpoint device avoids release.
> +	 * The endpoint can be released after unwinding from the memdev forced
> +	 * with the below actions.
> +	 */
> +	get_device(&endpoint->dev);
> +
> +	/*
> +	 * All these next devm actions are necessary for dealing with unbind
> +	 * triggered through sysfs with the CXL objects linked to a Type2.
> +	 */
> +	rc =3D devm_add_action_or_reset(&cxlr->dev, schedule_detach, cxlmd);
> +	if (rc)
> +		return rc;
> +
> +	rc =3D devm_add_action_or_reset(&endpoint->dev, schedule_detach, cxlmd);
> +
> +	if (rc)
> +		return rc;
> +
> +	rc =3D devm_add_action_or_reset(&cxlmd->dev, schedule_detach, cxlmd);
>  	if (rc)
>  		return rc;
> =20
> +	attach->cxlr =3D cxlr;
> +	attach->cxled =3D cxled;

[Severity: Medium]
If any of the devm_add_action_or_reset() calls above fails, aren't the
cxlr->dev and endpoint->dev references leaked?

attach->cxlr is only assigned after all three devm_add_action_or_reset()
calls succeed, so on early return delete_endpoint() sees
attach->cxlr =3D=3D NULL and skips endpoint_unregister_region(attach->cxlr).

> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index baa6df2d362a4..eaa663f25699a 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -942,6 +942,9 @@ void cxl_coordinates_combine(struct access_coordinate=
 *out,
>  			     struct access_coordinate *c1,
>  			     struct access_coordinate *c2);
> =20
> +void endpoint_unregister_region(void *_cxlr);
> +void delete_endpoint(void *data);
> +

[Severity: Medium]
Does building with CONFIG_CXL_BUS enabled and CONFIG_CXL_REGION=3Dn fail to
link on endpoint_unregister_region()?

drivers/cxl/core/port.o is built unconditionally under CONFIG_CXL_BUS and
calls endpoint_unregister_region() from delete_endpoint(), while
endpoint_unregister_region() in drivers/cxl/core/region.c is only built
when CONFIG_CXL_REGION is enabled and has no !CONFIG_CXL_REGION stub in
drivers/cxl/cxl.h.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118191431.2178=
1-2-alucerop@amd.com?part=3D2
