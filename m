Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AF21C3BE9
	for <linux-cxl@vger.kernel.org>; Mon, 23 Dec 2024 19:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734983596; cv=none; b=KT7rKnk4dLNEL4WgfVtig72jS99bIIEaR2JA3MJFzuc/lJseCW6TvK2Ob0N8NGl1ZxW8hbKkK2bnjwwp7aTAjVRqCnexhUhHheMeg7YUSVFYrq31lXjgDBYCrpN1cwxj9FjlfBkRbyaRdYk5qLEvcekfCfmIumxB1lbERXd3eck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734983596; c=relaxed/simple;
	bh=vOqIZs0fKAdtMwWrTHeyuEJQQH+IhXrp0Bb3nScXDH8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PjtZ/ihIcqS6VPFGXcreZjEE8uqnu3xt/M4tcCIQZGB73/DqNR2gSQesF0LdslwU/h5I6pPqCb3j8Dru8lsGB4fWyMoRmv2uhwNld1/VX+jP9ylCxcfVRhwueydHXzkBvw6b3yd3ztXumBXjHdub9FCKFG1vWLz3MDK6VJ6KgVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YH7vf30GSz6L7DB;
	Tue, 24 Dec 2024 03:51:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A9872140A70;
	Tue, 24 Dec 2024 03:53:10 +0800 (CST)
Received: from localhost (10.47.75.118) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Dec
 2024 20:53:10 +0100
Date: Mon, 23 Dec 2024 19:53:08 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <seven.yi.lee@gmail.com>, <hch@infradead.org>,
	<a.manzanares@samsung.com>, <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFC 1/1] cxl/pci: Support Global Persistent Flush (GPF)
Message-ID: <20241223195308.000059ba@huawei.com>
In-Reply-To: <20241220164337.204900-2-dave@stgolabs.net>
References: <20241220164337.204900-1-dave@stgolabs.net>
	<20241220164337.204900-2-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 20 Dec 2024 08:43:37 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Add support for GPF flows. It is found that the CXL specification
> around this to be a bit too involved from the driver side. And while
> this should really all handled by the hardware, this patch takes
> things with a grain of salt.
> 
> Timeout detection is based on dirty Shutdown semantics. The driver
> will mark it as dirty, expecting that the device clear it upon a
> successful GPF event. The admin may consult the device Health and
> check the dirty shutdown counter to see if there was a problem
> with data integrity.
> 
> Timeout arming is done throughout the decode hierarchy, upon device
> probing and hot-remove. These timeouts can be over-specified,
> particularly T1. Set the max timeout to 20 seconds for T1, which is
> the NMI watchdog default for lockup detection. For T2, the policy
> is to use the largest device T2 available in the hierarchy.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Hi Davidlohr,

Just some superficial review whilst I was trying to grasp what was
involved. I don't know enough about this particular feature to do much
more without some spec reading etc.  That will probably have to
wait for 2025.

Thanks,

Jonathan

> ---
>  Documentation/driver-api/cxl/maturity-map.rst |   2 +-
>  drivers/cxl/core/mbox.c                       |  17 +++
>  drivers/cxl/core/pci.c                        | 104 ++++++++++++++++++
>  drivers/cxl/core/port.c                       |  68 ++++++++++++
>  drivers/cxl/cxl.h                             |   3 +
>  drivers/cxl/cxlmem.h                          |  24 ++++
>  drivers/cxl/cxlpci.h                          |  64 +++++++++++
>  drivers/cxl/pci.c                             |  97 ++++++++++++++++
>  8 files changed, 378 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
> index df8e2ac2a320..99dd2c841e69 100644
> --- a/Documentation/driver-api/cxl/maturity-map.rst
> +++ b/Documentation/driver-api/cxl/maturity-map.rst
> @@ -130,7 +130,7 @@ Mailbox commands
>  * [0] Switch CCI
>  * [3] Timestamp
>  * [1] PMEM labels
> -* [0] PMEM GPF / Dirty Shutdown
> +* [1] PMEM GPF / Dirty Shutdown
>  * [0] Scan Media
>  
>  PMU
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 548564c770c0..c82cf1547027 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1308,6 +1308,23 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, "CXL");
>  
> +int cxl_set_shutdown_state(struct cxl_memdev_state *mds, bool dirty)
> +{
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	struct cxl_mbox_set_shutdown_state in;
> +
> +	in.state = dirty;

For readability and because the definition of in isn't right here, maybe make
the setting of 1 / 0 explicit?  I briefly wondered how we were writing a boolean.

	in.state = dirty ? 1 : 0;

> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_SET_SHUTDOWN_STATE,
> +		.size_in = sizeof(in),
> +		.payload_in = &in,
> +	};
> +
> +	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_set_shutdown_state, "CXL");
> +
>  int cxl_set_timestamp(struct cxl_memdev_state *mds)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9d58ab9d33c5..9b1e110817f2 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1054,3 +1054,107 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>  
>  	return 0;
>  }
> +
> +int cxl_pci_update_gpf_port(struct pci_dev *pdev,
> +			    struct cxl_memdev *cxlmd, bool remove)
odd wrap. I'd move cxlmd up a line as still under 80 chars.


> +{
> +	u16 ctrl;
> +	int port_t1_base, port_t1_scale;
> +	int port_t2_base, port_t2_scale;
> +	unsigned long device_tmo, port_tmo;
> +	int rc, dvsec;

Given no other reason for ordering. reverse xmas?

> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	dvsec = pci_find_dvsec_capability(
> +		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PORT_GPF);

I'd align after (. There is space under 80 chars.

> +	if (!dvsec) {
> +		dev_warn(&pdev->dev,
> +			 "GPF Port DVSEC not present\n");

One line.

> +		return -EINVAL;
> +	}
> +
> +	/* check for t1 */
> +	rc = pci_read_config_word(
> +		pdev,
> +		dvsec + CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET,
> +		&ctrl);
> +	if (rc)
> +		return rc;
> +
> +	port_t1_base = FIELD_GET(CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK,
> +				 ctrl);
> +	port_t1_scale = FIELD_GET(CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK,
> +				  ctrl);
> +	if (port_t1_scale > GPF_TIMEOUT_SCALE_MAX) {
> +		dev_warn(&pdev->dev, "GPF: invalid port phase 1 timeout\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Set max timeout such that vendors will optimize GPF flow to
> +	 * avoid the implied worst-case scenario delays.
> +	 */
> +	device_tmo = gpf_timeout_us(7, GPF_TIMEOUT_SCALE_MAX);
> +	port_tmo = gpf_timeout_us(port_t1_base, port_t1_scale);
> +
> +	dev_dbg(&pdev->dev, "Port GPF phase 1 timeout: %lu us\n", port_tmo);
> +
> +	if ((remove && device_tmo != port_tmo) || device_tmo > port_tmo) {
> +		/* update the timeout in DVSEC */
> +		ctrl = FIELD_PREP(CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK,
> +				   7);
> +		ctrl |= FIELD_PREP(CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK,
> +				   GPF_TIMEOUT_SCALE_MAX);
> +		rc = pci_write_config_word(
> +			pdev,
> +			dvsec + CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET,
> +			ctrl);
> +		if (rc)
> +			return rc;
> +
> +		dev_dbg(&pdev->dev,
> +			"new GPF Port phase 1 timeout: %lu us\n", device_tmo);
> +	}
> +
> +	/* check for t2 */
> +	rc = pci_read_config_word(
> +		pdev,
> +		dvsec + CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET,
> +		&ctrl);
> +	if (rc)
> +		return rc;
> +
> +	port_t2_base = FIELD_GET(CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK,
> +			    ctrl);
> +	port_t2_scale = FIELD_GET(CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK,
> +			     ctrl);
> +	if (port_t2_scale > GPF_TIMEOUT_SCALE_MAX) {
> +		dev_warn(&pdev->dev, "GPF: invalid port phase 2 timeout\n");
> +		return -EINVAL;
> +	}
> +
> +	device_tmo = gpf_timeout_us(mds->gpf.t2_base, mds->gpf.t2_scale);
> +	port_tmo = gpf_timeout_us(port_t2_base, port_t2_scale);
> +
> +	dev_dbg(&pdev->dev, "Port GPF phase 2 timeout: %lu us\n", port_tmo);
> +
> +	if ((remove && device_tmo != port_tmo) || device_tmo > port_tmo) {
> +		/* update the timeout in DVSEC */
> +		ctrl = FIELD_PREP(CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK,
> +				   mds->gpf.t2_base);
> +		ctrl |= FIELD_PREP(CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK,
> +				   mds->gpf.t2_scale);
> +		rc = pci_write_config_word(
> +			pdev,
> +			dvsec + CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET,
> +			ctrl);
> +		if (rc)
> +			return rc;
> +
> +		dev_dbg(&pdev->dev,
> +			"new GPF Port phase 2 timeout: %lu us\n", device_tmo);
> +	}

Can you factor out the above as there is a huge amount of repetition for phase 1
and phase 2?  Should give more readable code I hope!

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_update_gpf_port, "CXL");

> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 2a25d1957ddb..670cf4f91c6a 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -450,6 +450,21 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>  	return dev_get_drvdata(cxl_mbox->host);
>  }
>  
> +/**
> + * struct cxl_gpf_device - Device GPF information
> + *
> + * Cached Device Global Persistent Flush data (Phase 2).

Maybe name it so the ph2 is in there?

> + *
> + * @t2_base: Base component of the timeout.
> + * @t2_scale: Scale component of the timeout.
> + * @power_nwatts: Required power from the device.
> + */
> +struct cxl_gpf_dev {
> +	u16 t2_base;
> +	u16 t2_scale;
> +	u32 power_mwatts;
> +};
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 4da07727ab9c..fe7d92ef538f 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -40,9 +40,20 @@
>  
>  /* CXL 2.0 8.1.6: GPF DVSEC for CXL Port */
>  #define CXL_DVSEC_PORT_GPF					4
> +#define   CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET		0x0C
> +#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK		GENMASK(3, 0)
> +#define	    CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK		GENMASK(11, 8)
Why the extra indent? Should be same as line above.
> +#define   CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET		0xE
> +#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK		GENMASK(3, 0)
> +#define	    CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK		GENMASK(11, 8)

snap.

>  
>  /* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
>  #define CXL_DVSEC_DEVICE_GPF					5
> +#define   CXL_DVSEC_DEVICE_GPF_PHASE_2_DURATION_OFFSET		0xA
> +#define     CXL_DVSEC_DEVICE_GPF_PHASE_2_TIME_BASE_MASK		GENMASK(3, 0)
> +#define	    CXL_DVSEC_DEVICE_GPF_PHASE_2_TIME_SCALE_MASK	GENMASK(11, 8)
Bonus points for consistency.

> +#define   CXL_DVSEC_DEVICE_GPF_PHASE_2_POWER_OFFSET		0xC
> +#define	    CXL_DVSEC_DEVICE_GPF_PHASE_2_ACTIVE_POWER_MASK	GENMASK(31, 0)
>  
>  /* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
>  #define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
> @@ -129,4 +140,57 @@ void read_cdat_data(struct cxl_port *port);
>  void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
> +
> +#define GPF_TIMEOUT_SCALE_MAX 7 /* 10 seconds */
> +
> +static inline unsigned long gpf_timeout_us(int base, int scale)
> +{
> +	unsigned long tmo, others;
> +
> +	switch (scale) {

Look up table maybe?  Name tmo tmo_usec to avoid need to give units.

> +	case 0: /* 1 us */
> +		tmo = 1;
> +		break;
> +	case 1: /* 10 us */
> +		tmo = 10UL;
> +		break;
> +	case 2: /* 100 us */
> +		tmo = 100UL;
> +		break;
> +	case 3: /* 1 ms */
> +		tmo = 1000UL;
> +		break;
> +	case 4: /* 10 ms */
> +		tmo = 10000UL;
> +		break;
> +	case 5: /* 100 ms */
> +		tmo = 100000UL;
100 * MILI
> +		break;
> +	case 6: /* 1 s */
> +		tmo = 1000000UL;
MICRO
etc
Who likes counting zeros?  Units.h is our friend.
And with those definitions it becomes fairly obvious
and I think you can drop the comments.

> +		break;
> +	case GPF_TIMEOUT_SCALE_MAX:
> +		tmo = 10000000UL;
> +		break;
> +	default:
> +		tmo = 0;
> +		break;
> +	}
> +
> +	tmo *= base;
> +	/*
> +	 * The spec is over involved. Do not account for any ad-hoc
> +	 * host delays. Ie: propagation delay, host-side processing
> +	 * delays, and any other  host/system-specific delays.
> +	 */
> +	others = 0;
> +	tmo += others;
> +
> +	/*
> +	 * Limit max timeout to 20 seconds (per phase), which is
> +	 * already the default for the nmi watchdog.
> +	 */
> +	return min(20000000UL, tmo);
> +}
> +
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 6d94ff4a4f1a..37d5616b6fc8 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -900,6 +900,101 @@ static struct attribute_group cxl_rcd_group = {
>  };
>  __ATTRIBUTE_GROUPS(cxl_rcd);
>  
> +
> +static int cxl_gpf_setup(struct pci_dev *pdev)
> +{
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	struct cxl_port *port;
> +	int rc, gpf_dvsec;
> +	u16 duration;
> +	u32 power;
> +	int device_t2_base, device_t2_scale;
reverse xmas again given no other reason for ordering that I ca see
(after first few where there are dependencies.


