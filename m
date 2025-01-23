Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0BB20B22
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737645815; cv=none; b=Jv4BMOheJETCXvcjhEAs9l/Jd6AJPP0wozkP5YyvCCY6e/W/92GSZy5LX/jrMgphsTjwKdMvALirz2mnXts61KK4uOq23fZpywGNTJKbVnf6ZFw3NGE3ipl3SvLbZ15Y+eOxCb2+zZFxi4jeiMbU4ojMG6oB9lj2t+6m0KtoGPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737645815; c=relaxed/simple;
	bh=RVodNgq3s6lHx5kDhkpzi+RJnEfTht0znSTkiRgSvKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cswwm1ZwguRVA/wMjKQwryH6rIp8CRqBU8ZVy4uaLG5VJpKxJ8oSsWkvOyOhDrkpfytDpTXXue7P5oPus14o2UFhZlRTiUWQwwvUnsK09u3nKJIhc9vtIOPxMW7RVFFzwP1lBz8Ro3en39g85B17lejc5zckQx3K9wDhnipEyvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=rxj9TjWl; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="rxj9TjWl"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-467838e75ffso14452531cf.3
        for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 07:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1737645812; x=1738250612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OjEaypsuz30K7ptqs1a56KzoE/dpYJ3kzMwZ+SzZO90=;
        b=rxj9TjWlOs/wqNPLMptt+iugcIWSxCHuekKmkHW/2PBJnwIZj2CTeNC8XctksLUKYp
         aGqhtM2zFrs8EWFACaYsjs3rt1FHMAZuUT1TSCsM3yqvZ77lKb88icsn4y1bXdjol36u
         xby702WXHw1W3jeuDf9P3d1a1Jk1/HiqWJ4AAxomcnzHeZ461vasEGa1ht1Afq46rFeC
         oaWIm5VPrlLoor4YQDQRy60bK+Ti8ifIHKGKZi45wJJSKaRhEnu8uVSkIrrqTj3qzJff
         ROvcGwuvJLMmph+kqhqK5lUZgwldhKij4hvEL0HM5ozc5sboQPby9WGByG/XXYCvWxDV
         0lMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737645812; x=1738250612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjEaypsuz30K7ptqs1a56KzoE/dpYJ3kzMwZ+SzZO90=;
        b=BfO5edFxR5nL0+sX/RRyTCt8G6zeBQ/adq0BijP3THEKGAtOMm1CTMaa0M4+011mJ6
         0vrG2TyUWZdr/uPQhmf43YUaPt0lYdsR45/nte+irdiywL4OPtbLijIRJJpLPvCO7Gn+
         4MDxlP08itdbP8sp7Gwz4Fr2jwh/O7X4920Y/wAAD4H9KmFjZG2jJ7Pfen368gdxFpO1
         WfDMrnKp3obxbXb6iI75P/e/1G288hv+j7iDSCeqyciUm7NlzjpJMUhKTvaSFQhmjNmL
         KcMpwHmZ5RTpRto9PZdi3N/v/8q+2797Jt+5+spJ9rATLkQD0V614Ho6w3VdczTLQ9M4
         hYSw==
X-Forwarded-Encrypted: i=1; AJvYcCVHpm6XHvSnXEuOcwUVhNEH54R4lb4mwgxvBwI6wI+NCZzSeaVmt9qXW+Az8Ktye2pNO/bktsopeIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiqZ1G+Dp8YfGAmtkyjXyog4Xxxqt1YdkUZfceHPZmS/J63BuO
	YEkyTmE4Qqnm7n0FT/S0IR5Kt0RsEYvxtJJF0+ewQ3eBVumMH/Dw9hrSQ/sMI2o=
X-Gm-Gg: ASbGncsmMRQLyEiKKgUl/OHv1p0ZKUm9YxnL0xXWCM5y8MHEiGwn7fmQaJtwrgnBUEs
	khAmNVcypBr5q6n/84kw9+tH7DStRrrGPw04cbVTHABccU71HDUyjQXWu/9iadrohNAV/KFUExU
	+VHXQL+Cw3g6Hh0q9ShVcAtdmNdsiKvt6L3tfKSLq0KQLj/bVRdc3TGFejOtzQT6TlkOU+2LQGw
	LzmxbwqcLMs3ard5Ve5pX5v6FUKA/77P7lPG3piP9ttVmDG/giqzfq/vzm8LIjDIjv7GeKQAVX8
	bmyTD2tQUoYAmqg9GgqvB25eXtxnO++pN61VzgIxopJiwzbMt/av7i2eC69MmPY=
X-Google-Smtp-Source: AGHT+IH0KcoGKqmDsUgTF05dHZJcCCc30ZfWfCukf4fZycbhyLEokFwxuPHzWPHV33Tlg8kQ38x5Sw==
X-Received: by 2002:a05:622a:292:b0:467:b7de:da8a with SMTP id d75a77b69052e-46e12a2c4e7mr401054231cf.6.1737645812180;
        Thu, 23 Jan 2025 07:23:32 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e2f67ea89sm49249971cf.10.2025.01.23.07.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 07:23:31 -0800 (PST)
Date: Thu, 23 Jan 2025 10:23:30 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Hongjian Fan <hongjian.fan@seagate.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"fan.ni@samsung.com" <fan.ni@samsung.com>
Subject: Re: [PATCH] hw/mem: support zero memory size CXL device
Message-ID: <Z5Je8gZb_7pTQ1RW@gourry-fedora-PF4VCD3F>
References: <20241202230310.1531219-1-hongjian.fan@seagate.com>
 <20241203172328.00001a00@huawei.com>
 <CH0PR20MB42505D4F82D534A85EEA4C2A90362@CH0PR20MB4250.namprd20.prod.outlook.com>
 <Z1iS2SeYSOQqdLVU@PC2K9PVX.TheFacebook.com>
 <20241224151315.0000068e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224151315.0000068e@huawei.com>

On Tue, Dec 24, 2024 at 03:13:15PM +0000, Jonathan Cameron wrote:
> On Tue, 10 Dec 2024 14:13:29 -0500
> Gregory Price <gourry@gourry.net> wrote:
> 
> > On Tue, Dec 03, 2024 at 09:15:51PM +0000, Hongjian Fan wrote:
> > > Hi Jonathan,
> > > 
> > > I'm trying to emulate our memory appliance which is similar to a MH-SLD. The memory device is connected to the host server while the size of the memory could be changed by the out-of-band fabric manager. If there is no memory assigned to the host, the CXL device will be booted as zero memory size.  
> > 
> > This should not be how this is done.
> Agreed, but...
> 
> It sounds like a pre DCD boot time only pooling solution?
> 
> What is the path to adding memory?
>
> > 
> > The ACPI tables should report the maximum possible size, and the DCD
> > infrastructure should enable physical regions that have been added to the host.
> > 
> This isn't the ACPI bit, it's just the device reporting.  Can have a huge
> CFMWS and tiny devices.
> 

If the device is booted as a 0-memory device, how is the CFMWS populated
with the capacity needed to back it? It's all coming from the same
tables.

You poked the right spot in their post - we need more information about
how the memory is added.

If the intent is to just increase/decrease the capacity of the device
on the surface, then the only method I can see here is "tear the device
device down and re-initialize it". At least then - I think? - the driver
will go off and create the appropriate resources.  I've played with this
in QEMU previously in the past, so I *think* that works?

If it doesn't do that, then they'll need to go off and basically
re-invent DCD for their device in the driver (or via fwctl? yikes).



Side note, after thinking about it: a 0-memory device at least lets you
poke all the control bits without having to care about the actual memory
piece, so maybe that's useful regardless.

~Gregory
