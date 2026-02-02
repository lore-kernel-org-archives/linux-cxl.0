Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EB2303C86
	for <linux-cxl@vger.kernel.org>; Mon,  2 Feb 2026 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770061939; cv=none; b=tC45FSkCXaAvWh3HAjlF5R6FlnoVuwPGK5Yy7FC1+jb+yEs0uSwArgmRcNzCMicS3udy4Ne9QQtI5neADWeo87dw7iAFvJUkcI2G3zH0ARQ2iQiQYZDdFTydq4nwk0Hqt4BeyUaLnc4IjagMtsR39diCeLDlirQ3wYA8ATNPfa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770061939; c=relaxed/simple;
	bh=iHwVM/IQCYrdRxSOrhIOx7Y1Q48Fm2ITli5IFwO+PLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7KauA2ETUNW8PHlfrt7IfZZQiAwa0xH/qTZWlFCkkRIhXBvZtP6Jw2urKqsSWdPwGDzMHNQQyNSY0/o2Dinmwjeq/YxwSNswayVgOQ/G/gbXEueZxmwcqmlUNUqCwdF+w8ZVRulGdNI/py/qetvXQTj1XfaLszLOgsEqc/Ys5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=sij4A4ak; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="sij4A4ak"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-502a789834fso44655931cf.2
        for <linux-cxl@vger.kernel.org>; Mon, 02 Feb 2026 11:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770061936; x=1770666736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6vWYyRi38ay7knCeZnmEa05emjEEY8IjE/qthmXHUHk=;
        b=sij4A4akkt2yJnwqnv03pZ+8H4SYlwqDDvV07U26IHi9t7LCM9mc7e+vBt531NYgiH
         eXf4DPTOh7NF3sYDkKWfuFI2eiu6uQJE/Sc0MpkgOGWfA+oNKibxZh//BxjOYde/yHV5
         LpsE9osHfUxFNOE+Sbtf+G4BExvfa16Pn+psAzhJnhVxu+3mNlvvdKswI/KqmVQbBhNl
         MtdZxwMCMtnwYtYo9zOMR8y6L1XJf9htI04ZCAv96PJYCsJ3cCLZjXaY6G/5NCTqIIIF
         5Fon75gHmzCdrsDEImLgCk6TZydwh99of/3LlWLjl5eNaRMZiJwaqPgx4XZn/mdaFBYa
         zPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770061936; x=1770666736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vWYyRi38ay7knCeZnmEa05emjEEY8IjE/qthmXHUHk=;
        b=pfQtl+xSFRJrua86V4Jpxcx5pXaEvfW5CKvmWJwEJbV/80sNZjkvN9hizFPry/akKJ
         AAqRtpNLPprp/SQuJ+t9hXgNUxs1gNHLjRW4E4KHMmrM2X9QPo81Sc2ijaz6AtEFDRop
         7owLVj83TZ8DW/kOsWkqaU9Tb6ZY8sJXpnKGll+56R9TQ2ahSgPDmg2edJ31vwX5wph1
         cc1ElNUgTCqjsTRKdG0+bb8m1XwCS44DijBHEkqXwZuT9pHQ3mIpvC2rdV+SLnlF9PGj
         p8UlZ21m1JsPzDiQodeXtJuyM6pQG8gUGYoyabpe4EzV6Qyv6nBmkyAQPdHO7NZyLm7l
         Lz0g==
X-Gm-Message-State: AOJu0YyxFRA5rx2cs6LCxYp3NQ/v5zf5hKj/dlebuIA6Vw02qO37NsPj
	qiVcKlq8TEg3wnxHQ8kiA8EIVluj0y2TzRgNNKIu2t8LhpFcyX9Ke/xt+hy39axP40U=
X-Gm-Gg: AZuq6aJMrfAcC9N+KwSY+oNU2KFTVj1NDXKTE/BXeRsoXnWjRn5YvIZfoX3aMBx0gzf
	J5dSBV/yOotWKAkxUDvbcjMGiCXUZLjBmGqM4N4XO+gq/ER6nBls8xviprmwMXqxfiiYJpl3u+i
	I8L06ONi3iDFOwdu7O2rFVUencrvUsrnvULPiVFJ3fyDgXXtImyTalF890VjJPsY71j81uK8Mpa
	V9bZy52+fKLbfVeSfHT7K5LGzyZLw40cEC3t0ugCKzbBKjm37rqlQDRFkOP69GzUo8ma0Kc9rHQ
	edrAaNpGF7IhWwU1/UZQeHYs1EHa/fEGbJOnebe47Pk0fTUthJ2CcVM4791A1FvAmxQtLG7XLpg
	OxznK466bJ2NHo4wCzo08uXOurMLKcHMYKnHrNLoPn1c7FyG8ig5rRJPcQNaOlgRxIpN4+KRPQO
	MA1wYPmVcmXjy8QjVVobn2e89BfMK47E1Fp8pPrOovyOhE3bV7VxcbckRxWc6VwoNC2Cy1bg==
X-Received: by 2002:a05:622a:1ba3:b0:4e2:e58a:57e1 with SMTP id d75a77b69052e-505d21d7100mr175542631cf.37.1770061936249;
        Mon, 02 Feb 2026 11:52:16 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033ca9d5b9sm103647231cf.13.2026.02.02.11.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 11:52:15 -0800 (PST)
Date: Mon, 2 Feb 2026 14:52:14 -0500
From: Gregory Price <gourry@gourry.net>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org
Subject: Re: RFC: CXL Isolation Support
Message-ID: <aYEAbq6UkQD7mqGM@gourry-fedora-PF4VCD3F>
References: <b4f7a760-5cf4-4343-8f7e-9698ba435fa4@amd.com>
 <aX0jC3DEqcnyrg7x@gourry-fedora-PF4VCD3F>
 <df6bd8d3-f11a-4b19-af56-1593e5c87298@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df6bd8d3-f11a-4b19-af56-1593e5c87298@amd.com>

On Mon, Feb 02, 2026 at 11:30:58AM -0600, Cheatham, Benjamin wrote:
> 
> 
> On 1/30/2026 3:30 PM, Gregory Price wrote:
> > But, you can at least get data from the system that the link went
> > down and even have a chance to investigate before nicely blowing up.
> > 
> > Which is at least much more helpful.
> 
> Recovery is the end goal, but not the immediate one. AMD platforms don't support
> recovery from isolation at the moment so the goal is to just keep the system
> from immediately resetting when a CXL link goes down. All that let's you
> do is a) choose when you reset the system for a repair and b) get more debugging
> info, which you already highlighted.
> 

Ah, another issue for type-3 devices is where the `struct page` are
hosted.  if you want true isolation, you cannot allow memmap_on_mem=true
for CXL devices, otherwise you can't even guarantee kernel safety.

This has implications for maximum capacity of the CXL device (must have
sufficient non-isolated capacity to host isolated capacity memory map).

This policy is not plumbed from CXL into DAX at the moment, so whatever
the default for dax users is being used. (should be =false, i think)

~Gregory
