Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E89032C957
	for <linux-cxl@vger.kernel.org>; Sat, 21 Feb 2026 04:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771649295; cv=none; b=lTTo283sE0ULyfCNLnN0w2lcCAuSwrw25JsNGeYNXVZ8yuzJYliQTj9FqpSEILPhpBMGFOKN6pi+ngBMyqMQosw348g1zHjqoY5bKMeOUynrqQfMWjWlkrV+gnHMvAA2J4MW4AB2AgMFMfBQg+FcNUC9BTBGP8DwovKOx+1gzdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771649295; c=relaxed/simple;
	bh=mEsr6mMZj3A98YW1eNq3yyz90k9RElIecO1zjl+Pj1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFIl42ZHQrUeGukucDxjNe4dcPWNAc0Kncc3qc0J6Z3HnElcseKGIXQUC9QYsXhyTZJmkRV/JvuZkbY6KWXI4k83OJRVkiVCHyM6tuNt1mfTEZJL3XkwBKx9REagTE2aSV+3xd9flAcAepoURJLQtqeH3dDqlxcqzYdOelDXNaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=T9iZDjeX; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="T9iZDjeX"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c70b5594f4so305781985a.1
        for <linux-cxl@vger.kernel.org>; Fri, 20 Feb 2026 20:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771649292; x=1772254092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eq3866hUg0iccmQvSfWEyoLr7h9wTLRxQOBYnSXIh+c=;
        b=T9iZDjeXJodH18Pg6Tlptd03tg7yvB6qXtRgYz6yI5fts3rgYz6AoTZIwtpZc5r73b
         nyhql7BjoxqPiCU+yzn+VQ7eW/KlSh6xNO3BWpGEcShMvFIu+R/u+68vm9MkVkLt+B+f
         NpLLJy/a30t1qo0YiyLOQdyTA+geMcAT3a8H8k+1w9FXPW5MKNjybmpZayvimzAT6sOf
         XHwg8QpRIqJY9etOCNNiT5bc/782nqG2RTniU7HwvysJtvUIOIAHGZlV+Ugr5KZmp4XA
         bv+fCmFcy8NTO4szx5uo9tLLgmBtJxTXz7dUMwSwgkEo/M+WOwN4T7oxbmRy70oYWQSA
         VVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771649292; x=1772254092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eq3866hUg0iccmQvSfWEyoLr7h9wTLRxQOBYnSXIh+c=;
        b=rJUlCbj4/bg/Mfp95GFCOOLPafB1O3dXezeXGh8nSXFM9a8mZm/XnBbtXWoFaZ4Own
         bITL53VSvfOn1mNhhj9rjRvJMawDcQlc5CAmsercsC+wzd/4Ma/Vdt40AlFasQHX37Y4
         S7mYFiSrmqllJibsGk+8Nv1735UbUl6k7Muu4MH1rn4ltzsZlFmhKS7O69paOd/V2RvY
         4GmZRniLRqUoPdVZjj1ZXk5GlXyE32bOWqnh3lrsYcwYszZB5TGuZH+99F2G4jL9m3uj
         +V85R9uXjeE0prlW1NHJt5hbgQWwKOQecYPOrKayRtswzeHhOCH45ifqIdGbZiQLkcvU
         bVrg==
X-Gm-Message-State: AOJu0YxrRBDNad7ZMBzZV71D6JPAGZDsoY6IgrCo4Qqu/xKc9w24Zo2x
	knp0r+vqrat/tZtGP0Eqw3TNUz+JQmNL29RnHdQLQXAbY4p6HeLLu+Us8XUFe2d+JbQ=
X-Gm-Gg: AZuq6aJ41Bp2E3YHid1mT08Tze+N1o4n6f/Gn1VhlfaPN63Z6xBT6qN+pEwlT2nJ+AI
	N+WgQPGW2S5IJCica5f6yuXK6yAjv9jslBUc/by+LF7UPYEU1ZZwSZf1PwWhU0EWCZcV9dY8seF
	+/362nPLDV+zRHqPnzo/ibhZ40BNytceJH4d/1mdBDxSBporT0WddmC4k/3L0cWxOdlvIfU6hTv
	Kw5TCrUzIeI+XmOceuD0eQLQH97D/KrJ2kwcVTp5QPXLdfVZ9HjkVUJk6I7IzbDB4w18JiWiRaP
	x2nrrcNtlLTh0gJozX2E/dRjQ6uGCJet5aJQJq06/GrEeYU2B96MEuNDTVUsNfKaEc4dOycMbyk
	LpbpV96TcMveIC5CGICuHRQ6tHbzO0K2v4NCqyo7PFEYrplOao1N1iRKs80HuNKSwbrs874f+Sd
	OrZaH6wIZhWA6Ug0Eo2S9Tbfs8NDzGnM/mY/1enR4LpH52+E6tLuSJdnIl7JLJ/kgxWcT4I63CH
	iU4yfJUmQ==
X-Received: by 2002:a05:620a:8d1:b0:8c9:eee0:dbb7 with SMTP id af79cd13be357-8cb7bfc8d44mr724210585a.23.1771649292241;
        Fri, 20 Feb 2026 20:48:12 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d1202e2sm116505085a.44.2026.02.20.20.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 20:48:11 -0800 (PST)
Date: Fri, 20 Feb 2026 23:48:09 -0500
From: Gregory Price <gourry@gourry.net>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v23 10/22] cxl: Export function for unwinding cxl by
 accelerators
Message-ID: <aZk5CVRELS2qo92c@gourry-fedora-PF4VCD3F>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-11-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201155438.2664640-11-alejandro.lucero-palau@amd.com>

On Sun, Feb 01, 2026 at 03:54:26PM +0000, alejandro.lucero-palau@amd.com wrote:
> -static void unregister_region(void *_cxlr)
> +void cxl_unregister_region(struct cxl_region *cxlr)
>  {
> -	struct cxl_region *cxlr = _cxlr;
>  	struct cxl_region_params *p = &cxlr->params;
>  	int i;
>  
> @@ -2457,6 +2456,14 @@ static void unregister_region(void *_cxlr)
>  	cxl_region_iomem_release(cxlr);
>  	put_device(&cxlr->dev);
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_unregister_region, "CXL");
> +

kreview suggested you probably want this:

void cxl_destroy_region(struct cxl_region *cxlr)
{
	struct cxl_port *port = cxlrd_to_port(cxlr->cxlrd);

	devm_release_action(port->uport_dev, __unregister_region, cxlr);
}
EXPORT_SYMBOL_NS_GPL(cxl_destroy_region, "CXL");


During testing I experienced some double-releases when doing aggressive
loads and unloads of some drivers.  This was one of the fixes.

~Gregory
