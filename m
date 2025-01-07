Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D081F37DD
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jan 2025 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736275287; cv=none; b=YwXWk5bwSBebri4MeWrWXQYIv/E5HpD73rWaRFYO2G4yyFmAscnSIdtXekcT+o/r1uKooG2hxvrc3vfPkGZpFfRp7v2eij6OyWzfWTiUxffU7gvccS6TGMy5hfw+WumvIxgx1TtWUBtUV9BOJdmoxhgs1ER2ep+NmaV6EX96Xco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736275287; c=relaxed/simple;
	bh=CUhT0qKasm/krOGKnxRhke1zSYMTe8IDIt8D27WS5KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpXM7Lb/MYKx/c2sOpwAR0kQ962z4k6UJvEE+wtcX5MM6sWAGp329Pgic4PXIU0dXlf63YK5jkO2Fz8i9fW4BUrzDnCaWzhUKkknVsqrYrkK8Wcpbs7xZ6jqDhcabmo879wcgx3wwG0Jpv+QyvVmFHO+DXpETlFzAi8kzAWsvqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=M8shJoam; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="M8shJoam"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-467bc28277eso132447611cf.1
        for <linux-cxl@vger.kernel.org>; Tue, 07 Jan 2025 10:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736275283; x=1736880083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pOa6RldRQLg+SPTe+trTGJEbRJpuxW7J3qUfJvoZNGQ=;
        b=M8shJoam2T/7TOHtOeViYb2aI3fkorQk58HXE0ATXLi+MT/p4wtJTVP8CMycXhRqoK
         SrvUj8M2y8MIAEXnk1RTYNcLXTFdFh9qWS2Uws6w3agYz2/QlcFTqeVpXIyriglAxu6l
         jeUgiksKTK3vYeAUq9jHqX9Fi8Ui2WpkMrANDxWst7DipVg8prCuKs4LUob8vBcgKFGx
         04t+C00ZJ0dE+1Qm/tRUBwsm2DXhoqRvjum81bTq+vscngjjloNnrmHLIcZg44L5tLWk
         dA6L4cMPpFVpVIZIP1ED87rvXnMaZAyHT+d04pKjpxRGyETVuTeIwSWoFHmKXcSWCba4
         OfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736275283; x=1736880083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOa6RldRQLg+SPTe+trTGJEbRJpuxW7J3qUfJvoZNGQ=;
        b=u3GOXBE6oHsUJq37MubgzY6rkshK70cSVNZHEjTs8eBzhYH3Du1wOKgsH7cujk1VUH
         YeATYkTuOb2JlwVG8olyklEl+PpR6SHZ7FT54+Cqv/zBUbdcq2eezgOfsqRx4izMqqqR
         5d9L1jswwe7ENZkUAEp2LcmHfyIBkStC7o8P217ORerqPiuLLGG0Ul2MYqdT3lKgp0TA
         QBeA0/FbmyWvtWZGjQslY/Jw0LjopPmOu56ZARYRNL2SjjN9+1uVqTDpUt5fqjf3OdTl
         nGdeBUiE4XQVg4vmnTaqRPfvVOUEEYl6RTDc30RIXYcJpx6KBmewOQOJ63V4SmdcIqf1
         SbAA==
X-Forwarded-Encrypted: i=1; AJvYcCUKyeGhjRtncCHpnw0i0Sap+oXxz6DqjtKF9Nroie9odHPfmeo+TbFR3kEd5Du3DzdGyYoCwUGef3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLl+ZX1wNwLu0D9yX20KhsSb+Lz6cmOAuYHxg//0iVBB/uAwcp
	6US3PwfV8s3Wq9vndYUdu1Pb93bOXVJRKA316trwfELRKYjUku6hBQBpJG1ER78=
X-Gm-Gg: ASbGncuFDMB/jpy6W9AXcNYi3pQoKBzEmHRPOiDFwopy9YMr4MBAIL1OLrO7hMKqwNT
	oNDTgumvW7cmP+gkB73IGAu3n28So6rKBFE7ApXT+NmUhsNSmTJpWe2FQXHim6pUia6GRgB0I4A
	+rjcNM2xs26ERaJjDUIk+w4FNSoP+o5JtSwuGpF9kG0ChmYe4/imZD8DLTf+HjGNNzzVNf5sgUB
	gek/qWAnGlMV2viWWfJmHwa6u8N9+HceNvdjTMAiL9ay+YxggH1VeF5cVQ9KyaSU7y4OBA/PaD4
	K0uVp6Mw9+cmBedGIRpcPgu2jj1ly7UmWLJFfOg=
X-Google-Smtp-Source: AGHT+IGH8CVHv0Avna17jMkfb3V14jhcj0KRMPhlO9rptqrNtxqwztrpyCjpSZqfnZM96SDUNNwW/g==
X-Received: by 2002:a05:622a:28b:b0:467:63a5:fb9c with SMTP id d75a77b69052e-46a4a98a203mr1178673321cf.44.1736275282988;
        Tue, 07 Jan 2025 10:41:22 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb2b0acsm189900291cf.73.2025.01.07.10.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 10:41:22 -0800 (PST)
Date: Tue, 7 Jan 2025 13:41:20 -0500
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
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 11/29] cxl/region: Unfold cxl_find_root_decoder() into
 cxl_endpoint_initialize()
Message-ID: <Z311UHk3D5UiJH8H@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-12-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-12-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:09:57PM +0100, Robert Richter wrote:
> To determine other endpoint parameters such as interleaving parameters
> during endpoint initialization, the iterator function in
> cxl_find_root_decoder() can be used. Unfold this function into
> cxl_endpoint_initialize() and make the iterator available there.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

This makes sense in the context of the prior patch, so long as the
prior patch holds.

Reviewed-by: Gregory Price <gourry@gourry.net>

