Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648F4409105
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 06:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615331; cv=pass; b=ZIenA1btJk6j+auutLCvTzejtbZC85tdB8k7kl1QFgeIZfdFAraZ46wHIipyP/30b8/4dTDQ59Le1x7ZWwwCCxglJfMHekhEyJsHdh1IHIX4zauxHwCBz9h8Fgl+sdMcZV4sFKuZpL4cnKiDZp80mxfq8IqgOg05w8RcLiIby9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615331; c=relaxed/simple;
	bh=exztTe768hHFL/OwdTHeLPYMFmvraSjjIsL3/kd74ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eIx4562Rfc5j3QNlFJhXOZSDkytLoasTNfYdSb/XTfsXqdzhyQ+s7aD1qldQqWhd+PZNtZuhbGnvGyyuOqo0FajCw+EbUzHDb5WeinhTTnYsXEqAJcj17vyNr7JFpBOyiQnUBCsI4Mnyhh+xWhjEykwzx5OYYPjS4k7OYtvNcfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=T3+m/dcU; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="T3+m/dcU"
ARC-Seal: i=1; a=rsa-sha256; t=1784615320; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SrAc2lz11QUAlXDiQ6HxK7cSXTbSeX+u0SqNyLgE4NuBQiPc1J9hNV3tRdWHssciasmASUC9ojgyijxXnqGpN0OU9Ru4l3g7yzb9jc4gb/RuF1ZGrrYQXuoDG7jWVGj6uTa8U5FpN21hfnIyKKWibA+F6chxP3NyiP5UUG99HiY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784615320; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2YTWS7KaUXs/fO+Jyt91TSlrwVWd7Xqi2AGBdBPCUgk=; 
	b=nI+35RBgMlx5IhjmOlG+THa5K4qJcCUO1Zh3kxV+o00ZldBq9oC9ul2oJYa6L2q89O4Vu0HqDcH/pLkIBX6YVdkwdPd55km5qtBvGw7NhdHEVfrhukSU7RaEvm3dglyy89dHY7+5JMsg8EqNiHmJ2A5RBppTxboJP/cuRHGvi54=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784615320;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=2YTWS7KaUXs/fO+Jyt91TSlrwVWd7Xqi2AGBdBPCUgk=;
	b=T3+m/dcU0qqa4FsLtginyqCNW+byYpUgEBe/UaHFlYp4Oo8+Rxe4BikjGzNZv1LZ
	mjxnn3EMNkm5NRjClC+kKJd41fwQloFjJvJWLMcnlgcjlIgB36dIqsJBUunRnnBTJhl
	Zp/vJBBMQ6eQWspyO+/SQqAnIsd3IClBhIytF9MU=
Received: by mx.zohomail.com with SMTPS id 1784615317218888.1353631301831;
	Mon, 20 Jul 2026 23:28:37 -0700 (PDT)
Message-ID: <cb22a0ee-2fcd-4066-887a-71462b0fb4f1@zohomail.com>
Date: Tue, 21 Jul 2026 14:28:27 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] cxl/hdm: Restore commit_end when decoder
 enumeration fails
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, Srirangan Madhavan <smadhavan@nvidia.com>,
 Ira Weiny <iweiny@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>
References: <cover.1784595445.git.alison.schofield@intel.com>
 <3b2d66e380cb00b1365911a59f32739580d82563.1784595445.git.alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <3b2d66e380cb00b1365911a59f32739580d82563.1784595445.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227611b296d3e82895915ddb97800004956d6892f43b43a14a67ef33b1428da6b5963f9d54f553dd0:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/7/21 09:59, Alison Schofield 写道:
> commit_end tracks the highest committed decoder on a port. It gets
> advanced before decoder enumeration is complete, so a later failure
> leaves it pointing at a decoder that was never added. The next probe
> then rejects decoder0 as out of order and enumeration fails.
>
> Reset commit_end to the none committed baseline once the decoders are
> torn down, so a subsequent probe rebuilds it from scratch. Register
> the reset before the decoders are added so that on unwind it runs
> after every decoder has been unregistered. This prevents commit_end
> from dropping below the highest committed decoder still registered and
> exposing an inconsistent value to a concurrent reader.
>
> Protect the commit_end advance in the DVSEC emulation path against
> concurrent readers, matching the register-programmed path.
>
> Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> Fixes: b777e9bec960 ("cxl/hdm: Emulate HDM decoder from DVSEC range registers")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
> ---
>   drivers/cxl/core/hdm.c | 23 ++++++++++++++++++++---
>   1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 077aface1a2a..7d4ba7fa30fa 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -955,7 +955,8 @@ static int cxl_setup_hdm_decoder_from_dvsec(
>   	 * change the range registers at run time.
>   	 */
>   	cxld->flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
> -	port->commit_end = cxld->id;
> +	scoped_guard(rwsem_write, &cxl_rwsem.region)
> +		port->commit_end = cxld->id;
>   
>   	rc = devm_cxl_dpa_reserve(cxled, *dpa_base, len, 0);
>   	if (rc) {
> @@ -1181,6 +1182,14 @@ static void cxl_settle_decoders(struct cxl_hdm *cxlhdm)
>   		msleep(20);
>   }
>   
> +static void cxl_reset_commit_end(void *data)
> +{
> +	struct cxl_port *port = data;
> +
> +	guard(rwsem_write)(&cxl_rwsem.region);
> +	port->commit_end = -1;
> +}
> +
>   /**
>    * devm_cxl_enumerate_decoders - add decoder objects per HDM register set
>    * @cxlhdm: Structure to populate with HDM capabilities
> @@ -1191,13 +1200,21 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>   {
>   	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>   	struct cxl_port *port = cxlhdm->port;
> -	int i;
>   	u64 dpa_base = 0;
> +	int i, rc;
>   
>   	cxl_settle_decoders(cxlhdm);
>   
> +	/*
> +	 * Reset commit_end after all decoders have been torn down so a
> +	 * subsequent probe rebuilds it from scratch.
> +	 */
> +	rc = devm_add_action(&port->dev, cxl_reset_commit_end, port);
> +	if (rc)
> +		return rc;
> +
>   	for (i = 0; i < cxlhdm->decoder_count; i++) {
> -		int rc, target_count = cxlhdm->target_count;
> +		int target_count = cxlhdm->target_count;
>   		struct cxl_decoder *cxld;
>   
>   		if (is_cxl_endpoint(port)) {
