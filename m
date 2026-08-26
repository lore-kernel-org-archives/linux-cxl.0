Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437F38472
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 01:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787709414; cv=none; b=UD3lxgEydyENdTmPDf8o/h4T3QZ4lch2a3omw3AaObrpFUAj2O2f+oYv/UX+hSiN5PAYoDI4X0NPEG7am7wR69SPZHgasmlcsAO8LemzaWY6Oys4oqEi6Jv/iCtLH8cEjQp6KeTaI5gOk8SjMESHNlycgZreeVAmFQcSWtY4nqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787709414; c=relaxed/simple;
	bh=V6A2n8FdbS6N2tttSfVA+yZLsYz4J8A7KXLmGAd12/0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y4gtsZ/1g2RVneSg02sa0v8mqz96KiYO7Zl8or0THvLl/2iackls49SaqPN9VRvvbaGKrNbU/uSqLtq6z5NvENZtvtWwQIVbjDNDbZP3LWfFnaKgvqaTySFyyBhc8tKCaeaVrQ8gRSF2b8XmPXZALPviZqu7dxQ4HGNsPs8Bwh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E31fkjbY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E31fkjbY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64601F000E9;
	Wed, 26 Aug 2026 01:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787709412;
	bh=xcnw8lbILrJTR8IBwwDWShS5tvovmbg68nJ0jhJEgSc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E31fkjbYwq082CcKS4vuMCSCh6/gnmV10Ltl0HGUqi3la+5pkayDKTnL/cOb33CU6
	 X1wFxWKxoqRQpTrDt+bsb9j4VRCPLS0UNgdLWosYmfBxpgUCPjFVBgk13NqHhiB9xp
	 q8RE4y9hQQG8x/hgWr8k6xQpTmxNdg1TZdhHQrYMa1Smslf2jni8dQK78e8SmKM7M7
	 6nt5ku4VIc3qQTJFsSJlpMcVHs4kaOx+bCh5PR5R5Y+UbCfZuTrjpLOkXET8v6fqpT
	 5vErtwVKI2dYmBGqJCalYA7eR39OxMl6fsad/fyR6Dg1uXOQ6/C/C2CB6qLiEuE8Qn
	 64Tm+9KiG4wKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/7] cxl/memdev: Don't overwrite the error from an
 earlier partition poison query
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260826014508.9989-6-icheng@nvidia.com>
References: <20260826014508.9989-1-icheng@nvidia.com>
 <20260826014508.9989-6-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 01:56:52 +0000
Message-Id: <20260826015652.A64601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unvalidated `po->count` from hardware payload causes an out-of-bou=
nds memory read that gets exposed to userspace via the `cxl_poison` tracepo=
int.
--

commit b8896ead9022e537cefc70198cd640048454c1cf
Author: Richard Cheng <icheng@nvidia.com>

cxl/memdev: Don't overwrite the error from an earlier partition poison query

cxl_get_poison_by_memdev() queries Get Poison List per partition but
never checks the result inside the loop, so a later partition's success
overwrites an earlier partition's failure and the whole scan reports
success while that partition's poison went unlisted. Before the loop
conversion the PMEM query returned early on error. Stop the loop on any
error not already tolerated as a RAM -EFAULT.

> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index b3419df586b9c..e39b3d13fd566 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -231,6 +231,8 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev=
 *cxlmd)
>  		 */
>  		if (rc =3D=3D -EFAULT && cxlds->part[i].mode =3D=3D CXL_PARTMODE_RAM)
>  			rc =3D 0;
> +		if (rc)
> +			break;
>  	}
>  	return rc;
>  }

[Severity: High]
This is a pre-existing issue, but I noticed a potential out-of-bounds read
triggered when cxl_get_poison_by_memdev() calls cxl_mem_get_poison() earlier
in this loop.

Looking at cxl_mem_get_poison() in drivers/cxl/core/mbox.c:

drivers/cxl/core/mbox.c:cxl_mem_get_poison() {
    ...
		rc =3D cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
		if (rc)
			break;

		if (!le16_to_cpu(po->count)) {
			dev_dbg(&cxlmd->dev, "Poison empty payload!\n");
			break;
		}

		for (int i =3D 0; i < le16_to_cpu(po->count); i++)
			trace_cxl_poison(cxlmd, cxlr, &po->record[i],
					 po->flags, po->overflow_ts,
					 CXL_POISON_TRACE_LIST);
    ...
}

Does this code trust the unvalidated po->count value from the hardware
payload?

If a device returns an artificially large po->count (up to 65535), the loop
appears to read beyond the bounds of the mds->poison.list_out buffer and ex=
pose
adjacent kernel memory to userspace via the cxl_poison tracepoint.

Could we bound po->count to mbox_cmd.size_out or the buffer capacity
to prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826014508.9989=
-1-icheng@nvidia.com?part=3D5
