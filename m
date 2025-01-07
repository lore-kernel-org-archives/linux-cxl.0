Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8881F3D31
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jan 2025 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736274552; cv=none; b=tfFYfOwc3A97eqUpj/fvrZBIAMc3q4O0J8ZliOY40eeBg3QFep54CjMJKRPkfsImuCTCPS1vKqTHYxwCHmeZZBRJafJHumoMlabTq3bsX3az/2TAoDHAqQscm1vWxBJX2iLJsKe18yq4QIZ1EysmwwUmobFUGlf05pHIV8Rbv5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736274552; c=relaxed/simple;
	bh=HuzTlQmNZsIBmfBAmyOUKyF/ixrOlmUaAyaX5ng3OkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UApbi7y/CNZdg5Mnj7s/mYDUO3p7jEQ64Famq5EYaowzuQ+d4hxbnHNEEuNrnNH75e6U8wRxkY7K+hOizC9ginUrXoXnbI4HzleCW9hcfzrvB9Ou8/btVi2NX6XnuY/p8HtqKrNxKOPyQzOSktjOt+ZXpG+z9BybEjQEncsLmZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GIUz6YJt; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GIUz6YJt"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-467918c360aso18543111cf.0
        for <linux-cxl@vger.kernel.org>; Tue, 07 Jan 2025 10:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736274546; x=1736879346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dp605me3sPsa5gpAtTALr5yeV9d4gS3Ff/ETi3+Scuk=;
        b=GIUz6YJtKHzbTtkFcdtnQn2CxDY7vzAQ1GvAhXNvcjqdh2n/t3ZKi/NJajkSyDbMT5
         fGPp2SwxGUs6lcXxI5rTAr8LISUsgatIluTmm4LnzhDSMz9ehgRObIzkJHyiUS2qpgMh
         HW3MvI76ByYd/B/n0xZdmWB4AA2RqlemueRiDFZeZayQq9wAIahIRxnfiVvzohCVUbKj
         9GEvSqIoNdi46GdajDIVyLTryDvlrvMVqqz1vPWi3xRRZgOYj4eMY8nLwg64plok/QMI
         BDWpUxh/4oGLrBGQKem+Zrb1Cslx66cilyh9URTIb48aJ5eMFXJYSIxkGtMg5uDBtWz1
         VFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736274546; x=1736879346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dp605me3sPsa5gpAtTALr5yeV9d4gS3Ff/ETi3+Scuk=;
        b=P66b0xwjuB76l7BdGnv4rmyhlc8yoFG0moHqm0CuC5maoXP9qLZJVpeKQB7xen+/AD
         ks5zjyRelFV7BPN3aoV5EtflZ6C4zVwBNGtKqYOWz/Co0YFQ//NtIbNyOQ5j1WOUnsTt
         U+ni2eAZiL1bl5Qpw7MDA7oG2mz2joKZjst2p75UsRf00dO46CadpBHnCkEHXs4c1mvR
         VXSuGpLMKCQ0TY669/Y5sq7/hNQY9mepirCHhjyWw6L/sxf0mNbrOV+OKTPCEvSNGsu9
         VwPcC6s06J+34CgDt53J3SnROhHAGIUzbxN4ZHuWlLWdo7RE2IKefx/JLsRKeReKSJ3S
         MjTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCPjZgDOP3eAQKBfgY+tigC2O66KouyQL4I0vIYyiPXTlfyq7YHc1PxBAYVOTy5YSiOmxZu8nqgXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaU3V9kkunjyv6WvtrmWzK8JvOUOnmA3A9DB+E4nK1B4flinF6
	B8mSdC/vyKwdoHU19zrM2FWHkCBtnUhfx7nZj/zCTPPTMOGLjcaL/jdInUI2nAw=
X-Gm-Gg: ASbGncu3opeIFkNl9/e2zJ0RFNfxKKg3okXTE53+f0yIx6Nuz64FCaExGn4QgSB7v2H
	jiij1PHk84jJrB4eORhthSO2kI61YS85B8w04g59zcE05Ne8vkfSl7eDZpTr2+XNMrBSpdGNiQp
	oUun5oMkBffRdjPnbzQAxroJs/uXw2NcwawFdb0CoiLQ9dSj2UP2vY5H9kJuDT20reR9BFSWjxV
	2tv1dMcRYqgjDlK4H6v0/FvP01syAiCqT37tEFnR8Cn2VAuQqybQP1Ykz/0MxhO4d2BfhnPRIqG
	9KnDJxEJzHZPDq6KzD6zQgaRwNtmN2zY7XEBu3U=
X-Google-Smtp-Source: AGHT+IGmvA0CQPzc1AmDqnnOKKW8CkLxAcqlYGFt4Pyyms7/mSY2wxHRPnKqa8UwT7I2YxmQprynqQ==
X-Received: by 2002:ac8:59c4:0:b0:467:6b59:423 with SMTP id d75a77b69052e-46a4a9a4378mr1243268061cf.55.1736274546631;
        Tue, 07 Jan 2025 10:29:06 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e6a61cfsm189376481cf.44.2025.01.07.10.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 10:29:05 -0800 (PST)
Date: Tue, 7 Jan 2025 13:29:03 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 08/29] cxl/region: Split region registration into an
 initialization and adding part
Message-ID: <Z31yb1WUA-5vEiQr@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-9-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-9-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:09:54PM +0100, Robert Richter wrote:
> Before adding an endpoint to a region, the endpoint is initialized
> first. Move that part to a new function cxl_endpoint_initialize().
> The function is in preparation of adding more parameters that need to
> be determined in a setup.
> 
> The split also helps better separating the code. After initialization
> the addition of an endpoint may fail with an error code and all the
> data would need to be reverted to not leave the endpoint in an
> undefined state. With separate functions the init part can succeed
> even if the endpoint cannot be added.
> 
> Function naming follows the style of device_register() etc. Thus,
> rename function cxl_add_to_region() to cxl_endpoint_register().
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Little bit difficult to read mixing style and functionality, but I like
this update and I understand why. One inline question

Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
>  drivers/cxl/core/region.c | 36 ++++++++++++++++++++++++++++--------
>  drivers/cxl/cxl.h         |  5 +++--
>  drivers/cxl/port.c        |  9 +++++----
>  3 files changed, 36 insertions(+), 14 deletions(-)
> 
... snip ...
> +	rc = cxl_endpoint_register(cxled);
>  	if (rc)
> -		dev_dbg(dev, "failed to add to region: %#llx-%#llx\n",
> -			cxled->cxld.hpa_range.start, cxled->cxld.hpa_range.end);
> +		dev_warn(cxled->cxld.dev.parent,
> +			"failed to register %s: %d\n",
> +			dev_name(&cxled->cxld.dev), rc);

Is it worth differentiating obvious failures here for a better warning?
I'm fine either way.

~Gregory
