Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD471A83E1
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jan 2025 23:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736291541; cv=none; b=siwtuL2g2w04hXdpB3V5A2uPbWSLzTQyHOamHAeZyr00m3ldQ9DEc2z1IR6ksswABfN5ebmAQsiNOy7XOg645X85wJi0be/a1euBuBhcR14TXDBz0viCLv7lkEaGlESD27j8LAlb0aKSa5OBkuRLnPIlKQSeW8cMUy1lPoMu7RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736291541; c=relaxed/simple;
	bh=ke+cTagVWNayiACoAJMsNy9aZ6DDNXeqKH7RDgVf9us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7onBhYdxm5SF6UP9B4NQ4WtgbLRSMuaGTPS9MSKhaJCyFgWSfRR+P9oEv37odSZUJiu+lpw4PX72f9HrgUMxXBFdYNWWIfPH6HljcGCMBi0okuq4BmWZqLmsMpkGHfVxwqZVoi2wpTw92PrZgYswn/5agyVFv04JCZbiuCByok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gWPnS7Ox; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gWPnS7Ox"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6dd43aa1558so118991606d6.0
        for <linux-cxl@vger.kernel.org>; Tue, 07 Jan 2025 15:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736291539; x=1736896339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9VHFqeLvAexKLFQY6+Qlq47pjz76NClRGHlKgml5Mnk=;
        b=gWPnS7Ox9KGS2ICBLtAqbvgcO8r9HiOw/efzs4Z6ETc7KTfFx9WMiznxGZGKl52f6X
         ilhBpT+uxPBC/2dfO+0pH/uOOjK5/ARwEnuQaKy+tCbPYXe7n5Oxr/WG45AhQy21eaJ+
         AUQy2UHJwk4LOeXREgFvlqY+btOAARpIhass05DwKwi7c8RnyM1+jjWrUHh0yxfp+ixh
         b5SmY8Vxp8cew1RXxgMqUltrR1BeWNgzIhaI4aMqDm66BDkxW/2QEDzy6lszNhyVbj9S
         nL/3nS+3C4ggKibyqq62+xFcOmirG9ExMd5nJtryzZMcoUmHDemdYpVQPpot0C0QJJE8
         lTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736291539; x=1736896339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VHFqeLvAexKLFQY6+Qlq47pjz76NClRGHlKgml5Mnk=;
        b=WbVhfH/CiBTmxKal0GRNhGOGWhzzkQNAVowLosynXkhe6sVp11nHUmelqJZ5qY/1oW
         FelugWzcAKbO0OT0AdvCTi9MtMi76pbGxJHker0MQqotFopxZELTRrPMhKyqncGQ35NL
         1jKNii+XWTddpD5219z8HUey841bt/FnjtVoFwtyt3wcDA0X8lBJ1zeQTjubwNfSmeki
         G8Lsh5g3ZRHaGqhqy7G/sxlB/lrfZivVrXiX4sQF2DpQwlKd3oDL8rweu17VljkVBtq1
         OJ0zBtopNUq5Zw3A96/imHAG3SpJ9bHOIf7O4m8B7T9/dpQv/1cS05yGlytUfdoGNsOU
         jViA==
X-Forwarded-Encrypted: i=1; AJvYcCUDj5iovCpUezTTcTEGhyf9bXYD60FYg19W5tRxHrez26ODKeKks+oNhL+sFvem937wRYAl2yydvNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvwHS1jdKpZHkvumw92ugmzMmh4DH6SrLRN59Y4U/E1sDM5uQ/
	i9tXlkIMl3D0F7CG6X3IxYtLx8WUgcfgEv2C4eAmwdKvnLWOywYStiJE4NcfEW8=
X-Gm-Gg: ASbGnctXKCMEvSsIpdQlghSimmBBdYALrV8gqJDal7T1Jbbnb1o2/j9SHqy4B5HAhX/
	YJQ/+BYRQhF5iCmHuquQHTzpGHfpdg+ewh1l3TLek1saB0djK8r0HEzD/qdwTmXnJcCasLhxWEX
	jQ9wGIeugTM8Ge2RCwdeXVucLBVbL4lJmRKoDdMq6X/7/1TwTd7TfaTMXzGgok2SHr0xRoG736Q
	RRJZIr2xnyKlK4qLfDYxOGZyRgQj2Lw0cojIL9n1geOQbrHW5zBX8XeVwSBTAiF6+XOWAiGE6PM
	z08Bx3XCv1QHadxgrUKtxmSmPITqE8DJq1LZy9o=
X-Google-Smtp-Source: AGHT+IEFB26SDfw9G5BRp1YuOtrLu5w4moBk/iJUy7upN4VtO3G8QGwOmQ8T11fIf/XTe95usVK0Fg==
X-Received: by 2002:a05:6214:2a4e:b0:6d8:9bbe:393d with SMTP id 6a1803df08f44-6df9b1d1f3dmr12565886d6.1.1736291538812;
        Tue, 07 Jan 2025 15:12:18 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd18137543sm182178636d6.58.2025.01.07.15.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 15:12:18 -0800 (PST)
Date: Tue, 7 Jan 2025 18:12:16 -0500
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
Subject: Re: [PATCH v1 28/29] cxl/region: Show message on broken target list
Message-ID: <Z3200KvAGaoW1KcS@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-29-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-29-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:10:14PM +0100, Robert Richter wrote:
> Broken target lists are hard to discover as the driver fails at a
> later initialization stage. Add an error message for this.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
>  drivers/cxl/core/region.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 775450a1a887..2af3b6c14f46 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1870,6 +1870,13 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>  	}
>  	put_device(dev);
>  
> +	if (rc)
> +		dev_err(port->uport_dev,
> +			"failed to find %s:%s in target list of %s\n",
> +			dev_name(&port->dev),
> +			dev_name(port->parent_dport->dport_dev),
> +			dev_name(&cxlsd->cxld.dev));
> +
>  	return rc;
>  }
>  
> -- 
> 2.39.5
> 
