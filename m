Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88E01E5714
	for <linux-cxl@vger.kernel.org>; Mon, 13 Jul 2026 20:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783976302; cv=none; b=KY8aG+xuTt24Z7Q0rfvdKrKg1gP2rzB1kXo2RA7lp5qvPnCXKYsP+pstlHIIRKy19Az7NQ9WT5jofoAheblYfc+g+WFJ4sSUQvNeaxahhwsaue2y/dlsdQ3Qj3b65Cd87UoQTej+xik00SwLRCVTIxpy+U5B8x+E7w98bmmJxS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783976302; c=relaxed/simple;
	bh=l67iy+DIKW3KA//RrLAhD9hbcyjFrO8kGD0OyguxkAw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eGRXsxTyCXu/VNSktvfRtZDWfLIOcGOdSNveKxit2Jj9n0tA+i9+Tt+rGuJoX9l6awnskWUr3HSUZFFGJzJM8Pu4CdGONil/dhzpKFWhz+P9TdXQUXUdFwJsW80YpI1NTI8GJcZZqC639pWfTDIwZ8T4CGdQ8hOY0Y3yDhIEWfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sy9mmTJO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sy9mmTJO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736541F000E9;
	Mon, 13 Jul 2026 20:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783976301;
	bh=0Dk0F9jahzpZ2fzDT/k+yOcw6MA1snzMy+n7QWRk/KE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sy9mmTJOAbOpXRX8RlFpHgblABBD6eC2ua9YWaDtRJgAt4uQ7hgTzpci1TNiZn1Tw
	 d7X3fKKGB7hluHEdl9pHpcT4Ow7wzxrH4BglpdzxBLvm53Azv1JXWhAClfbzdvKzJD
	 gxeFimX6nI9owcxTMPdixYnZ0gotXo1laK0L55xzDj/Uk0JkZWr7n/9FZ9Y10VTIX1
	 S0DOQ5n0/QujmkzkbQsBjh2bUhIh+5MyM2FPsEnBktT0/k59EOtHhzOMD/7xFvYvtu
	 WO4tzHfnmpGdrvLAPT5Sgxa01iBakO+7thqwBDrAwESdSACT57zuyl4HsZ6pvGE7gi
	 9dkQnH98PyOXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] cxl/hdm: Restore commit_end when decoder
 enumeration fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <dd46f240738e3eb2663b23ed79fd9544ff5dccfa.1783974681.git.alison.schofield@intel.com>
References: <cover.1783974681.git.alison.schofield@intel.com>
 <dd46f240738e3eb2663b23ed79fd9544ff5dccfa.1783974681.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 20:58:20 +0000
Message-Id: <20260713205821.736541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Transient reset of `port->commit_end` allows concurrent bypass of =
safety checks in `cxl_mem_sanitize`, potentially destroying active memory.
--

--- Patch [3]: [PATCH 3/3] cxl/hdm: Restore commit_end when decoder enumera=
tion fails ---
commit 0d7f87c9ca0ba7b9bbdd31e5ea90994445b1c9b5
Author: Alison Schofield <alison.schofield@intel.com>

cxl/hdm: Restore commit_end when decoder enumeration fails

This commit resets port->commit_end to -1 before enumerating decoders so
the commit state is rebuilt from the decoders actually committed on each
probe. This prevents previous enumeration failures from causing subsequent
probes to fail.

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 75d17120233da..0145d3db31070 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -1178,6 +1178,10 @@ static int devm_cxl_enumerate_decoders(struct cxl_=
hdm *cxlhdm,
> =20
>  	cxl_settle_decoders(cxlhdm);
> =20
> +	/* Reset to the none committed baseline for a fresh enumeration */
> +	scoped_guard(rwsem_write, &cxl_rwsem.region)
> +		port->commit_end =3D -1;

[Severity: High]
Does this scoped_guard drop the lock too early?

Because scoped_guard only holds the lock for the following single statement,
the rwsem_write lock is released immediately after setting port->commit_end
to -1. This leaves the transient -1 state exposed to readers without protec=
tion
while the loop below performs the hardware enumeration.

Could a concurrent reader like cxl_mem_sanitize() acquire the read lock
during this window, observe a temporarily empty committed decoder count
(since cxl_num_decoders_committed() evaluates the exposed -1), and=20
erroneously bypass its safety checks to securely erase actively mapped memo=
ry?

> +
>  	for (i =3D 0; i < cxlhdm->decoder_count; i++) {
>  		int rc, target_count =3D cxlhdm->target_count;
>  		struct cxl_decoder *cxld;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783974681.gi=
t.alison.schofield@intel.com?part=3D3
