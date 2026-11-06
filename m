Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793945758;
	b=RTpfH7WkAhI0iOqN/gpArbvr3yJROCDyk6MpwLYva3rG2Wu+ivWusPiyr3Du17GsPiI7
	 Ul05v8fiYDA+OaG+epCwiTlwI105T5lCDUyZUjr2dwuL996gWAW5Xok1YXJ09d+gpPwwk
	 oJ91lCXdjemWCBnQOv9xMrGeosyLxj/c4CFz89xPUcij0gYU6Y1kDvEfBLUCH2jh375Lb
	 DboEotxYLQNBHl7pefxQ8S7US7Df0jmcc8I2Wvegb2NZ7WGB5EZtrHhfFRodJI6WJBs9p
	 ncTpN3QvEenI9unKzjxci8M9AFWzC7a7hLpwK5TIkJhaymeQubJ+9YHP+TaZ7Y9vmRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793945758;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=FOdm3se7oai8lf6KL3Ai8GyjpFGqs7MesWLwk2GzLNg=;
	b=bIxTdMVzMpyWyGR5HyANMmI1yj5y5F44ZD3unVflLE6/PYoMMY1vgeSqYH7kUpPOe1oZ
	 Z9s6epMEXLQ+aidWrHL9enUDP9Hc0oKOJ2fOcd9Hzg0DilXk34CBqWXY3baymV0+N7t5L
	 gWJ/gKa99dTyY5OtUzA5J8/seZ0yt/YZheDAAnnho8VF/GpnllNgJga8CZz0NyT6R5gim
	 DhU+i681sVrG01YgqRLpBp5MRio2bRBNlfYiNfKkssvNQcRC7+df1wDBgAHWR2Wqfqij+
	 ll/pCT8+LkNorLtNpG2E81sBtDqV2UaLyopQY7jGPxRVL2RBD54NuFwBEx/47C6LGzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=BPf+xLYQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
Received: from sender6-pp-o94.zoho.com (sender6-pp-o94.zoho.com [165.173.180.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5CF606D835
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 06:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A5CF606D835
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=BPf+xLYQ
ARC-Seal: i=1; a=rsa-sha256; t=1793945752; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UWA33dQPuTW/Ir07XVGMhvybWjtu+JBPXRP7Piy1hdJ6S1mpnkzhMmhqQtrHYzcj1qRAQxG+4B4T/OSloMwzrnh3pnl2Wmr3GCsPMClEZFxWGuKpw47pJc/xk5zp1h5AHhCGr+q8UA/Ix64/JN4e7JYijS5j5TuBycb8YvANyqM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793945752; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FOdm3se7oai8lf6KL3Ai8GyjpFGqs7MesWLwk2GzLNg=; 
	b=YXAuALm3MP+HHW2L+lB/vuNLFCu8s/bcFm9CLUkE/PGMfQw3bQMCFZaZ1ldq1MFJ55uipN6C9jkS87Y1hH8w2F7/jI/mLXagM8LpScjelvH4cM3tfcbUM4RXTC//pR9LNkKnvrDDup//k7kDBLVKmrgnvQgF7BowXyBFWzTalis=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=BPf+xLYQvV9tRbdavAVGmqoNPBdsQqLTIiMcxFRkB8U3qlXjjsI9Ope5qsmRa1DjhooLGuXnwY8QRu65I/oMcYtonOia46DtRJLeFcEFcg1a4RpAwFUH7N5JTlpr5dPYFZLC75MTAZwNWNM5Zjnwha2amJSclrVZDCJbA95rVs4=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=FOdm3se7oai8lf6KL3Ai8GyjpFGqs7MesWLwk2GzLNg=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793945751029630.2107441501879;
	Thu, 5 Nov 2026 22:15:51 -0800 (PST)
Message-ID: <51d3903c-c822-4bdb-9615-5f8d8b0ae3b3@zohomail.com>
Date: Fri, 6 Nov 2026 14:15:47 +0800
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
Feedback-ID: zu08011227cb8563ae1649f7e52dc3e6570000832cba4ca6d8ea1c2c22f11a3b3f2b68f0c9f91c2180ac95b9:ZohoMail
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
Is it possible to call cxl_region_perf_data_complete() inside 
cxl_region_setup_targets()? So that we don't need to call it separately 
for user-created and autodiscovered regions.
>   	cxled->cxld.interleave_ways = p->interleave_ways;
