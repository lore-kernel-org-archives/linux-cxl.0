Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7682F3905F4
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 17:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185851; cv=none; b=T/Qb6UYHQS89MpNaxBIW4NlcPwZsn62tQQGU0sqYsD/os37LKeTVti7HggtwsLQxvgV/N276vA5zEaBYNl5ldWeaPTAJQIgeo8L5l4kB0MdfaAdvJzKuC/3PEohhTEGPgzWV3KJ5v6/grvaSBtIN3LmcaYkNb3K82Ls8K/eCm7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185851; c=relaxed/simple;
	bh=Y3L8Zoxd3dR81rNsGMa2l10v4lSRYvgoly2XQay5aRA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W8r6GRIbhZoodkJdocjqdO8XJ2xV0+i7RIqKhByEXk+RQ+iKD7PSo5pLAmbZYJvKxypVaUNMdnh6rcrJ0jpTQJZErswyzD4jRMJ8VmKXMbqmCQKdBgPdbnCEmWhUeBovHHZv7/qYtACQPYhYbbEvH/a3BNVhD+usAit/JUOyjnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kw5PzjHt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kw5PzjHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D202C1F000FF;
	Wed, 23 Sep 2026 17:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790185850;
	bh=YNOsk61cFdYlw2Feu5XrA/o4DuX53qRaHyRXC1mMVLQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kw5PzjHtRL9yHndK52/H5um2VEd1JP0o6sTZi2pnv3Q67E1idB0LX0jgl/kr5JzUR
	 4XXpbzvUkmCCnzvEFnXDTcZlLIswDoDc76aZxytxwuxWmdotMS4CJqSmhX2xfpUw/G
	 YOoeANpFFey1KZCtlIVWCe4bwu3uRathPjVUHuK6sBmCmbD/Tl/4WcDlCi0Fnsd9mI
	 hDYATUsFH3XnDvgkt9ZnyL45Thrapm8GN8/eysIvQ6OVu+jKaAAt8prSP8Brtfn1rC
	 5CnRERbnSsKxJQVv7rkzrkOena5Ka6oEZUZIfmfHA4kHaq7miSXwJcIhrBYKI92Fqd
	 HHpuS5DowcjIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/15] cxl/cache: Add snoop filter creation and set up
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Cheatham" <Benjamin.Cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260923173342.5584-13-Benjamin.Cheatham@amd.com>
References: <20260923173342.5584-1-Benjamin.Cheatham@amd.com>
 <20260923173342.5584-13-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 17:50:49 +0000
Message-Id: <20260923175049.D202C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] cxl/cache: devres leak on dport hot-remove due to devm group mis=
match
--

commit a51df73f15bcf70227ccbfa7fe083fcb3c6ed6e3
Author: Ben Cheatham <Benjamin.Cheatham@amd.com>

cxl/cache: Add snoop filter creation and set up

This commit adds the capability to track the system's CXL snoop filters and
probes them during dport addition. Snoop filter capacity allocation will be
handled in a later patch.

> diff --git a/drivers/cxl/core/cache.c b/drivers/cxl/core/cache.c
> --- a/drivers/cxl/core/cache.c
> +++ b/drivers/cxl/core/cache.c
[ ... ]
> +int cxl_dport_probe_snoop_filter(struct cxl_dport *dport)
> +{
[ ... ]
> +	rc =3D cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
> +				    BIT(CXL_CM_CAP_CAP_ID_SNOOP));
[ ... ]
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -301,6 +301,16 @@ static struct cxl_dport *cxl_port_add_dport(struct c=
xl_port *port,
>  	/* New dport added, update the decoder targets */
>  	cxl_port_update_decoder_targets(port, dport);
> =20
> +	/*=20
> +	 * cxl_cachedevs won't probe if this fails, but it's not an error for
> +	 * cxl_memdevs
> +	 */
> +	rc =3D cxl_dport_probe_snoop_filter(dport);

[Severity: Medium]
Does this code leak devres memory and virtual address space on dport
hot-remove?

This function call happens outside of the dport devres group, which was
already closed when __devm_cxl_add_dport() returned (and the temporary
port_dr_group is removed earlier in this function).

When cxl_dport_probe_snoop_filter() is called, it triggers a devm
allocation:

cxl_dport_probe_snoop_filter()
  -> cxl_map_component_regs()
    -> devm_cxl_iomap_block()

Because there is no active devres group specifically scoped to the dport
at this point, will this devm allocation attach directly to the parent
port instead? If so, the allocation won't be freed when the dport is
hot-removed, leading to a resource leak.

> +	if (rc)
> +		dev_info(dport->dport_dev,
> +			 "Failed to find or create a CXL snoop filter: %d\n",
> +			 rc);
> +
>  	dev_dbg(&port->dev, "dport%d:%s added\n", dport->port_id,
>  		dev_name(dport_dev));
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923173342.5584=
-1-Benjamin.Cheatham@amd.com?part=3D12
