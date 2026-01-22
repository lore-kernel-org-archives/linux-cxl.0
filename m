Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951AA34F279
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094062; cv=none; b=D5vE/Ln7IgbIVJ5T0aNZ0SHf2cWaf2PQW1Luco+I8++zVrc0WptXIp4NRClYZBsNoZLyRHJEZL4gA94GBt/kdf4yJJCrp3AmNvH/utewyqyVask3FrWMTe4hhtFYMrCdK8Ng8aWy8m6m1SguW4eKMTr+PhG0oQXU9485fN2/xK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094062; c=relaxed/simple;
	bh=GJATCReGfVxuRdXV7CGCyp1C5muYjobO28k1/e36Sks=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WzsKqjNZJxxnAlkOcUJFfrKol80JQrhacdUtqBxPiP+ALFlts2DBRzRL0HPJG5okoLtL39SlNVse7twcX2Fv8gs8q7yOnKVASnr6/fStw+SwZEttHfMF+MqtNhmAS63upLcE3VcdcCFz1NKSk3YmWXH0LVi0qBrDUjIgQounAUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dxkl06DHzzJ46bm;
	Thu, 22 Jan 2026 23:00:28 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id BBABA40570;
	Thu, 22 Jan 2026 23:00:56 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 15:00:56 +0000
Date: Thu, 22 Jan 2026 15:00:54 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>, <terry.bowman@amd.com>
Subject: Re: [PATCH 6/9] cxl/port: Move dport RAS setup to dport add time
Message-ID: <20260122150054.00006604@huawei.com>
In-Reply-To: <20260122033330.1622168-7-dan.j.williams@intel.com>
References: <20260122033330.1622168-1-dan.j.williams@intel.com>
	<20260122033330.1622168-7-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 21 Jan 2026 19:33:27 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Towards the end goal of making all CXL RAS capability handling uniform
> across host bridge ports, upstream switch ports, and endpoint ports, move
> dport RAS setup. Move it to cxl_switch_port_probe() context for switch / VH
> dports (via cxl_port_add_dport()) and cxl_endpoint_port_probe() context for
> an RCH dport. Rename the RAS setup helper to devm_cxl_dport_ras_setup() for
> symmetry with devm_cxl_switch_port_decoders_setup().
> 
> Only the RCH version needs to be exported and the cxl_test mocking can be
> deleted with a dev_is_pci() check on the dport_dev.
> 
Comment below that doesn't really have anything to do with this patch
and can be ignored.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/core.h       |  8 ++++++++
>  drivers/cxl/cxlpci.h          |  8 ++++----
>  drivers/cxl/core/port.c       | 10 +++-------
>  drivers/cxl/core/ras.c        | 30 ++++++++++++++++++------------
>  drivers/cxl/mem.c             |  2 --
>  drivers/cxl/port.c            | 12 ++++++++++++
>  tools/testing/cxl/test/mock.c | 12 ------------
>  tools/testing/cxl/Kbuild      |  1 -
>  8 files changed, 45 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 422531799af2..fb1461c07648 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -144,6 +144,12 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
>  int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>  					struct access_coordinate *c);
>  
> +static inline struct device *dport_to_host(struct cxl_dport *dport)
> +{
> +	if (is_cxl_root(dport->port))
> +		return dport->port->uport_dev;
> +	return &dport->port->dev;

Obviously really applies to earlier patch but maybe it's worth 

	struct cxl_port *port = &dport->port;

	if (is_cxl_root(port))
		return port->uport_dev;
	return port->dev;

I'm not sure it really adds that much but is the sort of thing
someone will post a patch 'tidying up' later.

> +}
