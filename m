Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB72EB64D9
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Jun 2023 08:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243640AbjFNIhI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Jun 2023 04:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjFNIhH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Jun 2023 04:37:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E9719AC
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jun 2023 01:37:04 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QgzHh3dH2z6GD22;
        Wed, 14 Jun 2023 16:34:40 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 09:37:01 +0100
Date:   Wed, 14 Jun 2023 09:36:59 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <vishal.l.verma@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/7] cxl/mbox: Add sanitation handling machinery
Message-ID: <20230614093659.00006b5c@Huawei.com>
In-Reply-To: <giuweh2q6au33ycip6wiz6lf5g4wdhoyawfqoosq3x3atitjet@gtc2a6hzp63e>
References: <20230612181038.14421-1-dave@stgolabs.net>
        <20230612181038.14421-4-dave@stgolabs.net>
        <20230613170755.000011b9@Huawei.com>
        <giuweh2q6au33ycip6wiz6lf5g4wdhoyawfqoosq3x3atitjet@gtc2a6hzp63e>
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

On Tue, 13 Jun 2023 09:28:54 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Tue, 13 Jun 2023, Jonathan Cameron wrote:
> 
> >> +		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
> >> +			if (cxlds->security.poll_tmo_secs != -1) {  
> >Should be checking your new poll boolean.  
> 
> Yes, again sorry for the oversight.

Other than that, LGTM and with the fix

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> Thanks,
> Davidlohr

