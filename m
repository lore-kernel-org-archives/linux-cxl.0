Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243A14A0F17
	for <linux-cxl@vger.kernel.org>; Thu, 17 Sep 2026 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642394; cv=none; b=jbZujGsnpe4Yj15FHE5Ino5VDlNSfuofMGxP7eoP6Esz2djpmg08DPQs9G1ijEdDSfC0JVfOvMNWDgxXyKgo9RxyqWvw1JqSmFXW2FmiI/eKZOUCvp+DGuiX0ldk3r7BxpzTbUBWVTUplqSbDmjTl+8XLsK1Rop6KwsyZr9XUv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642394; c=relaxed/simple;
	bh=ka0/m+qtdPWkFPiXlttemM28bRjjyU/0vCTCEkkQ8ac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A39LB05dgktyvTeTZ5ZdrwW9R7NVkI+Wtp8gMWEotqZBvrdJT4XvNE5hw5t8DGRVBzgRx/I5H0EDG8eiYKVtnnPAMLVRzOhARgO//E7QTHnDK2YF6ux9a2XYEdCnh01WbcZl/L5+KvbBQMFH0r/c7cWv12KxMk3fZ6ZvpnROqxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IY+2ziUB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IY+2ziUB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165CF1F000FF;
	Thu, 17 Sep 2026 10:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789642382;
	bh=cgJ683rOiJvs0ecOh1v5HYYpJ6FcMtXWYrGT9udLb5A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IY+2ziUB+4uZiEndRtDWEaGbbsLVayBWY0xlxRKPddk+vJvI1k+jVaEpjXaAgoHWn
	 O8YPncVK1moiSYgc6xe6WDApsinVNStaKI9qtpZ7kMchL4TzvmWqky58DsEDLT0pkf
	 hI50TroeJz0hxT4tRZAqB5iKJBUxkyvzdgjtpsTUBUJy+zgncBhmM38x6y4lVMBcTk
	 8uLddVgZshpoS250XE653qtmFSzjdjWEJpHjY9RFI4gUj+Kn5TTnvJUQiCj1doa5KJ
	 ll5ThpSa2AVF+YjDXPlF7ZWTZ0eSMiRtDtCGUumNr+L8RUZ7KyeKp/jHnOB4X4ZZ4e
	 SlGMsDfOtlXqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] cxl/mbox: bound the Get Supported Logs entry count
 by the payload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gaobin Huang" <huanggaobin23@semi.ac.cn>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260917104603.2658529-1-huanggaobin23@semi.ac.cn>
References: <20260917104603.2658529-1-huanggaobin23@semi.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 10:53:01 +0000
Message-Id: <20260917105302.165CF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] cxl/mbox: memory leak of gsl buffer on truncated payload error p=
ath
--

commit 7ecb0885e04d5e150bd0769634b9a3391c017244
Author: Gaobin Huang <huanggaobin23@semi.ac.cn>
cxl/mbox: bound the Get Supported Logs entry count by the payload

This commit adds bounds checking for the number of entries in the Get
Supported Logs response against the actual payload size. It prevents
out-of-bounds reads during device probe by ensuring the device doesn't
report more entries than it actually returns.

> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
[ ... ]
> @@ -849,18 +851,47 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>  	struct cxl_mbox_get_supported_logs *gsl;
>  	struct device *dev =3D mds->cxlds.dev;
>  	struct cxl_mem_command *cmd;
> +	size_t gsl_len, gsl_hdr_size, max_entries;
>  	int i, rc;
> =20
> -	gsl =3D cxl_get_gsl(mds);
> +	gsl =3D cxl_get_gsl(mds, &gsl_len);
>  	if (IS_ERR(gsl))
>  		return PTR_ERR(gsl);
> =20
> +	/*
> +	 * The device chooses the reported payload length and min_out only
> +	 * requires the entry count field on its own (2 bytes), so a response
> +	 * shorter than the header is reachable.  There is nothing to enumerate
> +	 * in that case: fail rather than derive a bound from an underflowed
> +	 * subtraction.
> +	 */
> +	gsl_hdr_size =3D struct_offset(gsl, entry);
> +	if (gsl_len < gsl_hdr_size) {
> +		dev_err(dev,
> +		"GSL: response of %zu bytes is too short for the header\n",
> +		gsl_len);
> +		return -EIO;

[Severity: Medium]
Does this code leak the `gsl` buffer allocated by cxl_get_gsl()?

cxl_get_gsl() dynamically allocates the `gsl` buffer using kvmalloc() and
returns it. By directly returning -EIO when the payload is shorter than the
header, we bypass the `goto out;` block which contains the necessary
kvfree(gsl) call. Since this occurs on a device probe error path, it leaks
the allocated memory.

As an additional observation, leaving `.min_out =3D 2` in cxl_get_gsl() for=
ces
higher layers to manually re-validate the payload length here. Setting
`.min_out =3D 8` (or using struct_size()) in cxl_get_gsl() would allow the =
CXL
mailbox core to handle this validation natively without requiring these
manual checks.

> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917104603.2658=
529-1-huanggaobin23@semi.ac.cn?part=3D1
