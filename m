Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C96123817E
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771949180; cv=none; b=MLpM41ap829IBuQCLpBTNjvkJKRoVgl5XwGuechMKAsjp5se5EBEEIC7NQ4eAY/WksXnfoKeshuCd73Hrz/I8POMRFK5awRbcIx5Uk0dgATqdhXFdMfjpP7JDx2eEtJaJhfPT6qU1HjmVqKOvBFZoo4UO0OGkTb7bn9ymNb5W+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771949180; c=relaxed/simple;
	bh=2RDlxP23LTTOTm0sJDgOn7+Zt8oGCWPiBVjHf9aKP3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVB2Pcxl0n917zkTF28Cw1cGcO54ocApqVg4XFxEEPYwwzGY0KXoGeCs0dgwjibD+4SiLscFKyIVVDROdc4paWgLYfWwypguyT/CuYEjq18WkAJHqpyL2VNlCVIwWMJJlUUbLo1LK295uIozmcH5Ex7TOzjGdWUk/PxDOn1UZKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MiKaSTOd; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MiKaSTOd"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-506989e8516so47232981cf.0
        for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 08:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771949178; x=1772553978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ike/uCavi7YQ1PNQjdYgpCIj6IREJfg0S4iNOr3wGBw=;
        b=MiKaSTOdvPBIUo14gJnnOl0LhBxeNzue40brozcGEdpbizFonPWWvRUREv+FoXUEcs
         UCQn+tHqSKa/+IWP+FsodstZtqKG84MOXTa+m2oGIrWirTamGg8hB18g31WX9UGpHezC
         QwxTicNDJzOj4UPw2EARb+wm1GqBnMygJybGHLG7xCRRT2zChfglDKC2gMp9+XES/e3b
         Jo0mO7qbuIRe97GlCGjjNKInHjXccAe31ABGGNHXQdWSh/ya1jtZzR/tDo1quCrr9qbM
         FOQWnHBtVfUKdatwW8a66qGSgI4Lq/31yLoT53pcMKIXKUEd+43dn+YWM40wyT3wCu7g
         osOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771949178; x=1772553978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ike/uCavi7YQ1PNQjdYgpCIj6IREJfg0S4iNOr3wGBw=;
        b=CPEnK5TElvj9TWGXsrGqbS2CzHi/NKd898nfQtu2krGD0O5TtdTaWH1AT7nIxZ4FI4
         NOUAOSM3BAt2sqjmVPu4FypUxhrdgdAGFjx6TDSPGl7OTKJEk81IIhywQJITgVw5sTcB
         bWUvwkeGwKiRbanmulX2oK1RGcempJqS2/z7uPASTy0ma+V0o9+JE886TQzHm3NjWPnQ
         AY0P2hRyqfCqoGtxp0plIgKknzPtf97/l7T7fu7SS62ldZIGn4iu2mB2At3qMQNYIv3G
         Ve5JT4d9MPjlKOKsI0ss5RjWa658fyYjEKFNHbYrkratUuhdp7zrzs3p1UU33jjFOu6h
         Ynxg==
X-Gm-Message-State: AOJu0Yyp9PT47D4M1AZLDIQ54SFT9jIXIuV2hxXR+bycpAX5p5B5Zoce
	zT9ruO2q1oPSQtAkbL7ZhVNlOwvgxhbTnxscmPadfchS/13VXYGyLuIj5dODlWCVkwI=
X-Gm-Gg: AZuq6aK4GvPwywjrs5DgNFels/1/jUKJXWmBoWNqBzwGUrsNvTTu7zBmHvG3JZq9QHk
	Tpx8WNFetHV8AL7NhPZ7ndyYMKlqZjL3pTBGOys4cPVsD6DcrYlIq4El2tOvKHHJC+NFawAGN39
	Z37lcWaD3KlX6A1l8CqFdnDujMePZBDTDXL4p8ZH2ugnZhYj2Fm1gSgN9ZsjlgV9B8y7KPq2A7n
	cZxwwF7XnzSHMS94UVDRnVpIDDAiUctinrQjzCwGm6WlX3nf17Zq7qPma50oMtUv1tkIJEj0ep2
	V15mNuEwfacYRKweRMQzqB91mBrYAy1YuHREZIyISZWDcK3xd80p6ssQIdvpioz887AFgXFQEch
	+2YLLCYWD4ZS8OiqVgyv22gNqnze8KwuM4FJ1tx2uIbAK3pddFhtHgFhNomsdAN+DOvJES7t+R6
	ptSjIPWTW3daOIyTTg3FPjcf/L4qqwsodNuao3N30AEVbYhIa9fDCpzN1XeOXnfovS0w0VL2K/1
	+OIfl10hg==
X-Received: by 2002:ac8:5d42:0:b0:507:3d1:433d with SMTP id d75a77b69052e-5070bcacf49mr193487431cf.57.1771949177523;
        Tue, 24 Feb 2026 08:06:17 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d550785sm122680901cf.11.2026.02.24.08.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 08:06:17 -0800 (PST)
Date: Tue, 24 Feb 2026 11:06:14 -0500
From: Gregory Price <gourry@gourry.net>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v1 3/3] cxl/region: Factor out interleave granularity
 setup
Message-ID: <aZ3MdkPQf-5aXZ9j@gourry-fedora-PF4VCD3F>
References: <20260224152645.3441489-1-alejandro.lucero-palau@amd.com>
 <20260224152645.3441489-4-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224152645.3441489-4-alejandro.lucero-palau@amd.com>

On Tue, Feb 24, 2026 at 03:26:45PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation based on Type3 devices is triggered from user space
> allowing memory combination through interleaving.
> 
> In preparation for kernel driven region creation, that is Type2 drivers
> triggering region creation backed with its advertised CXL memory, factor
> out a common helper from the user-sysfs region setup forinterleave
> granularity.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>
