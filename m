Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FDC2512EE
	for <linux-cxl@vger.kernel.org>; Tue, 25 Nov 2025 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764078906; cv=none; b=a0VzCS2SQufoo7P2b8sEkcuDINyucetDC87yTE+uNQfO3l8u8lenZivHMkSBC5QtCWHTIOtZgGMWoqMupRJyVwipJIIHDDbVQmeSd24/6hG6igenHfclvCbfVlG9AKh5mrothTV2EPsEkRVKzlyDXxAwBNQmLNbXW+y1P2LJ6ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764078906; c=relaxed/simple;
	bh=9cdDbADaV+G9ohLC6r88tq7oW1kjh+5VpyuQIt9brqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKfh5LOz/sNqaORmezitSIGtBL14VxECz8hK2dMuLpdsnpHEgrmA85s5YqqO7eq20Vg798c0GgpATgKFsTNh8cLj2bS8mf0wgKQgiPAqaTANaDqI+u7RNHk0dLXOIyVpPE5gv0QcYCNuTVtoVf2p3oU/INE9TwGff/J6wQ3oYGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=pgxN/Hky; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="pgxN/Hky"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b144ec3aa8so545011785a.2
        for <linux-cxl@vger.kernel.org>; Tue, 25 Nov 2025 05:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1764078903; x=1764683703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BN0Gd9FIr+nCWCDMfR+V4cuqmnLr3RwYOCmv9D7V0q0=;
        b=pgxN/Hky6yFaO6c92cxygrwsGitFlxGbZo4w2l1vJOYac11hp+trjrSQaFq6Gso4ly
         EM7qpaOVLCMx3S1yZw0nkH/pcci+clHaiOO16Q4V0s6Tdrw4CbK4cuCQnCoh5CaPm/Lz
         jv7P1ZBd1KuT8LIpxUMEHqSrLOsh9vraHMqC3W2lcyBzZzf40W7XgtE4gtx40mlHlgLM
         bpHa6h6FaulHms2vk/suJkcBqzKusqd0b9b2MDUAIZO91GM/FOcOORu3/uV8/ZUqRFRX
         VAaUpqawOx8oH28+YPCMv+nt8DHPCN4yYtIrjx6kdpFgWKEr/V9xG7s2Fr4HQks7rnHC
         rOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764078903; x=1764683703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BN0Gd9FIr+nCWCDMfR+V4cuqmnLr3RwYOCmv9D7V0q0=;
        b=w7YCIb26i3Cv+j16vLw+QrAMqFr/FLHzz21o70drdmIlyNH5bpKQFa+17jRoI+MY4Y
         p33Tr8jR6X2VyoRlby6ofEYaHVwCQpQUwUE+CpM954BhU2w6PGCT4vH+0OdMLE9VMKgz
         CBC2zcgZh2FC+0X1/svtErbQRdpbEeEpfUoY9xNMm8x5ewWl94MOWvJbo9S/2mPW/6+w
         43p8oXzR/EMJfSABSb50wAcH7cWNvEJgKF8waLwdmoRwetaq+7sUuvDj/wF3tlGDY2+n
         F9VEGY6pDDO5KixkSCeDlzYg9TEqk49aMtPeGyOx1GFbg3zJFoELEZCVND6qbZ6nBFJH
         1E/g==
X-Forwarded-Encrypted: i=1; AJvYcCXpB+Sw8IUeIaiQpDVLbsbavrZeKx7IaQtU5hYOp3fNq+ahWIpvCF3Cmn8xlOoRbWKI7miYbMOoSLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm3nhgiYl0I1mIg1rRUUht5OqY6FG3RbiTyjpoCIr1hxui0XyX
	50FpybbO/61JDw07366XYRfFX3dRmHLCktmh/0GqLc9Vpz2q9bRmOVKrnf3/TA7cPZg=
X-Gm-Gg: ASbGncvDapORX617TqnmxNBfbqSVx1wtLdpXrB1pMNeTh3K7fnN5VdJ0mQehOdeelQ+
	Rr2mTiBPy2u6zI5CsNyvH/B+7K4URi6Hh9Ryj7xDJrEgPS/0FxWa+PYdd++2Qlo6l/hESpL0sss
	zEV1997pYDEavBwLnHAF3rXOBLB4w1Wfl42Bnl86yRWTnuYZzMv/uQj48rtxr4zSNw0kLjBot9z
	RWnQzaaavqmZksM4+T1LSPj94ieN7mlvTLlpdXkSUM+8UpT6SYkp5gn+wIYU6REa2J/0wxSKuh0
	F27OywI+7FeHr/Shm0p3wGiF74dfJYYcUryxGPB0yVtThE4q3HA36EHExQTbRG3xUWBFzCMTs2L
	vHTKHl+lMIU85pKamt2lyLUQyPIUO2+aMr0ILO4k+b3kziuprfDFrydU9EOQtqijVKxAageBWD4
	w7DLQXbOkslFP71AJtLWs18WvPkATVb9Hc1eMIRLrCddCV7XBYiCXzK5451pPmKBo1jEN+Ug==
X-Google-Smtp-Source: AGHT+IFx3qYvfMeNQjPsq0h3FXby92i43IYo4538aKMep94Ks7M8pwR0PaaNTSu6rKB1+FH0hRPYfg==
X-Received: by 2002:a05:620a:294a:b0:8b2:5cdd:6a16 with SMTP id af79cd13be357-8b33d4823efmr2004079685a.82.1764078901111;
        Tue, 25 Nov 2025 05:55:01 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b329431939sm1147831285a.18.2025.11.25.05.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 05:55:00 -0800 (PST)
Date: Tue, 25 Nov 2025 08:54:58 -0500
From: Gregory Price <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Robert Richter <rrichter@amd.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v6 00/11] cxl: ACPI PRM Address Translation Support and
 AMD Zen5 enablement
Message-ID: <aSW1MlUSs2jjdVjO@gourry-fedora-PF4VCD3F>
References: <20251114004021.1310661-1-rrichter@amd.com>
 <aReKmdOeHBBDWMuC@aschofie-mobl2.lan>
 <aRs4ILR8EEwnfOtQ@rric.localdomain>
 <aSOxXX7xX4jYqqvF@aschofie-mobl2.lan>
 <aSS7n40Hmiaf7ibc@gourry-fedora-PF4VCD3F>
 <aSUh-9fXFGsK_Z1_@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSUh-9fXFGsK_Z1_@aschofie-mobl2.lan>

On Mon, Nov 24, 2025 at 07:26:51PM -0800, Alison Schofield wrote:
> On Mon, Nov 24, 2025 at 03:10:07PM -0500, Gregory Price wrote:
> > 
> > IIRC the to_spa() function wouldn't be populated (will be NULL) if this
> > is the case, so you wouldn't even be able to call the translation
> > function.
> 
> The hpa_to_spa fn defined as a root decoder ops is an additional layer for
> arch's needing HPA to SPA translation. It's optional. If there is no
> hpa_to_spa fn, then it is assumed that the CXL HPA==SPA and that is the
> 'final answer'  added to the trace log.
> 
> Sounds like you are on one of these systems, so maybe you could take a
> look at what happens. If your devices support, try to inject and/or
> clear poison and see the resulting kernel trace log. There is an
> example for that here:
> https://github.com/pmem/ndctl/blob/main/test/cxl-poison.sh
> 

Servers am able to test on are @ 6.16 with cxl .17+.18 backports

I don't see: /sys/kernel/debug/cxl/$dev/${action}_poison
in my sysfs

Have enabled enabling various debug and einj options.

When were these added? Am i missing build options?

~Gregory
