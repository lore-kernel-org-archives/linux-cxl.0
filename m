Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D5A1E22E9
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jan 2025 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736268599; cv=none; b=dFMW471uM0mQ99nvrBqmOcpRPdWRHn/xXLkLdAFUu7D+e27CiV6DTQ3bWaqE5Gq4h5pF9srdPLZjVCUgZ4ZMfJGF7Wxhopa4HoCwg+XZ3becvpHEQMLKlaCCm42Mow0by6piavKMCViKPU+oH80zgjOwsTwvR5innhtNAIydsWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736268599; c=relaxed/simple;
	bh=o+Wl34SdBo103Nc1R/lKqtrcRe1UYK9HPCvqt0cNLRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcIBQYJYa6gh1kdWQmlkeLByBrZ4n4ev4WPZW54ojceJTb8wYrcMNUOvKw2xRNe28F1vBtuIiQFHPPZRf0dmDx1kG7FdVLOGhCmCdsXI7sSJeZAYi8Bsmdjh/BWQKgK+4yoXYGlL7sQwTISn34FJO0tTU3WX0B7TbNbcNxnef2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Ll/Vy2bA; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Ll/Vy2bA"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-467a37a2a53so16921301cf.2
        for <linux-cxl@vger.kernel.org>; Tue, 07 Jan 2025 08:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736268593; x=1736873393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XPyxJ38MGo5fiKfUZUWa+5eEjSnwU1cZs3xFsnDOh8o=;
        b=Ll/Vy2bAWBJyq+81Drema0imI5VRthA88v+QfmMXVZMxuQCZvCmO5RMR4gbkGNoKoO
         PM5oriIaUCirNaneggtQGhvZK6zbYTGqx2ozm0j9HCPbDTXcQNQreDgBHPE3PFbDAJUh
         Jk2Uuox2dfhMlZ0pbHbsfRTrI4e19uGAroAcJ1lEXEXgNkkEBbFXQHHq7lkru3h+d8AS
         cYB9fzxMIZ/6Scjm3hPS2ka5Qn11pXk1zufh2GxSik6Tt4ZV8Tit5QXUo6+Od4JHbIf9
         M/gIz0K6hgrNs4XD+FKQTsc9jgomfqcrpERqx1e6LKcLapYI8GiBftHC4utmMXNkwOv7
         F7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736268593; x=1736873393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPyxJ38MGo5fiKfUZUWa+5eEjSnwU1cZs3xFsnDOh8o=;
        b=g+LFivQg0VOPP5Whuyx9Wboq54S2o+vWiDh+U2TUm2CKorek4kPgNtPgjWgXXX0vpU
         yPKX5x6nnJZ/aEQ80rN0ffCrLSuWBgjcddJWoOsFXw9O99mrAa4NAYBNd8hm3lgTBIPR
         0+rje2gP5VN4e+8SLKqgiYkhIKBFoT8jL4FbbbWp2nMaoUedCnpFatWxv9ELT+47xxTC
         ewAKZKmcbcwg0S9aviNscnIbMUB+NAH27Wrx8Ua8kWk3L1NzuPi3oVgK3KYGrd/jeN3l
         iFUrejunLlJmdMhbiFw1+G4fYZRKqictCnMfijliNdyJdfFs4LjWcxT8w7IKrxic0Ogw
         l+QA==
X-Forwarded-Encrypted: i=1; AJvYcCXNzZeULG9lsr/xeFwab4s2yY4tGtlyadmcCNgoUbc6wuou7xRZ0afZhnpHaKte8PJopDi1Slor+Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxads1cRWtjQvUKT00G5Ehu+PkgVJNaqm/yslAbiZRu/c89iKc2
	f9+ngfbZiWj/rlVmAhPWLkAR4C8bN+7v2XnQabOzebKzpK4JFCTXiPP5NZUQs+E=
X-Gm-Gg: ASbGnctjWmw6Zp3WuRgK+4dwLMkC3JZUc2jNInKmww/jpZwlRzu6gScEYSL96gZOCot
	I3k2upTuTJ30lF0/ox2fCLwXasy/PJzAqzO/1XNzZ8BFcwwcACaLZIRdNQVjx5JD+oRRnDtINb+
	yymnCy2Tp5+/y/yVEEt7C890WnESkKUBTyDLF8kslRnrI3gYIY2wxljQQJcRDijEB39p4V3Ps3t
	t0MlwWsgDPZXaoV7h2IqDHQDgdnoWYRCThuuZNrtwPpa6xlffaRHqckdmgT0UjgynpVE0C6eZy9
	UCQ7QWAf2lUclFRh5LUjfQa3fkX9x/9Z+SjPYJ8=
X-Google-Smtp-Source: AGHT+IFBSXLroR2FgsUlB0mbrlBft/EgrN6qscz6sm1Q4LClYVj49SJmQjMmH9K3UzEgee4wzb3bkg==
X-Received: by 2002:ac8:7f41:0:b0:466:b394:92bc with SMTP id d75a77b69052e-46a4a8b81famr955610131cf.6.1736268593595;
        Tue, 07 Jan 2025 08:49:53 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e6a106fsm187506001cf.38.2025.01.07.08.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 08:49:53 -0800 (PST)
Date: Tue, 7 Jan 2025 11:49:51 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 05/29] cxl/region: Move find_cxl_root() to
 cxl_add_to_region()
Message-ID: <Z31bL0J5H1d5R7JA@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-6-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-6-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:09:51PM +0100, Robert Richter wrote:
> When adding an endpoint to a region, the root port is determined
> first. Move this directly into cxl_add_to_region(). This is in
> preparation of the initialization of endpoints that iterates the port
> hierarchy from the endpoint up to the root port.
> 
> As a side-effect the root argument is removed from the argument lists
> of cxl_add_to_region() and related functions. Now, the endpoint is the
> only parameter to add a region. This simplifies the function
> interface.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

