Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ECCC77B6E
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Apr 2023 14:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjDNOGb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Apr 2023 10:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjDNOGa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Apr 2023 10:06:30 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA7959E5
        for <linux-cxl@vger.kernel.org>; Fri, 14 Apr 2023 07:06:04 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Pyd4B3PfDz6DF3C;
        Fri, 14 Apr 2023 21:45:14 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 14 Apr
 2023 14:49:41 +0100
Date:   Fri, 14 Apr 2023 14:49:40 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxl/mbox: Add support for background operations
Message-ID: <20230414144940.00002b3e@Huawei.com>
In-Reply-To: <20230407180512.pj2lznudcidb7f7l@offworld>
References: <20230224194443.1990440-1-dave@stgolabs.net>
        <20230224194443.1990440-2-dave@stgolabs.net>
        <20230403174730.00003920@Huawei.com>
        <20230407180512.pj2lznudcidb7f7l@offworld>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 7 Apr 2023 11:05:12 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Mon, 03 Apr 2023, Jonathan Cameron wrote:
> 
> >> @@ -350,7 +350,14 @@ static CXLRetCode cmd_infostat_bg_op_sts(struct cxl_cmd *cmd,
> >>
> >>      bg_op_status = (void *)cmd->payload;
> >>      memset(bg_op_status, 0, sizeof(*bg_op_status));
> >> -    /* No support yet for background operations so status all 0 */
> >> +    bg_op_status->status = ARRAY_FIELD_EX64(cxl_dstate->mbox_reg_state64,
> >> +                                            CXL_DEV_BG_CMD_STS, PERCENTAGE_COMP) << 1;  
> >
> >Ah. I'd forgotten I bodged this one in for the switch.  
> 
> General question, do you know the reasoning behind why this command is only listed
> for switches (while the overall vocabulary is very generic to all bg-capable commands)?
> 
> Thanks,
> Davidlohr

Maybe the thought was that there are other ways for it to be obtained from everywhere
else and duplication (with possibility of disagreement) is bad...

(feel free to ask right person in the consortium).. :)
