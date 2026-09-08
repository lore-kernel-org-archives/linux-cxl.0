Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80788374A1B
	for <linux-cxl@vger.kernel.org>; Tue,  8 Sep 2026 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788864209; cv=none; b=HGNSuxF651e1EmJIgYwi9ztrP/j0Cdhc4JIdtc3Pm8ioLC0qCfBFpMZMBps6b2OTIhjxtLWiaDCqGLi/NV+ByRMyML2KMVEtWexKdVfB9PIzNEueC+JhzjldqB4mqgby7KOicI+BC697AHBNY7IyJT8I4c979p2Q0xgv6oqocjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788864209; c=relaxed/simple;
	bh=19tozevnApEj18vostr/MlD48q7hpet1HgD0Szb6Ocg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nnCXZDJmp+Wx/fBnfg6fcgvCjouCOaMIr6+DwXdZdgMnDLT/cSanQTYZWPpWDL3SXmRbMgg+kzS+6sw38nQj8Bf+Cwjg2gM9RQBF9TnNytC8tbojby3O64eD79pcvVwLt55cL9ovxcY0vVzYnlnOGRrNTsgMsMg4LIF+pPaUvyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSq8Gi1s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSq8Gi1s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5E61F00A3A;
	Tue,  8 Sep 2026 10:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788864208;
	bh=SzXKdZ+6X+TPUPiVhyHFV2mnE5NG+ARUaFTp192aX2c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NSq8Gi1snsiaNTIn+HTObaA4FWTdqTcXRbC1RM3X6VQ2ATyKx4bV/4qSu9ARXn4pB
	 3Crcl15QSAIjb8IZAwviF2HD1iwo57zMGenipOLIwMU+quLfSy1fMJqKUJdNCHbUIY
	 MSgO3+hWhwd5Mf8P/oaPgu86D1PvmZQx8ZIYLgk9QiNgUACnjSrMwqacxv1DW+ZE2O
	 7gIKywLIWaFSTuoWUwoSyu/yLei1r19ym+XHGYLqwmC43tFs9wYdZT1h02u6jAqkg4
	 yP+SPjJkDtzD9al7MwpfVjpHIQIiFvDlIQXwX/lze7wqqixDjKpuqVhNym6SXt/hHa
	 9CkckRFtm56aA==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v13 6/8] cxl/mem: Configure dynamic capacity
 interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anisa Su" <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260908102124.2231730-8-anisa.su@samsung.com>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-8-anisa.su@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 10:43:27 +0000
Message-Id: <20260908104327.DF5E61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If a CXL device is surprise-removed or a fatal PCIe error occurs, =
`cxl_event_thread` enters an infinite loop, pegging the CPU at 100% and dea=
dlocking device removal.
--

commit f11145933c61ad9c3ba90b62e3f38dc571f856c5
Author: Ira Weiny <iweiny@kernel.org>

cxl/mem: Configure dynamic capacity interrupts

This commit configures Dynamic Capacity Device (DCD) event log interrupts
on devices supporting dynamic capacity. It disables DCD if interrupts are
not supported, and carefully preserves firmware-first interrupt policies
if selected by the BIOS.

> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 7b754af2168d0..1ea505b1f40e8 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
[ ... ]
> @@ -523,8 +535,8 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
>  		 * ignore the reserved upper 32 bits
>  		 */
>  		status =3D readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> -		/* Ignore logs unknown to the driver */
> -		status &=3D CXLDEV_EVENT_STATUS_ALL;
> +		/* Ignore logs unknown to the driver or owned by BIOS */
> +		status &=3D mask;
>  		if (!status)
>  			break;
>  		cxl_mem_get_event_records(mds, status);
>  		cond_resched();
>  	} while (status);

[Severity: High]
This is a pre-existing issue, but does this loop lack a check for PCIe
surprise removal where MMIO reads return all 1s (~0)?

If a CXL device is surprise-removed or a fatal PCIe error occurs, readl()
will return 0xFFFFFFFF. When this is bitwise ANDed with mask, it leaves a
non-zero value, causing the loop to continue.=20

Since cxl_mem_get_event_records() will also read ~0 (e.g., when checking
cxl_doorbell_busy()) and return immediately without changing hardware
state, won't this loop spin indefinitely, pegging the CPU at 100% and
deadlocking device removal when free_irq() waits for this thread to exit?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908102124.2231=
730-2-anisa.su@samsung.com?part=3D6
