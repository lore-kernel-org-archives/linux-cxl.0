Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C18BC7EE29
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Jun 2023 13:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbjFAN2m (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 1 Jun 2023 09:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbjFAN2W (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 1 Jun 2023 09:28:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F9210C2;
        Thu,  1 Jun 2023 06:28:06 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QX6QC1psxz6J74d;
        Thu,  1 Jun 2023 21:28:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 1 Jun
 2023 14:28:04 +0100
Date:   Thu, 1 Jun 2023 14:28:03 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <terry.bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v4 15/23] cxl/port: Remove Component Register base
 address from struct cxl_dport
Message-ID: <20230601142803.00000d7c@Huawei.com>
In-Reply-To: <20230523232214.55282-16-terry.bowman@amd.com>
References: <20230523232214.55282-1-terry.bowman@amd.com>
        <20230523232214.55282-16-terry.bowman@amd.com>
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

On Tue, 23 May 2023 18:22:06 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Robert Richter <rrichter@amd.com>
> 
> The Component Register base address @component_reg_phys is no longer
> used after the rework of the Component Register setup which now uses
> struct member @comp_map instead. Remove the base address.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

