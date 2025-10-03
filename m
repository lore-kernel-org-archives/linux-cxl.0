Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0251A2387
	for <linux-cxl@vger.kernel.org>; Fri,  3 Oct 2025 04:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759465714; cv=none; b=aHx/kkSwuBAhj1IB0+d0olu9nv3WPd9PcQrS9J1RAkOy2W6qUeLpD13p0/iO0tbx/zLxrJA79F1fSRdxeGCYRImy+zEcHG6FKszl6qxUIaLqU0rYJK+nTP37LcUSLFBlRzJE4JYc+5TM3TCED2s441FuCudi07HTxktLn7tr3ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759465714; c=relaxed/simple;
	bh=1x2paevEmWZL5BjszJy+ErjUTaRao5sLqmxxx5HKEOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfqvjtscWIeNJYN5LM2IABjqrzW9f/ebykB0Odov4DfunV4M1jHsiP3Y9ax46z1nYyIaWjb8watW6vidZVLjJ0poTKp3wTxA2fNmtAiam76IuR++SXomzVZP5DsE1zq5JSAj2NDVEWT+Ro2hmwujO+nxf3UxHhxLyI40J4IuQWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MlmSlt0h; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MlmSlt0h"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7f04816589bso210025185a.3
        for <linux-cxl@vger.kernel.org>; Thu, 02 Oct 2025 21:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1759465711; x=1760070511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l7laoun6BLBv+J0t0ls+E/q64BCmeJXWHsIjdFyERJY=;
        b=MlmSlt0h2Skh5fh++xPO9IuU2DwteyxJPTbKrzRiQ7aLF0y9qiS30+VU9SCy8rpCc4
         AViBXO/DbGFwyQFiwlL/Crm6fNx3eFmUEv3q3EywmFNaXaN84ak7PRloFQgjemoh+6V/
         RaKWW9oU/n56F20bXln6SO+J8Ee7RJjVv6ZX8ZLtFxyOXpN788EujbuHchTOpkInMMS6
         PA2iGwTVYcJPEq+ZRJ3FXrT69JwLxkX+qc9tXqoxx+OJhn8VqJSET6YeKZtVUJco2grj
         CePc/O5w7NVsYYu/tGRkbjTVVOiBC1G7bliNgNJbEyyo0NF5GOvSCxSAebF6JNI1EUWd
         zCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759465711; x=1760070511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7laoun6BLBv+J0t0ls+E/q64BCmeJXWHsIjdFyERJY=;
        b=PQO6UAVEX+aykylAycmITntOeDFd2sxOTYcqlO3QF3FWtm9RcUwZBn97WEGpRsTK2R
         5PhTI5Wd3Big+1sGtHy5SOoYmj4MuMGP/s7n3k8ihLqpulxloD0bfbeMItrqyltTq4+l
         JesTETIhXikf7w8wZMUHKsp350tEa4nwxoEvLxwtWsNvXiu1bctgKFJwqZy1NE1W6PVW
         Jq/rAe7PydArC0WmPfquAgbwoUYrr+AciDqqkekKlFc11fFzv0BMHspEN5XSwJ5zFbYI
         2MC1U+JIEfBC6ApwyzlAqhS9qZGhgjeYHnG9DC8sDIqXZjDg6Laj+s7x/Yyjj+eiftUg
         pUZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR+Jijvx38sPg3cyi2EYYQcBo+AOa4mQTqvwM329EhlGUK/2MejjossbfS4dZ8YFk+p7TRoFZVxYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI48rqaCFdTbxuCSaoanKVs2JxKyK/Cf/9VXhfUotBllUaMsZN
	4HvyqLZ3E+xNvuBq7Lo2jfDIxaNZk0E/UhqpsmuNUvI+7fFTwXC1VlmZ6SDFXyLcp4E=
X-Gm-Gg: ASbGncutq+oJKiCSpLMaVSFKAs9aClVI4nfs9F8mJk2YDLKJHiDna6ugca/rhyEwHlx
	98l0Xp1S+cJ8gtcjHC9TwnvVET/SjAmPTqoL2Pn1R6ga4fEoiQAlbjvrClSernSHAoO8byPfv2v
	ZUxGVfJHTOQLeJpAAcGi5AGe0vYQxDnRkpDEso5GJ2jZhSPG5fZTrs5PSdRnJcyviuSRqhKem0N
	GneqiV/Z5eZABBY51hinY+7YrrwznbKv+5j4WaFtKEZelLKoXNZXZYLyPI+XFw+jOlnnGwPnY2q
	3TzIWxbl+vT3M9uSV2ZdWWc6nrTp5bniLDw8p2MxoKMR2IQRoDDI88gIVsRbYl0WifOcJn04LEJ
	VEr4I5IroQYMY03+U7kIjnNlaxMEauSJnvKXWpbu4RgfVpkWgo2HZbumQS2GtxctVCj95uDuOnL
	Sq4WharQppSGPXwOO1JfBp//4qEuK+RpgOmqKn1IYL
X-Google-Smtp-Source: AGHT+IGoBfg687Zb0RivQYwvewlvLSVf4PUprK6kWqW3uH6tsrVVwD5VkG2ol+cbWe6+E0nQGqpCyg==
X-Received: by 2002:a05:620a:40cb:b0:81f:eb9f:8564 with SMTP id af79cd13be357-87a3a258232mr249702485a.47.1759465710899;
        Thu, 02 Oct 2025 21:28:30 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87772740ef4sm335463485a.27.2025.10.02.21.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 21:28:30 -0700 (PDT)
Date: Fri, 3 Oct 2025 00:28:28 -0400
From: Gregory Price <gourry@gourry.net>
To: Vishal Aslot <vaslot@nvidia.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Li Ming <ming.li@zohomail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Zijun Hu <zijun.hu@oss.qualcomm.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/hdm: allow zero sized committed decoders
Message-ID: <aN9Q7BxpPOSYBVU5@gourry-fedora-PF4VCD3F>
References: <SN7PR12MB81316C958DF0F4B10369B928BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <cb300580-1297-4d4b-9a3a-2cf7445b739b@intel.com>
 <SN7PR12MB8131FBDB82D2A3A539FA09D0BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <70a2ea96-0a4b-4185-8f37-ea77ed757b64@intel.com>
 <SN7PR12MB81319CD146CC8B4CFD45E62FBBE7A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <SN7PR12MB8131F796BAE8B6243E088879BBE7A@SN7PR12MB8131.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB8131F796BAE8B6243E088879BBE7A@SN7PR12MB8131.namprd12.prod.outlook.com>

On Fri, Oct 03, 2025 at 12:59:07AM +0000, Vishal Aslot wrote:
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index e9e1d555cec6..50164fd1b434 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -1047,10 +1047,10 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>                 }
> 
> +               port->commit_end = cxld->id;
> +

Went looking to understand what commit_end actually does here, can you
help explain?

>                 if (size == 0) {
> -                       dev_warn(&port->dev,
> +                       dev_dbg(&port->dev,
>                                  "decoder%d.%d: Committed with zero size\n",
>                                  port->id, cxld->id);
> -                       return -ENXIO;
> +                       return -ENOSPC;
>                 }
> -               port->commit_end = cxld->id;
>         } else {
> @@ -1210,6 +1210,9 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>                 rc = init_hdm_decoder(port, cxld, target_map, hdm, i,
>                                       &dpa_base, info);
>                 if (rc) {
> +                       if (rc == -ENOSPC) {
> +                               continue;
> +                       }

Don't need brackets here

>                         dev_warn(&port->dev,
>                                  "Failed to initialize decoder%d.%d\n",
>                                  port->id, i);
> --
> 2.34.1
