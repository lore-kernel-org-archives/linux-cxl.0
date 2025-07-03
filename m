Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B89298CC5
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751571628; cv=none; b=p9gDD4P8tFK2g1ZbcnHLZc+kG33VicYSUsHlDw8zqe2Wxa5BFhl/VY7FXeDdCgyXZuhx+tyloYhYivvIJ+Vr7S53IhA4/5F0QDlY2R1YwVCPJV/yYsOg4vVsLX70GIpvOXZV1ou8yUEWaymFEY1c8zs32uETDc0GwtzXO2dcYrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751571628; c=relaxed/simple;
	bh=wjAihhlgIFoKBph/30BdSuaRV45zLLu2FTAyTGC63U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iubTAWY3+jY3KG5lbrtcKbrRArNQEHlNhRrDBmEadY7vqG2e9HJO+DaoYm/0wpPsh88n1AxNEB5rQ0q0t2Rww63shYbqK60hidwAHi2SV2LLjl4q3yOU8XMS5/a+KNDB6NnmmodsBpDqzXOD+iu18LPwO3Tm1J/g4lhXaCE09Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=tIwK+dhj; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="tIwK+dhj"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a752944794so2329351cf.3
        for <linux-cxl@vger.kernel.org>; Thu, 03 Jul 2025 12:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1751571624; x=1752176424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5JiRVjpCDIQ2FImaZDAlexoOFjZvW0CINutA6RTJCI=;
        b=tIwK+dhjNysjyhsEaEO+QTBWm9yc/pmUIcdB5wWstIq0vtM6QzFiINXLWi5BD2ZsjY
         PuYwFGL/Rg7b38rDWLx1dTyX4fiPz4OLv7lZ5pnTcKG+aLjnjhcwvtCnyi/51ES7/7KK
         KT6ol/9XNPXtm1Ue6nk1zb82RiQxknwW9eSYFEk0vHxTKTaMD1AEBYTtir+5kEyrieCm
         SRdo+gPGK5hNQzI5PPrsncNDUNoH9uIc3s/9vUhOYk1wku/dQ3i9yobIeiCwab8kvPIp
         TeGeHYt3uiG9MhSHFpl+QYEhP4Wb1TbvC8NahY5AAvwvos/oQPzam1kTrsvEzbQMPwLn
         oUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751571624; x=1752176424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5JiRVjpCDIQ2FImaZDAlexoOFjZvW0CINutA6RTJCI=;
        b=IXZVQbvWMhOH+bUcxoSEK9ZIyEghW7TAqczFVncPEhhKTiISn7s+037tffFVjKQKzs
         9cxehmgz0Am4oRRA0Es/KRPpo1fRWhM+3dYB0jscC1WhC/30fTCv1IMmWsaBVLBPLUTu
         Yvkj6s0JF3xoBxv/p50gx+xljUkvgd8jZE1ujkj/XRtHD1J9tcLL2TEuxR95MOM+/+WK
         ugvlp9fadmoCVSDGXlbiVxBSQ21GqbK2T9zXAHWjINpYrmRi/V7ZHubRZ5zwoDVFicBD
         ACbWpY1tT36Cbm7Ok5jI6FRKH+rJpQdI7qeUSq3yXOR+MVCmM2RIdm0Cjn8jC1RutiSM
         083Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4GQRpj2Gt1/sa2BKrutp9eeqBOK30mpm3Cu6j6pzDFIR3jZNid5H2c1UzfrpwhKX7NCODvzRpLo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ/BVdbkzbtPniJLPPYj+BWWLaesdOi3Vooq/xueoEtLU/u7lX
	0OHeUPfx/DcVActqr31VuoLstAv+d1pi/7JgCPk7+gp/XjU1nAjs49dH/UW2v/JHuok=
X-Gm-Gg: ASbGnctW/0DLTlqwDzLZO+uiBd5pkNJ5qpfMax+k8Tqpm25veVnZWjSagV0Y7BzQBhG
	hSDnTeP+z9B+TWCFUqDxi/zy2ilsGJj8xJR5ja4RrK4MI21Mc5gl4V8Qu6rUZv2Sj89w2uEl+72
	I8E+vmGaj9W0sBr89ih+c6acq67yHiJJK6XvKmeQxK1UZ6VuqDw5rSm12hkcewx11sXFJkvdZw2
	vdTLZeEigixbyxMhHNox0n3uvpkspiMMmGbYLTacyBzll0qdwTk25HMRZQ262AYv+v8gXZ9ajA7
	PbbC8ShQVlEWMWOU4aWtcafb+fBPGQvaTYMnaoT78rkOU3DlVCBCQKVpmmeb3kwKdPXmzG4i76d
	lPvhvxpU27CUMx2RUTxeoBsg+KRuGWekGwqOS7eiJzQ==
X-Google-Smtp-Source: AGHT+IHtokJzW6Y7SnAkO7fHIQj00qi7TbnLaOfijw/VLKAWWQHbBebWsqlSHWpM0Ffk/Tm8g67+Iw==
X-Received: by 2002:a05:6214:dcd:b0:6f5:3cae:920f with SMTP id 6a1803df08f44-702b1b376ffmr133762066d6.27.1751571624342;
        Thu, 03 Jul 2025 12:40:24 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d5ad73sm2155396d6.92.2025.07.03.12.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 12:40:23 -0700 (PDT)
Date: Thu, 3 Jul 2025 15:40:21 -0400
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cxl: docs/driver-api/conventions resolve conflicts
 btw CFMWS, LMH, ED
Message-ID: <aGbcpac1pma1od40@gourry-fedora-PF4VCD3F>
References: <20250623152923.1048525-1-fabio.m.de.francesco@linux.intel.com>
 <aFmo18OEZGMA2HU8@gourry-fedora-PF4VCD3F>
 <c32cede0-643c-47bb-bfde-93adbcf16155@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c32cede0-643c-47bb-bfde-93adbcf16155@intel.com>

On Tue, Jul 01, 2025 at 08:23:57AM -0700, Dave Jiang wrote:
> 
> 
> On 6/23/25 12:19 PM, Gregory Price wrote:
> > On Mon, Jun 23, 2025 at 05:29:02PM +0200, Fabio M. De Francesco wrote:
> >> Add documentation on how to resolve conflicts between CXL Fixed Memory
> >> Windows, Platform Memory Holes, and Endpoint Decoders.
> >>
> >> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> > 
> > I won't block a doc update on a suggestion so
> > 
> > Reviewed-by: Gregory Price <gourry@gourry.net>
> > 
> >> +Platform Firmware (BIOS) might reserve part of physical addresses below
> >> +4 GB (e.g., the Low Memory Hole that describes PCIe memory space for MMIO
> >> +or a requirement for the greater than 8 way interleave CXL regions starting
> >> +at address 0). In that case the Window Size value cannot be anymore
> >> +constrained to the NIW * 256 MB above-mentioned rule.
> > 
> > It might be nice to have a diagram that explains this visually, as it's
> > difficult for me to understand the implications through words alone...
> 
> +1 on request for diagram to explain. We should try to document this issue as clearly as possible. Thank you.
>

At the very least, it would be nice to have an explicitly example that
explains the expected cfmws/decoder configurations that are valid but
"technically" violate the spec

I *think* this basically boils down to "CFMWS size is not aligned, but
all the decoders it targets are"?  If I understand this correctly?

> > 
> > which is likely why the conflict exists in the first place :]
> > 
> > ~Gregory
> 
