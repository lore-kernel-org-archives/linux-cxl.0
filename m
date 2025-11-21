Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFC01AF4D5
	for <linux-cxl@vger.kernel.org>; Fri, 21 Nov 2025 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763749635; cv=none; b=FdVw15KiXNcXRe9NqmlrYZ2eKs4542i6yejqb5WS0ap9RPrkPXn2tbTXE1sCcj6ak1HCWjlAkrLiLh82YVRP9Vvx+J0DUF0TYG7ka0gfMhVEtAbSjf69PSof3cTtBp3E3mY3/jjMoJxvyupA7+iILlGUjpbjVdjyKwT3rzvWfaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763749635; c=relaxed/simple;
	bh=RIpIicnRHmRQuJRBvM2SWLEVi/ryf1VeYisOEFqReEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jV8IcLF8+hjlQuBqWRaKk2yGeHo2KS7kY4ptW+dqlWh50ALKvm93cS32yF7TiCkIUv3oXoOZSeDfTjRMgfrdtlFP23shqNpnNZmD0qG8jHPIhaYCte9/pW2D0BqeVmB1nhHLJsg2/TIgIB1Axl6ZDFQzEj4xSGNFkMlg/31Pmvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=nIzTxwdC; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="nIzTxwdC"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b2ed01b95dso231349185a.0
        for <linux-cxl@vger.kernel.org>; Fri, 21 Nov 2025 10:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1763749632; x=1764354432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BSM9j3tB0BFCd1CCyzkIWTNWPTuFhRIBwlbOOYldaI8=;
        b=nIzTxwdCwowG9WkkEHVkK0Oe4o9wzgOPDawTxTsGxd3KOHvZhTotXETK2RKHeVJBw1
         KfNMF25L/mpmHax9xiaxVVwVRHMjz9ppAKwKsZNjSwDU/wp2vEvIZUlsW0DQbN2Je8+v
         dJWN81G9ZpTwdvfyVuKy/kKkMwLJHNKluRBOs5PP5dDrnbVOsNLiF3w0p6Q3Mbk0lpFq
         b/jGf9rIWEzltOk+kdQZ+XUo08yh4I2aE3qp6ZTB0uiR0fHrd2rs9a4med+TmApmL3Dj
         382GeDK/ajyJDwCTdrvirJdenn3nfj9pgaoIzLQFZklOOHads7ZuOvB0Tc8/LOnrWZVO
         yAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763749632; x=1764354432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSM9j3tB0BFCd1CCyzkIWTNWPTuFhRIBwlbOOYldaI8=;
        b=ewMKvssj6CFTTW3sElgVjRUhosKsap9rbdNxvyDyH9NKKIV4JsN3speL87S8pBbTQb
         8JEaOIGsNA8fESYhZzb3nYHvIVOICGzbic2tJi988+tmDZ1c0xT4LAaKd1S5I7TDS5mf
         amGJe/CTv+0AXFscFD3L2xOBmd1oY7Bim8pDgo81RlnNJLJ3H5zPjGLMYigIuesXznzk
         q5iNID06VRg+mmo7/jzWBgDCydsQCUsmDMXpI7DeL+oXnleRh7iYxtE7JjQZe0L/kqjs
         WU5RRyZxqzBWe4WjScc3uG3j8s3o1CWc2oQhms7oRnUJQGUSzOrwoO1XL4fg07LmvzJE
         MVgw==
X-Forwarded-Encrypted: i=1; AJvYcCUYc2ZOuQUZs+uudMG+tRHJmNA+HzEU0zByIu7njEIDsJ6SCbjuBBBpWfD29eqZ1JcE2qU5tC8GKMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnNrWjQkl5q+2WVkp/0epO2nglN4iPhqK8udS/tINksppiZIiy
	D0L8hJFy4csBqz4qXKB3KT5hbVTz+zxsD8t8ByLqeaf97PoUj/5IJSXJEAbKadyW6uw=
X-Gm-Gg: ASbGnct0Jms6sAyErLGi8NUDCSYJLJGwbaxG3uKk234N7rMsXMyPvVvSC1Gw02Ofzw4
	8llUn2FhPKBZZJVERbXRd7wSCk9SYJeKcRMsZH2MEamp41eSeTkzssfQNu5Q1jhxoYtJZNN/n6f
	aWA7Nzey2jTiIPdeZ1pdFinWlaz0/Ilrtu19DEIJFtDb8wwjqMRMsqXHSjzl2/F8Z9tcQyuw/iG
	ESOEDt66N2sheS3k6BGOoNzM88+sWDsucQBh91w6g8q1tKBS+w9V8GMRo0ddhCJA3xIzo/IJzmp
	6MiajFFhsJ/i7KXGzsINed9U3px6zVCo8J/EVKopwCV6ixyE5t3kMEyhJUiOfY8jPAd10zcI6mP
	HLqCtEc1Jxu2dH6FU1OsJFzFqfH1ZbSdCCfHEeUrHbsguMajgZ7wLE3lMAgv4ouZT70uYHzfqfZ
	Jq/C5wjiHGEZulNtIn3CRjdZrRuQ2tIMXncRB8IoTdmDjVtKiA0SJd0Ibp22NP6VAgxkRAxQ==
X-Google-Smtp-Source: AGHT+IGKm8uH3sKDW5KC8Eriuk3f7FVRukai4cHX9cxHkx709+pQdR97f/CiOuxJQvK4Xa3LIBqdGQ==
X-Received: by 2002:a05:620a:29d4:b0:8b2:ea56:9660 with SMTP id af79cd13be357-8b33d1d0d69mr407483985a.30.1763749631705;
        Fri, 21 Nov 2025 10:27:11 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295c3306sm418206685a.31.2025.11.21.10.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 10:27:11 -0800 (PST)
Date: Fri, 21 Nov 2025 13:27:00 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Corbet <corbet@lwn.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 2/2] Documentation/driver-api/cxl: ACPI PRM Address
 Translation Support and AMD Zen5 enablement
Message-ID: <aSCu9DqRde7ry7l-@gourry-fedora-PF4VCD3F>
References: <20251121121655.338491-1-rrichter@amd.com>
 <20251121121655.338491-2-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121121655.338491-2-rrichter@amd.com>

On Fri, Nov 21, 2025 at 01:16:51PM +0100, Robert Richter wrote:
> This adds a convetion document for the following patch series:
> 
>  [v7,00/11] cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
>  https://patchwork.kernel.org/project/cxl/cover/20251114213931.30754-1-rrichter@amd.com/
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

With a once-through I don't see any obvious nits.  lgtm

Reviewed-by: Gregory Price <gourry@gourry.net>

