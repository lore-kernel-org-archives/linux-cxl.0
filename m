Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4D41ACED1
	for <linux-cxl@vger.kernel.org>; Thu, 13 Mar 2025 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889883; cv=none; b=Moyc3asaFWmC4dHXMBgBzIUmS7TBDvYAZpLxdGJwi6B5ertJNsWi98+Om+sNmtmbwxAJCNAmzc2wdKPLMHD/HfATv+2QNgEiow+QxbZUwNjCGlz8LplMtNTYXlUexlID4pipbLiv+D0k3XiRdUq2r781X63oakunXxCRogvnLmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889883; c=relaxed/simple;
	bh=PdPtCwG/G4UNGh+IlI5MLCGpZY1iYAT2HF93sTGAIFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUQT2dYnbsj5dUmISpITfYzEvymSwKHAAFXYJrK6s6rhJgYAx1dhcAZYZ+OZXQ2gLRQ2DVBCcddLtNSQxpM2lM2qjMll6ixlNwMFogbpsTUtiY8OmH/Z/rn+wWAYvfa0sGaVIivq6mmIG8CLtiRZoHaEfrCAFUECUrFDyUrVXTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=FtaY+grk; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="FtaY+grk"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c53b9d66fdso155074085a.3
        for <linux-cxl@vger.kernel.org>; Thu, 13 Mar 2025 11:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741889880; x=1742494680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UpgcW7UU29tzc2HSUMpC8m7j2QavoELN53utjERwIQo=;
        b=FtaY+grkloTu15b38qAtJ9PeC8z1Hl4fmL5wd+d3LI17idtMnsqqrmmuNWM4A7HO4M
         9sVpHcPYPKYls2PNbz1/gi9twkpFHylGIbp4fYwIJl2VkeJgqBbeliL5FnrtF2rdeZvs
         jyV7dgJB0farHAaW5Xns9cWE0XaynRCKm4B0yyfKGSnH+v/bu6S9vjiq/yJpFr+Ttjxe
         QnDzvcqxbi49vf8eXQAj/ZGvjYq2WZDx1zmYcNiEW+MqIQYjUyacmyyEvu41M4jxGi7i
         5gri7E8Eqyg6NyQkmN9woljqJbKRJ+jQErZHPm8byoylKf7eVcNwUj1AYIhVEamQ92NR
         DJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741889880; x=1742494680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpgcW7UU29tzc2HSUMpC8m7j2QavoELN53utjERwIQo=;
        b=vUc4kYiRB/0XkB9PGuXX8mF63wfB2auL0QHaW3qvvMDRoJdkCKq5hamjksSCihgbk8
         aNu5ZZbjc96WxuiTwioerKcB1Q5gu+HrnlPmAmGGBH/3gP/CEJkgcsCsdMas8eJ7J5WU
         LmSpipfOH6n+8vnFATcbMFisDlm3Am2ZviuRhlin0nd1piiXGs78EJY/tGH5hsEOa974
         3zmRfka+S08udhTzrtVlUJhmIeU9216QcQmZxHUIJ8ldL8zHDV98W5eu0zFOSDfWhRmA
         0cM6ofsWIg45xO/3x6lnS4LpMtsm3ahDmsKkYp4wxWcIwDIgzZvECZ7DzIEwBn0yah4D
         zGjA==
X-Forwarded-Encrypted: i=1; AJvYcCVRCM7rYcXMK7BtPtiNCX7SximdbZy7rZG9HOE5+bBLpZD4VUq/eNICeG9yaIaWsA3yAiH/PZ7lFgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQt+ZJRqTbIJtxcB9vsgApwFIYUxIYRckZLJ2StyeII7HfroMO
	BaiUd3iyqdDapee7oWi9SMMJUo99xH5yxVrS8bSpAJ1U+LgScqajLBaBiq8Jfqc=
X-Gm-Gg: ASbGnct9yqVXmpBsscU7gN39Ypkq/529D2FjxC/k98T42NcAOWfG+cCRrqQx2/AaGtj
	c0adww6FDZOPjcfVI5ZDf5Z6ofX808/njw1x8vTrjp30S1hE7A7XwJPFtY7voXCoM/W+HjuYUIj
	/lvDRJs8bfH5muGXSDzDh2JaclTTVra7iFHhqLhs3LShe5zUzqz3mRtiCDBHY28NXSGlrjG1EN5
	qWyiJ+uGqsoKiJak2Z3yUYFTbwIDQzWMWFnph/DqwZyj5xipibQT4lAcksCzyZ2PW1pTQwr3rSL
	MmWwKQiN3r61EULqT3xZuK4jkklq0YB/ihHPU/kbc9CxeNHJCPWVX6RrtdWHn0did0tneQutVb8
	YV97Xrn7/QZM1oAKmJ5MKllJaaxM=
X-Google-Smtp-Source: AGHT+IFU07FAOug463Uwa+DOe07sChN0wwFnYBffXB/Iobm2IJ99vzyHde0TeD4Rsxvo8fielsuN7Q==
X-Received: by 2002:a05:620a:2606:b0:7c5:59a6:bad7 with SMTP id af79cd13be357-7c579ebc8afmr95372085a.17.1741889879813;
        Thu, 13 Mar 2025 11:17:59 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c9be48sm127266785a.60.2025.03.13.11.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 11:17:59 -0700 (PDT)
Date: Thu, 13 Mar 2025 14:17:57 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 0a: CFMWS and NUMA Flexiblity
Message-ID: <Z9MhVZmFVTPpuRe1@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
 <Z8u4GTrr-UytqXCB@gourry-fedora-PF4VCD3F>
 <20250313172004.00002236@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313172004.00002236@huawei.com>

On Thu, Mar 13, 2025 at 05:20:04PM +0000, Jonathan Cameron wrote:
> Gregory Price <gourry@gourry.net> wrote:
> 
> > -------------------------------
> > One 2GB Device, Multiple CFMWS.
> > -------------------------------
> > Lets imagine we have one 2GB device attached to a host bridge.
> > 
> > In this example, the device hosts 2GB of persistent memory - but we
> > might want the flexibility to map capacity as volatile or persistent.
> 
> Fairly sure we block persistent in a volatile CFMWS in the kernel.
> Any bios actually does this?
> 
> You might have a variable partition device but I thought in kernel at
> least we decided that no one was building that crazy?
> 

This was an example I pulled from Dan's notes elsewhere (i think).

I was unaware that we blocked mapping persistent as volatile.  I was
working off the assumption that could be flexible mapped similar to...
er... older, non-cxl hardware... cough.

> Maybe a QoS split is a better example to motivate one range, two places?
> 

That probably makes sense? 

> > -------------------------------------------------------------
> > Two Devices On One Host Bridge - With and Without Interleave.
> > -------------------------------------------------------------
> > What if we wanted some capacity on each endpoint hosted on its own NUMA
> > node, and wanted to interleave a portion of each device capacity?
> 
> If anyone hits the lock on commit (i.e. annoying BIOS) the ordering
> checks on HPA kick in here and restrict flexibility a lot
> (assuming I understand them correctly that is)
> 
> This is a good illustration of why we should at some point revisit
> multiple NUMA nodes per CFMWS.  We have to burn SPA space just
> to get nodes.  From a spec point of view all that is needed here
> is a single CFMWS. 
>

Along with the above note, and as mentioned on discord, I think this
whole section naturally evolves into a library of "Sane configurations"
and "We promise nothing for `reasons`" configurations.

Maybe that turns into a kernel doc section that requires updating if
a platform disagrees / comes up with new sane configurations.  This is
certainly the most difficult area to lock down because we have no idea
who is going to `innovate` and how. 

~Gregory
