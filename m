Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFB133B975
	for <linux-cxl@vger.kernel.org>; Mon, 13 Jul 2026 02:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783910947; cv=pass; b=s5PHuK7R+QM5uUthwKRM6Rp6395QiEavhsntT/HbtmROl86pb3e6ZBI83RVX6kw8U5rXoakW7dFZC85Faaq42TsqP++u+bjkn4hMqCffRvD5Iqz3V57yaO9fjFz4c8YrMuAsJM9DMHzhCzWl+0fSVZajRGvDVdAg0xlWAsc4Bv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783910947; c=relaxed/simple;
	bh=ps1alfOy+OxgqeIyZ0gav9UvT4oAAV+laaKDT6yWHzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lr1iJMqR/ZCJ5H8RfGjbkBHFm3PJZU6RmA6XrodbFDB1y2VyMbbJik3delI+TU3Z1hi0MKc7hyDIYvvg+MLl9hGvel/oDrye+oTL68IMgw1Ig3qsUtiITFm1Y25YHsIV8ZqBoDRfomSwS2I0DD9pvp3ALfHT0LQpJJ2eeN1VS+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=XucdKBMz; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="XucdKBMz"
ARC-Seal: i=1; a=rsa-sha256; t=1783910940; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QnP0rK6o7aYYZjx0pOa/pK64LJ0GTKp0yDPhMknqZ69XgK5lDstdXATWQKwrz3Ri9NqUVuegC5FuHZatUoIBudZ2/RBxN50p9Vt81U8gzUku+zgV5Aj/2+ItpvaZhiMEWSMiG/O3SwPURxbLLzwK07WN/hZX5SLTQGrN8LrNf6w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783910940; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vm1pnD8kTrHNSm9lrXhziwQblk/5LjEldSxL/Sn8Jfg=; 
	b=gqoOscg0WrDkCJ3TdjVBUoXvz31c3hPMW8iTvlgTbv20lnUPootRLKCTO2yHrnWBLqDzOHrAStvxaO67hz/Y8lciuj0tqP6EsiK1cALsfZWlKvXdZb7V7YHdebUXeuxnjR3gxTub0mFXN0Qk20+WlcoK4Eyz/WkiwLOyawq1QLE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783910940;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=vm1pnD8kTrHNSm9lrXhziwQblk/5LjEldSxL/Sn8Jfg=;
	b=XucdKBMzUREqMoEU9WoHxvCQWN0udxV/verrK4C7L1kQz7Ikf1Dc0A/4Ebkm8xI5
	BzO6N486lC14+t7r17U2ZWEKtNGxg04m8/9h9tRYnvCZo/UGBCpbAxINkl3a6y/6Ie8
	Au3hC7T2M+hIz9Nph+8MEPbdie5UyS93xwmeslpI=
Received: by mx.zohomail.com with SMTPS id 1783910937810704.8150433230427;
	Sun, 12 Jul 2026 19:48:57 -0700 (PDT)
Message-ID: <862754de-1e19-43ae-b212-f7a8c9ede739@zohomail.com>
Date: Mon, 13 Jul 2026 10:48:52 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Fix use-after-free in find_pos_and_ways()
 error path
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Dan Williams <djbw@kernel.org>
References: <20260711180755.1779002-1-alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260711180755.1779002-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: zu08011227c99e6ccdee7290eee3bd647200009b9398815180cbd311178650029d245399ccfab74eacc1b084:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

On 7/12/2026 2:07 AM, Alison Schofield wrote:
> The error path releases its reference to a switch decoder before
> logging an error that includes the decoder name. If the released
> reference is the last one, the decoder can be freed before the error
> message accesses its name.
>
> Drop the reference after the error is reported.
>
> Found via inspection.
>
> Fixes: d90acdf49e18 ("cxl/region: Add a dev_err() on missing target list entries")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1e211542b6b6..c86dd9d55e93 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1938,8 +1938,6 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>  			break;
>  		}
>  	}
> -	put_device(dev);
> -
>  	if (rc)
>  		dev_err(port->uport_dev,
>  			"failed to find %s:%s in target list of %s\n",
> @@ -1947,6 +1945,8 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>  			dev_name(port->parent_dport->dport_dev),
>  			dev_name(&cxlsd->cxld.dev));
>  
> +	put_device(dev);
> +

Is it better to use a __free(put_device) instead of this open-coded?

Ming

>  	return rc;
>  }
>  
>
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482


