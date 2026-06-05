Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB41D3E0223
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684677; cv=none; b=d9mlnqb5bJILKRK2UcrHODjyCFRxyXLfsfLO/NuA4yo//dwy/q9mCbGRLIueNACweXBl+BMiJ/SFWLOxapNB9um9rWkIiGWXm8f5wRHyx44GIMroem7jtVPQB8Sse1eitJI7l7FwYlSCcKTlIf6xcS/Z9PM9KKYYlBEwEZG7/tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684677; c=relaxed/simple;
	bh=7iHAYeujqsfha91TRMGCx6x4vUOgrszaGUOuUs83zCU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k1InpmIzLO8U4yfDIIa8JkSyxiCMgBNfGgEqHeebO74wFJK0Hrz1ytKcgBA+lvOcd1WwviirTyZerm6/5roKFgqmPpuBBCY56gXiRbqHfd4WBan6guF6d8VLJhvibtR48ySZLXhFv0FSMQw9SMYxnqcq0sHp5IHPuRN5uT8t3+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBdNHgK+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBdNHgK+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F451F00893;
	Fri,  5 Jun 2026 18:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780684676;
	bh=32iUYtevjapI6xOJC2LdlXHnFtQSnyV7zRl8VjJmSig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VBdNHgK+8hLbVrDfzZk2BzPS+GvS0PV9J42dXoSR1jc3emzzVEGfmn0Dk2Otxs8w3
	 CEhXSOgWDFo+ov8RviHb5IKK/ozwXe540dxvmNru8J/S2DAB6EtnSKVzC7DVh4hi50
	 jdVoIkrWs+Qj903MtRgkpZsVCjaGzKW9saqsupAXXIaWzjPBHQUAMap5ZV3PucShLU
	 9bEh/AY+hTDp+gvQzutCI6wD31JXeVs9sUw4G+rixviaVQY7VxPy7mFg6AOSQEweuf
	 gLMb/4NOc3kjqCkdydB26H2QvmHPhBWl0/98KW6Yziiv81NTiUiD98NV6/NXssY5Vv
	 i6BCL8gWyhIFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/port: Fix missing port lock in cxl_dport_remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260605182014.2254410-1-terry.bowman@amd.com>
References: <20260605182014.2254410-1-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 18:37:55 +0000
Message-Id: <20260605183756.49F451F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch attempts to fix a Use-After-Free by adding `cond_cxl_roo=
t_lock(port)` around `xa_erase()` in `cxl_dport_remove()`. However, this is=
 an incomplete fix that leaves the vulnerability unmitigated because the re=
ad paths perform lockless lookups of the `dport` pointer and dereference it=
 without holding the port lock.
--

commit ca3b77804e4fe414bebb82b07916a450f1a53a28
Author: Terry Bowman <terry.bowman@amd.com>

cxl/port: Fix missing port lock in cxl_dport_remove()

This patch attempts to fix a race condition where cxl_dport_remove() runs
without the port device lock during xa_erase(). It adds conditional lock
acquisition around the xa_erase() call to prevent a use-after-free by
concurrent callers.

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index c5aacd7054f1d..b9bbe6c5767c4 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1092,8 +1092,17 @@ static void cxl_dport_remove(void *data)
>  	struct cxl_dport *dport =3D data;
>  	struct cxl_port *port =3D dport->port;
> =20
> +	/*
> +	 * For non-root ports the port lock is already held by the caller
> +	 * (driver unbind via devres_release_all(), or cxl_detach_ep() via
> +	 * devres_release_group()).  Acquiring it again unconditionally would
> +	 * deadlock.  Use cond_cxl_root_lock() which only acquires when the
> +	 * port is a root port and the lock is therefore not yet held.
> +	 */
> +	cond_cxl_root_lock(port);
>  	port->nr_dports--;
>  	xa_erase(&port->dports, (unsigned long) dport->dport_dev);

[Severity: High]
This is a pre-existing issue, but does adding the lock here actually prevent
the use-after-free for the readers?

The read paths perform lockless lookups of the dport pointer and dereference
it without holding the port lock. For example, in
drivers/cxl/mem.c:cxl_mem_probe(), it calls cxl_mem_find_port() which
locklessly finds dport via xa_load(), and then dereferences dport->rch befo=
re
acquiring the endpoint parent lock.

Similarly, in drivers/cxl/pci.c:rcd_pcie_cap_emit(), it calls
cxl_mem_find_port(), locklessly dereferences dport->regs.rcd_pcie_cap, and
only later takes the root_dev lock.

Since these readers don't acquire the port lock before the lookup or
re-validate the pointer after acquiring any locks, isn't the UAF still
possible when the writer concurrently frees the dport?

> +	cond_cxl_root_unlock(port);
>  	put_device(dport->dport_dev);
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605182014.2254=
410-1-terry.bowman@amd.com?part=3D1
