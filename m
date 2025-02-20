Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCD121480E
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 19:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740079920; cv=none; b=Inex7ZF7jiP8brs6jOyiscY9Mhn+KCqvOLUiVtWYIanAZwesLZZwTz1l+KlYwlGHMgBAVM+V06mgnhJqY1j2wI+Ytud7YlGxFnpPIWaGoaFCwL6aTvTKOjqQg8hoednwsFwWO+XrOQlgkjTrc8YyZV6cvGRT5IX85tAb9T3sM38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740079920; c=relaxed/simple;
	bh=zKZRbmlMfiArVhLDPOtXDkIrEe3d98jChT9V5NFyQL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3qMb+cpJ0wBjm1vvRmc7nKAVMPVnyTic+ONprUDhon4Q217+EfCpOKeaWF76urjHs8qlh1sEMx8JLOlesVaiqf1qqda/TKjqWPdjZZaj6ci0OydUGwzEYfhO8Y2MGAYtwuXwP27llvbqAXo8iO4HdiojgkfOmQWI2mF4lGwqEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Fgg6DbOH; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Fgg6DbOH"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4720a115d15so20211371cf.1
        for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 11:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740079917; x=1740684717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5B3VvCvglVGU8mE6rfo8Oq9Xi4U6GIxDpJLBxzVgoWs=;
        b=Fgg6DbOHQr0YEpHX+8VRRJWLvqoFFEiJWHl7ZKBzIISFDv/wnbEL+te2Ub38obsSRV
         sXm7as4Efv2gXyWyRewNEYEZznp7lO6MztYjmjzUL7J6VyCyYXgxXQNsW9nJc3LwsSGs
         MzCZDv9uu1mhdEjp5Nl2TwO1Wz2eDC1jQfSlH4mtkwhbmaJLDL3h9jmqV1cPeda9RqNy
         IcVIv4xJ1MAMhtalHMxY0p/WzR+2GPhwe4hkKDg5WLpef2ym171+vlcTxB1+68YE89NR
         9ogu2URwNEGFk11w96TX9h1Z01bUAaUikHmw+PElIfuVGkz3UTA8sFv/r9o7XjvMYkTe
         CT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740079917; x=1740684717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5B3VvCvglVGU8mE6rfo8Oq9Xi4U6GIxDpJLBxzVgoWs=;
        b=AuZ43K6fP6eijoyhCZipuboxrVgTn1Tgn3oClr86Nuh4a5fbqmq6onit21YPVHfcVB
         eeHKUHy2fHaGR6hVoeXUnL1dKwjR7Klx7oFV93RT5QBLWMKNQ5+n7GEWxW9laRCVodCl
         u1cSLJsuHQCPTOHfHlh/AWTA9yju29UMfQgCQDj6JxP5WuruCwKWQIAfxxmc/XAgcFhw
         QxwFESoHKj/bu96TUhp2X6RxjYrYLCVtomFEOmtT3+SqGd1YnzhTxgHIbdJIyO8Xynep
         VQUFt7bUguMG6x5Uy16X4Q/dlximCnVF7OX/eMphON49LG3iv90ztNhLpfitry8f8fvy
         SHkw==
X-Forwarded-Encrypted: i=1; AJvYcCW4fTsvLPLaPrMXtHi2qET/dPsBjtMXB8wV4jDUbBgWwQRi/itubw+remKC6pQMqnessNAR0zGEjxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMhRTYLV7B0B8o8KJCqeIyPpAcVERL60cP9z3vKnRn73FxUqG1
	8hwLNzhTsuSz0qEUSGLsv9b/wV9iI7Qa1NADnkBlKKq6LrbB526Lpm77OUGNSpg=
X-Gm-Gg: ASbGnctQZS/L8KGLZkqam18I3CcOC3z6I1kLNS4XzEHHlThaFjzFiMfXuNJzYw8Nygt
	cWjZ36jLw4HuntvtMcgO25bRMTmHRuS6C/HeCwpLJEg33J81S7ff+C7Rnt7+1/nOcO7xotCCBIb
	iFp4VEk5mIschY29Pt1/cFYzeXR6ELDQqXEa1P4XvP/5GLr6A3tXyg2SUE+e1Vm/MUDukqcmSKJ
	eUFh77axtAirUO7FAtGaSNmTViaOilDFZtu+9wf51ooW7B9NJedkjS/CXzj7whCEZ2401vvXiB0
	Jflm+NwkVTBvVRQExEJ28cAfUGxuHpOffcdSDN40erZHgH58We9FT0H11bkaDsXbF0Cs/RDNAg=
	=
X-Google-Smtp-Source: AGHT+IFIoH2n7atYbRZlP+y6O4TJiqvU2UuxiHPMwz2VbHTgGdB81yXveIX9y8r445vXk2WbBopA1A==
X-Received: by 2002:ac8:5f14:0:b0:471:80ef:35e7 with SMTP id d75a77b69052e-47214ffad1amr59567541cf.4.1740079917672;
        Thu, 20 Feb 2025 11:31:57 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47207d1dc11sm25157871cf.6.2025.02.20.11.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 11:31:56 -0800 (PST)
Date: Thu, 20 Feb 2025 14:31:55 -0500
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
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 09/15] cxl/region: Use the endpoint's SPA range to
 create a region
Message-ID: <Z7eDK5pk0qLbo3BA@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-10-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132356.1809075-10-rrichter@amd.com>

On Tue, Feb 18, 2025 at 02:23:50PM +0100, Robert Richter wrote:
> To create a region, SPA ranges must be used. With address translation
> the endpoint's HPA range is not the same as the SPA range. Use the
> previously calculated SPA range instead.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>
