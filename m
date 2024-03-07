Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1197D12BEB1
	for <linux-cxl@vger.kernel.org>; Thu,  7 Mar 2024 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709815998; cv=none; b=dyzyrayWhPNZsqUAvmmDWNbLNx76jSgvFYUKn8mpFGTe9sAWrVKhQUvPA4uFFgV14YdIvt/J86aUKCd8GPVb6fkpg1tnbL6QXrS+t/bZ7Fvdg/8tedgXxqy6KokanTSCzWDBBsxqpNm7sbbG0VNxUZVvZlo88790RcANLCW/gOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709815998; c=relaxed/simple;
	bh=ueLYuZmf3Md+zwb6NrmNsbrRff/yoPN1QEGQU040V0Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uMFIVs8v5jiFW5iwlwla4GYJzkNjUSwJqc/+647c9DGG46WOn4tkJ9rmV0HosfNszOarsA+1wGz0yNoHQSvypfvOP1aztcr2H2yxyYh2BIGY04oBGwYXCYGzAPe5GrhSWbJ54A60VqkG7LqNkr2gsUlW7VtgqnNh0Puaa6ZI1UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tr8Nj5M5mz6J9lC;
	Thu,  7 Mar 2024 20:53:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C181A14058E;
	Thu,  7 Mar 2024 20:53:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Mar
 2024 12:53:12 +0000
Date: Thu, 7 Mar 2024 12:53:11 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v3 2/3] cxl: Consolidate dport access_coordinate
 ->hb_coord and ->sw_coord into ->coord
Message-ID: <20240307125311.00005ede@Huawei.com>
In-Reply-To: <20240306175204.1906538-2-dave.jiang@intel.com>
References: <20240306175204.1906538-1-dave.jiang@intel.com>
	<20240306175204.1906538-2-dave.jiang@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 6 Mar 2024 10:52:03 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The driver stores access_coordinate for host bridge in ->hb_coord and switch
> CDAT access_coordinate in ->sw_coord. Since neither of these
> access_coordinate clobber each other, the variable name can be consolidated
> into ->coord to simplify the code. This change also simplifies the iteration
> loop in cxl_endpoint_get_perf_coordinates() and allow all the
> access_coordinate to be picked up in the loop.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Makes sense - can only be one set of access characteristics for a dport,
just coming from different sources depending on which dport it is.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/acpi.c      | 6 +++---
>  drivers/cxl/core/cdat.c | 2 +-
>  drivers/cxl/core/port.c | 5 +----
>  drivers/cxl/cxl.h       | 6 ++----
>  4 files changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 1a3e6aafbdcc..dbd5a0d10f8b 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -530,13 +530,13 @@ static int get_genport_coordinates(struct device *dev, struct cxl_dport *dport)
>  	if (kstrtou32(acpi_device_uid(hb), 0, &uid))
>  		return -EINVAL;
>  
> -	rc = acpi_get_genport_coordinates(uid, &dport->hb_coord);
> +	rc = acpi_get_genport_coordinates(uid, &dport->coord);
>  	if (rc < 0)
>  		return rc;
>  
>  	/* Adjust back to picoseconds from nanoseconds */
> -	dport->hb_coord.read_latency *= 1000;
> -	dport->hb_coord.write_latency *= 1000;
> +	dport->coord.read_latency *= 1000;
> +	dport->coord.write_latency *= 1000;
>  
>  	return 0;
>  }
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 0363ca434ef4..fcfb6308996b 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -460,7 +460,7 @@ static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
>  		xa_for_each(&port->dports, index, dport) {
>  			if (dsp_id == ACPI_CDAT_SSLBIS_ANY_PORT ||
>  			    dsp_id == dport->port_id)
> -				cxl_access_coordinate_set(&dport->sw_coord,
> +				cxl_access_coordinate_set(&dport->coord,
>  							  sslbis->data_type,
>  							  val);
>  		}
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index e1d30a885700..6fa273677963 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2143,7 +2143,7 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>  	 * nothing to gather.
>  	 */
>  	while (!is_cxl_root(to_cxl_port(iter->dev.parent))) {
> -		combine_coordinates(&c, &dport->sw_coord);
> +		combine_coordinates(&c, &dport->coord);
>  		c.write_latency += dport->link_latency;
>  		c.read_latency += dport->link_latency;
>  
> @@ -2151,9 +2151,6 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>  		dport = iter->parent_dport;
>  	}
>  
> -	/* Augment with the generic port (host bridge) perf data */
> -	combine_coordinates(&c, &dport->hb_coord);
> -
>  	/* Get the calculated PCI paths bandwidth */
>  	pdev = to_pci_dev(port->uport_dev->parent);
>  	bw = pcie_bandwidth_available(pdev, NULL, NULL, NULL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 003feebab79b..0cf5f23d9de6 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -658,8 +658,7 @@ struct cxl_rcrb_info {
>   * @rch: Indicate whether this dport was enumerated in RCH or VH mode
>   * @port: reference to cxl_port that contains this downstream port
>   * @regs: Dport parsed register blocks
> - * @sw_coord: access coordinates (performance) for switch from CDAT
> - * @hb_coord: access coordinates (performance) from ACPI generic port (host bridge)
> + * @coord: access coordinates (bandwidth and latency performance attributes)
>   * @link_latency: calculated PCIe downstream latency
>   */
>  struct cxl_dport {
> @@ -670,8 +669,7 @@ struct cxl_dport {
>  	bool rch;
>  	struct cxl_port *port;
>  	struct cxl_regs regs;
> -	struct access_coordinate sw_coord;
> -	struct access_coordinate hb_coord;
> +	struct access_coordinate coord;
>  	long link_latency;
>  };
>  

