Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A6323E334
	for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791650297; cv=none; b=LC2+R7GX7w7TIao/Diis5RHhr84fdAjG37kUv6KoBAkDc3nWIeHUOX52PhWp4Cg9kp8VAMEdbV+wRHYCJRH//D6mMcNvrVqYPPJabwoIgNx1vXt0PjSJ/niI0BNMOAecfHf5Pin2MO1Irt1BEaIDv2808rm054mgr4VKPOtjmD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791650297; c=relaxed/simple;
	bh=OciOU+ZhqaDzpfFETzAadxv8pK9CspNvVtLsIgEVbpw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=E45KxJwx6BKPLjf427AX1N0Q1lZ7GjZZKGjJKVsyjQXO+DvvyXRRLzxlZEN8+ekkeiAE/mpIRPmMa0ihVxIEqOf54uHR4CfdcLFO54u1DaJJ0GgZEkQlqIJi7h70EK17YvMXWOtlfzLVWI+Fw7BGAXTUfO6nbyTaSqs7aFScvXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFMMl922; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFMMl922"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8A21F000FF;
	Sat, 10 Oct 2026 16:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791650295;
	bh=N+wyg/JnHtya3uGD6fluRAjg8lDGsc4nP5eUerBHLMk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iFMMl922PkH0L4Eg1/z9WeNB/nnvXjMZcpMP/2bNspsmIACVgGNY3DEnxz6ax9NGW
	 uzLBu8Zo03PQtVjCqzm1CWIcEJ2hYfBtPPcd2aJLur0ZMd9UuK9C4FoZBCA9WBZA6V
	 wcEsP9SZ1vseQUqG2PJhajhcRBCrgYbbPN8idmKF4Mo+exkTYnObW6wDotKStQT8Gw
	 fA0hfrJk2AtGCiQ2mwsvonlj/RAdgUgwtNUFiGJSl7b+Ru6gd8NrQclFVjWaG6fWDk
	 s7UE89pxOum8AKtj6TpcrwesPBXudCVuGKaLrMWXLkvHeRUcr0FePJmuKaXBGWjI9h
	 HltyzOLd4wIuw==
Message-ID: <sashiko-outbox-166745@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/5] cxl/mbox: Add Get Poison List snapshot support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shaikh Kamaluddin" <shaikhkamal2012@gmail.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20261010162017.62506-2-shaikhkamal2012@gmail.com>
References: <20261010162017.62506-1-shaikhkamal2012@gmail.com>
 <20261010162017.62506-2-shaikhkamal2012@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 16:38:14 +0000
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] cxl: cxl_poison_snapshot_append returns -ENOSPC, bypassing truncat=
ion handler
--

commit 14df359a915714a1d8f08f27fcdf1ccf13b88763
Author: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>

cxl/mbox: Add Get Poison List snapshot support

The commit adds snapshot support to copy Get Poison List records from a
device into a caller-owned buffer. It allows callers to inspect the complete
set of collected records while preserving existing trace-only behavior for
current callers.

> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 55828a836c01a..2752b46ffee29 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
[ ... ]
> +static int cxl_poison_snapshot_append(struct cxl_poison_snapshot *snapsh=
ot,
> +				      struct cxl_poison_record *records,
> +				      u32 count)
> +{
[ ... ]
> +	available =3D snapshot->capacity - snapshot->nr_records;
> +	if (count > available) {
> +		snapshot->truncated =3D true;
> +		return -ENOSPC;
> +	}

[Severity: High]
Does returning -ENOSPC here cause the caller to prematurely abort?

In drivers/cxl/core/mbox.c, cxl_poison_snapshot_append(), when the device
returns more poison records than snapshot->capacity, returning -ENOSPC inst=
ead
of clamping the count and returning success prevents the loop in
cxl_mem_get_poison_common() from completing its normal termination logic.

> +
> +	memcpy(&snapshot->records[snapshot->nr_records], records,
> +	       count * sizeof(*records));
> +	snapshot->nr_records +=3D count;
> +
> +	return 0;
> +}
> +
> +static int cxl_mem_get_poison_common(struct cxl_memdev *cxlmd, u64 offse=
t,
> +				     u64 len, struct cxl_region *cxlr,
> +				     struct cxl_poison_snapshot *snapshot)
>  {
[ ... ]
> +		rc =3D cxl_poison_snapshot_append(snapshot, po->record, count);
> +		if (rc)
> +			break;

[Severity: High]
Does breaking early on -ENOSPC deprive the caller of the expected truncation
state?

In drivers/cxl/core/mbox.c, cxl_mem_get_poison_common(), if
cxl_poison_snapshot_append() returns -ENOSPC, this propagates up and breaks=
 the
loop before the internal termination logic can be reached. The generic error
cascades up to the caller, bypassing the expected truncation handler design=
ed
to handle this exact scenario.

> +
> +		/* Protect against an uncleared _FLAG_MORE */
> -		nr_records =3D nr_records + le16_to_cpu(po->count);
> +		nr_records +=3D count;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010162017.6250=
6-1-shaikhkamal2012@gmail.com?part=3D1
