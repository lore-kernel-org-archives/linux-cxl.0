Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDD7C7EE29
	for <linux-cxl@archiver.kernel.org>; Fri,  2 Jun 2023 12:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbjFBMgv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 2 Jun 2023 08:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbjFBMgu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 2 Jun 2023 08:36:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B0118C;
        Fri,  2 Jun 2023 05:36:48 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QXjB329yCz67J0f;
        Fri,  2 Jun 2023 20:34:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 2 Jun
 2023 13:36:46 +0100
Date:   Fri, 2 Jun 2023 13:36:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <lukas@wunner.de>
Subject: Re: [PATCH v3 2/4] lib/firmware_table: tables: Add CDAT table
 parsing support
Message-ID: <20230602133645.000036db@Huawei.com>
In-Reply-To: <168565511896.1098279.8010082917678621299.stgit@djiang5-mobl3>
References: <168565502116.1098279.131831312990693128.stgit@djiang5-mobl3>
        <168565511896.1098279.8010082917678621299.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 01 Jun 2023 14:31:58 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The CDAT table is very similar to ACPI tables when it comes to sub-table
> and entry structures. The helper functions can be also used to parse the
> CDAT table. Add support to the helper functions to deal with an external
> CDAT table, and also handle the endieness since CDAT can be processed by a
> BE host. Export a function cdat_table_parse() for CXL driver to parse
> a CDAT table.
> 
> In order to minimize ACPICA code changes, __force is being utilized to deal
> with the case of a big endian (BE) host parsing a CDAT. All CDAT data
> structure variables are being force casted to __leX as appropriate.
> 
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
>
LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


