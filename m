Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058B722E400
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jan 2025 02:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736907822; cv=none; b=tPIqsXT80YmNT9W72sce00aA4kHYOV8quRflEa4c3my9D1CVdASg6v2zGo3U4qVoXNF+TRHfhCF50c7FVruK41CFO6orjoSuo6p+Q6BqWn9VDaimeIsk70r1drm5ZzfBK0/aNBhlIhcCnV0wgjRG3KtYl+C0KYTj5qUJhZastno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736907822; c=relaxed/simple;
	bh=o/P5O0ePktq8VUtCRPX3dltyt6nu7IWQDbM6nRTtctE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGlpM2WY/yfNJ9oosF9Xj25ZOujcaMj/SGapai2NY/3ozrRzcCIr9BQBzsHfgI8fBkZcb+bBKkaeQr5o10YFVF8XD2iSbDTlSXhjnk6G+84QeaXjf4CYSuO4QnAHIF++NwAIaVWhHoqL8Mu+mHzusw3JqJtqGlqsXfyWj3vLd1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=uE0kB0Bj; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="uE0kB0Bj"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46788c32a69so76486041cf.2
        for <linux-cxl@vger.kernel.org>; Tue, 14 Jan 2025 18:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736907820; x=1737512620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=peWTTYrtZ7J6rEfihyYy+2RDFnwMGAeDvIy5UrD7uQI=;
        b=uE0kB0Bj0hGelOvIyMjEUNE4xmx+v1sQEiHYXn7gwJcwkZe6+nNslvrOPiudwK4SmA
         CddYwZibgUzL0Fguw1DpFJjXry/lAYPXApQuooK0weYRa8l1PDff8VnMcEEgg4tM+5Cj
         xEAQXRKO0Mz3JGB22v2De1PpC1O+VrI7+S9TFPgO/l22UpbfmTtWIw3dy0macE18Bmmt
         Y5pfKR1eQUpyuA6/fsTRefJzkXqfziQ89rkSLAUo3RpWrH0EmB+jSNy2QSCZKSPoHHbe
         AIasGcXktfATvxNcZn3AyJSdhfXIbvsjkiqU0U60/sh5mEvjdl8waPYLg/gAxmMJYSMH
         dh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736907820; x=1737512620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peWTTYrtZ7J6rEfihyYy+2RDFnwMGAeDvIy5UrD7uQI=;
        b=f13xRc5rUNm8t38ydfeP116mCML6CRDCkeXkvc/BZv18CVVoA4Km1kAvGhvvmBA/FM
         onRN8ISzVjinPG5b7mnAWTpxCT2q06dxwe2P0qeoWIdxaLIn77GBUTONG2O5/ncZI40i
         EwdPJ7lqLfSeaMLaHP8DUXb7+dyg4Skt0KUkDFViSyP1VZPA9jLwReI1gjux9HW/nxeN
         nE5EpbK4u8S+UTy06l1Pm5qBvYf2CRoaMNShWP+8n/V9WwPdobjPBg2Ek3+CcS02mkvC
         ZPOMWxz/jImdA2n6KCN9Oxq/p/VvsuEoGaoZJasQI3UlmPSm7H4u/7A4yRR4I6OVJVPi
         xDLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8WEnpaplJhN3rgNesZ4Zfs7WaYpxZDSZtK24RAcSz3XmdlyBnJL01Bo5EkWUMVPiQYk2xztGNWRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlGrfft8dpgkdgR4qhIWmsbt1qR0rgDspok4Usdxr0HdDmL515
	4nX8w+42Atrrq376tr0x5zpj0XtNOOitRBq81JDMkBFtUCPy5Qgzwfo14EpRm+dGQcmSd9iW+hD
	R
X-Gm-Gg: ASbGnctza2tJvM+Wo16WN1nPmWXsjWF3nNHM3I8SCnKpAF0oHirN0quWBNWTNTM/YSw
	G/cCHINNo27myJN0JN1ru4UtYfIJmcvltmxTTDeC72hoQzMy9Xsxqqgc+Rba+bdODHG4ENP0q6x
	SfW2BB1vh+QFGPswl3p23YuVM/vmcBUcYcsscwDUY4sJjSlRNVJRGw/2AmCF10YVi41NTXquHd2
	rWGGmAWt+RVs0Iz4nJn0MGJxIpC9dowZj79n+v7EQrZBG3XxxFOqEz8u3PSFCkIxl5AqTdUFu/6
	QkpSWahZGz7pZPzu9nSlToTA9+4WSj8BHZfj7xo=
X-Google-Smtp-Source: AGHT+IFyAtiDuay7n/TNXk4xGFEnbFli7K8y/fsUcIy3MBXe0aPAer6QiqYaIaBstZCBK0bISZitEw==
X-Received: by 2002:a05:622a:34c:b0:466:8c53:7758 with SMTP id d75a77b69052e-46c70fd31b0mr423868141cf.5.1736907819935;
        Tue, 14 Jan 2025 18:23:39 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c873216d0sm59635911cf.12.2025.01.14.18.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 18:23:39 -0800 (PST)
Date: Tue, 14 Jan 2025 21:23:36 -0500
From: Gregory Price <gourry@gourry.net>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Robert Richter <rrichter@amd.com>, ming.li@zohomail.com,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/4 v2] cxl/core: Add helpers to detect Low memory Holes
 on x86
Message-ID: <Z4ccKD9Fc-Egc6EL@gourry-fedora-PF4VCD3F>
References: <20250114203432.31861-1-fabio.m.de.francesco@linux.intel.com>
 <20250114203432.31861-3-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114203432.31861-3-fabio.m.de.francesco@linux.intel.com>

On Tue, Jan 14, 2025 at 09:32:54PM +0100, Fabio M. De Francesco wrote:
> +/*
> + * Match CXL Root and Endpoint Decoders by comparing SPA and HPA ranges.
> + *
> + * On x86, CFMWS ranges never intersect memory holes while endpoint decoders
> + * HPA range sizes are always guaranteed aligned to NIW * 256MB; therefore,
> + * the given endpoint decoder HPA range size is always expected aligned and
> + * also larger than that of the matching root decoder. If there are LMH's,
> + * the root decoder range end is always less than SZ_4G.
> + */

Is there any reason to limit this memory-hole handling to only low
memory holes? I have observed systems where the following memory
hole situation occurs:

(example, not exact sizes)
CFMW1:   [  0xc0000000 - 0xdfffffff  ] 512MB range
Reserved [  0xe0000000 - 0xffffffff  ] 512MB range
CFMW2:   [ 0x100000000 - 0x15fffffff ] 1.5GB range

2 CXL Memory Devices w/ 1GB capacity each (again, an example).

Note that 1 device has its capacity split across the hole, but
if the devices are interleaved then both devices have their capacity
split across the hole.

It seems with some mild modification, this patch set could be
re-used to handle this memory hole scenario as well
(w/ addr translation - Robert's patch set)

Is there a reason not to handle more than just LMH's in this set?

(I may try to hack this up on my test system and report back.)

~Gregory
