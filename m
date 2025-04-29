Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CB624290C
	for <linux-cxl@vger.kernel.org>; Tue, 29 Apr 2025 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745943241; cv=none; b=WIivLxOrmrwanivf6wOBT/dut1pRxPhJqR5YrK7Pub7C5rPNnZZn6teTwFZj4Zb3GLQA19dMzf3bqLBgsSEdcfc4Gl8zynZH4egq8veI367z2+k8EI6MPa2ja8QkabuofcJ2zbrLzyVc6Nt63XuF2zo6sL4blxNsqcVSUqKKOIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745943241; c=relaxed/simple;
	bh=uYyKCMw/uCGBssy/618cuvAybTKRye9ePkiOPdyJNlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLsNzUwrGosLNaIKbE8pUuHgCI9Irhu4xzK2RoIhJ3oH6vYnBmYLgE5czEwx+uPZA6dobGHUvlnQD6TKJF9EkyjeCFPfEQraxwNNl2cSBE/sQCfdOyqq1k0aSHdmjzp871qYphsp6zePOdfuGom+fjpcDPCO8rgfILT854t2lBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LDQjjnDm; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="LDQjjnDm"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-476f4e9cf92so46421181cf.3
        for <linux-cxl@vger.kernel.org>; Tue, 29 Apr 2025 09:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745943238; x=1746548038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QYW5ylN4/OUlBLAJXc3Y67XvBUn2IFnL+yXKkyihqHE=;
        b=LDQjjnDma1uFB6uZg9oWRcs261YaKztoBcYtcX2+AkYpL7OqLyFxZnPlFv/BnhplfB
         4dt3pfmyG9f1fg5DttzKvSJ2FfY0fkeNFcu3EDFU9ZFF9ZFo6knSG1rT1Irv4LLArU+3
         dBxRm7JL5Jqpk6OGzmyQl+zwuRlkmEh7oO2oJBOAzm2IryUJiX9B7P3RzIHKNof3p1Jh
         I0i59Q7OEYsT9gZGjpyuhmeJyJzR14k7n7QltviVPAqkQrov/0xSmD6dATul51ZoiQ4K
         /DQ9pGWR3ZZt3hw39ghnYCq7r/RE+JDexBCQkiA/fkbTp2XS6erfHuRLNIz1u2jAVy2X
         sz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745943238; x=1746548038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYW5ylN4/OUlBLAJXc3Y67XvBUn2IFnL+yXKkyihqHE=;
        b=X3uQhdQX7f014s5FIeB9AW/oeNJCSo0LbgKh/BGODafnDAS4ZjGedGKA7nDM/M6jZS
         nq/zLBagiKpmGpuJfsLmRDcC8pFVV/NVJ5ZECXKADiqtR0ypQEdIGDOX+7sKwzuKW+q4
         56gHzTvVxC2giNyaATLUYFQr5jBCNTirjdPSZC9XNuhbLbRZWFKN6g8CR53yVuB1WvNy
         ODz7YCD5pMSuBOx2PKdDhFf/zoyoOAX5LD3kUn+rBqtA1x/TDLBqVGEvujtD9HSeSVZY
         /B+2HBFZpO90gPYbXbiPfrBpFzSUvdbf80P5eNUqX0ZhQ6Wc0NBZnwgsRlbu8NduZtiG
         6aEw==
X-Gm-Message-State: AOJu0Yw9/xiGrZ5vco/6MkCGyGHWSNgTxGtvc/Mw8VxUZem9H1fQKxeH
	3Aed9TUD6DYG3T5QtINQBoHd0nvfC3nin3+rBGBPswdAY93CSf3UG1hKEdLnKyA=
X-Gm-Gg: ASbGncswClh4ArBJCqaVbIDcBtoqDdemKlU9qbjzfPZbPqRoXy5vu1Aa/gcIBMBm2gA
	kQyzikzv3HR5zdzZg2R3GDLWoN+B0ewduF5x1H+r3VWRB2Ug73Xqz8sHPXhBSx/bOO3eoZStdKq
	76NKrdCWxyFtRwh52BUPWMKuB8abDrQhxln8YnW2buNRsH6i99sRuONqrA3Bvcj37Y6kg0wT/Sz
	CJ+gVvO+H7t0HiWsZcwROAOia7atYFowyEJ7gBCfwKJ6WKUxm11p6/CDaC8AZdkytsyQtiVwY3m
	+iCnnLZQ/5sqzVtpkVHMdvUL06TeSgy7QnoxUfcYFn5UDbGoSlY+EnPBs+t1WLQolsiy70N7yzk
	5EN3gxPC5Ar4boDjCQRfnzCVWpqvOO3iIKQ==
X-Google-Smtp-Source: AGHT+IG3yEJDLPFxkXQY3px7o4oFmEnbRp7LRDKSw6my64BupCqKtOmMc4j9xvx9O69J+XOQiwgi+Q==
X-Received: by 2002:ac8:6908:0:b0:477:6e6a:7cfe with SMTP id d75a77b69052e-4880cefae73mr65484891cf.0.1745943238640;
        Tue, 29 Apr 2025 09:13:58 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9efdaa41sm81823441cf.19.2025.04.29.09.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 09:13:58 -0700 (PDT)
Date: Tue, 29 Apr 2025 12:13:56 -0400
From: Gregory Price <gourry@gourry.net>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, kernel-team@meta.com
Subject: Re: [RFC DOC] cxl driver draft doc
Message-ID: <aBD6xEmzgTbT58kH@gourry-fedora-PF4VCD3F>
References: <20250427170042.545675-1-gourry@gourry.net>
 <20250429155927.2t4rdawgpf4veaq7@offworld>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429155927.2t4rdawgpf4veaq7@offworld>

On Tue, Apr 29, 2025 at 08:59:27AM -0700, Davidlohr Bueso wrote:
> On Sun, 27 Apr 2025, Gregory Price wrote:
> 
> > This is one piece of cxl boot-to-bash series being documented here:
> > https://github.com/gourryinverse/cxl-boot-to-bash
> > 
> > This page specifically:
> > https://gourryinverse.github.io/cxl-boot-to-bash/linux/cxl-driver/
> 
> May I suggest using cxl.docs.kernel.org? I set that up years ago
> exactly for something like your writings, but never got around
> to it.
> 
> Thanks,
> Davidlohr

That's one option, but we discussed just yeeting this into
linux/Documentation as "theory of operation". Dan seemed to favor this.

I'm just about done my full first draft, and it's turning out to around
60-ish pages when compiled down to a single HTML page (~12000 words).

I was planning to submit a patch series that updates with each single
page to make it more easily reviewable for the group.

~Gregory
