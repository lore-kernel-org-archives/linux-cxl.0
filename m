Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6D8283FE3
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768259313; cv=none; b=r1EJ3H3G/Kh00oH1Z8AmqGUG7mb7WIe2b5yAgEkfImKQF4FXqqxaDhOiXKUvm29AW7+YqYQ6LN6ucTNfHIS2Oq72KAJP06OEtyAR4VYDPYVd/4UQIH/DwBCLQeh/MKJ9/v/CM7aYmqoPpaeR59gVxqSAQI9btkfe6B4KRkFsYMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768259313; c=relaxed/simple;
	bh=E1uWqE0I0piZ8iWS+np5pHiZdSplMSLCxJDU4lgZ/o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z78jGb2vIn2J1fDBPRY91QeCm8bgthoGWGhx6Wa389RPNmh5qTCk6+I4sKRW93SOfMt8jY7MhUx21ISA15jOeJl72SWJqxV3aB7uoiGQjnx0Trg5QcHkO2yQf2WLce4ixM2PbCemNddN429S2MLmcsm636LIXwi63gwCgJx2rjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qiyROcwK; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qiyROcwK"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4eda26a04bfso84242481cf.2
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 15:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768259311; x=1768864111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K7pBY3tdoCPsY/Y8lsMhx2ZTdVpn7tnk/qSfrKh2Sf8=;
        b=qiyROcwK6ibPNvPcOlO3IxZ2nDKp8IYZNKOUILSEnOxis+6xwIZXdTjjj2AMxA33Gr
         W6w5+JnqRCF567GLtdaEDKLmm5mpIH7lcN0t5D1Nf07TFMPAK1NQckpqUo1ak3LfnSle
         wjOIZwONHl3dHNxtZd7Xkmgcgs7FS2W7B/ElGpnOzIxFvVoGpGTScuJ90R7thcvv9JSS
         oE9Ok42FxgSgBWjx/Cu/rDH7BFVwQ2QlCpPOPwOQp+L9pqSuSkjDyxaz8RKohAJd//wk
         Cj+vZWKWANbsUzgg1PA0NB4/nazUajbZ/NV9ltnpj7qmjce5wj+fmhWQt+XvxcwPhhfe
         OaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768259311; x=1768864111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7pBY3tdoCPsY/Y8lsMhx2ZTdVpn7tnk/qSfrKh2Sf8=;
        b=Sw8lUZIu/2gv+vxqFTUep3NBv4VE/MZQ+u5MvsxQGc0DI/Ved3iHdRO409yKRsH4GO
         qzxfLUSdJWivhFEzE880uyE8H2+z3CU9Z41drN8Vc/ZfusyZEWJq0UGZ1CY+U1TtSDnG
         FWlxS/qfWbl0U3wmcG5CKrCZ+fSLVDs3zTjN2MA1xhLQRsJ7eCoJeqODKrJyV2e/2VrE
         jP/AexGhS31C5U4yJgvrsg31zRHQNbSsLeeaCRLapmCZziNuY0lchmX2VeTvcvc143Q3
         9lwiZQIGY0A/sGv6c3MjdTjTJJT9JoQUC8qf8y6buDIG9oFBk54Ozoq3wwZPVpuBhr6R
         KS3A==
X-Gm-Message-State: AOJu0YzeFwCy2naynVCjVs10JQyw6jDXAuJtWnLv071ByDi87ezcmAz8
	ZDmNAONQmASwk1Eu+elupMPC3mMprTShS5w/A8Zbs3FfCoAO3I7uNkZdoX5P54UWI+JVTsAhCJQ
	dnlDA
X-Gm-Gg: AY/fxX6Bt1MQ2CN8QYcftsCkszXhXbbzmk3pSCsEj1McaRVkkCizw+jKIjLc8Tldyv6
	7NzNjVTw0nIRT3r8B3xvsXFHqQt6zUZESezRHZcXTZjZuarF/bq7r4wcLL1kHLU0Xj+ecLfFK1O
	x/s30CY9ttjJA5wkk4a4YMk7MCDLPkIrY0M7x3VLV2gm1wlnbSb7LHnDU4/zzxxKrZgcvPj8l0g
	B5gRopIZ7ShzLBvXqVBcRcmSBYtNst9eO6Ej6Hke8orp2f7bCB9A6lYxBoWcKxVSbLRW7t8d6Ak
	lMVo3+nIXjaZH1cHwp2di38UwFVUipOzIlqBybX9kKvddmiUzfQnUuTrcFseVhnDY3TZg5DghOO
	PpG1B1cWobIVndkOYy6+3CUIL0B5LvtCmB8CrVQT4Wqog/LhaoJvXhil8U3uRhlnRbT9jDehirM
	Nxn4aMTCQVDgLA1Yo60OK2StMntwt7ntyxLycW9l3BFzARokpK/0CdxjU05OrY0Uc4yRjm86amu
	PA0Fw/7
X-Google-Smtp-Source: AGHT+IFdGc6Mg2NLuWw8k6tdvzIclIeZLr8fIMB/We8FpiyeJTcC7asLjb3Pr3ApzSo8xGy0+HaRsQ==
X-Received: by 2002:ac8:5a93:0:b0:4ee:4656:54f6 with SMTP id d75a77b69052e-4ffb4aee2c0mr263870871cf.84.1768259311529;
        Mon, 12 Jan 2026 15:08:31 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e2a8fsm144992886d6.16.2026.01.12.15.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 15:08:31 -0800 (PST)
Date: Mon, 12 Jan 2026 18:07:58 -0500
From: Gregory Price <gourry@gourry.net>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com
Subject: Re: [PATCH 5/6] cxl: add CXL_REGION_SYSRAM_DEFAULT_* build options
Message-ID: <aWV-zstlCWPLT8g_@gourry-fedora-PF4VCD3F>
References: <20260112163514.2551809-1-gourry@gourry.net>
 <20260112163514.2551809-6-gourry@gourry.net>
 <d612aaee-6bf4-4a30-aef2-46619cec379c@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d612aaee-6bf4-4a30-aef2-46619cec379c@amd.com>

On Mon, Jan 12, 2026 at 03:11:00PM -0600, Cheatham, Benjamin wrote:
> On 1/12/2026 10:35 AM, Gregory Price wrote:
> > DEFAULT_OFFLINE: Blocks will be offline after being created.
> > DEFAULT_ONLINE:  Blocks will be onlined in ZONE_MOVABLE
> > DEFAULT_ONLINE_NORMAL: Blocks will be onliend in ZONE_NORMAL.
> > 
> > This prevents users from having to use the MHP auto-online build config,
> > which may cause misbehaviors with other devices hotplugging memory.
> 
> Isn't the MHP auto-online build config still used in some flows? A quick note on
> when that option will still be used would be nice.

It's definitely still in use, and in fact we use it to manage many
systems with BIOS configured decoders.

That option super-cedes this option, which... is probably problematic,
and David might want to chime in on whether improving the hotplug+online
pattern to include the intended zone should dictate its removal.

~Gregory

> > +static int cxl_sysram_offline_memory(struct range *range)
> > +{
> > +	int offline_rc = 0;
> > +	int rc;
> > +
> > +	rc = walk_memory_blocks(range->start, range_len(range),
> > +				&offline_rc, offline_memory_block_cb);
> > +	if (!rc)
> > +		rc = offline_rc;
> > +
> > +	return rc;
> > +}
> 
> I think these two helpers can get moved into patch 2/6 when the 'store' attribute was defined. I don't
> see anything that requires they're in this patch and it would help reduce churn.
> 

Yeah this'll get reworked with the interface rework.

Thanks again,
Gregory
