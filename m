Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC27F1A317F
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957272; cv=none; b=DeHU7T3ZYUlsNmMFqDvB07T3vh1ieSZH130Kj8kQF0HvHrK9uaMKAnRyuiwW/lO9LIPub4IaN5elzz5uWNN3nPV6xXtDrbCBLN75YZGWPyB1bPqJWz46j1sVjTJD53y6ztEbmah5oqr6jd5ZsTnBhUB0DC8WDFTBUjePgtRDtSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957272; c=relaxed/simple;
	bh=hY6Zloh4mg7ZCNsjbeJ0HY1B9qv651w6ooNCAsuy9XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8PfjQQ/jzxtdq74aItnMAebcHXnG5/ERG9reBmSLOFt0pj49fejEdXy4a8YwZdtZ1Oq+AP9U8kBumaLKmeoeNuULl74FcblwdiqsZVcNnRgdf4AiRquHHiWisv0HIBdD5PTiuvxQMBR8+0tpQnqHKQoKKXvYeixEn1BOGNAvA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SumRsikh; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SumRsikh"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e44af3dacbso9806076d6.2
        for <linux-cxl@vger.kernel.org>; Fri, 07 Feb 2025 11:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738957269; x=1739562069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a4oAel342nYv5nBJe0AwxOmOsZherwYKX7ofeLtPQ0c=;
        b=SumRsikhI0AhtJmT+/ynpcaDr4MxquUujj0Z58+BysgwZy5/gQTy/yQJrLmc89hkl8
         JU2mO/402QKY8zBx1YzOZs/I/TA0CiNR0FPrXn4FcobOuhGrTCs2b1qMU9jbt8P5L2y3
         14qKVGQnt65GDvm153a2DctQGRQ1uTls4UGmSfrmah1ET2S2d7MaJcVYF19J+Olhhlnd
         6KGjrNhbp30urdjBEJKZ0bTZx2+2yy6Re+u7tIrNZ5PUJLGOPRSy1NbMTOuTS6fGiwYx
         q330Nw6QkuxEGd6Wm3IcXlHVDpUKzZk+kFHzT7SfAVvei9UJPaBOKp+v9CNSuJNpHhOD
         kPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738957269; x=1739562069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4oAel342nYv5nBJe0AwxOmOsZherwYKX7ofeLtPQ0c=;
        b=pJaQYrQHn7EPPpRhrNLXI04oH4tAy2fbFlsUIML/CS5K1aLcoD0of9oGcD/9/HqHxe
         FxehBZZSiC+H1qTBbyvMQCw/e2aWxl+5W9J7wN5aByBzam34O7mxt6G1T+UQDmdrZ8Ka
         0wp6IiYlb20opHJwGk5Cl0A/0IEow9fM5L/x7YyCZ8zOEFYdMlyTbJ2eG/7lS+aW5hiF
         jJ0F4yOGzLaehRFi9XPwTkFF6fiHnA2Xpk71R2/D2ubI0b/tXein3oQJL7oArzpw3bJw
         IWRQHYEAtDFCa+/ZKwMAZAPivO3oKZRRZH3gzBf2Hf+7KvCDj1CzgSs0JoF28crD+wmT
         QpMQ==
X-Gm-Message-State: AOJu0Yz2jGoUtul6xRgimfNnUBPy7kh4X+t/EZHgZqLXY3MJos0z8uBf
	Juwxs8jKKJM0EgY+paawxs3ISxrK2fOGptwqMqWaRoPCPokka/FH9xhkixGecYw=
X-Gm-Gg: ASbGncsUHEzL+RG3PONrcVbSkPPnWNgjcsXTNflXJaASOsUDnPfvpYduN6j/GlphtVE
	M28pzc00qgU5XnhHA+cT3aXfX8wsUpP9E+9ia68ZThQSKgEH4cDr4OzDLZZ/AS2Ev802b8bLO+e
	uS8mUgm7ii9d9QzBTIw8rBJOz6a6EubihkR8aAo/cUKs659AbxbZeqjvl9guWK+a2EIx4Gs0Y4x
	VAj9DYMpMxbQRUpZK0k/G4AULDBXhGM6vnoyueGUi9WL1b9asMnj9RQ9KqOJCKrgujZtQBSPVMg
	zE6EHnkVnMVXY2wTC5mRcxl+N240vGo++X516+U3tQOr/3Zn24N49ADczw8+GWN31cRvSsapoQ=
	=
X-Google-Smtp-Source: AGHT+IHaxpZee3sCSGfBDBfxwHempye2pj5zZfAfTlfZq36QNyZhbhDUkJdEyf8Z1mLKSaGiyhRixA==
X-Received: by 2002:ad4:576b:0:b0:6d4:3593:2def with SMTP id 6a1803df08f44-6e4455c246fmr61051826d6.5.1738957268471;
        Fri, 07 Feb 2025 11:41:08 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e445621334sm12230366d6.64.2025.02.07.11.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 11:41:07 -0800 (PST)
Date: Fri, 7 Feb 2025 14:41:05 -0500
From: Gregory Price <gourry@gourry.net>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com,
	alucerop@amd.com
Subject: Re: [PATCH v5 13/16] cxl/pci: Add error handler for CXL PCIe Port
 RAS errors
Message-ID: <Z6Zh0faJrwxsVBLD@gourry-fedora-PF4VCD3F>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-14-terry.bowman@amd.com>
 <Z6W92JUQQt4Lf6Ip@gourry-fedora-PF4VCD3F>
 <5df5c06a-b1fe-4b79-a313-2b4c5b088f83@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5df5c06a-b1fe-4b79-a313-2b4c5b088f83@amd.com>

On Fri, Feb 07, 2025 at 01:23:06PM -0600, Bowman, Terry wrote:
> 
> 
> On 2/7/2025 2:01 AM, Gregory Price wrote:
> > On Tue, Jan 07, 2025 at 08:38:49AM -0600, Terry Bowman wrote:
> >> +static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev)
> >> +{
> >> +	struct cxl_port *port;
> >> +
> >> +	if (!pdev)
> >> +		return NULL;
> >> +
> >> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
> >> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
> >> +		struct cxl_dport *dport;
> >> +		void __iomem *ras_base;
> >> +
> >> +		port = find_cxl_port(&pdev->dev, &dport);
> >> +		ras_base = dport ? dport->regs.ras : NULL;
> > I'm fairly certain dport can come back here uninitialized, you
> > probably want to put this inside the `if (port)` block and 
> > pre-initialize dport to NULL.
> Right, it can. NULL dport check here covers this, no?:
> 
> 		ras_base = dport ? dport->regs.ras : NULL;

dport can be garbage (whatever is on the stack) at this check because
nothing ever intializes it to NULL.

> 
> Terry
> 
> >> +		if (port)
> >> +			put_device(&port->dev);
> >> +		return ras_base;
> > You can probably even simplify this down to something like
> >
> > 		struct_cxl_dport *dport = NULL;
> >
> > 		port = find_cxl_port(&pdev->dev, &dport);
> > 		if (port)
> > 			put_device(&port->dev);
> >
> > 		return dport ? dport->regs.ras : NULL;
> >
> >
> > ~Gregory
> 
