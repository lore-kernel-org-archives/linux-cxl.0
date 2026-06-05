Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4273B3CB91C
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 21:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780695363; cv=none; b=lzRn25PjZ1nzDtg4HkY8MbvVZqVBgs0zQvVfOYHF1WB8Jx3ZBaE7Uy0jU+1es4bgeEFdVoS5vg/wq0eI4mnD5lhurQyGgC28VSKasZL5zrcGk/2zHuACrGWiZJ0tDDd0MFqGcou4WUCS/Ntp+oT3RwrpU/44Fj0IGyBS7M9qMvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780695363; c=relaxed/simple;
	bh=N4zCn+81MclTWG81CSwGF+13c22LpP2ueTq8kzKVKuM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ooox4oo1OatTTjCqcnaEScB8Bw0IQa0xRLaEiougZkPrJ5M8J07W0miuu3HtNMNcxUuKY+K8RFllnTpeQiyE1JKbrRttDvSm/VW5ZzHIzESQJKscZFZ/+cwgPnrjaxq86sAhQkh3QbVMJMgTN6PZM+gDs0wYvrHlyvt1fqp0hcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PttezATW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PttezATW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D1E1F00893;
	Fri,  5 Jun 2026 21:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780695362;
	bh=fNHY73BIoUTzQEHu86zApsLGIC/ZfnFqMVwv+K0oNkc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PttezATW5txrSoVhnSny89AO9QLj2eI921hd8Gz2ifqkC4bj03XgCm7JO1rsNAiw4
	 E81G9FqgACkarvRfknBHd2P44iIhwkwShqo7/jMIHQ8GQyMA20o0qGlDPt5jMAsxDo
	 rBqTwYgbaH2YwcN7my6Cmp6oV8M1KZOapLxUUKVirBMcEhwlXHiuN1983ZADJFxCGa
	 w93W5XKPotReOSUMCzB3agh+H3IbQi+fy2OCwCflVLL+gDNFBa7y5Aw5WE3JX+Hg5c
	 SyauD6afj0QacYCWuO6038CLA/g3owIdK2VlrXOEV7dF1hAhBfMVOEiQKaCEg4VkjK
	 80f8wNrunJC5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/9] dax/kmem: extract hotplug/hotremove helper
 functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gregory Price" <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260605211911.2160954-8-gourry@gourry.net>
References: <20260605211911.2160954-8-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 21:36:01 +0000
Message-Id: <20260605213602.10D1E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] dax_kmem_do_hotplug() unconditionally attempts to add memory for a=
ll ranges, missing a check for successfully reserved I/O resources, leading=
 to unsafe hotplug and a permanent memory leak on removal.
--

commit 9aae29a4ee0b2d84bab7e3e062cb31c70f75bf67
Author: Gregory Price <gourry@gourry.net>

dax/kmem: extract hotplug/hotremove helper functions

Refactor kmem _probe() _remove() by extracting init, cleanup, hotplug,
and hot-remove logic into separate helper functions.

> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 41ccb618a1464..5bf36ab73f867 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
[ ... ]
> @@ -63,14 +63,195 @@ static void kmem_put_memory_types(void)
>  	mt_put_memory_types(&kmem_memory_types);
>  }
> =20
> +/**
> + * dax_kmem_do_hotplug - hotplug memory for dax kmem device
[ ... ]
> +static int dax_kmem_do_hotplug(struct dev_dax *dev_dax,
> +			       struct dax_kmem_data *data,
> +			       int online_type)
> +{
> +	struct device *dev =3D &dev_dax->dev;
> +	int i, rc, onlined =3D 0;
> +	mhp_t mhp_flags;
> +
> +	for (i =3D 0; i < dev_dax->nr_range; i++) {
> +		struct range range;
> +
> +		rc =3D dax_kmem_range(dev_dax, i, &range);
> +		if (rc)
> +			continue;
> +
> +		mhp_flags =3D MHP_NID_IS_MGID;
> +		if (dev_dax->memmap_on_memory)
> +			mhp_flags |=3D MHP_MEMMAP_ON_MEMORY;
> +
> +		/*
> +		 * Ensure that future kexec'd kernels will not treat
> +		 * this as RAM automatically.
> +		 */
> +		rc =3D __add_memory_driver_managed(data->mgid, range.start,
> +				range_len(&range), kmem_name, mhp_flags,
> +				online_type);

[Severity: High]
Should this loop verify if the resource was actually reserved before
adding the memory?

In dax_kmem_init_resources(), if request_mem_region() fails for a range
but a previous range succeeded (mapped > 0), the failure is bypassed and
data->res[i] is left as NULL.

If we don't check for !data->res[i] here, does this unconditionally call
__add_memory_driver_managed() and hot-add memory for physical ranges that
failed reservation?

> +
> +		if (rc) {
> +			dev_warn(dev, "mapping%d: %#llx-%#llx memory add failed\n",
[ ... ]
> +static int dax_kmem_init_resources(struct dev_dax *dev_dax,
> +				   struct dax_kmem_data *data)
> +{
[ ... ]
> +		/* Region is permanently reserved if hotremove fails. */
> +		res =3D request_mem_region(range.start, range_len(&range),
> +					 data->res_name);
> +		if (!res) {
> +			dev_warn(dev, "mapping%d: %#llx-%#llx could not reserve region\n",
> +				 i, range.start, range.end);
> +			/*
> +			 * Once some memory has been onlined we can't
> +			 * assume that it can be un-onlined safely.
> +			 */
> +			if (mapped)
> +				continue;
> +			return -EBUSY;
> +		}
> +		data->res[i] =3D res;

[ ... ]
> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +/**
> + * dax_kmem_do_hotremove - hot-remove memory for dax kmem device
[ ... ]
> +static int dax_kmem_do_hotremove(struct dev_dax *dev_dax,
> +				 struct dax_kmem_data *data)
> +{
> +	struct device *dev =3D &dev_dax->dev;
> +	int i, success =3D 0;
> +
> +	for (i =3D 0; i < dev_dax->nr_range; i++) {
> +		struct range range;
> +		int rc;
> +
> +		rc =3D dax_kmem_range(dev_dax, i, &range);
> +		if (rc)
> +			continue;
> +
> +		/* range was never added during probe, count as removed */
> +		if (!data->res[i]) {
> +			success++;
> +			continue;
> +		}

[Severity: High]
If dax_kmem_do_hotplug() erroneously added memory for a range with a
NULL data->res[i], will this check cause us to skip remove_memory()
for that range?

Does this strand the memory block online permanently?

> +
> +		rc =3D remove_memory(range.start, range_len(&range));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605211911.2160=
954-1-gourry@gourry.net?part=3D7
