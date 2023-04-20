Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2083C77B76
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Apr 2023 11:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjDTLkt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Apr 2023 07:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjDTLks (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Apr 2023 07:40:48 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF55DAD;
        Thu, 20 Apr 2023 04:40:46 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q2G0R4BGDz67PjK;
        Thu, 20 Apr 2023 19:39:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Apr
 2023 12:40:44 +0100
Date:   Thu, 20 Apr 2023 12:40:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>
Subject: Re: [PATCH v4 06/23] cxl: Add callback to parse the DSLBIS subtable
 from CDAT
Message-ID: <20230420124043.00004e0e@Huawei.com>
In-Reply-To: <168193569717.1178687.294428469465996536.stgit@djiang5-mobl3>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
        <168193569717.1178687.294428469465996536.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 19 Apr 2023 13:21:37 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Provide a callback to parse the Device Scoped Latency and Bandwidth
> Information Structure (DSLBIS) in the CDAT structures. The DSLBIS
> contains the bandwidth and latency information that's tied to a DSMAS
> handle. The driver will retrieve the read and write latency and
> bandwidth associated with the DSMAS which is tied to a DPA range.
> 
> Coherent Device Attribute Table 1.03 2.1 Device Scoped Latency and
> Bandwidth Information Structure (DSLBIS)
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 

One comment inline.

> +/* Flags for DSLBIS subtable */
> +#define DSLBIS_MEM_MASK		GENMASK(3, 0)
> +#define DSLBIS_MEM_MEMORY	0
> +
>  int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>  struct cxl_dev_state;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> @@ -136,5 +164,9 @@ cdat_table_parse(dsmas);
>  cdat_table_parse(dslbis);
>  cdat_table_parse(sslbis);
>  
> -int cxl_dsmas_parse_entry(struct cdat_entry_header *header, void *arg);
> +#define cxl_parse_entry(x) \
> +int cxl_##x##_parse_entry(struct cdat_entry_header *header, void *arg)
I'm not sure this is worthwhile. What was your reasoning for it?
Also wrecks typing that arg argument as I suggested earlier...

> +
> +cxl_parse_entry(dsmas);
> +cxl_parse_entry(dslbis);

