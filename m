Received: from sender6-pp-o94.zoho.com (sender6-pp-o94.zoho.com [165.173.180.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B3846982A
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 06:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791872980; cv=pass; b=ijdnm4RAbJz8jaZT71fUjpHDNKvWABFEKlWt/aAy6SVj6Z1eRlf9svti/5EhTUpR8Z6/jG8F5huna7P9ItxHTNnRztBKiQ9XbNiIQh8kwXkjOUX01AftMvA8UeHKqIFR1ntDz4YqJsOY8FgElJlv/74BOjUzFqgPBmTZf8lZfNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791872980; c=relaxed/simple;
	bh=lssAw4UK5A7p7Bbq0nr9Wo3LAl6TpZLngyc2SNFmG4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vjw9ZX9ehl48xbV/szoT8fQvC0qWtAypOBxROJp3kYPKzuNPPNiQjXq1Ci/GJHkifzhTjeurQotE+B0dPqk3jM09dq/ZnO6SOM8niC6cow59PauJLHXrDde1ecNkcehbAlepuamAYYuwQCmH0BYLS8JMVLhQbRw4Mg777612iTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=ftDpsHmB; arc=pass smtp.client-ip=165.173.180.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="ftDpsHmB"
ARC-Seal: i=1; a=rsa-sha256; t=1791872970; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lfq1ESRBrq1DMUYGBBIzzZ1PdeCYzfFF5OmSQDKyGFwVDnobqTWy/Xwj94xx/00WEZt0+3aRKUd8nj0Viqsk6MDWWaC5D8+1SN2fbtvHI4+0Ol/qxGTYIYnkNQ2RUPqjtfnB4ZKPyV00tAYgQMwqjl3BIzP+fW3OlBPFVwdx/SE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791872970; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sLb2r3GDCYyoarmi9W2/hs30nPaBWKjUxdn9/xX2leM=; 
	b=aRo04GTHHs2HUdFI3lRqdKK62PqI7S29R8v1xiYiPqzp9e7sG3lFat8IJ/G4DW6NkKRdIw8wBtABnNjIo8fs+BIrGxmC6xJxWwwuG5WPkpse01Z5H7Pa7Ts+9BKy1U2ld0a368o0tthFCAK5Kv020r5rsTsmc9wJsJx0sxkOrGw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791872970;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=sLb2r3GDCYyoarmi9W2/hs30nPaBWKjUxdn9/xX2leM=;
	b=ftDpsHmBYPHFJ4IBADxufFHroW9Rd32YYvoNYeFojMucgHaZca8No36zze+zydDv
	lmL0ZucPqldH/y+bss/7r1Ita+xvuRa9/Z2XYbHnI9GFM+UnPApTjm9+g1pMg6g87n4
	Rieyn34OavSnL3mm7gloxtWolyJB8SGcvF/31YCM=
Received: by smtp.zohomail.com with SMTPS id 1791872968960619.2084948754547;
	Mon, 12 Oct 2026 23:29:28 -0700 (PDT)
Message-ID: <53fbb184-524d-499b-9513-6c0f07b4a9b3@zohomail.com>
Date: Tue, 13 Oct 2026 14:29:24 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] cxl/region: Rename cxl_port_setup_targets() to
 cxl_switch_port_setup_targets()
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
References: <cover.1791860305.git.alison.schofield@intel.com>
 <3342ed1a893f001bb96efb3aecaccbe311697e87.1791860305.git.alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <3342ed1a893f001bb96efb3aecaccbe311697e87.1791860305.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112273c1ed0b780c1cd844b3ce3360000345015ecd8cad391595e285968a56cdce246fad9848bcfb4fa:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/10/13 12:25, Alison Schofield 写道:
> cxl_port_setup_targets() configures the switch decoder targets for a
> region. It runs for each switch port, including host bridges, between the
> root and an endpoint.
>
> Rename the function to cxl_switch_port_setup_targets() to make its scope
> explicit.
>
> No functional change.
>
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>

> ---
>   drivers/cxl/core/region.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index bc087ca63946..9b0e2f195d1f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1432,9 +1432,9 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
>   	return 0;
>   }
>   
> -static int cxl_port_setup_targets(struct cxl_port *port,
> -				  struct cxl_region *cxlr,
> -				  struct cxl_endpoint_decoder *cxled)
> +static int cxl_switch_port_setup_targets(struct cxl_port *port,
> +					 struct cxl_region *cxlr,
> +					 struct cxl_endpoint_decoder *cxled)
>   {
>   	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>   	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
> @@ -1716,7 +1716,7 @@ static int cxl_region_setup_targets(struct cxl_region *cxlr)
>   		 */
>   		for (ep = cxl_ep_load(iter, cxlmd); iter;
>   		     iter = ep->next, ep = cxl_ep_load(iter, cxlmd)) {
> -			rc = cxl_port_setup_targets(iter, cxlr, cxled);
> +			rc = cxl_switch_port_setup_targets(iter, cxlr, cxled);
>   			if (rc) {
>   				cxl_region_teardown_targets(cxlr);
>   				return rc;
