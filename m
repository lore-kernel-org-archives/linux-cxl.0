Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED54F477E4B
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099776; cv=none; b=ebiN/x5pi00B9vR3k4oQvsWr5t1QXTeUXlY8AwfDYj58sCdK0Tve3liXPGUeyRfhqvJFS5yfdSZ0yXLHOq171JPO41sgLYiD21bG3vK7SL26RHM3Ptf0Du9EYgDb0s9N0To5xY/dZt32EOvOdXhGsEg4fOBrdCThIJ9qtaAOz54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099776; c=relaxed/simple;
	bh=efV0mbnEbRCvXvolEeQcQpUBFjTmX4i8TCHJp0YIfxo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i/mrzQ8VODpG+zdWHjWyuf+mbW+msGrRasnCeeYb0tzY/sH2zgvh7eU6Zo/FYomC4ZvK8zLBulh6v9FYV2fW8xrRGft4nMdYKu9ssg6K6a2/b8EraBKnXh94OGRR1mA/rwQkNkTiSErYj/9Wd+hWeprKI903kHf0CUZvC8DOGjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c60pj6f1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c60pj6f1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F031F00898;
	Tue, 22 Sep 2026 17:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790099774;
	bh=4/SMHA8u+tonP+0cqyzB8Kq5hfbUpvRCaasyqSsOKoc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c60pj6f1YCjfM9+gyY0PPOLmuujsW16jLxImJGCidCCfzryhkSw1caCyIxNcEh5gg
	 h9OrStbVFSuJ0a7yADZ2XusdAw6DasDnf1aAg5OsTCwGOfMsbDxuZcrLv4RTSA3Eq8
	 KHgy+ZL31U0ZmPs+nS0WY/KOKkQYqo47cL5BlbfYXUJFcZw6zH39A9AICvwMt2FW+k
	 2zJoBs+1qNP/H1Dr1bjsayOcz2dmlaUJzLAtHisN3n3jZecGxmQcUYHz/HC00ffGZ+
	 IWaMPrFZLP4dqUXvcD7X4z4P3UaW1ihyB5nUjUxwn+EPIhWV79bCjd2PJET9WmwvY8
	 HiINaVPfG3aZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/4] cxl/memdev: Add support for multi PF devices
Reply-To: sashiko-reviews@lists.linux.dev
To: alucerop@amd.com
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260921191239.4249-4-alucerop@amd.com>
References: <20260921191239.4249-1-alucerop@amd.com>
 <20260921191239.4249-4-alucerop@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 17:56:13 +0000
Message-Id: <20260922175614.13F031F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] cxl: UAF / memory corruption due to omitted no_free_ptr() in cxl_g=
et_pf0_memdev()
- [High] cxl: NULL pointer dereference when cxlmd->attach is NULL
- [High] cxl: data race and NULL pointer dereference due to missing memory =
barriers
--

commit 8b8a34ac3eece08d08d13bded379e20360255e65
Author: Alejandro Lucero <alucerop@amd.com>

cxl/memdev: Add support for multi PF devices

This commit adds a device link between the CXL region a PF0 memdev is
attached to and the non-PF0 wanting to use the CXL region. A CXL region
release will trigger such a PF to be released from its driver first,
keeping the CXL memory use safe.

> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index b3419df586b9c..67be02faa7e14 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
[ ... ]
> @@ -802,6 +802,72 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cx=
l_dev_state *cxlds,
> +struct cxl_memdev *cxl_get_pf0_memdev(struct device *pf0, struct device =
*pfx,
> +				      struct range *range)
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
> +	attach =3D container_of(cxlmd->attach, struct cxl_attach_region, attach=
);

[Severity: High]
If cxlmd->attach is NULL (e.g. for a standard class memory device initializ=
ed
via devm_cxl_add_memdev), does container_of() evaluate to NULL here since t=
he
member is at offset 0?

> +
> +	/*
> +	 * The cxlmd object does exist and it can be found in the cxl bus after
> +	 * creation but before attach probe setting the proper HPA range. If so,
> +	 * the caller will need to try later.
> +	 */
> +	if (attach->hpa_range.end =3D=3D -1)

[Severity: High]
Could this lead to a NULL pointer dereference when accessing
attach->hpa_range.end if attach evaluated to NULL above?

Additionally, since attach->hpa_range.end is checked locklessly to determine
if initialization is complete, could CPU or compiler reordering cause the
subsequent read of attach->cxlr to see an uninitialized or NULL value?

> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	/*
> +	 * Create the device link between the region and the consumer device.
> +	 * AUTOREMOVE_CONSUMER means the link implicitly to be removed if the
> +	 * consumer unbinds first with no consequences for the supplier.
> +	 */
> +	if (!device_link_add(pfx, &attach->cxlr->dev, DL_FLAG_AUTOREMOVE_CONSUM=
ER))

[Severity: High]
If attach->cxlr is read as NULL due to missing memory barriers or acquire
semantics, could this dereference lead to a kernel panic?

> +		return ERR_PTR(-ENODEV);
> +
> +	range->start =3D attach->hpa_range.start;
> +	range->end =3D attach->hpa_range.end;
> +
> +	return to_cxl_memdev(mem_dev);

[Severity: High]
Will the device reference acquired by bus_find_device() be unconditionally
dropped here at scope exit due to the __free(put_device) cleanup attribute?

Should this return to_cxl_memdev(no_free_ptr(mem_dev)) to inhibit the
cleanup and safely transfer ownership of the acquired reference to the call=
er?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921191239.4249=
-1-alucerop@amd.com?part=3D3
