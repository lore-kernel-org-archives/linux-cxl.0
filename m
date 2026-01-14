Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3E6285CAD
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 18:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414728; cv=none; b=HtZCKCsUukWHpoKjTA86uMDWqyICJJs2/Q9wAAEf9avyXKkgwVQ+MOCFGu7C1a7BGkISjq7qHbXB2Y+1O/wVQxpAalLYBFn/imBS1ALaEUP2Q7Woayn3Bv/67zPNSpmSjOas0S978gFOpPraCOo09sngKp7laXLK52hjNVk1zdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414728; c=relaxed/simple;
	bh=nvKWR5nnAzHhlGbNmiAcErLJSBsDgEBrbGdBWFfzM3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIZxceJ0afpt9LTlWlHsAVuanCjK9B8l5trNIzTbKSF6DFsAHeqPtJrxElWWU8QGTET38RDYw+LQi4cDIwAm0TStsoh8tMywcTJ9mPrxO9SxPUazNsXPgUT42PkJ/XIFp4JV2gE3+et9W3wqIS/ZlJRWmVuYcgnxr4ZyjjlQb+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=P1eQG2p9; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="P1eQG2p9"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8c07bc2ad13so7316585a.2
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 10:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768414725; x=1769019525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kCRHBPEdLpSaT9XnA1UF9iPTP5oMnQq3mHDp21dM8hQ=;
        b=P1eQG2p9bGH2NiP4/jwtMPtiQ77hA4tUxXh1jy8LEGZ7nGgunmE96+ZmwP/0dBV8nM
         OTsylxJFPo/WhzHWmJoBoDuC89XpmJqtKfqCQM3xc3NsXlBkZWZJexSusQTp97UQd8fz
         /LiNTDXM2pwR8RtPFw4Vy8frV3UYJs0wF8fcaT/DhSfjt4/NasVFXDCiR7B7oz0CO1EW
         /WvK1sDBydwo9CmgOSAQS6TQ0MfnY10gfc2hIb4ekCIneBqgJG3cmEMteyLsT22jOUHK
         Fy7BXRTeFqvxyM9VdzRpr+rP2KPQLNWNaJxpcfQnS98ALRHMm1LD1SmNF/3X/CY4ubpw
         8BRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768414725; x=1769019525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCRHBPEdLpSaT9XnA1UF9iPTP5oMnQq3mHDp21dM8hQ=;
        b=FWON/5OAmVifN379rctU5mpDc7DeL/a7es+cMMxQnbdeQISJ4LtURfj782djhKSaxv
         XsCia50NOKA/NiLLmaYgPXUfiRDb3gU/+hWJX5aXywgymzbvIDs0xNvL9+PgWOAhboN2
         pD9gqAIrsnC9RIUFFhhQN5vLxJzfoGy4f/GHGAX1uwn81OKxDk4wiDaN5NEtXQSeCA/r
         y9UpmKQpUXN8IDLIihR3P8Y4B236N8wZgqAps+cC9viKtpH2OP7RwJiHmG3UnpX8uYFS
         ysjyRad52TbJSP7TQ6ReGzLnU5FTsw1vC5J8hKR7VfPPVdgWZQp2jrnz8K/c6NB44pWg
         iFew==
X-Forwarded-Encrypted: i=1; AJvYcCVgYIMbXwy8aWCAq4gT2I5x0LJL0NMFw7dPLgJgatAIUc388TanlnmJEhBL1cZX+r16GFK72ZBMPe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybl8XNE1rGTEx8vW222jcDDf92Kzb3HAwCbqGv0BWUU5/Gy/L+
	0PeqPElxq+1qMzPJeAxJ5fjXiuWpvB7AsZMgPBqnsqUVNzX4NzaLtTJjsxGa6aUXdLc=
X-Gm-Gg: AY/fxX6KNfdkApJNlkxahjnW3qAFNugyz6jx7CYDkPaCCVLGM11i9KrC3LBK3luLp1Y
	Wku7e+8qVKhuHnl3PkSH3JYUy4twX532b6E0JmLbv/BVJuS/imACekvoHvS5OgQJafm7BkR5F9q
	DVxpNSeERY5teYTRKiHYFvcPRSiHbSRRF2kYQb6WFy/IHwzDAtsJS359uh4oOZ20gVpD2keBXyw
	NYOdO/Py8zTp18pqvwjN4YMt5mX7RZVLidAIBT1jMU+Y4gxrYTKXpP+tzqOtQN+rByRGUllP96c
	Fte0b0KZami1dnTGHLSZBEfgHA01R3KVJ1M2mdoRokLxOIOJn16bqV2534YnpyyfeGaNs8jaTnR
	/PeUQKsH6kdQJjn0VmP0VAlDkRscD9aKOfcF1q5SI3RgsRzzjLek6LDSNMqGEFphjKz/L98gERb
	bOtrdwPx+PUpnsrQvV1TEOX10PJWL5zPTwS0r+a9TdsblZvYCJKdk6CRdXZuW2TYjX8NHhyJdLo
	/nPf83H
X-Received: by 2002:a05:620a:3724:b0:89b:9b75:f5f1 with SMTP id af79cd13be357-8c52fbdea7emr538217385a.53.1768414725232;
        Wed, 14 Jan 2026 10:18:45 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c530aab8f1sm210480985a.23.2026.01.14.10.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 10:18:44 -0800 (PST)
Date: Wed, 14 Jan 2026 13:18:12 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Robert Richter <rrichter@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Corbet <corbet@lwn.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 3/3] Documentation/driver-api/cxl: ACPI PRM Address
 Translation Support and AMD Zen5 enablement
Message-ID: <aWfd5L4bPk29_AeO@gourry-fedora-PF4VCD3F>
References: <20260112111707.794526-1-rrichter@amd.com>
 <20260112111707.794526-3-rrichter@amd.com>
 <20260114180000.00002533@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114180000.00002533@huawei.com>

On Wed, Jan 14, 2026 at 06:00:00PM +0000, Jonathan Cameron wrote:
> On Mon, 12 Jan 2026 12:16:45 +0100
> Robert Richter <rrichter@amd.com> wrote:
> 
> > This adds a convention document for the following patch series:
> > 
> >  cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
> > 
> > Version 7 and later:
> > 
> >  https://lore.kernel.org/linux-cxl/20251114213931.30754-1-rrichter@amd.com/
> > 
> > Link: https://lore.kernel.org/linux-cxl/20251114213931.30754-1-rrichter@amd.com/
> > Reviewed-by: Gregory Price <gourry@gourry.net>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> 
> Head hurts from reading this :(  Hopefully I never do again!
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>

What's one more layer of virtual addressing between colleagues? ;]

Glad this looks to finally be punching through.

~Gregory
