Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793945483;
	b=x2El+QEmL9I/jOHWdrask8q6KqSILNkVMdxN8kk8r4O5CeI2aaFzkSjoRM4O8xsqe5nm
	 HvmWeUpvcLcaAhvFTEG2Q0dAGcqKU6GX9pV+McUwzRiRxkdGfo9PXc85UQKpAg4fhWP/k
	 c/jo+jJUCGQsE6c2ZO4BBb2/1C6oiHSoD2w8d0SwK2jvZ61HrBPsDBnsSLJ3oRhTxX3oC
	 uYbO7MOJ6cfFNOi8fgXc3v2TnnuPWxAt+4KUdEovsjXDVFF4JvIAuLKBiEIWbM4ZGOmA1
	 7iPZqkXNDdVHLR9FcvbDPEDJK5aRwI983r3uqmmWU1R4zl7vNHQm0VTp4YtFAHepB4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793945483;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=p93KlAbb8+9aaTRa2e6XPglDextBPEuIe0qrzUAdZkY=;
	b=bHeRn+10KGM2dUvP5JgUkKQUTMkAympRgyJrLNUfurJUKwY0VHXavs+IIa1Pj38i+IPo
	 ATHhsQ5jzF0SFOUSzhPD3UoSmIJ+ksPag2oBjcDh5TxWZSoirCSIbF1pab8vrg2/EogWo
	 Fp1FhfKsbUzk4Kh9/Bw7ueSDQXQf22JUbZ6C0Zc8FTit8FBUXSc4vrjYxdbggPnw/LcGO
	 02nt/lGutP4n04VCm0jj3LnRKkKLHrrBpp3p6YsN6yF+QDDCLibZs48OPd34WlQfK5vKm
	 /u/XKS2y1B5lIiH4GIxkb2cm9nROPWiOuFOGxNoU0m9/CU2DUMH85MWehy2k6Oq9kDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=W46QuDBK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16414606A330
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 06:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16414606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=W46QuDBK
ARC-Seal: i=1; a=rsa-sha256; t=1793945475; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hoNLCHTzr7V/lOpCONe2uZDY6FdS6N8BcvfEtXPBEFLwwFsZDrJWC9n5HtrJD6h/juyCzxgntB/TtxOhI/ln7q3DxuJRWEttrzqw5O3lsNOz9Xw+rnzkZhRDE9tFkX+i6gj6w8YS5NGKbREabUPdZI5O/YlCoihO7SP7lhTUB3M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793945475; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=p93KlAbb8+9aaTRa2e6XPglDextBPEuIe0qrzUAdZkY=; 
	b=Jh7qFDoA3290ITNYPje+CSdsElGIqY7AXKEjRgfW2eaQJ8Xc2n2kdrSX7EFnq9wN7LqVf5MPWkqZkcsFVkf+ECODH+TsPC0/iqOhiq/bBVYibzuMBTH0zu4cDhc6SlrfgjxHc8G9yi2kuWMfcsRQJERvCz4QC27eTb974tVT0dg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=W46QuDBKQXkM3443uxXqL2C2K80hI0S8qyZ22YNOwOVpjxQSQPf0UxuAzk/WkiRMiQXwhzu3vMImWB3fVPO4p5i1EG1/F9UX26ErHPxpI66c7N3GFqokfgCgX1AFTPQMgnTYbnkOaUdWPBbLE3EmlIZ9MLBMvTboubd0E7DqG+w=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=p93KlAbb8+9aaTRa2e6XPglDextBPEuIe0qrzUAdZkY=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793945473363690.5088060186878;
	Thu, 5 Nov 2026 22:11:13 -0800 (PST)
Message-ID: <e18a6dba-159b-433b-b9cc-4e71844e995b@zohomail.com>
Date: Fri, 6 Nov 2026 14:11:06 +0800
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
Subject: Re: [PATCH 2/4] cxl/region: Show access attributes once performance
 data is calculated
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1793847269.git.alison.schofield@intel.com>
 <eb2b648a7b0446f65d6ac2db6eb4f247ee72cea6.1793847269.git.alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <eb2b648a7b0446f65d6ac2db6eb4f247ee72cea6.1793847269.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112270d420ff099ccf3a1f1cb95a800009a54302b1f759a8778ecd0902835c5f76443b4a15059121aaf:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/11/5 11:28, Alison Schofield 写道:
> Region access attributes expose calculated latency and bandwidth to
> userspace, allowing the performance of individual CXL regions to be
> inspected independently of their use as system RAM.
>
> Currently, attribute visibility is refreshed only when performance data is
> propagated to a NUMA node. Regions whose memory is not onlined as system
> RAM, such as pmem and devdax regions, can have valid performance data that
> userspace cannot inspect.
>
> Refresh attribute visibility when the region completes and its performance
> data has been calculated. The existing visibility checks continue to hide
> attributes without valid values, and NUMA node performance updates remain
> unchanged.
>
> Fixes: c20eaf44113e ("cxl/region: Add sysfs attribute for locality attributes of CXL regions")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>

> ---
>   drivers/cxl/core/region.c | 29 ++++++++++++++++-------------
>   1 file changed, 16 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 34d42559e33e..50cd483d710d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -144,6 +144,19 @@ static const struct attribute_group *get_cxl_region_access1_group(void)
>   	return &cxl_region_access1_coordinate_group;
>   }
>   
> +/*
> + * Region access attributes depend on calculated performance data, not
> + * NUMA node onlining. Re-evaluate visibility after region completion.
> + */
> +static void cxl_region_update_access_groups(struct cxl_region *cxlr)
> +{
> +	if (sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_access0_group()))
> +		dev_dbg(&cxlr->dev, "Failed to update access0 group\n");
> +
> +	if (sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_access1_group()))
> +		dev_dbg(&cxlr->dev, "Failed to update access1 group\n");
> +}
> +
>   static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
>   			 char *buf)
>   {
> @@ -2171,6 +2184,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>   		p->state = CXL_CONFIG_COMMIT;
>   		cxl_region_perf_data_update(cxlr);
>   		cxl_region_shared_upstream_bandwidth_update(cxlr);
> +		cxl_region_update_access_groups(cxlr);
>   
>   		return 0;
>   	}
> @@ -2194,6 +2208,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>   		p->state = CXL_CONFIG_ACTIVE;
>   		cxl_region_perf_data_update(cxlr);
>   		cxl_region_shared_upstream_bandwidth_update(cxlr);
> +		cxl_region_update_access_groups(cxlr);
>   	}
>   
>   	cxled->cxld.interleave_ways = p->interleave_ways;
> @@ -2629,7 +2644,6 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
>   static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>   {
>   	int cset = 0;
> -	int rc;
>   
>   	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
>   		if (cxlr->coord[i].read_bandwidth) {
> @@ -2650,18 +2664,7 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>   		}
>   	}
>   
> -	if (!cset)
> -		return false;
> -
> -	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_access0_group());
> -	if (rc)
> -		dev_dbg(&cxlr->dev, "Failed to update access0 group\n");
> -
> -	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_access1_group());
> -	if (rc)
> -		dev_dbg(&cxlr->dev, "Failed to update access1 group\n");
> -
> -	return true;
> +	return cset > 0;
>   }
>   
>   static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
