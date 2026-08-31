Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3B5469850
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788190694; cv=none; b=lmref1Px1r179R4lbZXW/+Aknn7XBkpRXoRStnsDWIjQxR5egHCMvjezBE0vj+6Rrqbmfv4NG3/xwSx5ODXkv/+E4+Ma5AO7etFfOdQN1HXVgD5sQ+rtOXYCEhzgVz74/yroVg/3kOYaIaBoYUbRLnvPayrA2cMu5O4bQ7DBXPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788190694; c=relaxed/simple;
	bh=aVGTmCsuYzXj/eqGoDYR12c96RR5Z+uUwyqDKM4V23E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XCFj5ZLnBnDcmXvW20xLWWVWTci5Zl/R7Z9ffYU9b+lz30dh2AuX23Fdu3UYrpExk7FNGZxi049GjZKbfHA6ktfPIdrj0WYX60QxBEQsRLYNSReIsg7RTAPivrP5ep6huQlsxw3kSXOy2UP0FB+tq2C98UaVvedlZv0UkjxLMLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O52gR6Zk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O52gR6Zk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A830D1F00A3D;
	Mon, 31 Aug 2026 15:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788190692;
	bh=RILhKJIGOD59NSE9T9d5sU2veiQtQjOMjEeiyAIrQ6k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O52gR6ZkMagaAcY0GRFkEWjXOHnhDXYmb1cYU4ckCgQa889GHYA8Z3Y2IieFQkEXn
	 9LAyyEp8rERt5FHOyp64IZbvIiTHiG+381taCrHOf5Cj8wqvPvpNf/l4XjU/e0dRAW
	 I4RVmjBfohIGLUp9jSFsBuwPtBU44S2lKRnVIOYERWv2V2XSulJu8/0T7IkmnUvpqQ
	 2/Etp62TywCl8EBYoCDwx9btJSRWQFhFEBelboya8MB4ma9H3xARHNSc+AZMbmXt2o
	 iduQ+IKFJYCzX/piTcPwokiUZQ8PiHgHEqhqRWVtf4obWnD95m00s3DF0HZg0CHKtR
	 8YfH3VfvvG18A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] cxl/region: Validate partition index
 before array access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260831133314.4125787-312-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-312-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 15:38:12 +0000
Message-Id: <20260831153812.A830D1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Malformed loop condition in `__cxl_dpa_reserve()` causes an infini=
te loop and out-of-bounds read if a resource does not match any partition.
- [High] `poison_by_decoder()` misses partition index validation, causing a=
n out-of-bounds read if `cxled->part` is -1.
--

commit 31fe17e0b5eabcb1df81ee069bc89ecabb1a8d36
Author: Koba Ko <kobak@nvidia.com>

cxl/region: Validate partition index before array access

construct_region() reads cxled->part and uses it to index
cxlds->part[] without checking for a negative value. If the
partition was never resolved, part remains at its initial value
of -1, causing an out-of-bounds array access.

Link: https://patch.msgid.link/20260414024527.3399590-1-kobak@nvidia.com

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 41b64d871c5a1..e09ba89889397 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3521,6 +3521,9 @@ static struct cxl_region *construct_region(struct c=
xl_root_decoder *cxlrd,
>  	int rc, part =3D READ_ONCE(cxled->part);
>  	struct cxl_region *cxlr;
> =20
> +	if (part < 0)
> +		return ERR_PTR(-EBUSY);
> +
>  	do {
>  		cxlr =3D __create_region(cxlrd, cxlds->part[part].mode,
>  				       atomic_read(&cxlrd->region_id));

[Severity: High]
This is a pre-existing issue, but does poison_by_decoder() in this same file
also miss this partition index validation?=20

If cxled->part is -1, it appears we skip index validation and jump directly
to reading cxlds->part[-1].mode:

drivers/cxl/core/region.c:poison_by_decoder() {
    ...
    mode =3D cxlds->part[cxled->part].mode;
    ...
}

Could this cause a similar out-of-bounds read during CXL endpoint poison
iteration?

[Severity: High]
This is a pre-existing issue, but does the loop condition in
__cxl_dpa_reserve() evaluate as constantly true?

drivers/cxl/core/hdm.c:__cxl_dpa_reserve() {
    ...
    for (int i =3D 0; cxlds->nr_partitions; i++)
    ...
}

If a resource does not match any partition, i increments infinitely because
cxlds->nr_partitions is evaluated as a constant boolean rather than an index
bound. Could this cause an infinite loop and out-of-bounds read on cxlds->p=
art
until a page fault halts execution?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-312-sashal@kernel.org?part=3D1
