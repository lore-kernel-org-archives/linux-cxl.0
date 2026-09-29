Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C5C3515DE
	for <linux-cxl@vger.kernel.org>; Tue, 29 Sep 2026 06:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790662548; cv=none; b=Y3oDuSz13LRlLfuCSqyRV1mWJ1hPbwOSbuGNiN41HBAT2094+gDutwNic9KEMTlwy6D5ZJegTdQtGurvOpqPfzyBkPvQz3fML3K1sIB97Q5sRBwI6KX2ZsCDwk3lwMNP5q9bX2vqqoyZI36T++yBmJ++44C3pLJzmrAGoIqam00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790662548; c=relaxed/simple;
	bh=y83iVJbYBuNpJrk9ZXRTAO7ONK13iH+NBXkW6CgCoWo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j//hO0nIxE4zGyId8ubDjvjgqYFxBmAHzWpHhuCDEbTb9DAUVOOyS7ygiE50so4cG7aRPjmGS9+H/7ORysj9lLoj7/sxmbsv2MCa+qZHTSI0PykXeWh7s6P7sN9M7scf6t8EGlCm0frsKTG7qwtZOHjif17+9UvSnT6St2ygk9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMacATeh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMacATeh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4419C1F000FF;
	Tue, 29 Sep 2026 06:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790662546;
	bh=vp7WHQK9GL7BEpeEsdpYl9GBk91uY9pKhDOsWpHFnYo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KMacATehCAUrebJzlV31uFcJIsIsRDuiYTTQWP+HimgUqqMPmWrcygDlFO4yDkvCt
	 6pSzt7F+pAFAKYE/F2Kk3c2ofPaX3ruJTLyZO30CbsFMYjgFzcnwk7LO9FzOc2EJ5D
	 pBs+REEZssVhMzOxk7nmM797N6YCvYlaXi6MEVone9THs+FAFR7/IaCO0ZYjE+hxhW
	 xtBg46R5NeqgULPJbiBHa2hTt7i/iNoPf010ahfm5hl6NZflMz/pba1RzX2p5/2WBI
	 o/zmQZGOPpJ3YnLL7g4741wFqmjErTI5JTyQ3X4vZ1q3ftn4d9jyDK0n03ROt8FzRJ
	 PAQaml2UykhZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/mbox: bound the device-supplied command return code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gaobin Huang" <huanggaobin23@semi.ac.cn>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260929060747.3550005-1-huanggaobin23@semi.ac.cn>
References: <20260929060747.3550005-1-huanggaobin23@semi.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:15:45 +0000
Message-Id: <20260929061546.4419C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] cxl: incorrect comment about return code mappings
--

commit 2dcefe093dad494dcbd18a284c00e32e26f8041e
Author: Gaobin Huang <huanggaobin23@semi.ac.cn>

cxl/mbox: bound the device-supplied command return code

Validates the device-supplied command return code from the mailbox status
register before indexing the command return code table. This prevents an
out-of-bounds read if a device reports an undefined code.

> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index c401e3a1af06f..7f89dc4fcf050 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h

[ ... ]

>  static inline int cxl_mbox_cmd_rc2errno(struct cxl_mbox_cmd *mbox_cmd)
>  {
> -	return cxl_mbox_cmd_rctable[mbox_cmd->return_code].err;
> +	const struct cxl_mbox_cmd_rc *rc =3D cxl_mbox_cmd_rc_entry(mbox_cmd);
> +
> +	/*
> +	 * Unknown codes are still failures, and -ENXIO is what every
> +	 * non-success entry in the table maps to, so the caller cannot tell
> +	 * an undefined code from a defined error in a way that matters.
> +	 */

[Severity: Low]
This isn't a bug, but in cxl_mbox_cmd_rc2errno(), is this comment accurate
regarding the table mappings?

While most non-success entries map to -ENXIO, PADDR maps to -EFAULT and
POISONLMT maps to -EBUSY. The fallback to -ENXIO is safe, but the comment
and the commit message claim that every non-success entry maps to -ENXIO,
which could be confusing.

> +	return rc ? rc->err : -ENXIO;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929060747.3550=
005-1-huanggaobin23@semi.ac.cn?part=3D1
