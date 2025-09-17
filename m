Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6781B242D8B
	for <linux-cxl@vger.kernel.org>; Wed, 17 Sep 2025 19:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758138987; cv=none; b=TvtApq8St78Z9AJhCBw4pg80cAnPbOalKjNd7biDXGWfDn4nEmuZgY3f+epezG8bswmqcYYs7f7XzR0UmCrfUVsBuELk9IRnlLFPavKrb+8wiFJTSIyKIT+yKkyNZD7MirtH+UILRM7wifZYlT+RzHBFyDwE+virFgP5Ovx2FOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758138987; c=relaxed/simple;
	bh=U+xzvg0+p8YRBwVjJW5ad4ZRAtixrH50H3CYwD66PRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7773n7r3Wxgw9CHVhYxX37CvkSid3wG369skahSs/wGeotTsf1Lssnj8jVfnmuTVKdvaANNZ+5sXrtb5JJp7IrdNT0b5FqVVTikIu7i4nGW6bHDw1mhIw84+jfoiDYbHBy3X8FL3D+Q5AHY4kFziVE66xvX11bBiHaJZZ+4voE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=JKSjebNC; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="JKSjebNC"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b79c8d1e39so2553081cf.2
        for <linux-cxl@vger.kernel.org>; Wed, 17 Sep 2025 12:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758138984; x=1758743784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TWHRbE+2RwfEiSllz0UZDyGmNU78opvT0w9mXRiIjrQ=;
        b=JKSjebNCeuvZec/sew0HOq5nhdjUYTGNTSBdF7eHxVOGjK7UxiBXf35dEqaUxpdNVm
         eYlcx6Lq3Svfb/N7RUavziAQkIiFqivDehH657gD355So2wY1enjBpNwE7t9y7BYJfkg
         ks9xqirKwnPJE7i/lx0rpyBiE9qqz3hN8bcvXfLe8NOmLjAXmefrfgarVLOFx4zEnBbZ
         3AUs5Qqpyrhc3n41jwCro44X8TaVnQZFZDjtvcOR4iVP7MnHgJ6cs8BH7sl0R9sG+lx9
         Lhw0pPeBOuXDLssv/qzkJImhtgUl8iFIaW8HaAd3DjL8uzWSxhBP0JPSsGd2DK2a+2ca
         WYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758138984; x=1758743784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWHRbE+2RwfEiSllz0UZDyGmNU78opvT0w9mXRiIjrQ=;
        b=gpHm+ZsDHrvsd4K/lCqHh25GBHISVJ/Gm8XYAIFYT1BWjnyrHzzL3UUToMskSuF+Pw
         p44DeMpyYD+Z0cN2uf29v1RCggfPj2ggqnPlbejTiFzdJPwlLpKoBfm4OsZJhS4Awpge
         xCYK8WYmInfXVDgow51Whc8iMRd6PcjDxq2zEFglLJ9h+9fFIns7xXz+W27N1RgqM1rt
         t/6eBkkiYR+fEhoOoqwTMGYiHM72D3PTuGPM0JxZYFWK5TUw64FnvJa9cfkvpZdn+LG6
         K2taJoKtj4hX+Zq2Msz6wphA6MZxJ7C9E0SJ+/ezjZ1i6AKB8I9+3YoZfP4s4qAbBYmY
         uQSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIL7XkAhYcjiDrAov7FDPWfZd+syiGSrvdgDA6Oqjdh0reEPrl2tmHbaJo60fi5ddrDEKTxoXu60o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/gV5KsYnby7f3HdQhnLPn2VJWFUSf8lwZ4zAH+Hxz5xHrka0J
	EiIsflj6z9bAzSssc1Ki00v7ugeZ5x8ty9HnXSxsSV41oDobs+cXNl3CQAgEb40ZkPw=
X-Gm-Gg: ASbGnctb2DhR3YmMzCL1Pzqw8QGIiOeIVWMsF5Qe5Z5WO/Nwzgwy6RjksHqLjeyzb00
	Pmo+eK0W83P63i4Jo/jVUPFlMPphONg6hPsYnTytsQW5FdvyePakiweF+8jm8vaKOt9splkAoyS
	2Ryd5xtmg4vA9vgecp7o/E7vZICqJpkyZlNv2OEwi9lXsAOE7JYmc6Vs6vza4+SrpQutJLfL1Wx
	F6t5wiaZOAiOiqPQW8MyD4S2mTlIPvevaC7Kle2oMT2c5/fAsq7B5s0WLB06VGbzctTzbRiBA++
	6iz+/g1iKmZyqWaIfIkaha4CPUKPfUbZqZmjwyuaxudB24gfhweRMz+Dfq13yrHjcwagtdm0fei
	oNxxi6L0BnbkaoyH5+pk8raNy+vGGKT/TmO3kKOPdjsVKRwLB421TMQJbOIVxxCvIG24YW35Q6n
	IWf4fLvTs/GGk1XdKyzKiIgQ==
X-Google-Smtp-Source: AGHT+IGZY5onFfbJ/Ady5+OG7UsSraIKd+u3udvBLrGG06Nf882Q/uxkOvG1zGx4Y0t9b1FKmtIqRA==
X-Received: by 2002:a05:622a:1cc3:b0:4b7:8235:1eaf with SMTP id d75a77b69052e-4ba6a5d6732mr45153491cf.39.1758138984189;
        Wed, 17 Sep 2025 12:56:24 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda15f577esm3184571cf.7.2025.09.17.12.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 12:56:23 -0700 (PDT)
Date: Wed, 17 Sep 2025 15:56:21 -0400
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 01/11] cxl/region: Store root decoder in struct
 cxl_region
Message-ID: <aMsSZZVNwH3LP_Ur@gourry-fedora-PF4VCD3F>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-2-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912144514.526441-2-rrichter@amd.com>

On Fri, Sep 12, 2025 at 04:45:03PM +0200, Robert Richter wrote:
> A region is always bound to a root decoder. The region's associated
> root decoder is often needed. Add it to struct cxl_region.
> 
> This simplifies code by removing dynamic lookups and removing the root
> decoder argument from the function argument list where possible.
> 
> Patch is a prerequisite to implement address translation which uses
> struct cxl_region to store all relevant region and interleaving
> parameters.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Nice

Reviewed-by: Gregory Price <gourry@gourry.net>

