Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D8E22B5AD
	for <linux-cxl@vger.kernel.org>; Tue,  8 Apr 2025 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126242; cv=none; b=gHmq8pY+Dz5Ejdd1dSjKrncpnxsgHwUz7ztNaEC3KKX7eta6ZyO8vrng83859pRAK0IEGg66SY/XEy3AHvUb9tKPjcnxMplzrtsiCfVpx36GOl+kJB5Px8trunFVkL7md+5tfIF6WMcBwe+R/HQiS0ILdzbnf9kypjDxT9DIfYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126242; c=relaxed/simple;
	bh=wJ2kWEXqmHIVVFcKNKQQWAV8NF977MZH28l4p0Emvxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i42kHta+sKOoV5QWykR1hUzVVowhoIyU1XPYrGWog/cQYEdKoy5z1Uy1XDcTNd5jqn+DU4oO5boT0hzW3WKSRcQkVC/Rkb3AVHgKsZAWM+oRobAbeVCYZvg+XZJZGHqZiX6n5YHlGb4DkIdGqZbdOiddEHx2ULFDsRscHJnEuHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=apPG4qGQ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="apPG4qGQ"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c59e7039eeso801519285a.2
        for <linux-cxl@vger.kernel.org>; Tue, 08 Apr 2025 08:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1744126238; x=1744731038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=80p7iIkcfWVt6T0ZDUkow3T09KI306nMAUN+A5Nla/Q=;
        b=apPG4qGQmLPErLeUoH1I9UR0jhp/GnCUtMeLo3o0N6PW0GerSXjX/gz9zVIrBxf/sS
         /yD+BoSLmBN13K28Ofd9f43NYpIf+KTFlQJp5p0tN6DnKscdZgzcnjU9r7xZJOcJKxNK
         ESgYXgFVE1Q80zIvv+CBZf28gB4Qr1ZhH6n6NTMbMW0Tcn7V91KfxoRCPhpcii7JJLr7
         /nAnogKmfXIDX+qh4Rt77Mq+Myx63Ypu5kaIkVTejl1q/qP/v19xsDHOUz9wMp9GLPuj
         zIUlfGH7ip1/WnOWnk/sTAtZDGZ98jq/hEbmVCF6SjbE3OnT80hdP4SEgTziwIR7UVtd
         Z5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744126238; x=1744731038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80p7iIkcfWVt6T0ZDUkow3T09KI306nMAUN+A5Nla/Q=;
        b=wLxNDgar0yykBuR01wpZz8TiStaNNks44TrZeSpbP0ZKi9w9N5FhJxMLqwAtsRMehO
         QgYN/rWYpgfflHgNVk7HTz8S5nUQSIwncS5G5DkmmIF62NOOhVHq+YN2pK2mfyZABc4Q
         OnpH5flbZ9ETEScX1F5P9tC5a9dewVN1wK55ssAC3nLy2D7fSn+wif6cCZiOIzieZNR5
         MfzuvGPMh0lIPf6fUx/PV651fousl1mlgB5evmM1J9ca2Ecirow5kLdTPh3hQcZUCfdk
         5yzcuQx/m8EJmiJd866EFAWg8xTOX8tFy9B6ADtpMgitJ3/hG3R34zlg+8cUe+OpZ+9s
         zEQw==
X-Forwarded-Encrypted: i=1; AJvYcCUmw0CxCtMEM0MLfgazegih6kpQd3wCIDgybsEFhmbEDM9qYF28vWofb7bErtlv+wThqM14nTHL/i8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJRugrghWtsc46FGrYP+JcH4GgPtykkX9l8wDMs0Wgjrms5c+n
	adTp4wP3BtWuZIZH+swLpyDPzrkw+A5QkOhDp2KOfd0O0dlmE3e5quka6lnelmo=
X-Gm-Gg: ASbGncvIyu5Y74pNU2eEjn2K5qCbE8coJu5YueGdFtC7V6vTEm7dl4Li9FGiHxsUEM6
	Y6N3tO5jC7fcGUO0cWljpQA1Q8ntvaeUGntG461rdeaMbDt3xDgpJ6eYpEa+BrlrgcaOdyqH0vw
	PMAakYHN7m1p2EyimQqAKQrGmKXpCr9HQczUX+cPBqTTwnJQdKKPV3JyRgxXebAeU/VPleh8Cw/
	vzocGlNip6rPHX3ciBVeGuq7OmEsUkFpA0KEcZuIWiLixu2uYnTs824sIaYw4pFo1duReUhTkzq
	IzYnrempYGGgsTGrHIv4pz5csF6/tnQETnSTROcEaUd386XcclkERf70C5G25vU8NIUxIWCS2DV
	ZjopSw0aJObnDW+G+avI0skga/u2VUonf7rt+dw==
X-Google-Smtp-Source: AGHT+IElG3B7qmkd4bwP3vsCYukqysH6g7f63YBrkPa7XO7hD1VZI5XzBRmSCmw2vJvB7Cw/9Ps8Lw==
X-Received: by 2002:a05:620a:1994:b0:7c5:9a37:c418 with SMTP id af79cd13be357-7c774e24d8bmr2328284285a.51.1744126238373;
        Tue, 08 Apr 2025 08:30:38 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76e75acabsm771487885a.28.2025.04.08.08.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:30:37 -0700 (PDT)
Date: Tue, 8 Apr 2025 11:30:36 -0400
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH] cxl region: recalculate interleave pos during region
 probe
Message-ID: <Z_VBHN375pEl_MhI@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-5-rrichter@amd.com>
 <Z_CW6AIE1zoA80qB@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_CW6AIE1zoA80qB@gourry-fedora-PF4VCD3F>

On Fri, Apr 04, 2025 at 10:35:20PM -0400, Gregory Price wrote:
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 934dcb2daa15..5c9e2b747731 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1879,7 +1879,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
>  	int pos = 0;
> 
>  	ctx = (struct cxl_interleave_context) {
> -		.hpa_range = &cxled->cxld.hpa_range,
> +		.hpa_range = &cxled->spa_range,
>  	};
>

Realizing just now that this line belongs to the next patch.

~Gregory
