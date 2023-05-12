Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FB8C77B75
	for <linux-cxl@archiver.kernel.org>; Fri, 12 May 2023 17:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbjELRCr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 May 2023 13:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237723AbjELRCi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 May 2023 13:02:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0FFE56
        for <linux-cxl@vger.kernel.org>; Fri, 12 May 2023 10:02:38 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHw631kDMz67QTT;
        Sat, 13 May 2023 01:01:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 12 May
 2023 18:02:35 +0100
Date:   Fri, 12 May 2023 18:02:35 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/7] cxl/mbox: Add sanitation handling machinery
Message-ID: <20230512180235.0000099b@Huawei.com>
In-Reply-To: <z4fp6fcfhb4kfartdsqgqr7b5gvlywq4ihoucjpmhgiy536ea5@iwezgmbqwmue>
References: <20230421092321.12741-1-dave@stgolabs.net>
        <20230421092321.12741-4-dave@stgolabs.net>
        <20230511154530.00000801@Huawei.com>
        <z4fp6fcfhb4kfartdsqgqr7b5gvlywq4ihoucjpmhgiy536ea5@iwezgmbqwmue>
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

 
> >  
> >> +		queue_delayed_work(system_wq,
> >> +				   &cxlds->sec.sanitize_dwork, tmo * HZ);
> >> +	}
> >> +	mutex_unlock(&cxlds->mbox_mutex);
> >> +}
> >> +
> >>  /**
> >>   * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
> >>   * @cxlds: The device state to communicate with.
> >> @@ -173,6 +210,16 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
> >>		return -EBUSY;
> >>	}
> >>
> >> +	/*
> >> +	 * With sanitize polling, hardware might be done and the poller still
> >> +	 * not be in sync. Ensure no new command comes in until so. Keep the
> >> +	 * hardware semantics and only allow device health status.
> >> +	 */
> >> +	if (unlikely(cxlds->sec.sanitize_tmo > 0)) {
> >> +		if (mbox_cmd->opcode != CXL_MBOX_OP_GET_HEALTH_INFO)  
> >
> >Doesn't this let the value of mbox_cmd->opcode change to HEALTH_INFO so that
> >when we get here again we could carry on without other commands though still not in
> >sync (if things are very weird).  
> 
> I don't quite follow, mbox_cmd is local to each caller. Below I touch on this.

Indeed. Comment was result of a misread.

> >
> >That's confusing.  I'd add a separate structure element for it instead with
> >appropriate naming.  
> 
> Agreed, can be nicer. Another alternative is doing away with it altogether and only
> allow sanitation if interrupts are supported/enabled. Considering the potential runtimes,
> it's not a crazy ask to the hw to at least give some notification mechanism instead
> of having sw trying to stay up to date.

Whilst I fear someone will build it, we can be mean to them and make them add the support ;)
I don't mind either way.

Jonathan

> 
> Thanks,
> Davidlohr

