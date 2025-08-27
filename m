Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCC11AC43A
	for <linux-cxl@vger.kernel.org>; Wed, 27 Aug 2025 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756326232; cv=none; b=OSYsr8jTmZ2VR1CT1qkYfzEIzbA1PdPxNRqdmVZMkYuwC1v7a4J6iifFVkh3xdeGx9mk5E2zs+9zEFgkMfzvdNlLKNzbs/7czvKDYXJeDE9sBelUgzNBvdz8axu5o0Reg7UVfTSvlzW+m3S6wdEe9ciHQbdsLs2V8S4+2jF69i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756326232; c=relaxed/simple;
	bh=ympLIfd6q2uz8sPjeGy9ikp10Y5W46lxVKN2uHOkeSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFNgqyS605pdt0GFRk82BmN0zJmBydV4WPxxyx5BjrgUgqo2iowzOKokXHP9/tb8eup4BIPcywAvFHM+7jOMnB02nlEvFP7RdVgLGB2MSyZOjC6j3XGKpan9lgDMlR3KGGrxHdkQw/8zTKAka+DRJOC8Im+S+UX7n5rANbRH7c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=VfGp4OEP; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="VfGp4OEP"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-70de042246eso3023636d6.1
        for <linux-cxl@vger.kernel.org>; Wed, 27 Aug 2025 13:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1756326229; x=1756931029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tpOEDUkT9ltpYSIW5r16zrEEmzgxmIvdt7bvKP65LEk=;
        b=VfGp4OEPUkqUAXEYtqxtt5QpayX5o8O2Qr49ZnpVK0ygstT7Du8ecbeBB9mE4AO1B5
         eGC6fphf1mFXekjOpz7CjDWSV2WTkdr4tFwSBTuFzF8AnkAKdfsweaIGRp3U7f7Sbx9F
         wZJQYh+p+TZlqfksLeHEKQeyFpJnxce6Li0CsuvlrlhBxV6n8L/doHv4ylkUHM1f8OvT
         JfqrgBBMD/299d8taAhDGUfV4Bhi33P40ZvNfOtXEmaFCeZmVN/fRNhUuBgYb/MYvF+E
         TwnaFiUQBJi93l/fgR6iZrS49KT8O8Sbn5UM5G+S69Pn+7ZGseA72wKbhh2PIBFhWaKI
         IzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756326229; x=1756931029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpOEDUkT9ltpYSIW5r16zrEEmzgxmIvdt7bvKP65LEk=;
        b=clcp+H3mKguM+NiJOj/SxY78WrTj4I86thq60/qfBwKsYhRXGTwfOcL8vxsO0bodV0
         V6IDTl0A0seZyCY46hfsviI0QhHnuirw6EagW8HEtrQCCMz2nHlp+qg2a4Spitgdjn6B
         bz0rVqVcMc15Wi52ifxvcuAmoPdNygcNdHaoIedn+P4mnvACTpMzI3Ic8W2P14jlmA0i
         KXXy5rnpTGKIPl0wam9i1yWdLHnzbojSUqGBaTv8M0S33qnVtiddk5g+0H6n5IstNl4I
         UpozJWUS2/8irFrjMrfw81HCNNKhgp5x0AhugZsmlXsA82y1naZC45uz5JqLnV0EbyCp
         ii7A==
X-Gm-Message-State: AOJu0YzXpzHT1zNkdM/i5pNZfvW+Y6RMCKM4Rh8HwzVj9pMLIfWPGigU
	mtBWaBaZBYIWjponS5L5/7EnkcTPDlPI4oaFhIP2DZfKQB8Q7RJbu0PX8HFk6i5MT38=
X-Gm-Gg: ASbGncsYGF1bAQUR5yw3gPZclkMisBCENxNt8gcEkcDikBaP6EuhdIfR1VBA3byBJaM
	xZ5ff22i6dZfo1zxRBoWW+MUJIOoRnq9Mscw4lNj6waTK06p0i1s1CXG2wzEB9Q/0z/XAdBq1+u
	4w9IqsKhq9vFgSlsdlfzApiX1hyGWGpPLW7Zo9bnFET3x+4NzIx059h03erDgu3YvWGtbt4IGV+
	HJ4JaAVnd8NFlT4+n/z8Ia/bBuGW9QsTfH+eJj33cwTk5/5JV8WICRvP9zvuuGz4wP5tImD92g9
	x1+1IXcEOn1a5dVsuA7sJLJF/t9EUl33YMApuR26Pojone9yuWh1863jQIYyEE49195gjwWfO/p
	j7sledWljCkqxZdBiJjMfiDx/axox3rL4zulJXz1je3UkvQCjDAUjDLOhx993e1pljtHYA0zcBm
	/adA==
X-Google-Smtp-Source: AGHT+IH2jvq0biwVj6G9Lb1igaYWxMehi3WpzeTMyFhLVTHvBbvwK5R7zTgvdDX6KlbQ3p+4Xa/pJA==
X-Received: by 2002:a05:6214:5098:b0:707:a430:e01b with SMTP id 6a1803df08f44-70d971f7608mr246666016d6.3.1756326229319;
        Wed, 27 Aug 2025 13:23:49 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da72ce510sm89559896d6.64.2025.08.27.13.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 13:23:48 -0700 (PDT)
Date: Wed, 27 Aug 2025 16:23:46 -0400
From: Gregory Price <gourry@gourry.net>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ALOK TIWARI <alok.a.tiwari@oracle.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4] cxl: docs/driver-api/conventions resolve conflicts
 between CFMWS, LMH, Decoders
Message-ID: <aK9pUhETnNgs-7UG@gourry-fedora-PF4VCD3F>
References: <20250820150655.1170975-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820150655.1170975-1-fabio.m.de.francesco@linux.intel.com>

On Wed, Aug 20, 2025 at 05:06:39PM +0200, Fabio M. De Francesco wrote:
> +
> +E.g, a real x86 platform with two CFMWS, 384 GB total memory, and LMH
> +starting at 2 GB:
> +
> +Window | CFMWS Base | CFMWS Size | HDM Decoder Base | HDM Decoder Size | Ways | Granularity
> +  0    |   0 GB     |     2 GB   |      0 GB        |       3 GB       |  12  |    256
> +  1    |   4 GB     |   380 GB   |      0 GB        |     380 GB       |  12  |    256
> +

This may be a dumb question, but... how is validation supposed to work?

Like in theory according to the above something like the following would
also be valid:

Window | CFMWS Base | CFMWS Size | HDM Decoder Base | HDM Decoder Size
  0    |   4 GB     |   380 GB   |      2 GB        |     382 GB      

(ignoring ways/granularity, i didn't adjust those).

The entirety of the CFMWS would be contained within the HDM decoder, but
with carve-outs on either end.  This would be "allowed" according to the
logic here.

This would effectively allow all HDM decoder base/size values to be valid
as long as one CFMWS is contained entirely within it.

As a result, wouldn't it then also be valid to have an HDM Decoder cover
more than one CFMWS range (two full CFMWS described by a single HDM
decoder).

That seems like it could cause issues.

~Gregory
