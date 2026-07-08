Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07443F7A8A
	for <linux-cxl@vger.kernel.org>; Wed,  8 Jul 2026 07:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497350; cv=none; b=sng0dvNVcr3npPcYPTVGTwzgZCUnim6Eh5kf3QFCrxTlzQiMfKs0U+Z5ta2UObABJpdgUQuf7nmzOWz0gJN7mnPKbvlhIotALnHj4sUkqzzoYntrn0eI3epo4zbzVCohLq0ki3QopW4UMns/trndbHNa4347BtK8XW1dXaM8Hrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497350; c=relaxed/simple;
	bh=JxVx5rD+qx7VxeLoCkSo1ioSw53SzFHBXio+EsVhCOM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OUBpkXUNOX6XIi6vcdQXQYSidE6xF2xGwlDThCSmSIqlyHjqMfMpy+ZUq29jjdzQy9Z2BLfva1urgIaEgw8xx3jA57Agpug1tH0ppbg9rKCu6nF9i5uA0gTmcuVfqal6TEVljjF8CB8LafSoET6j1NJQjJE6648XVmSoB9pnZi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O481lX4y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O481lX4y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F101F000E9;
	Wed,  8 Jul 2026 07:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783497341;
	bh=y7nm84BEz0ytrwYClcwNDZkMlhDaVXoewitWOQTlejw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O481lX4yZhWnYvFOtZi5y9NAqIv4Ck9pHcj22kStV3NfANj8AhGJAE+gE+Axum7ky
	 7Oiw3yZj7Ln+HjpkbDhAr9TM6+ahB0ceTspL8imkbGj/wBqLc6Ugegxzr+zto6gpvu
	 U8d19wHCNM+5ErYQkpHFHaudwLWBtmTrXP8wGzM3b48QA/p8+CQ1uPt8UX0JvbuYsC
	 yuEf0/6/hd8D/mNMHUD6QOaYEsZ1fzP94HCJTuLJCnn9NxXe1nVbgOOaJLNj5JtmVP
	 eA/dvlxFIpZOWyipb7G+shwMKKXEa6aRGeQ63vwiVUU6QQc9SbssfkshkKk4FdhBXz
	 RwQwa4V4j0V/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] cxl/memdev: Don't overwrite the error from an
 earlier partition poison query
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260708074228.43654-6-icheng@nvidia.com>
References: <20260708074228.43654-1-icheng@nvidia.com>
 <20260708074228.43654-6-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 07:55:39 +0000
Message-Id: <20260708075540.C6F101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Failure to advance the offset in Get Poison List loop causes redun=
dant mailbox queries and missing poison records.
--

--- Patch [5]: [PATCH v3 5/5] cxl/memdev: Don't overwrite the error from an=
 earlier partition poison query ---
commit d12b3a1ef61c4d80195127d0b11aa93c505ec62e
Author: Richard Cheng <icheng@nvidia.com>

cxl/memdev: Don't overwrite the error from an earlier partition poison query

This commit fixes an issue in cxl_get_poison_by_memdev() where errors from
querying poison lists for earlier partitions were overwritten by subsequent
partition successes. It adds a check to break the loop early on any error
that is not explicitly tolerated as a RAM -EFAULT.

> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 33a3d2e7b13af..8718964b9c5e8 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -231,6 +231,8 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev=
 *cxlmd)
>  		 */
>  		if (rc =3D=3D -EFAULT && cxlds->part[i].mode =3D=3D CXL_PARTMODE_RAM)
>  			rc =3D 0;
> +		if (rc)
> +			break;

[Severity: High]
This isn't a bug introduced by this patch, but I notice an issue with the
Get Poison List loop inside cxl_mem_get_poison(), which is called just above
this block.

When the device returns CXL_POISON_FLAG_MORE, the do-while loop in
drivers/cxl/core/mbox.c:cxl_mem_get_poison() does not advance pi.offset:

	pi.offset =3D cpu_to_le64(offset);
	pi.length =3D cpu_to_le64(len / CXL_POISON_LEN_MULT);

	do {
		struct cxl_mbox_cmd mbox_cmd =3D (struct cxl_mbox_cmd){
			.opcode =3D CXL_MBOX_OP_GET_POISON,
			.size_in =3D sizeof(pi),
			.payload_in =3D &pi,
			[ ... ]
		};

		rc =3D cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
		if (rc)
			break;

		[ ... ]

	} while (po->flags & CXL_POISON_FLAG_MORE);

Does this cause redundant mailbox queries using the exact same offset?

If the device has more poison records than can fit in a single response,
would this result in fetching the same records repeatedly and missing the
subsequent ones?

>  	}
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708074228.4365=
4-1-icheng@nvidia.com?part=3D5
