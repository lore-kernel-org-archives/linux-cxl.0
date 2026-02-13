Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533DC201113
	for <linux-cxl@vger.kernel.org>; Fri, 13 Feb 2026 05:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770959995; cv=none; b=YnFu4YjUfPatFaOGjOjdWq0PA+aN2//GpU8uMiyA1cxTTQGLSfxnfCapU+8ODENEwehUngcndHysko0q0Yl2C+a4XxawNLYkfY9tq2d3lHobW3+UjfguX313bdw+vL0zgdEpv+5wHwPArKhjyMP/ouqdmcFCLr8lslytsdYnfkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770959995; c=relaxed/simple;
	bh=SYC6rhojWY+cCcZWc5g81xQ4OOuW10p/z1Xsg0feWuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Soax8o2YQy2Ag07Duj3z4t6eLO8CLdrC2C5f6L1OaUp9u9E5Q4qhDIsnQtZwS08p5WbA5P72ErLnWIPJFDImKnFh8yNgtBYfk4RY/8mzJxFn3CMjotN9cwHkfeQOwjlp5lSZP657/P9BtOIWtyi442akzbap3rV97Y/d4ZN42UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=m7nzyaeh; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="m7nzyaeh"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-896fa834290so7133196d6.1
        for <linux-cxl@vger.kernel.org>; Thu, 12 Feb 2026 21:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770959993; x=1771564793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5sq39GKGKYtZnvRF7sZHwfSBOVR0WiB0kKUCAzpybVY=;
        b=m7nzyaehCPYxFY2mG7lbIE5V/K9Et4GGo5L64PFxyCRRraPqB50v22aKr061VgtjB+
         UJaIwrom4NL0LO8b9ieg427bMPYjQoE3X6gaOo81t2R11OYp16m2iJinBHG4eHtrZXZH
         /NTDEXnq1xIgC331K3rBHY8pp1VJQmWP/GCUQWjVjsOFWWcQ+a6ZS6OrhbUBJmj1E2D5
         gmwgr4BAJSRv1Fcu436GOwnJBusy6bH6CB4ZrXiUigQ51W1qshNV+s78hNfs7rxYFVuA
         WRHAPbdXghx96kp9q5ZaCNIJkN7mSIPxebm4l5FFsLMHMfZrn7/UH3ubqtZwH/lGCaKC
         Ue0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770959993; x=1771564793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sq39GKGKYtZnvRF7sZHwfSBOVR0WiB0kKUCAzpybVY=;
        b=fioNNbKA0ZqA0mwqW2n4+n95AyC0xYRzZ/8ytVGPnw1FdMiTJVuLq66gcalP62yAf2
         Jh4mSt+J96dhmc5pPYcaJxydjytK4GWz3JO8VkcHt6oFs0/tlQrITn+HVCx6CaZOYPU0
         DZ2+mv3GxKWRbxbYj2FY+uuHesTNfAfTtJULn554KQ7bbkFFK8U1jELaTjiqSUQcT8zO
         j71LrkwkJxJ+DoZYKLKEYsIfE1v/CQqqNek+pqv+P+aZy321mdA+ZxtXnA/PwMKUdsFm
         uk3Iumm0JDBJlc2bXasqKh16X7yddz+m6ElX4+9xG1zse1kVkCvThQK5MHqIc30Zx3hR
         caQw==
X-Gm-Message-State: AOJu0Yz1d81EKvDrVwA4Cq3BAnQUxBzZ22gwaKykbqynVrzH1AH3e4KP
	Zv5kBdna+9CUVbGWwjUPLGMJ3NNhnzMxEyby5x6zJeUbwLzvT2N0NcfAKU1rFV+ncGo=
X-Gm-Gg: AZuq6aLVku3gf1pOHpIw1nYNLTV8xC7z3rV8E8ZHkWIU2LGddcRBQxVMgDo8D0U8P3Z
	hzVwOENCfSItKeNZnEXPOEUleumgKygqgbSx2oaOcU2N45OMCpPGGG7Rt7DtkaszvUacQthCBdj
	pZTBQ9TjLg8vZTdiatL+/xFZ9xQrbe30ONqj9wX0PGozCRgixmUPyFzOrEsZCsCnNcpxO1XCuT1
	gyuRGu7JLm7brlZx3LWMrpUj4glhr1dkK1BWH9xrsGC5Yrdv8vihO6I0RLWAsCRAS56wAmyW1hV
	UQaKNaF7mMUU4CTKjy+1zqIXp7RC4oU0fRIXAq3oZqIaKC9cTNor14cOgs3n1+K+VcKTRAvndN6
	qKCj73XXuQVA2nGqaDUwJG0BWJK4bU/1On3uuYq5Lye0h9AxOsT76LuW+kMSYbaKDxCIH/gLvb4
	8NHlj3bIzpcLCPJAcvWAg4lE1StEvrC8BkpwQEgkyvpEX5t+GcAsZpESK3Dtrzat1VYSoF7Ihhr
	a3W1AonoA==
X-Received: by 2002:a05:6214:1301:b0:894:6f33:1700 with SMTP id 6a1803df08f44-89736138b27mr8969376d6.14.1770959993095;
        Thu, 12 Feb 2026 21:19:53 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506847d7bdesm62607671cf.6.2026.02.12.21.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 21:19:52 -0800 (PST)
Date: Fri, 13 Feb 2026 00:19:50 -0500
From: Gregory Price <gourry@gourry.net>
To: dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com
Subject: Re: [PATCH v3] cxl/memdev: fix deadlock in cxl_memdev_autoremove()
 on attach failure
Message-ID: <aY60dhq_3witwbLN@gourry-fedora-PF4VCD3F>
References: <20260211192228.2148713-1-gourry@gourry.net>
 <698e97998a33f_1cc5100e5@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <698e97998a33f_1cc5100e5@dwillia2-mobl4.notmuch>

On Thu, Feb 12, 2026 at 07:16:41PM -0800, dan.j.williams@intel.com wrote:
> Gregory Price wrote:
> > cxl_memdev_autoremove() takes device_lock(&cxlmd->dev) via guard(device)
> > and then calls cxl_memdev_unregister() when the attach callback was
> > provided but cxl_mem_probe() failed to bind.
> > 
> > cxl_memdev_unregister() calls
> >   cdev_device_del()
> >     device_del()
> >       bus_remove_device()
> >         device_release_driver()
> > 
> > This path is reached when a driver uses the @attach parameter to
> > devm_cxl_add_memdev() and the CXL topology fails to enumerate (e.g.
> > DVSEC range registers decode outside platform-defined CXL ranges,
> > causing the endpoint port probe to fail).
> > 
> > Add cxl_memdev_attach_failed() to set the scope of the check correctly.
> > 
> > Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> 
> Looks good,
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> This was a kreview find? Would it make sense to do something like
> "Reported-by: kreview-<git sha>"?

Technically it's a combination of Claude using kreview, but I think this
is reasonable since Claude falls over on some of this without the
prompts.

If that's something we want:

Reported-by: kreview-c94b85d6d2
