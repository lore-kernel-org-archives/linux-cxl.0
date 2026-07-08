Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351B63BB9F5
	for <linux-cxl@vger.kernel.org>; Wed,  8 Jul 2026 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783508069; cv=none; b=bw+N17NXDBEvcdGsgzfaxeUmFg04nZf+TpyJeNF1GeCVlj/dugJxiy8hPtlt/YPxAeQ0ZNkYvvJYBD1Uxc75aY2COBexd8M3lynd5NqlxG085DoG6pDSF12f6vwbTreGTE6PtiGTrkCsEP/buNw/+w2oJOxaO1qoqjJkayhVFQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783508069; c=relaxed/simple;
	bh=SIWIDXrJuaOht3UdD22gvMCWOJOZidDuE+Zv01s2oto=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Op7s1qY4L7BPHj4xzBbieltrCX6GUfP1PdXldblvXWA66tao8r05V3FwXkQBajMrE4o8Qw/Csh7IiwV7I4DWyY3yxP+ElzogVvDmpO3gYkC0CVB4vdMtUSMPSvHG80O1jm4fRniK/47Nq9IjZTPFIUAuySrjxNcgQb0XQjMLcE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZKq/R7l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZKq/R7l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7081F000E9;
	Wed,  8 Jul 2026 10:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783508059;
	bh=4DUe44+PPGzr4k1EXjhV48OhuSElNGvw0rh0v+uLoYs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gZKq/R7lYkMo9Axb1l1hlcCzF9SBKKBN9/N2qVQgC+Mc/mbk5xjVAj3tiAuekMb29
	 iYktOfg8K1NxIiGQlonlZqjAwZIJoCAPb2wGxgQ3C2eNlz2fNDqPtQ5SQqS9ooHA5a
	 YvcY/Xbb0kSar21z3nkG8wXX/nd0aOguI5XHHkRaWJzx0Mw2LxGFO1Jzxbq9SFSKf9
	 NbO3g/yQxcGM1f3px7fv1g59LtLxWqxyAGroUjxFSayuUYOr3olW3ZZSHokVijim22
	 3EoaGWLDFJWu0h3z7np8LB3MhOeuGQNafwKOz/j/izgtM5m7xtLvb6hwbAfq+HRmRB
	 Nd3WsZ01d8MOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/2] cxl/hdm: Allow zero sized HDM decoders
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260708104024.68029-2-icheng@nvidia.com>
References: <20260708104024.68029-1-icheng@nvidia.com>
 <20260708104024.68029-2-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 10:54:18 +0000
Message-Id: <20260708105418.DB7081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] cxl_dpa_free() early-exits for zero-size DPA reservations, permane=
ntly breaking the LIFO teardown constraint and runtime reconfiguration.
--

--- Patch [1]: [PATCH v7 1/2] cxl/hdm: Allow zero sized HDM decoders ---
commit 6f85fee709a80e6ce5f72e57edb7b3f3de0aa965
Author: Richard Cheng <icheng@nvidia.com>
cxl/hdm: Allow zero sized HDM decoders

This commit treats empty CXL HDM decoders as first-class entities by backing
them with a zero-sized kmalloc'd resource. This allows the OS to correctly
enumerate ports on systems where the BIOS commits zero-sized decoders.

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b4..ccbab2e21f060 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c

[ ... ]

> @@ -545,7 +569,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>  	struct device *dev =3D &cxled->cxld.dev;
> =20
>  	guard(rwsem_write)(&cxl_rwsem.dpa);
> -	if (!cxled->dpa_res)
> +	if (cxled_empty(cxled))
>  		return 0;

[Severity: High]
Does this early return prevent zero-sized reservations from being correctly
released?

In __cxl_dpa_reserve(), a zero-sized decoder is backed by a dummy resource,
assigned to cxled->dpa_res, and port->hdm_end is incremented. However,
because cxled_empty() returns true when resource_size() is 0, cxl_dpa_free()
will return 0 here and skip the call to devm_cxl_dpa_release().

This appears to leave the dummy resource allocated and port->hdm_end strand=
ed.
Since port->hdm_end is never decremented, will this permanently break the L=
IFO
teardown constraint for any subsequent attempts to free preceding decoders =
on
the port?

>  	if (cxled->cxld.region) {
>  		dev_dbg(dev, "decoder assigned to: %s\n",

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708104024.6802=
9-1-icheng@nvidia.com?part=3D1
