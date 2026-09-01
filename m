Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB7B36B91E
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 00:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223431; cv=none; b=ShTSGD2S6LflSdwY0XOSVjQ6jV2Hd7xKoqNtAJbnLR6tYYVIfdR76tcVGMUBONGi3QDzjbhkc+cpGaaWN0A42ooc8RsOv8ohlnjIrHbNrmSR6v8SiL6Hpi6mGVIyZ6VKXm6q+J5yM2sqaxfGyy0xibwL9HhhsJkPhFVu7A8HzMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223431; c=relaxed/simple;
	bh=cLs/NXO8/EQ+h+0lkk4Bwyrus8hKNfwRxBv2iv4lOvQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pElhkQVJbaJFR6UfUjAwx4Sq7+6j1SSsphbuuCNPocirRKkRkF/4aONDLlGyq8foo/IWGTl6VRRu3ycWv7xKMXHwcrd4jOj0P6jp+UTyFpchGOThtYInyqlUyY7x3qm32J+F+rjTbw1lNA7ckltfNSHBGmQ1DlcqiOl5LWGZX9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYPWI5M4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYPWI5M4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F9C1F000E9;
	Tue,  1 Sep 2026 00:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788223426;
	bh=ZrFJ5szSMl2s5w5VoANaRiqhzWerlAW5G7pH670aR30=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mYPWI5M43eluf0NIJkgTAleeiaTxbnqsD3a5MZpOepXCNbSjgptOdVJBuLVzJ6zC7
	 gujt7emev9jTXnDSqidvFL0HqPQz10DVDU13xgNhlqY15KPxmiH2VIMZ5bC4KYs2Do
	 5ZQtHCuTpYPK9NyjCehG7MuaLVAUpeGoAcW3bJdAm1A9ZHXSoRqPsUqH75AS47O2bG
	 LGIWKJ3MthUy36BTP1k42ynrEDAgIejA3F4WXzafP8lLUeMidRmZACsA8lTJPMFuV/
	 JXUOTU5hePu8UnLEqQpC8PZwKmTrFmsl/BzMUP8gSva9cc99NZUYCPPR32Muv2lSMA
	 OcShkqSteYGPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] cxl/events: Bound the per-log Get Event Records
 loop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anisa Su" <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260901002912.958-4-anisa.su@samsung.com>
References: <20260901002912.958-1-anisa.su@samsung.com>
 <20260901002912.958-4-anisa.su@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 00:43:46 +0000
Message-Id: <20260901004346.A8F9C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Returning -EIO after capping the event log passes causes an infini=
te IRQ storm rather than letting the caller give up on the log.
--

commit f19a605d6e7399b93479014db2d4bf98656f2614
Author: Anisa Su <anisa.su887@gmail.com>

cxl/events: Bound the per-log Get Event Records loop

This commit bounds the cxl_mem_get_records_log() loop to prevent a misbehav=
ing
device from permanently stalling the event thread. It introduces a 128-pass=
 cap,
returning an error if the cap is reached, and yields the CPU via cond_resch=
ed()
between passes.

> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 7c6c5b7450a54..5e49589727d59 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
[ ... ]
> @@ -1109,34 +1137,72 @@ static void cxl_mem_get_records_log(struct cxl_me=
mdev_state *mds,
>  				type, rc);
>  			break;
>  		}
> +
> +		if (++passes =3D=3D CXL_EVENT_LOG_MAX_PASSES) {
> +			dev_warn_ratelimited(dev,
> +				"Event log '%d': Still reporting records after %d passes, giving up",
> +				type, passes);
> +			rc =3D -EIO;
> +			break;
> +		}
> +		cond_resched();
>  	} while (nr_rec);

[Severity: High]
Does returning -EIO here cause an infinite interrupt storm rather than lett=
ing
the caller give up on the log?

When the 128-pass cap is reached, cxl_mem_get_records_log() returns -EIO. T=
his
propagates to cxl_event_thread(), which breaks out of its event reading loop
and returns IRQ_HANDLED.

Because the event log is not empty, the device will immediately fire another
MSI. Since the thread returned IRQ_HANDLED, the kernel's spurious interrupt
detector won't disable the interrupt line. This wakes up cxl_event_thread()
again, which performs another 128 passes and exits, repeating endlessly.

Should the interrupt be persistently disabled or the log masked when we give
up on reading it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901002912.958-=
1-anisa.su@samsung.com?part=3D3
