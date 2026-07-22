Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB72344AB91
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 05:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784697911; cv=pass; b=DUQGz2hulMauU4A9Ht38eb3z8MDMYe8qqyZSKfW2q7oZUNJhXppczIQX8Z+01tOLiIpnL7xMtwCIeA05PHvGKIcBI+okIZk4Ng7YJnpbEl452/SR5ID9ELJSkWpa0gWdtBE2F7K7HmNvx3dQR3teVawz0DnYIknNQLFwoAC/noY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784697911; c=relaxed/simple;
	bh=DM/iU+789iXlJmO44SQ6x+2xXVn4ae/D2AXVJ2O4UHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sPT8pYM2j1uWgM8C5Jp3XdBvNts8miiLroXrADb8NuptQRPXv6wp+d1V3JjtGzt4jNYphNNhhz3A+EXneOo+dRP/LhFj8jifQ/U2FTxSrC3JxBT1AV1ADcHn+NXSZeTFll4IVLst5IZPSQ0ktuoXl23Yp3rj5d39B3c+UT9bwk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=AhkVZDKx; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="AhkVZDKx"
ARC-Seal: i=1; a=rsa-sha256; t=1784697902; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hKpVk6bL82nNkpglq7cqr4LgPrToSbheRRIfQr+tn3sBcoxTzd4lCm4/XGIzbOi/1o/Hcbh6aZk+17Zq+QznlnljZ1q9bbTFsyH4gW7LUr2q4bHkyxWj+PBsp0msRGcq/zjC0vIdrUGxKTSI2Q15w0+ptC7WIC3lMZQk7/fudXg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784697902; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MfOm0wk1OP0UmBBXLArA4edXiGiG/BhYr4dPHh1hhmk=; 
	b=l6P2HIdkeTQFWlrbEJK0od1nW+5WtGd3w0yAaFTE7cydfe/guA6M2E9fMwXE0dpgerq44WlA93RYLDRUuBLrdaI4/YbKUQsYbmGqbM8wZkjRB3yuH7esuyz39iLscCgKPtArfMheui21Ti8H+oqZziJG454+2y7CmRJBnjBBdwM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784697902;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=MfOm0wk1OP0UmBBXLArA4edXiGiG/BhYr4dPHh1hhmk=;
	b=AhkVZDKxFSysVqAM5ts63WAtRmcSIpuOeUEK/ApRAXW2iA1D0OLknRyyFKVXVW5q
	lYLowen2lVdXH0AU3uG7en5opmu+WbtyGa1BPpdV2M5F5eQy+qfXcZbzUSs9bZec2GO
	2toOKaQri6aFh2v+rqpXhr4qq7yYD/u1Czt3bvHg=
Received: by mx.zohomail.com with SMTPS id 178469789890016.6172098863791;
	Tue, 21 Jul 2026 22:24:58 -0700 (PDT)
Message-ID: <8d75f4f2-dd2c-40fd-9147-4897e8061f9c@zohomail.com>
Date: Wed, 22 Jul 2026 13:24:54 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cxl/region: Fix use-after-free in
 find_pos_and_ways() error path
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>
Cc: linux-cxl@vger.kernel.org
References: <3a36953b5c665cb9544ba61dafbea0b0fa508c77.1784654628.git.alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <3a36953b5c665cb9544ba61dafbea0b0fa508c77.1784654628.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227899ae2315fb39c7a8100c21e0000c716ff9ec7d1580f46b6f4f1dffbe8563f234553dc18796159:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/7/22 01:37, Alison Schofield 写道:
> The error path releases its reference to a switch decoder before
> logging an error that includes the decoder name. If the released
> reference is the last one, the decoder can be freed before the error
> message accesses its name.
>
> Drop  the reference after the error is reported.
>
> Fixes: d90acdf49e18 ("cxl/region: Add a dev_err() on missing target list entries")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Li Ming <ming.li@zohomail.com>


> ---
>
> No changes in v2.
> Reposted in series w the __free change in patch 2/2
>
>
>
>   drivers/cxl/core/region.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1e211542b6b6..c86dd9d55e93 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1938,8 +1938,6 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>   			break;
>   		}
>   	}
> -	put_device(dev);
> -
>   	if (rc)
>   		dev_err(port->uport_dev,
>   			"failed to find %s:%s in target list of %s\n",
> @@ -1947,6 +1945,8 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>   			dev_name(port->parent_dport->dport_dev),
>   			dev_name(&cxlsd->cxld.dev));
>   
> +	put_device(dev);
> +
>   	return rc;
>   }
>   
>
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
