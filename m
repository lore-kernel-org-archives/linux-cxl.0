Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FEFC77B7E
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Jun 2023 12:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbjFAMto (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 1 Jun 2023 08:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbjFAMtn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 1 Jun 2023 08:49:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB93124;
        Thu,  1 Jun 2023 05:49:40 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QX5Ws6rXLz67g6l;
        Thu,  1 Jun 2023 20:47:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 1 Jun
 2023 13:49:37 +0100
Date:   Thu, 1 Jun 2023 13:49:37 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <terry.bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v4 08/23] cxl/regs: Remove early capability checks in
 Component Register setup
Message-ID: <20230601134937.00005bf8@Huawei.com>
In-Reply-To: <20230523232214.55282-9-terry.bowman@amd.com>
References: <20230523232214.55282-1-terry.bowman@amd.com>
        <20230523232214.55282-9-terry.bowman@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 23 May 2023 18:21:59 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Robert Richter <rrichter@amd.com>
> 
> When probing the Component Registers in function cxl_probe_regs()
> there are also checks for the existence of the HDM and RAS
> capabilities. The checks may fail for components that do not implement
> the HDM capability causing the Component Registers setup to fail too.
> 
> Remove the checks for a generalized use of cxl_probe_regs() and check
> them directly before mapping the RAS or HDM capabilities. This allows
> it to setup other Component Registers esp. of an RCH Downstream Port,
> which will be implemented in a follow-on patch.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
