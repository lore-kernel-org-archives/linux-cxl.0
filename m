Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BF82BDC33
	for <linux-cxl@vger.kernel.org>; Wed, 17 Sep 2025 19:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139136; cv=none; b=b//2WiQotyN1kIcdBPJuLKTd7laN4JimWBmwYHoBJjfWJMHQx5QTMgTaxA2fwuNnd4j5fSWv0KiaSmU3Re6s7+FGxvh26nd7+Act2U5W0QDuZKjmnOXqB6PZu0w3YbWiRwtXs1B+PPGXIy0jl9rOEhz/iZZ0n/WpIpUzIxZYats=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139136; c=relaxed/simple;
	bh=dxkk8tG7hK5JdTJzWjjKydDl+hoVXSV6oyTVGZWUjEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8u8520jc8mahXDY826GtiFfXMlOW7iIMZkoRl0hnDpesz5c/ZexMfyuM6k4fcdmfvsY/k4RiR6TLYd+kUVdYVuo1Ul+0TIki/6KWwG5wSOI3VPJMxtjQ+adGuyea8kXTJ70tMHYoyhnTOXRdab3O9wcR0podW7gW9ICUDu7qMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=eERBNmkg; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="eERBNmkg"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8127215a4c6so130940185a.0
        for <linux-cxl@vger.kernel.org>; Wed, 17 Sep 2025 12:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758139133; x=1758743933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=58ejY8lKzPUFnBka1rlupB1Kz/9dcjqxS2QMacOwEpg=;
        b=eERBNmkgWA3cSVVsKGfw5IaOGFyIH/ym+gmi6zvoehP7+M2Ix647vDLZ2fUR5QLlkA
         A+gfMsD/Ega05PmHKTt+SrDvykiLtDd7HeN0oS9Q1MAQ2zKO2pKLbgLqU6wFR9yO1DGr
         wM5HiWk8EuCvX8ncyJ3esO0DFLBxvCSeYALyowpWX8L2FfdYLU1PFAovziSO0NQZUO5n
         2S13j07ZYT5F11UU4FAO+9hMTSysEqmqprZP+cx1JDEyuUFHi6uvDjnHeMl3+sJs877J
         O7+j1l9fyxG+VnVTYTXwZCFFUyxiFpd5q6HFw+Y3g9p92vuEPkShA0F7rPAt9k4flq6/
         p7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758139133; x=1758743933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58ejY8lKzPUFnBka1rlupB1Kz/9dcjqxS2QMacOwEpg=;
        b=tDixmdP0mArFIdgrX79cmhPLlAetTJtbcQA6GI5oqygulr5Y7RChOG1MNZEtZPZxWv
         kogjHum2LEXeaznEy3k/BbewtX9QiQ+/alYrGmP1zX7mhFyoZQG3k1o2u+QJvD2l4Akq
         6bd6+67wBxAvtbp+e2lD2BZiBOki5vbwwN7gqsQ/gCtdxB/gxYHqnyEgqn6yJh+u+Uyd
         szhUbA03al0XGFAxQmqAnuIS2h1LNv9axiKAbnDhEbQ0Ia5oeHL/6FYf/78C12HTaB1Y
         FrQsrmbzELLqAwX8t78KEhEaycU3QRGgG+AblbPpoldqxYGqStm2jjnGknMq0G9D/Rh/
         3PhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmwIerszdPavPX8flv5+cfUSZejV62ElFg9dRd6wLwHyM9ob+OHkRZsFhD1Wx5drqRA/qNF7lezKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJTPZOXICrqlABD173e6N7p/6fyegbrefIqI6wKLY3mCnrZtX6
	w++ZtpcYwD2zycf8tEFRn8MQCUJaws/HuXvWe+It5IM0UOvLKdAPtc3qiYWtC6pO4xE=
X-Gm-Gg: ASbGncuAt3ryRStfmkgUZVqZOZrBnhJwwD11EnF13vCx9hq9oyPVEZw5+vR+fHUF9+3
	exSn1vTtp5z7H/dOs1HxQthMa5paF68YMNEZvfOT3+hWoCmLBj/7OsOQdQHWFPuCwES7eAqDr9T
	rc86FErBCzCnJn3j+oSjyegIlZyU4SbOXiWR041hGfC3O4vMJ+zY3HBizpOCkeuMvd4huZi0mOY
	04su7oSEWKhhcJGhwKyKWvEX0IYqTchyimQub+bYcTAZWZIwJLlwTT2Wj8qL0rBNcIdkfEL+Su2
	F1VMUsSjysrUUoE9Y2gJL4UTe4z6ME5OkIqZOJAw7WyhHywFFZ+membmV6qgZH09bIjexzIqrHe
	Ru0GzsHjtFkUTgSceNunejcqQTSINbiq/M0/EJI7Vqa82OHT/m6HdS+h0xK0LalzHlsD31vwOOb
	UZ9hs=
X-Google-Smtp-Source: AGHT+IFo5mUXlgWJqSrwW3Ag53sh8YnNIU8HxG9er19Nkhdl6k6VD/pvyTugHUvkMVjI7UpywYGlJw==
X-Received: by 2002:a05:620a:414d:b0:808:2794:7c40 with SMTP id af79cd13be357-8363bf2f1e1mr123738985a.37.1758139133063;
        Wed, 17 Sep 2025 12:58:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8363240f538sm34971585a.56.2025.09.17.12.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 12:58:52 -0700 (PDT)
Date: Wed, 17 Sep 2025 15:58:50 -0400
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
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 02/11] cxl/region: Store HPA range in struct cxl_region
Message-ID: <aMsS-lJqZCmcDQDF@gourry-fedora-PF4VCD3F>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-3-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912144514.526441-3-rrichter@amd.com>

On Fri, Sep 12, 2025 at 04:45:04PM +0200, Robert Richter wrote:
> Each region has a known host physical address (HPA) range it is
> assigned to. Endpoint decoders assigned to a region share the same HPA
> range. The region's address range is the system's physical address
> (SPA) range.
> 
> Endpoint decoders in systems that need address translation use HPAs
> which are not SPAs. To make the SPA range accessible to the endpoint
> decoders, store and track the region's SPA range in struct cxl_region.
> Introduce the @hpa_range member to the struct. Now, the SPA range of
> an endpoint decoder can be determined based on its assigned region.
> 
> Patch is a prerequisite to implement address translation which uses
> struct cxl_region to store all relevant region and interleaving
> parameters.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>
