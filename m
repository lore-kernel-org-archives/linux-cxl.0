Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2A8221FA0
	for <linux-cxl@vger.kernel.org>; Mon,  6 Oct 2025 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759770416; cv=none; b=UEpmCNiFUL1siaQgTijN1ygTvrmfiiOMLIRlKRPWEWTdRCfFUO3VzIUJRHU7XvlPFQyDsd73L5/5nuVnC6nA9IadIhvc/4H1VC2kiQCFypsr4L0U/eUTdmnXm990UqbngiiHCqWsHJ/wXcRTjzKTskCIFsXhWDDXx6U4NPsBCBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759770416; c=relaxed/simple;
	bh=i2EkJ/x08v/kmNFdCKaOvysl2VoRkIydM+svs0676Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRpgd+toV65llPhVL2TjzhODnjFAEMBjbEvW3CwIDx1wOdP/kkO0OLuErvY8BM0Ef3X0FLyVVOPFYUOmtIKdLqwhUe0inmAKtIJlf+GaiTChIkjxQGwFrmPaWx3bBmx9141xuEgieSVVx+xlWYjI2mvZzeo+TOXBM41VTQm6li0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=o2D3HwRx; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="o2D3HwRx"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-78f75b0a058so53901306d6.0
        for <linux-cxl@vger.kernel.org>; Mon, 06 Oct 2025 10:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1759770413; x=1760375213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QgG7Kj7F8Fvf8QdLk2gzxRzLGx7bPBlhHTO5oE1aqE0=;
        b=o2D3HwRxacVbEpskCXv9LRuXjXX7derKEUWKhYiVbIdz4rBqfUJbyQNPW3SwD3/9a5
         B8g5RDgTScRJjzYEYgXo2+n3bb2M+5GiUOiRUNU8Vs72Zh2Q/TCWTVlKh4QObme3kzDy
         ve1gSaQTK1ykGwlMEcEfIsk2kXUTUN3LqNbFl9C2ZjylkwlvNqlaf6FfwdMewDp4Ly4O
         toNdelTzjbL24MOljqWKDAmIzfODLP6TPk+MJrSeNuS/aRWOQQew1GgYfuEbAK/+N16m
         cSTcOSGXcmUbg0jqc7OAWKnGmYZ+PG8ilAD/HfPK6pPqqSFSqh3CjKS9Auja4T44ER5m
         r48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759770413; x=1760375213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgG7Kj7F8Fvf8QdLk2gzxRzLGx7bPBlhHTO5oE1aqE0=;
        b=hon8D4ZYXAC1m3rJ7zDsFmWjPl1+AunRHAmLuCERocwD4wN+Nr70tDPx8w64uqcV1e
         YJSMKup2u3olwJbwYpNfw47C3KoIzULwuUucJIa3Wbv+HDIBJB92vYYR1kRrWDwI6Fl7
         wUEHEtkI95rPdMKkQyc5WfdGzkoJ6Ns5Tun/2rc264C0E8N5E8+cxiNpV9kRQDgbQtQ/
         ckU+kmg0MTljSEicwrsp8zVsgQswobMnf+JLe8Yd9LpQ8sIOZjPQXNV5mbCE78yxB+8U
         VqYqykXPwejkaQsidriahdRaPU5/6HUf1Q6MtYrJZjcHdNJmJG+1+v9ir1CirZWPCuh9
         lY1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVi8o5lbBfs/HPCTpO6jvAbHpuZFoG4imBLuF+2KXxVR8gwNVwgrsRWod987UU2WNSiLxQB5wqrtw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvY/WG+yo7nO0/mKhmqshFoEF9b+pXd0seLCq5hfV9qduK0+lc
	tCogCXUFbh3HzdASzKTuB+8iTWII7YH+X/wq+A/pY/8Pb3D46KI1hcL+Rs/7xV80e3E=
X-Gm-Gg: ASbGnctYgI8NPJQMA/7nkuT0znUxy/qNn/YGhu/8gwWMJL8+kpJRLbNHFOZu7D0KLxB
	1aimLoSl0pYVKcb31qFw9Xe//oDheyT4Nk2ECkspgCW87ZZZ1oy8275LhqUNvzSIVOyoZVVHtHB
	OhC5rd1YmJ31wHjFkFWNGIvcGak+WJX225IaomdHKeo2jGQ22r7lJWg0dE7oMXImr0w40OpxrUv
	QSirW/KNPVQb2lf0DKeMtEyG84QYSl9jH6KPfXOGVRNaC6h4Et+DMSRl3py6xDWdUv3PekUN41n
	HirRGuObXk7+9oI9XIplyJx4IJW9kFt5lDqlFfep43PMttkpV9O8IEm5GEhQMK3P+wRpx0P2eBr
	cbCP/m9eTyLUA5uaj7pDg7JG+nRLXlUB2LxSvKwna9xcTq2vY8FvsdxpYQn3GaM3K4cc3ZCjcBW
	mh3iJuuno0pBXH163Ej6SMm2xYIbD70PHqSM6ZNn5+
X-Google-Smtp-Source: AGHT+IG4ZEw+VCFdNsTXOlMFhE8o6tJ1XiGtSukmRId1ODIYJZ+HVRAvZr4LoRCUnsgOjWfcW+1egg==
X-Received: by 2002:a05:6214:2524:b0:782:a877:bbd1 with SMTP id 6a1803df08f44-879dc856462mr164109016d6.48.1759770412800;
        Mon, 06 Oct 2025 10:06:52 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bb4465cesm123440686d6.17.2025.10.06.10.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 10:06:52 -0700 (PDT)
Date: Mon, 6 Oct 2025 13:06:50 -0400
From: Gregory Price <gourry@gourry.net>
To: Vishal Aslot <vaslot@nvidia.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Li Ming <ming.li@zohomail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Zijun Hu <zijun.hu@oss.qualcomm.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders
Message-ID: <aOP3Kr3jHLWOydRp@gourry-fedora-PF4VCD3F>
References: <SN7PR12MB81316C958DF0F4B10369B928BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <aN4SSEmaCaxbeiwJ@gourry-fedora-PF4VCD3F>
 <02a4b5f1-ad29-4825-9040-ff96e328f674@intel.com>
 <SN7PR12MB8131EE31375531673BCF0C62BBE4A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <aN_cUPzzwUy-s36n@gourry-fedora-PF4VCD3F>
 <SN7PR12MB8131CDE3909B30FCE3E24B6BBBE5A@SN7PR12MB8131.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB8131CDE3909B30FCE3E24B6BBBE5A@SN7PR12MB8131.namprd12.prod.outlook.com>

On Sat, Oct 04, 2025 at 01:49:26PM +0000, Vishal Aslot wrote:
> >>
> >
> > Ahhh, so are you saying that you will only ever observe the following
> > (as an example)
> >
> > endpoint decoders...
> > decoder2.0   ->  available and can be programmed
> > decoder2.1   ->  size=0, locked
> > ...
> > decoder2.N   ->  size=0, locked
> >
> > or are you suggesting the following is valid:
> >
> > decoder2.0   ->  size=0, locked
> > decoder2.1   ->  available and can be programmed
> > ...
> > decoder2.N   ->  available and can be programmed
> >
> > ~Gregory
> 
> The first case is what we've got. In our case, the HB has 4 decoders. The end point (a Montage card with single port) has two decoders. For both, we commit & lock all decoders and all decoders except decoder<port>.0 are zero-sized.

If the second case is not supported (I don't think it is), then it's
worth spelling this out.

I don't think either of these cases are relevant for scenarios outside
of the scenario where the host pre-configures the decoders either -
worth spelling that out as well.

Just in the commit log.

~Gregory
