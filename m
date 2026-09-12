Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7060B1E1DF0
	for <linux-cxl@vger.kernel.org>; Sat, 12 Sep 2026 00:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789172445; cv=none; b=o47tI5YP8OJHESyGR77jCsD7qHOTOWHv1t0cjZwDetQqmGqDoKNd2RgIObcMe3B3NVTERayX1BmEJgjtSvgQyQv+9eSOOh3CX4KTef0aTic0TfgVxN35PnRJlLXvrIHoRkrr1G72Qx1TK6eOy8TJrAOqq6ZAqliN3Kx/ye/kli8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789172445; c=relaxed/simple;
	bh=q5i7AMrm8OnrRcezatjI+jxgblvlNuoyikRKV4MxWkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdK85x67VqbRZxfMSnAuKaNpUFCMeAvMAZq+oMCLtPLLYtbd4KQOhqvTQYbaAa2EX1z7G7F/LBPZZYL8GUhayCxw4rkl/ZjXbvOAFKyv5WHLO0qYMbObtwDBNhbUC+DTfJe13QEDjA6knAlsg9zW488UQBWyv3BhXG5eLa2rciM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=aKpD8avc; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="aKpD8avc"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfbd148cso6468636d6.1
        for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 17:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789172442; x=1789777242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q5i7AMrm8OnrRcezatjI+jxgblvlNuoyikRKV4MxWkw=;
        b=aKpD8avc8PyAVJztNiNq+KqEDJKLFavKK4OXQ1v0Af8Mj8UqVh0krhpQ9mFGQckb4o
         wQRugnekjpHhC5yfCIgnuXwcsqViMsLmHjwl/Fo1Kyo7XePIpaiiW+b3HwmJEMewz5vP
         dnP7s+S08297dca/J4eZeOUPgbmFQCIRuckWuJSFp+ljXQsgRkBFTGJ7+sNlFte99Kfw
         sj1dam9daTr1XxSBVwdfackVevmjpycoGuxXGnWhcaDRN8mKTpbPWeFiT15Sjg8NlWj5
         ECRhkzswhzmbBb3dePI+em5/nXicQQ1WZIdxXXx9FRgK3UZxykMxFpCXaMVHGcmwuyT7
         skaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789172442; x=1789777242;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q5i7AMrm8OnrRcezatjI+jxgblvlNuoyikRKV4MxWkw=;
        b=pEO+EFdL0lLXHMf8PKXEiH/fKZXotsVOs6Rz7t/7z0Kv0uCGHxHfqVjg0csGUJQ1ti
         j+z0E7bPDRwixgtl8k0RWa4nQNxkze7G9Z7odFBy6A4TjRdyU/3sB29rpxkSVglAO2Ae
         uI2+Mq5ey9lwIUp6Z0yHaogmwYqs1bJ4k0sCooEYzqStoPCroQ9bGdUKqALrmSofjK2U
         ynrwAjizLx+EgIPMT0vK8oYiBVCsZcyjN6RZ4c2zjvL2V9QVEBTlE+awT/CBKadFUNHr
         VuJQmbNhGOzEEU73AQsXCYc0UshhhgmXELVLri0BdJc4M2GYJco8hs/P43EQ7dcoRf8h
         ZfRQ==
X-Gm-Message-State: AFuF++lDWOeudrZcefKN1CZ2in1YANfYZOiABQdNA5dhHR6yBBeVp8lN
	DS79dPowDSFYnyn0dxfefDUrYr2eNYA/rNIzhb+R2oo16uK+JNsgQwwAP45++PyqwG0=
X-Gm-Gg: AYBFou3bl50OQNb42vDfMhJvJCeq/tN/zzsuJRAwt4RGbrnr1oh9IeewgvyMK1kAI1i
	mXy4dklSAJrJUdUrPgKfM1QMbqsrGl8xPwWAwP5PzED50Bid4FzWciE95rxDkSci+n2Hs0by8gI
	s2UsVNu1txwGB0b76E86OMwVsjzOw+ErKzbCuHBgwsPWTdpl36ioQJUyulMaBLcYEzuN5eiz8L7
	Y8GqY/itlVxoYIf1Wg2ALFYY7hGAUMzXgwJJP2thW+JC7aAfQRmAh88VoZrw9WSKgwDTNj8CwDC
	6eqNCTbmyWe4BbGGpsPJee/vSG270BjNf5rNnVv8cQtGJiPqd16pwniLkI1AYTTCd7nWhJqizhL
	oZ/aNQJzdZJa9RqzzHqLyut4+foJ+5QtlHU6b6y4oqJ1GBmeu5m/eoep8K54wv+3G+Pry1/eZoA
	N+pGVfyRKxAW4mx5RAhYaTh5gRKb5rIqU5VfIwHYNF4sEvfCKUVNhe95hUE8OUPGRQQAryr6YgQ
	IdCQvMHSX2gi4vRzp166OBRe08b8aad/jrc2pkmMEEQNCFxGeV3jZEOYeAWGpJjjQ==
X-Received: by 2002:a05:622a:2586:b0:52f:c0f3:fff8 with SMTP id d75a77b69052e-530c85e34e3mr126561591cf.24.1789172442314;
        Fri, 11 Sep 2026 17:20:42 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca4e6a9csm32451091cf.23.2026.09.11.17.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 17:20:41 -0700 (PDT)
Date: Fri, 11 Sep 2026 20:20:40 -0400
From: Gregory Price <gourry@gourry.net>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, alison.schofield@intel.com, 
	jic23@kernel.org, dave.jiang@intel.com, icheng@nvidia.com, ming.li@zohomail.com, 
	vishal.l.verma@intel.com, dave@stgolabs.net, benjamin.cheatham@amd.com, 
	Anisa Su <anisa.su@samsung.com>
Subject: Re: [RESEND PATCH v13 8/8] Documentation/cxl: Document DPA partition
 layout and ordering rules
Message-ID: <aqSaZaaWaWUfKrC7@gourry-fedora-PF4VCD3F>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-10-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908102124.2231730-10-anisa.su@samsung.com>

On Tue, Sep 08, 2026 at 03:15:12AM -0700, Anisa Su wrote:

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

one question here, but not overly necessary to document because it
instantly becomes the moment the code changes (for reasons).

> +
> +Linux follows the static precedent anyway for the partition it maps: the
> +first DC partition must begin at the DPA immediately following static
> +capacity -- after pmem, after ram on a device with no pmem, or at DPA 0 on
> +a device with no static capacity at all.
> +

What is the reason for this requirement? Just easier to code?

is fine to leave as-is, the first device that comes along that needs
it changed "for reasons" can fix it, but it seems an entirely reasonable
restriction.

