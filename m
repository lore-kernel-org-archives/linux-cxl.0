Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF02611187
	for <linux-cxl@vger.kernel.org>; Tue, 26 Nov 2024 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732637384; cv=none; b=n3hUB85ElcODrdwcGR4NBTKVWPb9hsUIuXQ4ZXiBFW6Ydx1m3mXV9NQiFi9i7xHYghDH6NEhTsmKgpzvsLt8ZVPBdufVxxKoKPTivt4bl40magm7wAQEcJpvJ8r9Z5Qw3/SWAxULl/s3TTXvplvKOGTi59fpb1YeReZOJtScR/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732637384; c=relaxed/simple;
	bh=4sT/jriTXWP6qm9Z1NXZZARi5K4QSM58s4qxjk/WOlM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2XAOo40TsoHw772jgKptIHiV1xPhuREvx8eY8uTP5xph2zyjknUIxE+KSYSEt+I3RqnDHdviSmghnSVOsvSsub4II7TxixDE9PDkLBOMrtR9VeH1DaNbF9YMCvfPFMPQCNcpmFAtGqQ1AYKLGauWIzX1HYx2tlzgWJLVyCb7Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XySBf0c8Wz6K5pW;
	Wed, 27 Nov 2024 00:07:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 87064140A9C;
	Wed, 27 Nov 2024 00:09:40 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 26 Nov
 2024 17:09:40 +0100
Date: Tue, 26 Nov 2024 16:09:38 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>, "Alejandro
 Lucero" <alucerop@amd.com>
Subject: Re: [PATCH] cxl: avoid driver data for obtaining cxl_dev_state
 reference
Message-ID: <20241126160938.0000375a@huawei.com>
In-Reply-To: <20241114112435.45593-1-alejandro.lucero-palau@amd.com>
References: <20241114112435.45593-1-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 14 Nov 2024 11:24:35 +0000
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alejandro.lucero-palau@amd.com>
> 
> CXL Type3 pci driver uses struct device driver_data for keeping
> cxl_dev_state reference. Type1/2 drivers are not only about CXL so
> this field so not be used when code requires cxl_dev_state to work with
> and such a code used for Type2 support.
> 
> Change cxl_dvsec_rr_decode for passing cxl_dev_state as a parameter.
Looks like you also dropped the unused parameter port.  Mention that as well.

> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/pci.c        | 6 +++---
>  drivers/cxl/cxl.h             | 2 +-
>  drivers/cxl/port.c            | 2 +-
>  tools/testing/cxl/test/mock.c | 6 +++---
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 5b46bc46aaa9..420e4be85a1f 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -291,11 +291,11 @@ static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
>  	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
>  }
>  
> -int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
> +int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  			struct cxl_endpoint_dvsec_info *info)
>  {
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	struct device *dev = cxlds->dev;
>  	int hdm_count, rc, i, ranges = 0;
>  	int d = cxlds->cxl_dvsec;
>  	u16 cap, ctrl;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 5406e3ab3d4a..42a46e78d786 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -812,7 +812,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>  int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  				struct cxl_endpoint_dvsec_info *info);
>  int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
> -int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
> +int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  			struct cxl_endpoint_dvsec_info *info);
>  
>  bool is_cxl_region(struct device *dev);
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 9dc394295e1f..acf2ac70f343 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -98,7 +98,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	struct cxl_port *root;
>  	int rc;
>  
> -	rc = cxl_dvsec_rr_decode(cxlds->dev, port, &info);
> +	rc = cxl_dvsec_rr_decode(cxlds, &info);
>  	if (rc < 0)
>  		return rc;
>  
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index f4ce96cc11d4..4f82716cfc16 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -228,16 +228,16 @@ int __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
>  }
>  EXPORT_SYMBOL_NS_GPL(__wrap_cxl_hdm_decode_init, CXL);
>  
> -int __wrap_cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
> +int __wrap_cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  			       struct cxl_endpoint_dvsec_info *info)
>  {
>  	int rc = 0, index;
>  	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
>  
> -	if (ops && ops->is_mock_dev(dev))
> +	if (ops && ops->is_mock_dev(cxlds->dev))
>  		rc = 0;
>  	else
> -		rc = cxl_dvsec_rr_decode(dev, port, info);
> +		rc = cxl_dvsec_rr_decode(cxlds, info);
>  	put_cxl_mock_ops(index);
>  
>  	return rc;

