Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA39EB64D7
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jun 2023 12:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjFWMGc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 23 Jun 2023 08:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjFWMG2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 23 Jun 2023 08:06:28 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5C319F
        for <linux-cxl@vger.kernel.org>; Fri, 23 Jun 2023 05:06:26 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QnbVc1QStz6GCgr;
        Fri, 23 Jun 2023 20:03:36 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 23 Jun
 2023 13:06:22 +0100
Date:   Fri, 23 Jun 2023 13:06:22 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, "Thomas Huth" <thuth@redhat.com>
Subject: Re: [PATCH v8 0/4] hw/cxl: Poison get, inject, clear
Message-ID: <20230623130622.00004d02@Huawei.com>
In-Reply-To: <20230623025836-mutt-send-email-mst@kernel.org>
References: <20230526170010.574-1-Jonathan.Cameron@huawei.com>
        <20230623025836-mutt-send-email-mst@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 23 Jun 2023 02:59:44 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, May 26, 2023 at 06:00:06PM +0100, Jonathan Cameron wrote:
> > v8: Formatting fixes for QMP docs from Markus Armbruster (thanks!)  
> 
> This and other patches add a bunch of over-80 chars lines.  I'm not
> going to intervene here as cxl has lots of them but maybe scan over cxl
> codebase and shorten where appropriate.
> Thanks!

Will add it to the todo list and will pay more attention to this for
future series.

Some annoyingly complex register names make it tricky but I'm sure we
can do better if not necessarily perfectly!

Jonathan

> 

