Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB973803EC
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769095520; cv=none; b=ompPhGAurutvhBfFgBrqK1LqiiYb8YuqIyvlsJKaIjJoYOIHpaamWdnkME114ilzFLM2Hw6q7IvOlO+SjaIuQuvU3RjhYNE8wz6xQxBNtGKfRe0NIhVE2NSBnrP1JDJ5Iv56FYyjjGNkwtuE9h9TklqCBklyeOQ6lIyZflgMOa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769095520; c=relaxed/simple;
	bh=fVDfsgQ3vhBwC4jm7Xu65OaHXrtwbOvjcIevcGNcHHg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+k3oLadtEc6x6kZaLYgrMiYNJQWURB96Bo6DWDW+VyKwWSXKySak/ySPbMGG22tjl0I0X87mdD0CLeud+y9OPgF+lKpdDtZLyRskSD9EqgmxpRP5/xlNZh7mRVJexficxtxo+u9we8ZIreQm6Re3GA5Voce3yxK2F5WZkH+DVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dxlGy1csMzJ46Cy;
	Thu, 22 Jan 2026 23:24:42 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 2321140539;
	Thu, 22 Jan 2026 23:25:10 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 15:25:09 +0000
Date: Thu, 22 Jan 2026 15:25:08 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>, <terry.bowman@amd.com>
Subject: Re: [PATCH 7/9] cxl/port: Map CXL Endpoint Port and CXL Switch Port
 RAS registers
Message-ID: <20260122152508.00000518@huawei.com>
In-Reply-To: <20260122033330.1622168-8-dan.j.williams@intel.com>
References: <20260122033330.1622168-1-dan.j.williams@intel.com>
	<20260122033330.1622168-8-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 21 Jan 2026 19:33:28 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Terry Bowman <terry.bowman@amd.com>
> 
> In preparation for CXL VH (Virtual Host) topology protocol error handling,
> add RAS capability registered mapping for all ports in a CXL VH topology.
> This includes the RAS capabilities of Switch Upstream Ports, Switch
> Downstream Ports, Host Bridge Ports ("upstream"), and Root Ports
> ("downstream")
> 
> Update cxl_port_add_dport() to map the upstream RAS capability on first
> 'dport' attach.

I'm struggling to see how this maps the endpoint registers (or at least
how it changes that). So maybe the patch title has become incorrect?

Other than that seems fine to me.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/cxl.h      |  2 ++
>  drivers/cxl/cxlpci.h   |  4 ++++
>  drivers/cxl/core/ras.c | 16 ++++++++++++++++
>  drivers/cxl/port.c     |  6 ++++++
>  4 files changed, 28 insertions(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 75ff5f055f7f..3e0e82523bfd 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -607,6 +607,7 @@ struct cxl_dax_region {
>   * @parent_dport: dport that points to this port in the parent
>   * @decoder_ida: allocator for decoder ids
>   * @reg_map: component and ras register mapping parameters
> + * @regs: mapped component registers
>   * @nr_dports: number of entries in @dports
>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>   * @commit_end: cursor to track highest committed decoder for commit ordering
> @@ -628,6 +629,7 @@ struct cxl_port {
>  	struct cxl_dport *parent_dport;
>  	struct ida decoder_ida;
>  	struct cxl_register_map reg_map;
> +	struct cxl_component_regs regs;
>  	int nr_dports;
>  	int hdm_end;
>  	int commit_end;
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 0db3d73548aa..970add0256e9 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -82,6 +82,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
>  void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport);
> +void devm_cxl_port_ras_setup(struct cxl_port *port);
>  #else
>  static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
>  
> @@ -93,6 +94,9 @@ static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  static inline void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport)
>  {
>  }
> +static inline void devm_cxl_port_ras_setup(struct cxl_port *port)
> +{
> +}
>  #endif
>  
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index e90b7a91bf5d..b4be9c5715a6 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -166,6 +166,22 @@ void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport)
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_dport_rch_ras_setup, "CXL");
>  
> +void devm_cxl_port_ras_setup(struct cxl_port *port)
> +{
> +	struct cxl_register_map *map = &port->reg_map;
> +
> +	if (!map->component_map.ras.valid) {
> +		dev_dbg(&port->dev, "RAS registers not found\n");
> +		return;
> +	}
> +
> +	map->host = &port->dev;
> +	if (cxl_map_component_regs(map, &port->regs,
> +				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +		dev_dbg(&port->dev, "Failed to map RAS capability\n");
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
> +
>  void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
>  {
>  	void __iomem *addr;
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 2988533fb0a2..50a643cb3e04 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -202,6 +202,12 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
>  		rc = devm_cxl_switch_port_decoders_setup(port);
>  		if (rc)
>  			return ERR_PTR(rc);
> +
> +		/*
> +		 * RAS setup is optional, either driver operation can continue
> +		 * on failure, or the device does not implement RAS registers.
> +		 */
> +		devm_cxl_port_ras_setup(port);
>  	}
>  
>  	dport = devm_cxl_add_dport_by_dev(port, dport_dev);

