Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673C738F82
	for <linux-cxl@vger.kernel.org>; Wed,  5 Feb 2025 19:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738783021; cv=none; b=MV9YavvqKaBAVkWSTEWsl9YVNZEcka6w6tBPYgpsDPdAL2pX+A7KptfdCXC3u1Y/JZKoDt2UMpjQe+CXMeLnj0oIuNJjQwPtzqnfnUsltrePTPWSgTnf/H5j97r7O9Rx50nmiKiAbxGOjtcaHxjn2qB+iEnVxu2KzZN/T8eNliQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738783021; c=relaxed/simple;
	bh=mD7XWDvuIrkysisDXIVc/LntT2RD6K7r7e4lNQkKiXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4i2c0VAF0ZWq/yKQVyt1dLACFMGc2JVSPAxmcpuvgZeYr2+3BjK5hYeINlpHhWDIsnW7stS1vR+lfmDiAHSfznYxv6X26ASJvS5KKgXz+X1aCUq5UtbewA4jrErPTwi9JefpAeiSuOYgF3WpUz8MNgZwf6f1rLgqqBk9kg+nLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=N4SOe/e9; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="N4SOe/e9"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-46e28597955so1893661cf.0
        for <linux-cxl@vger.kernel.org>; Wed, 05 Feb 2025 11:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738783017; x=1739387817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AyF22ck5wlRe12OagalfFv2Yzfm1UdTCcLrkvea++OY=;
        b=N4SOe/e9hKiJVKHbXzBtbVEFmpqqnzkAg7NMFRkHhES68d5jTKmOqZ6iSP+LWDx0K4
         PYRWpkGSLPu/gHfhfjll1jA+asQswBipplKHGq54G7+0En5dgpzpBTDSP0oJbvbpvKdF
         z6j7mtQnUmHlZ2LyHWeEjcn640fdXhgbX34N1xHV3Bz586nMVB3de63Y5mKhMnsLNoIa
         8OSGvovPXrjdhOlxn9gIpxcqMcNkbwERx0pkkP5ZVGeg4d4W7Qf97dycQndhFWlOIXow
         ZBxJjoDR52E8CHmvnpsP29D0Y+iG98IpNsZOzJ4/PvD/iOtO3tihCmJx5FEBTNkyoL7d
         E7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738783017; x=1739387817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyF22ck5wlRe12OagalfFv2Yzfm1UdTCcLrkvea++OY=;
        b=V44GnqlzFVHiy1O3zfU1d23k/jT//Cy4I/6yGzJu39F9xW+ftV/ST/xMnH3ipzvMGa
         sdG7NUqYiBdF+Fn5AYBJpLaQY91F0CeCGwdHypmJp13XpHnQ82R82WU44iltBuy8GiuL
         QGd6vaVnZTokU7K2uDjq9lXIxT5EQpR/aRh44d/d6aFNw+f4HYw3qD2MjrcZJc5WLzbw
         e4e8sh6+oZ7DJH5HyLiQvhl/xYb66t183HiAGqtpNJ44AfvVp5bflr6ihrRm8SEuFczc
         rm7J+3mlD5yVzyg8trHYMLy3Z/fYna+Oke0JzjeSd2pCFF68+Zjjk2rKbWmswRutA16C
         pYLA==
X-Forwarded-Encrypted: i=1; AJvYcCXwZbiAFf4ocNq7VV8sQT7FRABBX0OKY2kZKPV2fgs+oH4EvMbde+0OQ0XTtnNs0oRWsjfQPeEeq+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzahErRvlnKqV3NfWDCn2hqa0Fj9MUiUYn5JesFLLm24VQ+Pl0W
	s9cinAlyeXj6Rfh7vriR9Zh1BmgKM8LwDQMMPF7uF0CFgQeh3FxzoZJ4la6j1hQ=
X-Gm-Gg: ASbGncsn+SfHFbAssEvRxQtD6BEA3+e2eQnTEJdLzF917azXibzcLSDLJhSsf8tqsjJ
	ivA0d8Yj5if0V7EbYADbMkhDnkZgtapR3lWSzFTxG+g43jUjuV5AGSr0v8QaIPw/tCVRjkRM4Bl
	I7WvQelXsUFL9kx0ev6OFJbzQv00nj8LsDdljjAiWPdjLa7aKI2FOtTw3MIJoYGTYF6L9nA7FNY
	LrLzO/lrNrJThIDYEi5UxTkXZy8sF6Ok1VNHCfVrqVCY3DABaP2IUv2vZ/lS46vD9whRZfxqO5N
	rtUVEEr8a95KB/9kiU6Vu7lzjsZa/0IOiS1uiSh/Zz8MExOpXqijPhPhwnLJn5FNVAw/B7/eCA=
	=
X-Google-Smtp-Source: AGHT+IGT+yTwoj6CP/vGkbljNLoLAl7MggI/BIq25DtBgr/RTTH+LQZsYYwhHhuY7OgWFev0tmt1Nw==
X-Received: by 2002:a05:622a:1826:b0:46c:7651:158c with SMTP id d75a77b69052e-470282f1ee9mr41819711cf.48.1738783017294;
        Wed, 05 Feb 2025 11:16:57 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf189497sm73560951cf.73.2025.02.05.11.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 11:16:56 -0800 (PST)
Date: Wed, 5 Feb 2025 14:16:54 -0500
From: Gregory Price <gourry@gourry.net>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v6 2/6] efi/cper, cxl: Make definitions and structures
 global
Message-ID: <Z6O5JqL30lFr4S8Q@gourry-fedora-PF4VCD3F>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-3-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123084421.127697-3-Smita.KoralahalliChannabasappa@amd.com>

On Thu, Jan 23, 2025 at 08:44:17AM +0000, Smita Koralahalli wrote:
> In preparation to add tracepoint support, move protocol error UUID
> definition to a common location, Also, make struct CXL RAS capability,
> cxl_cper_sec_prot_err and CPER validation flags global for use across
> different modules.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reveiwed-by: Gregory Price <gourry@gourry.net>

