Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E75CC77B7F
	for <linux-cxl@archiver.kernel.org>; Fri, 12 May 2023 14:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241230AbjELOuv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 May 2023 10:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241173AbjELOuu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 May 2023 10:50:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF6C30E5
        for <linux-cxl@vger.kernel.org>; Fri, 12 May 2023 07:50:48 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHs8w36WYz67jMp;
        Fri, 12 May 2023 22:49:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 12 May
 2023 15:50:45 +0100
Date:   Fri, 12 May 2023 15:50:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v5 04/14] cxl: Add support for _DSM Function for
 retrieving QTG ID
Message-ID: <20230512155045.00004b58@Huawei.com>
In-Reply-To: <168357883767.2756219.11563272201242678864.stgit@djiang5-mobl3>
References: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
        <168357883767.2756219.11563272201242678864.stgit@djiang5-mobl3>
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

On Mon, 08 May 2023 13:47:17 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> CXL spec v3.0 9.17.3 CXL Root Device Specific Methods (_DSM)
> 
> Add support to retrieve QTG ID via ACPI _DSM call. The _DSM call requires
> an input of an ACPI package with 4 dwords (read latency, write latency,
> read bandwidth, write bandwidth). The call returns a package with 1 WORD
> that provides the max supported QTG ID and a package that may contain 0 or
> more WORDs as the recommended QTG IDs in the recommended order.
> 
> Create a cxl_root container for the root cxl_port and provide a callback
> ->get_qos_class() in order to retrieve the QoS class. For the ACPI case,  
> the _DSM helper is used to retrieve the QTG ID and returned. A
> devm_cxl_add_root() function is added for root port setup and registration
> of the cxl_root callback operation(s).
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Trivial comment inline.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> v5:
> - Make the helper a callback for the CXL root. (Dan)
> - Drop the addition of core/acpi.c. (Dan)
> - Add endiness handling. (Jonathan)
> - Refactor error exits. (Jonathan)
> - Update evaluate function description. (Jonathan)
> - Make uuid static. (Dan)
> v2:
> - Reorder var declaration and use C99 style. (Jonathan)
> - Allow >2 ACPI objects in package for future expansion. (Jonathan)
> - Check QTG IDs against MAX QTG ID provided by output package. (Jonathan)
> ---
>  drivers/cxl/acpi.c      |  126 ++++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/core/port.c |   41 +++++++++++++--
>  drivers/cxl/cxl.h       |   33 ++++++++++++
>  3 files changed, 192 insertions(+), 8 deletions(-)
> 

> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 3e8020e0a132..16fc14d43aa4 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -586,6 +586,30 @@ struct cxl_port {
>  	bool cdat_available;
>  };
>  
> +struct qtg_dsm_input;
> +
> +struct cxl_root_ops {
> +	int (*get_qos_class)(struct cxl_port *root_port,
> +			     struct qtg_dsm_input *input);
> +};
> +
> +/**
> + * struct cxl_root - logical collection of root cxl_port items
> + *
> + * @port: cxl_port member
> + * @ops: cxl root operations
> + */
> +struct cxl_root {
> +	struct cxl_port port;
> +	const struct cxl_root_ops *ops;
> +};
> +
> +static inline struct cxl_root *
> +to_cxl_root(const struct cxl_port *port)
> +{
> +	return container_of(port, struct cxl_root, port);
> +}
> +
>  static inline struct cxl_dport *
>  cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
>  {
> @@ -665,6 +689,8 @@ struct pci_bus *cxl_port_to_pci_bus(struct cxl_port *port);
>  struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
>  				   resource_size_t component_reg_phys,
>  				   struct cxl_dport *parent_dport);
> +struct cxl_root *devm_cxl_add_root(struct device *host,
> +				   const struct cxl_root_ops *ops);
>  struct cxl_port *find_cxl_root(struct cxl_port *port);
>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
>  void cxl_bus_rescan(void);
> @@ -819,6 +845,13 @@ static inline int cxl_cdat_switch_process(struct cxl_port *port)
>  }
>  #endif
>  
> +struct qtg_dsm_input {
> +	__le32 rd_lat;
> +	__le32 wr_lat;
> +	__le32 rd_bw;
> +	__le32 wr_bw;
> +};

Could just move this up so forwards def not needed,

> +
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
>   * of these symbols in tools/testing/cxl/.
> 
> 

