Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279583E0226
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170452; cv=none; b=dTMEgx9PFh8fDPr9mGUjEXh0bjcyAHEH3b47rsyt0F6iUdBmxvS88ET+6jT7bhofN//dW8shAyBpku35cELz9/85TQvUOlxdEddPnR7sZxA+PSEfTqZq7MPcCqLPLeaxmiHL3RsGG4wLIB8pBTNOy+QFWTWI5tKLDFh0Z5Yy83o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170452; c=relaxed/simple;
	bh=sKFSfq1sLNNBn+F0r+O+agPE95Q3YLR5hTz4EMCCfj8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E1ZYANSmwRjSrhK07Mytc5vyx3ZLQ6H1NBG4M8iqlhnKzC305vrd/RJpccmQL//nEZtzJkXNprWfOgd3Nl3Wm2emQ4CMD9mhJdlfjRNZfiU/URuYQW2t8OrVaOC4tuOTJ/N0gpwVPzJsxv+fAil1yKMCNQ5+QU3O3VfyK9UA3jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuuDJQD4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuuDJQD4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AB11F000E9;
	Mon, 31 Aug 2026 10:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788170450;
	bh=KE1arxexRku41ND12Ilihn5xXMts2Z68dEMZ+0FHxjI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZuuDJQD4XWjVfQQ2WFV6c26CEwixMUT6iI+7U/ljE+JMiRgkAPYGCMkQQAsoThnuq
	 Kk2iatvRpqlIOGvGt1FG5SD7apRszQ9c/xiWmcWkNLvSxNkr406mvvTB0gRWETnpi2
	 CRPgsZTRmQwTE9uYuzXGyYf2dZP5OBGPEvxz64Rb+/Wy0Mf5hDfBcy90jgLjf+qBSB
	 6UUjvDeoOaAzLfXQ/W4dVifpWkURE7O+3yFlzBt65e9u1W55widieu95I+T1n5TvV5
	 4vIc8B32x+KXJPp1sbrWaUT77d5c5TRc6uyR7S5yoPoud2c5VZ9WvPvZC2HXRtdWyv
	 0V2SsVITpvBHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] cxl/port: Fix uninitialized coordinates reported
 for RCDs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260831092216.540644-3-kanie@linux.alibaba.com>
References: <20260831092216.540644-1-kanie@linux.alibaba.com>
 <20260831092216.540644-3-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 10:00:50 +0000
Message-Id: <20260831100050.A9AB11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Zeroing access coordinates for RCDs causes bandwidth calculation t=
o bypass assignment, resulting in 0 bandwidth for QoS matching.

Pre-existing issues:
- [Critical] parent_port_is_cxl_root() causes a NULL pointer dereference fo=
r CXL devices directly connected to a Root Port.
--

commit 2dd3e928fa65a79b6a782bef4e7234009cf5df5e
Author: Guixin Liu <kanie@linux.alibaba.com>

cxl/port: Fix uninitialized coordinates reported for RCDs

This commit initializes the access_coordinate array to zero for Restricted =
CXL
Devices (RCDs) to prevent exposing uninitialized stack memory to callers.

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 625e4aa427db0..fea43a92744cd 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2394,8 +2394,10 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_p=
ort *port,
>  	 * Skip calculation for RCD. Expectation is HMAT already covers RCD case
>  	 * since RCH does not support hotplug.
>  	 */
> -	if (cxlmd->cxlds->rcd)
> +	if (cxlmd->cxlds->rcd) {
> +		memset(coord, 0, sizeof(*coord) * ACCESS_COORDINATE_MAX);

[Severity: High]
Does zeroing the access coordinates break bandwidth calculations for RCDs?

The neutral/no-op value for CXL access coordinate bandwidth is UINT_MAX,
not 0. When cxl_coordinates_combine() is later called to merge these values,
__cxl_coordinates_combine() checks:

if (c1->write_bandwidth && c2->write_bandwidth)
        out->write_bandwidth =3D min(c1->write_bandwidth,
                                   c2->write_bandwidth);

Because this memset sets the bandwidth to 0, the condition evaluates to fal=
se,
bypassing the assignment. This leaves the output bandwidth unassigned (0),
which causes subsequent QoS class calculations to fail or misclassify the
device.

>  		return 0;
> +	}
> =20
>  	/*
>  	 * Exit the loop when the parent port of the current iter port is cxl
>  	 * root. The iterative loop starts at the endpoint and gathers the
>  	 * latency of the CXL link from the current device/port to the connected
>  	 * downstream port each iteration.
>  	 */
>  	do {
>  		dport =3D iter->parent_dport;
>  		iter =3D to_cxl_port(iter->dev.parent);
>  		is_cxl_root =3D parent_port_is_cxl_root(iter);

[Severity: Critical]
This is a pre-existing issue, but does parent_port_is_cxl_root() cause a NU=
LL
pointer dereference for CXL devices directly connected to a Root Port?

When the endpoint is directly attached to a CXL Root Port, the loop advances
iter to the CXL Root port itself. Passing iter to parent_port_is_cxl_root()
evaluates:

is_cxl_root(to_cxl_port(port->dev.parent))

Since iter is already the CXL Root port, its dev.parent is a platform device
(such as an ACPI device), not a cxl_port. to_cxl_port() fails the type chec=
k,
triggers a dev_WARN_ONCE, and returns NULL.

is_cxl_root() then unconditionally dereferences the NULL pointer in cxl.h:

return port->uport_dev =3D=3D port->dev.parent;

This results in a kernel panic on standard boot and probe paths for common
topologies.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831092216.5406=
44-1-kanie@linux.alibaba.com?part=3D2
