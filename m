Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA5644AB91
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 05:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784697928; cv=pass; b=DmiGhkzwk/9amqcmRE+bpsgDzjY2Tgljihw1csWZzJERaPgGmkCEtQWwJu1Ho8B9wFe0djjezcsuc4Si3dyna0NxzAAWkddhYAGFdQRtWLXboozA1iA5/P4dCM84MVa2JTOki8LAxZWX9uRynrzHlrZ5VUVgB0uGC0UED0dooLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784697928; c=relaxed/simple;
	bh=yyFM+dNYVDYVKOLtCeHoLzwZtZZo6wJ+1X1mZoMMTXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YgKsYjTwLQA3tODSTqVbSMqJboKpJ3DIQ2cy3RGyzchhg/8F6wUmKdN4pkL52nYTi8cuCk6jIVcIR8VVjsepLxZnY1CQeAvENGla7k3GYOKxgxa4Hjxf7zmvpTbzLslXAEwSXaS/Xfan7FVk/B8iYnJVCFugA/BJz6ib6D+P3/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=SyqqoI03; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="SyqqoI03"
ARC-Seal: i=1; a=rsa-sha256; t=1784697920; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gChG4qb1OzLY/MRSg3BAjwU7Z66rphCRpiptCVk9GRYqjiR0u3px/h4ZMQMe7BcwT0olw4QkhsFPgojhMdE0YtA8oPYyXmVYci5xziXLfGEHMVpOpUWKt08ZAKsuCk2V2yHuQrl42fTtQw4Bs7m+VqK7G/JBscvyU/E5ImV/WRE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784697920; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lGU8Rc639EeD/OdysvYGGEiKJvjP0+IGnl61IRcHJus=; 
	b=Kx0cDiIdEkAXeG8QtDXMZEmknmQ5xld4lKlkZlwxSw57WkDxNrnIPJLyxaXFmp9DJqVrIZxBpJSXXUqVhjwMNlasQdlRVzkLVgLB6DQMQ0nFgTUhGZr+u+FeofpoJ2QAROvhAyCwMnPwlvvVKfM4xJkoLDWEIsmWrrmr4mvI0U0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784697920;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=lGU8Rc639EeD/OdysvYGGEiKJvjP0+IGnl61IRcHJus=;
	b=SyqqoI03Pt3kQqhRUimig8SRe9XMSTWPQ6HJn+M3egV0U2NCALVXo09KiqpTD+aM
	CwE7PTq/8ZB+zYyD0o8Ev3iZCL1VTB3lcNhz/DGBTshrVxSsZNx6kJo1xwWszy09/eZ
	AyG87KLJffIgrU+YfkkepyU9RNkRvwNwEmu2tvZI=
Received: by mx.zohomail.com with SMTPS id 1784697918430554.5840672999656;
	Tue, 21 Jul 2026 22:25:18 -0700 (PDT)
Message-ID: <5dfeb383-37cd-43f6-ae15-b90b2b307e20@zohomail.com>
Date: Wed, 22 Jul 2026 13:25:14 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cxl/region: Use __free(put_device) in
 find_pos_and_ways()
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>
Cc: linux-cxl@vger.kernel.org
References: <3a36953b5c665cb9544ba61dafbea0b0fa508c77.1784654628.git.alison.schofield@intel.com>
 <03aceaa0001651c28f221988c9e845f59bf1d84d.1784654628.git.alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <03aceaa0001651c28f221988c9e845f59bf1d84d.1784654628.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112279ac83d08ed50760d894986370000a39761021d6480143acc440857d0047d80c37c34d6f3bdd10c:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/7/22 01:37, Alison Schofield 写道:
> Use __free(put_device) for the switch decoder reference returned by
> device_find_child() instead of releasing it with an open-coded
> put_device().
>
> This matches the scoped device reference handling used elsewhere in
> the file.
>
> Suggested-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Li Ming <ming.li@zohomail.com>


> ---
>
> This is a new patch added in series after the UAF fixup in patch 1/2.
>
>
>   drivers/cxl/core/region.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c86dd9d55e93..4d7d96d03ece 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1911,9 +1911,9 @@ static int match_switch_decoder_by_range(struct device *dev,
>   static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>   			     int *pos, int *ways)
>   {
> +	struct device *dev __free(put_device) = NULL;
>   	struct cxl_switch_decoder *cxlsd;
>   	struct cxl_port *parent;
> -	struct device *dev;
>   	int rc = -ENXIO;
>   
>   	parent = parent_port_of(port);
> @@ -1945,8 +1945,6 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>   			dev_name(port->parent_dport->dport_dev),
>   			dev_name(&cxlsd->cxld.dev));
>   
> -	put_device(dev);
> -
>   	return rc;
>   }
>   
