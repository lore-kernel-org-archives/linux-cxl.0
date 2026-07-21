Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE75E10F1
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 01:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595806; cv=none; b=PbLafm7MYZgswQTWHzi27cmMuuj+qECvVUF1zAuxrk+HAch5Xhv++w3T6U2JzeD40XjAZNs7vKoRFDOyhsErTwdzRdZX8yE6SLxqx7ZuzJiUy1D5nP1/96LCU956iAcjlH9RNRy5ApdK98WVkdrPQujFVHZF+MzuSCGEFMPkGOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595806; c=relaxed/simple;
	bh=68ICQaTYGNY0S7jaDpEzqRmTS602zrUnaPA1JjGGcXA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QFX6umLqbGMk6cNJMGi7RkcS6D3+nN1FWFixwmx0ozcBOF/3aJh51B0xlGmJestOXEsQ/tUu6MKO6tM9DEOboV8dZ/a8Ur+doXXniDLW7Zl7NJIZry64vsHQmYaIRsOLqWY3CXLf01aP8G+XMBMmn54AlcACevjIStbH5CsOxwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cF8+kISX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cF8+kISX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A361F000E9;
	Tue, 21 Jul 2026 01:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784595804;
	bh=/FnRMWymWQwCjna3n73N0UF7ENHmWL4PVz9Vqok9cHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cF8+kISXOpw3Ni3rT/FJ0A3X2lJbG34catzjacQ9bOcImELNZNs8ULOWzYFxiCHN2
	 k7mtp1rw6x7vzQVkPhzCU8pdH2Pbo8I31f+fA3TZ5DQNXdddVczRD/NfuO+w6u8HWN
	 YLYE6bheZIyM8etBlJGCXaIlQuT6wzWFOeOGsnT5ZAfmEnYYUeK2nLLtM6/O6cUaxd
	 O8yWJWOUTckbELbCpc3jLi30KnFJYih4aYi+OOkuGA3ZUrJx999v9BILiY8Kmi0YsN
	 6y/V8HGUUrjuL1Ogj6OJGMzFFt/3TIpMz/ZfNyrqdZBn2vUnV2lVK4wzKo8OiH7Q93
	 JaSIRLuCAN+mg==
Date: Tue, 21 Jul 2026 02:03:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Junjie Cao <junjie.cao@intel.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, qemu-stable@nongnu.org
Subject: Re: [PATCH 1/6] hw/cxl: fix timer leak in cxl_destroy_cci()
Message-ID: <20260721020320.4545bd3a@jic23-huawei>
In-Reply-To: <20260626062149.1844334-2-junjie.cao@intel.com>
References: <20260626062149.1844334-1-junjie.cao@intel.com>
	<20260626062149.1844334-2-junjie.cao@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jun 2026 14:21:44 +0800
Junjie Cao <junjie.cao@intel.com> wrote:

> cxl_init_cci() allocates a QEMUTimer via timer_new_ms() but
> cxl_destroy_cci() never frees it.  This leaks a timer object on every
> device exit path and, more critically, on every device reset cycle since
> the secondary CCIs (vdm_fm_owned_ld_mctp_cci, ld0_cci) are destroyed
> and re-initialized each time ct3d_reset() runs.
> 
> Free the timer with timer_free(), which cancels any pending expiry via
> timer_del() internally and tolerates a NULL pointer, then clear the
> field so that a repeated timer_free() on the same CCI is a safe no-op.
> (The function as a whole is not idempotent: it also calls
> qemu_mutex_destroy(), which asserts on an already-destroyed mutex.
> Callers must not invoke cxl_destroy_cci() twice; the .initialized guard
> added in the next patch enforces that.)
> 
> Fixes: 98cbac128f1c ("hw/cxl: Support aborting background commands")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Hi. Sorry for delay on catching up with these.

One minor thing inline - otherwise looks good to me.

Jonathan

> ---
>  hw/cxl/cxl-mailbox-utils.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 20e0b7e476..18a455e89c 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -4770,6 +4770,8 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
>  
>  void cxl_destroy_cci(CXLCCI *cci)
>  {
> +    timer_free(cci->bg.timer);
> +    cci->bg.timer = NULL;
Can we do this in reverse of the cxl_init_cci() ordering?   That would
put these after the qemu_mutex_destroy()

>      qemu_mutex_destroy(&cci->bg.lock);
>      cci->initialized = false;
>  }

