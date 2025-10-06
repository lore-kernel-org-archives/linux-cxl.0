Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3A22248A8
	for <linux-cxl@vger.kernel.org>; Mon,  6 Oct 2025 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759772147; cv=none; b=GRxMeD04vvogjG/U8Y83IpgnbHTLFsgGPjvcIUvhY3iZ57xDB836SNUmsM8h5iU6fqjgBQ63GnN5vo80KftKoZqYQ3kgB5v7aNMqAjdlAvA3mNyDdMtJ5xcZRllI9XauozUrLPXQf0H0DiR2LrJ7afLXgxkjjwJQexEX9aXsaqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759772147; c=relaxed/simple;
	bh=W195a0snK2qbMlgwvRIrKSLXzC/gj1N8SicfYvXdfZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9SLjaLSjrhP2PhDTwOFpZcP9TTmw3/VqTAX02tXQpi8kgcos0E85+IxVkPOJ0ZAOJyEjTWwSAmYNkEy04Z/yS5g32AXNFMXO3wxHiHWFenG1R1YQzfd7PUkcuoM2QppdlkLhDBQfsmH9MODAjw6cJJ09fQdp4Hi7PkfQX9LI2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Z4ZPlCwt; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Z4ZPlCwt"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-863fa984ef5so650150985a.3
        for <linux-cxl@vger.kernel.org>; Mon, 06 Oct 2025 10:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1759772145; x=1760376945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kR53Dw5KXmac3PH9uOCTXtwUd6vhGp4REIph22KJFUU=;
        b=Z4ZPlCwtMh0xurcLXNb/8qEC0lQS3m6nbc7H/qFd/DjHCAUgtB/ni5p8xXMqjl3qzV
         7SBVVuBSzceOTzvDSnhGl4MFbiqqMOivpTQdBYR4TtqAm46EpSsknaurxjAj9FCFr0/j
         C0vTgisGf4SLsrzTO/fzOYipz5SQM7J3xClyEHjc2kep2Vqy8dKz95qv3MKSxYzVU92s
         p56E3NTYMVAv7e6lBH8NhYgvMA3XBYDM2sGEHsFgzxYt4i1NwKapup/0sfGObM9GeNEt
         34fc/8LaaHkRCxt3xeLGOZyU23Upg1gSVpVe1R5jBCQeADPqhv+4Pu92Yg4RrqEgYEDu
         mK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759772145; x=1760376945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kR53Dw5KXmac3PH9uOCTXtwUd6vhGp4REIph22KJFUU=;
        b=v2pGmHm3tAPzomzMsFLQLmfIGRp8oECsaR1verkUyG1VEV6zJBWT7G7MruIiJDekdD
         dCQHCY1wGFoIU0hOkOB3FNJb9z4sX7LCugl5N14uHqvVkPuMJVodm0VdpTIYaIyXkXqc
         LQ9CvXw+EWNkPYiYeTJAfxlXjWt+4fao3u8X/0Bgw2u/sVn60UxvkGC6hIO9JP6KCZRh
         p+IVa9Uy79eApf4q/SuJhP8wzdWXxfWwwptNTN45hzdolG8t6Aj6OqCMtZfAp2UuJc6+
         sKLm4sWU519Vm2xxMpdA9pXjY6d4/BDRcquQP2qar39wRlDCGM4RoTjno6xGoxZhgC9e
         a4KQ==
X-Gm-Message-State: AOJu0YwM+Srl3LDJ+pIcwC1z3xOPShJcZi2YCkHaLgbP/VIx2T07y/+K
	BMUIgvn1k/8fidEeMTpZQ8EjkR3epfbJzNnDBNT/GFR4JOKbZeudthK6gGVsBagiEIg=
X-Gm-Gg: ASbGncsYKHS03qiM6ynlsF3VolGvHjZhMte6vyvWfaJ8Nd/SkvFDS9X2uCPtQGV9qlx
	Gwbs74rshLBpc6c/b/fmC8NdbY9maXNvL3Hb/hZmnL1v4qBozVqMDkiOnx/XkWH3j59U++yJPDf
	oDaNBN2nS86x4zM9ORfuaPhdEvgd8y+fwQxDwKMo/Wr2PrSY+aLUQMIEI3yA5CYpxlp+a1YyP2S
	PmlgFr8F0oWkC5tTHsvqjCUhfPvkjKy34H5bdsROkeoklm5HqP2L8/zfn55Ta/cjmGh6QAoVH5P
	2FOnQQmJopzbwRItt0uSfgzBAZpp8edF7e5NQKRz2H2sM9coEtc3MpBCOLTzORgUSWkSp9ZoqX5
	OeSBBHLH6a0/q9HMEkpskctfMvT5vol83gaIDqRzKZ07g+6GI7VJgjFEoE3faMpo2HZN01BaMS4
	HrZD9z0qt2mVRMB35G0u05Cd8TM8AmSv/2XMcSc/LDmbMz5gsZuIg=
X-Google-Smtp-Source: AGHT+IER8DoXpPhXVe8+Q8xupePoMW4LjKc805ivgHMRBIcpH9k3WI96ovGNcp68qp1cCNFhDqppHw==
X-Received: by 2002:a05:620a:4154:b0:85c:bb2:ad9c with SMTP id af79cd13be357-87a3a34d280mr1467487385a.53.1759772144584;
        Mon, 06 Oct 2025 10:35:44 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87772460ac0sm1375860885a.19.2025.10.06.10.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 10:35:44 -0700 (PDT)
Date: Mon, 6 Oct 2025 13:35:42 -0400
From: Gregory Price <gourry@gourry.net>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Robert Richter <rrichter@amd.com>,
	Cheatham Benjamin <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 1/4 v5] cxl/core: Change match_*_by_range() signatures
Message-ID: <aOP97tRkOhXmmMfk@gourry-fedora-PF4VCD3F>
References: <20251006155836.791418-1-fabio.m.de.francesco@linux.intel.com>
 <20251006155836.791418-2-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006155836.791418-2-fabio.m.de.francesco@linux.intel.com>

On Mon, Oct 06, 2025 at 05:58:04PM +0200, Fabio M. De Francesco wrote:
> Replace struct range parameter with struct cxl_endpoint_decoder of
> which range is a member in the match_*_by_range() functions and rename
> them according to their semantics.
> 
> This is in preparation for expanding these helpers to perform arch
> specific Root Decoders and Region matchings with
> cxl_endpoint_decoder(s).
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

This may end up conflicting with the AMD ATL patch set, as that set also
I believe made some changes to this area.  But somewhat irrelevant for
the short term.

Reviewed-by: Gregory Price <gourry@gourry.net>
