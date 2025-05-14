Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7D7223DCA
	for <linux-cxl@vger.kernel.org>; Wed, 14 May 2025 21:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747260001; cv=none; b=mD10TGt7ruH2XXRzEdZ87713klziNEUA6929g9did/1N6C/CRRn51bMqmeRXojlOWhG6Bhej+49/jIY1tFZwq0aoWrxjnjRwHEYa0y/H+HE8XfG5TYz5wU64Zx8eycxl2HPZD3+Ml7gQQorSEGU2DbT349nuqyYsGU4b3tTWV7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747260001; c=relaxed/simple;
	bh=Ik9PbzFESxLv98rSTclR+TOwTxlISZ10sWHo61uwFPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdmRu/gBPGxOb2P7/Fjm28/g7o/fzXADg1B3xul3Z8UJENPs38g346bYzk+4ceb6KWeaT+hMxAJMdyQmPmEwkX8WvXRbLZm83QDiUfBB8lKnxfhIeQ48EdTXej1h39KPTXbfUBcZ/tOdn1YjxKpA9Mi9TWWUGMreRaNy5Stqwuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Yr+xoSTH; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Yr+xoSTH"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c560c55bc1so26689085a.1
        for <linux-cxl@vger.kernel.org>; Wed, 14 May 2025 14:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747259998; x=1747864798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O4hLbE2jhkYfx2YhUxefc6YfCnXyJGvT+Xh5ZeprmFY=;
        b=Yr+xoSTHE/d/M8WCTgVTrX2t/Nv7vBbXll2sXWShftcLdyb+kukrvo0K/nDeMVCEs8
         0WW4DkBJGg4thgmjJwginW2JaopPQiTvLZtmmaHYcbAWe3HA7bqFwlO5lWoiDCrKUAUg
         BW0c5YBX0hrlW8mz+vE8bY9GOiHMxrs21i2xby8xjxlNhSwuTpk9MBHQbWq571YXibuM
         DK1Mv77UJQD1JD48656sMx3Z6NVse4e+wzygDXsSfazWIjTN5o+zUSpOnsK0cvuO3TEO
         SxO3WffNBMS+kHO2GZFEpIem64hlXbs105Qk+p0KiI+wTUZAsDt9IVJdpI3AbB3TiGwj
         uQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747259998; x=1747864798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4hLbE2jhkYfx2YhUxefc6YfCnXyJGvT+Xh5ZeprmFY=;
        b=rSNTsmj9/DymOhVMcB7nlTa08zD+LnvnqYX7U0iwpYYz/ssW+9eTB1IZHtOhvvaAMD
         RuViiGtcWNCLMxIBO/e0SvRlkbvr1xO3lyLPLCUwNzcUr8f48jWJXs/jrI+W8YQxqisk
         zvm5ETJbZeCCoKZg6TKpIonT+7ryE8ZekRVSJzAM43OVO277EZLmrWQEbOR9ehlNwuvy
         qv7CI6SnU43xI2V1Pa16CuJ7f+crmJogwoQZWZ6S2P3Db69QuJ5CRki0D3uel/IQx2Ua
         JGFulG7oVRGjl0vjptygTTzEnU1d/1QNmozyzl07loN6pidIzLuKbnyy3n70eTm/OlU4
         3LhA==
X-Gm-Message-State: AOJu0YyPAYF/9ZL15eREblQ9CW4BAGzAfjMyVvRe8UnXjxSSMkW5NPA7
	1CinMkx4d8yAwiHyIzTGRJNO0hyPxOTfrlv5U+eqYpnPydP8zsJncUzdOXM0Usk=
X-Gm-Gg: ASbGncs8d0Z0pAJgNztIZR22h/bzVHR31rcOYnnXpsC7sw3VwMnE3NWJoD83QxlSie4
	H1tnamaJS6McfSJ3VVY2Hrs7/VVbTw1sbMpM/D5pfAKc2mwIYF9LPH/vFqt16BwO0dgnrecOPnl
	CBV6dTQNhrbU3BzMo0kVdvFVj7nOV6JVFGqqvW9NWkN0qQGT0aobHi1Cx+2Mo23r0TKcA31apJ2
	Fsj0NH5+IVqjIgdQh02i7YifpIhmD2mAA5mxxW3KZLbh3Uix73SyDfv7y5DuTHaJS0yFIwwqT4s
	uUvYrM87FgdJcjY9ninNUYjhKML5m7CVrklTgaZxnYbZYfsX+u3ixmo+V8hhomJYbCPQcvWEn0U
	DGZ+7Ht4J1+GgnwY6Tty6eDeDlHSIUJSOYHszc6J4Rg==
X-Google-Smtp-Source: AGHT+IFsPT0MkdCTR3Pb0+m9FUdob6kpl1BjCRqFie5wYaf+vGZgVP0a/JUM4r0ePfHP+dCSepaEoA==
X-Received: by 2002:a05:620a:1a1b:b0:7c7:739d:5cea with SMTP id af79cd13be357-7cd28847660mr592990485a.35.1747259998500;
        Wed, 14 May 2025 14:59:58 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd00fdc4b8sm907981285a.83.2025.05.14.14.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 14:59:58 -0700 (PDT)
Date: Wed, 14 May 2025 17:59:56 -0400
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH 1/4] cxl: docs/platform/cdat reference documentation
Message-ID: <aCUSXEA9cfHeGpSB@gourry-fedora-PF4VCD3F>
References: <20250514003133.584401-1-dave.jiang@intel.com>
 <20250514003133.584401-2-dave.jiang@intel.com>
 <aCTA-C9StbfHjCMn@gourry-fedora-PF4VCD3F>
 <9ca53bc9-2eeb-4490-ac3c-fcb8cec0da78@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ca53bc9-2eeb-4490-ac3c-fcb8cec0da78@intel.com>

On Wed, May 14, 2025 at 12:02:01PM -0700, Dave Jiang wrote:
> 
> >                                                       ^^^^^^^^^^^^^
> > 						      provided by what?
> >> +Generic Target performance data provided by HMAT+SRAT to create the whole path performance
> >    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >    The is provided by SRAT right?
> 
> SRAT only provide the association of a device handle and proximity domain for a generic target. The HMAT provides the performance numbers based on the PXM.
> 
> DJ
> 

Hm, maybe this is best expressed in an example configuration?

I find it hard to keep the various table contents in my head while
reading document pieces like this, so having examples all in one doc
that show the relationships would be nice.

~Gregory
