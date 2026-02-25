Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EE2392820
	for <linux-cxl@vger.kernel.org>; Wed, 25 Feb 2026 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772034211; cv=none; b=F1t69cuTe88v1h7r9fs3EDHZoUlDx6nUFWQ3/aFl2xcIVNtnkID61v/tq/XUD1oo3clMYEY8wJ0k1fCUKF7IHSmZfn6NYmKZOPnj4bz2B+YIK2MSg2iWx5pXxuNiVOsv2dLS+eDbDkGI/nzYSLAptG9Oi867ip4FSbiHQUXlPOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772034211; c=relaxed/simple;
	bh=qVSkvXTU05UH+6UYx55K39nxiYnBsYPeq1WiWh+qnss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nsb3ZY75Gu7HpQ54bqq3OAyvvo7u6Tckc+wm/7zZkQoqeuLgvbyJk+FT4CO1awiukFGUq5styplm94erdNnyAS16gFAX9EOUL4kNJqvD3hfqk+h7Dzt/M+a44mftQUL2/ZwUK8swvxTXlr5XFbR2cfaxLAXsrcpjv9L9n+H9CNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=n8POJOik; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="n8POJOik"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cb7edbcde6so680025985a.3
        for <linux-cxl@vger.kernel.org>; Wed, 25 Feb 2026 07:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772034208; x=1772639008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DUwa8tR8E0KPFybUVUr07Z6iITbFwdIHlbvx4HS3wyE=;
        b=n8POJOikgJQGJY27wkUk9lo3EHd1qaZ4AKtm7u4vd2x56xsjsKrHFTckyBNBLIzUfY
         dtSjQfo/ymRohabCqMpuZdA+lUAAJ8j9KB0cW/b1wHBUmkrGZNO2XB9waB5PJ6HLF/sN
         2OnIy+QAGysdy3Yhn/RhbUyxWTJ8RxTRvZwf9Gitwymj3I+xcCmwOHfKy7Ta70H//lXA
         BZq3dfi2AcSpkoSlvCtRJdxAD72noFgEExG/VBie08/WSXBqLzexkw7caDBeeIOpsn00
         ngxr7pTuMwmK+HN/szllNNG8kr3Wj5ZmClK4bNIOxiyL+I5FTs5letpX7dt2dTpggOjc
         gUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772034208; x=1772639008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUwa8tR8E0KPFybUVUr07Z6iITbFwdIHlbvx4HS3wyE=;
        b=Sez9gRcKCdAl1sKlcstnhjW5aWAeLyyCu2WMCPTWtyenRYfNcWj6/gNa0DFs8EtuU3
         fd6928FbSooGBmTkoHQFOhsqCk0o7pkysn08/qIANYts9Uiw7osMI8613NHa7blcm/Cj
         z20gnxU6XRhAoXpWbnzPrYg7oRWA/DOc1HZGcGoTAqwsX59EshUfKifUo/j9fKcYFZwX
         lzBIrGak68lSkomesEt0n0hHeNvaLlR+lly7MsoSnayuIZU8XOKV9gfJxKjAUK+PLnol
         I3Ar9vq/bquvufSkKuHkWtxJo2wpCw+5JuKnU0f66M5aHI3kJ+y25W/Rcuqm6KuMvMU1
         r+0A==
X-Gm-Message-State: AOJu0YyiFcGcMP8oR0sWYZuz3rPvZ157e27UYxuX7wHeybJEa27hq1rg
	d21JhO02hWL/rP/323YekZqk0qVuprfSX7Ie7gN0lB24SSEUv5ijOu4Mwt5PEsycgaFL23pVBWo
	nM6pf
X-Gm-Gg: ATEYQzzG7OQtxhrUzxDAr+6/ykvjKZzb1VHhnNT29LASi7C0QyDXW9rmNiR6pFwJJiw
	WsaIhLFk9E/s030iDX2p7+nZFXeQtWvEuwdcnTaEE89b7JkqB39ZpLoJYM3oZN/+QI0sNocafC0
	GJQbb3NZ92XRjmKNItLA5cy/qXx5Z6vSU8LTshxGP7uLhGNAc5V69A++oTH+ZLzXACYLzD4pL+Z
	FKFMSwxDpchWDkZeRIZ9HSB10P2N3SoNFeTYGvnShs892qLxAoa9+x1gxdhwqtz+Uwzqnbf2Oik
	+m8xNIes96D5sj9P16IknRdNi7QzpDeRvmpix5L102vyyTddOC+F76NaipkrJB6Rlp/6AVM7clT
	7SRwM4tDq9ymk69dJBu1/K0FxKmZVbufGfJpHaUuwrE39yaGJ3d5d3uWWJHXz9/dSz3vLD/cT4V
	vVD/gco1ozLbF9lNwaLr+BGTXIzQvjZ29NJW+aV45ki4Qu9dQVqD1l/Q0UVb4/Rr/HEARvlnICQ
	lQ+nwuxcc9oq30/zsuT
X-Received: by 2002:a05:620a:4542:b0:8ca:d5cb:6841 with SMTP id af79cd13be357-8cb8ca6751emr1901239085a.49.1772034208330;
        Wed, 25 Feb 2026 07:43:28 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e637200sm125330486d6.44.2026.02.25.07.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 07:43:28 -0800 (PST)
Date: Wed, 25 Feb 2026 10:43:26 -0500
From: Gregory Price <gourry@gourry.net>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>,
	Alison Schofield <alison.schofield@intel.com>
Subject: Re: [PATCH v2 1/3] cxl: support Type2 when initializing cxl_dev_state
Message-ID: <aZ8Ynok74P7QyDNU@gourry-fedora-PF4VCD3F>
References: <20260225121430.3839189-1-alejandro.lucero-palau@amd.com>
 <20260225121430.3839189-2-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225121430.3839189-2-alejandro.lucero-palau@amd.com>

On Wed, Feb 25, 2026 at 12:14:28PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 

Just some nits

Reviewed-by: Gregory Price <gourry@gourry.net>

> In preparation for type2 drivers add function and macro for
> differentiating CXL memory expanders (type 3) from CXL device
> accelerators (type 2) helping accel drivers to embed cxl_dev_state
> inside a private struct.
> 
> Update type3 driver for using this same initialization.
> 

I think this generalizes to just

   helping drivers built from public headers to embed
   cxl_dev_state inside a private struct.

Obviously the immediate use-case is type2.

... snip ...

> +/**
> + * cxl_dev_state_create - safely create and cast a cxl dev state embedded in a
> + * driver specific struct.

... snip ...

> + * Introduced for Type2 driver support.

      ^^^ I don't think this comment is needed

~Gregory
