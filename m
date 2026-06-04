Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A028364EA4
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jun 2026 10:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568443; cv=none; b=g5iOikmGwQi7KSpCzv3/Y2Q4xBnpTlyGByJ+Ds3ROwDerajxoUJtpnbCvs1pA2Eq3LiA2xDf6ZJtle471Nfam73AJe2m0TrNffO43JJF3r+TFy/AjlfdmkFzW8VkVbXppt+QfTMmN05b/h4wAhjVIK10pFOVQSjiNpa9rGzyuXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568443; c=relaxed/simple;
	bh=sU/p62WNhcrFsz/wU6hSTPWO3PLa9j9ArZIohIvNQLU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JI/tz0db6q4FAInFzB0F5brKJij8Zt+xkOCGC4O/1Taz0Dhwkyd4QISd4OygOYw94gdEwJ6hFyz2Wh90+CgomOFPDh8v67wUeAeE4BrwLrsKNiYdgmnMztz5yikdI1CP3w5A+IkfQNC96vVSv+VESV3/vzsg/HbFRXxI9jL7tvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ds1zq22u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ds1zq22u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30EA31F00893;
	Thu,  4 Jun 2026 10:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780568442;
	bh=t32UCcdqzr85sSwnUwG9VfbZyyVpZARBWfAm1PwHlpU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ds1zq22uddwxA6eU1OayKfdHhp7IB2AQCbsMRREymJWDw1X9TcZEX6J0EOSTc8g7I
	 ETdITDVYP9sFJs1KgpzoVXxtm/B0CxvMoZkr1hRWrGOm/H302LrOQRluBniS9wpc7K
	 3YFnejchP2/O2eYE+U8Rd91hs+0UWpig7ZZ3LFt29VERonOIDvI2LDJhHuOz1wx/xK
	 6LVxKVIlSU0GorCR9cOYzdQqzvc6hOlJlGMbAzVNUCtR11/60J4FbZSqFhnXv9xt+7
	 89e0ozeIDOEeq7gsO+8OC8JNDS16CblspU+bvWFSIK+SaRSfoX6iZ7jnotr8KFEm3J
	 xGHlct1mcqfww==
Date: Thu, 4 Jun 2026 11:20:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/4] hw/cxl: Use host-only coherency for default CFMW
 restrictions
Message-ID: <20260604112035.4a0ba93d@jic23-huawei>
In-Reply-To: <20260602231806.2469011-3-dave@stgolabs.net>
References: <20260602231806.2469011-1-dave@stgolabs.net>
	<20260602231806.2469011-3-dave@stgolabs.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Jun 2026 16:18:04 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Change the default CXL Fixed Memory Window restrictions from 0x2f to
> 0xe, dropping Device Coherent and Back-Invalidate.
> 
> host-only coherent combined with Back-Invalidate is undefined behavior.

That one I'm fine with.

> Device Coherent alongside host-only coherent is permitted by the spec
> (multiple restriction bits may be set) but advertises conflicting
> coherency modes; neither belongs in the host-only default.

Why not in the default?  Software should be fine with it and it
means the default emulation is slightly more likely to function for
simple cases.  I don't feel that strongly about it given we don't
have an device coherent devices emulated in QEMU, but wanted to understand
your reasoning a little more.

Jonathan

> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  hw/acpi/cxl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
> index f92f7fa3d558..5ce5e8e083ba 100644
> --- a/hw/acpi/cxl.c
> +++ b/hw/acpi/cxl.c
> @@ -172,7 +172,7 @@ static void cedt_build_cfmws(CXLFixedWindow *fw, Aml *cedt)
>      build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
>  
>      /* Window Restrictions */
> -    build_append_int_noprefix(table_data, 0x2f, 2);
> +    build_append_int_noprefix(table_data, 0xe, 2);
>  
>      /* QTG ID */
>      build_append_int_noprefix(table_data, 0, 2);

