Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F001519B0;
	Fri, 14 Mar 2025 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741951899; cv=none; b=CQ3bgkayxkDNKVe52Me2Azxv9WNQviTJeroDthGHnKgBJaoEuFVFmem1WInD/v1NE1FtLTtfziCi4It1zfzwFtwJyADDeqfS0Qjpf1Eqrv3FKo7zwNvfEnaf4G2UFRJlw3CKKILMDolvDP0lKI6e1A44x0Jv+tfc5B7BPYRrvk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741951899; c=relaxed/simple;
	bh=grr53J3wv2CQbIqmII5z7WbBcrMBMQ/wYtPz7OGp2wk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A90NF6UQi071UapLS8UTHBjZoOkA9wxB/0a3gtpMHBUinR7gdNwh5A1CMaMIn+s+dO73JWazTxiPpf5TviRRSTszW1rS4McvffK4Umd8pvgbRYdZ01nWCiq1VFpkYbLjfK7fuLr11bySJueP9XT11LDZs5Ie54EhQmvXQEh+9i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDhvn6wPcz6K94D;
	Fri, 14 Mar 2025 19:28:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BDE4C140A70;
	Fri, 14 Mar 2025 19:31:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Mar
 2025 12:31:34 +0100
Date: Fri, 14 Mar 2025 11:31:32 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v4 02/14] cxl/pci: Moving code in cxl_hdm_decode_init()
Message-ID: <20250314113132.000043ce@huawei.com>
In-Reply-To: <20250306164448.3354845-3-rrichter@amd.com>
References: <20250306164448.3354845-1-rrichter@amd.com>
	<20250306164448.3354845-3-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 6 Mar 2025 17:44:36 +0100
Robert Richter <rrichter@amd.com> wrote:

> Commit 3f9e07531778 ("cxl/pci: simplify the check of mem_enabled in
> cxl_hdm_decode_init()") changed the code flow in this function. The
> root port is determined before a check to leave the function. Since
> the root port is not used by the check it can be moved to run the
> check first. This improves code readability and avoids unnesessary
> code execution.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/pci.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 33c3bdd35b24..6386e84e51a4 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -419,14 +419,6 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  	if (!hdm)
>  		return -ENODEV;
>  
> -	root = to_cxl_port(port->dev.parent);
> -	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
> -		root = to_cxl_port(root->dev.parent);
> -	if (!is_cxl_root(root)) {
> -		dev_err(dev, "Failed to acquire root port for HDM enable\n");
> -		return -ENODEV;
> -	}
> -
>  	if (!info->mem_enabled) {
>  		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
>  		if (rc)
> @@ -435,6 +427,14 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  		return devm_cxl_enable_mem(&port->dev, cxlds);
>  	}
>  
> +	root = to_cxl_port(port->dev.parent);
> +	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
> +		root = to_cxl_port(root->dev.parent);
> +	if (!is_cxl_root(root)) {
> +		dev_err(dev, "Failed to acquire root port for HDM enable\n");

Is this error message suffering from code rot?  In the path where
root is used, use no HDM enabling occurs.

> +		return -ENODEV;
> +	}
> +
>  	for (i = 0, allowed = 0; i < info->ranges; i++) {
>  		struct device *cxld_dev;
>  

