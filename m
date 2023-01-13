Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18196C54EBE
	for <linux-cxl@archiver.kernel.org>; Fri, 13 Jan 2023 13:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240927AbjAMNtM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 13 Jan 2023 08:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241855AbjAMNsf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 13 Jan 2023 08:48:35 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019E3617A
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jan 2023 05:43:26 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NtjFg34SNz67g2H;
        Fri, 13 Jan 2023 21:39:35 +0800 (CST)
Received: from localhost (10.81.201.219) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 13:43:23 +0000
Date:   Fri, 13 Jan 2023 13:43:22 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v2 2/8] cxl: export cxl_dvsec_rr_decode() to cxl_port
Message-ID: <20230113134322.00003146@Huawei.com>
In-Reply-To: <167330059655.975161.1643311250590533844.stgit@djiang5-mobl3.local>
References: <167330048147.975161.8832707018372221375.stgit@djiang5-mobl3.local>
        <167330059655.975161.1643311250590533844.stgit@djiang5-mobl3.local>
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

On Mon, 09 Jan 2023 14:43:17 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Call cxl_dvsec_rr_decode() in the beginning of cxl_port_probe() and
> preserve the decoded information in a local
> 'struct cxl_endpoint_dvsec_info'. This info can be passed to various
> functions later on in order to support the HDM decoder emulation.
> The invocation of cxl_dvsec_rr_decode() in cxl_hdm_decode_init() is
> removed and a pointer to the 'struct cxl_endpoint_dvsec_info' is passed
> in.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

