Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794316066;
	b=YsbcwDCLt4ncICFVsREFulA50T27YW8NDRgJHC4uSXkj9P12NquJAgfVRmK02dPiHww+
	 T768rX2MJctX9iKfNrBY/+h7EDpSI70QaZC6M4IgZXxYHxZpHyMmIpc9+EM8CuC1wNpTH
	 z/xaFwAnbJp3Jw64kSHz7/jrThn9eWzzcutzi1iu5BW3EDy9dbqom0YVkVFBkZkIGy7Tv
	 uaGJvDrZjS6tfPZeNAFv4ZBGekTL3+6oUouRVxBht2GG5O61qliTyvblH19CGSv/NcTGA
	 6eKcBR9D3jFR9hBPml7VY0JqcDDpDACX/YWbqRXYgOojKocxnPUG5vq//X6r3hlYsHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316066;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=Co4mU0ZneS0MyWgbVHsazkz327H1QmoZdkFsSWSdDAQ=;
	b=Iq88NYCz5tx1ZliJT3nYY5MNZIPV+pCnQcq5YRQBNS5Y+WIMVf2B9XtAt2QMAt3ObgVP
	 QYbkCr1jIzvHROXNuzroPAQgIMecnZcZYwdqap8IpS4REWI6crg4O9L4Ek0jG4nPWaxVw
	 MdcmOqzjMPq9lOuPLDjY7frSbZ+QwJLh7u45igf1z6khbC711UeMOjMOQKt9JvumWJNnA
	 y5Gcadw/sDBgkvItlSccYxXd9w31G5l0DXqk54znls9IGne3fg795FCg6brpG+oMTj+8P
	 TEAmfi6KqEOTpYBlq1KhFW/JT1s1qV4Cz/tSyXLUR90dsWeHvdrwDodhvIyPDmpuq8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=XbZffEbQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53673606A33E
	for <linux-cxl@vger.kernel.org>; Tue, 10 Nov 2026 13:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53673606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=XbZffEbQ
ARC-Seal: i=1; a=rsa-sha256; t=1794316045; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Y+z8TaVYRQ0Cca3agAl5xHOJnlCtCzeAg930WwZWZJaHUsfW+k+VULfSN81vBiBAnmX7PA74jXePxH0ny+h3ZSnYPlBplnnPEaDO6tnRi5svzG9CJHLoZvZvntkkGFbbNBAS8zZeGzVk0x/Reeo96+g3xPJz02FBRKon/UL9GYI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794316045; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Co4mU0ZneS0MyWgbVHsazkz327H1QmoZdkFsSWSdDAQ=; 
	b=YDY9skZx9SiBJdjBTo7lubIN270sezg/OFkGR0cKpH5uPm9Kdmw4ZseaU+YlB4Vhgz6tDg5ntrUG5eP7Ce9l9RtG9QXw4L2i9LFZ/5wqe4qmgavAAngTw6iZvjOkDv8AmExtM/ZgkjaYX0OJUUVov/GseF8xZh9zXTfmb2KKQmo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=XbZffEbQmXS/OQ283lBVOv2gyygqD0tnCGgfQUXYznyGtdklohFqsL6+JhoMoiXjgKE/SLMi7rDM1ktFLuNOOCUa2iC5KQRCoGGnuZfoj5i3gyB6BL4l9m4WL/0tpGQ+z2k15jnD6NcgOXemdr1zPZI6w7QCMX6qVkk62G1h10Q=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=Co4mU0ZneS0MyWgbVHsazkz327H1QmoZdkFsSWSdDAQ=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794316044256747.1582040586484;
	Tue, 10 Nov 2026 05:07:24 -0800 (PST)
Message-ID: <55fc9f60-9e99-43b9-9174-0b9d555a2abf@zohomail.com>
Date: Tue, 10 Nov 2026 21:07:18 +0800
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] cxl/region: Consolidate region performance completion
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1793847269.git.alison.schofield@intel.com>
 <b8d1edde2129a7338ad6e9863a08ae2309a3d93b.1793847269.git.alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <b8d1edde2129a7338ad6e9863a08ae2309a3d93b.1793847269.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu0801122749d4df76051e66e6418e5c750000c559afbde7ab9c38c5260f1111bb91e626ce88e07aeada1ab2:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/11/5 11:28, Alison Schofield 写道:
> Both user-created and autodiscovered regions perform the same three
> operations when all targets are attached: calculate performance data,
> account for shared upstream bandwidth, and update the visibility of the
> region access attributes.
>
> Consolidate these operations in cxl_region_perf_data_complete() to keep
> the completion paths consistent and preserve their ordering.
>
> No functional change.
>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>

> ---
>   drivers/cxl/core/region.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 50cd483d710d..f9435e65c695 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -157,6 +157,13 @@ static void cxl_region_update_access_groups(struct cxl_region *cxlr)
>   		dev_dbg(&cxlr->dev, "Failed to update access1 group\n");
>   }
>   
> +static void cxl_region_perf_data_complete(struct cxl_region *cxlr)
> +{
> +	cxl_region_perf_data_update(cxlr);
> +	cxl_region_shared_upstream_bandwidth_update(cxlr);
> +	cxl_region_update_access_groups(cxlr);
> +}
> +
>   static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
>   			 char *buf)
>   {
> @@ -2182,9 +2189,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>   		 * then the region is already committed.
>   		 */
>   		p->state = CXL_CONFIG_COMMIT;
> -		cxl_region_perf_data_update(cxlr);
> -		cxl_region_shared_upstream_bandwidth_update(cxlr);
> -		cxl_region_update_access_groups(cxlr);
> +		cxl_region_perf_data_complete(cxlr);
>   
>   		return 0;
>   	}
> @@ -2206,9 +2211,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>   		if (rc)
>   			return rc;
>   		p->state = CXL_CONFIG_ACTIVE;
> -		cxl_region_perf_data_update(cxlr);
> -		cxl_region_shared_upstream_bandwidth_update(cxlr);
> -		cxl_region_update_access_groups(cxlr);
> +		cxl_region_perf_data_complete(cxlr);
>   	}
>   
>   	cxled->cxld.interleave_ways = p->interleave_ways;
