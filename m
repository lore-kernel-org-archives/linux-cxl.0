Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E312749C6
	for <linux-cxl@vger.kernel.org>; Tue, 19 Aug 2025 11:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604420; cv=none; b=acXtQofRVdcefNyyYgZiAwnwYUCbxKWjHbMD4FO8w0pavVNb8zMAgdkojoSeyCCM34RRW6tsYoSeL6JLKRXiaGrBL7MdJROTR3oIQOt1LwEf2jWlH0DgIgieQgYkYtJycvejLdarhM74V33Km7FyH0TeddPZaYR90tsUbEIP2qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604420; c=relaxed/simple;
	bh=6yEVEkFnFTZSDUN7bq60yoOyMP777uZp00rxVwlaT+s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RWml0xkdlAVbha9VDH9vlcJvfuAC+173skvFvcyyojJAO0KmU+ZrF2PzKhxssESWKfVpxkfn+sJoF6CxLU0G9BBsCfXwMMKzytZMNOqMDoIIAtuXw6ITLRY1fUkjvFxBbxh7w2GcUOgeexEmvXgwYEbiT8GJsoYs/C/qL1i2dJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c5nwt5Ls8z6GFvC;
	Tue, 19 Aug 2025 19:51:26 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AEAAE140427;
	Tue, 19 Aug 2025 19:53:32 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 19 Aug
 2025 13:53:32 +0200
Date: Tue, 19 Aug 2025 12:53:30 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 06/18] cxl/port, mem: Make adding an endpoint device
 type agnostic
Message-ID: <20250819125330.00006c4f@huawei.com>
In-Reply-To: <20250812212921.9548-7-Benjamin.Cheatham@amd.com>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
	<20250812212921.9548-7-Benjamin.Cheatham@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 12 Aug 2025 16:29:09 -0500
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Change devm_cxl_enumerate_ports() and devm_cxl_add_endpoint() to take a
> generic struct device * instead of struct cxl_memdev in preparation of
> adding cache devices to the port hierarchy.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>

> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index cdac7bfa2289..c615e6c4ee60 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -104,9 +104,11 @@ static int cxl_mem_probe(struct device *dev)
>  	if (rc)
>  		return rc;
>  
> -	rc = devm_cxl_enumerate_ports(cxlmd);
> -	if (rc)
> +	rc = devm_cxl_enumerate_ports(&cxlmd->dev);
> +	if (rc) {
Not immediately obvious to me why this needs to be set.  Perhaps a comment?
> +		cxlmd->endpoint = ERR_PTR(rc);
>  		return rc;
> +	}
>  
>  	struct cxl_port *parent_port __free(put_cxl_port) =
>  		cxl_dev_find_port(&cxlmd->dev, &dport);
> @@ -138,7 +140,7 @@ static int cxl_mem_probe(struct device *dev)
>  			return -ENXIO;
>  		}
>  
> -		rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
> +		rc = devm_cxl_add_endpoint(endpoint_parent, &cxlmd->dev, dport);
>  		if (rc)
>  			return rc;
>  	}


