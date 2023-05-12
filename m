Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DB1C77B7F
	for <linux-cxl@archiver.kernel.org>; Fri, 12 May 2023 14:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240862AbjELOl4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 May 2023 10:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240832AbjELOl4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 May 2023 10:41:56 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23801BFE
        for <linux-cxl@vger.kernel.org>; Fri, 12 May 2023 07:41:54 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHryg0463z67G90;
        Fri, 12 May 2023 22:40:10 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 12 May
 2023 15:41:52 +0100
Date:   Fri, 12 May 2023 15:41:51 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v5 03/14] cxl: Add callback to parse the SSLBIS subtable
 from CDAT
Message-ID: <20230512154151.00003a0a@Huawei.com>
In-Reply-To: <168357883158.2756219.14426990857899261700.stgit@djiang5-mobl3>
References: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
        <168357883158.2756219.14426990857899261700.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 08 May 2023 13:47:11 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Provide a callback to parse the Switched Scoped Latency and Bandwidth
> Information Structure (SSLBIS) in the CDAT structures. The SSLBIS
> contains the bandwidth and latency information that's tied to the
> CXL switch that the data table has been read from. The extracted
> values are stored to the cxl_dport correlated by the port_id
> depending on the SSLBIS entry.
> 
> Coherent Device Attribute Table 1.03 2.1 Switched Scoped Latency
> and Bandwidth Information Structure (DSLBIS)
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'm disagreeing with myself again. Some comments inline based
on a fresh read.

> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v5:
> - Store data to cxl_dport directly instead. (Dan)
> - Use acpi_table_parse_cdat().
> v3:
> - Add spec section in commit header (Alison)
> - Move CDAT parse to cxl_switch_port_probe()
> - Use 'struct node_hmem_attrs'
> ---
>  drivers/cxl/core/cdat.c |   88 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |    8 ++++
>  drivers/cxl/port.c      |   12 ++++++
>  include/acpi/actbl1.h   |    3 ++
>  4 files changed, 110 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 6e14d04c0453..37b135c900d5 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -124,3 +124,91 @@ int cxl_cdat_endpoint_process(struct cxl_port *port, struct list_head *list)
>  	return rc;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cdat_endpoint_process, CXL);
> +
> +static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
> +			       const unsigned long end)
> +{
> +	struct acpi_cdat_sslbis *sslbis = (struct acpi_cdat_sslbis *)header;
> +	struct acpi_cdat_sslbe *entry;
> +	struct cxl_port *port = arg;
> +	struct device *dev = &port->dev;
> +	int remain, entries, i;
> +	u16 len;
> +
> +	len = le16_to_cpu((__force __le16)sslbis->header.length);
> +	remain = len - sizeof(*sslbis);
> +	if (!remain || remain % sizeof(*entry) ||
> +	    (unsigned long)header + len > end) {
> +		dev_warn(dev, "Malformed SSLBIS table length: (%u)\n", len);
> +		return -EINVAL;
> +	}
> +
> +	/* Unrecognized data type, we can skip */
> +	if (sslbis->data_type > ACPI_HMAT_WRITE_BANDWIDTH)
> +		return 0;
> +
> +	entries = remain / sizeof(*entry);
> +	entry = (struct acpi_cdat_sslbe *)((unsigned long)header + sizeof(*sslbis));

That's a little nasty to follow.  Perhaps.
	
	entry = (struct acpi_cdat_sslbe *)(sslbis + 1);

Bonus points if we can just use a variable length entry on the end of
struct acpi_cdat_sslbis. Might break some other locations but would make
this one nicer.

> +
> +	for (i = 0; i < entries; i++) {
> +		u16 x = le16_to_cpu(entry->portx_id);
> +		u16 y = le16_to_cpu(entry->porty_id);
> +		struct cxl_dport *dport;
> +		unsigned long index;
> +		u16 dsp_id;
> +		u64 val;
> +
> +		switch (x) {
> +		case ACPI_CDAT_SSLBIS_US_PORT:
> +			dsp_id = y;
> +			break;
> +		case ACPI_CDAT_SSLBIS_ANY_PORT:
> +			switch (y) {
> +			case ACPI_CDAT_SSLBIS_US_PORT:
> +				dsp_id = x;
> +				break;
> +			case ACPI_CDAT_SSLBIS_ANY_PORT:
> +				dsp_id = ACPI_CDAT_SSLBIS_ANY_PORT;
> +				break;
> +			default:
> +				dsp_id = y;
> +				break;
> +			}
> +			break;
> +		default:
> +			dsp_id = x;
> +			break;
> +		}
> +
> +		if (check_mul_overflow(le64_to_cpu(sslbis->entry_base_unit),
> +				       le16_to_cpu(entry->latency_or_bandwidth),
> +				       &val))
> +			dev_warn(dev, "SSLBIS value overflowed!\n");
> +
> +		xa_for_each(&port->dports, index, dport) {
> +			if (dsp_id == ACPI_CDAT_SSLBIS_ANY_PORT ||
> +			    dsp_id == dport->port_id)
> +				cxl_access_coordinate_set(&dport->coord,
> +							  sslbis->data_type,
> +							  val);
> +		}
> +
> +		entry++;
> +	}
> +
> +	return 0;
> +}
> +
> +int cxl_cdat_switch_process(struct cxl_port *port)
> +{
> +	int rc;
> +
> +	rc = acpi_table_parse_cdat(ACPI_CDAT_TYPE_SSLBIS,
> +				   cdat_sslbis_handler,
> +				   port, port->cdat.table);
> +	if (rc == 0)
> +		rc = -ENOENT;

I'm bored of this pattern now so hide it...

Howabout

	acpi_table_parse_cdat_fail_emtpy() that handles the rc
rewrite internally. (with a better name).

Gets rid of all this boilerplate.



> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cdat_switch_process, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ca3d0d74f2e5..3e8020e0a132 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -600,6 +600,7 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
>   * @rcrb: base address for the Root Complex Register Block
>   * @rch: Indicate whether this dport was enumerated in RCH or VH mode
>   * @port: reference to cxl_port that contains this downstream port
> + * @coord: access coordinates (performance) for switch from CDAT
>   */
>  struct cxl_dport {
>  	struct device *dport;
> @@ -608,6 +609,7 @@ struct cxl_dport {
>  	resource_size_t rcrb;
>  	bool rch;
>  	struct cxl_port *port;
> +	struct access_coordinate coord;
>  };
>  
>  /**
> @@ -803,12 +805,18 @@ struct dsmas_entry {
>  
>  #ifdef CONFIG_ACPI
>  int cxl_cdat_endpoint_process(struct cxl_port *port, struct list_head *list);
> +int cxl_cdat_switch_process(struct cxl_port *port);
>  #else
>  static inline int cxl_cdat_endpoint_process(struct cxl_port *port,
>  					    struct list_head *list)
>  {
>  	return -EOPNOTSUPP;
>  }
> +
> +static inline int cxl_cdat_switch_process(struct cxl_port *port)
> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif
>  
>  /*
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index da023feaa6e2..c5a24b75bf03 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -86,7 +86,17 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>  	if (IS_ERR(cxlhdm))
>  		return PTR_ERR(cxlhdm);
>  
> -	return devm_cxl_enumerate_decoders(cxlhdm, NULL);
> +	rc = devm_cxl_enumerate_decoders(cxlhdm, NULL);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (port->cdat.table) {
> +		rc = cxl_cdat_switch_process(port);
> +		if (rc < 0)
> +			dev_warn(&port->dev, "Failed to parse SSLBIS: %d\n", rc);
> +	}
> +
> +	return 0;
>  }
>  
>  static int cxl_endpoint_port_probe(struct cxl_port *port)
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 8ea7e5d64bc1..82def138a7e4 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -419,6 +419,9 @@ struct acpi_cdat_sslbis {
>  	u64 entry_base_unit;
>  };
>  
> +#define ACPI_CDAT_SSLBIS_US_PORT	0x0100
> +#define ACPI_CDAT_SSLBIS_ANY_PORT	0xffff
> +
>  /* Sub-subtable for above, sslbe_entries field */
>  
>  struct acpi_cdat_sslbe {
> 
> 

