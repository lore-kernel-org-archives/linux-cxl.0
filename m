Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C7438759C
	for <linux-cxl@vger.kernel.org>; Mon, 23 Mar 2026 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281328; cv=none; b=jodw+8qQdwtxDhajBZGD+i1LsB895Rtm2IxsPwYyEmYmVtol1bpn95xTn/R+NTliIT/g2U0xV4whsUKkMZ3kMDBEttcDDFyti5iamaCSjwEdhTjISJfnpucGktZOwk1DDmH5wPNoSHWf3fzLAaRLOtSlTuS5v0cdrLRaek6+7Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281328; c=relaxed/simple;
	bh=lX+Bjv5gwvpWYyxyzQ+X0tXLMWOc1bEx8TOlU/3PV+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrKTMxnxJBSvZlrGMpYZKKU1LMpbyYB0fNO6lZc6XJeWX8d35cic+2sx0SgXe+fOmAa05zxopLric+8MMQS7GOgVJ01/dyot/xLL9Xw5C2+T39Hi83KZWJZKJgAEGRmomS7Q0zWR3x9nPpdFbKRIkXmmkeP9+mGDJJuX55oUGqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cFSRjZe4; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cFSRjZe4"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50b4001af28so31611571cf.1
        for <linux-cxl@vger.kernel.org>; Mon, 23 Mar 2026 08:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774281326; x=1774886126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GrhakMb2iyzhEwZiPjId+H2lOD/QCjsAPbzl6n05L1I=;
        b=cFSRjZe4azpzxKranc9IUqxxq1yw8b0QV/Ovk2acOal6xvEw8QThSzwAE6ApvVY6ur
         Um7/S4LZgiNJny2BmOctTPZGP07xL2C1LNJcaMBkMoZe7++Cc5uEjSgcPikdxJxvN9hC
         Tv4yxuWBjSRKBWEC/NAoqPccf9G86ztsIorEnlOlaGaX5Io0pPCRMeJzfdbxRZFu0FM1
         1gqxmoSsZd7yEqCWE4qOE97TSx0+obcve/e0dKoBIltosXf4gRxtaYsMd2USnTTKLqON
         2MqF8cDKsCMq+jB1Yf9bPoNqgVUpDA4+uq5Pd5Ln8w+iZWedkOpaNXrDr/L2szpfO05o
         ecLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281326; x=1774886126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrhakMb2iyzhEwZiPjId+H2lOD/QCjsAPbzl6n05L1I=;
        b=gT1GKRuXfzWMjgJMFqVHzhL3Zuu5n08AGbPy4kawXsyxQtEWYNfqG4zV12zsLbtLn/
         SowSRVKDGKMzZHJO8bEX0G0hVlYO/ZEmhXSjHrCWhtnWN7sr454PlsLDvXNTQrxqBeg0
         2qffv4yyaI+mjb9rb8o3CTkFOfjFkHAylAJ4/UC9TjW/MHetVvOHG61OEJjsJObh9s5g
         VCDwtz0WH/8LL3XzDTV6EsDFRIDrjqeN+wIt6T1faYHbgxThNsvYQXuWRa3LFBfdrK9c
         +MXGRc5k9EMRmnfQKdcT7D6DFpDA9leUOUfJaafMMDr6mvOIFuUV4eu7RKTERh57tjxp
         86ug==
X-Forwarded-Encrypted: i=1; AJvYcCVsGCejpXOqGUF8L4bUv+RF04DkkvVJsOkgt+22w/k4OoBr6+LfGTS1fsGBapiP0TdFONrEW9bJwMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymt14g3Tnia7VmUspmBsyb70Srx+s8h9IEX5AQ0XMEhBqqVMnV
	Qsta30Uts5Iuiq73t2filnu3VyIePt/QJIvJkGbcv3OyB/JELTFzwPNtjsoj2gp9ZiQ=
X-Gm-Gg: ATEYQzyDxHDX/rKhfgB3Iak1VH0ccV3j0jyS3gBm4rvPv5Yv8L9ue4DUXW67V0YfVG/
	7bbYKVaehhnQED5EWmbIeaKho2ZPiWANrLhHG9WrwEx5Ox+72jCdeVY59c51Hsiwxs86rGQ+cm8
	7tcqrm/h2ZZnTN0sV+Zs4ijAXEILRVoLIVGmsQW+zAzVeS0hSyUp7oXA2hBhW00s/KN79OFnNDE
	vDyr9QzK5MespI1jnQ6QL5IsOUhaQh4jWtnQIj8XUr+AD0deZnSu+HEF5LX4L/DvnnDURNipXlG
	FL5HxOq52B6NXhtsb4ClIFBENJRRe0cWy1zVwxcw9Vgo3PuViMvOx0VXP3OrUpbj0nlRY2VyULo
	Ynwi39GPGkR//M35nT6FCUJ8vOeLlJ7EV5hYYpGBjzI65lwUwsRU/jGoXAK/xBlUlmUO8GfwiTp
	zSdO1R+QFmq00Hw5StE6Xih3hH1HL7nYWKVuDFSB7AeIiH9eHTBY8hvO4dxo0hQ1yx6MFWmXIU3
	psH
X-Received: by 2002:a05:622a:1f08:b0:50b:496c:baba with SMTP id d75a77b69052e-50b496cc8c4mr129862901cf.57.1774281325705;
        Mon, 23 Mar 2026 08:55:25 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (158-94-182-130.mclarenap.oninferno.net. [158.94.182.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c85215615sm91770346d6.10.2026.03.23.08.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 08:55:24 -0700 (PDT)
Date: Mon, 23 Mar 2026 10:55:17 -0500
From: Gregory Price <gourry@gourry.net>
To: Li Ming <ming.li@zohomail.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] cxl/hdm: Add support for 32 switch decoders
Message-ID: <acFiZehIZXuyBf42@gourry-fedora-PF4VCD3F>
References: <20260321061459.1910205-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321061459.1910205-1-ming.li@zohomail.com>

On Sat, Mar 21, 2026 at 02:14:59PM +0800, Li Ming wrote:
> Per CXL r4.0 section 8.2.4.20.1. CXL host bridge and switch ports can
> support 32 HDM decoders. Current implementation misses some decoders on
> CXL host bridge and switch in the case that the value of Decoder Count
> field in CXL HDM decoder Capability Register is greater than or equal to
> 9.
> 
> Update calculation implementation to ensure the decoder count calculation
> is correct for CXL host bridge/switch ports.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Gregory Price <gourry@gourry.net>
