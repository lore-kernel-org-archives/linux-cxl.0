Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793944281;
	b=BkhJ4i7QB+XT+fH5EaGP9E1cA5c5GTbWB7hWfd0XsJGneKWw1IR5dW+BU4f12ptevKGA
	 jVNEbB+uap3ZI+I68v7A0V7iQ7YsgsLrSS1Gpgv885wN1J3FUxMO6e2XKvWgjbS+QC7jw
	 omX5YqwggNeqzpklK17nuLuxuHBlI+hjY3rbVf4KsaT0uh+fJx7Tfyh+eG/iwhi/2MMiI
	 3vyl8uEAWez6wDNIH04xdaMawzKkockvLCwJfXFgmJWKhrlEzNU/mpsqmHAF2J7mgYZjN
	 D8nQZ/RDIuLg/jfpKoDRRcz+SJyHIKhc631LuIiuUOfMUbFC9xSHsqe5qQSq7jNJgFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944281;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=ISi1JFk0rUr/qH5yiUNDWFl9Yj1qbBPyLSyaOnYK0GM=;
	b=I3P+GeW2SHbDRqx+dRaNiPSx2Yi++XKzjcvTQcifZgMphjIPspYjmBS52LWPg0vC1sqM
	 B0aS8ojxJWhIXHHr6+OxhRv7zUoDQUarq+7ZjE2D5oWC+GlO3HMflBZqBl1auQuiqq744
	 Vbn8/T9xlWSaJWh0JLo6FyT+IKhNBD4kAU3bHm19ulOLCes5jb4ghMOywg1C1nybxvIDv
	 TqdTNvMnWhy0rTmIgEGU93NUZcsfnTHMz/XxH7aWgmXrLxB8GjtDgHspfXuCKsovrrGeB
	 3ZS6MPZYHENjqhns95mAmIcu54zhtTHEUOyZebMK9jpZOIr6IoRPlYtNeup9X/YTVyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=PFZvHna6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE646606A332
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 05:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE646606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=PFZvHna6
ARC-Seal: i=1; a=rsa-sha256; t=1793944274; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CeqTSRKl18hbJ9j+eKMc2H1vl8n6VUZar8RIzi5w+bJvQfWsy9Ge7xbSs4pRMd5j06IDbTKEwmWoKsnskV61BRU3R30Eub6nKKZHlggqgo/h64OT8wLBzHr1cHtlvNucZzumkNEUGvP7PdJjmcKAtxKZE9/x6G5BeTuzL9kDFnM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793944274; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ISi1JFk0rUr/qH5yiUNDWFl9Yj1qbBPyLSyaOnYK0GM=; 
	b=KLIdRKZu+0lxERv9RvVG9k7ooLd1lay+ZaoZkbnKcPAHvmqQlgEEeFhwDvG8LxQX9iT4jh+GFSyzBn4WyIfF0B8czmuPWQiXsl26kNp0GOCSnKRJnt14QVkPiW6ivf910AYfnFSVQ+pwOAF+HUmnQDycCmeiR1RJkKFVedHnrBc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=PFZvHna6uZ7FEvrwRDQCDN3mKLogOUsr+uJFnq4gyziW60a05zAljVXjOttvQaHCjFivV1MJ882WzboHj1I9iT2NBy+1YjCw5w7bUtFuFq974tv2EvGVuGE4NTM9gqzjq0xnGH4vXCOplcIyisJcTgIOGRoeYxNdCrbQo1zrDFg=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=ISi1JFk0rUr/qH5yiUNDWFl9Yj1qbBPyLSyaOnYK0GM=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793944274243370.1345627042299;
	Thu, 5 Nov 2026 21:51:14 -0800 (PST)
Message-ID: <e008f701-757c-4337-a96b-3a3282d4d86b@zohomail.com>
Date: Fri, 6 Nov 2026 13:51:10 +0800
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
Subject: Re: [PATCH 1/4] cxl/region: Calculate performance data once all
 targets are attached
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1793847269.git.alison.schofield@intel.com>
 <2d2cd95e7e415c785dbd0cd627141a5a9f0731d6.1793847269.git.alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <2d2cd95e7e415c785dbd0cd627141a5a9f0731d6.1793847269.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112276ce3c41672d10fba5cbbb0df0000bb61702c5fd85c51dbfd061ef1d2c867e964ed44ef50525aaa:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/11/5 11:28, Alison Schofield 写道:
> Region performance data is accumulated as endpoint decoders attempt to
> join a region. Failed attachments and subsequently removed targets can
> leave stale contributions in the region's performance coordinates.
>
> Latency reflects the worst of all attempted targets, potentially
> misreporting the region's access coordinates and affecting NUMA memory
> tier placement. Bandwidth is normally recalculated when the region
> completes, but if that calculation cannot be performed, the accumulated
> bandwidth remains. Rebuilding a region can inflate it further.
>
> Calculate performance data from the attached targets when the region
> completes, for both user-created and autodiscovered regions. Reset the
> coordinates before each calculation so only current members contribute.
> Perform this calculation before the shared-upstream bandwidth update,
> preserving the sum of member bandwidths if that update cannot complete.
>
> Fixes: 3d9f4a197230 ("cxl/region: Calculate performance data for a region")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>

> ---
>   drivers/cxl/core/cdat.c   | 19 +++++++++++++++++--
>   drivers/cxl/core/region.c |  4 ++--
>   drivers/cxl/cxl.h         |  3 +--
>   3 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index f5f86b69c86d..7acc516ae9fa 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -1124,8 +1124,8 @@ void cxl_region_shared_upstream_bandwidth_update(struct cxl_region *cxlr)
>   	cxl_region_update_bandwidth(cxlr, usp_xa);
>   }
>   
> -void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
> -				    struct cxl_endpoint_decoder *cxled)
> +static void cxl_region_perf_data_add(struct cxl_region *cxlr,
> +				     struct cxl_endpoint_decoder *cxled)
>   {
>   	struct cxl_dpa_perf *perf;
>   
> @@ -1147,3 +1147,18 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>   		cxlr->coord[i].write_bandwidth += perf->coord[i].write_bandwidth;
>   	}
>   }
> +
> +/**
> + * cxl_region_perf_data_update - Recalculate region performance data
> + * @cxlr: region with all targets attached
> + *
> + * Reset the access coordinates and calculate them from the current targets.
> + */
> +void cxl_region_perf_data_update(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +
> +	memset(cxlr->coord, 0, sizeof(cxlr->coord));
> +	for (int i = 0; i < p->nr_targets; i++)
> +		cxl_region_perf_data_add(cxlr, p->targets[i]);
> +}
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a048bd5c06cb..34d42559e33e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2130,8 +2130,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>   		return -EINVAL;
>   	}
>   
> -	cxl_region_perf_data_calculate(cxlr, cxled);
> -
>   	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>   		int i;
>   
> @@ -2171,6 +2169,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>   		 * then the region is already committed.
>   		 */
>   		p->state = CXL_CONFIG_COMMIT;
> +		cxl_region_perf_data_update(cxlr);
>   		cxl_region_shared_upstream_bandwidth_update(cxlr);
>   
>   		return 0;
> @@ -2193,6 +2192,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>   		if (rc)
>   			return rc;
>   		p->state = CXL_CONFIG_ACTIVE;
> +		cxl_region_perf_data_update(cxlr);
>   		cxl_region_shared_upstream_bandwidth_update(cxlr);
>   	}
>   
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index baa6df2d362a..2cd1842ce1ad 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -932,8 +932,7 @@ void cxl_switch_parse_cdat(struct cxl_dport *dport);
>   
>   int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>   				      struct access_coordinate *coord);
> -void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
> -				    struct cxl_endpoint_decoder *cxled);
> +void cxl_region_perf_data_update(struct cxl_region *cxlr);
>   void cxl_region_shared_upstream_bandwidth_update(struct cxl_region *cxlr);
>   
>   void cxl_memdev_update_perf(struct cxl_memdev *cxlmd);
