Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9D8C7EE23
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Jun 2023 13:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbjFANmX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 1 Jun 2023 09:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbjFANmV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 1 Jun 2023 09:42:21 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE488107;
        Thu,  1 Jun 2023 06:42:20 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QX6hf3MPtz67fpR;
        Thu,  1 Jun 2023 21:40:34 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 1 Jun
 2023 14:42:18 +0100
Date:   Thu, 1 Jun 2023 14:42:17 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <terry.bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v4 19/23] cxl/pci: Update CXL error logging to use RAS
 register address
Message-ID: <20230601144217.00005338@Huawei.com>
In-Reply-To: <20230523232214.55282-20-terry.bowman@amd.com>
References: <20230523232214.55282-1-terry.bowman@amd.com>
        <20230523232214.55282-20-terry.bowman@amd.com>
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

On Tue, 23 May 2023 18:22:10 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The CXL error handler currently only logs endpoint RAS status. The CXL
> topology includes several components providing RAS details to be logged
> during error handling.[1] Update the current handler's RAS logging to use a
> RAS register address. This will allow for adding support to log other CXL
> component's RAS details in the future.
> 
> [1] CXL3.0 Table 8-22 CXL_Capability_ID Assignment
> 
> Co-developed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
