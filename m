Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C593E44E7
	for <linux-cxl@vger.kernel.org>; Wed,  2 Sep 2026 20:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788379708; cv=none; b=Te41mm6mkHOl8ZNiGiMvUajAHpATyD08uD+pZMk6v7uIsXfJ3hFR90soIYr2f9ml8uI0GmXkzBEo70P7OI1IdRntLuPigQNR+WwX1AcnmLDWdI13XGKQBTCOY27TnjBSmnagyocLQ8IxuN1YwjPnspzuz3FNbaPcmiefGCIcZqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788379708; c=relaxed/simple;
	bh=uAa0TyTktUBCErtp5U1xu+1/pBnZ6mwmkSpGp8elFWg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NB/VE6lVniafi4ZI9XOQ2u412vHkcuCt91bNKLdJ/p81oUPtQQRjDUO0b4HbiDKqlMuWNBV8QpO41pHrK69gn44k7ur4H/iFix+Xx8hwRPoRSUjNeRchrYtLG7Cnc/UsbpgK0qg4PqS9V2fN5pY4kw1B0lqfpYr8Anl35X379p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmQtNuPI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmQtNuPI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308571F00A3A;
	Wed,  2 Sep 2026 20:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788379706;
	bh=ZHRDvVJJhbtQyBNBX3i2D7FGUbLbTIg2kepPNfBdFdg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZmQtNuPI05Ver2/AKa2lAucOJcjVu/p5AVU3rWiW7655GgxqqhZilGJIF2zwWXwy0
	 If+zLxzBjN9UV08YOdF2keAVXx7Jdzt8TIhosee5+2i41TIXGthBJSk4AyrDnsMqdu
	 jfWwJUeYky51fe7R4IbGHVZWA8D4GJbjnIJ5zpjlTtv1ucGqkfIBGm69uTpRWJas8n
	 LCkonL1YWyCA1wzIGYIzC6+Go46fdlZHkqfyWPIKj+CqrZSE+E1GAHpLD2gRp0bETj
	 H0KSb3JNBA2RkDX92DTEG1WPfp0X83OMFp3HgZ3N8MFwh1/5nBgTdNJBNOShokmi1t
	 e16kOajdwd/6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/memory_hotplug: factor out node_is_memoryless()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gregory Price" <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260902195507.88655-1-gourry@gourry.net>
References: <20260902195507.88655-1-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 20:08:25 +0000
Message-Id: <20260902200826.308571F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Unused function warnings when CONFIG_MEMORY_HOTREMOVE is disabled.

Pre-existing issues:
- [High] Data race on `node_spanned_pages` between ACPI CPU hot-remove and =
ZONE_DEVICE memory hotplug due to missing memory hotplug lock.
--

commit 239875f97a26527846083c3d6ab82ee6b800ce0a
Author: Gregory Price <gourry@gourry.net>

mm/memory_hotplug: factor out node_is_memoryless()

A memoryless node neither spans present pages (populated or ZONE_DEVICE)
nor has an offline-but-added memory block still linked to it in sysfs.

try_offline_node() presently open-codes this memoryless check.

Pull that into a node_is_memoryless() helper and pull the existing
check_no_memblock_for_node_cb() helper ahead of the add/online path
so it's clearer what is happening here.

> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 226ab9cb078ad..d0e94057682af 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1491,6 +1491,36 @@ static int create_altmaps_and_memory_blocks(int ni=
d, struct memory_group *group,
>  	return ret;
>  }
> =20
> +static int check_no_memblock_for_node_cb(struct memory_block *mem, void =
*arg)
> +{
> +	int nid =3D *(int *)arg;
> +
> +	/*
> +	 * If a memory block belongs to multiple nodes, the stored nid is not
> +	 * reliable. However, such blocks are always online (e.g., cannot get
> +	 * offlined) and, therefore, are still spanned by the node.
> +	 */
> +	return mem->nid =3D=3D nid ? -EEXIST : 0;
> +}
> +
> +/* Caller must hold the memory hotplug lock for this check. */
> +static bool node_is_memoryless(int nid)
> +{
> +	/*
> +	 * A node still spanning pages (especially ZONE_DEVICE) is not
> +	 * memoryless.  A node spans memory after move_pfn_range_to_zone(),
> +	 * e.g. once a memory block has been onlined.
> +	 */
> +	if (node_spanned_pages(nid))

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but can
this lockless read of node_spanned_pages() race with ZONE_DEVICE memory
hotplug?

The comment explicitly requires the memory hotplug lock, but the ACPI CPU
hot-remove path in drivers/acpi/acpi_processor.c:acpi_processor_post_eject()
calls try_offline_node() while holding only device_hotplug_lock():

drivers/acpi/acpi_processor.c:acpi_processor_post_eject() {
    ...
    cpus_write_unlock();
    cpu_maps_update_done();

    try_offline_node(cpu_to_node(pr->id));
}

Since ZONE_DEVICE memory hotplug (via memremap_pages()) modifies
node_spanned_pages under mem_hotplug_lock() without holding
device_hotplug_lock(), could this race result in a NUMA node with active
ZONE_DEVICE memory being erroneously offlined and unregistered from sysfs?

> +		return false;
> +	/*
> +	 * Offline memory blocks may not be spanned by the node yet, but they
> +	 * link to it in sysfs and can be onlined later, so the node is not
> +	 * memoryless while any remain.
> +	 */
> +	return !for_each_memory_block(&nid, check_no_memblock_for_node_cb);
> +}

[Severity: Low]
Does moving check_no_memblock_for_node_cb() and node_is_memoryless() outside
of the #ifdef CONFIG_MEMORY_HOTREMOVE block cause -Wunused-function warnings
when CONFIG_MEMORY_HOTREMOVE is disabled?

Their only caller, try_offline_node(), is conditionally compiled inside that
block, so these helpers would be unused in builds without it.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902195507.8865=
5-1-gourry@gourry.net?part=3D1
