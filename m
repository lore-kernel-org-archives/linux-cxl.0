Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B9C3783BA
	for <linux-cxl@vger.kernel.org>; Tue, 17 Feb 2026 20:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771359266; cv=none; b=jQ48gIGZtkxSC9BkdpD/hH34v9YywHhsF4Um79CZrgrrEcwpyNIYySRPTCiMlHyGmIskjHFlb35ext8HHFdzvRBCUbZ0XpbEARrN4Mg30Vx6p0IcW0XIJbheZCrgP61p+GWIqpUXpO8MvNQGNtwfqpheHURpzI+gS6DZQ8OS7Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771359266; c=relaxed/simple;
	bh=8ZDiadu57AMQtFook0Nh4/VXwD8sWMLryN21Uc8wqm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0IFJ9oEHSwNEigvD8JsOLvinQtfkREibzNJzz8Bybz+/n4WmwlRAdL5H2n76G/mT0zr4R4cdnFD9ujrbBoa4KYOqBDLaaFof0kj5GtUQrwlGbGo6K0lnPu0+V1G5XMoCY4HP/EpySh1Mlgoi+QQSQF0FxAIhQEYDjNf+tcPllY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NizZ7mMm; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NizZ7mMm"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c710439535so300854985a.1
        for <linux-cxl@vger.kernel.org>; Tue, 17 Feb 2026 12:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771359264; x=1771964064; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BotRyKbmo4lZuV5Y0MZBG/+fRYWoeM14u3+mLysohl8=;
        b=NizZ7mMm6W3uH1eVdDNmcsTwfH2wu4dRRX0W7eEQkPNj66mzbQQ65O5/k2tTKbJSLK
         vDKoYo13ZzKmBhE+LOiS454p5Pk4RUWNBESfGcqI7aOqMehRTokYmUvGg8ZiAFKSpdie
         gDKpt/LCGesuckcwXYnCMEF3tTDDm7faHJeTDJr11JfeLNH1shsr9jHmxCRMj7/V4sHr
         AUlFVXxmOw4rVQ6uUqqR8TsFpnWULsEIu5tzgqPfMtUH0ys4pnRaDee06samJ5iWi/Tv
         eRUr0zsY9B5y6+Oial7lkM7ZG/i1bVOB/NS3swHRekuTotRMYC8reBHMjtb6CR5Jju8L
         7gPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771359264; x=1771964064;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BotRyKbmo4lZuV5Y0MZBG/+fRYWoeM14u3+mLysohl8=;
        b=S69p84ntXbtOo6AssfJltIw62drmV/AsCNTjAnyfzJRVZhtGwUgxNUxZTORXNJi0T1
         hMqiGFWTSfCHiYpwKl8ilR0NdoZgWDmFvgij9RzvtWTAa0OemfahC+7OTRXgLAa75Ey/
         6DBnDGpQb/SdhB+1/pQKv19uVKB4EOsduxUUByr4rmshyqnpiKqXJ+tSil+/2Ni1+YST
         3Hm31ogsx+sCPZKAI4kajNRPv4h634+21RGAa3PSCJUIROvRUMn9CTiE1MOrlQiWB4CP
         BD08lyqCSFztzjCYI2JC1mW3xMg8vUKixVb737iIWn/vZxs4JJZzxUcUYPWTM0KK8Rhj
         99sw==
X-Gm-Message-State: AOJu0YykZhgvzeC0RRabafEVGblFMtHAElDOc46UNs34OarP/6bEZufY
	GqmVHNdiPyLkmfyggGoJVbPo12Teerl1XNGQcWr35M8y6xaiN2grHNfK9cXtRFyeSvk=
X-Gm-Gg: AZuq6aIFpdk2Gwo0tu/3hByioKG8Hm+llCUdVY+svVQd2puUPoczVlg6iEIRDf+F7UU
	RGrjZ287Q2lDvucgQ8BOP86mtq2WVuRZQAOOWR05IcVdrhkxwysgYZ68bj3bkj8ey4Bss9J9LZf
	1vVocMS/pTuMcWQGi9MGfHD4nGAOJ43XI4X/DD8iyAp1cprKBhJB4EyoHQlkrWZdiO/AlvSf0cX
	LjQ2Q1deyJwMg9ghtV38DL8I603RWTSaW6taz5iA8cKz9jq18vNRA7+4zJz/eA2rOtFhMkt28SY
	ExeW4q7SaTSv8vyK7BlEL6UP6N989PdQlKKT/Nj/wtoTiumOZ265BD7CideJJDwvrOOzzUdCFN5
	3xUnpR6pygL5TrJVNRsHzqcm/u32WrqPHQ8jUuVWAOeOk0nTAXwpfkLMx+55W9Pk42eFPH1GdW+
	7PpAmOyhmMdra80dLjT/5Q6sHB54hDVaonmZpccvCml97Sg+0Sws3elEEHDgKaVtL6kqfx1kfr5
	7Awwf5MnA==
X-Received: by 2002:a05:620a:258e:b0:8c6:e0c5:7bc0 with SMTP id af79cd13be357-8cb423c1ebcmr1581261785a.36.1771359264142;
        Tue, 17 Feb 2026 12:14:24 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b1c8123sm1611111485a.29.2026.02.17.12.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 12:14:23 -0800 (PST)
Date: Tue, 17 Feb 2026 15:14:22 -0500
From: Gregory Price <gourry@gourry.net>
To: Hongjian Fan <hongjian.fan@seagate.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: cgroup support for DCD
Message-ID: <aZTMHgTtEA9-rVft@gourry-fedora-PF4VCD3F>
References: <CY5PR20MB47474A4D5CFA5E7284328F6A9066A@CY5PR20MB4747.namprd20.prod.outlook.com>
 <aYdlv6Q8h3g2BHrn@gourry-fedora-PF4VCD3F>
 <CY5PR20MB4747B26D29D76514E88A4BA8906DA@CY5PR20MB4747.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY5PR20MB4747B26D29D76514E88A4BA8906DA@CY5PR20MB4747.namprd20.prod.outlook.com>

On Tue, Feb 17, 2026 at 03:31:41PM +0000, Hongjian Fan wrote:
> Hi Gregory,
> 
> > What you're describing is just producing more normal sysram numa nodes
> > and providing them to isolated cgroups.  This can, almost, already be
> > done with existing infrastructure.
> 
> Thanks for the reply. Would you mind of sharing a bit of more information on how to?
> Much Appreciated!
> 

cpuset.mem interface allows isolating workloads to specific numa nodes.

This is nested, so you can chop off a numa node from entire chunks of
the cgroup hierarchy and eventually expose only one cgroup to a specific node.

~Gregory
