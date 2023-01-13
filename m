Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25282C54EBD
	for <linux-cxl@archiver.kernel.org>; Fri, 13 Jan 2023 14:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjAMOEm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 13 Jan 2023 09:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239638AbjAMODU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 13 Jan 2023 09:03:20 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DD52BCF
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jan 2023 06:01:51 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NtjhD0GKVz68379;
        Fri, 13 Jan 2023 21:59:08 +0800 (CST)
Received: from localhost (10.81.201.219) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 14:01:49 +0000
Date:   Fri, 13 Jan 2023 14:01:48 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v2 5/8] cxl: create emulated cxl_hdm for devices that do
 not have HDM decoders
Message-ID: <20230113140148.0000568c@Huawei.com>
In-Reply-To: <167330062229.975161.18102703412584824456.stgit@djiang5-mobl3.local>
References: <167330048147.975161.8832707018372221375.stgit@djiang5-mobl3.local>
        <167330062229.975161.18102703412584824456.stgit@djiang5-mobl3.local>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.201.219]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 09 Jan 2023 14:43:43 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> CXL rev3 spec 8.1.3
> RCDs may not have HDM register blocks. Create a fake HDM with information
> from the CXL PCIe DVSEC registers. The decoder count will be set to the
> HDM count retrieved from the DVSEC cap register.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
Actually one bit that should be in here ended up in next patch,
where it should only move not be introduced.

Fix that up for v3 and feel free to keep the RB.

>  /**
>   * devm_cxl_setup_hdm - map HDM decoder component registers
>   * @port: cxl_port to map
>   */
> -struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port)
> +struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
> +				   struct cxl_endpoint_dvsec_info *info)
Docs update in wrong patch.

>  {
