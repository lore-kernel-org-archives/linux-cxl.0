Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3E1480947
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560913; cv=none; b=gDWsEAc/Ylh6RsDjxOUvhvnN3eDxHb6Vnek6rkL6Keou4Q4Yi/Af/opbE8eyvKJQhrQWX/yg9f+hjcHOhJd8qi1ncUgb+na3HD23vbIvIDIc9maHsE7/28SQH5WvMbMOuQAhFi3PF7ouEQ7Utc2/VE7FgV9MhPx4cHxDWTEb1kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560913; c=relaxed/simple;
	bh=CD5jz9MzeO5YBa9j0r6t/xBUlF7N8stH7HdnkAHytus=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VC2ciDFuO/dBMnpfMlWCtbhpKP6fNZDrgNsf4w6GhmdK8Q0H2dJNdGlTk9gjaI5/sCjrDC0UR8tF40eC0GKFK/LitTQ5gR76HH8o4f+QUHqLT/irx4q6JRR82mjzShJrs15pJcjGnzmBdhoBGCNyUfvgBopLUDonyuU1hVLdRzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KP6O/+Vv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KP6O/+Vv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123911F00893;
	Wed, 16 Sep 2026 12:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789560912;
	bh=Fp1qYm1XPVwZNPStweuSyuntzZYlrpKuiu6hbBk1yYA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KP6O/+VvYjPhwSX1+YLUmR0Lobo1rItQK8yNVvwXsYIjr5++CAr5UqW0qqv3ki4zI
	 0ovJt/PYm35Oih5w5RdizlkdSE6Mzhc3kU9/xqowsUhGkYrlQ6j46t59vBMCh3qlT9
	 kNieEquy1NjEim7ywV/qJMFtnRZkoJf77tBG32EIJBhqcEdpLz6eA/ADKkOhwm2TQe
	 QYjqS8tSRlUCxAgV+EfDb+e2rBF3Eq2/hdyWVnUY3g+fXfAPl6MzpHcNMqyad2idv7
	 iyew0SmxLAjAfGWq1OpF4y7Rdkk1gZzZfaMP3ZNtdSEyJihlwapKKmaKf8LTcVCd94
	 ay2ZJUkgSZJyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/region: Create node access attributes for
 CFMWS-only NUMA nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260916120338.369436-1-kanie@linux.alibaba.com>
References: <20260916120338.369436-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 12:15:11 +0000
Message-Id: <20260916121512.123911F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] cxl: backwards naming of cxl_need_node_perf_attrs_update()
--

commit b11d76869ff914a767abdc38146d89e156a8de78
Author: Guixin Liu <kanie@linux.alibaba.com>

cxl/region: Create node access attributes for CFMWS-only NUMA nodes

This patch handles a case where a NUMA node only backs a CXL fixed memory
window without being enumerated by SRAT. When such a node is not backed by
a real SRAT PXM, it creates the node access attributes using
node_set_perf_attrs() rather than just trying to update them.

> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index df9261ba84e5a..1ac7ce3a6127e 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c

[ ... ]

> @@ -1072,3 +1072,8 @@ void cxl_region_perf_data_calculate(struct cxl_regi=
on *cxlr,
>  		cxlr->coord[i].write_bandwidth +=3D perf->coord[i].write_bandwidth;
>  	}
>  }
> +
> +bool cxl_need_node_perf_attrs_update(int nid)
> +{
> +	return !acpi_node_backed_by_real_pxm(nid);
> +}

[Severity: Low]
Does this function name accurately describe what it checks for? It seems to
return true when the node is NOT backed by a real SRAT PXM, which means it
needs creation rather than an update.

[ ... ]

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 4f6069451fed6..11902e7f6a1c6 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c

[ ... ]

> @@ -2631,7 +2631,10 @@ static bool cxl_region_update_coordinates(struct c=
xl_region *cxlr, int nid)
> =20
>  	for (int i =3D 0; i < ACCESS_COORDINATE_MAX; i++) {
>  		if (cxlr->coord[i].read_bandwidth) {
> -			node_update_perf_attrs(nid, &cxlr->coord[i], i);
> +			if (cxl_need_node_perf_attrs_update(nid))
> +				node_set_perf_attrs(nid, &cxlr->coord[i], i);
> +			else
> +				node_update_perf_attrs(nid, &cxlr->coord[i], i);

[Severity: Low]
Is the logic backwards here because of the helper name?=20

If cxl_need_node_perf_attrs_update() returns true, this calls
node_set_perf_attrs() to create the attributes. If it returns false, it
calls node_update_perf_attrs() to update them.

This effectively reads as "if we need to update, we set; otherwise we
update". Would renaming the helper to something like
cxl_need_node_perf_attrs_creation() make this logic clearer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916120338.3694=
36-1-kanie@linux.alibaba.com?part=3D1
