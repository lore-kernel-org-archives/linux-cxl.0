Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08DE2E3AF1
	for <linux-cxl@vger.kernel.org>; Wed, 12 Nov 2025 22:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762987250; cv=none; b=fkUQHIWnEc0EHH3rQO7bGelDI+KRk5cyTdwaPGKhnS4jl34eynqI4uLcP0SSq+3yvMXbnKVhkVXN49gT9OjzSEpwKwb18RsO/cbFZE4v9dAxTuR5ytBkOyYnucPlIE3+tIWTTKjfDN6AH+GWiIER8+Pp/BXJ/iDUeEkZQ+CSxeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762987250; c=relaxed/simple;
	bh=P8wB0FO0yByvcvYYoigc7wENN3w1QKW/CVSgfU3dczk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9Z6T8Vv5E+F0xuc+GCqB6UqPn+zGf0XEV66i18KC07cDLRLRrAHn2r/ryfV63EDRl8H/0yvbY2LYe8U3T/45EOdjnvrWYDdhCCisRZtf4rJBqbtZ8H3q0SYGzhQW1kQWiZ0XFixTFb+KnhYCVGMNg2Ck+VLSBH/1i87LKNFPHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gFuUU9NL; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gFuUU9NL"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b272a4ca78so27671685a.1
        for <linux-cxl@vger.kernel.org>; Wed, 12 Nov 2025 14:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762987247; x=1763592047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F17wxxxXjWtCXfhR3CI+FvZY7BooVKr92Re6tDYp9Fw=;
        b=gFuUU9NLnPq0pZltIS7VfSRVBI9hAcVHRRKJ9jUfTXh4j/PYZz0aXktUxkZLvcSfp1
         c/T2qLIVUjVgwvlm/T9qvbQOMG9DQnYApp/n3ZkuNUIngmsF9+V3bR9iZQzYnOGPsaqe
         8FRJXOYxh8yKmxRqa6kJAGmVjutpalAZr+uuKWNkKOEDPM8f701eQ9wLu+EVC3Y9lmXF
         bmJVI78QzSCqkdKZTA9vhq0GA3fdZNIXt6hewOe/8wGY2rFa25WFZME7G4lWynAoU5Jd
         MktZ527Rw80xRWTW6pvVn1FkowIjeo660niVLgj5XfimGTKGzj2YYOpP4ondsd27ydr2
         Y9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762987247; x=1763592047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F17wxxxXjWtCXfhR3CI+FvZY7BooVKr92Re6tDYp9Fw=;
        b=eA9L6/5wM33beBlA/g3uSE1sYQ73AZ4XRCK4s5SgAf6a1N2xrEn+qmVHSFfV+EQ2uH
         WOgD51WmoAUhvR6xV/qrmdEf0W78G+dmX6V3r/vWcWi5IZqtTXpokUzzqLO5FdCKE1ab
         6yqU+0n+qUn63E/4pTFELaNPrachFvRYL3IUNwJus5Xq/uFITmE3ek833rvIDuCLKZHE
         gTM6p8qQttc8BNCd0fxYiwZJn/gEsyajCqWC9ItjzOB2wxhpP2Ln+Yy6kgwuRS12t7Hs
         BAMEFKLxb5NgJHqgABxTplgTsx/IP2rXKnGJkbe1UdPcyuvR3Ot+fRPpBJ0UE9SmCQQ0
         PfQw==
X-Forwarded-Encrypted: i=1; AJvYcCW3lLBxYSFKWxKjziumsh1Z6dKVMiPsP9ej73YMRcwuc+lnMutMmN7Z/HEmXIkVxR74/GW/j3NBrsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxT/CFLhaEsVi3sqVrtGUYCIaEF/LtqewSIIn60vK38znPlGte
	IED7iuK2atAoNmdPgj1HqD8Zqofz/vxKSx/x6uy34UbZNND/KrAJRZ6rZaWMHvtXEpQ=
X-Gm-Gg: ASbGncuR/E7Nr5lmqTJgmmPPmMUQdYz+eF7iHsGIywICz5pSshs/guWSnZmFpSBgljx
	dAZhY/GHK1HkNJ/m71TQJjZFXZYgidNsHNu7MoHpgKlTOC9bKjb9cRDYWHvtLnCOxEXuKi56Cod
	0BMs2KdF34a/KuGMr3iI6tBw9dAIwG6Ybgv1D17BYzLsap5JPySErwi5Nkt8WlZwv6vd+cP7oQE
	ya6+ucsUzSNXLCfcuHM+an/fg0UceJSdeZsf8P9iPCmmbz0Knzn76Ayplg3qceH87oMF9zej+SY
	n7VFQjHQWLadejhnccq0swe86iQmkjD7whOFClrmRZ3Flotxz6Mf4gcqNQ4zc+3W6e9nayCGj3N
	j7wqEVudEa96CDj7LpONRJnFwDIfmHnaYAGmNAMPmH3EEmThfA/2I8jaY3qOQfubaeudH7Rc5dE
	uGCCqbY0pVoRBcEr3b5yaELJwJe4zbY0km8QSeLc7p03X0pNdkv0b1AE1GR7o=
X-Google-Smtp-Source: AGHT+IHsrZxr2i8YDSF/b/oh9D32f8B4GcLii5rT3OW7CqVC+9w6JNHV8qPW/fd6ArMwiMM3EC3jWQ==
X-Received: by 2002:a05:620a:4112:b0:8b2:1f8d:f115 with SMTP id af79cd13be357-8b29b7df2f6mr678375485a.65.1762987247480;
        Wed, 12 Nov 2025 14:40:47 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2aee9eeb1sm12252285a.8.2025.11.12.14.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 14:40:47 -0800 (PST)
Date: Wed, 12 Nov 2025 17:40:45 -0500
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
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH 3/3] cxl/region: Remove local variable @inc in
 cxl_port_setup_targets()
Message-ID: <aRUM7bij1XY6sInV@gourry-fedora-PF4VCD3F>
References: <20251112205105.1271726-1-rrichter@amd.com>
 <20251112205105.1271726-4-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112205105.1271726-4-rrichter@amd.com>

On Wed, Nov 12, 2025 at 09:51:04PM +0100, Robert Richter wrote:
> Simplify the code by removing local variable @inc. The variable is not
> used elsewhere, remove it and directly increment the target number.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

