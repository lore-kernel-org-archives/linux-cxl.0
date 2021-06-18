Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FFDC48BDF
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 13:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC95613E2
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 13:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhFRNkP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Jun 2021 09:40:15 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3280 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbhFRNkP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Jun 2021 09:40:15 -0400
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G609Y4TwNz6M4k7;
        Fri, 18 Jun 2021 21:28:17 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 15:38:04 +0200
Received: from localhost (10.52.125.28) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 18 Jun
 2021 14:38:03 +0100
Date:   Fri, 18 Jun 2021 14:37:54 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/pci: Rename CXL REGLOC ID
Message-ID: <20210618143754.000001fa@Huawei.com>
In-Reply-To: <CAPcyv4jE5FPVH1+Gv+QzV2GF+piypCBvc5CTe6ZakdjXEZMCkQ@mail.gmail.com>
References: <20210618003009.956929-1-ben.widawsky@intel.com>
        <CAPcyv4jE5FPVH1+Gv+QzV2GF+piypCBvc5CTe6ZakdjXEZMCkQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.125.28]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 17 Jun 2021 17:33:52 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Thu, Jun 17, 2021 at 5:30 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > The current naming is confusing and wrong. The Register Locator is
> > identified by the DSVSEC identifier, not an offset.
> >
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>  
> 
> LGTM.
Likewise. oops ;)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
