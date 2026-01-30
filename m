Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A862EBB8A
	for <linux-cxl@vger.kernel.org>; Fri, 30 Jan 2026 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769799809; cv=none; b=To4oBvrdXwCaHSL1gWM/WBAuHVQLL1Lmig8x4UxVxN/Hep6NdpbD7+mCzA+sg0EHytbsGMhpXRFqT8AyIsolwK49rVPGURIT2A4ZOaeoSq4uYthymGBLD0xIW8yRA7BU8Vsewr/jCiosmYyidlXF7fx5RCbpTCMBWoQ7Lq+V/Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769799809; c=relaxed/simple;
	bh=1yRJKB92pyfvNCPZ5QOnsVBkWsozCQI7sXGdoqrIetU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDRIB0RK2c+BQaG6DjjsDtz6kluvHRbJzWSKJpmInrfDl8yabtUUbG5wVSmzrokmEuxLLvNI/U7siNAo88WQOaRVl25IPpegg/n6Snj3oPhrmGG1z8/LNVplcfdXcyUICC7o2gOxYTBLjmPR6U9EGiLI+e6Z6wzMAZrRH7oz94Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=h0x3tV8R; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="h0x3tV8R"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-89461ccc46eso39192786d6.2
        for <linux-cxl@vger.kernel.org>; Fri, 30 Jan 2026 11:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769799807; x=1770404607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1yRJKB92pyfvNCPZ5QOnsVBkWsozCQI7sXGdoqrIetU=;
        b=h0x3tV8Rx/zAXoDrEPa5rEoL5DZBcBvgGmxUpSHT/GpXpwaveag/aXsWtakO3tsr0S
         fjFnhvz5UwclUd79DXxPKWwYyyyncrfxM59jLHpNCLWVvlkbxtJV+7+bchO/39W/4Vuf
         xE9oxVWEvek0YLPY4GfF9EIxmTl36+AYdr3xkcKPgfVPGoZYKeT2pIoR2WLMXlaVp3oJ
         eZM24/I8f1fhdvXzXMJJgFRxzRtFGuK36TtYXQo7Z0nH+4V+4tJglFPDsRu1dTn56yjc
         Ee7F9dGUnUJX7Jz4L9qweVrdBKljfjb4aS/jociS3YRpKvWiO7JDCTFUVbVKKCU13JHR
         iLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769799807; x=1770404607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yRJKB92pyfvNCPZ5QOnsVBkWsozCQI7sXGdoqrIetU=;
        b=wn15k2tPJ+znMBrxAIMQv3mGlk0oCpa1MqRESeYZJ/l94u71e9qe8edc6R6ZuLXwED
         G4fqS7oA8lnJ+ibPSkSSPqEoSkufxy4qf/RvI3Jzc90MROKkePJ+Pv2H1omCk9onimFd
         gyXyeTseYcbEKPdJ5wy0Pkbwf2nimWvGs43hpI+M6N6FMJc2tBNWfgTI2cGcwMcZJdli
         3Lh39dNtwllqlQtpypSnRpcFEJpYZ2lzqPkBpEJLyV409Upnfc4/OCeSfVXbJEecGen6
         iaQqhPN8exUTgw/pu6sBu/ruAIJpQJDqw2hpQBM4JrL6qXgEtEvI1IKRQT+F8wMUh3/B
         71iA==
X-Forwarded-Encrypted: i=1; AJvYcCWm97nOY95OXxtQOTx5IzKIeRW1ojv/FpD35uultPWN/ZTeHJA57qUMTnMrJwObLXhIUYoqMbWtxEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YySKImPrMii1a2oBnYsavr8Er5yverbxC84LhtadF9ZGySUZEOo
	cAfRg5oiCM16pt58J2AhJorJ47w6BE+7ULfK5EPPI7FNle6gKVw3vb9V2MaT0B358bA=
X-Gm-Gg: AZuq6aIP6J+wVUBHcQZktJT5BgW04TcJFLSpZvr0xIRhlqQazrEPVj2U0ffLm4yZxro
	kMivHSbEeyZsKZPsg/7wdKncVvTrrkczu/Fcx9wKBgtGTidkBo35mApUmJvUs4DrkTd/Xsj6h9I
	mc07WXaiEV4+26OGWe1WlQ//GrHtXc7VsrEDOeBqy8vwVMZ99E7k0hlig4vimKpMGRQBf2G4JFv
	8Opn1TYcLJhKnYP7waADOgllwS9kfPwMEGA4dRkDekHPgfqmS1PGM2YlFZvJhs6joR+0u595G3f
	LgURBzVAFag1Z/wrChjPCwpNfd4+SKtRGo8I64kB98QhvCkjJ/rdVar1xJFXyUfmz1pQ972UBMZ
	L7MdnGbJ5uTxd4cxl+qLdN5BMrkshJRQnBClIDZkpcO+cp5/U0Almzafmy+8/NuPfljiBm6Ce2z
	ve1Pokuwo14zdcR301PoSQVyjkXjhnznoG55z4IAynjiDbFcMpUgkgamGdchZ/UI4ZG46nLg==
X-Received: by 2002:a05:622a:3c9:b0:4f3:4bbb:d5c9 with SMTP id d75a77b69052e-505d22edbc3mr54217681cf.79.1769799807104;
        Fri, 30 Jan 2026 11:03:27 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b7b380sm700189185a.10.2026.01.30.11.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:03:26 -0800 (PST)
Date: Fri, 30 Jan 2026 14:03:24 -0500
From: Gregory Price <gourry@gourry.net>
To: dan.j.williams@intel.com
Cc: Alison Schofield <alison.schofield@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/2] cxl/region: Timeout auto region assembly waiting for
 endpoints
Message-ID: <aX0AfDapYz6-xRYX@gourry-fedora-PF4VCD3F>
References: <3bcc5143777acc6d45675d78dd8c57079406bc53.1769746294.git.alison.schofield@intel.com>
 <697c3a6155b46_1d6f100e1@dwillia2-mobl4.notmuch>
 <aXztmSYih24WZgsr@gourry-fedora-PF4VCD3F>
 <697cf7bed7112_1d6f100b0@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <697cf7bed7112_1d6f100b0@dwillia2-mobl4.notmuch>

On Fri, Jan 30, 2026 at 10:26:06AM -0800, dan.j.williams@intel.com wrote:
> I do not see how we get into this situation. If dax_kmem comes up, then
> there is nothing to clean up. Yes, these can race, but typical locking
> should ensure full forward progress or cleanup.

yes as long as the watchdog checks for the region actually having come
up or not before unbinding, it should be ok - but then it seems a little
odd to push that to userland if the driver basically already has all
that knowledge.

30 seconds is quite arbitrary though, so you have a point.

~Gregory
