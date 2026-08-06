Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68050472539
	for <linux-cxl@vger.kernel.org>; Thu,  6 Aug 2026 12:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019267; cv=none; b=RhDB/Oss9M6b8/3RgfNijD3rLQ+V0hPs90hHvTlgGh4fm5DBqBuAsvIATZ2tzLyr4l1FrfcOo1maiGFe2IVKoDe/q05QyhCC1qZFFJw+yb7xPXX81wxMkWUyTm93XFEqF9xKuJcm86cdk6Q47NzjnHR/VBBq28eCrH+iac8DSZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019267; c=relaxed/simple;
	bh=zbxbgVABDpAz7Yl9dVLN94U6/Mw6TDrkPy4AolyE644=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYA+QE6xNLZLFoPx61hGczgLTnl8S3UII3DVdijVhlNEMu23sDzgDj4yb7SSb9NJi2iH+INX+6MxeU2sB/6NIeK35rBfni2Ptq8k9XlmC8AE07vbRt8gzR8CFgw38f+OwDK+FtiSa32nouCLWy9kP9WOsdJy/hReVhJIKCZ+iDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iB3BVgXR; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iB3BVgXR"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38deea72eebso1798868a91.1
        for <linux-cxl@vger.kernel.org>; Thu, 06 Aug 2026 05:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786019266; x=1786624066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8lGDFFRjFwi4B9aeNDvA48Sw9DPRqkHPcAQDd/V37v8=;
        b=iB3BVgXRm+IisTx4/yul/sTg8zjpo4Bfl09wJdZ9Hp5Ha7zDj8yQWIf+uKOt7jzJT7
         byove/q+0bp6NKLvep+7hNjNph9XDcvOMvRS6zcTNhABgZdiHqpW9sq8SEOpdQazrOOg
         65wn5+s/y9tsUqqyOUTjuRDZQtpmO7WT6TgC4j6w6rtmOnlNEl4lEj9NU7ucu0KJjJkk
         MCAFbsg/LsBY41NLFnQIwv3obBbyZP5wbA/OusS40GUdTWNBE8gfcv43qPewAbXPN3nt
         vpd8IP//EM8qXvM15yFpVqQJeTfCw8NL/MUGxPwHpY5SfTutFU0WB/ZPri9RPKyYNFZd
         Dm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786019266; x=1786624066;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8lGDFFRjFwi4B9aeNDvA48Sw9DPRqkHPcAQDd/V37v8=;
        b=PYRQmaWeIidD/xvW4KwZFlxlFQgHQbaacZ7kNX87hA3X7qVen4ItXN1v1udSA6x1ud
         Umg1D3cOC2TiIEIaUn7YkcdS1a08FAtvVBG+6jJZDify1NE4EBf81wfff06+Qwvd6Zrc
         mVDwy+picudaBcVc8JtuXiXYtMqmLRODAk7qwjnE4I+kz2DutXtZIc49BBij/eex8i6D
         L90rd0WPBfuD9O5X4R1YgZIJkxWqMYEu9wU8/+UvfD7RZXn4aWZDpwoPV1hzwVhnVc8U
         09i1uLlsvBU1p8wh0yNDntsbwrbASj2pz5DMvij8W/pLlNUofUQpEtWuz732z1XLVBXX
         8r3A==
X-Forwarded-Encrypted: i=1; AHgh+RowZsNkn9ctb2GWniAC5MGVqB5OATiwEBrYWk9yuHkYk7kUUxaJTBDAhsk69W5cnUnO3hzl3HGEG1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3gsbvy5+UKFe85Lvn14UhO1iKBN25qByP0V1FTF5OOkBoq8YK
	gNJ9LyEi+5C2J3XFDg4cRK7PFtbMv0z5Pc51Sz2+Qw7E8/1rnwWN8kZ3
X-Gm-Gg: AR+sD11D7OnrzMHCw8WZVTMk3hMMsqmlmuxd9yBLdtDIUEIug1H8iC7MpGIawHhulTX
	4lDicumAvuSGqQZR/fPyfXPr75dtmGXW3W66d3Kwue+Sp18iOkozkTWo4AJyNl+fGAUENjL671+
	s7I+mmzmcwPyKe307ECKWYokZ/WLuQ359vmWeQ+8Qq31ZtDtZkAthM1Fqb2QN2KyDS58iyaZ8r+
	tQTgBcnQykxpGnsFdlkn4KJWTIoHzUYl2TCHFAq8cjRt7UYK4fhrQUbEW5xSPr2vBiMjyYKZwat
	nlkXrBLFUo3kgIyiif3rNcPMOu2KE/r9P1bIOAaMI9a8PFwOopFSwwOGrxBbs4btpan9S6F9V+y
	BCU9tPHp0cka8D3tJJDBuiggEsTarZYNjanvZONa0kqLk+Gtt4e7NggYwLyRmt/r2R31q4Uaw4U
	5GNTq+gvZ1nY+vxK71aVdhIKz4Nm/nkUvAqO1wBjxXzGCcII2tXrUVRfNvwbAHIUEwvKFv1/fGY
	RT847OxblDbUjJF0drLYnQtSw1TiIzmvbrhgnnLyRgT
X-Received: by 2002:a17:90b:2807:b0:38e:3fdc:62e5 with SMTP id 98e67ed59e1d1-3903c5ee958mr15947483a91.19.1786019265685;
        Thu, 06 Aug 2026 05:27:45 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085dbe349sm1485613a91.4.2026.08.06.05.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 05:27:45 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Thu, 6 Aug 2026 05:27:42 -0700
To: Alison Schofield <alison.schofield@intel.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <jic23@kernel.org>, Fan Ni <nifan.cxl@gmail.com>,
	Li Ming <ming.li@zohomail.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <iweiny@kernel.org>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>, Dan Williams <djbw@kernel.org>
Subject: Re: [PATCH v12 5/8] cxl/pci: Factor out interrupt policy check
Message-ID: <anR9vpMtUVuPaTM4@AnisaLaptop.localdomain>
References: <20260731084901.1512819-1-anisa.su@samsung.com>
 <20260731084901.1512819-6-anisa.su@samsung.com>
 <anEqVU3-B3ab53eE@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anEqVU3-B3ab53eE@aschofie-mobl2.lan>

On Mon, Aug 03, 2026 at 04:55:01PM -0700, Alison Schofield wrote:
> On Fri, Jul 31, 2026 at 01:48:10AM -0700, Anisa Su wrote:
> > From: Ira Weiny <iweiny@kernel.org>
> > 
> > Dynamic Capacity Devices (DCD) require event interrupts to process
> > memory addition or removal.  BIOS may have control over non-DCD event
> > processing.  DCD interrupt configuration needs to be separate from
> > memory event interrupt configuration.
> > 
> > Factor out event interrupt setting validation.
> 
> Hi Anisa,
> 
> "Validation" seems like the wrong term here. The helper checks for
> firmware ownership of the memory event logs. It is not validating
> the event interrupt settings.
> 
Fixed. Commit message now reads

	Factor out the check for firmware ownership of the memory event logs.

> Which leads to my next comment -
> 
> snip
> > 
> >  
> > +static bool cxl_event_validate_mem_policy(struct cxl_memdev_state *mds,
> > +					  struct cxl_event_interrupt_policy *policy)
> > +{
> > +	if (cxl_event_int_is_fw(policy->info_settings) ||
> > +	    cxl_event_int_is_fw(policy->warn_settings) ||
> > +	    cxl_event_int_is_fw(policy->failure_settings) ||
> > +	    cxl_event_int_is_fw(policy->fatal_settings)) {
> > +		dev_err(mds->cxlds.dev,
> > +			"FW still in control of Event Logs despite _OSC settings\n");
> > +		return false;
> > +	}
> > +
> > +	return true;
> > +}
> 
> Why such a general name here? This helper seems to have one very specific purpose.
> 
> cxl_event_validate_mem_policy() doesn't validate the policy. It checks whether
> firmware still owns the standard memory event logs despite _OSC granting OS
> control. I'd prefer naming it after that condition rather than "validate".
> Something like cxl_event_fw_owns_mem_logs() reads much closer to what the
> code actually does.
> 
Renamed -- Naming it after the condition means the return value
has to invert, since true now means firmware does own them:

static bool cxl_event_fw_owns_mem_logs(struct cxl_event_interrupt_policy *policy)
	{
		return cxl_event_int_is_fw(policy->info_settings) ||
		       cxl_event_int_is_fw(policy->warn_settings) ||
		       cxl_event_int_is_fw(policy->failure_settings) ||
		       cxl_event_int_is_fw(policy->fatal_settings);
	}

so the caller loses its '!':

	if (cxl_event_fw_owns_mem_logs(&policy)) {
		dev_err(mds->cxlds.dev,
			"FW still in control of Event Logs despite _OSC settings\n");
		return -EBUSY;
	}

and I moved the dev_err out to the caller so
cxl_event_fw_owns_mem_logs() only answers the question "Does the FW own
event logs?"

Thanks,
Anisa

> --Alison
> 
> 
> > +
> >  static int cxl_event_config(struct pci_host_bridge *host_bridge,
> >  			    struct cxl_memdev_state *mds, bool irq_avail)
> >  {
> > @@ -661,14 +676,8 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
> >  	if (rc)
> >  		return rc;
> >  
> > -	if (cxl_event_int_is_fw(policy.info_settings) ||
> > -	    cxl_event_int_is_fw(policy.warn_settings) ||
> > -	    cxl_event_int_is_fw(policy.failure_settings) ||
> > -	    cxl_event_int_is_fw(policy.fatal_settings)) {
> > -		dev_err(mds->cxlds.dev,
> > -			"FW still in control of Event Logs despite _OSC settings\n");
> > +	if (!cxl_event_validate_mem_policy(mds, &policy))
> >  		return -EBUSY;
> > -	}
> >  
> >  	rc = cxl_event_config_msgnums(mds, &policy);
> >  	if (rc)
> > -- 
> > 2.43.0
> > 
