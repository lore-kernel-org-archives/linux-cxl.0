Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E21D3596C
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jan 2025 22:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736287289; cv=none; b=Q2BWbsJlFiHZP1LTwCFmr+AH5PZRxDRgafUYHwXIwCeHIj29Bqo0XTZsdCeA8OXqmblZa2rYPiGMAz5t5eX4LU6YiAQKFdJyMB8OAURQGKS27D/BNaTNRLgn8EUYkIlKyJdds5VYdQCxQGX2JC/knW7fjKtHBK0SIX7GZ7PT2s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736287289; c=relaxed/simple;
	bh=HTd6aNzd+WG4gQYS/ec1UtjMqQBNV7pllBynGdA6iOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+9zMYREzYm1hh2M5n8QRmMAVuyXAHG5PegvL0cOKm4Onf+3q2QDWITVnBhyBz0J0yTwOjIF8vRfG+uWvbb1OQhk8xQrSk8dmLsbMIW/zlW89fsZVRUlTWhPtu4YOgF3AAug0vEFKUzB6x1GTmWg+uHkiqcY1uJYXRjpEHduTIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=G7Xk2R0E; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="G7Xk2R0E"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b6f1be1daeso1492889185a.0
        for <linux-cxl@vger.kernel.org>; Tue, 07 Jan 2025 14:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736287285; x=1736892085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9z8RNkUkt+CcynHF95NF8N98PCbipY/N38UIAM8LaNM=;
        b=G7Xk2R0E8ra5rHDh2cvQ0d2nXFQitlpjzzjSH9Mwk/m6ZDVR7Bb6SHZPgdP0tlxXIi
         S7ayMbdxkqS+x5LG5RYpHr4TbB7D+d8x0TTnDt1+eXcTt9AMUeHJa3zGrMFGtZzrPAZX
         p0DW72YcxVGj+6XZdugUAVQ2XJ8+HXy7J+fnFO5TfaLY0OI9KXCuHL3RFxCMQWNpvUC0
         gqzs1dJ8jgd666BtSHzgfHkTYnSebINsTqjHuuEFbm6coFXRbFIjYUm1sBaMX382gjYc
         J6jMHGgWJcQ5avBkjSaaL4T6tjyoDw4QlYZuubhy//te/SETKPRcHVBDJ0jtss8AaLJ3
         7vIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736287285; x=1736892085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9z8RNkUkt+CcynHF95NF8N98PCbipY/N38UIAM8LaNM=;
        b=qfQzMx2XFqtlHH9ycC9OXc6Et+1bnu8u3lcecbQfcmbc4jA4/MOTTW5rufmAxDug2Y
         gCSfL+F9Eds2nBvZjrCBoBTWPcG440DPshFWkm730BG8b9HRCsLaOsVv8anisbJtVf6D
         E5lDHLdTH/gxMkWjVTEgLDFnS/mDIHE7/sNz1MmLS7+t01071IQVwNHnMTXMz9+o0DUm
         /9e1a5gX8kj7YnI/kaGfATh/qCyJwOuQcvPF3IGWOq3NHMDP3mjaLlidGda7wVZ2xK2n
         0IclWDLCeU+X75I5p49MLzY2u1w6JMLiz8Z5PJfA0GOUtgVesGKZriXlwcpbG9aiz0ic
         CyTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpaYk4rgmpYe395cgESka7e2E0SGyfOkarywwYCbYEcFW3LstzGQ9gQSLly8AlJEvZ/Tdtm/bmeE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEGkAK/9Q35aexLXhMf83LRwKfaVwkJPKmVhdignQGrnXp5R7v
	p6FaNe8CsYOrbVwklafIU+3ltp4Rwy8afgW74HdKTj7YP1PtsD7xKl0YinGW7nI=
X-Gm-Gg: ASbGncsQKt4idAvzR2ut7vD26rYN5EU0np0sbDg8G1/pR3eBWpy8nHmOVY8H6CQbhMT
	CA/vIWI+PR1EHm6Zrly2JG9O70H7Abzq4WLhxxbZqmJ3kPIWl6ky2Ow3tgw78M1yBrbP5rzzzJs
	d2g1WVJ/BC+2vEbYzHoqR2jYBkFiKhO0cnR3ba065/esg7CIi5xP1+NtuAdqOxUiOVBmAd0zUvw
	fad29v8kVuvoCI/Hn4qb7b5NeDq9jLTjK/1YtzJO0iV++MNcziirfDbOnKcTmYMIOvI/th8BSRG
	jydRYYuQtCF7WmDshG+y0wLdQAhwtO9JJxq1nio=
X-Google-Smtp-Source: AGHT+IHbOqe2Ef0AYcLsrDlalZWeqM6pd6Eh/2Fncle6Uf/C590+nFuSLbF1ltS+ZHE+yhoYTu6SBA==
X-Received: by 2002:a05:6214:5782:b0:6d8:8480:27e with SMTP id 6a1803df08f44-6df9b1eb0afmr13222126d6.11.1736287284860;
        Tue, 07 Jan 2025 14:01:24 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd180ea6fdsm185057416d6.23.2025.01.07.14.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 14:01:24 -0800 (PST)
Date: Tue, 7 Jan 2025 17:01:22 -0500
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
Subject: Re: [PATCH v1 16/29] cxl/region: Use translated HPA ranges to
 calculate the endpoint position
Message-ID: <Z32kMmH25_qfHhZ5@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-17-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-17-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:10:02PM +0100, Robert Richter wrote:
> To enable address translation, the calculation of the endpoint
> position must use translated HPA ranges. The function
> cxl_endpoint_initialize() already uses translation which could be
> reused to calculate the endpoint position.
> 
> Use translated HPA address ranges for the calculation of endpoint
> position by moving it to cxl_endpoint_initialize(). Create a function
> cxl_port_calc_pos() for use in the iterator there, but keep a
> simplified version of cxl_calc_interleave_pos() for the
> non-auto-discovery code path without address translation since it is
> not support there.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---

just one inline question

> +static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_port *iter, *port = cxled_to_port(cxled);
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct range *range = &cxled->cxld.hpa_range;
> +	int pos = 0;
> +
> +	/*
> +	 * Address translation is only supported for auto-discovery of
> +	 * decoders. There is no need to support address translation
> +	 * here.
> +	 */

Just clarifying - it's only supported for discovery of already
programmed decoders (programmed in BIOS)? i.e. driver-programmed
decoders shouldn't need this translation / won't support this type of
interleaving?

Comment here begs some questions but not necessarily a review blocker.

~Gregory
