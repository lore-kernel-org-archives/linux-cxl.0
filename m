Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2130733BBD9
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 00:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223134; cv=none; b=uYYZbIGkkqsqQ/doXe4DtBevCAhB5Ng7fKzvriMoyOhYZp5Dpzm1N1bJ9EZ9DN/tD7MY/+PtUUSBpnaw0YlzaYs1darZlmrKTR9pPKj0bM+IgUKZfTSzNYywn2/TpmIjjFpwm16Pq1u2HvA81lpQ4x6zOYd6tMSxCGBI7NQ4vLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223134; c=relaxed/simple;
	bh=BZT1TQdxQT18TZCsoBPkUJLhrGbgwkZLVtgSjkcw1k8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UPWPbefGgowQve81kTE3pn5GvgcQMpn+dvMDOXSKtk0ITEOfegkUMgO34486b8UVHNZKtzafSH/JQtHLXF8DhOIPJwFVqQ/zOp/JbwLwswoScPSsyeeaqo06zraveFPmAnSk38Ov17OwDuhkJ6ao0VnqC3jaNf/ysi5LPPZQEwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFK54/6C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFK54/6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2DD1F00A3D;
	Tue,  1 Sep 2026 00:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788223132;
	bh=A0jJPCbucx2KvVYGUNaTOxLmy4/LuWLajsYjWrtB0qw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CFK54/6CzzCZZoq/kNntBoUEu2NkRfmkfktZygH1xtizNhzhvqPw5dKt4nbvbg48f
	 2PAXPUMfLz5uhDN7vTM3Zf2dqERTfNObSab/0l48ETbSa1EdedpQWI5eY/qCrZik3N
	 NMV6m7VL8xed/b2vOIpYsUzkgSLNbirhUfXyxSQhdon2FIDZDDVsq/P8btgMOTksSZ
	 3TMmf8OaiXq9cnB7eaDfm0hHLfaeWKpnQu6zRG6p3hDvYiRLF9pjZZzoCy8oCvyitn
	 AuUIYxCmtfflan3WytFPGEs/kC1ZvCQIEBFw/qbQE+Ir48rwa4rhlwqbHDsSEnXk1A
	 PR97qpczm5clA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] cxl/events: Return IRQ_NONE when no events were
 processed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anisa Su" <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260901002912.958-5-anisa.su@samsung.com>
References: <20260901002912.958-1-anisa.su@samsung.com>
 <20260901002912.958-5-anisa.su@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 00:38:52 +0000
Message-Id: <20260901003852.6D2DD1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Concurrent execution of the shared IRQ thread for different CXL ev=
ent vectors will incorrectly return IRQ_NONE, causing the kernel to permane=
ntly disable the IRQ.
--

commit e4fb9fa2ad67f892cc6a1e121480e607bbf7ed82
Author: Anisa Su <anisa.su887@gmail.com>

cxl/events: Return IRQ_NONE when no events were processed

This commit changes cxl_event_thread() to return IRQ_NONE when no events
are processed, rather than always returning IRQ_HANDLED. The stated intent
is to allow the kernel to detect devices flooding their MSI vectors.

> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 239df18c9c87b..94ff2b7d1f09a 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -528,6 +528,7 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
>  	struct cxl_memdev_state *mds =3D to_cxl_memdev_state(cxlds);
>  	u32 mask =3D CXLDEV_EVENT_STATUS_ALL;
>  	int attempts =3D CXL_EVENT_DRAIN_ATTEMPTS;
> +	bool handled =3D false;
> =20
>  	while (mask) {
>  		u32 status, drained, stuck;
[ ... ]
> @@ -542,6 +543,7 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
>  		status &=3D mask;
>  		if (!status)
>  			break;
> +		handled =3D true;
> =20
>  		rc =3D cxl_mem_get_event_records(mds, status, &drained);
>  		if (rc) {
[ ... ]
> @@ -579,7 +581,7 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
>  		cond_resched();
>  	}
> =20
> -	return IRQ_HANDLED;
> +	return handled ? IRQ_HANDLED : IRQ_NONE;
>  }

[Severity: High]
Will this cause concurrent event interrupts on multi-vector devices to be
permanently disabled?

If a CXL device maps different event logs to different MSI vectors (for
example, Info to vector 1 and Warn to vector 2), and both events occur in
quick succession, the first handler thread will drain both logs because
mask is initialized to CXLDEV_EVENT_STATUS_ALL.

When the second handler thread wakes up, it will read a status of 0, break
the loop without setting handled to true, and return IRQ_NONE.

Could this trigger the kernel's spurious interrupt detector during normal
operation under load, causing it to permanently disable the IRQ and break
hardware event reporting?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901002912.958-=
1-anisa.su@samsung.com?part=3D4
