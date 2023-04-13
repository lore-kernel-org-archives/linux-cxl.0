Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A875C77B61
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Apr 2023 17:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjDMRIN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Apr 2023 13:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjDMRIM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Apr 2023 13:08:12 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DA861BE
        for <linux-cxl@vger.kernel.org>; Thu, 13 Apr 2023 10:08:01 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Py5bC3Ppyz67htw;
        Fri, 14 Apr 2023 01:06:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Apr
 2023 18:07:46 +0100
Date:   Thu, 13 Apr 2023 18:07:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alison Schofield <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v5 03/12] cxl/memdev: Warn of poison inject or clear to
 a mapped region
Message-ID: <20230413180745.0000210f@Huawei.com>
In-Reply-To: <ZDWcJcs9fu7+clzi@aschofie-mobl2>
References: <cover.1679892337.git.alison.schofield@intel.com>
        <fc7db7de4778803a3221d7fd5a203bf971fdac61.1679892337.git.alison.schofield@intel.com>
        <20230330195546.00004774@Huawei.com>
        <ZDWcJcs9fu7+clzi@aschofie-mobl2>
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


> > Also, I "think" we just know that the association has been built.
> > Injecting poison is probably still fine if the region / decoder hasn't yet
> > been committed.  
> 
> I think you are right. If we want to allow inject in the space between
> mapping and commit, then this work needs to move to the region driver,
> similar to how cxl_get_poison_by_endpoint() in the get poison list
> series works.
> 
> I'm not seeing how injecting poison in that gap, would be an important
> debug scenario. Is it?
> 

Probably not ;) Maybe a comment to say that this is being conservative by
preventing it earlier than strictly necessary.

If this merged whilst I wasn't paying attention no need to add one.
