Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EEE23C39A
	for <linux-cxl@vger.kernel.org>; Thu,  5 Mar 2026 02:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772677340; cv=none; b=lTz0HZsQJ1pc+rAKgdpkOKeGwYwjxYxMpVXLjcb7heotzt8WUFCNUGe9J8uT/vZGaOQJsLirZXc8f55AML7js74KZ2eiOLEVrxMqjIfGI1d6jgr1BinxY+Ghx5VJKWXgR3Gq+FoRU1ZPOctoKSmRnaDnyStjItCeah6xRogfXqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772677340; c=relaxed/simple;
	bh=zqyUE8ffG9X8bHUnSyJPQ+Mf9wAHerQ/TkcQrDVQKQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACzm+6mmyP8NJnNde31s0EdH6LCeRCxCmQA/Ki4YDmfitngPBa0EIlCWN1iKZuZmePdoYVYee/B0FH1avXSu2vFOUAWU4XyQcBmPUcLT6+ba4f/tUMFNntIC2NeNxkOUIw5ElvtYfPPz/SV8q2+bYpQjg/0/nBnStuEubTEkM+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gXXxoh4x; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gXXxoh4x"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89a1c6dd788so18083166d6.0
        for <linux-cxl@vger.kernel.org>; Wed, 04 Mar 2026 18:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772677338; x=1773282138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HUN/Lua8rzSBEA2ypk126i9wj33RYRzjdqwwBQVrXg4=;
        b=gXXxoh4xhl0T7m+PXdpYmbAwLDYDjPR/mCYhbLkWeLdcBdH7ps/keWTC66xk6xxxaS
         TRZMc5drI7FmZzgtwiKJV5b7HO3c6u6+1Rl/kuTRdp/X67fyE5djT4uwgo5FWPoC1wW/
         lcudm9V9Ck9xX0M2YE2stNM13ii1dF0zt5YsmKvdaynGM3MPiK1vxkod02VekOBJNQCP
         R3amMos6kofztbs3MaOvFkF19DL3KHLGr3GsiqX8SqtdV44VDSXOvyhRMK1aTpmgGih9
         J68Fh8uh58fHpvrxoGy+Mqu5dtcSZ36G77qpXzIB2yIhGhW0b+UqD+TPbrNqeYMNK9aN
         LAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772677338; x=1773282138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUN/Lua8rzSBEA2ypk126i9wj33RYRzjdqwwBQVrXg4=;
        b=mL5f+mMSiXe3ITEWsZDim/F0GN4oM0FYmOKBT7+SGJXJU2UeL1aj6zzSeJuIDgoAxN
         jWg1gZhxmEihPYiNflR3fprEBY4ogn79PIuWuqLbPhCzL0IEjnF1C2t2r0k1okRjnDUn
         sRkHiE3L+izzFeamBeyk5VQpapLa3VgcYoFUd+XWRmWHVjyM0ACVV+hJi+JtTuWBH03u
         jdtrjVWIpC/t4t8lcr4PsDIawVxLKHZJa7baOr8gw+WkbnbxM72TOyhjOKr9DQx9jUrf
         VI9talYHzdjJlL9J/Xy1iOZECPx5x83i24hwNjOBucdD2cCj5cow2HS7dPMbKo2tcjyo
         IfVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnV1M5AbC5Zbes7g3uICWwAiuJY3Y7mDX65xN18aexlur8XmDcXYu58pZWUiR+Mr500DlmxhWmgWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9mA1oUmb8wtJ5hm+gPKCL427PFgxZbNNZz1VO193OKxusqhzx
	n3pRDwOeUDw1CA3ruYH24wW9Lz+HKnX4xd5VA11KSNhHStMZuHHAwNw0mGWj6FQX3Fk=
X-Gm-Gg: ATEYQzxy8bkqQ0+jkogOSnWW784Pt+gjzdvHS+/Wq4kLYKbj6R58EB8MaYhV5JWZP94
	r7L32OoMH9/A6+Br59Pq633GU8O5TVX3AduOXoMsGJV3mRzMdeEQ3wGI4bL8td/7lBTXJ2i2q0v
	BhCFoPxlMOx+Fh76D2BQhhJ8dRro4ryB4XH5jF7D6HY95zJlhExMwUKE0iwaYKgAMR5uYBPz/l6
	bmJ2XFlEp8nKYJXHdtC1jdzJiFfTOK8XWOkgMuYPddhX7zFtMGJOQXX3J5M+9k6GC/YdUL/eqi7
	ZTgZY/cVac10ddDLRj07EuMDS4CmOhoCI6t0V8RVTTyUcfxe22k7cdSYRnSrB4JaHnMTwnic2qX
	lIOmKgJIwJ6nFOMmTClR79vNRoWswwpI2qmx9+NqGyV11UzPBy1/z7Wn2WTWyKgc0LXvW0shrNt
	hRcEwD7pTZ2RfRihRkMsssGclkJNHpX+DSbWHofIyXWAWzs3pEHhWXuvreXbHXO7T6CbWG1pjXX
	PiU4MAv3Q==
X-Received: by 2002:ad4:5d6d:0:b0:89a:1441:b7fc with SMTP id 6a1803df08f44-89a19ac8b54mr60687086d6.2.1772677338156;
        Wed, 04 Mar 2026 18:22:18 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899fc95502dsm82713976d6.25.2026.03.04.18.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 18:22:17 -0800 (PST)
Date: Wed, 4 Mar 2026 21:22:15 -0500
From: Gregory Price <gourry@gourry.net>
To: dan.j.williams@intel.com
Cc: "Huang, Kai" <kai.huang@intel.com>,
	"nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"Schofield, Alison" <alison.schofield@intel.com>,
	"thorsten.blum@linux.dev" <thorsten.blum@linux.dev>,
	"wangyuquan1236@phytium.com.cn" <wangyuquan1236@phytium.com.cn>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Message-ID: <aajo16gazmWSsXDh@gourry-fedora-PF4VCD3F>
References: <20260304213342.5776-1-kai.huang@intel.com>
 <aaizNh-0LEvRQMCy@gourry-fedora-PF4VCD3F>
 <aai-K2tEdIp5B4XP@aschofie-mobl2.lan>
 <aajGuOC-G_dFYpwa@gourry-fedora-PF4VCD3F>
 <4809035f61dcd6ace773532efe46b0f1928be313.camel@intel.com>
 <aajOckpcmQwYydVQ@gourry-fedora-PF4VCD3F>
 <178a85c1d5a48938bf866a85d34ee2ba87901d10.camel@intel.com>
 <69a8dc7ca72c2_2f4a10026@dwillia2-mobl4.notmuch>
 <bf78a2ee58e99e1fab9df3b5406f20edf9420415.camel@intel.com>
 <69a8e5a4d2372_2f4a10056@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69a8e5a4d2372_2f4a10056@dwillia2-mobl4.notmuch>

On Wed, Mar 04, 2026 at 06:08:36PM -0800, dan.j.williams@intel.com wrote:
> Huang, Kai wrote:
> 
> A small 2 line patch to save a few megabytes of memory, sure. A
> paragraph of context that almost nobody will ever care about on a go
> forward basis? No, thank you.

eh throw it in the changelog *shrug*, i think it's useful context.

~Gregory
