Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4065F54763;
	Fri,  9 Jan 2026 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767968082; cv=none; b=sjlJ6lUVOujqumexv+jzZrqey7liW3Lrxfa7nYJKH2rJcvdDMoLmSOLh3Wp4z4IUCkdjIL8OTpVmQY1/cynN3Myudb9AetSnHgUNIfFldK5MM3pQzwaghi00vt7Akk/yY3T/JC5xVnsqgwEXruiXeenKi72hXuJRxYR8TQayYZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767968082; c=relaxed/simple;
	bh=8e3koJimZyEDxJ5RiW+sQiOJPcEvtrvKpLfQo/AJHeg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dG8aNyYBS9bzJ8vT70SgztnuDuoYTmjFZnR2UaVkmgfEnpdd2Dkk2KXMb+UE79wBCfOPKexyCbvmuU4N6mXgR4Xi8BZ0IFipLuaGZSCcYHnHQoSzyacwhHqNGN7zbUu5FXyrsL6c42/h1ytnau53OdqVAN52SszY2R5MWhQX0zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dnkKx6VxwzJ46DY;
	Fri,  9 Jan 2026 22:14:29 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C5ED40570;
	Fri,  9 Jan 2026 22:14:36 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 9 Jan
 2026 14:14:35 +0000
Date: Fri, 9 Jan 2026 14:14:34 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Ben Widawsky <bwidawsk@kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] cxl/hdm: Fix newline character in dev_err() messages
Message-ID: <20260109141434.00000b88@huawei.com>
In-Reply-To: <20260109122952.639231-1-rrichter@amd.com>
References: <20260109122952.639231-1-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 9 Jan 2026 13:29:51 +0100
Robert Richter <rrichter@amd.com> wrote:

> The newline character is not placed at the end of the string. This
> causes unintended line wraps, broken log level and unterminated log
> messages. Fix that for all messages.
> 
> Note that the messages are changed to use colons now instead of
> parentheses, which is more common use.
> 
> Fixes: 24b18197184a ("cxl/hdm: Extend DVSEC range register emulation for region enumeration")
> Fixes: 9c57cde0dcbd ("cxl/hdm: Enumerate allocated DPA")
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/cxl/core/hdm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 031672e92b0b..28611b350cf6 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -966,7 +966,7 @@ static int cxl_setup_hdm_decoder_from_dvsec(
>  	rc = devm_cxl_dpa_reserve(cxled, *dpa_base, len, 0);
>  	if (rc) {
>  		dev_err(&port->dev,
> -			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx\n (%d)",
> +			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx: %d\n",
>  			port->id, cxld->id, *dpa_base, *dpa_base + len - 1, rc);
>  		return rc;
>  	}
> @@ -1117,7 +1117,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	rc = devm_cxl_dpa_reserve(cxled, *dpa_base + skip, dpa_size, skip);
>  	if (rc) {
>  		dev_err(&port->dev,
> -			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx\n (%d)",
> +			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx: %d\n",
>  			port->id, cxld->id, *dpa_base,
>  			*dpa_base + dpa_size + skip - 1, rc);
>  		return rc;
> 
> base-commit: 88c72bab77aaf389beccf762e112828253ca0564
> prerequisite-patch-id: f44102a7b095afa1588a5cac012ec2e0d852c021
> prerequisite-patch-id: c142edda207a3a69ae242182e51e9a8b8d78cf72

