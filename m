Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965E21F1902
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jan 2025 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736275118; cv=none; b=bqmdlo7U58szRbwGNfsZdPLkT0rxwqmd2/nyUTNbkdXUyCV1P2+KV6Y8lPR3f06NqhwrwnVcU/5jm1yEF5RQjCtgujF1H75VJe7HKPB6II6YNnMYfbYQxX39gge5mw3pjIzV/Thpum1eRMeAQXZZuIJoc0MtjmSZEsK3X6yN28c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736275118; c=relaxed/simple;
	bh=9HtiWsDNzgo89i/A9DUYqCWaTCj+4yUHwJ4Hx6eU7eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/UWsgvul777rBDVj5b/ihNGsDcHS4GLA9xDv7us+/h4TsOB5nrmO14hLf9uTFuKi1nKXZ/CWVusSCi9/DDh2I/A/tabdPR2IDNLQ2xc6P+mpJCKEjA1rt43vXFK0wOH+Q3wURZTgeg2t5sFydQwjv9b8iUBJvWdVI7b8nWMSgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=kFlii5M9; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="kFlii5M9"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b70e78351aso1257833485a.0
        for <linux-cxl@vger.kernel.org>; Tue, 07 Jan 2025 10:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736275115; x=1736879915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lxKRPAafgujkPHN/cyX+chAJbS2cosZ747BgCMk3b6Q=;
        b=kFlii5M9zl9IgB679U7SWTq7PLwrAeNK6GPznJ1hzuEZ/hQaftEONsZwgDrYTchkWw
         ZKykYkqzHm/ZMj1Qt0u6ZF8xBlriDgR0U0gKyCikXsRSxCPX5fZS3zTHk6SDTuBMG+0k
         Tnu1z5TI64QwixuuYJyBgHTxK1QRrXbgdwHNA4jayFPPkj0MHhEP/9VKwFmXKg1z/QUs
         i00ov1LoHcmyN0+XyJTlpLaPJeuanWU2ph/hSiraQy8umd4i9rqIiXntvw3KyK5fBnKW
         Kv9PaRWOVFjaRWGBsvPo13F8mgBXbrHybw0t3mI//abWkh0P3loLUt8cvOZJNAV/l242
         doPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736275115; x=1736879915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxKRPAafgujkPHN/cyX+chAJbS2cosZ747BgCMk3b6Q=;
        b=NCnAizJTdfauEQx/OUuPjHybLRYL677uvYTeoqZGBR0hs32ig3vXKbN2Im5aa7+BVP
         miPqN1n0DSKc4fe6tuEamaFXjaahCA9wrqY3mqU8tWFqym9QjzEI7xJLNrOoSQOQfRGB
         fY1VfLZfb6BfgtzEt/qCrwOVklKthck+KykvqSTpZX4yBiaAv3Li2rAM0juVfEU/lVH/
         P7ooVlSkuRjLClrp+MHVD/6TcNFJoRm4gG2RkN/4eMwWU0aQnvg38Hu90ifi5+utf/Bk
         pIuodv9Cr9QZEjBNE+Zah7WTrXPsy50jTN6riLisJkTPGzyR+3NCgb2x17irT44JcbIV
         +J1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4WZYcn0IAKq25CmGuw2Wg/uKWUKl1zO8C2pYtA9TqBCOGGrW/AW6e9AG5SsPkGbKe4pGrYZTMdqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YylGj0ctS3T7+bezoJEIV06ChNxZ0H5c8CHWA/0LJCqj2OVrfCf
	EZ+f2sUto1KKnB8B+9fwnUlIBwBjN1oYQLJ0MsVoc80JPKKw92MeElUZoDWE2nc=
X-Gm-Gg: ASbGncsHwWSG2BBe1NP3owb6lDounMNbJZIg28tDpRpn6BYlslJuKFnRwy6orAgvu2N
	/x2/5enqrrEqoe/MIRlvcBZ1DKBE7y0iOmh3TZVKnTMQH+0Q7Gx6Hw6tLETjjtaippDha1pMkAD
	e7DbP2ItDGz5UkSxgdZWViEGqi51fR400gR2531kJqp69KyxpCa03AaFE8BMPhrprM4uCF99+5Z
	GFdV6mg4+pLldiiPm4dFICTPjIwE1BvmWXtbtgnRjLZAXuFvHdMlYg1iW1uiyPPJeOeg6lcqDv5
	VXofuC4P8OsfaQWGOY/s/lbvnQC4stWvP7CRZ50=
X-Google-Smtp-Source: AGHT+IHjK3hP31FEJs0xRiIcZ3+FrR4LQgY/O9Gvne8cgG7pm6UE0EJSJTkpkn0siX+MVS9SbnOPYQ==
X-Received: by 2002:a05:620a:8005:b0:7b6:91a4:845b with SMTP id af79cd13be357-7b9ba72e2a6mr12190506585a.15.1736275115608;
        Tue, 07 Jan 2025 10:38:35 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2df858sm1614472985a.45.2025.01.07.10.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 10:38:35 -0800 (PST)
Date: Tue, 7 Jan 2025 13:38:33 -0500
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
Subject: Re: [PATCH v1 10/29] cxl/region: Add function to find a port's
 switch decoder by range
Message-ID: <Z310qYmGmGqqhY53@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-11-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-11-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:09:56PM +0100, Robert Richter wrote:
> Factor out code to find the switch decoder of a port for a specific
> address range. Reuse the code to search a root decoder, create the
> function cxl_port_find_switch_decoder() and rework
> match_root_decoder_by_range() to be usable for switch decoders too.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 43 +++++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 18 deletions(-)
... snip ...
>  
> -	cxlrd_dev = device_find_child(&iter->dev, hpa,
> -				      match_root_decoder_by_range);
> -	if (!cxlrd_dev) {
> +	cxld = cxl_port_find_switch_decoder(iter, hpa);
> +	if (!cxld) {

Are there scenarios where this would return a different decoder than
previously? For example, is there an assumption that root decoders
will be search first, as opposed to intermediate decoders?

The match function was changed to check is_switch_decoder from
is_root_decoder, i'm just worried about the case where we might have
multiple decoders in the path and the switch decoder is hit first -
resulting in the wrong decoder returned.

~Gregory
