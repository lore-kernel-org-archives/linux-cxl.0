Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8694E80AD
	for <linux-cxl@vger.kernel.org>; Fri,  4 Sep 2026 17:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788543574; cv=none; b=pQ+uvN+j5CUnTzPTnTuENzDZYKWdTqoeeFhnv3OG7fFaaU2HlbX+aysyKFRvsZD14VxQOrbQ5SHCHcbcg/TJXrsDs+BvHzMqHkqMlsaCgbeUPgiyYVw2bDO20yhlxEy/neUKg/OgmnxiYZxWfHuXpnoNcWK7GCsWMUC8N9QP3YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788543574; c=relaxed/simple;
	bh=36fE6zbtsUDDX6xqeMNRTP9/hntMV0jEJftj9BxNoYk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lHlgVY8dJoOkwrcbqH+kkSnAqEx6TXZuVDgKxAhqgTqWhy/HAldXq+x/CNnN9aXBK897qmof1lIsbR2r7z+N2PKjHWenAvoVzCrTzKJoH3uw4pWU7GtrBWu7vMhGsxBz/g6wPeUnfxfewxKi8TiVBQNFLuyZYjSWzWu6kbyP0QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvl/qh/2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvl/qh/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A9E1F00A3D;
	Fri,  4 Sep 2026 17:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788543572;
	bh=nDSlZ+rwGTdyPdco8kk1x8ymG7dMpDQZZCGO6MENsm0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dvl/qh/2e+rMTprQFpCz1aQASwvVzvlB69HtnL58/s9MvSLkIAheCZ2tw+33gioLZ
	 OWaerL1YCRhT0ncfPDXN1PMVuJYtHBQ017pLiDPg08m3FLTZFdv/V260Qr5vo8zhW/
	 YXCeBlQDR+x2tdliZlepDeEaqyzUVTcJ7qoDgBITiMrl10buJxoI0lu80eN1bC3O/b
	 McIqS5RbR6fLykTCrbPBLmwSVic9NbncdQLF6ACiEqTCZH3Ufk6+YO6RKWQX6A//o/
	 xEDazcwbxiAi6Magi8TXtewlYTp7NR8UJTZDvWV13zktDp788zwf3xP0OmBHXSO9n7
	 ffixjIGGxRprg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/13] efi/cper: Reject CPER records with an
 out-of-range error_data_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260904172337.1409775-2-dave.jiang@intel.com>
References: <20260904172337.1409775-1-dave.jiang@intel.com>
 <20260904172337.1409775-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 17:39:32 +0000
Message-Id: <20260904173932.84A9E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The section iterator allows out-of-bounds memory reads when evalua=
ting the generic data header on truncated CPER records.
--

commit 11208300cad76f5a8ea35d8ac53a2941f6447499
Author: Dave Jiang <dave.jiang@intel.com>

efi/cper: Reject CPER records with an out-of-range error_data_length

This commit uses check_add_overflow() to reject CPER records with a huge
error_data_length that wraps around when summed with the header size. It
prevents infinite loops or out-of-bounds walks caused by integer overflow
during section iteration.

Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@i=
ntel.com?part=3D1

> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 06b4fdb59917a..332c78f2d5617 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c

[ ... ]

> @@ -762,10 +762,18 @@ int cper_estatus_check(const struct acpi_hest_gener=
ic_status *estatus)
>  	data_len =3D estatus->data_length;
> =20
>  	apei_estatus_for_each_section(estatus, gdata) {
> -		if (acpi_hest_get_size(gdata) > data_len)
> +		int record_size;
> +
> +		/*
> +		 * The <acpi/ghes.h> helpers sum these as a signed int, so a
> +		 * huge error_data_length wraps small rather than large and the
> +		 * walk then advances by that wrapped value. Reject a size an
> +		 * int cannot carry.
> +		 */
> +		if (check_add_overflow(acpi_hest_get_size(gdata),
> +				       gdata->error_data_length, &record_size))

[Severity: High]
This isn't a bug introduced by this patch, but does the section iterator
allow out-of-bounds memory reads when evaluating the generic data header on
truncated CPER records?

If the firmware provides a CPER record where the total data length covers
the first section plus a small positive remainder (for example, 1 byte), the
apei_estatus_for_each_section() loop will advance to the second section
because there is still remaining data length.

Inside the loop, the updated code evaluates check_add_overflow():

    if (check_add_overflow(acpi_hest_get_size(gdata),
                           gdata->error_data_length, &record_size))

This evaluates acpi_hest_get_size(gdata) (which accesses gdata->revision)
and reads gdata->error_data_length before verifying that the remaining data
length is large enough to contain the generic data header.

Could this trigger a page fault and kernel panic in NMI or IRQ context if
the firmware error logs are malformed? While this problem was pre-existing,
this patch replaces the acpi_hest_get_size() check with check_add_overflow(=
),
adding an unconditional read of gdata->error_data_length to the existing
out-of-bounds read of gdata->revision.

>  			return -EINVAL;
> =20
> -		record_size =3D acpi_hest_get_record_size(gdata);
>  		if (record_size > data_len)
>  			return -EINVAL;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904172337.1409=
775-1-dave.jiang@intel.com?part=3D1
