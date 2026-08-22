Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682723A9871
	for <linux-cxl@vger.kernel.org>; Sat, 22 Aug 2026 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787409836; cv=none; b=K1BHgte4C0CD+MI1qpqcYPM8IqBBAES1ZrwwZlU2JF1ihjTCUDIHe1mlTDYpGhGMDrmkuQmMNvvrykNG41PHgVIEHT9qGvOTa69q4Nx1homevdAjhHyuaRIh+YcPzXu1kugza0AGNQseYIsd9bn8RGY+eXSzz2EZUqkvGK72wvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787409836; c=relaxed/simple;
	bh=TatImfwxCOr1zQJx+Mmzd9Db9QzdM/LggcQf9DpAeOY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cvl39EpUOYLsCBdAhTe0TvLWvQCliMLki7dnIzG/XCUtYLvwI1ZcOy6W9WRF+MF4Qt/TGx4oN758B8ozpVXaLtT1PHJ8l6PpR6DUXAKVSISdU/33Io+OhYwTV3Ohltg9wmTeema6ez3d4JEfCsyHB6jY/2PSt2Zj+k0eTbCeOJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0+4j2CD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0+4j2CD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E571F000E9;
	Sat, 22 Aug 2026 14:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787409833;
	bh=Nxm4gLW2coJ2W1Mh4pU+gDTASi5MUUPdfv3sGMNYKcM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e0+4j2CDI3aGmVjA3quLXjGLKD9DGgOmJLvz9pOPdPHmgV9J7beRo+05MhM0fPsIK
	 suEkrawgnnZLp5OVidbBfWw1kcw3Vp7nwvaOy9VySxxZBtm19Kma+zX0dfnYaYhN3a
	 BIGhQhMfOTbVYJ61qdfp7Pbf+EYdFAyMRVR5niGdgRTK8n0TSFjTxBQIuymxbwCNVK
	 pFand07tx0TSuchsatXRfwT3DZEtvTREUFKM+lRs+LerXKcVXcLcQP5hoUxku/7zSC
	 ruXM9lPQugM2aRdrX7I8gU6gLVWQeZq0cmrAt1jDs4st++vyt3YQTdFFNACER6i03x
	 vGpYTI6TKUwZg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC 1/2] cxl/memdev: add support for mutipf device
Reply-To: sashiko-reviews@lists.linux.dev
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260821155134.260053-2-alejandro.lucero-palau@amd.com>
References: <20260821155134.260053-1-alejandro.lucero-palau@amd.com>
 <20260821155134.260053-2-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 14:43:52 +0000
Message-Id: <20260822144353.76E571F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] `cxl_get_pf0_memdev()` returns a pointer after dropping its device=
 reference via `__free()`, causing a Use-After-Free.
- [High] Flawed execution context detection using `mutex_trylock()` leads t=
o silently skipped driver releases.
- [High] `cxl_get_pf0_memdev()` leaves the sibling device in the xarray on =
the `-EPROBE_DEFER` error path.
- [High] Unconditional dereference of `attach->hpa_range.end` causes a kern=
el panic if `cxlmd->attach` is NULL.
- [High] Sibling device pointers are stored in the `cxlmd->siblings` xarray=
 without taking a reference count.
- [Medium] The return value of `xa_store()` is ignored, potentially leaving=
 siblings unregistered.
- [Medium] Missing `xa_destroy()` for the `cxlmd->siblings` xarray leads to=
 leaked internal nodes.
--

--- Patch [1]: [RFC 1/2] cxl/memdev: add support for mutipf device ---
commit be73e6cb4711f45100bc8fb00094b292d5fbc718
Author: Alejandro Lucero <alucerop@amd.com>

cxl/memdev: add support for mutipf device

A PCI device can present multiple Physical Functions(PFs) but the CXL
specs restrict to the first one, PF0, the discovery and management of
CXL capabilities accessed through a PF0 BAR. Other non-PF0 PFs need to
obtain the CXL.mem range to work with somehow.

> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index b3419df586b9c..327c4da3208fe 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -26,6 +26,35 @@ static void cxl_memdev_release(struct device *dev)
>  {
>  	struct cxl_memdev *cxlmd =3D to_cxl_memdev(dev);
>  	struct device *parent =3D dev->parent;
> +	struct device *sibling;
> +	unsigned long index;
> +
> +	/*
> +	 * Type2 multipf support implies other non-PF0 PFs could be having a

[ ... ]

> +		/* Several possibilities trigger a memdev release with one being
> +		 * its parent device (Type2 device) released from its driver. If
> +		 * so, such release is the context for this function, precluding
> +		 * the mutex lock and therefore safely avoiding to invoke the
> +		 * release again which would trigger a deadlock.
> +		 */
> +		if (mutex_trylock(&cxlmd->dev.parent->mutex)) {

[Severity: High]
Does this trylock reliably detect if it's executing within the context of t=
he
parent device's release callback? If the trylock fails, the code assumes it
is already on the parent release path and skips calling
device_release_driver(). However, couldn't the lock be held by a completely
unrelated thread performing sysfs access, hotplug operations, or power
management? If lock contention occurs, the parent driver release might be
skipped entirely, leaving the parent device permanently bound.

> +			mutex_unlock(&cxlmd->dev.parent->mutex);
> +			device_release_driver(cxlmd->dev.parent);
> +		}
> +	}
> =20
>  	ida_free(&cxl_memdev_ida, cxlmd->id);

[Severity: Medium]
Is it necessary to call xa_destroy() for the cxlmd->siblings xarray before
freeing the struct? The xarray is dynamically initialized during alloc, and
if it allocates memory for internal tree nodes, skipping xa_destroy() could
lead to leaked internal nodes even if all entries were logically erased.

>  	kfree(cxlmd);
>  	put_device(parent);
>  }

[ ... ]

> @@ -802,6 +832,98 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cx=
l_dev_state *cxlds,

[ ... ]

> +struct cxl_memdev *cxl_get_pf0_memdev(struct device *pf0, struct device =
*pfx,
> +				      unsigned long index, struct range *range)
> +{
> +	struct cxl_attach_region *attach;
> +	struct cxl_memdev *cxlmd;
> +	struct device *mem_dev __free(put_device) =3D
> +		bus_find_device(&cxl_bus_type, NULL, pf0,
> +				match_memdev_by_parent_device);
> +
> +	if (!mem_dev)
> +		return ERR_PTR(-ENODEV);
> +
> +	cxlmd =3D to_cxl_memdev(mem_dev);
> +
> +	/*
> +	 * we got the cxl_memdev and the implicit get_device in bus_find_device
> +	 * makes the next steps safe.
> +	 */
> +
> +	xa_store(&cxlmd->siblings, index, pfx, GFP_KERNEL);

[Severity: High]
Should this xarray store take a reference count on the pfx device before
storing it? Since cxl_get_pf0_memdev() registers the pfx sibling device but
doesn't increment its reference count, if the sibling device is independent=
ly
removed and freed, the xarray could retain a dangling pointer. When
cxl_memdev_release() later iterates the xarray and invokes
device_release_driver(sibling), it would dereference this dangling pointer
and cause a use-after-free.

[Severity: Medium]
Is it safe to ignore the return value of xa_store()? Since xa_store()
dynamically allocates memory for new elements and can fail returning an err=
or
pointer, an unhandled failure means the sibling device would be omitted from
the xarray while the function returns success. This might silently compromi=
se
cross-device unbinding logic.

> +	attach =3D container_of(cxlmd->attach, struct cxl_attach_region, attach=
);
> +
> +	/*
> +	 * The cxlmd object does exist and it can be found in the cxl bus after
> +	 * creation but before attach probe setting the proper HPA range. If so,
> +	 * the caller will need to try later.
> +	 */
> +	if (attach->hpa_range.end =3D=3D -1)

[Severity: High]
Can this unconditionally dereference a NULL attach pointer? Because attach =
is
at offset 0 within struct cxl_attach_region, if cxlmd->attach is NULL, the
attach pointer evaluates identically to NULL. Standard Type 3 CXL memdevs
lack an attach region, so cxlmd->attach would be NULL, causing an immediate
kernel panic when trying to access attach->hpa_range.end.

[Severity: High]
Does this error path need to clean up the xarray entry before returning?
Since the sibling device was already inserted into cxlmd->siblings, returni=
ng
-EPROBE_DEFER here without calling xa_erase() leaves a stale pointer in the
xarray. Later, cxl_memdev_release() could iterate over the xarray and invoke
device_release_driver() on a dangling pointer.

> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	range->start =3D  attach->hpa_range.start;
> +	range->end =3D  attach->hpa_range.end;
> +
> +	return to_cxl_memdev(mem_dev);

[Severity: High]
Could this return a pointer after dropping its device reference, causing a
use-after-free? bus_find_device() acquires a reference to the matched device
stored in mem_dev, which is decorated with __free(put_device). Because this
return statement does not inhibit cleanup (for example, by using
no_free_ptr() or return_ptr()), put_device(mem_dev) is automatically execut=
ed
at scope exit, instantly dropping the reference while returning an unpinned
pointer.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821155134.2600=
53-1-alejandro.lucero-palau@amd.com?part=3D1
