Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEE31A4F3C
	for <linux-cxl@vger.kernel.org>; Mon, 17 Mar 2025 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233377; cv=none; b=Qnn2uksToz0ZgHuLgTa6Yzruv3yBcXrDj0qVWKaxp/NddqAUeKqclm9jkolvvY0UtzSAPgSD8Gha13Wt/kFAirjbAcie0K6EgR4rCYR5mP7f/EmNkRgfK6p94jb7wqLZ60PJnthxz4ZzxgRiJQ91c0OuGUk/fgxXKwJNLnoKV/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233377; c=relaxed/simple;
	bh=O4nrPLyamLCCyaWqQW+fu+1xgvE7CNsXjO1kMscMvWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjDWsavax2gWUFCy/zYcp6Re/FsLx85L42R022LXmnuSYth1p7Kts8W2wb3FcDBznNBHtgIIfINhWz1ahVN/5YNUmKVh2txFAWGyZ4HXqasO225tBAR9N/YSRoJgEF9HlnLdG8kBQph0uZHJcQ0jm/26rGfVnn3MDCcvNQM+6P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=e+Q6h+Rc; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="e+Q6h+Rc"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c58974ed57so190180885a.2
        for <linux-cxl@vger.kernel.org>; Mon, 17 Mar 2025 10:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742233374; x=1742838174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qIumjbP5J/FNsIgd6eSQrbmNGbx4a2Nt6O2c+0OlOIE=;
        b=e+Q6h+RcAu5181PwlIGxPaYPbd+h+gSbp3Eu9VN0nxLtZF58QieRKwy0XPDFk+/iKP
         8Sqm8p1y1TvIoIP+/CbF46oLh4TxNtyARFU9PpBkPzzs0AvbMqraevnkWosVfYRiud6y
         Z8GMpCCbTp4pq16XMeGOi+ebxVzIcxpb9X3zLf4v5AqxkI7dUjyfsgReJFCGwU92CqsN
         CZvQo8CN1fiXEcqaiQK67ia+cIf9LM/8XzWK3qOH9ufKfszb+nPnRLFaYy82zdKBWemf
         MNATikiL6r0Y7ionfiJlhGzWxt3psbAGmxUcXH128ORI1ckSY6iGusUZuR1WGINvNfAM
         2rZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233374; x=1742838174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIumjbP5J/FNsIgd6eSQrbmNGbx4a2Nt6O2c+0OlOIE=;
        b=K6Jyo4P0PKnpvupNzMPTx920pu9eu6o3+b2Dw/kaql7iTxyrCj1wrcE1m/XPpU9kxO
         OdtzC22KJkqbgLM3jM0v8vsO6jdQr17JZqMkMOG9lzoKKTrEUq92nTEznexT91dJxY4p
         nR6DdNgbNpDjUzPCGkFqLmbPaXhzJQCoIiqto+rPdSAlHtSLyfw16a9sZ1V0/StOyhXy
         QkOTtdYdf4prZSb6a5esjViYrOO2/4xrcQMY9fQDUnSdbLxHfENIS3BgscE12yARbIM3
         I63FkuMhcLhQ7IEzMYjDE2wjp5UOhuc1H7MxG5uzqykImZiKO7yHtCrobc0slG1MSxGp
         qj1g==
X-Forwarded-Encrypted: i=1; AJvYcCWeA+/YKCxXYH30xhndHqcjWwCxm0zByRDl+XwAO4qZidtbU6ifNOVZL/ysRhFd9lr1XQsd6yuMzfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaUPRq5QzVlkHWzo4hGAsQHB0CJ+kILkb+gKVETzOIpHtzYhqG
	k93p6sBMcvtp+yO9th6d7LgP2PZonkh/o9cA4DKYE9NfPPuXu5PYr8tiPn2uo34=
X-Gm-Gg: ASbGnctL9fSEk4PVaRxsskSMAwQpoPLw3g+u/tfXpC8VUYhBEtOlblTZZqzAKtFDCIu
	v35HRscYAMYws+YK0iDXoZaxJ7u+Nk5jPDZHrlwduMCYcNLk8QBEtDN/vlQ/abNJ0dSVyI8/gvv
	YyIqVflOQkCisB5nbvBJbQm2FIhLnGuOLofpUgXW2anIrrz2c/LMCOxKI+EvLnDS/uRo3Uj8tXM
	oEp3BlZLTMiJQ8ePd+jy5VShMaHyINlCA+jE/92zwHpBzAuGU5Ipumji/L0zeQqrTo+9+WRzCQ3
	v4ZHMNT/ROV5v4YLpbYvz9Jtm3QAhc6HmbNW4a0Dnloer+vEFEdpd/groF3pISYws0AFn0WwINV
	8fzjEz8cl9S2MTH3g6dGNkwUufFs1
X-Google-Smtp-Source: AGHT+IFm3m+TIvLp/42d+oS0NNodx96Bmh/ApjXOVi7XJ1ehRoz7URv6NoETqpy3pqWkCuIfw+AQPg==
X-Received: by 2002:a05:620a:4411:b0:7c5:3c0a:ab7e with SMTP id af79cd13be357-7c57c79bd5amr1536349285a.5.1742233374449;
        Mon, 17 Mar 2025 10:42:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c9d641sm611346385a.65.2025.03.17.10.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:42:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tuEUG-000000006co-3Ai2;
	Mon, 17 Mar 2025 14:42:52 -0300
Date: Mon, 17 Mar 2025 14:42:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Li Ming <ming.li@zohomail.com>, Arnd Bergmann <arnd@arndb.de>,
	Robert Richter <rrichter@amd.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl: fix FWCTL dependency
Message-ID: <20250317174252.GA10600@ziepe.ca>
References: <20250310135119.4168933-1-arnd@kernel.org>
 <0c2a1f2f-539f-4a94-82f4-57406421a3b8@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c2a1f2f-539f-4a94-82f4-57406421a3b8@intel.com>

On Mon, Mar 10, 2025 at 08:24:44AM -0700, Dave Jiang wrote:
> 
> 
> On 3/10/25 6:51 AM, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The 'FWCTL' subsystem is selected by CXL_FEATURES, which is a 'bool' symbol
> > with a dependency on CXL_PCI, but referenced by the cxl_core.ko.
> > When cxl_core is built-in, but the cxl_pci.ko driver is a loadable mdoule,
> > this results in a link failure:
> > 
> > ld.lld-21: error: undefined symbol: _fwctl_alloc_device
> >>>> referenced by features.c:695 (/home/arnd/arm-soc/drivers/cxl/core/features.c:695)
> > ld.lld-21: error: undefined symbol: fwctl_register
> >>>> referenced by features.c:699 (/home/arnd/arm-soc/drivers/cxl/core/features.c:699)
> > ld.lld-21: error: undefined symbol: fwctl_unregister
> >>>> referenced by features.c:676 (/home/arnd/arm-soc/drivers/cxl/core/features.c:676)
> > 
> > Move the 'select' into the symbol that controls the core module instead.
> > 
> > Fixes: a53a6004e7a5 ("cxl: Add FWCTL support to CXL")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Dave Jiang <dave.jiang@intel.com>
> 
> Thanks for the fix Arnd. Jason can you please append this fix to your latest branch? Thanks!

I folded it into the Fixes commit thanks

Jason
