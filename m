Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792463360;
	b=O9Ki1MzZyB/goNybOVKvmyVE09EyO9alWJ/KAORK2XCBW4hAmisLX1IXy6uRVqw2I81H
	 9AgrAn9eNxLVlp9Fx83BoT+IzH5WbBCBbV5FNaYaPD16UQ0Oe+K0WfR4jxd8BjBLVZYXW
	 h5ki7Nm3AbHUDE0Lr1RjzeEQXBkA85c+VfZAEK/qJjS7txZBjZk33n8LmpqYQtdQjxzE0
	 xh94P1jz8ULZrTCFmZD1xCoSv4Db8p1qkeM2A6ehlOuKteoRPc15BHC8AE9R3Paj1ZfLW
	 htdQX7Rl1uqPVyBsFjngqqgIXeb1nWJjpltM/ePw2E2aNClGBKkQVFL3hS8DJqrmHLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792463360;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=M43+0GqaEg8FdX4LkHIw7KQT/9DQrnnQEVrZl63JIOY=;
	b=0Ek1u5kdzgTMy8oxzsnHUzkUwzzVHOR+Qn6/5M/ka86nYmHXXg+reWi3c3U7yCvNq7dD
	 R/INrTxNg9h15jkccZsYKgIMauncK0IU0twgZT9k9M098uepfdjmVWW7f7NycffRPeds4
	 SggzEvNEwUIMLTZvBsiigj67gHrRoec0lHoOiBBBYvG9JQlTcAzNRyGWUgeW2kRhm4CDU
	 OYsoAKftU38XAJa6yRbV5YD6tCMEFnGzJvg8ZdoBqIaz518Ba9rraYFzKklFpPx2dMMjO
	 uWZgzhzZFXqqAcG8GwA8uiy3IU9V9kOhZyFsgfaFTQWsjKfEZVFyEsh459kchUtEAwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=ming.li@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=cyDMyb4Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D52606A31A
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 02:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67D52606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=ming.li@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=cyDMyb4Q
ARC-Seal: i=1; a=rsa-sha256; t=1792463352; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IQdzM/xI45lq9bizfbbzlqVzkZStmhFskvF5KiD/dkZRdkbHVL9eLSECJwvRZXgXlSiYq07A1i7TOjzO2RwXhvFsKLLpCYlh+PC83kPOsw4oiEevcIcB3Yi4swatZiRcN0SJupKmtiGokdribb3ECC76Epm3ICNyA3SKyIG9lpk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792463352; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=M43+0GqaEg8FdX4LkHIw7KQT/9DQrnnQEVrZl63JIOY=; 
	b=GoNyDtgcW39PpPQlcx5mqdrfrKLsMrYvf8IpUji5an3jin5e1GN3bRbE00AMx9MzxT5D+EhasQXkfeNztSfnZi00n1ekiablyUF3mQAi2YWYni0R5s+1FVx/zpseVs9c5sN5Edg5AOgQaW35dkh22O7gROKngpc7CyuOHn4Lz04=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792463352;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=M43+0GqaEg8FdX4LkHIw7KQT/9DQrnnQEVrZl63JIOY=;
	b=cyDMyb4QhouHi2Cn3yeHhQ8igyic2/3KvzRdj14RjPJC/dx8NxPlmSWwLZuQPYud
	aFEYO3uyQLhmdIxLPHJPpV7za29K2PUN3M8MbaqxguiX2OitLq56SV06/CsnQfPnjdp
	X2c2OEqA6Bpqmma3wsojj/jmuT3G9x1VG0gJlAJg=
Received: by smtp.zohomail.com with SMTPS id 1792463350962965.9304124170185;
	Mon, 19 Oct 2026 19:29:10 -0700 (PDT)
Message-ID: <896f59e7-6907-4662-b8c9-eed7a5e89d8b@zohomail.com>
Date: Tue, 20 Oct 2026 10:29:07 +0800
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
Subject: Re: [PATCH v4 4/9] cxl/region: Calculate peer distance only for
 reused targets
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1792263750.git.alison.schofield@intel.com>
 <6ac7f8fae75f7cd29b5d530a552aec2b6c6169b5.1792263750.git.alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <6ac7f8fae75f7cd29b5d530a552aec2b6c6169b5.1792263750.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227c8273e9654994aae3a5586e000005071244a5a29b8c7d8ffbba745a3a5358ae74e96021236b510:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/10/18 03:19, Alison Schofield 写道:
> From: Richard Cheng <icheng@nvidia.com>
>
> cxl_switch_port_setup_targets() calculates peer distance before
> searching the existing targets. When the endpoint needs a new target,
> the calculated distance is never used.
>
> Move cxl_port_peer_distance() into the matching-target branch,
> immediately before check_last_peer(). This avoids unnecessary ancestor
> walks and per-port region lookups when adding distinct targets.
>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> Tested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>

> ---
>   drivers/cxl/core/region.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 4ab5a1d025a9..8bfebe3e1025 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1485,10 +1485,10 @@ static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
>   	}
>   
>   	if (cxl_rr->nr_targets_set) {
> -		int distance = cxl_port_peer_distance(port, cxlr);
> -
>   		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
>   			if (ep->dport == cxlsd->target[i]) {
> +				int distance = cxl_port_peer_distance(port, cxlr);
> +
>   				rc = check_last_peer(cxled, ep, cxl_rr,
>   						     distance);
>   				if (rc)
