Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6CD3587D3
	for <linux-cxl@vger.kernel.org>; Fri, 19 Dec 2025 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166600; cv=none; b=k4hfQlLLptEz8e4RDuTG7ANPYagIg9K1DARzkVLOZVcWQw38wCW2ZKFAEjSZ9fjKTnsaMqCWlcsiRHx9alIIK/NQfwz7gELZ2VonaKitbqAJo0eX1mXx2HTNUntt/X2YLQkjTd9wib6a5aW82GRAIiwsymp7qOWiCE+URZINFHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166600; c=relaxed/simple;
	bh=Omz9bF932KFBWAscAYwamtozRokHcfDIGRyc9I2hS7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kU/JlZOnyFvaakhLdUkDBNPSkI4A3/R0Yb+PvmGq05hQcZ230WQLgIsJnlIxqXH8h8sO7o5ym/8iJ+TV9HlSvnNXrPFIfqmhowIgKzKcWytRtveo3Bj0zn9idZLKTWkIQYpitKf4HJZH0Yls/hqB5MHAxL0Ee4HX2EkshSRYHZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=bhi8VO9E; arc=none smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="bhi8VO9E"
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-4f1b1948ffaso13251811cf.2
        for <linux-cxl@vger.kernel.org>; Fri, 19 Dec 2025 09:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1766166595; x=1766771395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jpsc03gYxvvzNTD6Pzq0cktCiuw/FsEgN8u4oLr2gDo=;
        b=bhi8VO9EfKh7/nx/DAQHawV7JKRJtUx1GmwVkGmJkwU3ovQO/pnNTyN6fz/rWUZ7ex
         bOZHfC5sHuaxXuPFsEAcYdQEwvl7OrfdzaANaXYWCcEugnL9G5/Lze1lCVQYNMB3motd
         RHJSGSV7oa/7Yi2qx8zgM2KKSLOHfZZUy6WHzN9AerG/DxzUbp1EmsT4hPo6sIWhptUC
         G17PTrit6eyPQLfmAQmRAZzwwU978+SL3z0X7AN+3pzJgCoJahUNpyKVrynecct6hrKA
         lvB/ij+pA+Yo3LSLcT6D4O0zNRwKghPCvtTptfsDkCTI5S1SEue7wKvilVT19Pbo70kN
         4+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766166595; x=1766771395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jpsc03gYxvvzNTD6Pzq0cktCiuw/FsEgN8u4oLr2gDo=;
        b=OHIwLhfj/5VjM3uVHc/LX1jA8xRxubwaCxZ8+sLVfn/an88BUmNomzi9Yf+bPeppm9
         y8Fz+6Szf5nixPJ+/qWHKr5UqbVYoj90pFXYc6+PehtDQ0XE4lRhBKP0Nro3UG6BocG+
         ybOCuZSKpu1Tq61NW3U16dm26455Gr5P8NfQmvnJyrLyJDAoH5TkeEuNf0/a6rv6E0hr
         NQQkwBmNatcd/QXgPrbxHtJ3msLt5VdD5RI+7AUapZaigxUzIAZLa6dsVyQPuD0SSgTE
         /9SadRtruxLeeY8ue+j9M28t1tcCLrMNCq60Zzqu1HdU9EerGG1TBdetUGEOk1881bYQ
         MMsg==
X-Gm-Message-State: AOJu0Yz2oErM56FTut7FncZbEGEK8tRHzk1eiWqxurXxcuGdo427HCLp
	Ri7gomyYAYMvalEZBewzNc1YAn9ES5ZaJkYWPEXtz4+U4RZsB6VE8m0zDfkfXi4f58E=
X-Gm-Gg: AY/fxX6MZHvwhLmpO/TUhlVaCXaXk0IHYTLkcG5TL8JtuLUZBKJmjPo3js1taG1FwKs
	Mm4y4ixY3+ey0YTK2VUwUfSlQAZFb+LJt4lHkBl9Wre/mDV+FPiTAyaDjI/aW0ngxTNGsPmLw8q
	a+0OIIXXl/+we1IPmQbW3kTHA3duAe2MnQKl+rrQkc6CKy/n1oe9rxXEuSWNvjvN4D2zePSLPHm
	5Ztnt1AAAi/4nkmmxVu59Ymg0JCm9DiJUEtB5109RuDwmEf4Jh9gZVNdx9KcGNnmmGjcPjR0jW5
	bIB5w/FMIWC29rb7SlYaaahA6JkKUNInJDYBD015eGWBuaWmCA6Ro28tafnQZoEM7Sa3MWs+m29
	RBiNud9K/b497fnN+hbSc8nVxz6pEIeacixLMtc+E+dws6/PyUKc8AcKGJKbmyJuML1nqXx0Lcx
	cACO1cJkFAN5hEkJH0j0AdXOYl+FJeewPFqmFmOFeE4wP+DVW6gysXXR4LLDjs6WxPyxi3sQ==
X-Google-Smtp-Source: AGHT+IGrrbnvLfy09qrL3xJF0W/Y+RTkhOgeFaJKT50olbcVcq178IYN/2QkszMJkf5iOxhFen/DDQ==
X-Received: by 2002:a05:622a:4c07:b0:4ec:f403:3019 with SMTP id d75a77b69052e-4f4abcc3ce9mr52841621cf.21.1766166595408;
        Fri, 19 Dec 2025 09:49:55 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac64c011sm21223581cf.25.2025.12.19.09.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 09:49:54 -0800 (PST)
Date: Fri, 19 Dec 2025 12:49:17 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, corbet@lwn.net, rakuram.e96@gmail.com,
	alucerop@amd.com
Subject: Re: [PATCH v3 1/2] Documentation/driver-api/cxl: BIOS/EFI
 expectation update
Message-ID: <aUWQHb2kiCdV23Aq@gourry-fedora-PF4VCD3F>
References: <20251219170538.1675743-1-gourry@gourry.net>
 <20251219170538.1675743-2-gourry@gourry.net>
 <20251219172810.00002e70@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219172810.00002e70@huawei.com>

On Fri, Dec 19, 2025 at 05:28:10PM +0000, Jonathan Cameron wrote:
> On Fri, 19 Dec 2025 12:05:37 -0500
> Gregory Price <gourry@gourry.net> wrote:
> 
> > Add a snippet about what Linux expects BIOS/EFI to do (and not
> > to do) to the BIOS/EFI section.
> > 
> > Suggested-by: Alejandro Lucero Palau <alucerop@amd.com>
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> 
> Nice.  Best of all I can blame you if our bios folk moan at me :)
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 

:shrug:

"Patches Welcome" :]

~Gregory
