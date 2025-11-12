Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA68207A32
	for <linux-cxl@vger.kernel.org>; Wed, 12 Nov 2025 22:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762987020; cv=none; b=nqSCYQ+628D9s7/P6jNxHQHFtLoRMMXWp9CzsvQ0ewL1nVSzPUxg5PgMW0clCqpLFPf1YQZsGGCmCaxdiAFXUlq5zEypJ3Q+Q5E2R8VgGouxAmbiqt/15h/EoquYiv2d9KYMNScxsRG8ebaAvJ7v5zzG3u02mdxQKYeXzEeVHeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762987020; c=relaxed/simple;
	bh=LPgsBEvnoEonnFLOfBv5HuddMkcPnZVrPmEkV4l0TSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCdaVK/PNugG3257EWMHqPuLwFdBHO6vUrV/U3vdrK8ROctmVtTnWb2wY2EMQTUoTxfy65nSOoQkqjd1ffN01KxlowzuBkjMSUmBRFEl6weu81wjHETKr6K8hlDGzwtlc0OTH3GH82I6J+tjdANdeknFVqrxd7a5/TvA0dwux40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dAIRctza; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dAIRctza"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b144ec3aa8so19275485a.2
        for <linux-cxl@vger.kernel.org>; Wed, 12 Nov 2025 14:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762987018; x=1763591818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cMNytqbDI8FzAjDManJ+YKoSJvcJrL+l2+VA087X3a8=;
        b=dAIRctzadCTgkKoFxZKeSSaiOCXQESCDhRTyBVEZzUmwmrjSyIQaXzMdVKy5auGTUT
         FOKAtrbXcPtC1mPBoGD1bFFOVkPSEotwIdcPbjuTu0px8U2k3ozeSXNL+a90M72/E40B
         moUvKwKcQbmpY/wXIMhcU0HuxNqYRIC+6UEzTN40/lVJ7yZjahtzWG/XsKbxc7A3CnIq
         NMFhpRj3MYd8kLAWDa8dzyOchOslIcSaqj8BtoFO/UEvI+1GUxlw/R12DweyHcF5G2JP
         F2DiG1k1Rr6CtXywG+CV4t+sn29zY3KMlxtohSVKyZy3o3obPgLOaOS2hnwpgKC1q1GV
         2v4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762987018; x=1763591818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMNytqbDI8FzAjDManJ+YKoSJvcJrL+l2+VA087X3a8=;
        b=iXGvYWWVNMiHpu7H/63z3u8vxR3PFxUNTIG9Znwnv5lJL/U8B1UXeMuvTUbwQAxOXm
         3D94maTBBnOSAGNwgA/zWrDfdj/03ybrbSjEK7iF3mIWYsMNiN1hNMDKoW838vRPefoi
         0HGu3Yysqcv8ixLTAtCWp6EJfU4bcE4aflUl1u6out5tOWLj6Mi8rUM4q3H028iTnTFE
         ppla2EH2WwVkb9L/08/RMrIksiKX3GguKZcAkwXI2JaRN3Ebozlqz7tB4/llQHPNbxHU
         Bcm4s4Pyihx9pGRSa1t/ulLGHdIRojdYwsSifRnJWk3iBhJbgRkoGVZZ8jpf3T0Lw5td
         iPuA==
X-Forwarded-Encrypted: i=1; AJvYcCVCcL6jygNLHiAM6mM8Pg12WQ8Mhf3/RMkv0B0vYxHa3a19bWwO/2f7u7bx7vbOvsIbCJSgNrzaZ68=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCNxELYroerBUIDi2LknKHRaFzMua8KFTlgq/wzNpvpo7f/X12
	XKcincJmg9D+s5BBuOt1irnWkIhsdffHp3pDpvCD5apQW6GPvFzJXMw3sgti0zPI1wE=
X-Gm-Gg: ASbGnctZsMLiz/g7Y43SwKSGdVQxVoO+/6Eg9NDbr+p4Pbd3LiGaHYBf2iAtqQZKprv
	YJIXV0GmHv0kxy2tzbsOVzfWOWxkWezuyDLVLBwVWfd4J1m9YrRahp2xuU0nyawciDuG9gu8dE0
	HE3JtC90tlZljuzXlSNt/mgTcWsA2Ybg2Locu3j4aqMhVrG7Zij2H7RRB4QUzRMmiQiJVz/OID7
	RSHVFjGcQwEa3BhaY7LE7VaH8OCQ+16x9reyAbtRVh4FaHahC0Av5He7OO0BJWBGo71BZPfVC0f
	Qr2IO7kLyfXNvVH0WTQNMOJYNx8oaoiPpeSOqKBoDAHh8I/QUTSUVUxtLllu8tLT/VAiYziK8lw
	KXj3eoaw9RIVGLMtcUZ/F6XzTexij7ChIFyWA0WPErEauE/njMVqihpNTQ0AyNNbfqiYPMUZ6TA
	LKqYTCUjwryR3AXhumh4NRsq6CJWmKZ0zrFgvZL+/+NdMbjp475wA33DkugE4=
X-Google-Smtp-Source: AGHT+IHSKjX9RCv10XVLOYeIj8kPKt5WTLdPspgyQ2/nAWVDl9dZp21csLPMcO/goytGE2kWAR0jbw==
X-Received: by 2002:a05:620a:2915:b0:89e:67a9:fced with SMTP id af79cd13be357-8b29b97fc99mr599752485a.66.1762987018035;
        Wed, 12 Nov 2025 14:36:58 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2aeea0574sm11729385a.6.2025.11.12.14.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 14:36:57 -0800 (PST)
Date: Wed, 12 Nov 2025 17:36:55 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH 2/3] cxl/acpi: Group xor arithmetric setup code in a
 single block
Message-ID: <aRUMBz8wl1ePak8O@gourry-fedora-PF4VCD3F>
References: <20251112205105.1271726-1-rrichter@amd.com>
 <20251112205105.1271726-3-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112205105.1271726-3-rrichter@amd.com>

On Wed, Nov 12, 2025 at 09:51:03PM +0100, Robert Richter wrote:
> Simplify the xor arithmetric setup code by grouping it in a single
> block. No need to split the block for QoS setup.
> 
> It is safe to reorder the call of cxl_setup_extended_linear_cache()
> because there are no dependencies.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Signed-off-by: Gregory Price <gourry@gourry.net>

