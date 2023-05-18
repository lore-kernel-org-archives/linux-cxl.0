Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832AEC77B7D
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 09:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjERJyV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 May 2023 05:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjERJyU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 18 May 2023 05:54:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1068198E
        for <linux-cxl@vger.kernel.org>; Thu, 18 May 2023 02:54:19 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QMQF52Gz4z6J7Ch;
        Thu, 18 May 2023 17:50:01 +0800 (CST)
Received: from localhost (10.126.175.163) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 18 May
 2023 10:54:17 +0100
Date:   Thu, 18 May 2023 10:54:16 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH RFC 1/5] hw/cxl: Use define for build bug detection
Message-ID: <20230518105416.000054c9@Huawei.com>
In-Reply-To: <20230517-rfc-type2-dev-v1-1-6eb2e470981b@intel.com>
References: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
        <20230517-rfc-type2-dev-v1-1-6eb2e470981b@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.175.163]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 17 May 2023 19:45:54 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> Magic numbers can be confusing.
> 
> Use the range size define for CXL.cachemem rather than a magic number.
> Update/add spec references.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

I guess we should do a scrub to move all refs to 3.0 soon
given it's horrible having a mixture of spec versions for the references.

For future specs, we should only do this when sufficient X.Y references
have started to appear - I think that's true for r3.0 now.

Jonathan

> ---
>  include/hw/cxl/cxl_component.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> index 52b6a2d67f40..bca2b756c202 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -10,7 +10,7 @@
>  #ifndef CXL_COMPONENT_H
>  #define CXL_COMPONENT_H
>  
> -/* CXL 2.0 - 8.2.4 */
> +/* CXL 3.0 - 8.2.3 */
>  #define CXL2_COMPONENT_IO_REGION_SIZE 0x1000
>  #define CXL2_COMPONENT_CM_REGION_SIZE 0x1000
>  #define CXL2_COMPONENT_BLOCK_SIZE 0x10000
> @@ -173,7 +173,9 @@ HDM_DECODER_INIT(3);
>      (CXL_IDE_REGISTERS_OFFSET + CXL_IDE_REGISTERS_SIZE)
>  #define CXL_SNOOP_REGISTERS_SIZE   0x8
>  
> -QEMU_BUILD_BUG_MSG((CXL_SNOOP_REGISTERS_OFFSET + CXL_SNOOP_REGISTERS_SIZE) >= 0x1000,
> +/* CXL 3.0 8.2.3 Table 8-21 */
> +QEMU_BUILD_BUG_MSG((CXL_SNOOP_REGISTERS_OFFSET +
> +                    CXL_SNOOP_REGISTERS_SIZE) >= CXL2_COMPONENT_CM_REGION_SIZE,
>                     "No space for registers");
>  
>  typedef struct component_registers {
> 

