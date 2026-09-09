Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880383BF698
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 21:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990562; cv=none; b=IbkBXB2BqxF7WOsEYeGnsoT2lJWqk47DIA8twMwOjOiuEimqH3yjH7ewOz49ISs13A3GpzwRHXMc/9u/PdMEXDALEcO9dJW8DhJN8oBZCfk8SPx0D6Ndy+lP+WEooo0wVz4B9q30btP3NnlZpcBoKjern6gDzCU5jXYf1sfMN6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990562; c=relaxed/simple;
	bh=8yVBKXS1tMlxaq0vaCkXXCo3Lxag6RyX8fkMwkl8gj4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fObCPtG159eaTq87mXRM5zRqGUvFxPAJto/iH938wx+Xdiy5SC2KmztoPuEthVfUK9Rq6/Gy43toyZQ9Rm2E34zR9vLFx2bK7RslTk/o/hFTQnKftX9QZTDXHB6jG10FPPPXmr9hqsyZBSMVumjjiO7bVoLpgHWaaFh7Jedh/KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRga7Yc/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRga7Yc/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26621F000FF;
	Wed,  9 Sep 2026 21:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788990554;
	bh=QcHVnl49l3zhueQfVL+IylfHSkl+rzJM5aSGQVrVeTY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lRga7Yc/b/tTrXSIAmctd2AZDnIAX0E2ahYIfJlquUG2N9ACL0neyCoPHVKG6gZpB
	 eXvVCUEVss33wWwTPz6rfTtFaUbiqub9l22mYoMA+31VHXUQLGT+MISk8ZrdAr9CTt
	 A4AGQ9GKHfNtVN/vHtmHI00q4pTlNfm7cW33lTXs1b9a7Nk7JCISdvF9mgLjwBJ0Na
	 XfVLW1ojJmMVJOjztNxRLUnxAH5MixGOTnz0C7C078ZMvYObW59XVVurdd7tiECT+6
	 0x8Ny1ffalaP8yzFzq402rhneuQWzJggSHAZOmdbS1ZeUQelvjDS9VGRE0C/Q3clKe
	 K8Bx/ujkSNBYA==
Date: Wed, 9 Sep 2026 22:49:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, alison.schofield@intel.com, icheng@nvidia.com,
 ming.li@zohomail.com, benjamin.cheatham@amd.com, alucerop@amd.com,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v8 09/10] cxl/test: Add mock BI topology support
Message-ID: <20260909224909.44e9a9c2@jic23-hlaptop>
In-Reply-To: <20260909170302.1550680-10-dave@stgolabs.net>
References: <20260909170302.1550680-1-dave@stgolabs.net>
	<20260909170302.1550680-10-dave@stgolabs.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Sep 2026 10:03:01 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Extend the mock topology with an all-software Back-Invalidate path
> covering both the type3 memdevs and the type2 accelerator.
> 
> Following the framework's convention of substituting software state
> for register programming, cxl_bi_probe_capable() gains a --wrap shim
> dispatching through cxl_mock_ops, and the mock decoder setup enables
> BI in software in place of cxl_bi_setup(). The mock setup mirrors
> cxl_bi_enable_path()'s walk - dport nr_bi accounting up to the root,
> unwound by a devm action - and the capability check keeps the
> VH-only rule.
> 
> A single HDM-DB window (BI | DEVMEM | VOLATILE, targeting host
> bridge 0) is emitted in every topology mode and parses into a
> CXL_DECODER_F_BI root decoder; DEVMEM satisfies can_create_ram().
> In type2 mode it coexists with the accelerator's HDM-D window.
> 
> cxled_committed_bi() reads the BI bit from the HDM decoder
> registers, so each mock port's cxl_hdm carries a page of plain
> memory as that register block, maintained on decoder commit/reset
> and restored on saved-decoder replay - letting a committed HDM-DB
> region survive a cxl_acpi rebind. The accelerator grows to 1G of
> capacity so the boot-time auto region leaves DPA for a BI region.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Another area I'm not as confident in but seems fine.  Needs more eyes
but from me.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
