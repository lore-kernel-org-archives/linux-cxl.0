Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC6D14B959
	for <linux-cxl@vger.kernel.org>; Tue, 13 May 2025 04:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747111612; cv=none; b=XKQIFO+vqYFGGbyIVoqM/xIE/pGalbATENzMLHTGRkBRg9gvdUQT84v1ipXb4aVDhcX0pn3UWWFt3upYNJVA/R2pHjmqW+0Tf4eOFCaCA1Ge4YYbkU6tE0PAC/GyUI8EctBmwkk8wyaCOfFP5uUU0Dw5NfiRTtu0JE1Y6OF0kdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747111612; c=relaxed/simple;
	bh=8xWrcYA7k5Vzqj5NIgVSIGVNuqIZoBdZDdKZkzP8Igw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWmEr2FUdR98cEDvY1KjwgMaf2si51354kZ+HbvQ1aFW/caPVc/d2OoGJwXwMWK1uAbOmCKQewCSMo6CzleXmu0x44EMgmY91gdqTdJ9LC0xj2XvUbPCMpFyE3x9waHvIqV4Q2R8oXnrdl7sN54RML5tOSPtF66PEnFy3m2rVfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=E/NUHZiQ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="E/NUHZiQ"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-476ab588f32so80946571cf.2
        for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 21:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747111609; x=1747716409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jt/NwU4GWZ7n51T1zTP7Mh2OZNdTQhhlQdFmKv0CJeU=;
        b=E/NUHZiQjdBwT+j0pWqjkMKqs3J4srdXhF8kdf5uAkoSJXrWQDGOh7G4qoHFCP6Ijs
         dYgndpSpddPO6yKTRAEpjALYJQYUzib1mA2oQxvSbqGnOPcBdiYk2gsj0P8By0lkENBK
         89FHeSOG60BZJgvcGl6HMoW4/lYFtvgJEajFawww3iLb9ZADSQkh0MHcwaR6oie+RTYi
         tZBvGFXv6dzDVFDMEcrO7wQRadvKJ2WmTbNaFiI22a3x6UsS7Wyuxo/stYuSo7+A6oKT
         9FK0cQ+aIVUmkcExNQpoAofifmGn+N9WDVUy7Ywx5xO3nISy2uH1DIoL0KVt4PZy893V
         XlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747111609; x=1747716409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jt/NwU4GWZ7n51T1zTP7Mh2OZNdTQhhlQdFmKv0CJeU=;
        b=uWs7TwUcFjOyv8Ml1t1aKNEpbJJIBhDe5zlLsyp7oK/StvrkWZIB6U/OEarX5WsXsj
         +h1IdUPCXRE6bRbzcoUch6n9bKerO25wtCTUnMzjqn8MxczyUuVbWIbcPVc3FdqhqLlx
         D8upRJdKZYrua5X8jJTGIfXa0/Ep3QtK438HU6pRennOR5cqm271DeZl1IOEbkUsAC9q
         DaqdfK1yUDb4zgkyngrQG9ERkaYnTGtS9vxQpE/dxG4EjVq3Qczwf7XR1jEqJqS6H17W
         XFKaEeJ6qFNrTXI+Jyl7oEgO/TaiYx1QhgSEDNwhGZMAKuHVAILm9Keb+Zj6WpQcm4XA
         TOrw==
X-Gm-Message-State: AOJu0Yw0b1t/sqipE6DsxIRIY1aYyJ4a39eVyvxdrJd5iKkB1NiF8YgM
	4oOK8EJ6r+No/h+zfWlcM6ueJqWLH5vHxoxsn1Y2l4Jsb/4qZXf1AwXiOh9h/hA=
X-Gm-Gg: ASbGnct4ECE1kvwXlRrzwz31ry2teyn7yoyKE8m8WwtW9UDYLSB4t5cXq3ycEOQ2B2C
	fE18aPUPrK+/P6LPrQTrwSTEvyvHsWxDSebs8fay7rGZB4bh41uCKojL3uR8LiBQH9TjWpSKp/q
	3OylskPhCphqoOot8jz7pHWPCW9A9LwldhJT6mKs/xHHPa8YhLsX3aJfozB9N9CEvqc5h2to4i6
	a3T9A722nXVHy+j8AwgjIrXP4FzBEkLPmO6utj5+2Ua3muF0Ri9N02LK4vLgT2GrC+FI/DaIquu
	/BcB8XGrCuoUTIFzFGHfpU0s93yL88RGZjUpjo9ldRA9LLswuYkZLDzuB3fBIHd0g1qERxEk1uM
	QX2Nt904aB1561rOv3OikPu++WEt9L0o=
X-Google-Smtp-Source: AGHT+IGyIKE2DXQUT30zpTSrj3u5J388jOWqud23JgGJ+wj8U+Av3ODgXwv58oNCjx2syIEFU1807g==
X-Received: by 2002:ac8:57d3:0:b0:476:87f6:3ce4 with SMTP id d75a77b69052e-494527b8112mr227130261cf.39.1747111608963;
        Mon, 12 May 2025 21:46:48 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4945246c6a5sm60331101cf.8.2025.05.12.21.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 21:46:48 -0700 (PDT)
Date: Tue, 13 May 2025 00:46:46 -0400
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, ira.weiny@intel.com, rrichter@amd.com,
	ming.li@zohomail.com
Subject: Re: [PATCH v2 01/10] cxl/region: Add decoder check to
 check_commit_order()
Message-ID: <aCLOtiz17QNdu0-J@gourry-fedora-PF4VCD3F>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-2-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507004310.3536991-2-dave.jiang@intel.com>

On Tue, May 06, 2025 at 05:43:01PM -0700, Dave Jiang wrote:
> check_commit_order() attempts to convert a device to a decoder without
> making sure the device is a decoder. So far this has been working due
> to pure luck. Issue discovered while doing deferred dport probing when
> child ports are now in the midst of decoders due to ordering change
> of child port additions. Add a check before attempting to do decoder
> conversion.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Gregory Price <gourry@gourry.net>
