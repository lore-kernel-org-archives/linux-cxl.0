Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA9E37DAA9
	for <linux-cxl@vger.kernel.org>; Thu,  8 Oct 2026 03:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431929; cv=none; b=FzCD08T0II2X+Nv3zfcZmWrJdNACNldZnQLP7wHSRK5NVMth3guDog3Gzw08AP4aL1hQLAto23JcXupQN/jzZ7FjcSgI2bwf9gBQ2ycy1jKSfRuEEzua8uyTBmvlZPsI2yZnlhEOhEbq12eb0DjazVgcNAqEcWcOvtrWT+Yq3SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431929; c=relaxed/simple;
	bh=Z0ZQd1QFEc8xo0mAwOPqnsdmpql4SRnHAcp5uIvmZjQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qr8KPTuoM8R5OomFw6cuZcXPAYUo5wMBc4KU/+TdNntfqHNeId4hW7uyiFi+ditzpi2VfVWPewpF6u2oPJpoUcl0VMCkej2Fc+nQqMgdDZyaxvTdUCGgqwEcaOxovkB1AW6XLiaTcmk2ekIhRKUAmBDY1WVuqSytDl7M25zQ21M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQfKs0Bd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQfKs0Bd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1311F00893;
	Thu,  8 Oct 2026 03:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791431928;
	bh=1r4yPihAwRKlBDtosH/vn0evoqvmy+5n7mGRKdeGu9U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QQfKs0Bd8odqyXQ3KkG2LosLOYuj4B5lyMUzd59L6THxSmsFZKF5eMnDFNpH+5+0T
	 ARimgmc++7xw3LPXDqeRXIysxLi3aDwvhAd8wWFJfLQ8EQlRdxeyk9OJDTcDz83uwe
	 kO5bWhr5f/tmd1G2stj1NWvkdxHQHatoRuX4ZUYrlnRoBXKy27XxbgmGV+OUWjSDU2
	 hDlIrCAyYyoOoUGkvG9G0Bf9CcTbCebfSbUeg/Io5rFbOK9iphVMA66RqJplm+UIDf
	 p2OqzfYJp8388zTwm16//7+T3Ys+F7fva21/9Upa8IvRHVjuT81U/t75D+iubMf37V
	 zWY6UpZWI/Cug==
Message-ID: <sashiko-outbox-163599@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] cxl/pci: Program the Port GPF timeouts before
 caching the DVSEC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20261008034619.28059-3-kanie@linux.alibaba.com>
References: <20261008034619.28059-1-kanie@linux.alibaba.com>
 <20261008034619.28059-3-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 03:58:47 +0000
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] cxl: build fragility due to FIELD_PREP/FIELD_GET non-constant mask =
usage
--

commit 502048ecbaa85e66fc08a6f9dd92c92082d18d7f
Author: Guixin Liu <kanie@linux.alibaba.com>

cxl/pci: Program the Port GPF timeouts before caching the DVSEC

This commit delays caching the Port GPF DVSEC offset until both configurati=
on
phases are successfully programmed. This ensures that any endpoint attach
attempts will retry the setup if a configuration write fails.

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -849,7 +849,7 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev=
, int dvsec, int phase)
> =20
>  	rc =3D pci_read_config_word(pdev, dvsec + offset, &ctrl);
>  	if (rc)
> -		return rc;
> +		return pcibios_err_to_errno(rc);
> =20
>  	if (FIELD_GET(base, ctrl) =3D=3D GPF_TIMEOUT_BASE_MAX &&
>  	    FIELD_GET(scale, ctrl) =3D=3D GPF_TIMEOUT_SCALE_MAX)
> @@ -859,11 +859,17 @@ static int update_gpf_port_dvsec(struct pci_dev *pd=
ev, int dvsec, int phase)
>  	ctrl |=3D FIELD_PREP(scale, GPF_TIMEOUT_SCALE_MAX);
> =20
>  	rc =3D pci_write_config_word(pdev, dvsec + offset, ctrl);
> -	if (!rc)
> -		pci_dbg(pdev, "Port GPF phase %d timeout: %d0 secs\n",
> -			phase, GPF_TIMEOUT_BASE_MAX);
> +	if (rc) {
> +		rc =3D pcibios_err_to_errno(rc);
> +		pci_warn(pdev, "Port GPF phase %d timeout write failed: %d\n",
> +			 phase, rc);
> +		return rc;
> +	}

[Severity: Low]
Does adding this error handling and logging run the risk of breaking the
build on some compiler configurations?

Both FIELD_GET() and FIELD_PREP() internally use a BUILD_BUG_ON_MSG() macro
that strictly requires their mask arguments to be compile-time constants.
In update_gpf_port_dvsec(), base and scale are dynamically assigned
variables rather than constants.

This code currently builds only because the compiler heuristically inlines
the function or performs interprocedural constant propagation.

Because this patch increases the size of update_gpf_port_dvsec(), is there a
risk that compiler heuristics might decide against inlining it (such as when
compiling with -Os), which would expose the BUILD_BUG_ON_MSG() failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008034619.2805=
9-1-kanie@linux.alibaba.com?part=3D2
