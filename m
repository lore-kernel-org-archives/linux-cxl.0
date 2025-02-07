Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064661624F9
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 19:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957197; cv=none; b=oa8HmGUJs+In9fUnw8pPm33EB5mq/C1m4Nr9/BoYethXvDpBZvRCQNK6RAIlNhNXAvauk7DZPjFkWXHA2M0k6o4p82yIObxnzcRXGGkpOOgnf3OIgP3yW1Zp2CqenC2RitPZfZ2oJJSH59ct7/3uwQQQ0/wHDHKQJPBmc70SN+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957197; c=relaxed/simple;
	bh=s68IMjEbM4K+2/scksXJORrf7isnIwyyzdntKTO/ea0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8yV/uR8tcx0cj4NCeN45WaH13MHOS+w4WgzlVsirCT46EYX9b5FA2/U8mZoojf+2T7VuYMfXyMJoJqBcOgZV4gpQ5Hrf5Q5lRyaHazUidsPB+HbrISpsdt/FmTbPHlfFxwmSGxC5Xq4Su0qUU//FuiM91S7goOfzOe+bl9WkO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gx+BIpAH; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gx+BIpAH"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46df3fc7176so21426141cf.2
        for <linux-cxl@vger.kernel.org>; Fri, 07 Feb 2025 11:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738957194; x=1739561994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HoCXaz7FZACGfE1FRe1gWStT7EUpURyoBtQiate1bg4=;
        b=gx+BIpAHAJvejz7jTsL32KD8GaArD9zgssrqvClGHnTpcGmwzeIEvI/SK5tYVIgPSO
         FHLV9/iGzu8w8SBqERyoHqaOycd5GzB+BXLxg1ZR2T82GtzsZdm5kJe/e4rerriMr+BW
         RD3o/T79ExaUPEYLzmj+t73FgYG15gg4+d8uETCdxvZUzsOmsvh32LzQDekNfsuHLem3
         6f92nu9gIy2AYBLF97k40PjxU8vkrL2pfOC4J8kgeRKRz9Foi4M1nCN5XkOM65p5SxMs
         x59ihCuep+bSoUYHZxaI/Z32G2BNFHFyIlV5qdDDz13LDomI4FYIq5wNcijCcZkTjsok
         JhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738957194; x=1739561994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoCXaz7FZACGfE1FRe1gWStT7EUpURyoBtQiate1bg4=;
        b=lTaRORkwrf1DuHjKQOYFBLdOg+xkPrG+KyH4f7Pjn80SBbJsEtWkZ34OaE3ITEgv0/
         Hl13CjvnojQ6OuEGTwLpMBCZnDcWfGVzEMSYGu6QS6KAPPsa01umgdB46cRnI05GaycK
         BuQi3ezL+GXKhIW8nS027DP0STaKtvYsnjvqYUzmoIRdbt1hSbzDPDz8Ob07sAZbEI3K
         mRZrTx3F9/tyK3CSmkqRDCSIs4W9K7Tfq/Ma7KtLTDjsGN38b7hGN62tbrbj77S3BoRV
         39F1HINgQOpp69CvyNEELlI6iKOYB0N5cWh2q5wliTMVep2Msuy4trSw4THw60UBf6NU
         lMXQ==
X-Gm-Message-State: AOJu0Yypn3h+saUHMvI1poD7g5C+i4kz20p0UUoIpzF88lCqIMro44MT
	CNrz1KI/hB2dzi4JMuoRJxT6K2KkAm642wrKUb12QVajmzg5p43vyeqWrApxgx0=
X-Gm-Gg: ASbGncsmxAKirOr27ExQZexVbL3LI4+rxWrKuXp9IoCw1zqkj/wjNjug1Eed2zA8pFv
	J207/bQVF8ItZ6T5fUIi3v16hGlquzb7hPX3c1ae+86mFwAi7nhTqEvOCsU7IhT+4cS5qWJ1HYV
	5Lnr0QjwtGuQ9VPGSSx30fGTXFA6+8/dLWgucAsnGtdsakT2ZBW8KnXbRmuO4MfdL3RzsRA8z6H
	KI6UElUubWOvdM9m8P/PJ6OraSIKp4vpycW7Yfx3M0/n4tnAzfGCOJfa+hCAEImZguz077psJV1
	6YbA7x2oLEIjjaSHZEZrGEt3k5JKuvdbr9AqP2CKsOgURXkfHFtucW2sTf8n7Vc90py/zYyPmw=
	=
X-Google-Smtp-Source: AGHT+IFM4XYo7Sj0iZNNa5Y9RLAXbsSkxk7abPcbr2zA4DPL877A+xt+JaTMpBqXgKQnFgS8Cf3yJQ==
X-Received: by 2002:ac8:7f55:0:b0:46e:541b:c80e with SMTP id d75a77b69052e-471679ee853mr72470601cf.20.1738957193702;
        Fri, 07 Feb 2025 11:39:53 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471492a856fsm20177991cf.28.2025.02.07.11.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 11:39:53 -0800 (PST)
Date: Fri, 7 Feb 2025 14:39:51 -0500
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
Subject: Re: [PATCH v5 08/16] cxl/pci: Map CXL PCIe Root Port and Downstream
 Switch Port RAS registers
Message-ID: <Z6Zhh9MVjee4dGr5@gourry-fedora-PF4VCD3F>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-9-terry.bowman@amd.com>
 <Z6W2hFI7UsEslB3U@gourry-fedora-PF4VCD3F>
 <6749f386-4bd0-4395-9ad4-a9663fac9bc1@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6749f386-4bd0-4395-9ad4-a9663fac9bc1@amd.com>

On Fri, Feb 07, 2025 at 01:08:35PM -0600, Bowman, Terry wrote:
> 
> >> +
> >> +		if (dev_is_cxl_pci(dport_dev, PCI_EXP_TYPE_DOWNSTREAM) ||
> >> +		    dev_is_cxl_pci(dport_dev, PCI_EXP_TYPE_ROOT_PORT))
> > Mostly an observation - this kind of comparison seems to be coming up
> > more.  Wonder if an explicit set of APIs for these checks would be worth
> > it to clean up the 3 or 4 different comparison variants i've seen.
> >
> > Either way
> >
> > Reviewed-by: Gregory Price <gourry@gourry.net>
> >
> > ~Gregory
> Do you recommend moving dev_is_cxl_pci() to pci library as is? Thanks for 'Reviewed-by:`. Terry

I'd have to go look around and see how much the PCI_EXP_TYPE items are
being used for comparison and how - I was just commenting internally on
this patch set.  If this set is the only place it's being used (so far)
then it's probably not worth extra work yet.

~Gregory
