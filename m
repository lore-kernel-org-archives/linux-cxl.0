Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793331248;
	b=INjSmaBXWSwY6y+SQWjVLjvSTpZnqr2ASWYoy290e4tJSig28M/am2sYDEK+v/xnlOUU
	 /i7Yii7A/HVsmEIOIWmMkiZdp0XxIMqRf1WHfRvG+BGir2rfmItPNUqbVIbjSI5K+7qM7
	 eBR6x8fdUPit2X6cuP0/7HHTBUYjFZGGB3JjXR0u8mwSMkB2PyHfN2ikdcfsPoXqtYoJP
	 NOU7YzvOxz3f4oYV0b1D/cD3c1RdOUOq5hKdhxPAsrtannNrGOEDrSOO7XdUN9Wn4AZyo
	 o5UucqbZEv3aG6f4YK+GgmFFWDKO+kvhbsFeJLY46eb+c8m89/HZkNNE7jJc2W7DBMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793331248;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=e0rmtmi8YR+vkA2MG+f7oqg704jsdQwuvCR8xeLNahg=;
	b=1YEVyhu9ruPwoJbzcFSl2yORJuvWZNDmFsbM+OtbSY5JNtKLStk9TnTC7vtwBY7oh268
	 QqqYIq+rDEWqrV9LJU/iE0KlHTNkBP915RgbX6mGxKh+YYASrP3lXzahgVYNz5nd+LNeo
	 L/TDnb5deGT7hVog3O4P7Y6VKtm0wjZAAbVkSo9oulV37knri8fm1fX4ppMLTrzRM9LOK
	 1zQYt0anm044fh5kl8qXIUJLwIUxZvqjsIvcrmRH+xjKS9hDDe7ieanE6ZgSjuyjeD5Nu
	 +8lasRlj1aibhQsuP71zDaxlcGKuetPRE6mJGKnnyb8ME1kZhNVfh0RDC5pxeli3GXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOWn2ylI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9376606A322
	for <linux-cxl@vger.kernel.org>; Fri, 30 Oct 2026 03:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOWn2ylI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1661F000C1;
	Fri, 30 Oct 2026 03:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793331247;
	bh=e0rmtmi8YR+vkA2MG+f7oqg704jsdQwuvCR8xeLNahg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EOWn2ylIWCDLFXI8vhWBdz0FDzdhQeuDoGzN2WtcssqoYrYCQ35/g36EZppnz+Gbw
	 KyT7dlSMhXSHTiiBK00Bc9k5BBOUnnfe3jZ2yWJB3TrawbCW7hZllWHKQw5QFPTUcB
	 nTU9VIIf1KVpNrXnco26B++CuSme77X7MJEN4M+2ivqNwpthaymuD2duW+AP0odooO
	 GFSbGa7a6UkSoeMmKNK0xliaqu9DnpYKWnmu1UiCTu5NhJI1tx8UxjewSEy7CG04OU
	 lVKihXjWlt02vtMMh3+Edc+kcNOvAgheNVbk6xptkSpYiva+pT2FufzxatI5QzmP/I
	 hlzS99SdtAK2w==
Message-ID: <sashiko-outbox-190223@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] cxl/core: Create einj_types when EINJ becomes
 available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yongxin Yang" <yangyongxin@kylinos.cn>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20261030032050.787682-1-yangyongxin@kylinos.cn>
References: <20261029065629.333949-1-yangyongxin@kylinos.cn>
 <20261030032050.787682-1-yangyongxin@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 03:34:06 +0000
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] cxl/core: einj_types still missing on built-in RCH/RCD and redun=
dant ACPI hook
--

commit 85011aad4fb602610b914a77c4e46997107304a4
Author: Yang Yongxin <yangyongxin@kylinos.cn>

cxl/core: Create einj_types when EINJ becomes available

This commit defers the creation of the CXL debugfs einj_types file to a
new helper, cxl_debugfs_einj_add_types(), called from cxl_core_init(),
cxl_acpi_probe(), and cxl_debugfs_create_dport_dir() so the file can be
created once EINJ is initialized.

Link: https://lore.kernel.org/all/de14c4ef-e3d8-432f-9ce8-87c468d6d2ad@amd.=
com/
Link: https://lore.kernel.org/all/7a22cc6a-deba-40e6-8033-97d1234420ba@amd.=
com/

> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index b7ce6b59c680b..62dcb2b308430 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -968,6 +968,15 @@ static int cxl_acpi_probe(struct platform_device *pd=
ev)
>  	if (rc < 0)
>  		return rc;
> =20
> +	/*
> +	 * Create einj_types from here as well: with cxl_core built in,
> +	 * cxl_core_init() runs before EINJ is up, so when cxl_acpi is a module
> +	 * loaded afterwards this is the only hook that can create the file,
> +	 * including on RCH/RCD hierarchies, where the single dport is added by
> +	 * this probe itself and cannot help.
> +	 */
> +	cxl_debugfs_einj_add_types();

[Severity: Medium]
Does this hook in cxl_acpi_probe() ever actually create the einj_types
file, and does it still leave RCH/RCD hierarchies without einj_types (and
without the dport einj_inject file) when cxl_acpi is built in?

Earlier in cxl_acpi_probe(), host bridge dports are registered via
bus_for_each_dev(..., add_host_bridge_dport):

drivers/cxl/acpi.c:add_host_bridge_dport() {
	...
	if (ctx.cxl_version =3D=3D ACPI_CEDT_CHBS_VERSION_CXL11) {
		dev_dbg(match, "RCRB found for UID %lld: %pa\n", ctx.uid,
			&ctx.base);
		dport =3D devm_cxl_add_rch_dport(root_port, bridge, ctx.uid,
					       ctx.base);
	} else {
		dport =3D devm_cxl_add_dport(root_port, bridge, ctx.uid,
					   CXL_RESOURCE_NONE);
	}
	...
}

Both devm_cxl_add_rch_dport() and devm_cxl_add_dport() call
__devm_cxl_add_dport() -> cxl_debugfs_create_dport_dir() ->
cxl_debugfs_einj_add_types().

When cxl_acpi is loaded as a module after einj_init() has completed,
add_host_bridge_dport() has already called cxl_debugfs_einj_add_types()
before execution reaches the direct cxl_debugfs_einj_add_types() call at
the end of cxl_acpi_probe().

Conversely, when both cxl_core and cxl_acpi are built in, cxl_acpi_init()
runs at subsys_initcall_sync level, before einj_init() runs at
device_initcall level. At that point, einj_cxl_is_initialized() returns
false during both add_host_bridge_dport() and the direct call in
cxl_acpi_probe().

Later, when an RCD endpoint probes after einj_init(),
devm_cxl_enumerate_ports() returns early without adding any dports:

drivers/cxl/core/port.c:devm_cxl_enumerate_ports() {
	...
	/*
	 * Skip intermediate port enumeration in the RCH case, there
	 * are no ports in between a host bridge and an endpoint.
	 */
	if (cxlmd->cxlds->rcd)
		return 0;
	...
}

And cxl_endpoint_port_probe() sets up RCH RAS without setting up EINJ
debugfs:

drivers/cxl/port.c:cxl_endpoint_port_probe() {
	...
	if (dport->rch)
		devm_cxl_dport_rch_ras_setup(dport);
	...
}

As a result, on built-in RCH/RCD configurations, wouldn't
cxl_debugfs_create_dport_dir() and cxl_debugfs_einj_add_types() never be
called after einj_init(), leaving both einj_types and the RCH dport's
einj_inject debugfs files missing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030032050.7876=
82-1-yangyongxin@kylinos.cn?part=3D1
