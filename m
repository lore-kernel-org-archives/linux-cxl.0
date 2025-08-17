Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D659B18B0F
	for <linux-cxl@vger.kernel.org>; Sun, 17 Aug 2025 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755453336; cv=none; b=dVoA1V2YBhseaNXgNnf49lj8JypV9NLCRfIHMgGL4J8F/RuZgCL9McgfPPfHULJGjt9znZRLOhevTuuFR4YUitiRHj3o9HGC1KQWSCaXaRIC1LzrZj2kJFW/pnCoVxff5kQSJAGiityDcfj6+NRWKZ+A6U1xKDMEi6pBZp+3atw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755453336; c=relaxed/simple;
	bh=ZX65Osj3KZd+3VMcWnHgTciqbWcOdnJj8eq+6yip750=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsJDXXNKtAoxU3ciznS34/mKztfXwEauycZXE1BeqtcfuppFCjbKxS+6hIWBZ2oaAyAQkQVlvRR3U4HDix9NVSfAJEiEBWbXZEoy5XUb+2crw+tlRvYq6TNYEA0jMxv4dYBD6VtLk4EkCMJ0xyWdwnVUkCc+qyW7wz9kXlbD3Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=o1LThcsY; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="o1LThcsY"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b109912545so37662141cf.0
        for <linux-cxl@vger.kernel.org>; Sun, 17 Aug 2025 10:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1755453334; x=1756058134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ef15y+hBWoFQAF/OeWDYMRMusZ2qkkd9+CBv2gOjP8=;
        b=o1LThcsYcTqdLu7JXhyJ0Wj95rKJBG2xc5LaXMBkhScqIVGPGztqh561yyVz015fBm
         F+BToe2KaXtglUms/VEsiRXp6jyeXWzWrN42+NKWFHO80Mevgb4zu5SYWkJGyFsewI+K
         Fg71ITR2PGREaP+apBlPz1Bco1dfK5SZeb7a1GLlQYaXfoME5cXfBVOqRKRXRk+sfWdE
         k7x/qG77acYCCjTF4oYPiA8pQOXiUqSG9hn6lXdRwAemMVSma86TqhXcT/JOVZM3xY8G
         HhmS/jEF5W8Thr9m/ka4miTp7iWBO5YatYgCLyKvOLDWxDi0JEUTNe6dsLz9IqxtYty8
         JJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755453334; x=1756058134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ef15y+hBWoFQAF/OeWDYMRMusZ2qkkd9+CBv2gOjP8=;
        b=GRqnbCYCr7D4QvwWMRg3PpcIjsZeK1P9JkLB4ENtWyuti6n2nOTQKU7uIe2rAl/jFR
         x2KpJ8sCbMO3RHXj1fdLu7pkG3b5q2enV6apJpVr0SY+8g17XYSzhnS1z89qibqI8j1V
         SAWuYwMlA7C5OYzn6rz+AZZXa0gAFYmCTsuJV5im95uTlCcxHkEUp6FQKjTBxdpy5+DC
         PLrWEvJFe0prAouqE/sVOGjGvX9d1LVU8olM96jWcrlYt+ZPArMBPOdHawljCEKqvKVN
         9xYXSfSAyf6eymz8RrVPSspSEX0PqiL9qNufOmlB67DC3xX3y/eEhumOW45rs9W3CwmC
         vXnA==
X-Forwarded-Encrypted: i=1; AJvYcCXYRiKA6MTAiLrS2m/TW/W1WQ+Ge4hbM37psddaCnCBRs3uksb/qa/MJGrZitePcxNwAMkTSoYNDBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYjZt6cSDteLf2jhJdAjZEn5Hu8223e6M5Q9MjMxoS2DKho019
	7cNPvizg90WHpX/A8qadMvQ0hERWayhOuLvhv1jwWYSJk/OU4ls38758Mn17DVfQr5w=
X-Gm-Gg: ASbGncsQAU5MLEb5XfkUF1ufnhycCWkEHkdt3c6uMsTMnvv4kEL39/TSBJG5HLpS1tZ
	urLCncbqcBFIIss0dpi2XwxnsmIiANIZQU3OI5wSAW97pNNZr0/znllpZErGSD9K3MuU7ifZ6uu
	BDxgPO+PG9661MuRJULqE/tQ4PW8YmC4qgD648Mfyhm5STTtPsi9FXlkKxqGVfkSqeLszingoZ6
	eOlOPrKrZ2l/mneWhKON3149BkWYxtTTaDUEMJiQqYf2tTptVFvaqrRYYFZ1wGGiApMCUUn+7OX
	eoCMtN+U3Q34HMmPzAp00BftTCxYxlrsJMNk/42lwECx8GbP18c39P9/UTWRopNyOGinApZv+yv
	RvK/oGsr+pTU0KJ3a6Ztj83fg5ai+YfxwAp6JhqSI9rLwXRaMOlZWSFFe
X-Google-Smtp-Source: AGHT+IGGPniltbwWGADuC89Da2QodO4Z1fNUe08TbR56jJKviW2gzde0TZQ0UAs5hoxjQJhD9PIKdw==
X-Received: by 2002:a05:622a:1f0b:b0:4b0:b36e:b151 with SMTP id d75a77b69052e-4b11e0bb988mr130888341cf.16.1755453333798;
        Sun, 17 Aug 2025 10:55:33 -0700 (PDT)
Received: from fedora (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc1aa56sm39748811cf.7.2025.08.17.10.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 10:55:33 -0700 (PDT)
Date: Sun, 17 Aug 2025 13:55:31 -0400
From: Gregory Price <gourry@gourry.net>
To: rakuram <rakuram.e96@gmail.com>
Cc: linux-doc@vger.kernel.org, dan.j.williams@intel.com, dave@stgolabs.net,
	dave.jiang@intel.com, jonathan.cameron@huawei.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	linux-cxl@vger.kernel.org, alison.schofield@intel.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org, corbet@lwn.net
Subject: Re: [PATCH v2] Documentation/driver-api: Fix typo error in cxl
Message-ID: <aKIXk8SKIMKSuGDv@fedora>
References: <20250817173355.6615-2-rakuram.e96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250817173355.6615-2-rakuram.e96@gmail.com>

On Sun, Aug 17, 2025 at 11:03:56PM +0530, rakuram wrote:
> Fixed the following typo errors
> 
> intersparsed ==> interspersed
> in Documentation/driver-api/cxl/platform/bios-and-efi.rst
> 
> ---
> Changelog:
> 
> Changes since v1:
> Dropped fix for page-allocator.rst as requested by Gregory
> 
> Suggested-by: Gregory Price <gourry@gourry.net> 
> Signed-off-by: rakuram <rakuram.e96@gmail.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
>  Documentation/driver-api/cxl/platform/bios-and-efi.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/cxl/platform/bios-and-efi.rst b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> index 645322632cc9..a9aa0ccd92af 100644
> --- a/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> +++ b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> @@ -202,7 +202,7 @@ future and such a configuration should be avoided.
>  
>  Memory Holes
>  ------------
> -If your platform includes memory holes intersparsed between your CXL memory, it
> +If your platform includes memory holes interspersed between your CXL memory, it
>  is recommended to utilize multiple decoders to cover these regions of memory,
>  rather than try to program the decoders to accept the entire range and expect
>  Linux to manage the overlap.
> -- 
> 2.43.0
> 
