Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226A53CB91C
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 21:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780695481; cv=none; b=BVb2/ceXgqJTWea/OV0y341eJPynN5NelVzTSJJhxe2FF1FQRDarT7Qj49Y3Yt4PQJfB0U5pxGB6c2K33jnIQXZVjyA6yo0u2vp++QdREi+Tg0HH0nnfM41NOj3AuxduuxrDin/E+/fQM7nqMr1X3XjOxu1xEA6lu3OCT4cS054=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780695481; c=relaxed/simple;
	bh=jaVvyma8yzJG7FhQKPYyV2iFjZivND7GubQENRx/GTg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aIDgRghFYxChOO0xgTTZIp2bGlzE0V+c4a+MrQ58y9yZusKtdS6VHZQJl3gpvCBtldSpO6dBwC0dmCGihYd/jzLxNRCj27wIKZt3GTwtj8HrOqN0hkOdwT0dvGOl5a6vICN1KypDQZMwHmkXmVeuvp/vv04nMo7YRN6p3re3YZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxVIgjWq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxVIgjWq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B75F1F00893;
	Fri,  5 Jun 2026 21:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780695479;
	bh=6lCyWCy+zXVZAfcsZGYB2KHYwqGUMMCewdNUXhvKHCI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fxVIgjWqmI7L7/P7DJiUi/k5HGc3ny4ZOmYdXSCRFd3RQK/0znqrQZaMSU9qSPFPS
	 bX4hmQMpuxzzuBzcr/MievO3oKW6eQ2mlJO5EmD7vmAejBCNKovfhY7uEGecuIlYP3
	 ZxyuuHtyI+672re7Ws1DgCXgGZf/cPwQdTVhMyIirS3Zevce4m5CGqmETEZjwRewED
	 viS7Yl2//7lGIzWJYjJZjiO3fvIZULgAlqdW/hrMCqx5QYYfpw28x5pVbNZNgnqJvs
	 mbAzmBwaT6eUxeefJxT5rn5FMZZ5k1TxRVZzZYCJF3cla7ike6MYNBm3CjVLZnGZah
	 02IuTafX/ShQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 8/9] dax/kmem: add sysfs interface for atomic hotplug
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gregory Price" <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260605211911.2160954-9-gourry@gourry.net>
References: <20260605211911.2160954-9-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 21:37:58 +0000
Message-Id: <20260605213759.2B75F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unbinding the device while memory is online causes a use-after-fre=
e of `data->res_name` and incorrectly clears the node memory type.
- [High] `dax_kmem_do_hotplug()` unconditionally adds memory regions to the=
 system even if their physical address reservations failed.
- [Low] Lockless access to `data->state` in `hotplug_show` can race with co=
ncurrent updates.
--

commit 3599d063a2c3d29c40b1495050182e1083f34ccd
Author: Gregory Price <gourry@gourry.net>

dax/kmem: add sysfs interface for atomic hotplug

The dax kmem driver currently onlines memory automatically during
probe using the system's default online policy but provides no way
to control or query the entire region state at runtime.

This commit adds a 'hotplug' sysfs attribute allowing userspace to
control and query the entire memory region state. Unplug operations are
now atomic across the whole device.

> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 5bf36ab73f867..46ee06d9f56b3 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c

[ ... ]

> @@ -63,23 +69,41 @@ static void kmem_put_memory_types(void)
>  	mt_put_memory_types(&kmem_memory_types);
>  }
> =20
> +/* True for the online states a kmem dax device can hold. */
> +static bool dax_kmem_state_is_online(int state)
> +{
> +	return state =3D=3D MMOP_ONLINE ||
> +	       state =3D=3D MMOP_ONLINE_KERNEL ||
> +	       state =3D=3D MMOP_ONLINE_MOVABLE;
> +}
> +
>  /**
> - * dax_kmem_do_hotplug - hotplug memory for dax kmem device
> + * dax_kmem_do_hotplug - add the dev_dax memory ranges as system memory
>   * @dev_dax: the dev_dax instance
>   * @data: the dax_kmem_data structure with resource tracking
> + * @online_type: MMOP_OFFLINE to add the blocks offline, otherwise the o=
nline
> + *		 state (MMOP_ONLINE, MMOP_ONLINE_KERNEL, MMOP_ONLINE_MOVABLE)
> + *		 to bring them online in.
>   *
> - * Hotplugs all ranges in the dev_dax region as system memory.
> + * Adds all ranges in the dev_dax region as system memory, onlining them=
 in
> + * the requested zone unless @online_type is MMOP_OFFLINE.
>   *
> - * Returns the number of successfully mapped ranges, or negative error.
>   */
>  static int dax_kmem_do_hotplug(struct dev_dax *dev_dax,
>  			       struct dax_kmem_data *data,
>  			       int online_type)
>  {
>  	struct device *dev =3D &dev_dax->dev;
> -	int i, rc, onlined =3D 0;
> +	int i, rc, added =3D 0;
>  	mhp_t mhp_flags;
> =20
> +	if (dax_kmem_state_is_online(data->state))
> +		return -EINVAL;
> +
> +	if (online_type < MMOP_OFFLINE || online_type > MMOP_ONLINE_MOVABLE)
> +		return -EINVAL;
> +
>  	for (i =3D 0; i < dev_dax->nr_range; i++) {
>  		struct range range;
> =20
> @@ -88,10 +112,10 @@ static int dax_kmem_do_hotplug(struct dev_dax *dev_d=
ax,
>  		if (rc)
>  			continue;
> =20
>  		mhp_flags =3D MHP_NID_IS_MGID;
>  		if (dev_dax->memmap_on_memory)
>  			mhp_flags |=3D MHP_MEMMAP_ON_MEMORY;
> =20
>  		/*
>  		 * Ensure that future kexec'd kernels will not treat
>  		 * this as RAM automatically.
>  		 */
>  		rc =3D __add_memory_driver_managed(data->mgid, range.start,
>  				range_len(&range), kmem_name, mhp_flags,
>  				online_type);

[Severity: High]
Does this code unconditionally add memory regions to the system even if the=
ir
physical address reservations failed?

If `request_mem_region()` fails in `dax_kmem_init_resources()`, it skips
reserving the region (leaving `data->res[i] =3D NULL`), but continues the l=
oop
if previous ranges succeeded.

However, `dax_kmem_do_hotplug()` iterates over all ranges and blindly calls
`__add_memory_driver_managed()` without checking if `data->res[i]` is valid.
This attempts to forcibly online unreserved physical addresses as System RA=
M.

If these address ranges overlap with active MMIO or firmware regions, could
this lead to severe system stability issues and memory corruption?

[ ... ]

> +static ssize_t hotplug_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	struct dax_kmem_data *data =3D dev_get_drvdata(dev);
> +	const char *state_str;
> +
> +	if (!data)
> +		return -ENXIO;
> +
> +	switch (data->state) {

[Severity: Low]
Does this lockless read of `data->state` race with concurrent updates?

`hotplug_show()` reads `data->state` locklessly to return the current state
string to userspace. Concurrently, `hotplug_store()` modifies `data->state`
while holding `data->lock`.=20

Should this be protected by the lock, or properly annotated with
`READ_ONCE()`/`WRITE_ONCE()` to prevent compiler tearing?

> +	case DAX_KMEM_UNPLUGGED:
> +		state_str =3D "unplugged";
> +		break;

[ ... ]

> @@ -345,23 +516,20 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_d=
ax)
>  #ifdef CONFIG_MEMORY_HOTREMOVE
>  static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
>  {
> -	int success;
>  	int node =3D dev_dax->target_node;
>  	struct device *dev =3D &dev_dax->dev;
>  	struct dax_kmem_data *data =3D dev_get_drvdata(dev);
> =20
> +	device_remove_file(dev, &dev_attr_hotplug);
>  	/*
> -	 * We have one shot for removing memory, if some memory blocks were not
> -	 * offline prior to calling this function remove_memory() will fail, and
> -	 * there is no way to hotremove this memory until reboot because device
> -	 * unbind will succeed even if we return failure.
> +	 * Blocks added under the legacy offline policy are present but offline;
> +	 * remove them on unbind as the driver always has.  If removal fails,
> +	 * leak the resources rather than freeing state that still backs present
> +	 * memory.  Online memory is left alone (dax_kmem_cleanup_resources()
> +	 * warns and leaks it) since offlining it here could deadlock the unbin=
d.
>  	 */
> -	success =3D dax_kmem_do_hotremove(dev_dax, data);
> -	if (success < dev_dax->nr_range) {
> -		dev_err(dev, "Hotplug regions stuck online until reboot\n");
> +	if (data->state =3D=3D MMOP_OFFLINE && dax_kmem_do_hotremove(dev_dax, d=
ata))
>  		return;
> -	}
> -
>  	dax_kmem_cleanup_resources(dev_dax, data);
>  	memory_group_unregister(data->mgid);
>  	kfree(data->res_name);

[Severity: High]
Can unbinding the device while memory is online cause a use-after-free
of `data->res_name` and incorrectly clear the node memory type?

When `data->state !=3D MMOP_OFFLINE`, `dev_dax_kmem_remove()` skips
`dax_kmem_do_hotremove()` and calls `dax_kmem_cleanup_resources()`.=20

`dax_kmem_cleanup_resources()` intentionally warns and returns early to lea=
ve
the `struct resource` objects active to prevent unbind deadlocks.

However, `dev_dax_kmem_remove()` unconditionally proceeds to call
`kfree(data->res_name)` and `kfree(data)`. Since the leaked `struct resourc=
e`
objects' name fields still point to `data->res_name`, will any subsequent
read of `/proc/iomem` trigger a KASAN Use-After-Free?

Additionally, does the unconditional continuation improperly call
`clear_node_memory_type()`, corrupting the memtype association while the
memory blocks are still active?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605211911.2160=
954-1-gourry@gourry.net?part=3D8
