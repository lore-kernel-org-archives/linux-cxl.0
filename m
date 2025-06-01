Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B97428C2C4
	for <linux-cxl@vger.kernel.org>; Sun,  1 Jun 2025 23:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820650; cv=none; b=jcDYNNDwi9hNxxVfHu++KMMffz39cx3i93wDXIMhOBQ8pqDWr9U7ymqT5a73guXe4wD/E6qIx3dyXmyyIDUbi8CVAYom3wwPDlIe6+nxBq6g3Hepw+eLOMGShT5VOSqfSl/qDZ1UrXqGFC48ox0X0LTSHwWwKw2ymgciF2SXyRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820650; c=relaxed/simple;
	bh=SSGlRVBX7Ip3ay6aSI5KJLngtv0nEq6HZf42gbzA32M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZix/yUjFfFr2ndjHU1ed4thshZRx8kr8R6mCt2a/jcN64hsnM1KAq0IsoB4027jlDL64P/toKSUq/1UrDobUyZIIS2B8p/c/veEFuOSha8arChBM/066Wwxx1GHN1N1/FomyKmyeLGjb0DxWywUlJVfOPPCPSVPVT+J4w0B804=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ALjex9gR; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ALjex9gR"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a44b3526e6so29767501cf.0
        for <linux-cxl@vger.kernel.org>; Sun, 01 Jun 2025 16:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1748820647; x=1749425447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3ahtq5iYBzerYLsn2L4RRjLdCR+uk5v7bMh9egaPjI=;
        b=ALjex9gRMTmQ50it4soOyvAbAxZmVhMqeTenLVUSlJgmgg2i436msWqW7NPxB+PcGz
         8E71fLpVjbn7fnG32k8Cd33Im37uQienEuVV5aZKfwwRJH/g2N4N0WSPUcHv/YJVB7Me
         vUCq1fJJRACnOIOO82ys7g6agTDGMGelgnXRZMkBRCPcyTJgNNyyNPL4QORouDo0bsWf
         LuiaONA3E5+LirJ8+frAHn94QnCaeSXPMS6UcWmmIxfgNPZMKmu1tTd1z2XgaaH2ZLfK
         s+wdNie7dcETYVAw3m7HcYLpI70eH6OKE/gT4ftKWRzPf9MJRXa9tWRLAiVM0w8zarNq
         p++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748820647; x=1749425447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3ahtq5iYBzerYLsn2L4RRjLdCR+uk5v7bMh9egaPjI=;
        b=pL7IcZTLBe+iz+1y6EDvusWhQuXlhZCCl4srB4/DW4U0VS4kJkt4W5iOynq9CuIjkv
         AcmoWVwL9htDHvFv71YEqoJudQGPY7g+c9/qqotAgY1b8znepMDmgPjixen/6M1rS7iB
         +wVs1HQxrHiyAp0M7/839JRd8lbzGG0butCImG0JuPnFIfA83mFz2b873tQwUf2fDeQj
         Y8R+FkTaglpJekhCNEJew2158/GCxKbOTfuHu4jh520WlTIlH1gZ/8MHQu/4k3PXiXaG
         w2/w2vy2H9AwfKHK2BggA6L0Tzyw2baJyZNJkDdyyAm689EugWLmKxScWGoCeYNJ2ToQ
         s4xw==
X-Forwarded-Encrypted: i=1; AJvYcCUYeM5FVx2N4IHu/cptWgHPxLDToRgZD6kORmUYfuyic9pYzxYjO8c+Zhe/1jCy5gERv+5hCqEoVOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEoc2zUO6W2E0Pla4NCOJOYtE+5Eps5CknVPjvSEl7dcTpQlhe
	PA5LO3+gJYh1EVgGUaIn3YPgIM9TfbagPgL9awRVs1w3kP35iRg7hEH79JFLyxO3pfA=
X-Gm-Gg: ASbGncvO+ZRyVLobHhmhxyhmFuZYUlmrUlugOKSjrpDxu5ATWpX65roWzq8U9s1yzvZ
	eaq/wloPklxtFt/RyjO4DfmlJH8oVCg8OcTkQIXUqI5Hfd9Ucg4gMtP4+/8eWo/HLu/bDWEE9qy
	2PwMN8pvk1E9wyrcSDbaSHSr6tdNUZMBYDaAgceUL3KlwLO1Wfy6HjUqkiAyIR9u61wxVGBURJ/
	mir1xle8arWxU6NVHezr9WYMuWAiEHC3/HcLUZ0GINlNnxPW1q1LS6F/1E03VY0rlg/r2I/XBOJ
	USXS9sJ5+w0vUxUqWTakuw4PdXME08O0jPPdRSpkNX9MPpb07G6FRahf3K4KcIF5XvIO22tcDiu
	HJvxHvJz6GwNw3Qf1y6b4dGr38ztNFQc=
X-Google-Smtp-Source: AGHT+IHAt46IPZ2ZNZ13vLsgj7LdizYMg33TCIokRzOtUXTMz4rVh+t4qoD51lnIbRNNJhpIDOFVlg==
X-Received: by 2002:a05:620a:1a93:b0:7c5:49b7:237c with SMTP id af79cd13be357-7d0a1fb77c1mr1867411185a.27.1748820647265;
        Sun, 01 Jun 2025 16:30:47 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6e00cebsm52506366d6.73.2025.06.01.16.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 16:30:46 -0700 (PDT)
Date: Sun, 1 Jun 2025 19:30:44 -0400
From: Gregory Price <gourry@gourry.net>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, corbet@lwn.net,
	linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, darren.kenny@oracle.com
Subject: Re: [PATCH] Documentation: cxl: fix typos and improve clarity in
 memory-devices.rst
Message-ID: <aDzipGmldaeje43H@gourry-fedora-PF4VCD3F>
References: <20250531075209.3334261-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250531075209.3334261-1-alok.a.tiwari@oracle.com>

On Sat, May 31, 2025 at 12:51:58AM -0700, Alok Tiwari wrote:
> This patch corrects several typographical issues and improves phrasing
> in memory-devices.rst:
> 
> - Fixes duplicate word ("1 one") and adjusts phrasing for clarity.
> - Adds missing hyphen in "on-device".
> - Corrects "a give memory device" to "a given memory device".
> - fix singular/plural "decoder resource" -> "decoder resources".
> - Clarifies "spans to Host Bridges" -> "spans two Host Bridges".
> 
> These changes improve readability and accuracy of the documentation.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  Documentation/driver-api/cxl/memory-devices.rst | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
> index d732c42526df..e9e2952a967d 100644
> --- a/Documentation/driver-api/cxl/memory-devices.rst
> +++ b/Documentation/driver-api/cxl/memory-devices.rst
> @@ -29,8 +29,8 @@ Platform firmware enumerates a menu of interleave options at the "CXL root port"
>  (Linux term for the top of the CXL decode topology). From there, PCIe topology
>  dictates which endpoints can participate in which Host Bridge decode regimes.
>  Each PCIe Switch in the path between the root and an endpoint introduces a point
> -at which the interleave can be split. For example platform firmware may say at a
> -given range only decodes to 1 one Host Bridge, but that Host Bridge may in turn
> +at which the interleave can be split. For example, platform firmware may say at a
                                                                                ^^^^
If you wouldn't mind, can you also change:                           "at a"  - >  "a"

Otherwise

Reviewed-by: Gregory Price <gourry@gourry.net>
