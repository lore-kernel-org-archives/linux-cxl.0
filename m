Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0EDC7EE24
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Jun 2023 14:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237994AbjFFOde (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Jun 2023 10:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238013AbjFFOdX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Jun 2023 10:33:23 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BBF171B
        for <linux-cxl@vger.kernel.org>; Tue,  6 Jun 2023 07:33:14 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QbCZR1trpz67hv7;
        Tue,  6 Jun 2023 22:30:55 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 15:33:12 +0100
Date:   Tue, 6 Jun 2023 15:33:11 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <navneet.singh@intel.com>
Subject: Re: [PATCH 13/19] cxl/region: Factor out interleave granularity
 setup
Message-ID: <20230606153311.000037cd@Huawei.com>
In-Reply-To: <168592157031.1948938.2150827780624190474.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
        <168592157031.1948938.2150827780624190474.stgit@dwillia2-xfh.jf.intel.com>
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

On Sun, 04 Jun 2023 16:32:50 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for kernel driven region creation, factor out a common
> helper from the user-sysfs region setup for interleave_granularity.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

One trivial thing inline.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> @@ -444,16 +437,30 @@ static ssize_t interleave_granularity_store(struct device *dev,
>  	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
>  		return -EINVAL;
>  
> +	lockdep_assert_held_write(&cxl_region_rwsem);
> +	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
> +		return -EBUSY;
> +
> +	p->interleave_granularity = val;

Trivial: Blank line here would be a tiny bit nicer to read.

> +	return 0;
> +}
> +
>
