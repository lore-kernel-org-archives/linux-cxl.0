Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5946478F58
	for <linux-cxl@vger.kernel.org>; Thu,  2 Oct 2025 05:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759384142; cv=none; b=GQSS9ZPvLwvDKiewaz5mfTauGwTtV3YSEJr0OhV/RkpJ7eHo8Kzn+fRjzrxT5fw4duH9NLuF0IE7mBcgbsdbPa7sA2KliQNPiw6/mWr+yJcm9VEB0SMRB2DtxWCFeRtSc1Jzt9ZezbmcdCj45Zv3cZd7tZsOk2F4md6umQ2AIfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759384142; c=relaxed/simple;
	bh=wcyEKCO6iRV6aRiIOdMgZ+yCTGNmYXo0JcYAp+28Yd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbmYcfr1CqybGJer05KkYqK9sjIiBRs2nhlUjvXXGmSaR43rFdhXjykJvdmS/klte2lOibBaKmiK5zs0vBye2CK0e21SCCB00kP3KQ48pUDMW7WGPavbFEjGpRHN4AVV/zZj3gIHYFXhIxy/4BQV+I29D0KlBE4o3AVK6X1Wxv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=G3nqAeIc; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="G3nqAeIc"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-863fa984ef5so81740985a.3
        for <linux-cxl@vger.kernel.org>; Wed, 01 Oct 2025 22:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1759384139; x=1759988939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qPH+KrW9WWxU2Cy/czL4pPvnzuAqDNan3io0ryUNydQ=;
        b=G3nqAeIc/mS1fO15vQgOaDwngfytKFhNUSMKc2SpvBo2aXD7QGRZNFocVFAX9+mM9c
         q8dAxt3lzh8EqWhT8wtli9iPsGA2fyZyHaEVSykxAZjdtZHSXcGS9DIyQDqe972odGpr
         z8nWRYyE0YjtMv82bk+FiLW1ouIFZPD1pEJJIkgtoTfAEOOjJeE4tk2v4cq7HAHSTdZU
         rD1ajaF2/8cPlSRg3yX8vmjbfz4tm93Bs7UQf1cta4iprv41ygNaUEqzvwrj37URyc60
         Q19XYtg5oX6up61l9iLgy+xtUVLP9tOw+NN4m54rVR2YqESzPbZM4dcbSjL0nSc7C+uS
         VLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759384139; x=1759988939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPH+KrW9WWxU2Cy/czL4pPvnzuAqDNan3io0ryUNydQ=;
        b=JO7INDUPbDZhBzoNHsiJV7z/81NBap0TgyvgkqVwKJJ8SgkZgthd5O5ArrElUhGmPn
         CUo/EmMFKbAP6GaBrKtvrlOLFk6Ne11BZ2IUxVDnGkz+NiNG1iFg8vgU4/Lb8m5f7vJp
         cWitpj8+K+BcgHe5+dvTDiNSv/hGF2hfV/Hjkum5mpnSb3FO+E4+2yYhKW3zkFCKOWod
         fUUt5e/fgVyd4LAwb2cqsAXpNqLqidemue+SHj5U6BMQmqs1czQ1wdED+/9bueHXLcTR
         t73+rnGlkWFj8nVzoZGrcds8ciQf+Hwoz3UHZ9LRr7ElJRnSJoGFulreoymJdSBCgMcF
         i3kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNfbasQiCoOXNunR6pwymm6EsQzW1/PyLVln8Q07I6FhXG7PNJ3BA+gRImRnn4quqCO0IrPoGqeD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTCw45WT6OXdTVmo8odHih1Mks7QW5mbSH+Ou0tKPZ3fUdvofo
	Hr0Rrr42Kr3vPJU/9SI5KvLmrB2ZHttrpZKpcEwtXpuEhy7mcKmnvUvrVhTtP90XPvs=
X-Gm-Gg: ASbGncsV2akxkKVRKYTLTMnJFqwAIHsrzJNV1l1oCxWdjerlnqTF9HhChmJCxTLM0oQ
	4KxAxtXtlL0sT36Na+/rSdFC+sqXY3fKe3W+Ezf7n62KxTDFIJZx+PWj0h59qjuW1pPrF1t5C8C
	Xpst4Gkfzt54HKUoB2AHa7q9NuBtke6wiPFhhNqqcwDqledaj0YorCRS5fhFi1w3Th2DaAyURbz
	bS/UevA82xSEY7FqCwHeNhJOeVjOGDKM0cqCmAoJus69Lg5LV0Xu+1Zxf84F24taA2x1LdX77YC
	A/M4dEh3jI3WolPqiCTyANpCgWQTraFhw0kYpT467CTXfd3tY8tNl50cgjj99Z48QKlxohnVRle
	IFU0PGY3+4xtjjvMXhztNoch1zludc3xDJiqG5J4k7GvDLYSZ5Le0KKxW8lxVP5ItaQCbja6HCH
	iRPRMgg9EJsTJpwZOEZ40ysX5zxF7FlA==
X-Google-Smtp-Source: AGHT+IEhx9gZlJzZ4Qi6qF6wm60KnmFGKzm8v1QKTSYmj/krU2YemQjmdbWHw9GBA4Ia0vSPsAekKA==
X-Received: by 2002:a05:620a:a08d:b0:877:8704:2c1c with SMTP id af79cd13be357-87787042c37mr230208885a.47.1759384139185;
        Wed, 01 Oct 2025 22:48:59 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87771129fdasm149560185a.6.2025.10.01.22.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 22:48:58 -0700 (PDT)
Date: Thu, 2 Oct 2025 01:48:56 -0400
From: Gregory Price <gourry@gourry.net>
To: Vishal Aslot <vaslot@nvidia.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
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
Message-ID: <aN4SSEmaCaxbeiwJ@gourry-fedora-PF4VCD3F>
References: <SN7PR12MB81316C958DF0F4B10369B928BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB81316C958DF0F4B10369B928BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>

On Wed, Oct 01, 2025 at 08:37:26PM +0000, Vishal Aslot wrote:
> @@ -1210,6 +1210,11 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>                 rc = init_hdm_decoder(port, cxld, target_map, hdm, i,
>                                       &dpa_base, info);
>                 if (rc) {
> +                       if (rc == -ENOSPC) {
> +                               put_device(&cxld->dev);
> +                               rc = 0;
> +                               continue;
> +                       }

How do you suggest actually testing this? I briefly poked at this in
QEMU trying to commit decoders, but i found myself incapable of
exercising this path.

>                         dev_warn(&port->dev,
>                                  "Failed to initialize decoder%d.%d\n",
>                                  port->id, i);
> --
> 2.34.1
