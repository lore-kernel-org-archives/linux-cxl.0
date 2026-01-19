Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E3E37F758
	for <linux-cxl@vger.kernel.org>; Mon, 19 Jan 2026 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768834840; cv=none; b=eVgx0q8S/9ETOLt3UQEkEqkvY47Jhy+DW/H6lPMJgLDzUOwZYeGxuMd+h7nBn1ZpV6VRjw81bEFvcf0KL807FcdVC13ii+5ZwzfSjZyz6kG3wldgbuBdXmk8nA9ShQTH2YUGP06kBRlY/BcFuM1Frccqs+rdrN1LFxPN2rVSJiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768834840; c=relaxed/simple;
	bh=dZ8/Uvzir/Cd6kL8vqmVwfp/zyfT/E8c+UnLN5mi1ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPh5XPm7jFrVKqGrSxbFDnTxq10H9MioXDdHGANTyHS0FUD/qS0w0TSy2IdvnrRENUmY0OkoqPIrgoCOjazR2M0cWtdAc8Mi35P1rQnukoqvWta00yssB7YRa3kqc4RgKASVk/Luwqc1Iu8EUiCb/oDfAhBhojbcB2jJ1wHAMlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dSqxJtwk; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dSqxJtwk"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-88888d80590so66887716d6.3
        for <linux-cxl@vger.kernel.org>; Mon, 19 Jan 2026 07:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768834837; x=1769439637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bhXnXBrbzOdj0aDVbjPw6zJPfUNeHNhpbs6+OlN4LMM=;
        b=dSqxJtwkvqEoWOTsy4Bf3kon+2yMc/esz7Tm9lcBUWedB9cMRDNS7+VnOyDWC1MMsW
         PeVodG1eXrXzQ7nZhmKNKmDHJlORyM4sJw9O4ljaZvSD4cdRZi3/L36I3NEfFkWfS42e
         Abvf1hLIE7f7C6KIpgaPmI+XvV+gcw7gPSnicwRNG3vYSKTWB1ddjIfrTwVXc/q4MQ35
         FxP10sD9AepgcMih/8DzgJU0GGKZZMkK7nM38Vd//AownPGGGfruDCpUdxt7nsTn0BQ8
         xEoNXo7/t3mMJ6TWSx2aSM9VINZYTlU/a72FqgFEgly9yfPK5MLHuSi/bUxXRUVvjgdX
         Gy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768834837; x=1769439637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhXnXBrbzOdj0aDVbjPw6zJPfUNeHNhpbs6+OlN4LMM=;
        b=IZFPDUW/fLYFOChkU0minO6tBu7oq5I+V/RGr5Z7OsTYuYRFQxS2BQoIv5T4ugePP3
         UbSrT6344afyEGLkQTGG+eNgrzYzZeZNy+dixGj4DGMLIA/JXalRtZQBZShMlX0eabCe
         T7I99CPm6scZDDcEjXYH7aUPQTvvfXPSE9UP6y8Pk0yawn7CN5DuBgYwmz3uCK/rdxKU
         Ssw90Df54UD2kqPshLtcZk45X1uWs2GCZkzbV9p73Cu8lDZGP/7HsUKhQcYYZe8wHGJz
         KUb2yAEKP25QNMm5/K4EKU52yvEdKw2KtKTgQwfGFheo+q8vC/Va5LQ1jnSjl2s+uF49
         X3hw==
X-Forwarded-Encrypted: i=1; AJvYcCXKEs+zI3Bg6nt7Hogay31SLwfgkXz3/sgvq1vVUfPm4m7eQYcv9DrKRvaX0wCsZs7lK4hudeaHyfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFp/obt6VdGfrN+J4HJEPQF6dlvC96EUBXPHw+o5iR0mrvCSJJ
	ntTVlaDmbu6J421W7BrexiLXJN9P7Ln8zc7urfxpveIZN/WG1qtKpwyaPZYUlEAS5LE=
X-Gm-Gg: AY/fxX7VjBEXZHh+NVDJRa50Vf+i+Iv+RjvZzVAP1SDihYYgyqqVSe3i/8Pw4gdwILL
	VCrIW0Lc1Ucb2Y9PJXtU9kC8twf0vhsYjJAu6jlGBRPszyU7ZS8DfrjAJn6f+6v7mzX6hRfND33
	PdRRCjvKzRAdCN6lPPtPVYPVp7m2jIbL9GSeKpYKvMV0o/5E64Tk3Hcvw9bWGuauJDDU6oM7L3S
	EvDOvg7TUpcAr+RhbB1WwlpKYUayQAd+602ZsbOmf8TQAyUB60BjzMGJGen20NGK6wB18ZB7OD8
	AB8oOWgo4QXTxqzbfZAU7/RIQipDECTlYVecMuGusX5Ctng6SdW3qO/H846biuZOUPe1qXbhsDc
	hx3pJGfVDCiI04dYypKHbFHOd16eX0lFLUPDQjZsXa8wDZ5NIK+GBYBjkNeu1VEjemUQeo+b5iX
	CK8GUIRtj2Ze2C/HCDShEVT9BOFVy2DBqLYHMROwvC0kbXlevV1AeUKhva3cIgYFNqMUvALg==
X-Received: by 2002:a05:622a:1787:b0:4ed:da56:7a96 with SMTP id d75a77b69052e-502a1f844d4mr184037551cf.60.1768834836448;
        Mon, 19 Jan 2026 07:00:36 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1d9f4b9sm75192491cf.9.2026.01.19.07.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 07:00:36 -0800 (PST)
Date: Mon, 19 Jan 2026 10:00:02 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Borislav Petkov <bp@alien8.de>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	John Allen <john.allen@amd.com>
Subject: Re: [PATCH v9 10/13] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
Message-ID: <aW5G8unLd6Flcrp0@gourry-fedora-PF4VCD3F>
References: <20260110114705.681676-1-rrichter@amd.com>
 <20260110114705.681676-11-rrichter@amd.com>
 <CAMj1kXHYTyxBcO3Jt97pukZiOTqL8U=zL5iari82sqMOen1cEQ@mail.gmail.com>
 <aWehZwXsK1IXRNU2@rric.localdomain>
 <CAMj1kXFhBdCPW_+xPR-TmU4M46Jr6DGwtjUtjDQ0EbgPGmL7vQ@mail.gmail.com>
 <20260114180859.00004623@huawei.com>
 <20260115080444.GD830755@noisy.programming.kicks-ass.net>
 <CAMj1kXENYZq-UkCup6FSH_4tmpRe4xJN1_veuSWs-hxxAo=1Ew@mail.gmail.com>
 <20260116143838.GC1890602@noisy.programming.kicks-ass.net>
 <aW5AvfcjLkSP2j42@rric.localdomain>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW5AvfcjLkSP2j42@rric.localdomain>

On Mon, Jan 19, 2026 at 03:33:33PM +0100, Robert Richter wrote:
> Dan, Dave, regarding this series, the cxl driver just uses existing
> PRM kernel code and does not implement anything new here. Is there
> anything that would prevent this series from being accepted? We are
> already at v10 and review is complete:
> 
> https://patchwork.kernel.org/project/cxl/list/?series=1042412
> 

I will also add that this code has been heavily tested version to
version on many thousands of boxes for over a year.

~Gregory
