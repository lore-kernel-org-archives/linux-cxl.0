Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0575A280CFB;
	Fri, 18 Sep 2026 19:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789759980; cv=none; b=ay7JYdUWVOVuB9brbvmKmEq7LD8OzwsdAa7i/nRDJM2IBNr2zDOkEbNBBQnEUM8rHe8DuKcdKvZPPT4z68Pt98RKwEWj1YMUV/JwMQ3AN4Aj+//q63beblaDGfKAjxMV6WnNC6m2LlkpV88CvwNi2fLdMndwjMpatpMFeIPJPqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789759980; c=relaxed/simple;
	bh=01sD8TsXL/8cUXBRmq1rD3NgdtyjZUpcTSatBIkKUCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZMpjtVwmChiuCo2XxSrM8ptNob0tiv80KDFbbqKftPfgKOwBUZUptReu+opeWy3zIEroyi0VHcJlf7eefGmDhcBiHDsqIde7mhwOtn5dQQM6mRUzfeFX6Quqrl//2g8FfPEeigOhgeqdpgvW2vlfDAMWiPGn6u/3hAYDB1z+Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/Kg3Z6F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/Kg3Z6F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014641F000FF;
	Fri, 18 Sep 2026 19:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789759976;
	bh=nQwb18XESyuz5OASlsduj1sdr640VNVekgXtN0YRZLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=l/Kg3Z6FHUGDxuQUdXNMgp813iFDAbv+Ga3XXmLShfcGnN5TlM9W9xy1roTNIQ/4S
	 yk5kc0GR4VjZ6UonOliv/pcrkmMv6ud4wi5nH5KOWRunXi6mIXaVsXcHMXUz8YoDCW
	 Hrjq4oBkX+zVxfdqEbA5k4yZ/uA2mcCIUKLGQDEewChFLWWOgX0BvWIUbZZPaBs5SD
	 lE17kQMXojF0J/cTcd1bu9ZRDK60udeChL8jrjD5WWBqWSYY8Di9WOSBd03l7vPpST
	 8Kk/rARAoudLsAgCpbkJkWto+vmVLiz4cBEnbIcAXMPOWmszc58ZwDxiy6Ur9H3jnV
	 VOff0rhBtKz3A==
Date: Fri, 18 Sep 2026 20:32:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Gaobin Huang <huanggaobin23@semi.ac.cn>, <linux-cxl@vger.kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 <linux-kernel@vger.kernel.org>, Anisa Su <anisa.su887@gmail.com>
Subject: Re: [PATCH v2] cxl/mbox: bound the Get Supported Logs entry count
 by the payload
Message-ID: <20260918203254.08c34055@jic23-hlaptop>
In-Reply-To: <aqx6rM90rFZEsTuB@aschofie-mobl2.lan>
References: <20260917104603.2658529-1-huanggaobin23@semi.ac.cn>
	<aqx6rM90rFZEsTuB@aschofie-mobl2.lan>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> >  	rc = -ENOENT;
> >  	for (i = 0; i < le16_to_cpu(gsl->entries); i++) {
> > -		u32 size = le32_to_cpu(gsl->entry[i].size);
> > -		uuid_t uuid = gsl->entry[i].uuid;
> > +		u32 size;
> > +		uuid_t uuid;
> >  		u8 *log;
> >  
> > +		if (i >= max_entries) {
> > +			dev_warn_ratelimited(dev,
> > +					     "GSL: device claimed %u entries but the payload holds %zu\n",
> > +					     le16_to_cpu(gsl->entries),
> > +					     max_entries);
> > +			break;
> > +		}  
> 
> Question as above. Why not reject the malformed response here?
> If there is a reason to salvage entries that fit, explain that in the
> commit log.
> 
> If the intent is to validate the device supplied count against max_entries,
> it seems clearer to validate the count once before entering the loop.
Seconded. Error out as early as it is convenient to do validation.
Here that is as Alison says before the loop starts.

Thanks,

Jonathan
