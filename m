Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793945802;
	b=uAdkEjFY/W6K69xRCnZdSkpR3F82M3/wkXDkMvfxy8gSe6Myb9k/ziUrDMMyV6BXPJLJ
	 +L6dMASr1AoJ/Hq5WShYczQtDctifR2TG06bQuJFhy1dFnvhT3GTCKC2uB2NV+jSaq0JA
	 YfDCa/1UPEnRJ0yGGSkyhC2C0pJoXErGJqMiNXMA/4B9BZQy9pcgj4ZDKNUi1OIBqzZgi
	 ZpD2JwZ2g7yXrGBRywG/mbpBQphQrt434Pn644tM4Za2eh/rEcEgSUGiCSBSLDN++mUg2
	 jbLppPNS0Vjyfzu55XOlkDyQBZTp0yXPji22H07/5IgXQ2lrsoRgjLkC3kinXycohhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793945802;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=/5Nx/ZHlNXzyrHkiZL+pnMOk40xE4WZgSK28xpmYkv0=;
	b=l7wk65h39GDu9B6T0WExS3oGcVhTOyCcs3MZd2FL1Rz8ifsFuVkH+riZRU1YyXySVSW+
	 wlvyCuQxTQhgDxaed8H8IQFmchSxi0tEVMLVSOUplxnygUL5zkXHJUaE9JZkGAjD3b/n0
	 /urs2vU/yioO4OCBUA51QfcPaM31bIjPEeYYZBRnrOnjirnP7Qq/7LjhRAdWxAWhWMZkD
	 8+E4fmKtZ+8sani27yVtpFgM0/WPqDyfoO9aNlUYOmghz8Kt0tPuJf802F3aB9US+gyvB
	 KRkvCKwdDughho99iBhtMLPYNd9h+enR7bP/mVCh2z6TmVln+mtR5vDCF6VX+Br29ig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=XLO5tAMr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0324C606A329
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 06:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0324C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=XLO5tAMr
ARC-Seal: i=1; a=rsa-sha256; t=1793945796; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZE037h3ywd0TKSmYpguEpiiDasJXu19EmJ5BuC4E5R5ueSHeCOONdp0lbullLKsxx8E4hyRoWUhX1MyMz9Vti2/AW7DOz5Eea2sDInwZl/ceicYiQHhuFQDqCGPraCsjusVqU5ilwFiZvDgA58ejhGwwMlhMGKVzxw2qD0GxJls=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793945796; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/5Nx/ZHlNXzyrHkiZL+pnMOk40xE4WZgSK28xpmYkv0=; 
	b=h8XEncTqRLgbrYaVuKSllS45crxCV66wFXGUNkHD45O5Hcaxoidc5UpcIm0vMzfisVB1hEF7FgjYyX9Dyrf/HVXLwuRbOh00N72YurkHsTDsxhEEDndW3V/3Hx9mnfdqTmUINRWpYPeCmtB3Xjqo2jSmMY4eX8qyxNfez9nqqBU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=XLO5tAMr/UCefhzWoVkljmDTuDR+WR6PxX7zX+3/brvaeasnLJX39EBK3THDip7tkTA1Z8Qt/17vqXMcC6w9BQaFcATO0Ch3gQIzJpdEC40lNG3wFq0mp4DDOni5OOrnFsd63L3yZbdFIIYFWLUsNzgzbfX44/RkuqEmnmrSPXM=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=/5Nx/ZHlNXzyrHkiZL+pnMOk40xE4WZgSK28xpmYkv0=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793945794888627.6648808017505;
	Thu, 5 Nov 2026 22:16:34 -0800 (PST)
Message-ID: <da5463f4-9bab-47e6-989a-603138f1d224@zohomail.com>
Date: Fri, 6 Nov 2026 14:16:30 +0800
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
Subject: Re: [PATCH 4/4] cxl/test: Give each mock memdev its own performance
 data
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1793847269.git.alison.schofield@intel.com>
 <a078fadc9d039a34645ab8778fbf17faa3c85f27.1793847269.git.alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <a078fadc9d039a34645ab8778fbf17faa3c85f27.1793847269.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227442f50dfda8f572095be7c84000077a1274f2ac9f2ae0625e99e035c77be8e760b806d146136a4:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/11/5 11:28, Alison Schofield 写道:
> Assign distinct and predictable latency and bandwidth values to mock
> memdevs so region performance calculations can be tested against the
> expected contributions of individual targets.
>
> Derive each memdev's performance data from its memdev id:
>    latency   = 100 + 10 * id     (nanoseconds)
>    bandwidth = 1000 + 100 * id   (MB/s)
>
> These values allow tests to detect stale or duplicate contributions from
> targets that are not members of the completed region. Since mock memdevs
> are not PCI devices, the shared-upstream bandwidth calculation is skipped.
> Region bandwidth in cxl_test will be the sum of the individual memdev
> bandwidths, providing a predictable result for testing.
>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>

> ---
>   tools/testing/cxl/test/cxl.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 3eb1051b1ee8..762c8b9ed4dd 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1629,18 +1629,29 @@ static struct cxl_dport *mock_cxl_add_dport_by_dev(struct cxl_port *port,
>   }
>   
>   /*
> - * Faking the cxl_dpa_perf for the memdev when appropriate.
> + * Derive mock performance data from the memdev id so tests can identify
> + * each memdev's contribution to region performance.
> + *
> + *   latency   = 100 + 10 * id     (nanoseconds)
> + *   bandwidth = 1000 + 100 * id   (MB/s)
> + *
> + * Keep the values nonzero so the region access attributes are visible.
> + * The ndctl cxl-perf-data.sh test relies on these formulas.
>    */
>   static void dpa_perf_setup(struct cxl_port *endpoint, struct range *range,
>   			   struct cxl_dpa_perf *dpa_perf)
>   {
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
> +	unsigned int bandwidth = 1000 + 100 * cxlmd->id;
> +	unsigned int latency = 100 + 10 * cxlmd->id;
> +
>   	dpa_perf->qos_class = FAKE_QTG_ID;
>   	dpa_perf->dpa_range = *range;
>   	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
> -		dpa_perf->coord[i].read_latency = 500;
> -		dpa_perf->coord[i].write_latency = 500;
> -		dpa_perf->coord[i].read_bandwidth = 1000;
> -		dpa_perf->coord[i].write_bandwidth = 1000;
> +		dpa_perf->coord[i].read_latency = latency;
> +		dpa_perf->coord[i].write_latency = latency;
> +		dpa_perf->coord[i].read_bandwidth = bandwidth;
> +		dpa_perf->coord[i].write_bandwidth = bandwidth;
>   	}
>   }
>   
