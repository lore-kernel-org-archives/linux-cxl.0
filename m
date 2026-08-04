Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE86346F495
	for <linux-cxl@vger.kernel.org>; Tue,  4 Aug 2026 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785858341; cv=none; b=DNQqfb0R35T5KZJCOcmlX2Pl/TXlC5AMSRX9sQPgMw0Cg8gkwWpSnsAcPH8bO4BeuZ7bOJ5bhBU7H6XPNlGP8IOhwSHeNxLe7hB0dzeEA4GTwG93csbDQlyJBNGtsZ2HZHBeCKxMDNLXQHqkx2hfS15RQw8V5+Xjblosa9217B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785858341; c=relaxed/simple;
	bh=pfBibOOiLte/EX/+qle7mKZzjGU+fpJrKO2P1AlRO5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPFSFzUnNXWfBV+5QCaBWCmoKMZ9pPY22njl5Z2pyMcQGj1m8o91ysiduxGW+qi+/Wtr13YKAJVwlA/yj/U07f0TUxrOpWKpUnuJF5fxXXHQbXPobTK+1k/FDUUSpivL1ROfCYYEdY2dyIrwjHSl0nZpwuCsC4tecf/QbNbaz+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BMw7w687; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BMw7w687"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9349ad9c857so387312285a.1
        for <linux-cxl@vger.kernel.org>; Tue, 04 Aug 2026 08:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785858336; x=1786463136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5hmIhzrJ0XGT4baK5fEbfCbo8T+vTuWeZjg9ljZYg7A=;
        b=BMw7w687x2moMQw8aDNJimeqSJMpcah8ccRI2f659Q7z7/ip+9g532XGh0F0YITv+K
         weeAYrgU8J56cOogACq6UUhIOT0B43Xm97RVD6TR7Lc0oG4+ZUnaNviXHAANm4toc26/
         392exmNWyYjG2Qfq2jPknwqSny3gaVjTQIZeBgdpvwd7FbqWDu0DMFfLPGRuYAiugm66
         v8za0WhwXv7OEBvcwzTAg7v6By4SROyvdlmyPV0OT2HZeZftyVPtuhScmxsO23LPFUeA
         Fzl0a3P7ukM7/p/0qC7JLrAQsKznLHqwGdYJUDcbQqme/R9uW+xxE8VRdBk9YZ/cjJHC
         6B7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785858336; x=1786463136;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5hmIhzrJ0XGT4baK5fEbfCbo8T+vTuWeZjg9ljZYg7A=;
        b=rT0Jqg+NndNVrZbfSA7Bvru0N0i+7IZHFGJLU7NrvEHXhxiH/Fz6TINsL7Zeh1R3o2
         amS7Pyf7NPyPX6fhADcTa8JMlXAcoRgvB3orI20If+webR+QubM602mHBwOnAi0IxQ4D
         ssI+tXl7siBtWdCEGvVFLTO2FkQyoMfGZMXPvdKhFxf4qTSSdMkDZ4tDds8BMrRn3ZTd
         2LFe7PAEaahihJQkmpJZZDhQeNOYZIuK5vThnD68SWxg02TSnxWTkFRIfZT9BoI9aPMU
         l5Xe5QdAt4ZHqjq2NoqLcV8FAaRFsn3BtoGa4jAFlckgi8MbrwJbO7Lse6YQ2GHMLmVw
         Pvjg==
X-Gm-Message-State: AOJu0YxYOaVSDwEVBag29a+TwIDZYM3508H3/WCOp6DRAoNn1Gzz5aAi
	j2rjU2u0EmqIDCLR2azmNRNBNvgar+lcguLICq2flCEEHt6qSgPN6vBHfRZe7zs6goM=
X-Gm-Gg: AR+sD1363e/NYjfcOwrxK+limx4orKRkin0QbgMeQWemJllPcbAx5u/3xDIGO+Bbn1B
	nKApWCUU9QF5fEavrG1fWgL3WyOFPM5Fj+UiNpIs4W1fmJGHJAeEmW5IGnpsTmJIU9XynwrGySO
	CUohgsHnrYzqJn7YDQkDmHnceNgKQFubWsacUeoflDnh15fTJfZ/JbiJlGJQbvaaYibZSd4vw7N
	o51Dw42QR21vHHbCeE+hVAwzClboWAv3SwEY1YwM58NHKDAIUXbae0mkbcZoAMIMLpbGzNvoRrA
	fewahjBS6Huz3O40+ZfYcaoPe5Os7P8quWHmFTe5A01YFGc7FsCbQBH6BEFQMSVtoukVLV/vTwh
	vJNb0uWwpZaDnUD2BK0FfjhCpkSgw7h7uCfUpx+whtLpxtzFRnI/PNkZRvl0+TJSwXGnLQPhb/4
	0UedeL2nyATOuqgfWuJoDgTow7+LFEg2K/SE22H+l/I8hwI4TEvWG7mcaDDiClXgLlGJ4b7dWp2
	527ma+gc2HCpY/o+GgVw9u8f2G1H0DbYoifegAbZnqVgVCxXFQsNbc=
X-Received: by 2002:a05:620a:8c85:b0:92e:e7e0:ea45 with SMTP id af79cd13be357-934a0b10cdcmr2098248985a.47.1785858336297;
        Tue, 04 Aug 2026 08:45:36 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93641592964sm115484485a.0.2026.08.04.08.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 08:45:35 -0700 (PDT)
Date: Tue, 4 Aug 2026 11:45:34 -0400
From: Gregory Price <gourry@gourry.net>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Fan Ni <nifan.cxl@gmail.com>, Li Ming <ming.li@zohomail.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Ira Weiny <iweiny@kernel.org>, Benjamin Cheatham <benjamin.cheatham@amd.com>, 
	Wonjae Lee <wj28.lee@samsung.com>, Junhee Park <jh9934.park@samsung.com>, 
	Heesoo Kim <habil.kim@samsung.com>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH v12 1/8] cxl/mbox: Flag support for Dynamic Capacity
 Devices (DCD)
Message-ID: <anIJFdtTEmofty6U@gourry-fedora-PF4VCD3F>
References: <20260731084901.1512819-1-anisa.su@samsung.com>
 <20260731084901.1512819-2-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731084901.1512819-2-anisa.su@samsung.com>

On Fri, Jul 31, 2026 at 01:48:06AM -0700, Anisa Su wrote:
> From: Ira Weiny <iweiny@kernel.org>
> 
> Per the CXL 4.0 specification software must check the Command Effects
> Log (CEL) for dynamic capacity command support.
> 
> Detect support for the DCD commands while reading the CEL, including:
> 
>         Get DC Config
>         Get DC Extent List
>         Add DC Response
>         Release DC
> 
> Based on an original patch by Navneet Singh.
> 
> Signed-off-by: Ira Weiny <iweiny@kernel.org>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>
> 

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

