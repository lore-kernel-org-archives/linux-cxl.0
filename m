Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793167715;
	b=TY06OsGzcEmWLeORtwBTetLLkrog/e8JryMoNQty7MIaqppBsBwhvvnX+be+TvPLHXEM
	 JaBw7WIEsVqnUi0FzHYmBd2q2VMdk2TtmKxb+mq/hQ2jtNBpzjTfFqE/BTd7lK8nn8G1l
	 puFJST6fRpRGPrgvKBVv1/6w2x6zloyF44bvcGduwy0O2kcWow5dj0n/wYcmkj5RL+nyl
	 Nyc4bbGu73EteO8nZh6ULHviXBPEbkrlYKsADYJcV2iWzjs3Bd1kP4qd0vkygaaSGL6lk
	 cyJ1HN+MowwrCPfu2TTYunN+foT8ajPJh9sdKC2quqdYhCtW5ZtjbpAtB59tg4JHvpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793167715;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/TPcF4ULGqI2fEO87ogNm7T72JaMgv/YppexPEkAeQY=;
	b=IS+gYN91Pw/hvxpE/js1N8O4M/Gg26W5dvE/IO5eJO9DlFVjrpjhttZVx/ldBqbtbXDa
	 LDa7oxcBWK3XGGglpjJm/qdHCYdrIeGrGR0k3Q9amt6nkVz+5RXnzJ7Mv3SNpaEiuCGyT
	 g95ogmkzAEdCQbIj3H4SDGyjBsGs41eX/mQpCnmNWud0q6YhuQlIpsjMMfQmryAu+LMoB
	 HVvAA6hyB3/lATdS2GySJ//626cPu16QovggLrT73X+ExkiPmY3joVdSXft6mkCBsVYiP
	 mexmGnV0EPyD2ExT3AkyP+xyz2oSv+zmg92ANapZjJCWq+UwCLBXOJjT173dugMtxew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZrjEg98q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0934D606A31A
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 06:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZrjEg98q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0DD1F01825;
	Wed, 28 Oct 2026 06:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793167714;
	bh=/TPcF4ULGqI2fEO87ogNm7T72JaMgv/YppexPEkAeQY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZrjEg98qTHNC1lVSjPyTE2doONtcLkfg/1c/BhVI+TuHPyiSt82GwaMFW/CBHhlDe
	 j8kzWJ3cs8CZDYLMHKP9JU2CVVkcsorsvAPDw7SBi9ito1Kxta9V+lc+VZf28YXPUL
	 ESxXk0kIGE8TscMM+dIOBB5htog9CwEm9nXbxzugqhGuYftDIULzkU1L2l5WEh3vec
	 lpodoflW/iyKhRYVeFsgFRWLSlV4eLcva771yjx74Fa4s75XoQBkr6xlaHCWwDa5LK
	 cNacIgrRVe0bdUCtRW0CclnFH1uNUHtJhr457tQ/9sKO5TrgDGQB0Ip9MpiY+IwkZn
	 I8o1NuAnckFig==
Message-ID: <sashiko-outbox-187549@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/core: Create einj_types when EINJ becomes available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yongxin Yang" <yangyongxin@kylinos.cn>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20261028055401.1626640-1-yangyongxin@kylinos.cn>
References: <20261028055401.1626640-1-yangyongxin@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 06:08:33 +0000
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] cxl/core: data race on einj_types_dentry in cxl_einj_debugfs_add=
_types()
- [Medium] cxl/core: incomplete einj_types init ordering and modular regres=
sion
--

commit 8c31c56682570f7a66710a4b59dab14f80b09a59
Author: Yang Yongxin <yangyongxin@kylinos.cn>

cxl/core: Create einj_types when EINJ becomes available

This commit moves the creation of the einj_types debugfs file out of
cxl_core_init() into a helper called from cxl_debugfs_create_dport_dir() so
that the file can be created lazily after the einj driver initializes.

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index f3705ea44db77..f80dd8f4221a7 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -811,6 +811,27 @@ static int cxl_dport_setup_regs(struct device *host,=
 struct cxl_dport *dport,
> =20
>  DEFINE_SHOW_ATTRIBUTE(einj_cxl_available_error_type);
> =20
> +static struct dentry *cxl_debugfs;
> +static struct dentry *einj_types_dentry;
> +
> +/*
> + * einj_types cannot be created from cxl_core_init(): that runs at
> + * subsys_initcall level, before einj_init() has set einj_initialized.
> + * Create it lazily, from the first place where EINJ is known to be up.
> + */
> +static void cxl_einj_debugfs_add_types(void)
> +{
> +	if (einj_types_dentry)
> +		return;
> +
> +	if (!einj_cxl_is_initialized())
> +		return;
> +
> +	einj_types_dentry =3D debugfs_create_file("einj_types", 0400, cxl_debug=
fs,
> +						NULL,
> +						&einj_cxl_available_error_type_fops);
> +}

[Severity: Medium]
Can concurrent dport enumeration race on einj_types_dentry in
cxl_einj_debugfs_add_types()?

Previously, debugfs_create_file("einj_types", ...) was only called once from
cxl_core_init() in single-threaded initcall context. With this change, it is
called via:

  cxl_pci_probe()
    -> devm_cxl_add_memdev()
      -> cxl_mem_probe()
        -> devm_cxl_enumerate_ports()
          -> add_port_attach_ep()
            -> probe_dport()
              -> cxl_port_add_dport()
                -> devm_cxl_add_dport_by_dev()
                  -> __devm_cxl_add_dport()
                    -> cxl_debugfs_create_dport_dir()
                      -> cxl_einj_debugfs_add_types()

Because cxl_pci_driver enables asynchronous probing in drivers/cxl/pci.c:

	.driver	=3D {
		.probe_type	=3D PROBE_PREFER_ASYNCHRONOUS,
	},

and add_port_attach_ep() in drivers/cxl/core/port.c only serializes on the
per-port device lock:

	scoped_guard(device, &parent_port->dev) {
		parent_dport =3D cxl_find_dport_by_dev(parent_port, dparent);
		if (!parent_dport) {
			parent_dport =3D probe_dport(parent_port, dparent);

two worker threads probing endpoints under different parent ports can enter
cxl_einj_debugfs_add_types() simultaneously, both observe einj_types_dentry
as null, and both call debugfs_create_file("einj_types", ...).

In fs/debugfs/inode.c:debugfs_start_creating(), the losing caller will fail
with:

	dentry =3D simple_start_creating(parent, name);
	if (IS_ERR(dentry)) {
		if (dentry =3D=3D ERR_PTR(-EEXIST))
			pr_err("'%s' already exists in '%pd'\n", name, parent);
		simple_release_fs(&debugfs_mount, &debugfs_mount_count);
	}

logging a spurious error and racing to overwrite einj_types_dentry with the
error pointer. Should einj_types_dentry creation be synchronized with a lock
or once-only helper?

> +
>  static int cxl_einj_inject(void *data, u64 type)
>  {
>  	struct cxl_dport *dport =3D data;
> @@ -833,6 +854,8 @@ static void cxl_debugfs_create_dport_dir(struct cxl_d=
port *dport)
>  	struct cxl_port *parent =3D parent_port_of(dport->port);
>  	struct dentry *dir;
> =20
> +	cxl_einj_debugfs_add_types();
> +
>  	if (!einj_cxl_is_initialized())
>  		return;
> =20
> @@ -2589,8 +2612,6 @@ const struct bus_type cxl_bus_type =3D {
>  };
>  EXPORT_SYMBOL_NS_GPL(cxl_bus_type, "CXL");
> =20
> -static struct dentry *cxl_debugfs;
> -
>  struct dentry *cxl_debugfs_create_dir(const char *dir)
>  {
>  	return debugfs_create_dir(dir, cxl_debugfs);
> @@ -2603,10 +2624,6 @@ static __init int cxl_core_init(void)
> =20
>  	cxl_debugfs =3D debugfs_create_dir("cxl", NULL);
> =20
> -	if (einj_cxl_is_initialized())
> -		debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
> -				    &einj_cxl_available_error_type_fops);
> -

[Severity: Medium]
Does removing this check from cxl_core_init() introduce a regression for
modular builds, while still missing built-in restricted host topologies?

First, when cxl_core is built as a module, subsys_initcall(cxl_core_init)
compiles to module_init(cxl_core_init). Because cxl_core directly references
einj symbols (einj_cxl_is_initialized and
einj_cxl_available_error_type_show), the einj module is already initialized
before cxl_core_init() runs. Removing the creation from cxl_core_init()
rather than calling cxl_einj_debugfs_add_types() here means einj_types is no
longer created when cxl_core.ko is loaded before or without dport
enumeration.

Second, when both cxl and einj are built-in, cxl_acpi_init() runs at
subsys_initcall_sync in drivers/cxl/acpi.c:

  subsys_initcall_sync(cxl_acpi_init);

which still executes before einj_init() at device_initcall in
drivers/acpi/apei/einj-core.c:

  module_init(einj_init);

During cxl_acpi_probe(), add_host_bridge_dport() in drivers/cxl/acpi.c adds
the host bridge and restricted host dports:

	if (ctx.cxl_version =3D=3D ACPI_CEDT_CHBS_VERSION_CXL11) {
		dev_dbg(match, "RCRB found for UID %lld: %pa\n", ctx.uid,
			&ctx.base);
		dport =3D devm_cxl_add_rch_dport(root_port, bridge, ctx.uid,
					       ctx.base);
	} else {
		dport =3D devm_cxl_add_dport(root_port, bridge, ctx.uid,
					   CXL_RESOURCE_NONE);
	}

At that point einj_cxl_is_initialized() is still false in
cxl_debugfs_create_dport_dir(). Later, when restricted host endpoints probe
at device_initcall, devm_cxl_enumerate_ports() in drivers/cxl/core/port.c
returns early without adding any further dports:

	if (cxlmd->cxlds->rcd)
		return 0;

As a result, on built-in restricted host platforms,
cxl_debugfs_create_dport_dir() is never called after einj_init(), so neither
einj_types nor the dport's einj_inject file is created despite an injectable
dport being present.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028055401.1626=
640-1-yangyongxin@kylinos.cn?part=3D1
