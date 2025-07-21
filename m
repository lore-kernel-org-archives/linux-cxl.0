Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA56472617
	for <linux-cxl@vger.kernel.org>; Mon, 21 Jul 2025 00:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753059080; cv=none; b=ZI79IP4wxY4vBc9Q+iFOEcupub7R/+V/99syivin27lgIDf/UPIRPVxlt01f4cC6YyVixSwplRJTSibdhRygkfR/hp9TJNFrAlachBbEoUzfzV5e90Eu8gdhpf2AK3dI9ytFIjuISsfug7haxJb0v02NmiGyw8nCAND1xbfX5CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753059080; c=relaxed/simple;
	bh=flz3KI+pObSKl6+JdCtMWPSPqM5U/a/duvHNej2nPwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=if/AAS5XPZbO1QH3b4CdCZbr+U/MAzJcPDQhQ8d4ArfAp1K4mYZ2WsJrO/foJicAVKX+60ll2vNR3aWbRjEfEb6BGiuhINRSdV7vkcGrNxVZ4OzGUtAOVBBlxB5Z+TuRpi9B+oqgsEXpK3yYsxfxBHzf4VYEABl8XGfEpniCgeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Wuki6RHE; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Wuki6RHE"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ab3fb340e7so72734191cf.1
        for <linux-cxl@vger.kernel.org>; Sun, 20 Jul 2025 17:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1753059077; x=1753663877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UpYWz0hHkJ5czp6E2Ogh66jdWDkJrXo9PJQzqqTm/Fc=;
        b=Wuki6RHEfJTxiD+F6P9VAA1AmczSE7s1E/nTpYm5wXMo6RQaI/dAfBZclKatIhRU/e
         PaQUKdUzNB1sANwHNJc8vHB7Be3RN+BQf2NlQf6fiYTF2s+PM8UkFDgyFXqHF9N1GMOR
         ygIRhfnElJbHTvjFpEv/WE57CNYAaX2Qqvd2+yX+JEi7B8DqM7cZZW/FGUZuQJa3UDXG
         6ojn3XG84PX8fxjFLVJD+eWQXai8HrhrGUmiUA+SqpVANz2vzJugJgH6seHfYEoC7mhe
         cGToFNoETlcPnr0jqufQpODB9nfFSf5WXF61TCh6ZGKnT5IXGlMreHfUykz8lAkhYObz
         AYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753059077; x=1753663877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpYWz0hHkJ5czp6E2Ogh66jdWDkJrXo9PJQzqqTm/Fc=;
        b=lHOevNh2L5F2GGze+Wm+Q6iJrk5a7T0v3XW+rwxa78oNNU7SRPmPVNk5ufvBDXUDsc
         WOvvdAgsToWe5DSWLA3EUzNJ+dDQ5cMi0R27otGTuIkkTVCfZ0HyJeoCnTO+xCdV2xEb
         K6bGvVFBuldZ2vlQtT18R4evsT5xgZWMErP11YpkHCXrFB1Sw7IY5TtarEZWfIrr1MZe
         ILGgNXSjLmB3vFTs9WlhGRH87Oeb9oA33SWD2ppbUlv2z7OvKWvOyn27XikX0e8/7qH/
         7fobdVnVKebVzojfEJBQEqYgGZinCPQMTskcTjO4A6M+Ml7LEv76jAYxYTnoU8jtxDY3
         HD4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdyYQBXlXoCU3MsPsmIGvMWq2wFnXOFtbg1L9BFBjMeLD+Syn31/+VgBlIDYKOKScRmuVYIvqaBQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw69dhcyaBD83cR9fAabnwkrZqhgPPEFkOaeANMaqGvpRKxycy
	IC7JjTRl8Tf+DfN/G8XuxrZRCBrqJMFC6Oe7o/B6HzmSfOulPEG7YOVVo66cgB909vw9aNC2eCe
	dO1FG
X-Gm-Gg: ASbGncs3ysRyFbFvRYNPLC180mMBjdnMVIQOdPR2KbF/I3C1baZiqKU8z00Z5JjWLD4
	AwPG9vliFzh4FsSvydJlvPVrccL19fFptRcS2Smn7QxIjgIdN5ZIWfNC7zhL0NlRuTH4AQNe5IN
	oMikeCsBtgl2ItfDAgkpjZHAv7xWEvyDTVRvcbiRa/dMM2X9qf7Rd7FI9tKM3RnTUJHjy7Rb8mb
	CMWXMzxoWcTMmob/AsBUtWWPhOH6ixC+krGNOjWgYknWjHj1fuR2KFvE+PXDV8KU/z+ChoPSoCv
	Djv85L1TzAu9yLpoqWQybKh1+4Gg+z2f/U82TTw1brhqXgsqI2dr7t4EIcebpjQN+HC9Y0IsBYr
	zkNDVFc2zZDfsvirsQCdz/CNa8XUBJ3x1BO2cQLDi5ZE++rVEIbf7VeTmQz1AbreZl5xiPyHgjO
	HAbQ==
X-Google-Smtp-Source: AGHT+IHJ8BDCuM0ht9jJt2VhuA48Qsrq7u0dKStcaY7gkl2qUWPyhDCmG32ZpnKotK9wXF3jPQv7ew==
X-Received: by 2002:a05:622a:1a25:b0:4ab:95a7:cf9f with SMTP id d75a77b69052e-4abb2db8e1cmr169676251cf.54.1753059076774;
        Sun, 20 Jul 2025 17:51:16 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b204cdsm35378211cf.56.2025.07.20.17.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 17:51:16 -0700 (PDT)
Date: Sun, 20 Jul 2025 20:51:14 -0400
From: Gregory Price <gourry@gourry.net>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cxl: docs/driver-api/conventions resolve conflicts
 btw CFMWS, LMH, ED
Message-ID: <aH2PAju1rLxIbXXk@gourry-fedora-PF4VCD3F>
References: <20250623152923.1048525-1-fabio.m.de.francesco@linux.intel.com>
 <1985851.b9uPGUboIS@fdefranc-mobl3>
 <aGwmFwGNmw8n9zGR@gourry-fedora-PF4VCD3F>
 <17128669.tgchFWduMW@fdefranc-mobl3>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17128669.tgchFWduMW@fdefranc-mobl3>

On Thu, Jul 17, 2025 at 04:14:13PM +0200, Fabio M. De Francesco wrote:
> The table above shows a real configuration copied from an x86 platform 
> where the Low Memory Hole (LMH) starts at 2GB. 
> 
> The"HDM Decoder Base/Size" refers specifically to the CXL Endpoint 
> Decoders HPA range Base/Size. The first row of the table describes the 
> first window (CFMWS[0]), whose HPA rage base/size is 0/2GB, and the 
> Endpoint Decoder that the CXL driver should match with that CFMWS, 
> whose HPA range base/size is 0/3GB.

The only thing i ask is being more precise with decoder references.

HDM Decoder can refer to any of: root, switch, hb, or endpoint decoders.

Below you make this distinct in the explanation, but in the table it's
simply general "HDM Decoder".  All I ask is for a bit more clarity on
what decoder will contain what values to avoid further ambiguity.

> The driver expects that the Endpoint Decoders HPA ranges to be contained 
> into their corresponding Root Decoders. Furthermore, Linux fails to 
> attach Endpoint decoders to already constructed CXL Regions because of 
> the same size discrepancy issue. 
> > 
> > I think you need to describe what the expected behavior is for what linux
> > will produce in terms of the decoder objects given the above.
> >
> The expected behavior is that Linux should be able to match the Endpoint 
> Decoder with the Root Decoder range even if the CFMWS size is smaller 
> than the Decoder's, as long as the latter adheres to the 256MB * interleave 
> ways rule. Furthermore, Linux should be able to match the Endpoint decoders 
> with already constructed CXL Regions and allow the attachment process to 
> succeed. 
> 

You may also need to describe more than just the contents of the
endpoint decoder.  What would the content of any intermediate decoders
be (matching the root or matching the endpoint?).

> If this explanation suffices, I will incorporate it into the next version
> of this patch and also explain that "HDM Decoder" stands for Endpoint Decoder 
> and that the CFMWS HPA base/size describes the System Physical Address (SPA) 
> which the CXL driver uses to make Root Decoders HPA range base/size. 
> 

This explanation is better, just need a few more bits of data and I
think you're good to go.

~Gregory
