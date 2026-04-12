Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC54339A8;
	Sun, 12 Apr 2026 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775984257; cv=none; b=qoE8bSZ5VFQ9LufzUM3TR2WuyJeFwm2ZEVEfvz/s311wt99IFjaerBmW+PJxD2jBLWgHMNenIFa08SowpYnSHxYcK+R/nTOO1v3XyWdXkaoMi8LnwsWyI7l8ep+fwps5o/htAjOm6d62Q13Sut5pVfFtzKR0shf0jmsHPyUSPto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775984257; c=relaxed/simple;
	bh=wHvh5owJ/ckLeAWUCXgFtnerVe4Q4KiALc/fgMTdIz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiieSjAAKc97BXh6UvM+ap6WnzZz2xC/oZOwSJcOBwlgSJ54CXO/qwDVS+XKlD5rpRrkjUS7Yp8M27SsDs9jRxSxCnRNTTWJiGk1/6komsiUj2tPJxYeHxeAv60JPvFXiFyWpGbCPJwzI3n27YwbabFWH5nIXXzLH827TCWpY0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 5582536C;
	Sun, 12 Apr 2026 10:57:25 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3F0E36017530; Sun, 12 Apr 2026 10:57:25 +0200 (CEST)
Date: Sun, 12 Apr 2026 10:57:25 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Dan Williams <djbw@kernel.org>
Cc: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>, dave.jiang@intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	alejandro.lucero-palau@amd.com
Subject: Re: [RFC PATCH 4/4] cxl/region: Introduce cxl_memdev_attach_region
Message-ID: <adteddEh4I5UX-mq@wunner.de>
References: <20260403210050.1058650-1-dan.j.williams@intel.com>
 <20260403210050.1058650-5-dan.j.williams@intel.com>
 <59f69b87-e37e-44c7-8c15-c332118622b5@amd.com>
 <69dad30a614d7_fdcb41008c@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69dad30a614d7_fdcb41008c@djbw-dev.notmuch>

On Sat, Apr 11, 2026 at 04:02:34PM -0700, Dan Williams wrote:
> Cheatham, Benjamin wrote:
> > On 4/3/2026 4:00 PM, Dan Williams wrote:
> > > To date, platform firmware maps accelerator memory and accelerator drivers
> > > simply want an address range that they can map themselves. This typically
> > > results in a single region being auto-assembled upon registration of a
> > > memory device.  Use the @attach mechanism of devm_cxl_add_memdev()
> > > parameter to retrieve that region while also adhering to CXL subsystem
> > > locking and lifetime rules. As part of adhering to current object lifetime
> > > rules, if the region or the CXL port topology is invalidated, the CXL core
> > > arranges for the accelertor driver to be detached as well.

Nit: s/accelertor/accelerator/ and wrap to 72 chars

> I think that is possible, and also is not really a CXL specific feature. A
> capability to move resources in active use by drivers has been proposed before
> [1] (credit: Lukas).

There's no link provided for [1] in your e-mail but you may be referring to:

https://lore.kernel.org/all/20201218174011.340514-1-s.miroshnichenko@yadro.com/

Thanks,

Lukas
