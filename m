Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40332224D6
	for <linux-cxl@vger.kernel.org>; Sun,  7 Jun 2026 19:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780861555; cv=none; b=VlZXEXyX7fWtdgd1E+1fIrQIrItVXOe2QZA+gizMWm5/rdW2qrf/mkpbavJ6hnk9Xqa+S0xWbSNMOM+cRjSz+k5O1XjxUfq1oITmFJ9516EDRT4fscqPi5Ctc7jFYcrN1rTL3k3YGGun85RUp26tsrlQcJw1QJrR4lupw7+dsUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780861555; c=relaxed/simple;
	bh=+jzhfDFaPAEzYqHVxSZzoahMvLDkggXKfPbretKhEi0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PJUJnvYdYGqQMMQrpGTCx8tcMAinSKb0CW3/8coTjHK6OkcXSI6LNOUgtYt8ts/QowyrK3q0mO8HilgKuyqWx6il6jUBJvg5spSs0fZSAHxeyhWPj8ldUTP4LCWHoHPWgxWIXsA7JWjgIoLlzg8UGYYBgtDrK2es7O5kBHxaXLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZU2JKDBH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZU2JKDBH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62291F00893;
	Sun,  7 Jun 2026 19:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780861554;
	bh=rz2NOxto2ywS3m87homLrb2MoW6x2qpycWHVVNXWrCY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZU2JKDBH/u/mdnrwIJePimoLzLUctLenpEtwgUYofXZeahWm0+l/upRNyj0EulKU6
	 pmXB3AxBObEs7HaPZnuk/Ql9s6ulALP9kHFXJ/gEDm1yJxc2fOYc5/a3muabdK5qxk
	 Bf8E0jBnLrckhQQf39VfeZ3+jTWQ7GJBjkX0OItybz9+iyoGLxn/7rFf8YtuGdUydJ
	 NcC2EA66d/pQ4xtmYUd3aYEgFko+uyexOCAlNzSwVNnAfz/QIFGDBCmagnZoyQHtai
	 MobQZOefTRguA+u3ukrYZZD3RLTu8sxM0Yo2Rgaig9AUOcZJOA/PxmWqgaOO4uLNZ6
	 0FVjsS9BC/f6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 1/9] dax: fix misleading comment about share/index
 union in dax_folio_reset_order()
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019ea3932c9b-91164474-4e3f-48ee-844a-be310f330793-000000@email.amazonses.com>
References: <0100019ea3932c9b-91164474-4e3f-48ee-844a-be310f330793-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 19:45:53 +0000
Message-Id: <20260607194553.C62291F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect PFN advancement in `fsdev_clear_folio_state()` when star=
ting from a tail page of a stale compound folio.
--

commit eb3e25245bdf433dc92d71266558b877ef6655c1
Author: John Groves <John@Groves.net>
dax: fix misleading comment about share/index union in dax_folio_reset_orde=
r()

This commit updates a misleading comment in dax_folio_reset_order() to
accurately describe the aliasing of folio->share and folio->index in the
union. It clarifies that the assignment safely clears whichever interpretat=
ion
is active, as both fields should be zeroed when the folio is released.

> diff --git a/fs/dax.c b/fs/dax.c
> index 6d175cd47a99b..df19c9317d10e 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -392,12 +392,12 @@ int dax_folio_reset_order(struct folio *folio)
>  	int order =3D folio_order(folio);
> =20
>  	/*
> -	 * DAX maintains the invariant that folio->share !=3D 0 only when
> -	 * folio->mapping =3D=3D NULL (enforced by dax_folio_make_shared()).
> -	 * Equivalently: folio->mapping !=3D NULL implies folio->share =3D=3D 0.
> -	 * Callers ensure share has been decremented to zero before
> -	 * calling here, so unconditionally clearing both fields is
> -	 * correct.
> +	 * Clear the mapping and the index/share union word. folio->share
> +	 * and folio->index occupy the same union in struct folio. For
> +	 * non-shared folios (mapping !=3D NULL), the union holds folio->index
> +	 * (file page offset); for shared folios (mapping =3D=3D NULL), it holds
> +	 * folio->share (reference count). Either way, we are releasing the
> +	 * folio and both fields should be zeroed.
>  	 */
>  	folio->mapping =3D NULL;

[Severity: High]
This isn't a bug introduced by this patch, but looking at how callers use
dax_folio_reset_order():

drivers/dax/fsdev.c:fsdev_clear_folio_state() {
...
		while (pfn < end_pfn) {
			struct folio *folio =3D pfn_folio(pfn);
			int order =3D dax_folio_reset_order(folio);

			pfn +=3D 1UL << order;
		}
...
}

Does this loop incorrectly advance the pfn if the range start falls within a
previously initialized compound page (a tail page)?

Since pfn_folio() returns the head folio, advancing by 1UL << order from the
current pfn might skip over the beginning of the next contiguous memory
region. This could leave stale compound metadata on those skipped pages.

Should the pfn advancement account for the page's index within the folio?

>  	folio->share =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019ea3929225-a0=
f8e6f7-30ae-4f8e-ae6f-19129666c4c3-000000@email.amazonses.com?part=3D1
