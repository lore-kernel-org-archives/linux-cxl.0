Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892EBEB64D8
	for <linux-cxl@archiver.kernel.org>; Thu, 22 Jun 2023 09:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjFVJ5y (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 22 Jun 2023 05:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjFVJ5m (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 22 Jun 2023 05:57:42 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADBD1FFD;
        Thu, 22 Jun 2023 02:56:24 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qmwhz35WTz6J765;
        Thu, 22 Jun 2023 17:55:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Jun
 2023 10:56:17 +0100
Date:   Thu, 22 Jun 2023 10:56:16 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <terry.bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v6 06/27] cxl: Rename 'uport' to 'uport_dev'
Message-ID: <20230622105616.00004aad@Huawei.com>
In-Reply-To: <20230622035126.4130151-7-terry.bowman@amd.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
        <20230622035126.4130151-7-terry.bowman@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 21 Jun 2023 22:51:05 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Dan Williams <dan.j.williams@intel.com>
> 
> For symmetry with the recent rename of ->dport_dev for a 'struct
> cxl_dport', add the "_dev" suffix to the ->uport property of a 'struct
> cxl_port'. These devices represent the downstream-port-device and
> upstream-port-device respectively in the CXL/PCIe topology.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Make sense.
If the later patches need more review time it might still be nice
to get these renames in place in the meantime to avoid merge conflict
mess for Dan.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


