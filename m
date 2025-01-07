Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8029619CC17
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jan 2025 22:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736288334; cv=none; b=EyKdEvlDN1aIuh8/dr36xURefR2lB8VHC1e8YCM4XoMIKm8N90c1RgYVsf3bS34iZg3UgvS6C3LKqv9ronsR31o3KyqBFwzOgrgFYn9jxo+7NnBDmHKVfwHNCO0a/sikHrfhEZ/6fU77bOU1ECEMJHpBtphIzM9HdwhL1BdqlA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736288334; c=relaxed/simple;
	bh=C92n4giowFcJkP9bJoncOBGP6u7vWCoZqQBLoDO8ifk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCioy3BwBQMw6BCalcw/m0jwqw4UJnrRhtEfC77tW0NEZln0eyuJeH4kDaJ1uzDnnU/1MjRMjot8xjX/ByQCqqFEOE2Hp39KmcPbu0t9ZILw+IaURRI9U57vPkEvioeW0xBkNesnoiFgvU3/b5qzcERCr6TcRM4vaQfIH4ctWGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gNR+8sWk; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gNR+8sWk"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b6c3629816so829053985a.1
        for <linux-cxl@vger.kernel.org>; Tue, 07 Jan 2025 14:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736288331; x=1736893131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CHei3rjYaWUC5xmAfbKIWX0f334QfNk2qMw/9plGp/0=;
        b=gNR+8sWk60oy8HPckBK8QmTZQvThI8zl85uPH9xasrqQY0U8+cZz6lkOZNhyAezhLZ
         rmRcxDaAMvTYksrjFZnA1n+J7XM91DwShbvJB1CTCeqEouvliBLeMyf9AUCwSvoJszb2
         BoBqIz38KCipSOotvi2KfFJ3CPW4Oi+YB2P8BWIuyLtUB02sDNKO8FM8DoWRh7HrlW1v
         JifpxYFyu5+ShXrvQQI1O6fGe2rn7Q6AAZrRtUo6jdmxXZEZGiRLrXUXP0sPVeFbTehZ
         hG9HWch57qhUw+d9GssMh8dL40emkhQbNlFg6N4kSQ2by/CutOiB4PYicFOIDJUtAcxl
         XfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736288331; x=1736893131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHei3rjYaWUC5xmAfbKIWX0f334QfNk2qMw/9plGp/0=;
        b=RxTaAL64jct12ZZm6IiGG+xBm0VYGRLoRz6kZe6eiQnfRHjowoxVcJIIZPbJmjgNh/
         DZbVaJdrs0Rpm4oL+WHGk7/3LPni72zWJGhGMtwir7sKYMR5k9VT9Id7TnSlvDr9mUFv
         h7qmVo0X4Wtv60ipohabacdiMHEJVlmAdVG495BACvoR+mCSHSPTVZPfXFfb5yOMs9qr
         b99K3LBdGW4iy2llntA9x+hCRbZXl0y4nFJrOtlCzz3EqDRT9UVvwAKbZ8EZGDhvii3x
         YxZ6CjS8ctfHTROi/dqhdJ00m+FmnP0tSemjB+LHTvyVoWZnhu4KTTdLdYZ88QKm/b6/
         AeQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZOJ1jugVDHrBayWzSv+Uo3IPg54MOfyS734MppWiLQkOq6fyat4JLX/+330ROacnHDr85txUWvNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRUciIYjnc0kwDCbzq9rJc1rEFKbzGGniSdb1iyCvD0fIzOLs0
	85jY1l7r77HC/koocjv58/Zu1Gitn1cQxd6LprCywwSTxgtOdxOwcylYZzQWa7o=
X-Gm-Gg: ASbGncuXjk6ZWim3ZhYEGF6xpoHTodjg2J/h/rXofzj2LTmLvXQ9EyqTmD2+K/RiZLX
	pNxPz1vm77PhWQ4hh+pugXcJPKAsoF63Ui0spnopv1Ib0+ltxR/1qmPiMHyx6t/z5w4i/LyKVae
	AsbU/wBHt9u/7362DUBA7cBBXwofjP5LN9qVWl9YUzUi5Y4YmYHyo+vyEyGWJECX38Qkbkq9acx
	+2aAYKut5hIJjtFgLuI48kFxqckdtAlRieaq3vN3liHd49xX6FyGbEU6RSMR2AILXXyADZfKssb
	HoWXGcxOY9DO8nFy0AfQabJJgRFssdE26RoDzBE=
X-Google-Smtp-Source: AGHT+IFsemh/GPR8JW3UqZb+zild0+OAi5y8U5AMjkNe2LVIp5FKuTyyvio2CuL45Y2sK7NqvQI9Og==
X-Received: by 2002:a05:620a:459e:b0:7b1:ae66:e8cd with SMTP id af79cd13be357-7bcd97622d4mr74060685a.44.1736288331489;
        Tue, 07 Jan 2025 14:18:51 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac480ea7sm1628781885a.94.2025.01.07.14.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 14:18:51 -0800 (PST)
Date: Tue, 7 Jan 2025 17:18:49 -0500
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
Subject: Re: [PATCH v1 19/29] cxl/region: Use endpoint's HPA range to find
 the port's decoder
Message-ID: <Z32oSTvQL8EmNmxz@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-20-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-20-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:10:05PM +0100, Robert Richter wrote:
> For the implementation of address translation it might not be possible
> to determine the root decoder in the early enumeration state since the
> SPA range is still unknown. Instead, the endpoint's HPA range is known
> and from there the topology can be traversed up to the root port while
> the memory range is adjusted from one memory domain to the next up to
> the root port.
> 
> In a first step, use endpoint's HPA range to find the port's decoder.
> Without address translation there is HPA == SPA. Then, the HPA range
> of the endpoint can be used instead of the root decoder's range as
> both are the same.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

I'll make a note to test up to this patch in particular in HPA==SPA
mode without the follow ons.

The functional change here is the move from cxlr->params to
cxled->cxld.hpa_range. 

What was the likely value of cxlr->params previously? Undefined?

Otherwise I don't immediately see any issues.

Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
>  drivers/cxl/core/region.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b7f6d8a83e4e..23b86de3d4e7 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -861,9 +861,8 @@ static int cxl_port_calc_hpa(struct cxl_port *port, struct cxl_decoder *cxld,
>  
>  static int match_auto_decoder(struct device *dev, void *data)
>  {
> -	struct cxl_region_params *p = data;
> +	struct range *r, *hpa = data;
>  	struct cxl_decoder *cxld;
> -	struct range *r;
>  
>  	if (!is_switch_decoder(dev))
>  		return 0;
> @@ -871,7 +870,7 @@ static int match_auto_decoder(struct device *dev, void *data)
>  	cxld = to_cxl_decoder(dev);
>  	r = &cxld->hpa_range;
>  
> -	if (p->res && p->res->start == r->start && p->res->end == r->end)
> +	if (hpa && hpa->start == r->start && hpa->end == r->end)
>  		return 1;
>  
>  	return 0;
> @@ -888,7 +887,7 @@ cxl_find_decoder_early(struct cxl_port *port,
>  		return &cxled->cxld;
>  
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
> -		dev = device_find_child(&port->dev, &cxlr->params,
> +		dev = device_find_child(&port->dev, &cxled->cxld.hpa_range,
>  					match_auto_decoder);
>  	else
>  		dev = device_find_child(&port->dev, NULL, match_free_decoder);
> -- 
> 2.39.5
> 
