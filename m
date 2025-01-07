Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEAF1E0DE6
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jan 2025 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266726; cv=none; b=pkEDUhMAwlAUEyKaYnHfsOYPhz0zwGCIawKYUKAsvGik0dJwdvl522uQkvIags/fNNa0g43zH+3c7yBOH0yqGZoOqno01gMf8ENzGK9IKfavEvF+B651hhZcltwlMRaMXhRJwET8uQdo2iuUXJgISWNm6fb51WmvOCvlmx65Srg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266726; c=relaxed/simple;
	bh=DsDpwZtFplSEkT6noLhJ6QOEOEjv2MxU5xuN7dFjQQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAKcpBm3D2l9GAdejjvO8RTbk/xRoyhplSLnAupdFUEOs6B9eRftqIZDrvBUJIsRPeRUSyRD4DN/IEafdGduIMRx56SKjmuznV7zpJZjSHo2OcsE3ehfeAol0dQ1ya52+hNMiHNMMPbODKogJwrpkP5bUiuELDfHclLKcAgd5LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Fynw53ny; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Fynw53ny"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6dd5c544813so114284336d6.1
        for <linux-cxl@vger.kernel.org>; Tue, 07 Jan 2025 08:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736266722; x=1736871522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FaxcSnz2S5smrIZV+cxVoc71rFoVpYYB2um+pmHtbYg=;
        b=Fynw53nyINO9Ss+e3FtZumBKqeEtJ4RJ5OA6SZ4A40L8pgLn+c/IO5qNnnNNkFzBVJ
         szUB3UvuUH2VfTbZ9dUKSRRf/hRm4dYj8bx/WswfJD1Xa5sJ+vknFdfr2YM90gwZdsDU
         h2E9kHewyMiMq4SQykAMvSb/tvGg0tBtOOmY/UOtQOKBpWCNjpcWVzxRvesRdha2m0Zf
         vwPlXtqgVKwOxhigRWIbF1BU+rvg0QN5tQolBvdJWMBIQtISJrjkIvBZvPfSYhpdlKVm
         i/KGlob8/Xs1WJ8X+Rur4Ag7WGH9ToOnNvS5rqxWOPZmUZtsUqBJXqCn/06YRgplnhjX
         yGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736266722; x=1736871522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaxcSnz2S5smrIZV+cxVoc71rFoVpYYB2um+pmHtbYg=;
        b=M3hV3GzT3ioQmrJrYDEXuDfMzDosDxCUVy5lp6/Rg2gf6S1cCtCAzelj262LpkOvmP
         4BzvyF/kT/lXzfXRfs1zGOwKp+ue46vxdluZG/5WbfCeY5RfgEIpa3KDhIshRMcdz+dS
         VOCf6/zX2u4/v7hp9+sNY9Vk6ZS2kh5tRX6XF6ptcyV8zMEFZ5t5xlXYhQWeEwR6vXcI
         Jn1R8Ek3U/NcTwaj02OUsTroQCOkXpObW+B0JnpSnY5sGMVaRtGTwjio/Gq2Kxrv4emv
         29bESoFLobW7HCGNeX+TVQT7eR6Tl3bhJ5j1fPJ6cFdNh0lT/zUeGp2wPZuLUPAWirvm
         AG9g==
X-Forwarded-Encrypted: i=1; AJvYcCUmWDGtAELiUhVDsAZu0KIBnzD1UA7XxCucHk71TCEte7aPykppA9UA0UVssmbM5yjguiWcXFkqLfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF/NVkn/FQXZaF9+manzqYLI0kRpyUMdj9w7lGlHij2C7DpzGc
	eS1/KvoUvY0LOM7Uhdk/JIIEOde5yt+HC6kaRdKuW0J/Wt5gdnHKY2/mnqEgc9s=
X-Gm-Gg: ASbGncsLFmCHCDpcsddkY0GITwd6uti1SDX0TtDarDUsvU1huN9BIjsl8WIySnR11wu
	4/hO84McUzpUv3vJtEC3Bf1cJ/8PgebEOYVbcyzAP8lkrC7K5/nkkkafcFvSUoGmLnB0Jg1CzLY
	0uE+ZmbOdPvUuNOomMUv7E20nwlCIag0+NsVku3VVuNnb1ipemAJAjxjUyQhdsTia6Q0K1c00kh
	h2Lb4XLk4qrPbMnisVVKsbRshWwfjYyFu+uqM4SbHh+bpdFq3R2hZv1E1mpKBM2hbucDZWWqf/l
	lWQgpvqM0eg8CO+uc7LGm3F5xjBudCI+cMfgf5k=
X-Google-Smtp-Source: AGHT+IGem7wzFy4INJNzPyNqGkX4WOpJLzsebBNHiJG6ibLSwau55oro1R8Xpz7jo2OdpjPGBr1LlA==
X-Received: by 2002:ad4:4ee7:0:b0:6cb:f40c:b868 with SMTP id 6a1803df08f44-6dd233b7ec7mr968281096d6.46.1736266722319;
        Tue, 07 Jan 2025 08:18:42 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181d53ecsm182205516d6.114.2025.01.07.08.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 08:18:41 -0800 (PST)
Date: Tue, 7 Jan 2025 11:18:39 -0500
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
Subject: Re: [PATCH v1 02/29] cxl/pci: Moving code in cxl_hdm_decode_init()
Message-ID: <Z31T3xeUytKJGkWF@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-3-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-3-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:09:48PM +0100, Robert Richter wrote:
> Commit 3f9e07531778 ("cxl/pci: simplify the check of mem_enabled in
> cxl_hdm_decode_init()") changed the code flow in this function. The
> root port is determined before a check to leave the function. Since
> the root port is not used by the check it can be moved to run the
> check first. This improves code readability and avoids unnesessary
> code execution.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/pci.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 3e8d20f8955c..d206378c4cbc 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -419,14 +419,6 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  	if (!hdm)
>  		return -ENODEV;
>  
> -	root = to_cxl_port(port->dev.parent);
> -	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
> -		root = to_cxl_port(root->dev.parent);
> -	if (!is_cxl_root(root)) {
> -		dev_err(dev, "Failed to acquire root port for HDM enable\n");
> -		return -ENODEV;
> -	}
> -

Can't say definitively, but my reading of the original ordering suggests
the intent was to bail out of enabling anything if the cxl root cannot
be found (which suggests much larger issues).

This code flow allows the device to have its bits twiddled when the root
cannot be found - is that what we want?

>  	if (!info->mem_enabled) {
>  		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
>  		if (rc)
> @@ -435,6 +427,14 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  		return devm_cxl_enable_mem(&port->dev, cxlds);
>  	}
>  
> +	root = to_cxl_port(port->dev.parent);
> +	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
> +		root = to_cxl_port(root->dev.parent);
> +	if (!is_cxl_root(root)) {
> +		dev_err(dev, "Failed to acquire root port for HDM enable\n");
> +		return -ENODEV;
> +	}
> +
>  	for (i = 0, allowed = 0; i < info->ranges; i++) {
>  		struct device *cxld_dev;
>  
> -- 
> 2.39.5
> 
