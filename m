Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F05134D3B2
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 20:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787863935; cv=none; b=KKR/oVRUa8DXt/ErhQ5ylqC36NE4ZVlh3n7VbYuLwwQ/Qk1I5B5SbSjqWsFjC9ZpVM117HgqonBu8Zz1m0jNFnRTSik3y46QBKXGmfwGZiOzb6hMy8bXks7J2RfuFAJ4wtZjjkc16cFw6PMRvJoMei9qHbJo32UG4OOZ7bU4n4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787863935; c=relaxed/simple;
	bh=V37rrCAkjSGJKWOAGpqTn9MLKxoAuVluVAwwVD9R0bI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GghwNtFfwEDKp20/Jgdjh5SMK/zlwK9/ODEDVqNDN9mhkluFXBmoTuNTMg/fHxebswI8IxUnFRK6oZLoCqv0PMnEWKJv2hkVUKthKit0g5b+XMQJbH7myMokdceR6bv9BWUbsfTop1f9jdhCC+TfpNz74VYT+lL5WPl7lYpR8wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfPwsTpZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfPwsTpZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56E11F000E9;
	Thu, 27 Aug 2026 20:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787863933;
	bh=zW53Aa8lD4CB/JVriRBjqYu94kQCh3TSn6QPpTPVwJs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SfPwsTpZTHT/MsSmhINnLUmtNi3k5XSacTgk7xywW5PaTLMsdLrYDHAFQcpg0qd4x
	 3vMIt9ptKbHJYPY3zGPenrVa6hBN03K0aUSdlg+COM7GY+t+iOnxLIFAFl356krbdg
	 dyC0oP1j0SapVJaO59GyQsOeqWJQHcph3cxd71ZaEGLIpYTn8iihnin1lMsI2DKzKl
	 SSL50xcPaIcsvqPsMGrTNOhlrlvRTzqw2xrvdqq5Acob7XQ2lUM4HuVnyhVMeufIq+
	 YK0Z8cQvKFFOGmZr52GEGmqLtAjWxQhiJRM2eK8oyqsmc6rDbQykh8DbyewueHPoOY
	 8P1dGoJZZ+8bQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/13] efi/cper: Reject CPER records with an
 out-of-range error_data_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260827203726.3027541-2-dave.jiang@intel.com>
References: <20260827203726.3027541-1-dave.jiang@intel.com>
 <20260827203726.3027541-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 20:52:13 +0000
Message-Id: <20260827205213.B56E11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing lower bounds check for the section header in `cper_estatus=
_check()` allows out-of-bounds reads when iterating truncated CPER records.
--

commit 2032c31f790eb3dad96643cacd189ae773ea581e
Author: Dave Jiang <dave.jiang@intel.com>
efi/cper: Reject CPER records with an out-of-range error_data_length

This commit modifies the size validation in cper_estatus_check to use
check_add_overflow. It addresses an issue where a large error_data_length
could wrap around as a signed int, bypassing the original size checks and
causing an infinite loop or out-of-bounds access.

Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@i=
ntel.com?part=3D1
Fixes: 45b14a4ffcc1 ("efi: cper: Fix possible out-of-bounds access")

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
>  			return -EINVAL;

[Severity: High]
This is a pre-existing issue, but does this code risk an out-of-bounds read
if the CPER record is truncated?

The apei_estatus_for_each_section loop condition only checks if the start of
the section is within estatus->data_length.

If a truncated record leaves fewer than sizeof(struct acpi_hest_generic_dat=
a)
bytes for the final section, the loop will still iterate.

Inside the loop, acpi_hest_get_size(gdata) reads gdata->revision, and
check_add_overflow reads gdata->error_data_length before confirming if
data_len actually has enough space for the struct header itself.

Could this result in page faults or memory corruption if malformed firmware
leaves us with a truncated section header?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827203726.3027=
541-1-dave.jiang@intel.com?part=3D1
